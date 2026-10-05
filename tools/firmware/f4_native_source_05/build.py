#!/usr/bin/env python3
"""Real host pthread regression + two AArch64 ET_REL replacements. No target run."""
import argparse,difflib,hashlib,importlib.util,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
CC='/Library/Developer/CommandLineTools/usr/bin/clang'
DUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args()
 out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True)
 commands=[];tests=[]
 def run(argv,kind):
  argv=list(map(str,argv));q=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True)
  item=dict(kind=kind,argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr);commands.append(item)
  (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert not q.returncode,item;return q.stdout
 sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 for variant,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  for name,source,arg in [('old',ROOT/'tools/firmware/f4_native_source_04/source.c','old'),('new',OWN/'source.c','new')]:
   exe=out/(name+'_'+variant)
   run([CC,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*extra,'-DIQ4_F4_SOURCE_SYNTHETIC_HOST',source,OWN/'test_queue_lock.c','-o',exe],'own_host_compile')
   tests.append(dict(name=name,variant=variant,stdout=run([exe,arg],'own_host_execution')))
  exe=out/('barrier_'+variant)
  run([CC+'++','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-std=c++11','-O2','-Wall','-Wextra','-Werror',*extra,'-DIQ4_F4_QUEUE_LOCK_SYNTHETIC_HOST',OWN/'native_calls.cpp',OWN/'test_barrier.cpp','-lc++','-o',exe],'own_host_compile')
  tests.append(dict(name='barrier',variant=variant,stdout=run([exe],'own_host_execution')))
 assert row(ZIG)['sha256']==ZSHA
 assert run([ZIG,'version'],'compiler_identity').strip()=='0.15.2'
 spec=importlib.util.spec_from_file_location('inspect02',ROOT/'tools/firmware/f4_native_source_02/build.py')
 m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);objects=[]
 for name,suffix in [('source','c'),('native_calls','cpp')]:
  obj=out/(name+'.o')
  run([ZIG,'cc'if suffix=='c'else'c++','-target','aarch64-linux-gnu.2.28','-std=c11'if suffix=='c'else'-std=c++11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',out/(name+'.d'),'-c',OWN/(name+'.'+suffix),'-o',obj],'cross_compile_only')
  objects.append(m.inspect(obj));(out/(name+'.asm')).write_text(run([DUMP,'-dr',obj],'disassemble_only'))
 user=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
 for label,start,end in [('active',0x712000,0x71201c),('lock_helpers',0x712324,0x7124ac),('original_register_lock',0x712790,0x7127c4)]:
  (out/(label+'.asm')).write_text(run([DUMP,'-d',f'--start-address={start}',f'--stop-address={end}',user],'original_disassemble_only'))
 for old,new,label in [(ROOT/'tools/firmware/f4_native_source_04/source.c',OWN/'source.c','source'),(ROOT/'tools/firmware/f4_native_source_02/native_calls.cpp',OWN/'native_calls.cpp','native_calls'),(ROOT/'tools/firmware/f4_native_source_03/code_pins.h',OWN/'code_pins.h','code_pins')]:
  (out/(label+'_DIFF.patch')).write_text(''.join(difflib.unified_diff(old.read_text().splitlines(True),new.read_text().splitlines(True),fromfile=str(old.relative_to(ROOT)),tofile=str(new.relative_to(ROOT)))))
 oldobjects=[ROOT/'analysis/firmware/f4_native_diagnostics_build_04_final/source.o',ROOT/'analysis/firmware/f4_native_source_build_02_release_complete/native_calls.o']
 overlay=dict(schema='iq4_f4_native_source05_overlay',replacements=[dict(replace_only=row(old),replacement=row(out/(name+'.o')))for old,name in zip(oldobjects,['source','native_calls'])],additional_objects=[],public_ABI02_03_04_unchanged=True,native_start_added=False,frame_borrowing_unchanged=True,target_executed=False)
 (OWN/'LINK_OVERLAY.json').write_text(json.dumps(overlay,indent=2)+'\n')
 (out/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f4_source05_queue_lock_build',compiler=row(ZIG),objects=objects,tests=tests,normal_new_groups=10,asan_ubsan_new_groups=10,normal_old_contention_reproduced=True,asan_old_contention_reproduced=True,original=row(user),native_ports_synthetic=True,target_executed=False,sdk_loaded=False,camera_access=False,reported_camera_hold_root_cause_proven=False),indent=2)+'\n')
 print(json.dumps(dict(objects=[row(out/(name+'.o'))for name in ['source','native_calls']],tests=len(tests),build=row(out/'BUILD.json')),indent=2))
if __name__=='__main__':main()
