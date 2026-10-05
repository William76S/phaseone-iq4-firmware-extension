#!/usr/bin/env python3
"""JPEG quality100 and always visible current-value host checks + AArch64 build."""
from pathlib import Path
import argparse, hashlib, importlib.util, json, subprocess, shlex
ROOT=Path(__file__).resolve().parents[3]; HERE=Path(__file__).resolve().parent

def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())

def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True)
 commands=[];tests=[]
 def run(argv):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,text=True,capture_output=True);r=dict(argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr);commands.append(r);(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,r;return q.stdout.strip()
 sdk=run(['/usr/bin/xcrun','--show-sdk-path']);cc='/Library/Developer/CommandLineTools/usr/bin/clang'
 modes=[[]]+[[str(i)]for i in range(1,18)]+[[x]for x in ['--backend-unavailable','--append-failure','--sd-cap-only','--xqd-cap-only','--bad-cap','--submit-unknown','--submit-reject-after-prepare','--cancel-unknown','--notify-unknown','--begin-unknown','--wrong-ui-action','--completed-callback-fence']]
 for variant,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  common=[cc,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*flags]
  exe=out/('policy_'+variant);run([*common,'-pthread',HERE/'../f3_capture_menu_08/test_policy.c',HERE/'../f3_capture_menu_08/policy.c',ROOT/'src/codec/export_geometry.c','-o',exe]);tests.append(dict(variant=variant,kind='policy',result=json.loads(run([exe]))))
  exe=out/('menu_'+variant);run([*common,HERE/'test_menu.c',HERE/'../f3_capture_menu_08/policy.c',ROOT/'src/codec/export_geometry.c','-o',exe])
  for args in modes:tests.append(dict(variant=variant,kind='menu',args=args,stdout=run([exe,*args])))
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert row(zig)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 spec=importlib.util.spec_from_file_location('inspect_f4',ROOT/'tools/firmware/f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 objects=[];deps=set()
 for name,source in [('menu','runtime.c')]:
  obj=out/(name+'.o');dep=out/(name+'.d');run([zig,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',dep,'-c',HERE/source,'-o',obj]);objects.append(m.inspect(obj))
  for d in shlex.split(dep.read_text().replace('\\\n',' ').split(':',1)[1]):
   p=Path(d).resolve();assert p.is_relative_to(ROOT);deps.add(p)
 report=dict(schema='iq4_f3_quality_native_size_menu09',source_inputs=[row(p)for p in sorted(HERE.iterdir())if p.is_file()],dependencies=[row(p)for p in sorted(deps)],objects=objects,tests=tests,menu_runs_each=len(modes),quality_default=100,quality_reset=100,current_quality_row=True,coordinator_guards_retained=True,target_executed=False,camera_accessed=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(objects=[row(out/(x+'.o'))for x in ['menu']],menu_runs_each=len(modes),target_executed=False),indent=2))
if __name__=='__main__':main()
