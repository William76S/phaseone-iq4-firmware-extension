#!/usr/bin/env python3
"""Conservative static AArch64 string references; candidates require disassembly confirmation."""
import argparse,bisect,hashlib,json,re,struct
from pathlib import Path
from inspect_firmware import elf_metadata
EXPECTED='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def sx(v,n): return v-(1<<n) if v&(1<<(n-1)) else v
def main():
 a=argparse.ArgumentParser(); a.add_argument('binary',type=Path); a.add_argument('--out',type=Path,required=True); args=a.parse_args(); b=args.binary.read_bytes()
 if hashlib.sha256(b).hexdigest()!=EXPECTED: raise SystemExit('Unknown input')
 e=elf_metadata(b); sections={s['name']:s for s in e['sections']}; text=sections['.text']; ro=sections['.rodata']; eh=sections['.eh_frame_hdr']; base=text['addr']-text['offset']
 hdr=b[eh['offset']:eh['offset']+eh['size']]
 if hdr[:4]!=bytes((1,0x1b,3,0x3b)): raise SystemExit('Unsupported .eh_frame_hdr encodings')
 count=struct.unpack_from('<I',hdr,8)[0]; starts=[eh['addr']+struct.unpack_from('<i',hdr,12+8*i)[0] for i in range(count)]; starts=sorted(set(s for s in starts if text['addr']<=s<text['addr']+text['size']))
 def owner(pc):
  i=bisect.bisect_right(starts,pc)-1; return starts[i] if i>=0 else None
 pat=re.compile(r'live.?view|jpeg|\bICE\b|raw|frame.?buffer|video|overlay|firmware|signature|userhook|autostart|debug|FileManager|shell|CommandHandler|run/media|Iq[pP].*dev|coding|encoder|compress|\bUiIQ4|/p1/|/mnt/',re.I)
 strings={}
 for m in re.finditer(rb'[\x20-\x7e]{4,}',b[ro['offset']:ro['offset']+ro['size']]):
  st=m.group().decode('ascii'); off=ro['offset']+m.start()
  if pat.search(st): strings[off+base]={'file_offset':off,'linked_va':off+base,'text':st,'refs':[]}
 ins=struct.unpack('<'+str(text['size']//4)+'I',b[text['offset']:text['offset']+text['size']]); calls={}
 for i,w in enumerate(ins):
  pc=text['addr']+i*4
  if w&0xfc000000==0x94000000:
   dest=pc+(sx(w&0x3ffffff,26)<<2); calls.setdefault(owner(pc),[]).append({'pc':pc,'target':dest})
  if w&0x9f000000==0x90000000:
   rd=w&31; imm=sx(((w>>5)&0x7ffff)<<2|((w>>29)&3),21); page=(pc&~4095)+(imm<<12)
   for j in range(i+1,min(i+7,len(ins))):
    v=ins[j]
    if v&0xff800000==0x91000000 and ((v>>5)&31)==rd:
     target=page+(((v>>10)&0xfff)<<(12 if v&(1<<22) else 0))
     if target in strings: strings[target]['refs'].append({'adrp_pc':pc,'add_pc':text['addr']+j*4,'function_start_unwind':owner(pc),'method':'ADRP+ADD candidate; no control flow proof'})
     break
    if v&0x7c000000==0x14000000 or v&0xff000000==0x54000000: break
    # Any likely destination overwrite makes a non-adjacent candidate unreliable.
    if (v&31)==rd and (v&0x0a000000)!=0x08000000: break
  elif w&0x9f000000==0x10000000:
   target=pc+sx(((w>>5)&0x7ffff)<<2|((w>>29)&3),21)
   if target in strings: strings[target]['refs'].append({'adr_pc':pc,'function_start_unwind':owner(pc),'method':'ADR exact address'})
 # read-only absolute pointer references in initialized data/rodata
 for sname in ('.rodata','.data','.data.rel.ro'):
  s=sections[sname]
  for off in range((s['offset']+7)//8*8,s['offset']+s['size']-7,8):
   va=struct.unpack_from('<Q',b,off)[0]
   if va in strings: strings[va].setdefault('pointer_refs',[]).append({'section':sname,'file_offset':off,'linked_va':s['addr']+off-s['offset']})
 args.out.mkdir(parents=True,exist_ok=True)
 (args.out/'string_references.json').write_text(json.dumps({'input_sha256':EXPECTED,'evidence_level':'static_analysis','address_caution':'Linked VAs; runtime mappings not measured','strings':list(strings.values())},indent=2)+'\n')
 (args.out/'unwind_functions.json').write_text(json.dumps({'encoding':hdr[:4].hex(),'functions':starts,'calls':calls},indent=2)+'\n')
 print('anchors',len(strings),'referenced',sum(bool(s['refs']) for s in strings.values()),'unwind_functions',len(starts))
if __name__=='__main__':main()
