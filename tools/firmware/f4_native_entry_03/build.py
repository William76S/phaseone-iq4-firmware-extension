#!/usr/bin/env python3
import argparse,difflib,hashlib,importlib.util,json,pathlib,subprocess
ROOT=pathlib.Path(__file__).resolve().parents[3];HERE=pathlib.Path(__file__).resolve().parent;OLD=ROOT/'tools/firmware/f4_native_source_02'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c';CC='/Library/Developer/CommandLineTools/usr/bin/clang'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=pathlib.Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists()and row(ZIG)['sha256']==ZSHA;out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  q=subprocess.run([str(x)for x in argv],cwd=ROOT,text=True,capture_output=True);item=dict(kind=kind,argv=[str(x)for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr);commands.append(item);(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,item;return q.stdout
 assert run([ZIG,'version'],'toolchain_identity').strip()=='0.15.2';sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 cases=['normal','jpeg-busy','alloc-unknown','init-unknown','control-unknown','read-unknown','session-hold','idle-with-card','idle-no-fence','source-fence-unknown','empty-cancel']
 for variant,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer']),('tsan',['-fsanitize=thread'])]:
  exe=out/('entry_'+variant);run([CC,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*extra,HERE/'test_entry.c',ROOT/'tools/firmware/native_activity_01/activity.c','-o',exe],'own_host_compile')
  for case in cases:tests.append(dict(variant=variant,case=case,stdout=run([exe,case],'own_host_synthetic_execution')))
 spec=importlib.util.spec_from_file_location('inspect_f4',OLD/'build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 obj=out/'entry.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',out/'entry.o.d','-c',HERE/'entry.c','-o',obj],'cross_compile_only');ins=m.inspect(obj)
 s=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj],'static_disassembly_only');(out/'entry.o.asm').write_text('\n'.join(x.rstrip()for x in s.splitlines())+'\n')
 (out/'SOURCE_DIFF.patch').write_text(''.join(difflib.unified_diff((OLD/'entry.c').read_text().splitlines(keepends=True),(HERE/'entry.c').read_text().splitlines(keepends=True),fromfile='frozen_source02/entry.c',tofile='new_entry03/entry.c')))
 frozen=[OLD/'entry.c',OLD/'SOURCE_SHA256.json',OLD/'LINK_INPUT.json',ROOT/'tools/firmware/native_activity_01/SOURCE_SHA256.json']
 report=dict(schema='iq4_f4_native_entry_build_03',source_inputs=[row(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],frozen_compatibility_inputs=[row(p)for p in frozen],objects=[ins],tests=tests,ABI02_preserved=True,only_entry_object_replaced=True,camera_access=False,target_executed=False,sdk_loaded=False,actual_activity_acceptance=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(object=row(obj),host_runs=len(tests),target_executed=False),indent=2))
if __name__=='__main__':main()
