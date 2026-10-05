#!/usr/bin/env python3
"""Freeze new source closure/review artifacts; never stage or deploy."""
from pathlib import Path
import hashlib,json,sys,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/sdk_reference/f1_observe_geometry_build_04';PACKAGE=ROOT/'build/f1_observe_geometry04_source_review_01'
def row(p):
    b=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest()}
def verify():
    lock=json.loads((HERE/'SOURCE_SHA256.json').read_text())
    for r in lock['members']+lock['frozen_refs']+lock['review_artifacts']:
        assert row(ROOT/r['path'])==r,r['path']
    meta=json.loads((PACKAGE/'PACKAGE.json').read_text());assert row(ROOT/meta['zip']['path'])==meta['zip']
    with zipfile.ZipFile(ROOT/meta['zip']['path'])as z:
        assert sorted(z.namelist())==sorted(meta['members'])
        for n in z.namelist():assert z.read(n)==(ROOT/n).read_bytes(),n
    print(json.dumps({'source_lock':row(HERE/'SOURCE_SHA256.json'),'zip':meta['zip'],'zip_members':len(meta['members']),'verified':True}))
def main():
    if sys.argv[1:]==['--verify']:verify();return
    assert not(HERE/'SOURCE_SHA256.json').exists(),'already frozen; use --verify'
    refs=set()
    for folder in ('f1_module_entry_01','f1_geometry_probe_03','f1_native_ui_02','f1_native_overlay_01','f1_entry_button_ports_01','f4_ui_bootstrap_02','f4_ui_counter_01','f1_observe_role_02'):
        refs.update(p for p in(HERE.parent/folder).iterdir()if p.is_file()and(p.suffix in('.h','.hpp','.cpp')or p.name=='SOURCE_SHA256.json'))
    refs.update(HERE.parent/'f4_ram_entry_01'/n for n in('readonly_monitor.c',))
    for folder in('src/core','src/display'):refs.update(p for p in(ROOT/folder).rglob('*')if p.is_file()and p.suffix in('.h','.hpp','.cpp'))
    refs.add(ROOT/'tools/target/toolchain.lock.json')
    refs.update(ROOT/p for p in('analysis/firmware/f1_geometry_probe_03/manifest.json','analysis/firmware/f1_native_ui_02/manifest.json','tools/firmware/f1_module_entry_01/decode_observation.py','tools/firmware/f1_observe_role_02/role_config.preview.h','tools/firmware/f1_observe_role_02/status.h','tools/firmware/f4_ui_bootstrap_02/build_validate.py','tools/firmware/inspect_boot.py'))
    members=set(p for p in HERE.iterdir()if p.is_file()and p.name!='SOURCE_SHA256.json')
    members.add(ROOT/'analysis/sdk_reference/F1_OBSERVE_GEOMETRY_04.md')
    members.update(p for p in OUT.iterdir()if p.is_file()and p.name in('BUILD_VALIDATION.json','normal.json','asan_ubsan.json','TARGET_DYNAMIC.txt','TARGET_UNLOCK.disasm.txt','TARGET_DEFINED.txt','DEFAULT_CPU_FP_NEGATIVE.txt','ROLE_CANDIDATE_DYNAMIC.txt','role_config.h'))
    report=json.loads((OUT/'BUILD_VALIDATION.json').read_text())
    artifacts=[ROOT/report['target']['path'],ROOT/report['role_candidate']['path']]
    assert row(artifacts[0])['sha256']==report['target']['sha256'] and row(artifacts[1])['sha256']==report['role_candidate']['sha256']
    lock={'schema':'iq4_f1_observe_geometry_source_lock_04','stage':'offline_observe_scalar_only','camera_access':False,'SDK_started':False,'target_loaded':False,'installer_emitted':False,'mask_enabled':False,'paint_scope_called':False,'three_verified_fields_always_zero':True,'members':[row(p)for p in sorted(members)],'frozen_refs':[row(p)for p in sorted(refs)],'review_artifacts':[row(p)for p in artifacts]}
    (HERE/'SOURCE_SHA256.json').write_text(json.dumps(lock,indent=2)+'\n')
    PACKAGE.mkdir(parents=True,exist_ok=True);zip_path=PACKAGE/'IQ4_F1_Observe_Geometry04_Source_Review_01.zip'
    paths=sorted(members|refs|{HERE/'SOURCE_SHA256.json'})
    assert all(p.suffix not in('.so','.o','.exe','.bin','.lib','.dll','.iiq')for p in paths)
    with zipfile.ZipFile(zip_path,'w',zipfile.ZIP_DEFLATED,compresslevel=9)as z:
        for p in paths:
            n=str(p.relative_to(ROOT));info=zipfile.ZipInfo(n,(2026,10,4,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=0o644<<16;z.writestr(info,p.read_bytes())
    (PACKAGE/'PACKAGE.json').write_text(json.dumps({'schema':'f1_geometry04_public_source_review_package','source_lock':row(HERE/'SOURCE_SHA256.json'),'zip':row(zip_path),'members':[str(p.relative_to(ROOT))for p in paths],'target_binary_in_zip':False,'installation':False},indent=2)+'\n')
    verify()
if __name__=='__main__':main()
