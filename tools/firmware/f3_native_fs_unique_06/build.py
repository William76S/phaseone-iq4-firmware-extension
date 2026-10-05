#!/usr/bin/env python3
"""Own host files/fault fixtures and one target ET_REL; never target execution."""
import argparse, difflib, hashlib, json, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve()
 assert not out.exists() and out.is_relative_to(ROOT)
 assert row(ZIG)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 original=json.loads((HERE/'ORIGINAL_INPUTS.json').read_text())
 for r in original['files']:assert row(ROOT/r['path'])==r
 out.mkdir(parents=True);commands=[];results=[]
 def run(args,kind):
  q=subprocess.run(list(map(str,args)),cwd=ROOT,text=True,capture_output=True)
  commands.append(dict(kind=kind,argv=list(map(str,args)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if q.returncode:raise RuntimeError(q.stdout+q.stderr)
  return q.stdout
 sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk').strip();assert Path(sdk).is_dir()
 assert run([ZIG,'version'],'cross_compiler_identity').strip()=='0.15.2'
 common=['-std=c11','-O2','-Wall','-Wextra','-Werror']
 for san in (False,True):
  exe=out/('unique_sanitized' if san else 'unique_normal')
  run(['/usr/bin/clang','-isysroot',sdk,*common,*(['-fsanitize=address,undefined','-fno-omit-frame-pointer'] if san else []),HERE/'fs06.c',HERE/'test_unique.c',ROOT/'tools/firmware/f3_native_fs_adapter_04/host_posix.c',ROOT/'tools/firmware/f3_stream_transaction_02/stream.c','-o',exe],'own_host_compile')
  results.append(dict(sanitized=san,result=json.loads(run([exe,out],'own_host_execute'))))
 obj=out/'fs06.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28',*common,'-g0','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-fPIC','-ffunction-sections','-fdata-sections','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',out/'fs06.d','-c',HERE/'fs06.c','-o',obj],'target_compile_only')
 run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj],'target_import_inspect');run(['/usr/bin/file',obj],'target_format_inspect')
 old=ROOT/'tools/firmware/f3_native_card_bridge_06/fs05.c'
 (out/'DELTA.diff').write_text(''.join(difflib.unified_diff(old.read_text().splitlines(True),(HERE/'fs06.c').read_text().splitlines(True),fromfile='frozen06/fs05.c',tofile='unique06/fs06.c')))
 report=dict(schema='iq4_f3_fs_unique_06_build',source=[row(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name not in ('SOURCE_SHA256.json','LINK_INPUT.json')],original_inputs=original,compiler=row(ZIG),host=results,objects=[row(obj)],target_executed=False,device_accessed=False,SDK_invoked=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(passed=True,host=results,object=row(obj))))
if __name__=='__main__':main()
