"""Own host tests + readonly target cross compilation/ELF inspection, no SDK run."""
from pathlib import Path
import difflib,hashlib,json,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];NATIVE=ROOT/'tools/sdk/f1_restore_baseline_native_03';OUT=ROOT/'analysis/sdk_reference/f1_restore_baseline03_host';OUT.mkdir(parents=True,exist_ok=True)
sys.path.insert(0,str(HERE.parent));from f1_restore_baseline_03 import contract as c
cmds=[]
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(args,**kw):
 args=list(map(str,args));cmds.append(args);r=subprocess.run(args,cwd=ROOT,capture_output=True,text=True,**kw)
 if r.returncode:raise RuntimeError(r.stdout+r.stderr)
 return r.stdout+r.stderr
checks=run([sys.executable,'-B',HERE/'test_baseline.py']);(OUT/'PYTHON_TESTS.txt').write_text(checks)
sdk=run(['xcrun','--show-sdk-path']).strip();compiler=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1']
vectors=[]
for path in (c.RUNNER,c.INITTAB):
 for label,off,count in [('baseline_regular_metadata',0,0),('baseline_regular_sha256',0,0),('baseline_regular_octets_chunk',0,4096),('baseline_regular_octets_eof',5104,2)]:vectors.append(c.plan(label,'0123456789ab',path=path,offset=off,count=count)[0])
for label in (*c.PROC_BINARY,*c.PROC_TEXT):vectors.append(c.plan(label,'0123456789ab',process=123,count=4097 if label in c.PROC_BINARY else 0)[0])
for label in ('baseline_kernel_cmdline','baseline_syscall_facts','baseline_syscall_probe_sha','baseline_pthread_sha256'):vectors.append(c.plan(label,'0123456789ab')[0])
for label in ('runtime_exe_readlink','runtime_exe_sha256'):vectors.append(c.plan(label,'0123456789ab',process=123)[0])
vectors.append(c.plan('original_metadata','0123456789ab',path='/mnt/qspi/User/p1linux')[0]);reports=[]
for mode,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
 exe=OUT/('profiles_'+mode);run(compiler+flags+[NATIVE/'profile_test.cpp','-o',exe]);report=json.loads(run([exe]));assert report['passed']and not report['vendor_linked'];reports.append(report)
 for i,p in enumerate(vectors):
  path=OUT/('golden_'+str(i)+'.plan');path.write_bytes(p.encode());assert run([exe,'--check-plan',path])==p.host_text+'\n'
old=NATIVE.parent/'readonly_octets_native_01';original=(old/'readonly_once.cpp').read_text();expected=original.replace('#include "profiles.hpp"','#include "../../firmware/f1_restore_baseline_03/profiles.hpp"').replace('IQ4ReadonlyOctets01::Parse(','IQ4RestoreBaseline03::Parse(').replace('IQ4ReadonlyOctets01::Command(','IQ4RestoreBaseline03::Command(');assert (NATIVE/'readonly_once.cpp').read_text()==expected
zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c';target=OUT/'readfacts_aarch64_review_only';run([zig,'cc','-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-Wall','-Wextra','-Werror',HERE/'syscall_facts.c','-o',target]);inspection=run(['file',target]);(OUT/'TARGET_FILE.txt').write_text(inspection)
# Own read-only ELF parser, not execution or dynamic loading.
sys.path.insert(0,str(ROOT/'tools/firmware/f4_ui_bootstrap_02'));from build_validate import elf
_,_,_,imports=elf(target.read_bytes());imports=sorted(imports);(OUT/'TARGET_IMPORTS.json').write_text(json.dumps(imports,indent=2)+'\n');assert not any(x in imports for x in ('write','pwrite','unlink','rename','mount','ioctl','kill','reboot'))
pwsh=ROOT/'analysis/sdk_reference/vendor_downloads/powershell_mac/pwsh';expr='$bad=0;'+''.join("$t=$null;$e=$null;$null=[Management.Automation.Language.Parser]::ParseFile('"+str(p)+"',[ref]$t,[ref]$e);if($e.Count){$bad++;$e|Out-String};"for p in NATIVE.glob('*.ps1'))+"if($bad){exit 2};'PS syntax only PASS'";parsed=run([pwsh,'-NoLogo','-NoProfile','-Command',expr]);(OUT/'PS_PARSE.txt').write_text(parsed)
report={'schema':'iq4_f1_restore_baseline03_sdk_free_validation','python_test_output_sha256':sha(OUT/'PYTHON_TESTS.txt'),'profile_runs':reports,'python_cpp_golden_vectors':len(vectors),'target_review_only_sha256':sha(target),'target_bytes':target.stat().st_size,'target_imports':imports,'native_changed_lines':3,'Windows_native_build_executed':False,'SDK_or_camera_access':False,'target_executed':False,'commands':cmds};(OUT/'HOST_VALIDATION.json').write_text(json.dumps(report,indent=2)+'\n');(OUT/'.gitignore').write_text('profiles_*\ngolden_*.plan\nreadfacts_aarch64_review_only\n');print(json.dumps({k:v for k,v in report.items()if k in ('python_cpp_golden_vectors','target_bytes','native_changed_lines','Windows_native_build_executed','SDK_or_camera_access','target_executed')}))
