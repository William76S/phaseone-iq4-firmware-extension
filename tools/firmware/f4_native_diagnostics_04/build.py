#!/usr/bin/env python3
"""Four replacement ET_REL objects + own host fixtures; no target/SDK launch."""
import argparse,difflib,hashlib,importlib.util,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent;T=ROOT/'tools/firmware'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c';CC='/Library/Developer/CommandLineTools/usr/bin/clang';DUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
def row(p):b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();assert row(ZIG)['sha256']==ZSHA;out.mkdir(parents=True);cmd=[];tests=[]
 def run(argv,kind):
  q=subprocess.run([str(x)for x in argv],cwd=ROOT,text=True,capture_output=True);r=dict(kind=kind,argv=[str(x)for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr);cmd.append(r);(out/'COMMANDS.json').write_text(json.dumps(cmd,indent=2)+'\n');assert q.returncode==0,r;return q.stdout
 assert run([ZIG,'version'],'compiler_identity').strip()=='0.15.2';sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 configs=[('source',T/'f4_native_source_04',[T/'f4_native_source_04/source.c',T/'f4_native_source_04/test_source.c'],['-DIQ4_F4_SOURCE_SYNTHETIC_HOST'],[[]]),
 ('session',T/'f4_native_session_04',[T/'f4_native_session_04/session.c',T/'f4_native_session_04/test_session.c'],[],[[str(x)]for x in range(10)]),
 ('entry',T/'f4_native_entry_04',[T/'f4_native_entry_04/test_entry.c',T/'native_activity_01/activity.c'],[],[[x]for x in ['normal','jpeg-busy','alloc-unknown','init-unknown','control-unknown','read-unknown','session-hold','idle-with-card','idle-no-fence','source-fence-unknown','empty-cancel']]),
 ('menu',T/'f4_native_menu_04',[T/'f4_native_menu_04/menu.c',T/'f4_native_menu_04/test_menu.c'],[],[[],['heap-failure']])]
 for variant,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  for name,own,files,defs,args in configs:
   exe=out/(name+'_'+variant);run([CC,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*extra,*defs,*files,'-o',exe],'own_host_compile')
   for argv in args:tests.append(dict(name=name,variant=variant,args=argv,stdout=run([exe,*argv],'own_host_execution')))
 spec=importlib.util.spec_from_file_location('oldinspect',T/'f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);objects=[]
 for name,own,_,_,_ in configs:
  obj=out/(name+'.o');run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',out/(name+'.d'),'-c',own/(name+'.c'),'-o',obj],'cross_compile_only');objects.append(m.inspect(obj));dis=run([DUMP,'-dr',obj],'disassemble_only');(out/(name+'.asm')).write_text(dis)
 old=[T/'f4_native_source_03/source.c',T/'f4_native_source_02/session.c',T/'f4_native_entry_03/entry.c',T/'f4_native_menu_03/menu.c']
 for (name,own,*_),previous in zip(configs,old):(out/(name+'_DIFF.patch')).write_text(''.join(difflib.unified_diff(previous.read_text().splitlines(True),(own/(name+'.c')).read_text().splitlines(True),fromfile=str(previous.relative_to(ROOT)),tofile=str((own/(name+'.c')).relative_to(ROOT)))))
 report=dict(schema='iq4_f4_native_diagnostics04_build',compiler=row(ZIG),objects=objects,tests=tests,old_source_lineage=[row(p)for p in old],ABI02_03_preserved=True,native_start_added=False,target_executed=False,sdk_loaded=False,camera_access=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(objects=[row(out/(c[0]+'.o'))for c in configs],host_runs=len(tests),target_executed=False),indent=2))
if __name__=='__main__':main()
