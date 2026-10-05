#!/usr/bin/env python3
"""Owned host receipt tests and exact AArch64 objects; no original/target call."""
import argparse,hashlib,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';HOST='/Library/Developer/CommandLineTools/usr/bin/clang'
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 if out.exists() or not out.is_relative_to(ROOT):raise ValueError('fresh local output required')
 assert row(ZIG)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 out.mkdir(parents=True);commands=[];tests=[]
 def run(argv):
  q=subprocess.run([str(x) for x in argv],cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(argv=[str(x) for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr))
  (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if q.returncode:raise RuntimeError(q.stdout+q.stderr)
  return q.stdout
 sdk=run(['/usr/bin/xcrun','--show-sdk-path']).strip();assert run([ZIG,'version']).strip()=='0.15.2'
 runtime=ROOT/'tools/firmware/native_runtime_01'
 for san in (False,True):
  suffix='sanitized' if san else 'normal';flags=['-isysroot',sdk,'-std=c11','-O2','-DIQ4_NATIVE_HOST_FIXTURE','-Wall','-Wextra','-Werror']
  if san:flags+=['-fsanitize=address,undefined','-fno-omit-frame-pointer']
  exe=out/('receipt_'+suffix);run([HOST,*flags,HERE/'receipt.c',HERE/'test_receipt.c','-o',exe])
  for case in range(17):tests.append(dict(sanitized=san,case=case,output=run([exe,case]).strip()))
  exe=out/('self_'+suffix);run([HOST,*flags,runtime/'self_read.c',runtime/'test_self_read.c','-o',exe]);tests.append(dict(sanitized=san,case='self_read',output=run([exe]).strip()))
 flags=['-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-ffunction-sections','-fdata-sections','-fPIC','-Wall','-Wextra','-Werror'];objects=[]
 for src,name in [(HERE/'receipt.c','receipt.o'),(HERE/'wrappers.S','wrappers.o'),(runtime/'self_read.c','self_read.o')]:
  obj=out/name;opts=flags if src.suffix=='.c' else ['-target','aarch64-linux-gnu.2.28','-g0','-fPIC']
  run([ZIG,'cc',*opts,'-c',src,'-o',obj]);b=obj.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);assert h[1]==1 and h[2]==183
  objects.append(dict(**row(obj),ET_REL=True,target_executed=False))
  text=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj]);(out/(name+'.asm')).write_text('\n'.join(x.rstrip() for x in text.splitlines())+'\n')
 result=dict(schema='iq4_core_native_receipt_01',objects=objects,host_tests=tests,compiler=row(ZIG),whole_RAW_decode_proved=False,whole_PreviewProcess_proved=False,firmware_produced=False,device_access=False,target_executed=False)
 (out/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps({'tests':len(tests),'objects':len(objects),'device_access':False}))
if __name__=='__main__':main()
