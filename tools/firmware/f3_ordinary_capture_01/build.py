#!/usr/bin/env python3
"""Generate one capture03 runtime replacement plus exact-site A64 thunks."""
from pathlib import Path
import hashlib,importlib.util,json,subprocess
ROOT=Path(__file__).resolve().parents[3];SRC=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_ordinary_capture_build_01';OLD=ROOT/'tools/firmware/f3_saved_raw_capture_03'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
s=importlib.util.spec_from_file_location('stock',ROOT/'analysis/firmware/f3_host_no_card_transfer_static_01/collect.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
def row(p):return dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=m.sha(p.read_bytes()))
def emit(p,j):p.write_text(json.dumps(j,indent=2)+'\n')
def main():
 b=m.USER.read_bytes();assert m.sha(b)==m.USER_SHA;g=m.elf_getter(b)
 original=(OLD/'runtime.cpp').read_text();manifest=json.loads((OLD/'SOURCE_SHA256.json').read_text())
 expected=next(x['sha256']for x in manifest['files']if x['path']=='tools/firmware/f3_saved_raw_capture_03/runtime.cpp');assert m.sha(original.encode())==expected
 pins=[]
 for a,z in[(0x79cd98,0x79cdc0),(0x79cf94,0x79cfa8),(0x79d13c,0x79d154),(0x79ce3c,0x79ce7c),(0x79d2e4,0x79d300),(0x7a1d30,0x7a1d84),(0x8c709c,0x8c7184),(0x8c7188,0x8c71b0),(0x8c7804,0x8c78f0),(0x8c32d8,0x8c3318),(0x8c58e8,0x8c591c),(0x411bf4,0x411c18)]:
  for va in range(a,z,64):
   n=min(64,z-va);off,data=g(va,n);pins.append(dict(va=va,bytes=n,file_offset=off,sha256=m.sha(data),hex=data.hex()))
 lines=['// Exact unmodified stock spans, excluding the four patch instructions.','struct OrdinaryPin01{uintptr_t va;size_t bytes;const unsigned char*data;};']
 for i,p in enumerate(pins):lines.append('static const unsigned char OP%d[]={%s};'%(i,','.join(str(v)for v in bytes.fromhex(p['hex']))))
 lines.append('static const OrdinaryPin01 OrdinaryPins01[]={'+','.join('{%d,%d,OP%d}'%(p['va'],p['bytes'],i)for i,p in enumerate(pins))+'};')
 (SRC/'pins.inc').write_text('\n'.join(lines)+'\n');OUT.mkdir(exist_ok=True);emit(OUT/'PINS.json',dict(stock_sha256=m.USER_SHA,regions=pins))
 source='#include "integration.inc"\n'+original
 old='cfg=*o;__atomic_store_n(&configured,1,__ATOMIC_RELEASE);return 1;';assert source.count(old)==1
 source=source.replace(old,'iq4::ordinary_capture_01::Memory om{o->common.memory.context,o->common.memory.read};\n if(!iq4::ordinary_capture_01::original_prefixes(om))return 0;ordinary_memory01=om;\n '+old)
 old='uintptr_t actual=0;if(!twice(manager+0x48,&actual,8)||actual!=node)return;';assert source.count(old)==1
 source=source.replace(old,old+'\n if(!ordinary_guard01.consume(ordinary_memory01,manager,node))return;')
 (SRC/'runtime.cpp').write_text('// Generated from the frozen capture03 runtime; see build.py.\n'+source)
 aliases=[('iq4_f3_original_calibration_enqueue_01',0x8c58e8,0x34),('iq4_f3_original_node_reset_01',0x8c32d8,0x100),('iq4_f3_original_queue_guard_release_01',0x411bf4,0x24)]
 bindings=[]
 for symbol,va,n in aliases:off,data=g(va,n);bindings.append(dict(symbol=symbol,va=va,bytes=n,sha256=m.sha(data),hex=data.hex()))
 hooks=[]
 for va,symbol,target in[(0x79d300,'iq4_f3_ordinary_enqueue_thunk_01',0x8c58e8),(0x8c7184,'iq4_f3_ordinary_queue_unlock_thunk_01',0x411bf4),(0x8c5844,'iq4_f3_ordinary_node_reset_wrapper_01',0x8c32d8),(0x8c5c54,'iq4_f3_ordinary_node_reset_wrapper_01',0x8c32d8)]:
  off,data=g(va,4);hooks.append(dict(va=va,kind='BL',target_symbol=symbol,original_target=target,old_hex=data.hex()))
 emit(SRC/'ORIGINAL_BINDINGS.json',dict(schema='iq4_f3_ordinary_capture_bindings_01',input_sha256=m.USER_SHA,bindings=bindings,hooks=hooks,target_executed=False))
 commands=[]
 def run(argv,label):
  a=list(map(str,argv));r=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);commands.append(dict(label=label,argv=a,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));emit(OUT/'COMMANDS.json',commands)
  if r.returncode:raise RuntimeError(label+': '+r.stderr+r.stdout)
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_guard_'+tag);run(['/usr/bin/clang++','-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror',*flags,SRC/'test_guard.cpp','-o',exe],'host_compile_'+tag);run([exe],'host_test_'+tag)
 for name,suffix in [('runtime','cpp'),('enqueue_thunk','S')]:
  argv=[ZIG,'c++'if suffix=='cpp'else'cc','-target','aarch64-linux-gnu.2.28','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror']
  if suffix=='cpp':argv+=['-std=c++17','-I',OLD]
  run(argv+['-MMD','-MF',OUT/(name+'.d'),'-c',SRC/(name+'.'+suffix),'-o',OUT/(name+'.o')],'target_compile_'+name)
  run([m.NM,'-u',OUT/(name+'.o')],'target_undefined_'+name)
  run([m.OBJDUMP,'-r','-t',OUT/(name+'.o')],'target_relocs_'+name)
 emit(OUT/'BUILD.json',dict(schema='iq4_f3_ordinary_capture_build_01',source_runtime=row(OLD/'runtime.cpp'),stock_sha256=m.USER_SHA,commands=commands,target_executed=False,host_fixture_only=True))
 emit(SRC/'LINK_OVERLAY.json',dict(schema='iq4_f3_ordinary_capture_overlay_01',replacements=[dict(replace_only=row(ROOT/'analysis/firmware/f3_saved_raw_capture_build_03/runtime.o'),replacement=row(OUT/'runtime.o'))],additional_objects=[row(OUT/'enqueue_thunk.o')],original_bindings=row(SRC/'ORIGINAL_BINDINGS.json'),target_executed=False))
 print(json.dumps(dict(runtime=row(OUT/'runtime.o'),thunk=row(OUT/'enqueue_thunk.o'),host_tests_passed=True,target_executed=False)))
if __name__=='__main__':main()
