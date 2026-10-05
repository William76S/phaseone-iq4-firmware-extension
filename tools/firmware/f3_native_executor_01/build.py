#!/usr/bin/env python3
import argparse,hashlib,importlib.util,json,pathlib,subprocess
ROOT=pathlib.Path(__file__).resolve().parents[3];HERE=pathlib.Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
CC='/Library/Developer/CommandLineTools/usr/bin/clang';DUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=pathlib.Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();assert row(ZIG)['sha256']==ZSHA;out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  r=subprocess.run([str(x)for x in argv],cwd=ROOT,capture_output=True,text=True);item=dict(kind=kind,argv=[str(x)for x in argv],exit=r.returncode,stdout=r.stdout,stderr=r.stderr);commands.append(item);(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert r.returncode==0,item;return r.stdout
 assert run([ZIG,'version'],'toolchain_identity').strip()=='0.15.2';sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 for name,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer']),('tsan',['-fsanitize=thread'])]:
  common=[CC,'-isysroot',sdk,'-O2','-Wall','-Wextra','-Werror',*extra]
  activity=out/('activity_'+name+'.o');run([*common,'-std=c11','-DIQ4_ACTIVITY_SYNTHETIC_HOST','-c',ROOT/'tools/firmware/native_activity_01/activity.c','-o',activity],'own_host_compile')
  exe=out/('executor_'+name);run([*common,'-isystem',pathlib.Path(sdk)/'usr/include/c++/v1','-std=c++17','-DIQ4_F3_EXECUTOR_SYNTHETIC_HOST','-DIQ4_ACTIVITY_SYNTHETIC_HOST',HERE/'executor.cpp',HERE/'test_executor.cpp',activity,'-lc++','-o',exe],'own_host_compile');tests.append(dict(variant=name,stdout=run([exe],'own_host_synthetic_execution')))
 spec=importlib.util.spec_from_file_location('f4_inspect',ROOT/'tools/firmware/f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 objects=[]
 for source in ['executor.cpp','native_calls.cpp','wait_wrapper.S']:
  obj=out/(pathlib.Path(source).stem+'.o');cpp=source.endswith('.cpp')
  flags=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer']
  if cpp:flags+=['-std=c++17','-fexceptions']
  run([ZIG,'c++'if cpp else'cc',*flags,'-MMD','-MF',out/(obj.name+'.d'),'-c',HERE/source,'-o',obj],'cross_compile_only');objects.append(m.inspect(obj))
  dis=run([DUMP,'-dr',obj],'disassembly_only');(out/(obj.name+'.asm')).write_text('\n'.join(x.rstrip()for x in dis.splitlines())+'\n')
 (out/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f3_native_executor_build_01',compiler=row(ZIG),tests=tests,objects=objects,source_inputs=[row(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],target_executed=False,camera_access=False,sdk_loaded=False,actual_native_thread_tested=False),indent=2)+'\n');print(json.dumps({'objects':[row(out/(pathlib.Path(p).stem+'.o'))for p in ['executor.cpp','native_calls.cpp','wait_wrapper.S']],'tests':tests},indent=2))
if __name__=='__main__':main()
