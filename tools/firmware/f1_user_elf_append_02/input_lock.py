#!/usr/bin/env python3
"""Freeze actual source/object identities before emitting a finite candidate."""
import argparse,json
from pathlib import Path
from elf_append import Reject,need,sha,Elf,NEW_IMPORT
ROOT=Path(__file__).resolve().parents[3]
LIB_SHA='5876c5861ffae1b3f6a5fc091be8f1d601edf602ebeed6a4aa3bf5c3cfbe11aa'
def local(path):
    p=ROOT/path;resolved=p.resolve();need(resolved.is_relative_to(ROOT.resolve()),'payload input must be project-local')
    need(p.is_file() and not p.is_symlink(),'payload input file/symlink');return p
def row(path):
    p=local(path);data=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(data),'sha256':sha(data)}
def check(rowvalue):
    p=local(rowvalue['path']);data=p.read_bytes();need(len(data)==rowvalue['bytes'] and sha(data)==rowvalue['sha256'],'actual locked source/object changed '+rowvalue['path']);return p,data
def lib_export(path):
    p=local(path);data=p.read_bytes();need(sha(data)==LIB_SHA,'exact original libstdc++ SHA')
    e=Elf(data,3,'original libstdc++');sy=e.symbols(e.index('.dynsym'));matches=[(i,x) for i,x in enumerate(sy)if x[6]==NEW_IMPORT]
    need(len(matches)==1,'unique terminate export');index,x=matches[0]
    need(index==265 and x[1]==18 and x[2]==0 and x[3]==12 and x[4]==0x90828,'original terminate export contract')
    vi=int.from_bytes(e.section_bytes(e.index('.gnu.version'))[index*2:index*2+2],'little');need(vi==2,'original terminate export default version')
    vd=e.section_bytes(e.index('.gnu.version_d'));strings=e.section_bytes(e.index('.dynstr'));at=0;version_name=None
    from elf_append import cstring
    import struct
    while True:
        ver,flags,ndx,count,hsh,aux,nxt=struct.unpack_from('<HHHHIII',vd,at)
        if ndx==vi:
            name,_=struct.unpack_from('<II',vd,at+aux);version_name=cstring(strings,name)
        if not nxt:break
        at+=nxt
    need(version_name=='GLIBCXX_3.4','terminate GLIBCXX_3.4 export proof')
    return {'library_sha256':LIB_SHA,'symbol':NEW_IMPORT,'version':version_name,'default':True,'dynsym_index':index}
def validate(lock,expected_sha=None,path=None):
    if expected_sha:
        need(path is not None and sha(path.read_bytes())==expected_sha,'input lock SHA mismatch')
    need(lock['schema']=='iq4_f1_actual_payload_set_01','actual payload lock schema')
    need(set(lock['roles'])=={'UI','display'} and lock['synthetic_fixture']==False,'requires actual two functional roles')
    revision=lock.get('UI_revision','01');need(revision in ('01','02','03'),'finite UI revision')
    display_revision=lock.get('display_revision','12');need(display_revision in ('12','13'),'finite display revision')
    source_paths={r['path']for r in lock['source_manifests']}
    need(source_paths=={f'tools/firmware/f1_user_ui_entry_{revision}/SOURCE_SHA256.json',f'tools/firmware/f1_stock_display_payload_{display_revision}/SOURCE_SHA256.json'},'source role/revision identity')
    expected_ui={f'analysis/firmware/f1_user_ui_entry_{revision}/{n}.o'for n in ('runtime','module','entry_binding_10','inspector','candidates','bootstrap','counter','ctor_wrapper','compare')}
    expected_display={f'analysis/firmware/f1_stock_display_payload_build_{display_revision}/payload.o',f'analysis/firmware/f1_stock_display_payload_build_{display_revision}/wrapper.o'}
    need({r['path']for r in lock['objects']}==expected_ui|expected_display,'actual finite object roles/revision identity')
    for r in lock['source_manifests']:check(r)
    for r in lock['support_evidence']:check(r)
    objects=[]
    for r in lock['objects']:
        p,data=check(r);objects.append((str(p.relative_to(ROOT)),data))
    need(len(objects)==11,'actual expected 9 UI + 2 display ET_REL set')
    lib_export(lock['original_libstdcxx']['path'])
    check(lock['original_libstdcxx'])
    return objects
def create(output,ui_revision='03',display_revision='13'):
    need(ui_revision in ('01','02','03'),'finite UI revision')
    need(display_revision in ('12','13'),'finite display revision')
    ui_meta=f'analysis/firmware/f1_user_ui_entry_{ui_revision}/OBJECTS_AND_BINDINGS.json'
    display_meta=f'tools/firmware/f1_stock_display_payload_{display_revision}/LINK_INPUT.json'
    ui=json.loads(local(ui_meta).read_text());display=json.loads(local(display_meta).read_text())
    source=[f'tools/firmware/f1_user_ui_entry_{ui_revision}/SOURCE_SHA256.json',f'tools/firmware/f1_stock_display_payload_{display_revision}/SOURCE_SHA256.json']
    for path in source:
        # Entire manifest identity is fixed, and each ordinary path row is checked
        # by the original author's validator, not silently translated here.
        need(local(path).is_file(),'payload author has not frozen source')
    objects=ui['objects']+display['objects']
    for r in objects:check(r)
    lib='analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf';proof=lib_export(lib)
    lock={'schema':'iq4_f1_actual_payload_set_01','roles':['UI','display'],'UI_revision':ui_revision,'display_revision':display_revision,'synthetic_fixture':False,
      'objects':objects,'source_manifests':[row(p)for p in source],
      'support_evidence':[row(ui_meta),row(display_meta),row('analysis/firmware/f1_user_ui_entry_01/TERMINATE_ORIGINAL_EXPORT.json')],
      'original_libstdcxx':row(lib),'new_import_original_export':proof,'target_executed':False}
    validate(lock);need(not output.exists(),'input lock must be fresh');output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(lock,indent=2,sort_keys=True)+'\n');print(sha(output.read_bytes()))
if __name__=='__main__':
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--output',type=Path,required=True);ap.add_argument('--ui-revision',choices=['03'],default='03');ap.add_argument('--display-revision',choices=['13'],default='13');a=ap.parse_args()
    try:create(a.output,a.ui_revision,a.display_revision)
    except (Reject,OSError)as e:raise SystemExit('REFUSED: '+str(e))
