#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,re,sys,struct
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/stock_storage_router_55'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def main():
 if '--verify'in sys.argv:
  link=json.loads((OUT/'LINK.json').read_text());src=json.loads((ROOT/link['source_manifest']).read_text())
  assert row(ROOT/link['source_manifest'])['sha256']==link['source_manifest_sha256']
  assert all(row(ROOT/q['path'])==q for q in src['files'])
  assert all(row(ROOT/q['path'])==q for q in link['objects'])
  print('PASS frozen storage55 source, focused proof and seven target objects');return
 build=json.loads((OUT/'BUILD.json').read_text());exact=json.loads((OUT/'EXACT.json').read_text())
 assert all(q['exit']==0 for q in json.loads((OUT/'COMMANDS.json').read_text()))
 objects=build['objects'];assert all(row(ROOT/q['path'])==q for q in objects)
 b=USER.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
 phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 def raw(va,n):
  for i in range(num):
   typ,fl,off,a,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
   if typ==1 and a<=va and va+n<=a+fs:return b[off+va-a:off+va-a+n]
  raise AssertionError(hex(va))
 files={p for p in HERE.iterdir()if p.is_file()}
 files|={OUT/'BUILD.json',OUT/'COMMANDS.json',OUT/'EXACT.json',OUT/'A64_DELETE_LOOKUP.json',OUT/'A64_HALF_WAIT.json'}
 for q in objects:files|={ROOT/q['path'],OUT/(Path(q['path']).name+'.asm')}
 todo=list(files);inactive_includes=[]
 while todo:
  p=todo.pop()
  if p.suffix not in ('.h','.cpp','.c','.S'):continue
  for name in re.findall(r'^\s*#\s*include\s*"([^"]+)"',p.read_text(),re.M):
   child=(p.parent/name).resolve();assert child.is_relative_to(ROOT),child
   if not child.exists():
    assert 'vendor/libjpeg-turbo-1.5.3/' in str(child),child
    inactive_includes.append(dict(including=str(p.relative_to(ROOT)),conditional_path=str(child.relative_to(ROOT)),active_target_macro='IQ4_JPEG_API_VERSION=82'));continue
   if child not in files:files.add(child);todo.append(child)
 references=[ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py',
  ROOT/'analysis/firmware/stock_jpeg_policy_build_01/EXACT.json',
  ROOT/'analysis/firmware/native_half_failure_audit_55/SOURCE_SHA256.json',
  ROOT/'analysis/firmware/native_half_failure_audit_55/A64_UID_WORKER.json',
  ROOT/'analysis/firmware/half_timeout_55_static/RECEIPT.json',
  ROOT/'tools/firmware/stock_new_raw_receipt_55/SOURCE_SHA256.json']
 for p in references:assert p.exists();files.add(p)
 source=OUT/'SOURCE_SHA256.json';emit(source,dict(schema='iq4_stock_storage_router_source_55',files=[row(p)for p in sorted(files)],inactive_legacy_headers=inactive_includes,camera_accessed=False,target_device_executed=False))
 src=row(source);policy=json.loads((ROOT/'analysis/firmware/stock_jpeg_policy_build_01/LINK.json').read_text())
 alias='iq4_stock_original_catalog_lookup_55';va=0x48f4f0;first=raw(va,16)
 link=dict(schema='iq4_stock_storage_router_link_55',objects=objects,
  aliases=[dict(symbol=alias,va=va,kind='original imported routine',original_first16_LE=first.hex(),original_first16_sha256=hashlib.sha256(first).hexdigest())],
  BL_hooks=exact['BL_hooks']+[policy['BL_hooks'][0]],auxiliary_hooks=policy['auxiliary_hooks'],
  source_manifest=src['path'],source_manifest_sha256=src['sha256'],
  required_functions=['iq4_stock_jpeg_ctor_01','iq4_stock_xqd_format_get_55','iq4_stock_xqd_format_set_55','iq4_stock_storage_capture_format_55',
   'iq4_stock_jpeg_policy_bind_01','iq4_stock_jpeg_policy_set_01','iq4_stock_jpeg_policy_ctor_wrapper_01',
   'iq4_stock_half_acquire_01','iq4_stock_half_inner_wait_55','iq4_stock_half_inner_wait_wrapper_55','iq4_stock_delete_lookup_wrapper_55',
   'iq4_stock_jpeg_pending_clear_guard_55','iq4_stock_jpeg_last_failure_55','iq4_stock_storage_normalize_idle_55',
   'iq4_stock_jpeg_gallery_card_enter_55','iq4_stock_jpeg_gallery_card_guard_55','iq4_stock_jpeg_gallery_card_leave_55'],
  replaces_objects=['analysis/firmware/stock_half_export_54/runtime.o','analysis/firmware/stock_jpeg_policy_build_01/policy.o','analysis/firmware/stock_jpeg_policy_build_01/ctor_wrapper.o'],
  external_production_providers=['iq4_stock_storage_normalize_sd_55','iq4_new_raw_bind_55','iq4_stock_jpeg_gallery_bind_55','iq4_stock_jpeg_only_gallery_bound_55'],
  retains_54_half_settings_and_sink=True,retains_54_native_half_producer=True,retains_52_checked_publisher=True,
  required_policy_observer_target='iq4_stock_storage_policy_wrapper_55',policy_runtime_pin_header='tools/firmware/stock_storage_router_55/policy_pins_55.h',
  storage_runtime_pin_header='tools/firmware/stock_storage_router_55/router_pins_55.h',
  stock_pin_header='tools/firmware/f3_stock_half_export_01/stock_pins_54.h',half_pin_header='tools/firmware/f3_stock_half_export_01/half_pins.h',
  format_values={'0':'IIQ Only','1':'JPEG Only','2':'IIQ+JPEG'},native_size_enum=1,half_dimensions=[7102,5326],quality=100,
  half_inner_wait_milliseconds=60000,half_outer_wait_milliseconds=90000,native_nonowned_wait_unchanged=True,
  failed_job_pending_cleared_only_after_same_photo_and_quiescence=True,existing_done16_unchanged=True,
  JPEG_only_requires_true_gallery_and_fresh_RAW_receipt=True,camera_accessed=False,target_device_executed=False)
 emit(OUT/'LINK.json',link);print(json.dumps(dict(link=row(OUT/'LINK.json'),source=src,objects=objects)))
if __name__=='__main__':main()
