#!/usr/bin/env python3
"""Internal exact source -> sealed User comparison. Does not package firmware."""
from pathlib import Path
import argparse,hashlib,json,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent

def main():
 p=argparse.ArgumentParser();p.add_argument('--spec',type=Path,required=True);p.add_argument('--spec-sha256',required=True);p.add_argument('--reference-build',type=Path,required=True);p.add_argument('--output',type=Path,required=True);a=p.parse_args()
 assert hashlib.sha256(a.spec.read_bytes()).hexdigest()==a.spec_sha256
 spec=json.loads(a.spec.read_text());reference=json.loads((a.reference_build/'BUILD.json').read_text());original=(ROOT/reference['User']['path']).read_bytes();assert hashlib.sha256(original).hexdigest()==reference['User']['sha256'] and reference['linked_contract_sealed']
 out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();out.mkdir(parents=True);commands=[]
 def run(script,*args):
  argv=[sys.executable,str(script),*map(str,args)];q=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True);commands.append(dict(argv=argv,exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n');assert q.returncode==0,q.stderr
 inputs=out/'inputs';build=out/'user'
 run(HERE/'rebuild_inputs.py','--spec',a.spec,'--spec-sha256',a.spec_sha256,'--output',inputs)
 run(HERE/'build.py','--spec',a.spec,'--spec-sha256',a.spec_sha256,'--object-map',inputs/'ARTIFACT_MAP.json','--output',build,'--app-version',Path(reference['User']['path']).stem.rsplit('_',1)[1])
 run(ROOT/'tools/firmware/native_linked_unwind_03/verify.py','--build',build)
 proof=spec['loader_abi_proof'];assert hashlib.sha256((ROOT/proof['path']).read_bytes()).hexdigest()==proof['sha256']
 run(ROOT/'tools/firmware/native_linked_contract_02/seal.py','--build',build,'--loader-proof',ROOT/proof['path'])
 run(ROOT/'tools/firmware/native_linked_unwind_03/verify.py','--build',build)
 run(HERE/'verify_user.py','--build',build)
 fresh=json.loads((build/'BUILD.json').read_text());assert(ROOT/fresh['User']['path']).read_bytes()==original
 (out/'REPRO_IDENTITY.json').write_text(json.dumps(dict(reference=reference['User'],fresh=fresh['User'],all_objects_fresh=True,sealed_User_byte_identical=True,firmware_package_created=False,target_executed=False),indent=2)+'\n');print('All source -> internal sealed User byte-identical; no FWP or device execution')
if __name__=='__main__':main()
