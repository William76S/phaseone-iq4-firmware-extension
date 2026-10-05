#!/usr/bin/env python3
"""Exact finite native RTTI loader graph. Does not load or execute a library."""
from pathlib import Path
import sys,json,hashlib,struct
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/native_copy_rtti_static_01'
sys.path.insert(0,str(ROOT/'tools/firmware/f1_user_elf_append_02'))
from elf_append import Elf,RELA,cstring
LIB=ROOT/'analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
L_SHA='5876c5861ffae1b3f6a5fc091be8f1d601edf602ebeed6a4aa3bf5c3cfbe11aa';U_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 lb=LIB.read_bytes();ub=USER.read_bytes();assert len(lb)==1538432 and sha(lb)==L_SHA and sha(ub)==U_SHA
 le=Elf(lb,3);ue=Elf(ub,2);assert max(p[7]for p in le.ph if p[0]==1)==65536;ls=le.symbols(le.index('.dynsym'));us=ue.symbols(ue.index('.dynsym'))
 lm={s[6]:(i,s)for i,s in enumerate(ls)if s[6]};um={s[6]:(i,s)for i,s in enumerate(us)if s[6]and s[3]}
 version_requirements={};needsec=ue.section_bytes(ue.index('.gnu.version_r'));strings=ue.section_bytes(ue.index('.dynstr'));at=0
 for _ in range(ue.sh[ue.index('.gnu.version_r')][7]):
  ver,count,filename,aux,nxt=struct.unpack_from('<HHIII',needsec,at);assert ver==1
  pos=at+aux
  for _ in range(count):
   h,flags,other,name,following=struct.unpack_from('<IHHII',needsec,pos);version_requirements[other&0x7fff]=(cstring(strings,filename),cstring(strings,name),flags,h);pos+=following
  if not nxt:break
  at+=nxt
 lr=[(n,RELA.unpack_from(le.section_bytes(le.index('.rela.dyn')),n*24))for n in range(le.sh[le.index('.rela.dyn')][5]//24)]
 ur=[(n,RELA.unpack_from(ue.section_bytes(ue.index('.rela.dyn')),n*24))for n in range(ue.sh[ue.index('.rela.dyn')][5]//24)]
 roots=['_ZTVN10__cxxabiv117__class_type_infoE','_ZTIi'];queue=list(roots);visited=set();spans=[];copy=[]
 while queue:
  name=queue.pop(0)
  if name in visited:continue
  visited.add(name);assert len(visited)<=64
  idx,s=lm[name];assert s[3]and (s[1]&15)in(1,2)and 0<s[5]<=4096,name
  raw=le.data[le.va_offset(s[4],s[5]):le.va_offset(s[4],s[5])+s[5]]
  mode=1;address=s[4]
  if name in um:
   ui,uss=um[name];matches=[(n,x)for n,x in ur if x[0]==uss[4]and(x[1]&0xffffffff)==1024 and x[1]>>32==ui]
   assert len(matches)==1 and uss[5]==s[5],name;mode=0;address=uss[4];n,x=matches[0]
   version=ue.section_bytes(ue.index('.gnu.version'))[ui*2:ui*2+2]
   vi=struct.unpack('<H',version)[0]&0x7fff;needlib,needversion,flags,vhash=version_requirements[vi];assert (needlib,needversion,flags)==('libstdc++.so.6','CXXABI_1.3',0)
   copy.append(dict(symbol=name,va=address,bytes=s[5],dynsym_index=ui,version_index=vi,needed_library=needlib,version_name=needversion,version_flags=flags,version_hash=vhash,copy_relocation_index=n,copy_relocation_record_hex=RELA.pack(*x).hex(),original_file_all_zero=not any(ue.data[ue.va_offset(address,s[5]):ue.va_offset(address,s[5])+s[5]])))
  rel=[]
  for n,(at,info,add)in lr:
   if s[4]<=at<s[4]+s[5]:
    assert at+8<=s[4]+s[5]and at%8==0 and(info&0xffffffff)==257,(name,at)
    ri=info>>32;target=ls[ri];assert target[3]and target[6],target
    target_mode=0 if target[6]in um else 1;target_address=um[target[6]][1][4]if target_mode==0 else target[4]
    rel.append(dict(offset=at-s[4],target_symbol=target[6],target_mode=target_mode,target_address=target_address,addend=add,library_relocation_index=n,library_relocation_hex=RELA.pack(at,info,add).hex()))
    queue.append(target[6])
  if(s[1]&15)==2:assert not rel,name
  spans.append(dict(symbol=name,lib_dynsym_index=idx,mode=mode,address=address,library_va=s[4],bytes=s[5],kind='function'if(s[1]&15)==2 else'object',raw_hex=raw.hex(),sha256=sha(raw),relocations=rel))
 anchor=lm['_ZN10__cxxabiv117__class_type_infoD1Ev'][1];assert anchor[4]==0x8ee38
 immutable=[]
 for e,mode,names in[(le,1,['.dynsym','.dynstr','.gnu.version','.gnu.version_d','.rela.dyn']),(ue,0,['.dynsym','.dynstr','.gnu.version','.gnu.version_r','.rela.dyn'])]:
  for name in names:
   i=e.index(name);section=e.sh[i]
   if name=='.rela.dyn' and e is le:continue # graph records captured above; not all library relocations are needed
   # Original User COPY metadata must stay exact in current ELF; appended symbols
   # may grow dynsym/rela, so only copy-specific symbol/version/record entries are selected.
  if e is le:
   immutable.append(dict(mode=1,address=0,bytes=64,raw_hex=lb[:64].hex(),kind='library_elf_header'))
   phraw=lb[le.e[5]:le.e[5]+le.e[10]*le.e[9]];immutable.append(dict(mode=1,address=le.e[5],bytes=len(phraw),raw_hex=phraw.hex(),kind='library_program_headers'))
 for r in copy:
  ui=r['dynsym_index'];i=ue.index('.dynsym');s=ue.sh[i];data=ue.section_bytes(i)[ui*24:ui*24+24];immutable.append(dict(mode=0,address=s[3]+ui*24,bytes=24,raw_hex=data.hex(),kind='user_copy_dynsym',symbol=r['symbol']))
  i=ue.index('.gnu.version');s=ue.sh[i];data=ue.section_bytes(i)[ui*2:ui*2+2];immutable.append(dict(mode=0,address=s[3]+ui*2,bytes=2,raw_hex=data.hex(),kind='user_copy_version',symbol=r['symbol']))
  i=ue.index('.rela.dyn');s=ue.sh[i];n=r['copy_relocation_index'];data=ue.section_bytes(i)[n*24:n*24+24];immutable.append(dict(mode=0,address=s[3]+n*24,bytes=24,raw_hex=data.hex(),kind='user_copy_relocation',symbol=r['symbol']))
 report=dict(schema='iq4_native_copy_rtti_static_01',library=dict(path=LIB.relative_to(ROOT).as_posix(),bytes=len(lb),sha256=L_SHA),user=dict(path=USER.relative_to(ROOT).as_posix(),bytes=len(ub),sha256=U_SHA),roots=roots,base_alignment=65536,anchor=dict(user_copy_slot=0xf429d8,library_function_va=anchor[4],name='_ZN10__cxxabiv117__class_type_infoD1Ev'),COPY_dependencies=copy,spans=spans,immutable_inputs=immutable,target_executed=False,library_loaded=False)
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'GRAPH.json').write_text(json.dumps(report,indent=2)+'\n')
 def ubytes(b):return ','.join('0x'+b[i:i+2]for i in range(0,len(b),2))
 text=['#pragma once','#include <stdint.h>','#include <stddef.h>','struct Iq4RttiReloc01 {uint32_t offset,mode;uint64_t address;int64_t addend;};','struct Iq4RttiSpan01 {uint32_t mode,bytes;uint64_t address;const unsigned char*data;const Iq4RttiReloc01*relocs;uint32_t count;};']
 for n,r in enumerate(spans+immutable):
  text.append(f'static const unsigned char Data{n}[]={{'+ubytes(r['raw_hex'])+'};')
  if r.get('relocations'):
   text.append(f'static const Iq4RttiReloc01 Rel{n}[]={{'+','.join('{%d,%d,UINT64_C(%d),INT64_C(%d)}'%(q['offset'],q['target_mode'],q['target_address'],q['addend'])for q in r['relocations'])+'};')
 text.append('static const Iq4RttiSpan01 RttiSpans01[]={')
 for n,r in enumerate(spans+immutable):text.append('{%d,%d,UINT64_C(%d),Data%d,%s,%d},'%(r['mode'],r['bytes'],r['address'],n,'Rel'+str(n)if r.get('relocations')else'nullptr',len(r.get('relocations',[]))))
 text.append('};');(HERE/'rtti_pins.inc').write_text('\n'.join(text)+'\n')
 print(json.dumps(dict(spans=len(spans),immutable=len(immutable),functions=sum(s['kind']=='function'for s in spans),copy=len(copy),all_body_bytes=sum(s['bytes']for s in spans),graph_sha256=sha((OUT/'GRAPH.json').read_bytes()),target_executed=False)))
if __name__=='__main__':main()
