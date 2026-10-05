#!/usr/bin/env python3
"""Build and test the menu visibility repair; no device execution."""
from pathlib import Path
import argparse, hashlib, json, subprocess, importlib.util, difflib
ROOT=Path(__file__).resolve().parents[3]; HERE=Path(__file__).resolve().parent
OLD=ROOT/'tools/firmware/f3_capture_menu_06'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);a=ap.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True)
 for e in json.loads((OLD/'SOURCE_SHA256.json').read_text())['files']:assert row(ROOT/e['path'])==e
 commands=[];tests=[]
 def run(argv,success=True):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,text=True,capture_output=True);r=dict(argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr);commands.append(r);(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert (q.returncode==0)==success,r;return q.stdout.strip()
 sdk=run(['/usr/bin/xcrun','--show-sdk-path']);cc='/Library/Developer/CommandLineTools/usr/bin/clang'
 common=[cc,'-isysroot',sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror']
 oldtest=out/'old_menu_test.c';oldtest.write_text((HERE/'test_menu.c').read_text().replace('#include "runtime.c"','#include "'+str(OLD/'runtime.c')+'"'))
 oldexe=out/'old_menu';run([*common,oldtest,OLD/'policy.c',ROOT/'src/codec/export_geometry.c','-o',oldexe]);oldfailure=run([oldexe,'--backend-unavailable'],False)
 cases=[[],['--backend-unavailable'],['--append-failure'],['1'],['--sd-cap-only'],['--xqd-cap-only'],['--bad-cap'],['--submit-unknown'],['--notify-unknown']]
 for variant,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=out/('menu_'+variant);run([*common,*flags,HERE/'test_menu.c',OLD/'policy.c',ROOT/'src/codec/export_geometry.c','-o',exe])
  for args in cases:tests.append(dict(variant=variant,args=args,stdout=run([exe,*args])))
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert row(zig)['sha256']=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 obj=out/'menu.o';run([zig,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-Wall','-Wextra','-Werror','-ffreestanding','-fPIC','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-MMD','-MF',out/'menu.d','-c',HERE/'runtime.c','-o',obj])
 spec=importlib.util.spec_from_file_location('oldinspect',ROOT/'tools/firmware/f4_native_source_02/build.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);actual=m.inspect(obj)
 expected=json.loads((OLD/'LINK_OVERLAY.json').read_text())['replacements'][0]['replacement']['undefined_symbols'];assert set(actual['undefined_symbols'])==set(expected)
 (out/'SOURCE_DIFF.patch').write_text(''.join(difflib.unified_diff((OLD/'runtime.c').read_text().splitlines(True),(HERE/'runtime.c').read_text().splitlines(True))))
 report=dict(schema='iq4_f3_menu_visibility_repair07',objects=[actual],tests=tests,old_ready_false_hides_entry_reproduced=True,normal_cases=len(cases),sanitized_cases=len(cases),new_external_ABI=False,target_executed=False,camera_accessed=False)
 (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(object=row(obj),normal_cases=len(cases),sanitized_cases=len(cases)),indent=2))
if __name__=='__main__':main()
