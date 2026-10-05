#!/usr/bin/env python3
"""Own real-host files/faults and five AArch64 objects; never run target/SDK."""
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];SRC=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_saved_raw_capture_build_01'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
USHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
 b=USER.read_bytes();assert len(b)==11874544 and sha(b)==USHA
 assert sha(ZIG.read_bytes())=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);ph=[struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])for i in range(h[10])]
 def raw(v,n):
  r=[b[o+v-a:o+v-a+n]for t,f,o,a,pa,fs,ms,al in ph if t==1 and a<=v and v+n<=a+fs];assert len(r)==1;return r[0]
 native={'iq4_f3_original_file_bind_capture_01':(0x825724,76),'iq4_f3_original_writer_close_capture_01':(0x7d8a38,64),
  'iq4_f3_original_pthread_self_capture_01':(0x40b1d0,16),'iq4_f3_raw_acquired_continue_01':(0x8dc4c4,4),
  'iq4_f3_original_syscall_03':(0x40ae40,16),'iq4_f3_original_errno_location_03':(0x40a4e0,16)}
 pins=[(0x825724,64),(0x7d8a38,64),(0x40b1d0,16),(0x825ed4,64),(0x8dcf98,64),(0xdbc6b8,64),(0xd90410,64),(0xd91450,64)]
 text=['struct CapturePin01 {uintptr_t va;size_t bytes;const unsigned char*data;};']
 for i,(va,n)in enumerate(pins):text.append('static const unsigned char CapturePin%d[]={%s};'%(i,','.join('0x%02x'%x for x in raw(va,n))))
 text.append('static const CapturePin01 CapturePins01[]={'+','.join('{0x%x,%d,CapturePin%d}'%(v,n,i)for i,(v,n)in enumerate(pins))+'};')
 (SRC/'capture_pins.inc').write_text('\n'.join(text)+'\n')
 hooks=[(0x8dc4c0,'B','iq4_f3_raw_acquired_wrapper_01'),(0x8e0618,'BL','iq4_f3_sd_store_wrapper_01'),(0x7d8994,'BL','iq4_f3_raw_open_wrapper_01'),(0x8dd440,'BL','iq4_f3_raw_close_wrapper_01')]
 bind=dict(schema='iq4_f3_saved_raw_capture_native_01',input_sha256=USHA,input_bytes=len(b),bindings=[dict(symbol=k,va=v,bytes=n,sha256=sha(raw(v,n)),hex=raw(v,n).hex())for k,(v,n)in native.items()],hooks=[dict(va=v,branch_kind=k,target_symbol=s,old_hex=raw(v,4).hex())for v,k,s in hooks],target_executed=False)
 (SRC/'ORIGINAL_BINDINGS.json').write_text(json.dumps(bind,indent=2)+'\n')
 OUT.mkdir(parents=True,exist_ok=True);(OUT/'host_files').mkdir(exist_ok=True);commands=[]
 def run(a,label):
  a=list(map(str,a));r=subprocess.run(a,cwd=ROOT,capture_output=True,text=True);commands.append(dict(label=label,argv=a,exit_code=r.returncode,stdout=r.stdout,stderr=r.stderr))
  (OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(label+': '+r.stderr)
 for tag,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('test_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*extra,SRC/'test_capture.c',SRC/'capture.c',ROOT/'tools/firmware/f3_native_fs_adapter_04/host_posix.c',ROOT/'tools/firmware/native_activity_01/activity.c','-o',exe],'compile_host_'+tag)
  for case in range(13):run([exe,OUT/'host_files',case],f'host_{tag}_{case}')
 for name,suf in [('capture','c'),('directories_linux','c'),('runtime','cpp'),('acquired_wrapper','S'),('native_factory','cpp')]:
  run([ZIG,'c++'if suf=='cpp'else'cc','-target','aarch64-linux-gnu.2.28','-std=c++17'if suf=='cpp'else'-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',SRC/(name+'.'+suf),'-o',OUT/(name+'.o')],'compile_target_'+name)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',OUT/(name+'.o')],'inspect_U_'+name)
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-r','-t',OUT/(name+'.o')],'inspect_relocs_'+name)
 artifacts=[dict(path=p.relative_to(ROOT).as_posix(),bytes=p.stat().st_size,sha256=sha(p.read_bytes()))for p in sorted(OUT.iterdir())if p.is_file()and p.name!='BUILD.json']
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f3_saved_raw_capture_build_01',commands=commands,artifacts=artifacts,host_fault_cases_each=13,target_objects=5,target_executed=False,sdk_loaded=False,device_connected=False),indent=2)+'\n')
 print(json.dumps(dict(host_normal=13,host_asan_ubsan=13,target_objects=5,all_commands_passed=True,target_executed=False)))
if __name__=='__main__':main()
