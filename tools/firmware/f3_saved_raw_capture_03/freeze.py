#!/usr/bin/env python3
from pathlib import Path
import json,hashlib,shlex,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_saved_raw_capture_build_03';STAT=ROOT/'analysis/firmware/f3_saved_raw_capture_static_03'
def row(p):
 b=p.read_bytes();return dict(path=p.relative_to(ROOT).as_posix(),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 commands=json.loads((OUT/'COMMANDS.json').read_text());assert commands and all(x['exit_code']==0 for x in commands)
 owned={p for p in HERE.iterdir()if p.is_file()and p.name not in('SOURCE_SHA256.json','LINK_INPUT.json','LINK_OVERLAY.json')}
 artifacts={p for d in (OUT,STAT)for p in d.iterdir()if p.is_file()}
 refs={ROOT/p for p in ['tools/firmware/f3_saved_raw_capture_01/SOURCE_SHA256.json','tools/firmware/f3_saved_raw_capture_01/LINK_INPUT.json','tools/firmware/f3_saved_raw_capture_02/SOURCE_SHA256.json','tools/firmware/f3_saved_raw_capture_02/LINK_INPUT.json','tools/firmware/f3_native_card_bridge_06/SOURCE_SHA256.json','tools/firmware/f3_capture_menu_06/SOURCE_SHA256.json','tools/firmware/f3_source_dependencies_02/SOURCE_SHA256.json','tools/firmware/native_activity_01/SOURCE_SHA256.json','tools/firmware/f3_native_executor_03/saved_capture_contract.h','analysis/firmware/f3_native_fanout_mask_review_01/EXACT.json','analysis/firmware/f3_native_fanout_mask_review_01/manifest.json','analysis/firmware/f3_xqd_ram_group_review_01/REVIEW.md','analysis/firmware/f3_xqd_ram_group_review_01/EXACT.json','analysis/firmware/f3_xqd_ram_group_review_01/manifest.json']}
 for p in OUT.glob('*.d'):
  for v in shlex.split(p.read_text().replace('\\\n',' ').split(':',1)[1]):
   q=Path(v);q=(q if q.is_absolute()else ROOT/q).resolve()
   if q.is_file()and q.is_relative_to(ROOT)and q not in owned:refs.add(q)
 # Host sources also form part of the reproducible own fault-test closure.
 refs|={ROOT/p for p in ['tools/firmware/f3_native_fs_adapter_04/host_posix.c','tools/firmware/native_activity_01/activity.c']}
 lock=dict(schema='iq4_f3_saved_raw_capture_source_03',files=[row(p)for p in sorted(owned)],references=[row(p)for p in sorted(refs)],artifacts=[row(p)for p in sorted(artifacts)],compile_header_closure=True,external_dependency_manifests_require_existing_frozen_project=True,target_executed=False,sdk_loaded=False,device_connected=False)
 (HERE/'SOURCE_SHA256.json').write_text(json.dumps(lock,indent=2)+'\n')
 old=json.loads((ROOT/'tools/firmware/f3_saved_raw_capture_01/LINK_INPUT.json').read_text())['objects'];rt=json.loads((ROOT/'tools/firmware/f3_saved_raw_capture_02/LINK_INPUT.json').read_text())['objects'][0]
 oldrows={Path(r['path']).name:r for r in old};oldrows['runtime.o']=rt
 replacements=[dict(replace_only=oldrows[n+'.o'],replacement=row(OUT/(n+'.o')))for n in ('capture','runtime','native_factory')]
 for r in replacements:assert row(ROOT/r['replace_only']['path'])==r['replace_only']
 link=dict(schema='iq4_f3_saved_raw_capture_overlay_03',source=row(HERE/'SOURCE_SHA256.json'),replacements=replacements,additional_objects=[],original_bindings=row(HERE/'ORIGINAL_BINDINGS.json'),unchanged_objects=[oldrows[n+'.o']for n in ('directories_linux','acquired_wrapper')],consumer='coordinator08/executor03 group proof, original APIs remain',target_executed=False)
 (HERE/'LINK_OVERLAY.json').write_text(json.dumps(link,indent=2)+'\n');(HERE/'LINK_INPUT.json').write_text(json.dumps(dict(schema='iq4_f3_saved_raw_capture_link_03',source=link['source'],objects=[r['replacement']for r in replacements],original_bindings=link['original_bindings'],target_executed=False),indent=2)+'\n')
 members=owned|refs|artifacts|{HERE/'SOURCE_SHA256.json',HERE/'LINK_OVERLAY.json',HERE/'LINK_INPUT.json'}
 dest=ROOT/'build/f3_saved_raw_capture_source_03/IQ4_F3_Saved_RAW_Capture_03_Source.zip';dest.parent.mkdir(parents=True,exist_ok=True)
 with zipfile.ZipFile(dest,'w',compression=zipfile.ZIP_DEFLATED)as z:
  for p in sorted(members):z.write(p,p.relative_to(ROOT).as_posix())
 receipt=dict(source=row(HERE/'SOURCE_SHA256.json'),link=row(HERE/'LINK_OVERLAY.json'),zip=row(dest),members=len(members),hash_rows=len(owned|refs|artifacts),normal=36,asan_ubsan=36,target_objects=3,additional_objects=0,target_executed=False)
 (OUT/'FREEZE_RECEIPT.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps(receipt))
if __name__=='__main__':main()
