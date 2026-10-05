#!/usr/bin/env python3
"""Own real local temporary files/host tests + target compile only."""
from pathlib import Path
import subprocess,hashlib,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_fs_adapter_build_04';ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(a):
  r=subprocess.run(list(map(str,a)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(argv=list(map(str,a)),returncode=r.returncode,stdout=r.stdout,stderr=r.stderr));(OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(r.stdout+r.stderr)
 for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=OUT/('files_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,HERE/'fs.c',HERE/'host_posix.c',HERE/'test_files.c',ROOT/'tools/firmware/f3_stream_transaction_02/stream.c','-o',exe]);run([exe,OUT])
  exe=OUT/('guard_'+tag);run(['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags,HERE/'owner_guard.c',HERE/'test_guard.c','-o',exe]);run([exe])
 for name in ['fs','owner_guard','native_linux']:
  obj=OUT/(name+'.o');run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',HERE/(name+'.c'),'-o',obj]);run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);run(['/usr/bin/file',obj])
 files=[p for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json']
 report=dict(schema='iq4_f3_native_fs_build_04',commands=commands,inputs=[row(p)for p in files]+[row(ZIG)],outputs=[row(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='BUILD.json'],device_ports_invoked=False,target_executed=False,actual_camera_card_epoch_not_observed=True)
 (OUT/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'all_commands_passed':True,'host_results':[c['stdout'].strip()for c in commands if c['stdout'].startswith('{')],'target_executed':False}))
if __name__=='__main__':main()
