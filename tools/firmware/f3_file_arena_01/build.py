#!/usr/bin/env python3
"""Own real-host POSIX fixtures and target compilation; no target execution."""
import argparse,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def item(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 assert not out.exists() and out.is_relative_to(ROOT)
 assert item(ZIG)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 assert item(STOCK)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 out.mkdir(parents=True);commands=[]
 def run(args,kind):
  q=subprocess.run(list(map(str,args)),cwd=ROOT,text=True,capture_output=True)
  commands.append(dict(kind=kind,argv=list(map(str,args)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if q.returncode:raise RuntimeError(q.stdout+q.stderr)
  return q.stdout
 sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk').strip();assert Path(sdk).is_dir()
 run([ZIG,'version'],'cross_compiler_identity')
 flags=['-std=c11','-O2','-g','-Wall','-Wextra','-Werror']
 host=[]
 for san in (False,True):
  exe=out/('arena_sanitized' if san else 'arena_normal')
  run(['/Library/Developer/CommandLineTools/usr/bin/clang','-isysroot',sdk,*flags,*(['-fsanitize=address,undefined','-fno-omit-frame-pointer'] if san else []),HERE/'test_arena.c',HERE/'arena.c','-o',exe],'own_host_compile')
  host.append(dict(sanitized=san,result=json.loads(run([exe],'own_host_execution'))))
 objs=[]
 target=['-target','aarch64-linux-gnu.2.28',*flags,'-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-fPIC','-ffunction-sections','-fdata-sections','-funwind-tables','-fno-asynchronous-unwind-tables']
 for source in ('arena.c','native_linux.c'):
  obj=out/(source[:-2]+'.o');run([ZIG,'cc',*target,'-c',HERE/source,'-o',obj],'target_compile_only');objs.append(item(obj))
 report=dict(schema='iq4_f3_file_arena_build_01',source=[item(p) for p in sorted(HERE.iterdir()) if p.is_file()],compiler=item(ZIG),stock=item(STOCK),host=host,objects=objs,target_executed=False,device_accessed=False,full_RAW_renderer_executed=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
if __name__=='__main__':main()
