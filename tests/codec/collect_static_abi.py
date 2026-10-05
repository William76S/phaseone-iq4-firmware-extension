#!/usr/bin/env python3
"""Read-only exact bytes/offset/disassembly proof; never runs camera firmware."""
import hashlib,json,pathlib,struct,subprocess
root=pathlib.Path(__file__).resolve().parents[2]
source=root/"analysis/firmware/extracted/P1Linux_6.03.21.bin"
data=source.read_bytes()
expected="9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb"
if hashlib.sha256(data).hexdigest()!=expected:
    raise SystemExit("Unknown firmware module hash; static collection refused")
phoff=struct.unpack_from("<Q",data,32)[0]
phentsize,phnum=struct.unpack_from("<HH",data,54)
segments=[struct.unpack_from("<IIQQQQQQ",data,phoff+i*phentsize) for i in range(phnum)]
def offset(address):
    for kind,flags,fileoff,va,pa,filesz,memsz,align in segments:
        if kind==1 and va<=address<va+filesz:
            return fileoff+address-va
    raise ValueError("VA not in file-backed LOAD")
ranges=[("native_wrapper_abi_only",0x98d680,0x98d830),("std_error_create_compress_destroy",0x9a20f0,0x9a2250),("set_quality",0x9a2fc8,0x9a3030),("set_defaults",0x9a34b8,0x9a3600),("start_write_scanlines",0x9a39e0,0x9a3c80),("finish_compress",0x9a22f0,0x9a2538)]
output=root/"evidence/codec/static_abi"
output.mkdir(parents=True,exist_ok=True)
records=[]
for name,start,end in ranges:
    begin=offset(start);raw=data[begin:begin+end-start]
    disasm=subprocess.run(["/Library/Developer/CommandLineTools/usr/bin/llvm-objdump","-d",f"--start-address={hex(start)}",f"--stop-address={hex(end)}",str(source)],check=True,capture_output=True,text=True).stdout
    (output/(name+".disasm.txt")).write_text("INPUT_SHA256 "+expected+"\nSTATIC_ONLY_NEAREST_SYMBOL_NAMES_NOT_AUTHORITATIVE\n"+disasm)
    records.append({"name":name,"start_va":hex(start),"end_va":hex(end),"file_offset":hex(begin),"bytes_hex":raw.hex(),"sha256":hashlib.sha256(raw).hexdigest()})
report={"level":"static_analysis","module_sha256":expected,"device_actions":0,"runtime_abi_verified":False,"version_check":{"va":"0x9a214c","file_offset":hex(offset(0x9a214c)),"bytes":data[offset(0x9a214c):offset(0x9a214c)+4].hex(),"required_version":82},"size_check":{"va":"0x9a218c","file_offset":hex(offset(0x9a218c)),"bytes":data[offset(0x9a218c):offset(0x9a218c)+4].hex(),"required_compressor_bytes":584},"ranges":records}
(output/"exact_abi.json").write_text(json.dumps(report,indent=2)+"\n")
print(json.dumps({"module_sha256":expected,"static_only":True,"version":82,"compressor_bytes":584}))
