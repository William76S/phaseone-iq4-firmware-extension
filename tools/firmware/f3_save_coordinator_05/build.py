#!/usr/bin/env python3
from pathlib import Path
import json,hashlib,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_save_coordinator_build_05';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(a):
  a=list(map(str,a));r=subprocess.run(a,cwd=ROOT,capture_output=True,text=True);commands.append(dict(argv=a,returncode=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(r.stdout+r.stderr)
 refs=['tools/firmware/f3_native_card_bridge_05/card.c','tools/firmware/f3_native_card_bridge_05/fs05.c','tools/firmware/f3_native_fs_adapter_04/host_posix.c','tools/firmware/f3_stream_transaction_02/stream.c','tools/firmware/f3_stream_transaction_02/codec_bridge.c','tools/firmware/f3_render_plan_01/native_render_adapter.c','tools/firmware/f3_render_plan_01/render_plan.c','src/codec/stream_rgb32.c']
 for tag,flags,lib in [('normal',[],'libjpeg8'),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'],'libjpeg8_sanitized')]:
  exe=OUT/('coordinator_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,HERE/'coordinator.c',HERE/'test_coordinator.c',*[ROOT/p for p in refs],ROOT/f'evidence/codec/build/{lib}/.libs/libjpeg.a','-o',exe])
  for i in range(10):run([exe,ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin',OUT,str(i)])
 obj=OUT/'coordinator.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/'coordinator.d','-c',HERE/'coordinator.c','-o',obj]);run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);run(['/usr/bin/file',obj])
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_f3_save_coordinator_build_05',commands=commands,inputs=[row(HERE/n)for n in ['coordinator.c','coordinator.h','test_coordinator.c']]+[row(ROOT/p)for p in refs],outputs=[row(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='BUILD.json'],normal_cases=10,asan_ubsan_cases=10,real_host_codec_and_files=True,vendor_ops_fixture=True,target_executed=False),indent=2)+'\n');print(json.dumps(dict(all_commands_passed=True,normal_cases=10,asan_ubsan_cases=10,target_executed=False)))
if __name__=='__main__':main()
