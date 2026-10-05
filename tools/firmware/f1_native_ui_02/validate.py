#!/usr/bin/env python3
"""Frozen F1 UI02 hash/window/disabled scope validation; no target execution."""
from pathlib import Path
import hashlib,json,struct,zipfile
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f1_native_ui_02'
def digest(b):return hashlib.sha256(b).hexdigest()
def main():
 mp=OUT/'manifest.json';m=json.loads(mp.read_text());count=0
 for group in ['files','frozen_dependencies','ignored_rebuildable_ET_REL']:
  for rel,sha in m[group].items():
   p=(ROOT/rel).resolve()
   if not p.is_relative_to(ROOT)or digest(p.read_bytes())!=sha:raise SystemExit('Hash mismatch: '+rel)
   count+=1
   if group=='files':
    s=p.read_text()
    if not s.endswith('\n')or s.endswith('\n\n')or any(x!=x.rstrip()for x in s.splitlines()):raise SystemExit('Whitespace mismatch: '+rel)
 fields=['production_binding_enabled','device_accessed','vendor_code_executed','target_executed','actual_owner_and_native_menu_verified','actual_user_action_entry_verified','actual_fresh_repaint_and_disable_restore_verified','actual_surface_geometry_and_RAW_JPEG_isolation_verified','installed']
 if any(m[k]is not False for k in fields):raise SystemExit('Actual acceptance incorrectly recorded')
 b=json.loads((OUT/'build_validation.json').read_text())
 for name in ['normal','asan_ubsan']:
  if b['tests'][name]['groups']!=30 or b['tests'][name]['exit_code']:raise SystemExit('Host receipt mismatch')
 if b['tests']['production']['receipt']!='production EN0: zero native reads/calls'or len(b['target_objects'])!=2 or any(o['ELF_type']!=1 or o['machine']!=183 for o in b['target_objects']):raise SystemExit('Build scope mismatch')
 for k in fields[:-1]:
  if k=='actual_user_action_entry_verified':continue
  if b[k]is not False:raise SystemExit('Build actual acceptance incorrectly recorded')
 for rel,sha in b['sources'].items():
  if digest((ROOT/rel).read_bytes())!=sha:raise SystemExit('Build source mismatch')
 input=m['exact_User_input'];raw=(ROOT/input['path']).read_bytes()
 if len(raw)!=input['bytes']or digest(raw)!=input['sha256']:raise SystemExit('User mismatch')
 exact=json.loads((OUT/'static/exact_bytes.json').read_text())
 if exact['input_sha256']!=input['sha256']or exact['device_accessed']is not False or exact['target_executed']is not False:raise SystemExit('Exact scope mismatch')
 for r in exact['ranges']:
  a=int(r['start_va'],16);e=int(r['end_va_exclusive'],16);o=int(r['file_offset'],16);chunk=raw[o:o+e-a]
  if o!=a-0x400000 or chunk.hex()!=r['bytes_hex']or digest(chunk)!=r['bytes_sha256']or digest((ROOT/r['disassembly']).read_bytes())!=r['disassembly_sha256']:raise SystemExit('Exact window mismatch')
 for t in exact['tables']:
  o=int(t['file_offset'],16);chunk=raw[o:o+t['size']]
  if o!=int(t['va'],16)-0x400000 or chunk.hex()!=t['bytes_hex']or digest(chunk)!=t['sha256']:raise SystemExit('Exact table mismatch')
  if 'qwords'in t and [hex(struct.unpack_from('<Q',chunk,i)[0])for i in range(0,t['size']//8*8,8)]!=t['qwords']:raise SystemExit('Exact qword mismatch')
 for e in exact['entries']:
  a=int(e['va'],16)-0x400000
  if raw[a:a+16].hex()!=e['bytes_hex']:raise SystemExit('Candidate entry mismatch')
 if len(exact['ranges'])!=40 or len(exact['tables'])!=13 or len(exact['entries'])!=12 or exact['dynamic_relocation_evidence']!=['0000000000f436f8 R_AARCH64_JUMP_SLOT      strncpy']:raise SystemExit('Finite static contract changed')
 archive=OUT/'f1_native_ui_02_source.zip'
 with zipfile.ZipFile(archive)as z:
  expected=set(m['files'])|set(m['frozen_dependencies'])|{str(mp.relative_to(ROOT))}
  if len(z.namelist())!=len(expected)or set(z.namelist())!=expected:raise SystemExit('ZIP member mismatch')
  for name in z.namelist():
   if z.read(name)!=(ROOT/name).read_bytes():raise SystemExit('ZIP source content mismatch')
 print(json.dumps(dict(status='PASS',hashes_checked=count,exact_windows=40,tables_and_strings=13,candidate_entry_checks=12,host_groups_each_normal_and_asan_ubsan=30,production_zero_native_reads_calls=True,actual_acceptance=False)))
if __name__=='__main__':main()
