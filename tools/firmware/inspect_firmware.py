#!/usr/bin/env python3
"""Read-only, hash-bound extraction and inventory of the supplied IQ4 ZIP container."""
from pathlib import Path
import argparse, hashlib, json, struct, zipfile, zlib
EXPECTED_SHA256="a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300"
def sha(p):
    h=hashlib.sha256()
    with p.open("rb") as f:
        for b in iter(lambda:f.read(1024*1024),b""): h.update(b)
    return h.hexdigest()
def elf_metadata(b):
    if not b.startswith(b"\x7fELF"): return None
    cls,enc=b[4],b[5]
    if cls!=2 or enc!=1: return {"class":cls,"encoding":enc}
    v=struct.unpack_from("<HHIQQQIHHHHHH",b,16)
    out=dict(zip(("type","machine","version","entry","program_header_offset","section_header_offset","flags","elf_header_size","program_header_entry_size","program_header_count","section_header_entry_size","section_header_count","section_name_index"),v))
    out.update({"class":64,"encoding":"little","program_headers":[]})
    for i in range(out["program_header_count"]):
        p=struct.unpack_from("<IIQQQQQQ",b,out["program_header_offset"]+i*out["program_header_entry_size"])
        out["program_headers"].append(dict(zip(("type","flags","offset","vaddr","paddr","filesz","memsz","align"),p)))
    sh=[]
    for i in range(out["section_header_count"]):
        x=struct.unpack_from("<IIQQQQIIQQ",b,out["section_header_offset"]+i*out["section_header_entry_size"])
        sh.append(dict(zip(("name_offset","type","flags","addr","offset","size","link","info","align","entry_size"),x)))
    names=sh[out["section_name_index"]]; ns=b[names["offset"]:names["offset"]+names["size"]]
    for x in sh:
        o=x.pop("name_offset"); x["name"]=ns[o:ns.find(b"\0",o)].decode("ascii",errors="replace")
    out["sections"]=sh
    return out

def main():
    ap=argparse.ArgumentParser(); ap.add_argument("source",type=Path); ap.add_argument("--out",type=Path,required=True); a=ap.parse_args()
    digest=sha(a.source)
    if digest!=EXPECTED_SHA256: raise SystemExit("Refusing unknown firmware SHA-256: "+digest)
    a.out.mkdir(parents=True,exist_ok=True); ext=a.out/"extracted"; ext.mkdir(exist_ok=True)
    manifest={"source":str(a.source.resolve()),"sha256":digest,"size":a.source.stat().st_size,"evidence_level":"static_analysis","zip_crc_validation":"passed", "cryptographic_signature_validation":"not established", "entries":[]}
    with a.source.open("rb") as source,zipfile.ZipFile(a.source) as z:
        bad=z.testzip()
        if bad: raise SystemExit("ZIP CRC failure: "+bad)
        for info in z.infolist():
            p=Path(info.filename)
            if p.is_absolute() or len(p.parts)!=1 or ".." in p.parts: raise SystemExit("Unsafe member path")
            source.seek(info.header_offset); lh=source.read(30)
            _,_,flags,method,_,_,crc,csize,size,nlen,xlen=struct.unpack("<IHHHHHIIIHH",lh)
            data_offset=info.header_offset+30+nlen+xlen
            b=z.read(info); target=ext/p
            if target.exists() and target.read_bytes()!=b: raise SystemExit("Refusing changed extraction file: "+str(target))
            if not target.exists(): target.write_bytes(b); target.chmod(0o444)
            entry={"name":info.filename,"size":len(b),"sha256":hashlib.sha256(b).hexdigest(),"crc32":f"{zlib.crc32(b):08x}","compression_method":method,"compressed_size":csize,"zip_flags":flags,"local_header_offset":info.header_offset,"compressed_data_offset":data_offset,"elf":elf_metadata(b)}
            manifest["entries"].append(entry)
    (a.out/"inventory.json").write_text(json.dumps(manifest,indent=2)+"\n")
    (a.out/"SHA256SUMS.extracted.txt").write_text("".join(e["sha256"]+"  extracted/"+e["name"]+"\n" for e in manifest["entries"]))
    print(json.dumps({"sha256":digest,"entries":len(manifest["entries"]),"out":str(a.out)},indent=2))
if __name__=="__main__": main()
