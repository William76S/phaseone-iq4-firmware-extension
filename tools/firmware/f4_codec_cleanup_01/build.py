#!/usr/bin/env python3
"""New two-object overlay, finite offline evidence, no original native execution."""
import argparse
import hashlib
import importlib.util
import json
import re
import struct
import subprocess
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
SDK=Path('/Library/Developer/CommandLineTools/SDKs/MacOSX15.4.sdk')
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=sha(p))
def save(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 assert out.is_relative_to(ROOT) and not out.exists();out.mkdir(parents=True)
 commands=[];host=[];objects=[]
 def run(argv):
  p=subprocess.run([str(x) for x in argv],cwd=ROOT,text=True,capture_output=True)
  commands.append(dict(argv=[str(x) for x in argv],exit=p.returncode,stdout=p.stdout,stderr=p.stderr));save(out/'COMMANDS.json',commands)
  if p.returncode:raise RuntimeError(p.stdout+p.stderr)
  return p.stdout
 assert run([ZIG,'version']).strip()=='0.15.2'
 lib=ROOT/'evidence/codec/build/libjpeg8/.libs/libjpeg.a'
 sanlib=ROOT/'evidence/codec/build/libjpeg8_sanitized/.libs/libjpeg.a'
 for mode,library in [('normal',lib),('sanitized',sanlib)]:
  flags=['-std=c11','-Wall','-Wextra','-Werror','-isysroot',SDK,'-DIQ4_JPEG_API_VERSION=80']
  flags+=['-O1','-g','-fsanitize=address,undefined','-fno-omit-frame-pointer'] if mode=='sanitized' else ['-O2']
  for name,sources,libs in [('codec',['bounded_jpeg.c','test_codec.c'],[library]),('worker',['worker.c','test_worker.c'],[])]:
   exe=out/f'{name}_{mode}';run(['/usr/bin/clang',*flags,*[HERE/x for x in sources],*libs,'-o',exe]);result=json.loads(run([exe]));host.append(dict(mode=mode,suite=name,binary=row(exe),**result))
 for name in ['bounded_jpeg','worker']:
  builds=[]
  for number in [1,2]:
   obj=out/f'{name}_{number}.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-DIQ4_JPEG_API_VERSION=82','-O2','-g0','-fPIC','-Wall','-Wextra','-Werror','-ffunction-sections','-fdata-sections','-mno-outline-atomics','-funwind-tables','-c',HERE/f'{name}.c','-o',obj])
   b=obj.read_bytes();assert b[:7]==b'\x7fELF\x02\x01\x01' and struct.unpack_from('<HH',b,16)==(1,183);builds.append(row(obj))
  assert builds[0]['sha256']==builds[1]['sha256']
  nm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only',out/f'{name}_1.o'])
  disasm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',out/f'{name}_1.o']);(out/f'{name}.asm').write_text(disasm)
  objects.append(dict(name=name,builds=builds,byte_identical=True,undefined=nm))
 spec=importlib.util.spec_from_file_location('exact',ROOT/'tools/firmware/f3_render_plan_01/collect_static.py');exact=importlib.util.module_from_spec(spec);spec.loader.exec_module(exact);image=exact.ExactImage(exact.ORIGINAL)
 windows=[]
 for name,start,end in [('JpegMemoryCtor',0x9a5250,0x9a53b4),('JpegFreePoolAndSelfDestroy',0x9a40d8,0x9a4278),('JpegMemorySystemFree',0x9a7ef0,0x9a7f58)]:
  off,raw=image.get(start,end-start);txt=run([exact.OBJDUMP,'-d',f'--start-address={start}',f'--stop-address={end}',exact.ORIGINAL]);n=0
  for s in txt.splitlines():
   m=re.match(r'\s*([0-9a-f]+):\s+([0-9a-f]{8})\s',s)
   if m:assert struct.unpack('<I',image.get(int(m[1],16),4)[1])[0]==int(m[2],16);n+=1
  assert n==(end-start)//4;(out/f'{name}.asm').write_text(txt);windows.append(dict(name=name,start=start,end=end,file_offset=off,raw_sha256=hashlib.sha256(raw).hexdigest(),raw_hex=raw.hex(),instructions=n))
 save(out/'EXACT.json',dict(original_sha256=exact.SHA,windows=windows,target_executed=False))
 build=dict(host=host,objects=objects,host_libraries=[row(lib),row(sanlib)],compiler=row(ZIG),frozen_derivative_inputs=[row(ROOT/'src/codec/bounded_jpeg.c'),row(ROOT/'tools/firmware/f4_native_source_02/worker.c')],exact=row(out/'EXACT.json'),session_hold_branch={'file':'tools/firmware/f4_native_source_02/session.c','lines':[18,74,84],'native_owners_released':False},target_executed=False,camera_accessed=False)
 save(out/'BUILD.json',build)
 original=json.loads((ROOT/'analysis/firmware/f1_f4_user_integration_build_01_attempt03/LINK_REPORT.json').read_text())
 old={('worker' if x['label'].endswith('/worker.o') else 'bounded_jpeg'):x for x in original['objects'] if x['label'].endswith(('/worker.o','/bounded_jpeg.o'))};assert len(old)==2
 src=sorted(p for p in HERE.iterdir() if p.is_file() and p.name not in ['SOURCE_SHA256.json','LINK_OVERLAY.json'])
 save(HERE/'SOURCE_SHA256.json',dict(files=[row(p) for p in src],build=row(out/'BUILD.json'),commands=row(out/'COMMANDS.json'),derivative_originals=build['frozen_derivative_inputs'],target_executed=False))
 replacements=[]
 for o in objects:
  before=old[o['name']];p=ROOT/before['label'];assert sha(p)==before['sha256'];replacements.append(dict(replace_only=row(p),replacement=o['builds'][0]))
 save(HERE/'LINK_OVERLAY.json',dict(schema='iq4_f4_cleanup_two_object_overlay',source=row(HERE/'SOURCE_SHA256.json'),replacements=replacements,ABI_unchanged=True,additional_aliases=[],other_objects_unchanged=True,target_executed=False,cleanup_error_acceptance=False))
 print(json.dumps(dict(source=sha(HERE/'SOURCE_SHA256.json'),overlay=sha(HERE/'LINK_OVERLAY.json'),host_groups_each=sum(x['groups'] for x in host if x['mode']=='normal'),objects=2)))
if __name__=='__main__':main()
