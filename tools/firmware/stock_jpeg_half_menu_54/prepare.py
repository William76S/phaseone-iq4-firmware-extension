#!/usr/bin/env python3
"""Verify/reuse frozen Half menu for54; no code compilation or device access."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_jpeg_half_menu_54'
BASE=ROOT/'analysis/firmware/jpeg_restart_53_inputs_final/INPUTS_CLEANUP_DRAFT.json'
BASE_SHA='8793f5ec7aaf19709506136123efaa86187fcf1ea600a19dfd5573b4909b7b26'
OLD=ROOT/'analysis/firmware/stock_jpeg_half_menu_build_02'
SOURCE_SHA='09000f23f344c4be9cb9e87b748ae21b2eba62d9e7ef6b29c603e4de85af415a'
LINK_SHA='97bc39d546d730b6d3cd1a0007e50c073921c11349c514daad6e25b0e5215b12'
NM='/Library/Developer/CommandLineTools/usr/bin/llvm-nm'
def row(p,expect=None):
 p=(ROOT/p).resolve()if not Path(p).is_absolute()else Path(p).resolve();assert p.is_relative_to(ROOT)
 b=p.read_bytes();r=dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
 if expect:assert r['sha256']==expect['sha256']and r['bytes']==expect.get('bytes',len(b)),r['path']
 return r
def emit(name,j):
 p=OUT/name;p.write_text(json.dumps(j,indent=2)+'\n');return row(p)
def main():
 assert not OUT.exists(),OUT
 sr=row(OLD/'SOURCE_SHA256.json',dict(sha256=SOURCE_SHA));lr=row(OLD/'LINK.json',dict(sha256=LINK_SHA));base=row(BASE,dict(sha256=BASE_SHA))
 source=json.loads((ROOT/sr['path']).read_text());link=json.loads((ROOT/lr['path']).read_text());spec=json.loads(BASE.read_text())
 records=source['members']+source['target_header_closure']+source['objects']+[source[k]for k in ('baseline','compiler','stock','commands','A64_proof')]
 verified={x['path']:row(x['path'],x)for x in records}
 old=link['removes_objects'][0];keep=link['reuses_objects'][0]
 assert sum(o==old for o in spec['objects'])==1 and sum(o==keep for o in spec['objects'])==1
 hooks=[h for h in spec['BL_hooks']if h['va']==0x4f0528]
 assert len(hooks)==1 and hooks[0]['target_symbol']=='iq4_stock_jpeg_menu_append_01'
 assert sum(h['target_symbol']=='iq4_stock_jpeg_policy_set_01'for h in spec['auxiliary_hooks'])==6
 assert 'iq4_stock_jpeg_policy_ctor_wrapper_01'in spec['required_functions']
 APIs=['iq4_stock_jpeg_extended_size_get_02','iq4_stock_jpeg_extended_size_set_02','iq4_stock_jpeg_quality_get_02']
 undefined=subprocess.check_output([NM,'-u',str(ROOT/link['objects'][0]['path'])],text=True)
 assert all(n in undefined for n in APIs)
 old_receipt=json.loads((OLD/'BUILD.json').read_text());assert (old_receipt['normal_cases'],old_receipt['ASan_UBSan_cases'],old_receipt['A64_wrapper_cases'])==(17,17,2)
 OUT.mkdir(parents=True)
 check=emit('GUI_INTEGRATION_CHECK.json',dict(schema='iq4_half_GUI54_source_interface_check',verified_frozen_rows=len(verified),baseline=base,
   component_LINK=lr,component_manifest=sr,remove_exact_object=old,remove_exact_hook=hooks[0],
   retain_Mode_Destination_object=keep,retain53_policy_six_sites=True,
   half_native_enum=1,independent_choice={'0':'4K','1':'50%'},quality_readonly_genuine_getter=True,
   unresolved_producer_APIs_are_required=APIs,existing_host_cases={'normal':17,'ASan_UBSan':17,'A64_wrapper':2},
   component_code_recompiled=False,producer_implementation_executed=False,camera_accessed=False,target_device_executed=False,
   implementation_join_pending=True,no_duplicate_Size_entry=True))
 manifest=emit('SOURCE_SHA256.json',dict(schema='iq4_half_GUI54_reuse_sources',members=[row(HERE/'prepare.py'),row(HERE/'README.md'),sr,lr,row(OLD/'BUILD.json'),source['A64_proof'],check],
   target_header_closure=source['target_header_closure'],objects=link['objects'],reuses_objects=[keep],removes_objects=[old],baseline=base,
   frozen_payload_unchanged=True,camera_accessed=False))
 link.update(schema='iq4_stock_half_menu_link_54',source_manifest=manifest['path'],source_manifest_sha256=manifest['sha256'],
   source_manifests=[sr],receipts=[check,base,lr],requires_real_54_producer=True,requires_real_53_producer=False,
   target_release='6.03.54',retains53_mode_policy=True,quality_getter_API='iq4_stock_jpeg_quality_get_02')
 final=emit('GUI_LINK.json',link)
 print(json.dumps(dict(link=final,manifest=manifest,check=check)))
if __name__=='__main__':main()
