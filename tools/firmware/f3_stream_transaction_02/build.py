#!/usr/bin/env python3
"""Only own host tests/host libjpeg, then cross-compile ET_REL; never execute target/SDK."""
from pathlib import Path
import subprocess,json,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_stream_transaction_build_02';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(a):
  r=subprocess.run(list(map(str,a)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(argv=list(map(str,a)),returncode=r.returncode,stdout=r.stdout,stderr=r.stderr))
  (OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(r.stderr+r.stdout)
 libs=[]
 for tag,flags,libname in [('normal',[],'libjpeg8'),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'],'libjpeg8_sanitized')]:
  exe=OUT/('test_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,HERE/'stream.c',HERE/'test_stream.c','-o',exe]);run([exe])
  lib=ROOT/('evidence/codec/build/'+libname+'/.libs/libjpeg.a');libs.append(row(lib))
  exe=OUT/('codec_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,HERE/'stream.c',HERE/'codec_bridge.c',HERE/'test_codec_bridge.c',ROOT/'src/codec/stream_rgb32.c',lib,'-o',exe]);run([exe])
 for name in ['stream','codec_bridge']:
  obj=OUT/(name+'.o');run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',HERE/(name+'.c'),'-o',obj]);run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);run(['/usr/bin/file',obj])
 inputs=[p for p in sorted(HERE.iterdir())if p.suffix in ('.c','.h','.py')]+[ROOT/'tools/firmware/f3_save_transaction_01/transaction.h',ROOT/'tools/firmware/f4_ui_bootstrap_02/sha256.h',ROOT/'src/codec/stream_rgb32.c',ROOT/'src/codec/stream_rgb32.h',ROOT/'src/codec/bounded_jpeg.h',ZIG]
 report=dict(schema='iq4_f3_stream_build_02',commands=commands,inputs=[row(p)for p in inputs],host_libraries=libs,outputs=[row(p)for p in sorted(OUT.iterdir())if p.name!='BUILD.json'],target_executed=False,sdk_executed=False,native_ports_bound=False)
 (OUT/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'all_commands_passed':True,'host_results':[c['stdout'].strip()for c in commands if c['stdout'].startswith('{')],'target_executed':False}))
if __name__=='__main__':main()
