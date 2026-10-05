#!/usr/bin/env python3
"""Own host fault fixtures and target compile only; never load original ELF."""
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];SRC=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_saved_raw_capture_build_03';STATIC=ROOT/'analysis/firmware/f3_saved_raw_capture_static_03'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
USHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 b=USER.read_bytes();assert len(b)==11874544 and sha(b)==USHA
 assert sha(ZIG.read_bytes())=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);ph=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])]
 def raw(v,n):
  r=[b[o+v-a:o+v-a+n]for t,f,o,a,pa,fs,ms,al in ph if t==1 and a<=v and v+n<=a+fs];assert len(r)==1;return r[0]
 native=json.loads((ROOT/'tools/firmware/f3_saved_raw_capture_01/ORIGINAL_BINDINGS.json').read_text())['bindings']
 for name,v,n in [('iq4_f3_original_file_close_capture_03',0x82580c,96),('iq4_f3_original_file_dtor_capture_03',0x8257b4,48),('iq4_f3_original_xqd_store_capture_03',0x8df19c,0x824),('iq4_f3_original_fanout_select_capture_03',0x8dc278,0x184),('iq4_f3_original_fanout_refs_capture_03',0x8c5cdc,64)]:native.append(dict(symbol=name,va=v,bytes=n,sha256=sha(raw(v,n)),hex=raw(v,n).hex()))
 pins=[(v,64)for v in [0x825724,0x7d8a38,0x82580c,0x8257b4,0x825ed4,0x8dcf98,0x8df19c,0x8dc278,0x8c5cdc,0xdbc6b8,0xdbc280,0xd90410,0xd91450]]+[(0x40b1d0,16),(0x40ae40,16)]
 s=['struct CapturePin03{uintptr_t va;size_t bytes;const unsigned char*data;};']
 for i,(v,n)in enumerate(pins):s.append('static const unsigned char CapturePin%d[]={%s};'%(i,','.join('0x%02x'%x for x in raw(v,n))))
 s.append('static const CapturePin03 CapturePins03[]={'+','.join('{0x%x,%d,CapturePin%d}'%(v,n,i)for i,(v,n)in enumerate(pins))+'};')
 (SRC/'capture_pins.inc').write_text('\n'.join(s)+'\n')
 hooks=[(0x8dc4c0,'B','iq4_f3_raw_acquired_wrapper_01',None),(0x8e0618,'BL','iq4_f3_sd_store_wrapper_01',None),(0x7d8994,'BL','iq4_f3_raw_open_wrapper_01',None),(0x8dd440,'BL','iq4_f3_raw_close_wrapper_01',0x7d8a38),(0x8df038,'BL','iq4_f3_xqd_store_wrapper_03',0x8df19c),(0x8df6b8,'BL','iq4_f3_xqd_open_wrapper_03',None),(0x8df8e8,'BL','iq4_f3_xqd_dtor_wrapper_03',0x8257b4),(0x8df940,'BL','iq4_f3_xqd_dtor_wrapper_03',0x8257b4),(0x8dc4ec,'BL','iq4_f3_fanout_select_wrapper_03',0x8dc278),(0x8dc634,'BL','iq4_f3_fanout_refs_wrapper_03',0x8c5cdc)]
 rows=[]
 for v,k,s,t in hooks:
  r=dict(va=v,kind=k,target_symbol=s,old_hex=raw(v,4).hex())
  if t is not None:r['original_target']=t
  rows.append(r)
 (SRC/'ORIGINAL_BINDINGS.json').write_text(json.dumps(dict(schema='iq4_f3_saved_raw_capture_native_03',input_sha256=USHA,input_bytes=len(b),bindings=native,hooks=rows,target_executed=False),indent=2)+'\n')
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'host_files').mkdir(exist_ok=True);commands=[]
 sdk=subprocess.check_output(['/usr/bin/xcrun','--sdk','macosx','--show-sdk-path'],text=True).strip()
 def run(a,label):
  a=list(map(str,a));r=subprocess.run(a,cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=a,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(label+': '+r.stderr+r.stdout)
 for tag,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_capture_'+tag)
  run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*extra,SRC/'test_capture.c',SRC/'capture.c',ROOT/'tools/firmware/f3_native_fs_adapter_04/host_posix.c',ROOT/'tools/firmware/native_activity_01/activity.c','-o',exe],'compile_core_'+tag)
  for card in (10,11):
   for case in range(13):run([exe,OUT/'host_files',case,card],f'core_{tag}_card{card}_{case}')
  objs=[]
  for label,p in [('core',SRC/'capture.c'),('posix',ROOT/'tools/firmware/f3_native_fs_adapter_04/host_posix.c'),('activity',ROOT/'tools/firmware/native_activity_01/activity.c')]:
   out=OUT/(label+'_'+tag+'.host.o');run(['/usr/bin/clang','-std=c11','-O1',*extra,'-c',p,'-o',out],f'compile_runtime_dependency_{label}_{tag}');objs.append(out)
  exe=OUT/('test_runtime_'+tag);run(['/usr/bin/clang++','-std=c++17','-isysroot',sdk,'-isystem',Path(sdk)/'usr/include/c++/v1','-O1','-Wall','-Wextra','-Werror',*extra,SRC/'test_runtime.cpp',*objs,'-o',exe],'compile_runtime_'+tag)
  for case in range(10):run([exe,OUT/'host_files',case],f'runtime_{tag}_{case}')
 for name,suf in [('capture','c'),('runtime','cpp'),('native_factory','cpp')]:
  run([ZIG,'c++'if suf=='cpp'else'cc','-target','aarch64-linux-gnu.2.28','-std=c++17'if suf=='cpp'else'-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',SRC/(name+'.'+suf),'-o',OUT/(name+'.o')],'compile_target_'+name)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/(name+'.o')],'inspect_U_'+name)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t',OUT/(name+'.o')],'inspect_relocs_'+name)
 artifacts=[dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=sha(p.read_bytes()))for p in sorted(OUT.iterdir())if p.is_file()and p.name!='BUILD.json']
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f3_saved_raw_capture_build_03',commands=commands,artifacts=artifacts,host_core_cases_each=26,host_runtime_cases_each=10,target_objects=3,target_executed=False,sdk_loaded=False,device_connected=False),indent=2)+'\n')
 print(json.dumps(dict(host_normal=36,host_asan_ubsan=36,target_objects=3,all_commands_passed=True,target_executed=False)))
if __name__=='__main__':main()
