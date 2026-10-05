#!/usr/bin/env python3
"""Only replacement source.o; original eight objects/interfaces stay frozen."""
import argparse,hashlib,importlib.util,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
OLD=ROOT/'tools/firmware/f4_native_source_02';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
CC='/Library/Developer/CommandLineTools/usr/bin/clang';OBJDUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();assert row(ZIG)['sha256']==ZSHA;out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  r=subprocess.run([str(x)for x in argv],cwd=ROOT,capture_output=True,text=True);item=dict(kind=kind,argv=[str(x)for x in argv],exit=r.returncode,stdout=r.stdout,stderr=r.stderr);commands.append(item);(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert r.returncode==0,item;return r.stdout
 assert run([ZIG,'version'],'toolchain_identity').strip()=='0.15.2';sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 for name,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer']),('tsan',['-fsanitize=thread'])]:
  exe=out/('source_'+name);run([CC,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*extra,'-DIQ4_F4_SOURCE_SYNTHETIC_HOST',OWN/'source.c',OWN/'test_source.c','-o',exe],'own_host_compile');tests.append(dict(variant=name,stdout=run([exe],'own_host_synthetic_execution')))
 obj=out/'source.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-std=c11','-MMD','-MF',out/'source.o.d','-c',OWN/'source.c','-o',obj],'cross_compile_only')
 spec=importlib.util.spec_from_file_location('f4_source02_build',OLD/'build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);inspection=m.inspect(obj)
 dis=run([OBJDUMP,'-dr',obj],'disassembly_only');(out/'source.o.asm').write_text('\n'.join(x.rstrip()for x in dis.splitlines())+'\n')
 old=(OLD/'source.c').read_text().splitlines(True);new=(OWN/'source.c').read_text().splitlines(True);import difflib;(out/'SOURCE_DIFF.patch').write_text(''.join(difflib.unified_diff(old,new,fromfile='f4_native_source_02/source.c',tofile='f4_native_source_03/source.c')))
 report=dict(schema='iq4_f4_native_source_build_03',compiler=row(ZIG),source_inputs=[row(p)for p in sorted(OWN.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],frozen_compatibility_inputs=[row(OLD/x)for x in ['SOURCE_SHA256.json','source.c','source.h','native_calls.h','code_pins.h','test_source.c','build.py','LINK_INPUT.json']],tests=tests,objects=[inspection],original_other_eight_objects_unchanged=True,API02_unchanged=True,target_executed=False,camera_access=False,actual_color_tested=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(object=row(obj),build=row(out/'BUILD.json'),test_runs=3),indent=2))
if __name__=='__main__':main()
