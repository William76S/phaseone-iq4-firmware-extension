#!/usr/bin/env python3
"""Check native LV stop cleanup independently of frame delivery; host only."""
from pathlib import Path
import argparse,hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent

def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True);commands=[]
 def run(argv,ok=True):
  argv=list(map(str,argv));q=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True);commands.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert(q.returncode==0)==ok,commands[-1];return q.stdout.strip()
 sdk=run(['/usr/bin/xcrun','--show-sdk-path']);cc='/Library/Developer/CommandLineTools/usr/bin/clang';common=[cc,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror']
 exe=out/'old_session';run([*common,ROOT/'tools/firmware/f4_native_session_05/session.c',HERE/'test_session.c','-o',exe])
 for i in range(14,17):run([exe,i],False)
 for name,flags in [('normal',[]),('san',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=out/('session_'+name);run([*common,*flags,HERE/'session.c',HERE/'test_session.c','-o',exe])
  for i in range(17):run([exe,i])
  exe=out/('source_'+name);run([*common,*flags,'-DIQ4_F4_SOURCE_SYNTHETIC_HOST',HERE/'source.c',HERE/'test_source.c','-o',exe]);run([exe])
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert row(zig)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c';objects=[]
 for name in ['source','session']:
  obj=out/(name+'.o');run([zig,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',out/(name+'.d'),'-c',HERE/(name+'.c'),'-o',obj]);objects.append(row(obj))
 result=dict(schema='iq4_original_LV_stop_cleanup06',objects=objects,old_session_counterexamples=3,session_normal=17,session_sanitized=17,source_liveness_cases_each_variant=8,source_registry_regression=True,original_ports_synthetic=True,target_executed=False,black_reference_accepted=False)
 (out/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
if __name__=='__main__':main()
