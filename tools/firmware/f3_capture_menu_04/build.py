#!/usr/bin/env python3
import argparse,hashlib,importlib.util,json,pathlib,subprocess
ROOT=pathlib.Path(__file__).resolve().parents[3];HERE=pathlib.Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
HOST='/Library/Developer/CommandLineTools/usr/bin/clang';DUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=pathlib.Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists()and row(ZIG)['sha256']==ZSHA
 u=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';assert row(u)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 contract=json.loads((HERE/'NATIVE_CONTRACT.json').read_text());b=u.read_bytes()
 for x in contract['original_regions']:assert hashlib.sha256(b[int(x['va'],16)-0x400000:][:x['bytes']]).hexdigest()==x['sha256']
 out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  q=subprocess.run([str(x)for x in argv],cwd=ROOT,text=True,capture_output=True);item=dict(kind=kind,argv=[str(x)for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr);commands.append(item);(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,item;return q.stdout
 assert run([ZIG,'version'],'toolchain_identity').strip()=='0.15.2';sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 faults=['--submit-unknown','--submit-reject-after-prepare','--cancel-unknown','--notify-unknown','--begin-unknown','--wrong-ui-action','--completed-callback-fence']
 for variant,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer']),('tsan',['-fsanitize=thread'])]:
  flags=[HOST,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*extra];menu=out/('menu_'+variant);policy=out/('policy_'+variant)
  run([*flags,HERE/'test_menu.c',HERE/'policy.c',ROOT/'src/codec/export_geometry.c','-o',menu],'own_host_compile')
  run([*flags,'-pthread',HERE/'test_policy.c',HERE/'policy.c',ROOT/'src/codec/export_geometry.c','-o',policy],'own_host_compile')
  for exe,args in [(menu,[]),*[(menu,[str(i)])for i in range(1,19)],*[(menu,[f])for f in faults],(policy,[])]:tests.append(dict(variant=variant,args=args,program=exe.name,stdout=run([exe,*args],'own_host_synthetic_execution')))
 spec=importlib.util.spec_from_file_location('inspect_f4',ROOT/'tools/firmware/f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);objects=[]
 for source,name in [('policy.c','policy.o'),('runtime.c','menu.o'),('wrapper.S','wrapper.o')]:
  obj=out/name;flags=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
  if source.endswith('.c'):flags+=['-std=c11']
  run([ZIG,'cc',*flags,'-MMD','-MF',out/(name+'.d'),'-c',HERE/source,'-o',obj],'cross_compile_only');objects.append(m.inspect(obj));s=run([DUMP,'-dr',obj],'static_disassembly_only');(out/(name+'.asm')).write_text('\n'.join(x.rstrip()for x in s.splitlines())+'\n')
 dependencies=[ROOT/p for p in ['tools/firmware/f3_native_executor_01/SOURCE_SHA256.json','tools/firmware/f4_native_menu_03/SOURCE_SHA256.json','tools/firmware/f4_native_source_02/SOURCE_SHA256.json','tools/firmware/native_activity_01/SOURCE_SHA256.json','tools/firmware/f3_save_coordinator_06/coordinator.h']]
 report=dict(schema='iq4_f3_capture_menu_build_04',compiler=row(ZIG),original_user=row(u),source_inputs=[row(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],dependencies=[row(p)for p in dependencies],objects=objects,tests=tests,direct_linked_coordinator_consumer=True,default_production_EN0=False,actual_coordinator_ready_required=True,target_executed=False,camera_access=False,sdk_loaded=False,actual_manual_export_tested=False,actual_capture_format_tested=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(objects=[row(out/p)for p in ['policy.o','menu.o','wrapper.o']],host_runs=len(tests),camera_access=False),indent=2))
if __name__=='__main__':main()
