#!/usr/bin/env python3
"""Own host fixtures/real host files and AArch64 compile only. Never run target."""
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f3_native_card_bridge_build_05'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
RAW=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 assert hashlib.sha256(RAW.read_bytes()).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 OUT.mkdir(parents=True,exist_ok=True);commands=[]
 def run(a):
  a=list(map(str,a));r=subprocess.run(a,cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(argv=a,returncode=r.returncode,stdout=r.stdout,stderr=r.stderr))
  (OUT/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if r.returncode:raise RuntimeError(r.stdout+r.stderr)
 for tag,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  common=['/usr/bin/clang','-std=c11','-O1','-Wall','-Wextra','-Werror',*flags]
  exe=OUT/('card_'+tag);run([*common,HERE/'card.c',HERE/'test_card.c','-o',exe])
  for case in range(13):run([exe,RAW,str(case)])
  exe=OUT/('fdinfo_'+tag);run([*common,HERE/'fdinfo.c',HERE/'test_fdinfo.c','-o',exe]);run([exe])
  exe=OUT/('manual_'+tag);run([*common,HERE/'fs05.c',ROOT/'tools/firmware/f3_native_fs_adapter_04/host_posix.c',ROOT/'tools/firmware/f3_stream_transaction_02/stream.c',HERE/'test_manual.c','-o',exe]);run([exe,OUT])
 for name in ['card','fdinfo','card_linux','fs05','native_calls']:
  cpp=name=='native_calls';obj=OUT/(name+'.o')
  run([ZIG,'c++'if cpp else'cc','-target','aarch64-linux-gnu.2.28','-std=c++17'if cpp else'-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror','-MMD','-MF',OUT/(name+'.d'),'-c',HERE/(name+('.cpp'if cpp else'.c')),'-o',obj])
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj]);run(['/usr/bin/file',obj])
 inputs=[p for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json']
 report=dict(schema='iq4_f3_native_card_bridge_build_05',commands=commands,inputs=[row(p)for p in inputs]+[row(RAW),row(ZIG)],outputs=[row(p)for p in sorted(OUT.iterdir())if p.is_file()and p.name!='BUILD.json'],host_fixture_card_fault_cases=13,host_fdinfo_parser_groups=12,real_host_manual_file_groups=9,target_executed=False,vendor_native_calls_executed=False,physical_hotplug_not_proven=True)
 (OUT/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(dict(all_commands_passed=True,commands=len(commands),host_fixture_cases_each=13,fdinfo_groups_each=12,manual_real_files_each=9,target_executed=False)))
if __name__=='__main__':main()
