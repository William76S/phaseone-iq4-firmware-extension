#!/usr/bin/env python3
"""Freeze source/review closure only; never stage, run target, or deploy."""
from pathlib import Path
import difflib,hashlib,json,sys,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/sdk_reference/f1_observe_stack_build_05'
PACKAGE=ROOT/'build/f1_observe_stack05_source_review_01'
def row(p):
    b=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
def verify():
    lock=json.loads((HERE/'SOURCE_SHA256.json').read_text())
    for r in lock['members']+lock['frozen_refs']+lock['review_artifacts']:assert row(ROOT/r['path'])==r,r['path']
    meta=json.loads((PACKAGE/'PACKAGE.json').read_text());assert row(ROOT/meta['zip']['path'])==meta['zip']
    with zipfile.ZipFile(ROOT/meta['zip']['path'])as z:
        assert sorted(z.namelist())==sorted(meta['members'])
        for name in z.namelist():assert z.read(name)==(ROOT/name).read_bytes(),name
    print(json.dumps({'source_lock':row(HERE/'SOURCE_SHA256.json'),'zip':meta['zip'],'zip_members':len(meta['members']),'verified':True}))
def main():
    if sys.argv[1:]==['--verify']:verify();return
    assert not(HERE/'SOURCE_SHA256.json').exists(),'already frozen; use --verify'
    for old in('f1_module_entry_01','f1_observe_geometry_04','f1_observe_role_02'):
        lock=json.loads((HERE.parent/old/'SOURCE_SHA256.json').read_text())
        for r in lock['members']+lock['frozen_refs']:assert row(ROOT/r['path'])==r,r['path']
    report=json.loads((OUT/'BUILD_VALIDATION.json').read_text())
    assert report['tests']['normal']['groups']==report['tests']['asan_ubsan']['groups']==33
    assert report['tests']['normal']['decoder_checks']==report['tests']['asan_ubsan']['decoder_checks']==56
    assert not report['host_tests_reused_not_rerun'] and not report['target_loaded'] and not report['installer_emitted']
    for rel,wanted in report['sources'].items():assert row(ROOT/rel)['sha256']==wanted,rel
    old=(HERE.parent/'f1_observe_geometry_04/runtime_linux.cpp').read_text();new=(HERE/'runtime_linux.cpp').read_text()
    diff=''.join(difflib.unified_diff(old.splitlines(True),new.splitlines(True),fromfile='frozen/f1_observe_geometry_04/runtime_linux.cpp',tofile='new/f1_observe_stack_05/runtime_linux.cpp'))
    assert (HERE/'runtime_derived.diff.txt').read_text()==diff
    refs=set()
    for folder in('f1_module_entry_01','f1_observe_geometry_04','f1_geometry_probe_03','f1_native_ui_02','f1_native_overlay_01','f1_entry_button_ports_01','f4_ui_bootstrap_02','f4_ui_counter_01','f1_observe_role_02'):
        refs.update(p for p in(HERE.parent/folder).iterdir()if p.is_file()and(p.suffix in('.h','.hpp','.cpp')or p.name=='SOURCE_SHA256.json'))
    refs.update(ROOT/p for p in('tools/firmware/f1_observe_geometry_04/decode_observation.py','tools/firmware/f1_module_entry_01/decode_observation.py','tools/firmware/f1_observe_role_02/role_config.preview.h','tools/firmware/f1_observe_role_02/status.h','tools/firmware/f4_ui_bootstrap_02/build_validate.py','tools/firmware/inspect_boot.py','tools/target/toolchain.lock.json','analysis/firmware/f1_stack_current_static_05/exact_bytes.json','analysis/firmware/f1_stack_current_static_05/manifest.json','analysis/firmware/F1_STACK_CURRENT_TRANSITION_STATIC_05.md'))
    for folder in('src/core','src/display'):refs.update(p for p in(ROOT/folder).rglob('*')if p.is_file()and p.suffix in('.h','.hpp','.cpp'))
    members={p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json'}
    members.add(ROOT/'analysis/sdk_reference/F1_OBSERVE_STACK_05.md')
    members.update(OUT/n for n in('BUILD_VALIDATION.json','normal.json','asan_ubsan.json','TARGET_DYNAMIC.txt','TARGET_UNLOCK.disasm.txt','TARGET_DEFINED.txt','role_config.h'))
    artifact=ROOT/report['target']['path'];assert row(artifact)['sha256']==report['target']['sha256']
    lock={'schema':'iq4_f1_observe_stack_source_lock_05','stage':'offline_readonly_stack_observation','camera_access':False,'SDK_started':False,'target_loaded':False,'installer_emitted':False,'mask_enabled':False,'original_components_changed':False,'prior_source_not_relabelled':True,'role_binding_reused':False,'members':[row(p)for p in sorted(members)],'frozen_refs':[row(p)for p in sorted(refs)],'review_artifacts':[row(artifact)]}
    (HERE/'SOURCE_SHA256.json').write_text(json.dumps(lock,indent=2)+'\n')
    PACKAGE.mkdir(parents=True,exist_ok=True);zip_path=PACKAGE/'IQ4_F1_Observe_Stack05_Source_Review_01.zip';paths=sorted(members|refs|{HERE/'SOURCE_SHA256.json'})
    assert all(p.suffix not in('.so','.o','.exe','.bin','.lib','.dll','.iiq')for p in paths)
    with zipfile.ZipFile(zip_path,'w',zipfile.ZIP_DEFLATED,compresslevel=9)as z:
        for p in paths:
            name=str(p.relative_to(ROOT));info=zipfile.ZipInfo(name,(2026,10,4,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=0o644<<16;z.writestr(info,p.read_bytes())
    (PACKAGE/'PACKAGE.json').write_text(json.dumps({'schema':'f1_stack05_public_source_review_package','source_lock':row(HERE/'SOURCE_SHA256.json'),'zip':row(zip_path),'members':[str(p.relative_to(ROOT))for p in paths],'target_binary_in_zip':False,'installation':False},indent=2)+'\n')
    verify()
if __name__=='__main__':main()
