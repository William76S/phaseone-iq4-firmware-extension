#!/usr/bin/env python3
"""Read the actual nested candidate and independently repeat its packaging."""
from pathlib import Path
import argparse,hashlib,importlib.util,io,json,xml.etree.ElementTree as ET,zipfile
ROOT=Path(__file__).resolve().parents[3]
def row(p):
 b=p.read_bytes();return dict(path=str(p.resolve().relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);ap.add_argument('--package',type=Path,required=True);a=ap.parse_args()
 build=json.loads((a.build/'BUILD.json').read_text());assert build['linked_contract_sealed']
 user=ROOT/build['User']['path'];assert row(user)==build['User']
 directory=a.package.resolve();plan=json.loads((directory/'PLAN.json').read_text())
 wrapper=ROOT/'tools/firmware/user_only_package_stock_wrapper_03/package.py'
 sp=importlib.util.spec_from_file_location('repeat_actual_native_package',wrapper);m=importlib.util.module_from_spec(sp);sp.loader.exec_module(m);p=m.module()
 outer,inner=m.load_stock_fwp(m.DEFAULT_FWP);stock,_,attrs=p.load_stock(p.DEFAULT_FWR);assert inner==p.DEFAULT_FWR.read_bytes()
 repeated,fwr,fwp=m.build(stock,user.read_bytes(),build['User']['sha256'],attrs,outer,p.version(plan['release_version']),p.version(plan['component_version']),p.version(plan['system_version']),plan['release_date'])
 assert plan==repeated
 actual_fwp=directory/'IQ4-user-only-candidate.fwp';actual_fwr=directory/m.INNER
 assert actual_fwp.read_bytes()==fwp and actual_fwr.read_bytes()==fwr
 with zipfile.ZipFile(io.BytesIO(fwp))as z:
  assert z.testzip()is None and z.namelist()==['manifest.xml',m.INNER]
  root=ET.fromstring(z.read('manifest.xml'));assert root.attrib['version']==plan['system_version'] and root.attrib['date']==plan['release_date']
  assert len(root)==1 and root[0].text==m.INNER and root[0].attrib['version']==plan['release_version']
  with zipfile.ZipFile(io.BytesIO(z.read(m.INNER)))as q:
   assert q.testzip()is None and q.namelist()==['manifest.xml','P1Linux_'+plan['component_version']+'.bin']
   manifest=ET.fromstring(q.read('manifest.xml'));assert manifest.attrib['release_version']==plan['release_version'] and manifest.attrib['release_date']==plan['release_date']
   assert len(manifest)==1 and manifest[0].attrib['type']=='LinuxApp'and len(manifest[0])==1
   assert manifest[0][0].attrib['version']==plan['component_version']and manifest[0][0].text==q.namelist()[1]
   assert q.read(q.namelist()[1])==user.read_bytes()
 result=dict(schema='iq4_actual_F1_F3_F4_nested_User_identity_reproduction_01',User=build['User'],FWR=row(actual_fwr),FWP=row(actual_fwp),actual_embedded_User_matches_reviewed=True,fresh_whole_FWP_and_FWR_byte_identical=True,CRC_exact_entry_names_versions_valid=True,target_executed=False,camera_accessed=False,persistent_recovery_verified=False,persistent_installation_safe=False)
 target=directory/'ROOT_PACKAGE_INSPECTION.json';assert not target.exists();target.write_text(json.dumps(result,indent=2)+'\n');print('Actual nested User, both manifests, CRC, complete fresh FWP/FWR identity PASS; no device acceptance')
if __name__=='__main__':main()
