#!/usr/bin/env python3
"""Local source-closure plan/ZIP only. Never compile, execute firmware or connect."""
from __future__ import annotations
import argparse, hashlib, json, re, shlex, zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
SCHEMA = 'iq4_f1_card_source_closure_01'
TEXT = {'.c', '.cpp', '.h', '.hpp', '.S', '.inc', '.py', '.md', '.json', '.txt', '.ld', '.d'}
UI_NAMES = ('runtime', 'module', 'entry_binding_10', 'inspector', 'candidates',
            'bootstrap', 'counter', 'ctor_wrapper', 'compare')
VENDOR = {
 'analysis/firmware/extracted/P1Linux_6.03.21.bin': (11874544, '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb', 'link input'),
 'analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf': (None, '5876c5861ffae1b3f6a5fc091be8f1d601edf602ebeed6a4aa3bf5c3cfbe11aa', 'terminate export proof/link input'),
 'analysis/firmware/vendor_downloads/stock_fwp_01/XFSystem8.02.0.fwp': (80158711, '3dfb12c9417d60a0838a5abbfe3adccba2f242a79bab5f9ffa312be097571252', 'card wrapper input'),
 '../Firmware-BP-IQ4-IQ4_6.03.18.fwr': (78351289, 'a52758ffb163023e5323297e450450f91002175b69bed7590fe2cd037c2ab300', 'card wrapper input'),
 'analysis/firmware/P1_ramdisk.ext2': (134217728, '2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb', 'historical UI full-validator input; not needed for compile/link'),
 'analysis/firmware/extracted/Boot_4.00.13.bin': (71874288, '7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e', 'unchanged stock package/kernel context; not needed for compiler replay'),
}
class Refused(ValueError): pass
def need(ok, why):
    if not ok: raise Refused(why)
def sha(data): return hashlib.sha256(data).hexdigest()
def local(root, name):
    p = root / name
    need(not p.is_symlink() and p.resolve().is_relative_to(root.resolve()), 'nonlocal/symlink source: '+name)
    need(p.is_file(), 'missing source: '+name)
    return p
def source_bytes(root, name):
    p = local(root, name)
    need(p.suffix in TEXT and p.stat().st_size <= 16*1024*1024, 'not bounded source text: '+name)
    data = p.read_bytes()
    need(not data.startswith((b'\x7fELF', b'MZ', b'PK\x03\x04')), 'binary forbidden in source bundle: '+name)
    data.decode('utf-8')
    return data
def record(root, name):
    b = source_bytes(root, name)
    return {'path':name, 'bytes':len(b), 'sha256':sha(b)}
def make_dependencies(text):
    """Parse the actual one-rule Clang/Zig depfiles, including escaped spaces."""
    text = text.replace('\\\r\n', ' ').replace('\\\n', ' ')
    need(':' in text, 'dependency rule missing colon')
    target, tail = text.split(':', 1)
    need(bool(shlex.split(target)), 'empty dependency target')
    return shlex.split(tail)
def normalize_dep(root, name):
    p = Path(name); p = p if p.is_absolute() else root/p
    p = p.resolve()
    need(p.is_relative_to(root.resolve()), 'dependency outside project/toolchain: '+name)
    return p.relative_to(root.resolve()).as_posix()
def quoted_closure(root, seeds):
    result, todo = set(), list(seeds)
    while todo:
        name = todo.pop()
        if name in result: continue
        data = source_bytes(root,name); result.add(name)
        for match in re.finditer(r'^\s*#\s*include\s*"([^"\n]+)"', data.decode(), re.M):
            child = normalize_dep(root,str((root/name).parent/match.group(1)))
            if child not in result: todo.append(child)
    return result
def manifest_rows(j):
    rows=[]
    for group in ('members', 'frozen_refs', 'review_artifacts', 'artifacts'):
        for r in j.get(group, []):
            if isinstance(r,dict) and 'path' in r: rows.append((group,r))
    for name,r in j.get('files',{}).items():
        if isinstance(r,dict): rows.append(('files',dict(r,path=name)))
    return rows
def compile_records(root, revision):
    names=[f'analysis/firmware/f1_user_ui_entry_{revision}/OBJECTS_AND_BINDINGS.json',
           'analysis/firmware/f1_stock_display_payload_build_12/BUILD.json']
    rows=[]
    for name in names:
        j=json.loads(source_bytes(root,name))
        for argv in j['commands']:
            if '-c' not in argv or '-o' not in argv: continue
            if Path(argv[0]).name!='zig': continue # never include host test invocations
            src=normalize_dep(root,argv[argv.index('-c')+1])
            out=normalize_dep(root,argv[argv.index('-o')+1])
            need(out.endswith('.o'), 'nonobject compiler output')
            rows.append({'source':src,'output':out,'original_argv':argv,'record':name})
    need(len(rows)==11 and len({r['output']for r in rows})==11, 'requires actual nine UI/two display compile records')
    return names, rows
def plan(root=ROOT, revision='02'):
    need(revision in ('01','02'), 'finite UI revision')
    sources=set(); deps=set(); tool_deps=set(); drows=[]
    for stem in UI_NAMES:
        name=f'analysis/firmware/f1_user_ui_entry_{revision}/{stem}.d'
        drows.append(record(root,name));sources.add(name)
        for raw in make_dependencies(source_bytes(root,name).decode()):
            rel=normalize_dep(root,raw)
            if rel.startswith('build/toolchains/'): tool_deps.add(rel)
            else:
                need(rel.startswith(('tools/firmware/','src/')), 'unexpected actual compile input '+rel)
                source_bytes(root,rel);deps.add(rel)
    sources|=deps
    # Display12 never emitted .d. Record its real local quoted include closure;
    # do not claim a nonexistent compiler dependency file was checked.
    display=quoted_closure(root,{'tools/firmware/f1_stock_display_payload_12/payload.c',
                               'tools/firmware/f1_stock_display_payload_12/wrapper.S'})
    sources|=display
    dirs=['f1_user_ui_entry_01',f'f1_user_ui_entry_{revision}',
          'f1_stock_display_payload_12','f1_user_elf_append_01',
          'user_only_package_stock_wrapper_02','user_only_package_01','f1_card_source_bundle_01']
    for d in set(dirs):
        for p in (root/'tools/firmware'/d).iterdir():
            if p.is_file() and p.suffix in TEXT and not p.name.startswith('.'):
                sources.add(p.relative_to(root).as_posix())
    # Complete explicitly-used derivation sources; historic materialize/freeze
    # scripts are retained, but their other research validators are not promised.
    extra=['tools/target/toolchain.lock.json','tools/firmware/f1_user_elf_integration_12/inspect.py',
           'tools/firmware/f1_module_entry_01/module.hpp','tools/firmware/f1_module_entry_01/module.cpp',
           'tools/firmware/f1_native_ui_02/ui.cpp',
           'tools/firmware/f1_scaler_hook_install_11/entry_binding_10.hpp',
           'tools/firmware/f1_scaler_hook_install_11/entry_binding_10.cpp',
           'tools/firmware/f1_scaler_hook_install_11/SOURCE_SHA256.json',
           'analysis/firmware/f1_user_ui_entry_01/TERMINATE_ORIGINAL_EXPORT.json']
    sources.update(extra)
    for base in ('src/core/include','src/display/include'):
        sources.update(p.relative_to(root).as_posix() for p in (root/base).rglob('*') if p.is_file() and p.suffix in TEXT)
    meta, commands=compile_records(root,revision);sources.update(meta)
    sources.add('tools/firmware/f1_stock_display_payload_12/LINK_INPUT.json')
    manifests=sorted(n for n in sources if n.endswith('SOURCE_SHA256.json'))
    refs=[]
    for name in manifests:
        for group,r in manifest_rows(json.loads(source_bytes(root,name))):
            rel=r['path']
            category=('bundled_source' if rel in sources else
                      'external_toolchain' if rel.startswith('build/toolchains/') else
                      'external_vendor_input' if rel in VENDOR else
                      'not_bundled_historical_reference')
            if category=='bundled_source':
                actual=record(root,rel)
                need(actual['bytes']==r['bytes'] and actual['sha256']==r['sha256'], 'frozen bundled ref changed '+rel)
            refs.append({'manifest':name,'group':group,'classification':category,**r})
    externals=[]
    for name,(size,digest,role)in VENDOR.items():
        p=root/name;available=p.is_file() and not p.is_symlink()
        n=p.stat().st_size if available else size
        if available:
            need((size is None or n==size)and sha(p.read_bytes())==digest,'exact local OEM input changed '+name)
        externals.append({'path':name,'bytes':n,'sha256':digest,'role':role,'available_at_plan':available,'included_in_ZIP':False})
    # Other OEM binary refs (e.g. Boot or pthread) are provenance, not unnoticed
    # bundle members or new inputs. Their exact original manifest rows remain.
    known={r['path']for r in externals}
    for r in refs:
        if r['classification']=='external_vendor_input'and r['path']not in known:
            externals.append({k:r[k]for k in ('path','bytes','sha256')}|{'role':'historical manifest input; not used by current compiler replay','included_in_ZIP':False});known.add(r['path'])
    rows=[record(root,n)for n in sorted(sources)]
    backend=[r for r in rows if r['path'].startswith('tools/firmware/f1_user_elf_append_01/')]
    backend_digest=sha((json.dumps(backend,sort_keys=True,separators=(',',':'))+'\n').encode())
    ui_manifest=f'tools/firmware/f1_user_ui_entry_{revision}/SOURCE_SHA256.json'
    ui_frozen=ui_manifest in sources
    return {'schema':SCHEMA,'UI_revision':revision,'original_project_root':str(root.resolve()),
      'members':rows,'actual_UI_dependency_files':drows,'actual_UI_compile_inputs':sorted(deps),
      'display_dependency_method':'local quoted includes; original display build has no .d',
      'display_local_include_closure':sorted(display),'toolchain_dependency_count':len(tool_deps),
      'toolchain_lock':json.loads(source_bytes(root,'tools/target/toolchain.lock.json')),
      'compiler_records':commands,'reference_dispositions':refs,'external_inputs':externals,
      'external_runtime_requirement':{'path':'/lib/libpthread-2.28.so','bytes':105736,'sha256':'9305ff30980749a3f64b3e445764db2bc378d14d1ef8bbe004d0ecc768d00f77','source':'UI02 native_helpers.inc runtime verification; from stock rootfs','included_in_ZIP':False,'actual_camera_identity_verified':False},
      'backend_source_set_sha256':backend_digest,'UI_source_frozen':ui_frozen,
      'UI_source_manifest_sha256':sha(source_bytes(root,ui_manifest)) if ui_frozen else None,
      'original_full_freeze_validators_runnable_from_ZIP_alone':False,
      'original_validator_limit':'Historical validators require listed toolchain/vendor/review artifacts; bundle verification covers its own complete member set, not omitted rows.',
      'compile_project_source_closure_complete':all(r['source']in sources for r in commands),
      'target_executed':False,'camera_or_SDK_operations':0,'vendor_binaries_included':False}
def verify_members(root,j):
    need(j['schema']==SCHEMA,'source bundle schema')
    for row in j['members']: need(record(root,row['path'])==row,'bundle source changed '+row['path'])
def emit(root,j,path,ui_sha,backend_sha):
    need(j['UI_revision']=='02'and j['UI_source_frozen'],'final source ZIP requires separately frozen UI02')
    need(ui_sha==j['UI_source_manifest_sha256']and backend_sha==j['backend_source_set_sha256'],'explicit final source-set SHA mismatch')
    verify_members(root,j);need(not path.exists(),'ZIP must be a new local file')
    path.parent.mkdir(parents=True,exist_ok=True)
    with path.open('xb')as out:
        with zipfile.ZipFile(out,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9)as z:
            for row in j['members']:
                i=zipfile.ZipInfo(row['path'],date_time=(2026,1,1,0,0,0));i.compress_type=zipfile.ZIP_DEFLATED;i.external_attr=0o100644<<16
                z.writestr(i,source_bytes(root,row['path']))
            i=zipfile.ZipInfo('BUNDLE_MANIFEST.json',date_time=(2026,1,1,0,0,0));i.compress_type=zipfile.ZIP_DEFLATED;i.external_attr=0o100644<<16
            z.writestr(i,(json.dumps(j,indent=2,sort_keys=True)+'\n').encode())
    return {'path':str(path),'bytes':path.stat().st_size,'sha256':sha(path.read_bytes()),'source_files':len(j['members'])}
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--ui-revision',choices=('01','02'),default='02');p.add_argument('--plan-output',type=Path)
    p.add_argument('--verify-bundle',type=Path);p.add_argument('--emit-zip',type=Path)
    p.add_argument('--expected-ui-source-sha256');p.add_argument('--expected-backend-source-set-sha256');a=p.parse_args()
    if a.verify_bundle:
        need(not a.emit_zip and not a.plan_output,'verification is separate');j=json.loads(a.verify_bundle.read_text());verify_members(ROOT,j)
        print(json.dumps({'bundle_sources_verified':len(j['members']),'target_executed':False}));return
    j=plan(ROOT,a.ui_revision)
    if a.plan_output:
        need(not a.plan_output.exists(),'plan output must be fresh');a.plan_output.parent.mkdir(parents=True,exist_ok=True)
        a.plan_output.write_text(json.dumps(j,indent=2,sort_keys=True)+'\n')
    if a.emit_zip:print(json.dumps(emit(ROOT,j,a.emit_zip,a.expected_ui_source_sha256,a.expected_backend_source_set_sha256)))
    else:print(json.dumps({k:j[k]for k in ('schema','UI_revision','UI_source_frozen','UI_source_manifest_sha256','backend_source_set_sha256','toolchain_dependency_count','compile_project_source_closure_complete')}|{'source_files':len(j['members']),'vendor_binaries_included':False,'target_executed':False}))
if __name__=='__main__':
    try:main()
    except (Refused,OSError,UnicodeError,KeyError,ValueError)as e:raise SystemExit('REFUSED: '+str(e))
