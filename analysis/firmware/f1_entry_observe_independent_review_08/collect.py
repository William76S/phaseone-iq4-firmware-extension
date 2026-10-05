"""Offline finite Observe08 source/ELF review. Never builds or loads target code."""
from pathlib import Path
import hashlib,json,struct
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
ENTRY=ROOT/'tools/firmware/f1_native_entry_observe_08'
BUILD=ROOT/'analysis/firmware/f1_native_entry_observe_build_08'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def elf(p):
 b=p.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',b)
 assert b[:7]==b'\x7fELF\x02\x01\x01'and h[1:3]==(3,183)and h[9]==56 and h[11]==64
 ph=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])]
 sections=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11])for i in range(h[12])]
 strings=sections[h[13]];strs=b[strings[4]:strings[4]+strings[5]]
 named={strs[s[0]:strs.index(0,s[0])].decode():s for s in sections}
 def symbols(key):
  s=named[key];st=sections[s[6]];names=b[st[4]:st[4]+st[5]];result={}
  for off in range(s[4],s[4]+s[5],s[9]):
   n,info,other,index,va,size=struct.unpack_from('<IBBHQQ',b,off)
   if n:result[names[n:names.index(0,n)].decode()]=dict(info=info,section=index,va=va,size=size)
  return result
 dyn=symbols('.dynsym');full=symbols('.symtab')if'.symtab'in named else{}
 s=named['.dynamic'];tags=[]
 for off in range(s[4],s[4]+s[5],16):
  t,v=struct.unpack_from('<qQ',b,off);tags.append((t,v))
  if t==0:break
 ds=named['.dynstr'];names=b[ds[4]:ds[4]+ds[5]];need=[names[v:names.index(0,v)].decode()for t,v in tags if t==1]
 rel={}
 if'.rela.dyn'in named:
  s=named['.rela.dyn']
  for off in range(s[4],s[4]+s[5],s[9]):
   at,info,add=struct.unpack_from('<QQq',b,off)
   if info&0xffffffff==1027:rel[at]=add
 init=named['.init_array'];init_vas=[rel.get(init[3]+off,struct.unpack_from('<Q',b,init[4]+off)[0])for off in range(0,init[5],8)]
 init_labels=[next((name for name,v in full.items()if v['va']==va),'unresolved_symbol_name')for va in init_vas]
 def span(va,n):
  candidates=[x for x in ph if x[0]==1 and x[3]<=va and va+n<=x[3]+x[5]];assert len(candidates)==1
  x=candidates[0];off=x[2]+va-x[3];return b[off:off+n]
 return b,ph,dyn,full,need,dict(tags),init_labels,span
def main():
 out=HERE/'STATIC_REVIEW.json';assert not out.exists(),'Immutable independent review is not rewritten'
 p=ENTRY/'SOURCE_SHA256.json';m=json.loads(p.read_bytes());assert sha(p)=='88000455d0116e075aa6be69476508cc3d1a4b6bb4cefa4365ba034c18652d52'
 checked=[]
 for group in('members','frozen_refs','review_artifacts'):
  for r in m[group]:
   f=ROOT/r['path'];assert f.stat().st_size==r['bytes']and sha(f)==r['sha256'],r['path'];checked.append(r)
 assert len(checked)==473
 build=json.loads((BUILD/'BUILD_PREPARATION.json').read_bytes());results={}
 for kind,row in build['outputs'].items():
  p=ROOT/row['path'];u=ROOT/row['unstripped_path'];assert sha(p)==row['sha256']and p.stat().st_size==row['bytes']and sha(u)==row['unstripped_sha256']
  b,ph,dyn,_,needed,tags,_,span=elf(p);ub,uph,udyn,full,un,utags,init,usp=elf(u);assert ph==uph and needed==un and dyn==udyn
  exports={k:v for k,v in dyn.items()if v['section']};undefined=sorted(k for k,v in dyn.items()if not v['section'])
  assert set(exports)==set(row['exports'])and undefined==sorted(row['undefined'])
  symbol=exports['iq4_f1_normal_fit_ingress_observed_08'];assert symbol['size']==496 and symbol['va']==row['publication_va']
  cover=[x for x in ph if x[0]==1 and x[1]==6 and x[3]<=symbol['va']and symbol['va']+496<=x[3]+x[5]];assert len(cover)==1
  f=exports['pthread_mutex_unlock'];body=span(f['va'],f['size']);assert body==usp(f['va'],f['size'])
  words=struct.unpack('<'+'I'*(len(body)//4),body);assert words.count(0xd63f02c0)==1
  assert words[0x58//4]==0xb9000277 and words[0x60//4]==0xd63f02c0 and words[0x68//4]==0xb9400277 and words[0x68c//4]==0xb9000277
  assert tags[30]&8 and tags[0x6ffffffb]&1
  assert not any('dispatch_scaler_return_on_ui'in k or'after_native_write_on_ui'in k or'iq4_f1_scaler_bridge_08'in k for k in full)
  results[kind]=dict(path=row['path'],bytes=len(b),sha256=sha(p),ELF_type='ET_DYN',ELF_machine='AArch64',exports=sorted(exports),undefined=undefined,DT_NEEDED=needed,bind_now=True,publication=symbol,publication_file_backed_RW_load=cover[0],publication_file_bytes_initial=span(symbol['va'],496).hex(),init_array_order=init,original_unlock=dict(va=f['va'],bytes=f['size'],linked_body_sha256=hashlib.sha256(body).hexdigest(),original_pointer_BLR_count=1,original_BLR_va=f['va']+0x60,incoming_errno_restore_va=f['va']+0x58,original_errno_save_va=f['va']+0x68,return_errno_restore_va=f['va']+0x68c),render_and_scaler_issuer_unused_bodies_absent=True)
  if kind=='authenticated_observe_only_candidate':assert len(b)==97000 and symbol['va']==287208 and len(init)==2 and'prepare'in init[0]and'role_constructor'in init[1]
 runtime=(ENTRY/'runtime_linux.cpp').read_text();old=(ROOT/'tools/firmware/f1_native_entry_binding_07/runtime_linux.cpp').read_text()
 for text in ('const int result=reinterpret_cast<int(*)(void*)>(address)(mutex); // EXACTLY ONCE, first.','errno=incoming;','errno=saved;return result;'):
  assert old.count(text)==runtime.count(text)==1
 assert runtime.count('ui08_bridge->after_original_boundary_on_ui(')==1 and'configure_on_actual_ui('not in runtime and'bind_actual_provider_before_patch_on_ui('not in runtime
 result=dict(schema='iq4_f1_observe08_independent_static_review',checked_reference_rows=473,entry_source_sha256=sha(ENTRY/'SOURCE_SHA256.json'),runtime_sha256=sha(ENTRY/'runtime_linux.cpp'),outputs=results,review_scope='linked_SO_and_runtime_source_only',actual_hardware_observed=False,SDK_or_Windows_or_network_used=False,new_or_old_build_executed=False,actual_approval_created=False,mask_paint_accepted=False,Loader08_review='pending_final_frozen_source')
 out.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({k:v for k,v in result.items()if k!='outputs'},indent=2))
if __name__=='__main__':main()
