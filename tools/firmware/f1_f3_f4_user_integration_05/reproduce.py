#!/usr/bin/env python3
"""Fresh source compile, link, actual static checks, seal and stock wrapper."""
from pathlib import Path
import argparse,hashlib,json,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--spec',type=Path,required=True);ap.add_argument('--spec-sha256',required=True);ap.add_argument('--reference-build',type=Path,required=True);ap.add_argument('--reference-package',type=Path,required=True);ap.add_argument('--output',type=Path,required=True);a=ap.parse_args()
 spec=a.spec.resolve();assert hashlib.sha256(spec.read_bytes()).hexdigest()==a.spec_sha256
 specification=json.loads(spec.read_text());proof=specification['loader_abi_proof']
 assert hashlib.sha256((ROOT/proof['path']).read_bytes()).hexdigest()==proof['sha256']
 out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True)
 reference=json.loads((a.reference_build/'BUILD.json').read_text());assert reference['linked_contract_sealed']
 reference_bytes=(ROOT/reference['User']['path']).read_bytes()
 assert len(reference_bytes)==reference['User']['bytes']and hashlib.sha256(reference_bytes).hexdigest()==reference['User']['sha256']
 plan=json.loads((a.reference_package/'PLAN.json').read_text());commands=[]
 def run(script,*args):
  argv=[sys.executable,str(script),*map(str,args)];q=subprocess.run(argv,cwd=ROOT,capture_output=True,text=True)
  commands.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  assert q.returncode==0,q.stderr
 inputs=out/'inputs';userbuild=out/'user';package=out/'candidate'
 run(HERE/'rebuild_inputs.py','--spec',spec,'--spec-sha256',a.spec_sha256,'--output',inputs)
 run(HERE/'build.py','--spec',spec,'--spec-sha256',a.spec_sha256,'--output',userbuild,'--object-map',inputs/'ARTIFACT_MAP.json','--app-version',plan['component_version'])
 unwind=ROOT/'tools/firmware/native_linked_unwind_03/verify.py'
 run(unwind,'--build',userbuild)
 run(ROOT/'tools/firmware/native_linked_contract_02/seal.py','--build',userbuild,'--loader-proof',ROOT/proof['path'])
 run(unwind,'--build',userbuild)
 run(HERE/'verify_user.py','--build',userbuild)
 fresh=json.loads((userbuild/'BUILD.json').read_text());y=(ROOT/fresh['User']['path']).read_bytes();assert reference_bytes==y
 run(ROOT/'tools/firmware/user_only_package_stock_wrapper_03/package.py','--user-payload',ROOT/fresh['User']['path'],'--expected-user-sha256',fresh['User']['sha256'],'--release-version',plan['release_version'],'--app-version',plan['component_version'],'--system-version',plan['system_version'],'--release-date',plan['release_date'],'--emit-candidate-directory',package)
 run(HERE/'inspect_package.py','--build',userbuild,'--package',package)
 for name in ['IQ4-user-only-candidate.fwp','IQ4-user-only.fwr']:assert(package/name).read_bytes()==(a.reference_package/name).read_bytes()
 result=dict(schema='iq4_complete_F1_F3_F4_source_User_FWR_FWP_reproduction_01',reference_User=reference['User'],fresh_User=fresh['User'],complete_sealed_User_byte_identical=True,complete_FWR_and_FWP_byte_identical=True,all_target_objects_recompiled_from_exact_sources=True,target_executed=False,camera_accessed=False,persistent_acceptance=False)
 (out/'REPRO_IDENTITY.json').write_text(json.dumps(result,indent=2)+'\n');print('Full source → sealed User → FWR → FWP byte-identical; no target execution')
if __name__=='__main__':main()
