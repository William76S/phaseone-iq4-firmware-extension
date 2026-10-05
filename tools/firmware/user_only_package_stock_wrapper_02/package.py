#!/usr/bin/env python3
"""Offline wrapper bound to actual official FWP; no installation or target execution."""
import argparse,hashlib,importlib.util,io,json
from pathlib import Path
import xml.etree.ElementTree as ET
import zipfile
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
BASE=HERE.parent/'user_only_package_01'
BASE_SOURCE_SHA='f3de3a8773caa4b4c73d95be961a2075327d79a63cde4af2c73c47c6224dbbd8'
# Whole old module must remain its frozen original, not a silent replacement.
def sha(b):return hashlib.sha256(b).hexdigest()
def module():
 m=json.loads((BASE/'SOURCE_SHA256.json').read_text());rel=str((BASE/'package.py').relative_to(ROOT));r=m['files'][rel]
 b=(BASE/'package.py').read_bytes()
 if len(b)!=r['bytes']or sha(b)!=r['sha256']:raise ValueError('frozen 01 package source differs')
 if r['sha256']!=BASE_SOURCE_SHA:raise ValueError('unexpected pinned 01 module')
 spec=importlib.util.spec_from_file_location('iq4_package_frozen_01',BASE/'package.py');p=importlib.util.module_from_spec(spec);spec.loader.exec_module(p);return p
FWP_SHA='3dfb12c9417d60a0838a5abbfe3adccba2f242a79bab5f9ffa312be097571252'
FWP_SIZE=80158711
XML_SHA='29081a1b7be5753e91648f00abe2b478e3c040ced65b11c963361d296e96f575'
DEFAULT_FWP=ROOT/'analysis/firmware/vendor_downloads/stock_fwp_01/XFSystem8.02.0.fwp'
STOCK_SYSTEM=(8,2,0)
ROOT_ATTRS={'compatible_version':'2','name':'XFSystem','version':'8.02.0','date':'2022-07-21'}
BACK_ATTRS={'model_ids':'0x125,0x126,0x122','hw_revisions':'1,2,3','version':'6.03.18'}
INNER='IQ4-user-only.fwr'
def load_stock_fwp(path):
 b=path.read_bytes()
 if (len(b),sha(b))!=(FWP_SIZE,FWP_SHA):raise ValueError('unknown actual stock FWP')
 with zipfile.ZipFile(io.BytesIO(b))as z:
  if z.namelist()!=['FW5.00.5.FWR','IQ4_6.03.18.FWR','manifest.xml','XS1.01.4.FWR']or z.comment or z.testzip()is not None:raise ValueError('actual stock ZIP4/CRC')
  if any(i.flag_bits!=0 or i.compress_type!=zipfile.ZIP_DEFLATED for i in z.infolist()):raise ValueError('stock ZIP flags/method')
  xml=z.read('manifest.xml');inner=z.read('IQ4_6.03.18.FWR')
  if sha(xml)!=XML_SHA or sha(inner)!=module().FWR_SHA:raise ValueError('stock inner/manifest differs')
 root=ET.fromstring(xml)
 if root.tag!='system_package'or root.attrib!=ROOT_ATTRS or len(root)!=3 or root[0].tag!='firmware_package'or root[0].attrib!=BACK_ATTRS or root[0].text!='IQ4_6.03.18.FWR':raise ValueError('stock outer XML differs')
 return root,inner

def build(stock,payload,payload_sha,attributes,outer,release,app,system):
 p=module();plan,fwr,_=p.build(stock,payload,payload_sha,attributes,release,app)
 if outer.tag!='system_package'or outer.attrib!=ROOT_ATTRS or outer[0].attrib!=BACK_ATTRS:raise ValueError('actual outer reference required')
 root=ET.Element(outer.tag,outer.attrib);root.set('version',p.text_version(system));back=ET.SubElement(root,'firmware_package',outer[0].attrib);back.set('version',p.text_version(release));back.text=INNER
 xml=ET.tostring(root,encoding='utf-8',xml_declaration=True)+b'\n'
 entries=[('manifest.xml',xml),(INNER,fwr)];fwp=p.stored_zip(entries)
 if len(fwp)>0x7fffffff:raise ValueError('nested positive signed extraction size')
 plan.update(schema='iq4_offline_user_only_stock_wrapper_candidate_v2',original_stock_fwp_sha256=FWP_SHA,stock_outer_manifest_sha256=XML_SHA,system_version=p.text_version(system),original_system_version='8.02.0',system_version_strictly_newer_host_policy=system>STOCK_SYSTEM,fwp={'size':len(fwp),'sha256':sha(fwp),'entries':p.verify_zip(fwp,entries)},fwp_outer_schema_reconstructed_from_static_consumer_not_stock_sample=False,stock_outer_attributes_and_back_selectors_preserved_except_explicit_versions_and_filename=True,outer_XF_and_XT_components_removed=True,outer_stock_date_retained_as_candidate_base=True,minimum_update_version_not_added_to_stock_outer_or_child=True,offline_candidate_generation_scope_passed=plan['offline_candidate_generation_scope_passed']and system>STOCK_SYSTEM and not plan['payload_changes_limited_to_image_header_version'])
 # This is packaging evidence only. No patch functionality or device acceptance follows.
 return plan,fwr,fwp

def main():
 p=module();a=argparse.ArgumentParser(description=__doc__);a.add_argument('--original-fwp',type=Path,default=DEFAULT_FWP);a.add_argument('--original-fwr',type=Path,default=p.DEFAULT_FWR);a.add_argument('--user-payload',type=Path,required=True);a.add_argument('--expected-user-sha256',required=True);a.add_argument('--release-version',required=True);a.add_argument('--app-version',required=True);a.add_argument('--system-version',required=True);a.add_argument('--emit-candidate-directory',type=Path);x=a.parse_args()
 outer,inner=load_stock_fwp(x.original_fwp);stock,_,attrs=p.load_stock(x.original_fwr)
 if inner!=x.original_fwr.read_bytes():raise ValueError('stock FWP embedded FWR is not the exact provided original')
 plan,fwr,fwp=build(stock,x.user_payload.read_bytes(),x.expected_user_sha256,attrs,outer,p.version(x.release_version),p.version(x.app_version),p.version(x.system_version))
 if x.emit_candidate_directory:
  if not plan['offline_candidate_generation_scope_passed']:raise ValueError('emit requires independently changed non-version-only payload and explicit newer system/release/app versions')
  d=x.emit_candidate_directory.resolve()
  if ROOT not in d.parents:raise ValueError('fresh candidate directory must be inside this project')
  d.mkdir(mode=0o700,parents=False)
  for n,b in ((INNER,fwr),('IQ4-user-only-candidate.fwp',fwp),('PLAN.json',(json.dumps(plan,indent=2)+'\n').encode())):
   with (d/n).open('xb')as f:f.write(b)
   (d/n).chmod(0o600)
 print(json.dumps(plan,indent=2))
if __name__=='__main__':main()
