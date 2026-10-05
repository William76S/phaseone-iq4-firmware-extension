#!/usr/bin/env python3
"""Independent finite User byte/call/init/import inspection, never execute ELF."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3]
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 p=argparse.ArgumentParser();p.add_argument('--build',type=Path,required=True);a=p.parse_args();directory=a.build.resolve();report=json.loads((directory/'LINK_REPORT.json').read_text());build=json.loads((directory/'BUILD.json').read_text());user=ROOT/build['User']['path'];data=user.read_bytes();original=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
 assert len(data)==build['User']['bytes'] and sha(data)==build['User']['sha256']==report['candidate_sha256'];assert sha(original)==report['baseline_sha256']
 backend=ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py';assert sha(backend.read_bytes())=='3c6b4ccaafa1a524f39bac98f91058791526cef0289dd33b89967dd3f50d3fd9';spec=importlib.util.spec_from_file_location('root_inspect_frozen',backend);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m);e=m.Elf(data,2);old=m.Elf(original,2)
 allowed=report['allowed_original_spans'];changed=0
 for i,(x,y)in enumerate(zip(original,data)):
  if x!=y:assert any(start<=i<start+n for start,n,_ in allowed),i;changed+=1
 expected={0x51ddcc:'iq4_f1_lv_draw_wrapper_16',0x4eea58:'iq4_extensions_lv_menu_wrapper_01',0x4fb454:'iq4_f4_menu_native_pop_wrapper_03'}
 assert len(report['hooks'])==3 and {h['va']:h['symbol']for h in report['hooks']}==expected
 for h in report['hooks']:
  before=original[old.va_offset(h['va'],4):old.va_offset(h['va'],4)+4];b=data[e.va_offset(h['va'],4):e.va_offset(h['va'],4)+4];w=struct.unpack('<I',b)[0];imm=w&0x3ffffff;imm-=1<<26 if imm&(1<<25)else 0
  assert w>>26==0x25 and h['va']+imm*4==h['new_target']==report['own_symbols'][h['symbol']] and before.hex()==h['old_bytes']
 assert data[e.va_offset(0x4ee780,4):e.va_offset(0x4ee780,4)+4]==original[old.va_offset(0x4ee780,4):old.va_offset(0x4ee780,4)+4]
 assert report['original_init_entries_preserved']==340 and report['new_init_entries']==1 and report['actual_CSU_startup']['count']==341 and report['original_EH_entries_preserved']==32455
 assert report['new_dynamic_import']is None
 for proof in report['original_import_bindings'].values():
  b=bytes.fromhex(proof['proof_bytes']);va=proof['proof_va'];assert data[e.va_offset(va,len(b)):e.va_offset(va,len(b))+len(b)]==b
 def function_text(name,next_name=None):
  va=report['own_symbols'][name];higher=[v for v in report['own_symbols'].values()if v>va];end=min(higher)if higher else va+256
  q=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={va}',f'--stop-address={end}',str(user)],capture_output=True,text=True);assert q.returncode==0
  path=directory/(name+'.asm');path.write_text('\n'.join(s.rstrip()for s in q.stdout.splitlines())+'\n');return q.stdout,va,end
 text,va,end=function_text('iq4_extensions_lv_menu_wrapper_01');words=[struct.unpack('<I',data[e.va_offset(at,4):e.va_offset(at,4)+4])[0]for at in range(va,end,4)]
 calls=[];tails=[]
 for at,w in zip(range(va,end,4),words):
  if w>>26 in (0x25,0x5):
   imm=w&0x3ffffff;imm-=1<<26 if imm&(1<<25)else 0;(calls if w>>26==0x25 else tails).append(at+imm*4)
 assert calls==[report['own_symbols']['iq4_f1_before_native_menu_04'],report['own_symbols']['iq4_f4_native_menu_entry_02']] and tails==[0x4fb364]
 function_text('iq4_f4_menu_native_pop_wrapper_03')
 result=dict(schema='iq4_F1_F4_User_root_finite_inspection_01',User=build['User'],changed_original_bytes=changed,finite_original_mutations_verified=True,actual_single_LV_menu_wrapper_calls_and_stock_tail_verified=True,grid_entry_unchanged=True,original_init_entries=340,actual_CSU_entries=341,original_EH_entries=32455,own_EH_entries=report['own_EH_entries'],original_imports_verified=len(report['original_import_bindings']),new_dynamic_imports=0,F3_JPEG_feature_present=False,source_channel_admission_revision_pending=not build.get('canonical_RGB_source_guard_linked',False),target_executed=False,camera_accessed=False,in_camera_accepted=False)
 out=directory/'ROOT_INSPECTION.json';assert not out.exists();out.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
if __name__=='__main__':main()
