#!/usr/bin/env python3
import argparse,hashlib,importlib.util,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';CC='/Library/Developer/CommandLineTools/usr/bin/clang';ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();assert row(ZIG)['sha256']==ZSHA;out.mkdir(parents=True);cmds=[];tests=[]
 def run(argv,kind):
  r=subprocess.run([str(x)for x in argv],cwd=ROOT,capture_output=True,text=True);d=dict(kind=kind,argv=[str(x)for x in argv],exit=r.returncode,stdout=r.stdout,stderr=r.stderr);cmds.append(d);(out/'COMMANDS.json').write_text(json.dumps(cmds,indent=2)+'\n');assert not r.returncode,d;return r.stdout
 sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk').strip();assert run([ZIG,'version'],'compiler_version').strip()=='0.15.2'
 for name,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined']),('tsan',['-fsanitize=thread'])]:
  exe=out/('activity_'+name);run([CC,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror','-DIQ4_ACTIVITY_SYNTHETIC_HOST',*extra,OWN/'activity.c',OWN/'test_activity.c','-o',exe],'own_host_compile');tests.append(dict(variant=name,stdout=run([exe],'synthetic_host_execution')))
 obj=out/'activity.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-Wall','-Wextra','-Werror','-c',OWN/'activity.c','-o',obj],'cross_compile_only')
 spec=importlib.util.spec_from_file_location('original_inspect',ROOT/'tools/firmware/f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);ins=m.inspect(obj);assert ins['undefined_symbols']==[]
 (out/'BUILD.json').write_text(json.dumps(dict(schema='iq4_native_activity_build_01',compiler=row(ZIG),source_inputs=[row(p)for p in OWN.iterdir()if p.is_file()and p.suffix in ['.c','.h','.py','.md']],tests=tests,objects=[ins],camera_access=False,target_executed=False),indent=2)+'\n');print('3 variants/60000 combined synthetic generations; one ET_REL PASS')
if __name__=='__main__':main()
