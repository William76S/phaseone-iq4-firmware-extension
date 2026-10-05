#!/usr/bin/env python3
"""Only the owned SDK-free formatter is executed, never an AArch64 target."""
import json,subprocess
import fixed_profiles
from build_prepare import ROOT,HERE,OUT,sha
def main():
 commands=[]
 def run(a):
  a=list(map(str,a));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True);assert p.returncode==0,p.stdout+p.stderr;return p.stdout
 sdk=run(['xcrun','--show-sdk-path']).strip();exe=OUT/'host_formatter';run(['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1',HERE/'formatter_test.cpp','-o',exe])
 rows=[]
 for label in fixed_profiles.FLAGS:
  p,c=fixed_profiles.plan(label,'0123456789ab');data=fixed_profiles.serialize(p);path=OUT/(label+'.plan');path.write_bytes(data);actual=run([exe,path]).rstrip('\n');assert actual==c.host_text
  rows.append({'label':label,'flag':fixed_profiles.FLAGS[label],'scope':fixed_profiles.scope(label),'source_bytes':len(actual.encode()),'plan_sha256':sha(path),'host_text':actual})
 for label,token in [('loader11_arbitrary','0123456789ab'),('loader11_arm','../../etc/passwd')]:
  try:fixed_profiles.plan(label,token)
  except ValueError:pass
  else:raise AssertionError('Unsupported formatter accepted')
 dep=run(['/usr/bin/clang++','-std=c++17','-isystem',sdk+'/usr/include/c++/v1','-MM','-MT','owned_formatter',HERE/'formatter_test.cpp'])
 paths=dep.replace('\\\n','').split()[1:];refs={}
 for path in paths:
  p=__import__('pathlib').Path(path).resolve();assert p.is_relative_to(ROOT);refs[str(p.relative_to(ROOT))]=sha(p)
 for rel in('tools/sdk/readonly_backup_stage2/workflow.py','tools/sdk/read_hex_octets_01/contract.py'):
  p=ROOT/rel;refs[rel]=sha(p)
 report={'schema':11,'public_ABI':10,'golden_vectors':rows,'python_cpp_equal':True,'negative_per_cpp_vector':4,'arbitrary_path_PID_shell_refused':True,'SDK_loaded':False,'Windows_device_network_used':False,'target_program_executed':False,'deployment_authorized':False,'source_closure':refs,'commands':commands};(OUT/'FORMATTER_CHECKS.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'vectors':len(rows),'max_source_bytes':max(r['source_bytes']for r in rows),'python_cpp_equal':True,'target_program_executed':False}))
if __name__=='__main__':main()
