#!/usr/bin/env python3
"""Check frozen source hashes and exact input windows. Never execute target code."""
from pathlib import Path
import hashlib,json,struct,zipfile
from freeze import FALSE_FIELDS
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f1_geometry_probe_03'
def digest(b):return hashlib.sha256(b).hexdigest()
def main():
 mp=OUT/'manifest.json';m=json.loads(mp.read_text());count=0
 if m['schema']!='iq4_f1_geometry_paint03_freeze_v1':raise SystemExit('Wrong schema')
 for group in ['files','frozen_dependencies','ignored_rebuildable_target_artifacts']:
  for rel,sha in m[group].items():
   p=(ROOT/rel).resolve()
   if not p.is_relative_to(ROOT)or digest(p.read_bytes())!=sha:raise SystemExit('Hash mismatch: '+rel)
   count+=1
   if group=='files':
    s=p.read_text()
    if not s.endswith('\n')or s.endswith('\n\n')or any(x!=x.rstrip()for x in s.splitlines()):raise SystemExit('Whitespace mismatch: '+rel)
 if any(m[k]is not False for k in FALSE_FIELDS):raise SystemExit('Unproven actual acceptance')
 b=json.loads((OUT/'build_validation.json').read_text())
 for name in ['normal','asan_ubsan']:
  if b['tests'][name]['groups']!=30 or b['tests'][name]['exit_code']:raise SystemExit('Host receipt mismatch')
 if b['tests']['production']!=dict(groups=3,receipt='3 production guard groups; zero native reads/calls',exit_code=0):raise SystemExit('Production guard mismatch')
 if [o['ELF_type']for o in b['target_objects']]!=[1,3]or any(o['machine']!=183 for o in b['target_objects']):raise SystemExit('Target build scope mismatch')
 for k in ['production_overlay_enabled','actual_geometry_mapping_verified','actual_fresh_blit_verified','actual_surface_lease_verified','device_accessed','target_executed','vendor_code_executed']:
  if b[k]is not False:raise SystemExit('Build actual acceptance improperly recorded')
 for rel,sha in b['sources'].items():
  if digest((ROOT/rel).read_bytes())!=sha:raise SystemExit('Build source changed: '+rel)
 inp=m['exact_User_input'];raw=(ROOT/inp['path']).read_bytes()
 if len(raw)!=inp['bytes']or digest(raw)!=inp['sha256']:raise SystemExit('Exact User mismatch')
 e=json.loads((OUT/'static/exact_bytes.json').read_text())
 if e['input_sha256']!=inp['sha256']or e['input_size']!=inp['bytes']or e['device_accessed']is not False or e['target_executed']is not False:raise SystemExit('Wrong static scope')
 for r in e['ranges']:
  a=int(r['start_va'],16);end=int(r['end_va_exclusive'],16);off=int(r['file_offset'],16);chunk=raw[off:off+end-a]
  if not a<end or off!=a-0x400000 or chunk.hex()!=r['bytes_hex']or digest(chunk)!=r['sha256']or digest((ROOT/r['disassembly']).read_bytes())!=r['disassembly_sha256']:raise SystemExit('Exact range mismatch')
 for t in e['tables']:
  off=int(t['file_offset'],16);chunk=raw[off:off+t['size']]
  if off!=int(t['va'],16)-0x400000 or chunk.hex()!=t['bytes_hex']or digest(chunk)!=t['sha256']or [hex(struct.unpack_from('<Q',chunk,i)[0])for i in range(0,t['size'],8)]!=t['qwords']:raise SystemExit('Exact table mismatch')
 if len(e['ranges'])!=28 or len(e['tables'])!=5:raise SystemExit('Finite static set changed')
 archive=OUT/'f1_geometry_probe_03_source.zip'
 with zipfile.ZipFile(archive)as z:
  expected=set(m['files'])|set(m['frozen_dependencies'])|{str(mp.relative_to(ROOT))}
  if len(z.namelist())!=len(expected)or set(z.namelist())!=expected:raise SystemExit('ZIP members changed')
  for rel in z.namelist():
   if z.read(rel)!=(ROOT/rel).read_bytes():raise SystemExit('ZIP source mismatch')
 print(json.dumps(dict(status='PASS',hashes_checked=count,exact_windows=28,tables=5,host_groups_each_normal_and_asan_ubsan=30,production_guard_groups=3,target_build_only=True,actual_acceptance=False)))
if __name__=='__main__':main()
