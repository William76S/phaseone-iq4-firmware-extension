#!/usr/bin/env python3
"""Inspect actual linked own CIE/FDE, LSDA actions and landing pads; never execute ELF."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,struct,sys
ROOT=Path(__file__).resolve().parents[3]
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);a=ap.parse_args();directory=a.build.resolve();report=json.loads((directory/'LINK_REPORT.json').read_text());build=json.loads((directory/'BUILD.json').read_text());user=ROOT/build['User']['path'];data=user.read_bytes();assert hashlib.sha256(data).hexdigest()==report['candidate_sha256']==build['User']['sha256']
 backend=ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py';assert hashlib.sha256(backend.read_bytes()).hexdigest()=='3c6b4ccaafa1a524f39bac98f91058791526cef0289dd33b89967dd3f50d3fd9';spec=importlib.util.spec_from_file_location('linked_unwind_backend',backend);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m);e=m.Elf(data,2)
 def read(va,n):return data[e.va_offset(va,n):e.va_offset(va,n)+n]
 def section(va):
  found=[(i,h)for i,h in enumerate(e.sh)if h[2]&2 and h[3]<=va<h[3]+h[5]];assert len(found)==1,hex(va);return found[0]
 def pointer(blob,p,enc,va,base=0,range_only=False):
  start=p;v,p=m.encoded(blob,p,enc,va,base,range_only);raw0=blob[start:p]==bytes(p-start)
  if raw0 and not range_only:v=0
  if enc&128 and v:v=struct.unpack('<Q',read(v,8))[0]
  return v,p
 def cfi(blob,p,end,pc,limit,align,initial):
  state=dict(initial);saved=[];ops=0
  while p<end:
   op=blob[p];p+=1;ops+=1;hi=op>>6
   if hi==1:pc+=(op&63)*align
   elif hi==2:_,p=m.uleb(blob,p)
   elif hi==3:pass
   elif op==0:pass
   elif op in (2,3,4):n={2:1,3:2,4:4}[op];pc+=int.from_bytes(blob[p:p+n],'little')*align;p+=n
   elif op in (5,6,7,8,9,12,13,14,17,18,19,20,21):
    v,p=m.uleb(blob,p)
    if op in (5,9,12,20):w,p=m.uleb(blob,p)
    elif op in (17,18,19,21):w,p=m.sleb(blob,p)
    if op in (12,18):assert v in (29,31);state['cfa_register']=v;state['cfa_offset']=w
    elif op==13:assert v in (29,31);state['cfa_register']=v
    elif op==14:state['cfa_offset']=v
    elif op==19:state['cfa_offset']=w
   elif op==10:saved.append(dict(state))
   elif op==11:assert saved;state=saved.pop()
   elif op==0x2e:_,p=m.uleb(blob,p)
   else:raise AssertionError(('unproved own CFI opcode',hex(op),p-1))
   assert p<=end and pc<=limit and state.get('cfa_register',31)in(29,31)
  assert not saved;return ops,state
 def lsda(va,pc,length):
  idx,h=section(va);assert '.gcc_except_table'in e.names[idx];blob=e.section_bytes(idx);start=va-h[3];p=start;lpenc=blob[p];p+=1;lpbase=pc
  if lpenc!=255:lpbase,p=pointer(blob,p,lpenc,h[3])
  tenc=blob[p];p+=1;ttend=None
  if tenc!=255:offset,p=m.uleb(blob,p);ttend=p+offset;assert ttend<=len(blob)
  callenc=blob[p];p+=1;size,p=m.uleb(blob,p);callend=p+size;assert callend<=len(blob);calls=[]
  while p<callend:
   begin,p=pointer(blob,p,callenc,h[3],range_only=True);span,p=pointer(blob,p,callenc,h[3],range_only=True);landing,p=pointer(blob,p,callenc,h[3],range_only=True);action,p=m.uleb(blob,p)
   assert begin+span<=length and (not landing or pc<=lpbase+landing<pc+length);calls.append(dict(start=pc+begin,bytes=span,landing_pad=lpbase+landing if landing else None,action=action))
  assert p==callend;actions=[]
  for call in calls:
   at=callend+call['action']-1 if call['action']else None;seen=set()
   while at is not None:
    assert at not in seen and 0<=at<len(blob) and len(seen)<64;seen.add(at);filter_,q=m.sleb(blob,at);disp_at=q;displacement,q=m.sleb(blob,q);assert filter_>=0,'negative exception-spec filter needs separate proof'
    typ=None
    if filter_:
     assert ttend is not None;fmt=tenc&15;assert fmt in(0,2,3,4,10,11,12);width={0:8,2:2,3:4,4:8,10:2,11:4,12:8}[fmt];tp=ttend-filter_*width;assert callend<=tp<ttend;typ,_=pointer(blob,tp,tenc,h[3]);assert not typ or section(typ)[1][2]&2
    actions.append(dict(address=h[3]+at,filter=filter_,type_pointer=typ));at=disp_at+displacement if displacement else None
  return dict(address=va,section=e.names[idx],call_sites=calls,actions=actions)
 entries=[];cies=[];cie_map={};cfi_count=0
 for idx,h in enumerate(e.sh):
  if not(e.names[idx].startswith('.f1.')and e.names[idx].endswith('.eh_frame')):continue
  blob=e.section_bytes(idx);at=0
  while at<len(blob):
   size=int.from_bytes(blob[at:at+4],'little')
   if not size:assert not any(blob[at:]);break
   assert size!=0xffffffff and size>=4;end=at+size+4;assert end<=len(blob);ident=int.from_bytes(blob[at+4:at+8],'little');p=at+8
   if not ident:
    version=blob[p];p+=1;assert version in(1,3);z=blob.index(0,p,end);aug=blob[p:z].decode();p=z+1;align,p=m.uleb(blob,p);data_align,p=m.sleb(blob,p)
    if version==1:ra=blob[p];p+=1
    else:ra,p=m.uleb(blob,p)
    assert ra==30 and align==1 and data_align==-4;enc=0;lsenc=255;personality=None
    if aug:
     assert aug.startswith('z');alen,p=m.uleb(blob,p);ae=p+alen
     for ch in aug[1:]:
      if ch in('R','L'):v=blob[p];p+=1;enc=v if ch=='R'else enc;lsenc=v if ch=='L'else lsenc
      elif ch=='P':v=blob[p];p+=1;personality,p=pointer(blob,p,v,h[3]);assert personality==0x40a640
      elif ch=='S':pass
      else:raise AssertionError(ch)
     assert p==ae
    ops,initial=cfi(blob,p,end,0,0,align,{'cfa_register':31,'cfa_offset':0});cfi_count+=ops;cie_map[at]=dict(aug=aug,encoding=enc,lsda_encoding=lsenc,personality=personality,align=align,initial=initial);cies.append(dict(address=h[3]+at,personality=personality,return_register=ra))
   else:
    c=cie_map[at+4-ident];pc,p=pointer(blob,p,c['encoding'],h[3]);length,p=pointer(blob,p,c['encoding']&15,h[3],range_only=True);assert length>0 and section(pc)[1][2]&4 and section(pc+length-1)[1][2]&4;lv=None
    if c['aug']:
     alen,p=m.uleb(blob,p);ae=p+alen
     if c['lsda_encoding']!=255:lv,p=pointer(blob,p,c['lsda_encoding'],h[3])
     assert p==ae
    ops,_=cfi(blob,p,end,pc,pc+length,c['align'],c['initial']);cfi_count+=ops;entries.append(dict(pc=pc,bytes=length,fde=h[3]+at,personality=c['personality'],lsda=lsda(lv,pc,length)if lv else None))
   at=end
  cie_map.clear()
 assert len(entries)==report['own_EH_entries'] and sorted((r['pc'],r['fde'])for r in entries)==sorted(map(tuple,report['own_fde_pairs']))
 for name in ['__gxx_personality_v0','__cxa_begin_catch','__cxa_end_catch']:
  assert name in report['original_import_bindings'];proof=report['original_import_bindings'][name];assert read(proof['proof_va'],len(bytes.fromhex(proof['proof_bytes'])))==bytes.fromhex(proof['proof_bytes'])
 result=dict(schema='iq4_exact_linked_ELF_own_unwind_static_01',User=build['User'],verification_kind='exact-linked-ELF-static',own_CIEs=cies,own_FDEs=entries,own_CFI_operations=cfi_count,all_own_FDE_PC_ranges_and_EH_header_pairs_verified=True,all_own_LSDA_actions_and_landing_pads_verified=True,original_personality_PLT=0x40a640,cpp_unwind_target_accepted=False,target_executed=False,camera_accessed=False)
 out=directory/'LINKED_UNWIND_STATIC.json';assert not out.exists();out.write_text(json.dumps(result,indent=2)+'\n');print(len(entries),'own FDEs,',sum(r['lsda']is not None for r in entries),'LSDAs;',cfi_count,'CFI operations; static only PASS')
if __name__=='__main__':main()
