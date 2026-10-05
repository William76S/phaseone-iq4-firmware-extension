#!/usr/bin/env python3
"""Offline direct-clang/sanitized and two fresh AArch64 object builds."""
import argparse
import hashlib
import importlib.util
import json
import subprocess
import struct
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
SOURCE=ROOT/'tools/firmware/f3_raw_file_source_01'
SDK=Path('/Library/Developer/CommandLineTools/SDKs/MacOSX15.4.sdk')
SAMPLE=ROOT/'inputs/camera_baseline/IQ4_P0_20261004/Capture/IQ4_P0_2026100415266.iiq'
def sha(path):
 h=hashlib.sha256()
 with path.open('rb') as f:
  while b:=f.read(1024*1024):h.update(b)
 return h.hexdigest()
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,default=ROOT/'evidence/f3_raw_file_source_01');ap.add_argument('--skip-sample',action='store_true');a=ap.parse_args();out=a.output.resolve();out.mkdir(parents=True,exist_ok=True)
 spec=importlib.util.spec_from_file_location('fixtures',ROOT/'tests/f3_raw_file_source_01/make_fixture.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 fixture=out/'fixtures';subprocess.run([__import__('sys').executable,str(ROOT/'tests/f3_raw_file_source_01/make_fixture.py'),str(fixture)],check=True)
 commands=[]
 def run(argv):
  r=subprocess.run([str(x) for x in argv],cwd=ROOT,capture_output=True,text=True)
  commands.append({'argv':[str(x) for x in argv],'exit':r.returncode,'stdout':r.stdout,'stderr':r.stderr})
  if r.returncode:raise RuntimeError(r.stderr or r.stdout)
  return r
 before=sha(SAMPLE) if not a.skip_sample else None
 host=[]
 for name,flags in [('normal',['-O2']),('sanitized',['-O1','-g','-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  binary=out/('test_source_'+name)
  argv=['/usr/bin/clang++','-std=c++17','-Wall','-Wextra','-Werror','-pedantic',*flags,
  '-isysroot',SDK,'-isystem',SDK/'usr/include/c++/v1','-I',SOURCE,
  SOURCE/'reader_stage.cpp',SOURCE/'source_builder.cpp',SOURCE/'host_posix.cpp',
  ROOT/'tests/f3_raw_file_source_01/test_source.cpp','-o',binary]
  run(argv);r=run([binary,fixture]+([] if a.skip_sample else [SAMPLE]));result=json.loads(r.stdout)
  host.append({'mode':name,'binary':str(binary),'sha256':sha(binary),**result})
 after=sha(SAMPLE) if not a.skip_sample else None
 if before!=after:raise ValueError('actual sample changed')
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';target=[]
 for unit in ['reader_stage','source_builder']:
  builds=[]
  for number in [1,2]:
   obj=out/f'{unit}_aarch64_{number}.o'
   run([zig,'c++','-target','aarch64-linux-gnu.2.28','-std=c++17','-Wall','-Wextra','-Werror','-O2','-ffunction-sections','-fdata-sections','-fPIC','-c',SOURCE/(unit+'.cpp'),'-o',obj])
   data=obj.read_bytes()
   if data[:7]!=b'\x7fELF\x02\x01\x01' or struct.unpack_from('<HH',data,16)!=(1,183):raise ValueError('wrong ELF object type/architecture')
   builds.append({'path':str(obj),'bytes':len(data),'sha256':sha(obj),'ELF':'ELF64LE AArch64 ET_REL'})
  if builds[0]['sha256']!=builds[1]['sha256']:raise ValueError('target nondeterminism')
  nm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only',builds[0]['path']])
  target.append({'unit':unit,'byte_identical':True,'builds':builds,'undefined':nm.stdout})
 result={'schema':'iq4_raw_file_source_host_01','host':host,'target_objects':target,
 'device_accessed':False,'native_vendor_code_executed':False,'actual_sample_read_only':True,
 'actual_sample_path':str(SAMPLE) if before else None,'actual_sample_sha256_before':before,'actual_sample_sha256_after':after,
 'zig_sha256':sha(zig)}
 (out/'VALIDATION.json').write_text(json.dumps(result,indent=2)+'\n');(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
 print(json.dumps({'normal_groups':host[0]['groups'],'sanitized_groups':host[1]['groups'],'target_units':len(target),'sample_unchanged':before==after,'target_executed':False}))
if __name__=='__main__':main()
