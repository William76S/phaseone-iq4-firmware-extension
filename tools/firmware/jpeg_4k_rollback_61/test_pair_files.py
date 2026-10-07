#!/usr/bin/env python3
"""Four actual host filesystem cases using production61 helper, fixture native/card boundaries."""
from pathlib import Path
import hashlib,json,os,shutil,subprocess,tempfile
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/jpeg_4k_rollback_61_audit';P=R/'tools/firmware/jpeg_pair_delete_61'
def row(p):b=p.read_bytes();return dict(path=str(p.relative_to(R)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
inputs=[Path(__file__),D/'test_pair_files.cpp',P/'pair.cpp',P/'pair.h',P/'pins.h',R/'analysis/firmware/extracted/P1Linux_6.03.21.bin'];locks=[row(p)for p in inputs]
commands=[]
def cmd(argv):
 q=subprocess.run(list(map(str,argv)),cwd=R,text=True,capture_output=True);commands.append(dict(argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));assert q.returncode==0,commands[-1]
sdk='/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk';exe=O/'test_pair_files'
cmd(['/usr/bin/clang++','-isysroot',sdk,'-isystem',sdk+'/usr/include/c++/v1','-std=c++17','-O1',D/'test_pair_files.cpp','-o',exe])
tmp=Path(tempfile.mkdtemp(prefix='pair61-real-files-',dir=O));cases=[]
def snapshot(d):return {p.name:hashlib.sha256(p.read_bytes()).hexdigest()for p in sorted(d.iterdir())if p.is_file()}
try:
 for name in ['xqd_pair','neighbor_preserved','jpeg_remove_denied','jpeg_only']:
  card=tmp/name/'xqdcard';directory=card/'DCIM/100PHASE';directory.mkdir(parents=True)
  names=['IMG0001.IIQ','IMG0001.JPG']
  if name in ['neighbor_preserved','jpeg_only']:names+=['IMG0002.IIQ','IMG0002.JPG','OTHER.JPG']
  for file in names:(directory/file).write_bytes(('synthetic fixture '+name+' '+file+'\n').encode())
  before=snapshot(directory);cmd([exe,card,name]);after=snapshot(directory)
  expected=set(before)
  if name in ['xqd_pair','neighbor_preserved']:expected-= {'IMG0001.IIQ','IMG0001.JPG'}
  elif name=='jpeg_only':expected.remove('IMG0001.JPG')
  assert set(after)==expected and all(before[k]==v for k,v in after.items())
  cases.append(dict(case=name,files_before=before,files_after=after,actual_POSIX_stat_remove=True,retained_files_bytes_unchanged=True,remove_denial_via_real_directory_mode_0500=name=='jpeg_remove_denied'))
finally:
 for parent,dirs,files in os.walk(tmp):os.chmod(parent,0o700)
 shutil.rmtree(tmp)
assert locks==[row(p)for p in inputs]
report=dict(schema='iq4_61_four_actual_host_filesystem_deletion_cases',inputs=locks,commands=commands,cases=cases,temp_tree_removed=not tmp.exists(),camera_or_card_accessed=False,synthetic_file_payloads_not_valid_IIQ_JPEG=True,fixtures=['native objects and native card client API','original File object maps to one fixture RAW pathname','native ExpandPath maps only original XQD prefix to project temporary directory','JPEGOnly gallery registry identity callbacks'],production_helper_used_without_source_change=True,actual_host_filesystem_calls=['stat','remove','chmod'])
(O/'PAIR61_REAL_FILES.json').write_text(json.dumps(report,indent=2)+'\n')
(O/'PAIR61_REAL_FILES_SHA256.json').write_text(json.dumps(dict(schema='iq4_61_actual_host_filesystem_supplement',files=locks+[row(O/'PAIR61_REAL_FILES.json')]),indent=2)+'\n')
print(json.dumps(dict(cases=len(cases),receipt=row(O/'PAIR61_REAL_FILES.json'),lock=row(O/'PAIR61_REAL_FILES_SHA256.json'))))
