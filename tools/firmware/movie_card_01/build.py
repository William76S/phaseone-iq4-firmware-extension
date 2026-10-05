#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/movie_card_build_01';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(a):
  a=list(map(str,a));r=subprocess.run(a,cwd=ROOT,capture_output=True,text=True);commands.append(dict(argv=a,returncode=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(r.stdout+r.stderr)
 refs=['tools/firmware/f3_native_card_bridge_05/card.c','tools/firmware/f3_native_fs_adapter_04/host_posix.c','tools/firmware/f3_stream_transaction_02/stream.c','tools/firmware/f3_save_transaction_01/transaction.c','src/recording/native_mkv.c']
 for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('movie_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,HERE/'movie.c',HERE/'test_movie.c',*[ROOT/p for p in refs],'-o',exe])
  for i in range(13):run([exe,ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin',ROOT/'evidence/codec/host_encoded_samples/strided_rgb.jpg',OUT,str(i)])
 for name in ['movie','native_linux']:
  obj=OUT/(name+'.o');run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',HERE/(name+'.c'),'-o',obj]);run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);run(['/usr/bin/file',obj])
 (OUT/'BUILD.json').write_text(json.dumps(dict(schema='iq4_movie_card_build_01',commands=commands,inputs=[row(HERE/n)for n in ['movie.c','movie.h','native_linux.c','test_movie.c']]+[row(ROOT/p)for p in refs],outputs=[row(OUT/n)for n in ['COMMANDS.json','movie_normal','movie_asan_ubsan','movie.o','movie.d','native_linux.o','native_linux.d']],normal_cases=13,asan_ubsan_cases=13,real_host_files=True,card_mount_fixture=True,target_executed=False),indent=2)+'\n');print(json.dumps(dict(all_commands_passed=True,normal_cases=13,asan_ubsan_cases=13,target_executed=False)))
if __name__=='__main__':main()
