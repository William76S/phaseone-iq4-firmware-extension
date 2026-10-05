#!/usr/bin/env python3
"""Independent finite actual-User inspection; no target or safety assertion."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,struct,sys
ROOT=Path(__file__).resolve().parents[3]
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);ap.add_argument('--report-name',default='ROOT_INSPECTION.json');a=ap.parse_args();out=a.build.resolve()
 assert Path(a.report_name).name==a.report_name and a.report_name.endswith('.json')
 report_name=a.report_name
 j=json.loads((out/'BUILD.json').read_text());r=json.loads((out/'LINK_REPORT.json').read_text());data=(ROOT/j['User']['path']).read_bytes()
 assert sha(data)==j['User']['sha256']==r['candidate_sha256']and len(data)==r['candidate_bytes']
 backend=ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py';assert sha(backend.read_bytes())=='05c7bb3eabcd471d7ef2fbe8a53c014abcc62e212a9234810521e0ec91557b6d'
 s=importlib.util.spec_from_file_location('full_native_independent_inspector',backend);m=importlib.util.module_from_spec(s);sys.modules[s.name]=m;s.loader.exec_module(m)
 old=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes();assert sha(old)==r['baseline_sha256']
 stock=m.original_contract(old);e=m.Elf(data,2);changed=[]
 for i,(x,y)in enumerate(zip(old,data)):
  if x!=y:
   assert any(start<=i<start+n for start,n,_ in r['allowed_original_spans']),i;changed.append(i)
 for o in r['objects']:
  b=(ROOT/o['label']).read_bytes();assert len(b)==o['bytes']and sha(b)==o['sha256'],o['label']
 spec=json.loads((ROOT/j['spec']['path']).read_text());assert sha((ROOT/j['spec']['path']).read_bytes())==j['spec']['sha256']
 hooks=r['hooks']+r['auxiliary_hooks'];count=spec['expected_hook_count'];assert len(hooks)==count and len({h['va']for h in hooks})==count
 expected={h['va']:h for h in spec['BL_hooks']+spec['auxiliary_hooks']}
 assert {h['va']for h in hooks}==set(expected)
 checks=[];fdepcs={p for p,_ in r['own_fde_pairs']}
 for h in hooks:
  va=h['va'];wanted=expected[va]
  assert h['symbol']==wanted['target_symbol'] and h['old_bytes']==wanted['old_hex']
  assert h.get('branch_kind','BL')==wanted.get('branch_kind','BL')
  if 'original_target'in wanted:assert h['old_target']==wanted['original_target']
  a=e.va_offset(va,4);b=stock.va_offset(va,4);word=int.from_bytes(data[a:a+4],'little')
  assert old[b:b+4].hex()==h['old_bytes'] and data[a:a+4].hex()==h['new_bytes']
  kind=h.get('branch_kind','BL');assert word&0xfc000000==(0x14000000 if kind=='B'else 0x94000000)
  imm=word&0x3ffffff;imm=imm-(1<<26)if imm&(1<<25)else imm;target=va+imm*4
  assert target==h['new_target']==r['own_symbols'][h['symbol']]and target in fdepcs
  if 'old_target'in h:
   original_word=int.from_bytes(old[b:b+4],'little');imm=original_word&0x3ffffff
   imm=imm-(1<<26)if imm&(1<<25)else imm
   assert original_word>>26==0x25 and va+imm*4==h['old_target']
  assert any(p[0]==1 and p[1]&1 and not p[1]&2 and p[3]<=target<p[3]+p[5]for p in e.ph)
  checks.append(dict(va=va,kind=kind,target=target,symbol=h['symbol']))
 oldinit=stock.section_bytes(stock.index('.init_array'));idx=e.index('.f1.init_array');newinit=e.section_bytes(idx)
 assert newinit[:len(oldinit)]==oldinit and len(oldinit)==340*8 and len(newinit)==341*8
 assert struct.unpack('<Q',newinit[-8:])[0]==r['initializer_va']==r['own_symbols']['iq4_extensions_initialize_01']
 assert m.verify_csu_startup(e,e.sh[idx][3],newinit)['count']==341
 assert r['original_EH_entries_preserved']==32455 and r['new_init_entries']==1
 assert r['new_dynamic_import']['name']=='_ZSt9terminatev' and not r['new_dynamic_import']['added_DT_NEEDED']
 assert r['new_dynamic_import']['original_dynsym_indices_preserved']==545 and r['new_dynamic_import']['original_general_RELA_bytes_preserved']==960
 assert not any(p[0]==1 and p[1]&3==3 for p in e.ph)
 assert data[e.va_offset(0x4ee780,4):e.va_offset(0x4ee780,4)+4]==old[stock.va_offset(0x4ee780,4):stock.va_offset(0x4ee780,4)+4], 'Grid submenu entry changed'
 # Inspect the real linked wrapper argument immediately before the recording
 # entry call. This is the boot default; the existing card selector stays live.
 wrapper=r['own_symbols']['iq4_extensions_lv_menu_wrapper_01']
 entry=r['own_symbols']['iq4_f4_native_menu_entry_02'];default_sites=[]
 for at in range(wrapper,wrapper+0xc0,4):
  off=e.va_offset(at,4);word=int.from_bytes(data[off:off+4],'little')
  if word>>26!=0x25:continue
  imm=word&0x3ffffff;imm=imm-(1<<26)if imm&(1<<25)else imm
  if at+imm*4==entry:
   prev=e.va_offset(at-4,4);assert int.from_bytes(data[prev:prev+4],'little')==0x52800163
   default_sites.append(at)
 assert len(default_sites)==1 and spec['recording_default_fs_id']==11
 result=dict(schema='iq4_actual_F1_F3_F4_User_independent_inspection_01',User=j['User'],actual_objects_verified=len(r['objects']),actual_hook_destinations=checks,
  recording_default_fs_id=11,recording_default_argument_verified_at=default_sites[0],modified_original_byte_count=len(changed),original_changes_all_finite_allowed=True,original340_init_preserved=True,actual341_initializer_bound=True,
  original_EH_entries_preserved=32455,original_Grid_unchanged=True,no_RWX=True,new_import_only_existing_libstdcxx_terminate=True,
  linked_contract_sealed=j.get('linked_contract_sealed',False),target_executed=False,camera_accessed=False,full_RAW_render_accepted=False,recording_accepted=False,persistent_recovery_verified=False)
 p=out/report_name;assert not p.exists();p.write_text(json.dumps(result,indent=2)+'\n');print(len(checks),'actual branches;',len(r['objects']),'exact objects; finite inspection PASS; no target acceptance')
if __name__=='__main__':main()
