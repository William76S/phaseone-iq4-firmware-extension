#!/usr/bin/env python3
"""Exact stock wrapper with explicit release date; offline, no installation."""
from pathlib import Path
import argparse, datetime, hashlib, importlib.util, json
import xml.etree.ElementTree as ET

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
PREVIOUS=HERE.parent/'user_only_package_stock_wrapper_02/package.py'
PREVIOUS_SHA='e341876c524612bee78f457a440de7b46f6298642af88fbebc843513e3f0fa87'
assert hashlib.sha256(PREVIOUS.read_bytes()).hexdigest()==PREVIOUS_SHA
sp=importlib.util.spec_from_file_location('dated_exact_stock_wrapper_02',PREVIOUS)
old=importlib.util.module_from_spec(sp);sp.loader.exec_module(old)
module=old.module
load_stock_fwp=old.load_stock_fwp
DEFAULT_FWP=old.DEFAULT_FWP
INNER=old.INNER

def date(text):
    parsed=datetime.date.fromisoformat(text)
    if parsed.isoformat()!=text:
        raise ValueError('release date must be exact YYYY-MM-DD')
    return text

def build(stock,payload,payload_sha,attributes,outer,release,app,system,release_date):
    release_date=date(release_date)
    p=module()
    if outer.tag!='system_package' or outer.attrib!=old.ROOT_ATTRS or outer[0].attrib!=old.BACK_ATTRS:
        raise ValueError('exact original outer reference required')
    if attributes['release_date']!='2022-07-18':
        raise ValueError('exact original release reference required')
    dated=dict(attributes,release_date=release_date)
    plan,fwr,_=p.build(stock,payload,payload_sha,dated,release,app)
    root=ET.Element(outer.tag,outer.attrib)
    root.set('version',p.text_version(system));root.set('date',release_date)
    back=ET.SubElement(root,'firmware_package',outer[0].attrib)
    back.set('version',p.text_version(release));back.text=INNER
    xml=ET.tostring(root,encoding='utf-8',xml_declaration=True)+b'\n'
    entries=[('manifest.xml',xml),(INNER,fwr)];fwp=p.stored_zip(entries)
    if len(fwp)>0x7fffffff:
        raise ValueError('nested extraction size must remain positive signed')
    plan.pop('original_release_date_retained_as_candidate_base')
    plan.update(schema='iq4_offline_user_only_stock_wrapper_candidate_v3',
        original_stock_fwp_sha256=old.FWP_SHA,stock_outer_manifest_sha256=old.XML_SHA,
        system_version=p.text_version(system),original_system_version='8.02.0',
        system_version_strictly_newer_host_policy=system>old.STOCK_SYSTEM,
        release_date=release_date,original_release_date=attributes['release_date'],
        original_outer_date=outer.attrib['date'],inner_and_outer_release_dates_match=True,
        fwp={'size':len(fwp),'sha256':old.sha(fwp),'entries':p.verify_zip(fwp,entries)},
        fwp_outer_schema_reconstructed_from_static_consumer_not_stock_sample=False,
        stock_outer_attributes_and_back_selectors_preserved_except_explicit_versions_date_and_filename=True,
        outer_XF_and_XT_components_removed=True,outer_stock_date_retained_as_candidate_base=False,
        minimum_update_version_not_added_to_stock_outer_or_child=True,
        offline_candidate_generation_scope_passed=plan['offline_candidate_generation_scope_passed']
            and system>old.STOCK_SYSTEM and not plan['payload_changes_limited_to_image_header_version'])
    return plan,fwr,fwp

def main():
    p=module();a=argparse.ArgumentParser(description=__doc__)
    a.add_argument('--original-fwp',type=Path,default=DEFAULT_FWP)
    a.add_argument('--original-fwr',type=Path,default=p.DEFAULT_FWR)
    a.add_argument('--user-payload',type=Path,required=True)
    a.add_argument('--expected-user-sha256',required=True)
    a.add_argument('--release-version',required=True);a.add_argument('--app-version',required=True)
    a.add_argument('--system-version',required=True);a.add_argument('--release-date',required=True)
    a.add_argument('--emit-candidate-directory',type=Path);x=a.parse_args()
    outer,inner=load_stock_fwp(x.original_fwp);stock,_,attrs=p.load_stock(x.original_fwr)
    if inner!=x.original_fwr.read_bytes():
        raise ValueError('stock FWP embedded FWR differs from provided original')
    plan,fwr,fwp=build(stock,x.user_payload.read_bytes(),x.expected_user_sha256,attrs,outer,
        p.version(x.release_version),p.version(x.app_version),p.version(x.system_version),x.release_date)
    if x.emit_candidate_directory:
        if not plan['offline_candidate_generation_scope_passed']:
            raise ValueError('changed functional User and newer matching versions required')
        d=x.emit_candidate_directory.resolve()
        if ROOT not in d.parents:
            raise ValueError('new candidate directory must be inside project')
        d.mkdir(mode=0o700,parents=False)
        for name,body in ((INNER,fwr),('IQ4-user-only-candidate.fwp',fwp),
                ('PLAN.json',(json.dumps(plan,indent=2)+'\n').encode())):
            with (d/name).open('xb')as f:f.write(body)
            (d/name).chmod(0o600)
    print(json.dumps(plan,indent=2))

if __name__=='__main__':main()
