#!/usr/bin/env python3
"""Build own host fixtures and two AArch64 ET_REL replacements; never load SDK."""
import argparse,difflib,hashlib,importlib.util,json,pathlib,subprocess
ROOT=pathlib.Path(__file__).resolve().parents[3];HERE=pathlib.Path(__file__).resolve().parent
OLD=ROOT/'tools/firmware/f3_capture_menu_05';BASE=ROOT/'tools/firmware/f3_capture_menu_04'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';ZSHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
CC='/Library/Developer/CommandLineTools/usr/bin/clang'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def function(s,name):
 a=s.index(name+'(');a=s.rfind('\n',0,a)+1;b=s.index('{',a);depth=1;e=b+1
 while depth:
  depth+=(s[e]=='{')-(s[e]=='}');e+=1
 return s[a:e]
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=pathlib.Path,required=True);a=ap.parse_args();out=a.output.resolve()
 assert out.is_relative_to(ROOT)and not out.exists()and row(ZIG)['sha256']==ZSHA
 for parent in [OLD,BASE]:
  lock=json.loads((parent/'SOURCE_SHA256.json').read_text());assert all(row(ROOT/x['path'])==x for x in lock['files'])
 old=(OLD/'runtime.c').read_text();new=(HERE/'runtime.c').read_text()
 same=['rd','word','pins','on_ui','put','text','number','idx','present','hold','refresh','retire_finished','settings_idle','status','construct']
 assert all(function(old,n)==function(new,n)for n in same)
 out.mkdir(parents=True);commands=[];tests=[]
 def run(argv,kind):
  q=subprocess.run([str(x)for x in argv],cwd=ROOT,text=True,capture_output=True);r=dict(kind=kind,argv=[str(x)for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr);commands.append(r)
  (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,r;return q.stdout
 assert run([ZIG,'version'],'compiler_identity').strip()=='0.15.2';sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
 modes=[[]]+[[str(i)]for i in range(1,24)]+[[x]for x in ['--append-failure','--sd-cap-only','--xqd-cap-only','--bad-cap','--submit-unknown','--submit-reject-after-prepare','--cancel-unknown','--notify-unknown','--begin-unknown','--wrong-ui-action','--completed-callback-fence']]
 for variant,extra in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  common=[CC,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror',*extra]
  exe=out/('policy_'+variant);run([*common,'-pthread',HERE/'test_policy.c',HERE/'policy.c',ROOT/'src/codec/export_geometry.c','-o',exe],'own_host_compile')
  policy=json.loads(run([exe],'own_host_synthetic_execution'));assert policy['policy_groups']==59 and not policy['target_executed'];tests.append(dict(variant=variant,kind='policy',result=policy))
  exe=out/('menu_'+variant);run([*common,HERE/'test_menu.c',HERE/'policy.c',ROOT/'src/codec/export_geometry.c','-o',exe],'own_host_compile')
  for args in modes:
   text=run([exe,*args],'own_host_synthetic_execution');assert 'PASS native dual-card menu ABI' in text;tests.append(dict(variant=variant,kind='menu',args=args,stdout=text))
 objects=[];deps=set()
 spec=importlib.util.spec_from_file_location('inspect_f4',ROOT/'tools/firmware/f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 for name,source in [('policy','policy.c'),('menu','runtime.c')]:
  obj=out/(name+'.o');dep=out/(name+'.o.d')
  run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',dep,'-c',HERE/source,'-o',obj],'cross_compile_only')
  objects.append(m.inspect(obj));s=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj],'static_disassembly_only');(out/(name+'.o.asm')).write_text('\n'.join(x.rstrip()for x in s.splitlines())+'\n')
  import shlex
  for d in shlex.split(dep.read_text().replace('\\\n',' ').split(':',1)[1]):
   p=pathlib.Path(d).resolve();assert p.is_relative_to(ROOT);deps.add(p)
 oldins=json.loads((OLD/'LINK_OVERLAY.json').read_text())['replacement']['undefined_symbols'];actual=next(x for x in objects if pathlib.Path(x['path']).name=='menu.o')['undefined_symbols']
 expected=set(oldins)-{'iq4_f3_mode_set_on_ui_01','iq4_f3_settings_snapshot_04'}|{'iq4_f3_mode_set_for_card_on_ui_06','iq4_f3_settings_snapshot_06','f3_capture_backend_capabilities_03'}
 assert set(actual)==expected,(actual,expected)
 (out/'SOURCE_DIFF.patch').write_text(''.join(difflib.unified_diff(old.splitlines(keepends=True),new.splitlines(keepends=True),fromfile='frozen_menu05/runtime.c',tofile='new_menu06/runtime.c'))+''.join(difflib.unified_diff((BASE/'policy.c').read_text().splitlines(keepends=True),(HERE/'policy.c').read_text().splitlines(keepends=True),fromfile='frozen_policy04/policy.c',tofile='new_policy06/policy.c')))
 j=dict(schema='iq4_f3_dual_card_menu06_build',source_inputs=[row(p)for p in sorted(HERE.iterdir())if p.is_file()and p.name!='SOURCE_SHA256.json'],frozen_inputs=[row(p/x)for p,x in [(OLD,'SOURCE_SHA256.json'),(OLD,'LINK_OVERLAY.json'),(OLD,'runtime.c'),(BASE,'SOURCE_SHA256.json'),(BASE,'LINK_INPUT.json'),(BASE,'policy.c')]],dependencies=[row(p)for p in sorted(deps)],objects=objects,tests=tests,menu_runs_each=len(modes),unchanged_native_helpers=same,sole_atomic_state=True,capture_capability_is_actual_backend=True,source_or_card_ownership_from_ui=False,new_BL=[],additional_aliases=[],camera_access=False,target_executed=False,sdk_loaded=False)
 (out/'BUILD.json').write_text(json.dumps(j,indent=2)+'\n');print(json.dumps(dict(objects=[row(out/x)for x in ['policy.o','menu.o']],menu_runs_each=len(modes),policy_groups_each=59,target_executed=False),indent=2))
if __name__=='__main__':main()
