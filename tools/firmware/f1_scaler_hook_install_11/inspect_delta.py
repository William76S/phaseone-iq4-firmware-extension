"""Pure offline new11 linked-caller and one-condition delta inspection."""
from pathlib import Path
import hashlib,importlib.util,json,struct,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f1_scaler_hook_install_build_11'
def main():
 dest=OUT/'LINKED_CALLER_AND_DELTA.json';assert not dest.exists()
 spec=importlib.util.spec_from_file_location('owned_elf_reader',ROOT/'analysis/firmware/f1_entry_observe_independent_review_08/collect.py');e=importlib.util.module_from_spec(spec);spec.loader.exec_module(e)
 b,ph,d,f,n,t,init,span=e.elf(OUT/'libiq4_f1_normal_fit_hook_11_authenticated_candidate.so')
 _,sph,sd,_,sn,_,_,ss=e.elf(OUT/'libiq4_f1_normal_fit_hook_11_authenticated_candidate_load_only.so');assert sph==ph and sd==d and sn==n
 allowed=set(range(40,48))|set(range(60,64));changed=[]
 for p in ph:
  if p[0]!=1:continue
  a,z=span(p[3],p[5]),ss(p[3],p[5])
  for i,(x,y)in enumerate(zip(a,z)):
   if x!=y:assert p[2]+i in allowed;changed.append(p[2]+i)
 def one(k):
  r=[(name,v)for name,v in f.items()if k in name and v['section']];assert len(r)==1;return r[0]
 records={}
 for key in('pthread_mutex_unlock','prepare_once_at_live_ui','bind_actual_provider_before_patch_on_ui','after_original_boundary_on_ui','configure_on_actual_ui','Binding14native_current','iq4_f1_scaler_bridge_10'):
  name,v=one(key);body=span(v['va'],v['size']);ws=struct.unpack('<'+'I'*(len(body)//4),body);calls=[]
  for i,w in enumerate(ws):
   if w&0xfc000000==0x94000000:
    delta=w&0x3ffffff;delta=delta-(1<<26)if delta&(1<<25)else delta;target=v['va']+i*4+delta*4;calls.append({'at':v['va']+i*4,'target':target,'names':[z for z,q in f.items()if q['va']==target]})
  records[key]={'name':name,**v,'body_sha256':hashlib.sha256(body).hexdigest(),'direct_BL_calls':calls,'words':ws}
 u=records['pthread_mutex_unlock'];ws=u['words'];assert ws.count(0xd63f02c0)==1 and ws[0x60//4]==0xd63f02c0 and ws[0x58//4]==0xb9000277 and ws[0x68//4]==0xb9400277
 for k in('after_original_boundary_on_ui','prepare_once_at_live_ui'):assert sum(x['target']==records[k]['va']for x in u['direct_BL_calls'])==1
 pr=records['prepare_once_at_live_ui'];calls=[x for x in pr['direct_BL_calls']if x['target']==records['bind_actual_provider_before_patch_on_ui']['va']];assert len(calls)==1
 stores=[pr['va']+i*4 for i,w in enumerate(pr['words'])if w&0xfffffc00==0xc89ffc00];assert len(stores)==1 and calls[0]['at']<stores[0]
 assert [w for w in pr['words']if w in(0xd5033b9f,0xd5033fdf)]==[0xd5033b9f,0xd5033fdf]
 old='if(!b.configured_||!b.ports_.current_thread)return 0;';new='if(!b.configured_||!b.ports_.current_thread||b.status_.phase==static_cast<unsigned>(Phase::Hold)||b.status_.phase==static_cast<unsigned>(Phase::DetachedRetained))return 0;'
 a=(HERE.parent/'f1_scaler_hook_install_10/entry_binding_10.cpp').read_text();z=(HERE/'entry_binding_10.cpp').read_text();assert a.count(old)==1 and a.replace(old,new)==z
 unchanged=[]
 for name in('normal_fit.cpp','fixed_plan.cpp','provider.cpp','hook_capture.cpp','integration.cpp','prepare_linux.cpp','runtime_prepare_10.cpp','entry_bridge_10.hpp','entry_binding_10.hpp','scaler_bridge.S','normal_fit.hpp','provider.hpp','hook_capture.hpp','integration.hpp','prepare.hpp','transaction.cpp','transaction.hpp','linux_controller.cpp','layout.cpp'):
  a=(HERE.parent/'f1_scaler_hook_install_10'/name).read_bytes();z=(HERE/name).read_bytes();assert a==z,name;unchanged.append({'name':name,'sha256':hashlib.sha256(z).hexdigest()})
 old_name,old_symbol=one('Binding14native_current');del old_name
 assert old_symbol['size']>64
 for r in records.values():r.pop('words')
 proof={'schema':11,'public_ABI':10,'only_production_delta':'two Binding phases invalidate already captured Native.current','unchanged_production_sources':unchanged,'linked_functions':records,'original_unlock_BLR_count':1,'slot_release_store_at':stores[0],'configure_before_slot':True,'explicit_DSB_ISB':True,'init_array':init,'loaded_range_changes_only_ELF_section_metadata':changed,'all_other_LOAD_bytes_identical':True,'target_executed':False,'old_test_suite_rerun':False}
 dest.write_text(json.dumps(proof,indent=2)+'\n');print(json.dumps({'bytes':dest.stat().st_size,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest(),'target_executed':False}))
if __name__=='__main__':main()
