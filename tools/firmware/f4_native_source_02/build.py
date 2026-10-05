#!/usr/bin/env python3
"""Synthetic host faults/concurrency + AArch64 ET_REL; no target execution."""
import argparse,hashlib,json,struct,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
MENU=ROOT/'tools/firmware/f4_native_menu_03'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
CC='/Library/Developer/CommandLineTools/usr/bin/clang'
OBJDUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=hashlib.sha256(p.read_bytes()).hexdigest())
def inspect(p):
 b=p.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',b)
 assert h[0][:6]==b'\x7fELF\x02\x01'and h[1:3]==(1,183)
 ss=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11])for i in range(h[12])]
 namesec=ss[h[13]];names=b[namesec[4]:namesec[4]+namesec[5]]
 def name(i):return names[i:names.index(b'\0',i)].decode()
 assert not any(s[2]&0x400 or s[1]==6 for s in ss),'no native TLS or dynamic ELF'
 undefined=[];relocs=set();allocated=[]
 for s in ss:
  if s[2]&2:allocated.append(dict(name=name(s[0]),type=s[1],flags=s[2],bytes=s[5]))
  if s[1]==4:
   for off in range(s[4],s[4]+s[5],s[9]):relocs.add(struct.unpack_from('<QQq',b,off)[1]&0xffffffff)
  if s[1]==2:
   st=ss[s[6]];strings=b[st[4]:st[4]+st[5]]
   for off in range(s[4],s[4]+s[5],s[9]):
    n,_,_,index,_,_=struct.unpack_from('<IBBHQQ',b,off)
    if n and not index:undefined.append(strings[n:strings.index(b'\0',n)].decode())
 assert '.eh_frame' in [s['name']for s in allocated],'preserve synchronous unwind'
 assert not any('std::__1' in n or 'St3__1' in n for n in undefined)
 return dict(**row(p),type='ET_REL',machine=183,alloc_sections=allocated,relocation_types=sorted(relocs),undefined_symbols=sorted(set(undefined)),executed=False)
def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args();out=a.output.resolve()
 if out.exists()or not out.is_relative_to(ROOT):raise ValueError('fresh project output required')
 assert row(ZIG)['sha256']==ZSHA;out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  r=subprocess.run([str(x)for x in argv],cwd=ROOT,capture_output=True,text=True)
  item=dict(kind=kind,argv=[str(x)for x in argv],exit=r.returncode,stdout=r.stdout,stderr=r.stderr);commands.append(item)
  (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(json.dumps(item,indent=2))
  return r.stdout
 assert run([ZIG,'version'],'compiler_identity').strip()=='0.15.2'
 sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 flags=['-std=c11','-O2','-Wall','-Wextra','-Werror','-DIQ4_JPEG_API_VERSION=82']
 for variant,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer']),('tsan',['-fsanitize=thread'])]:
  groups=[('source',[OWN/'source.c',OWN/'test_source.c'],['-DIQ4_F4_SOURCE_SYNTHETIC_HOST'],[[]]),
   ('session',[OWN/'session.c',OWN/'test_session.c'],[],[[str(i)]for i in range(10)])]
  if variant!='tsan':groups+=[('worker',[OWN/'worker.c',OWN/'test_worker.c'],[],[[]]),('menu',[MENU/'menu.c',MENU/'test_menu.c'],[],[[],['heap-failure']]),('movie_binding',[OWN/'movie_binding.c',OWN/'test_movie_binding.c'],[],[[]])]
  for name,sources,defines,args in groups:
   exe=out/(name+'_'+variant);run([CC,'-isysroot',sdk,*flags,*extra,*defines,*sources,'-o',exe],'own_host_compile')
   for argv in args:tests.append(dict(name=name,variant=variant,args=argv,stdout=run([exe,*argv],'own_host_synthetic_execution')))
  if variant!='tsan':
   exe=out/('pop_passthrough_'+variant)
   run([CC,'-isysroot',sdk,'-std=c++11','-O2','-Wall','-Wextra','-Werror',*extra,'-DIQ4_F4_MENU_POP_SYNTHETIC_HOST',MENU/'native_calls.cpp',MENU/'test_pop_passthrough.cpp','-lc++','-o',exe],'own_host_compile')
   tests.append(dict(name='pop_passthrough',variant=variant,args=[],stdout=run([exe],'own_host_synthetic_execution')))
 target=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-Wall','-Wextra','-Werror','-DIQ4_JPEG_API_VERSION=82','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables']
 objects=[]
 for source,name in [(OWN/'source.c','source.o'),(OWN/'native_calls.cpp','native_calls.o'),(OWN/'worker.c','worker.o'),(OWN/'session.c','session.o'),(OWN/'thread_calls.cpp','thread_calls.o'),(OWN/'movie_binding.c','movie_binding.o'),(OWN/'entry.c','entry.o'),(MENU/'menu.c','menu.o'),(MENU/'native_calls.cpp','menu_native_calls.o')]:
  cpp=source.suffix=='.cpp';obj=out/name
  run([ZIG,'c++'if cpp else'cc',*target,'-std=c++11'if cpp else'-std=c11','-MMD','-MF',out/(name+'.d'),'-c',source,'-o',obj],'cross_compile_only')
  objects.append(inspect(obj));run([OBJDUMP,'-dr',obj],'target_disassembly_only')
 deps={p for p in OWN.glob('*')if p.is_file()and p.suffix in {'.h','.c','.cpp','.py'}}|{p for p in MENU.glob('*')if p.is_file()and p.suffix in {'.h','.c','.cpp','.py'}}
 dependency_sources=[]
 for rel in ['tools/firmware/f3_native_jpeg8_binding_01/SOURCE_SHA256.json','tools/firmware/f3_native_card_bridge_06/SOURCE_SHA256.json','tools/firmware/movie_card_01/SOURCE_SHA256.json','src/codec/bounded_jpeg.c','src/codec/bounded_jpeg.h','src/recording/native_mkv.c','src/recording/native_mkv.h','tools/firmware/native_runtime_01/self_read.c','tools/firmware/native_runtime_01/self_read.h']:
  dependency_sources.append(row(ROOT/rel))
 report=dict(schema='iq4_f4_native_source_menu_build_02',compiler=row(ZIG),source_inputs=[row(p)for p in sorted(deps)],dependencies=dependency_sources,tests=tests,objects=objects,
  target_executed=False,sdk_loaded=False,camera_access=False,actual_recording_tested=False,hardware_modes_verified=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(objects=len(objects),test_runs=len(tests),build=row(out/'BUILD.json')),indent=2))
if __name__=='__main__':main()
