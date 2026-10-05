#!/usr/bin/env python3
"""Replay only the eleven recorded compiler invocations; never run target code.

Use an extracted source tree with no existing .o files. This does not run old
materialize.py/freeze.py or assert that their omitted review artifacts exist.
"""
from __future__ import annotations
import argparse, hashlib, importlib.util, json, subprocess, sys
from pathlib import Path
from bundle import ROOT, SCHEMA, Refused, need, verify_members, local, sha

def verify_toolchain(j,zig):
    need(zig.is_file()and sha(zig.read_bytes())==j['toolchain_lock']['zig_binary_sha256'],'compiler SHA mismatch')
    prefix='build/toolchains/zig-aarch64-macos-0.15.2/'
    refs={}
    for r in j['reference_dispositions']:
        if r['classification']!='external_toolchain':continue
        need(r['path'].startswith(prefix),'unexpected third-party toolchain root')
        rel=r['path'][len(prefix):];expected=(r['bytes'],r['sha256'])
        need(rel not in refs or refs[rel]==expected,'conflicting frozen toolchain refs')
        refs[rel]=expected
    need(len(refs)>=j['toolchain_dependency_count'],'missing exact referenced toolchain files')
    for rel,(n,digest)in refs.items():
        p=zig.parent/rel;need(p.is_file()and p.stat().st_size==n and sha(p.read_bytes())==digest,'referenced toolchain file changed '+rel)
    return len(refs)

def compiler_commands(j, root, zig):
    old=Path(j['original_project_root'])
    rows=[]
    for r in j['compiler_records']:
        argv=[]
        for arg in r['original_argv']:
            p=Path(arg)
            if p.is_absolute()and p.is_relative_to(old):arg=str(root/p.relative_to(old))
            argv.append(arg)
        argv[0]=str(zig)
        if '-MF'in argv:
            argv[argv.index('-MF')+1]=str(root/'build/f1_source_replay_02/deps'/(Path(r['output']).stem+'.d'))
        need('-c'in argv and '-o'in argv and argv[1]in ('cc','c++'),'compile-only invocation')
        need(Path(argv[argv.index('-c')+1]).resolve()==local(root,r['source']).resolve(),'recorded source mismatch')
        out=root/r['output']
        need(out.resolve().is_relative_to(root.resolve())and not out.exists(),'fresh object output required '+r['output'])
        need(Path(argv[argv.index('-o')+1]).resolve()==out.resolve(),'recorded output mismatch')
        rows.append((r,argv,out))
    need(len(rows)==11,'exact eleven compiler invocations')
    return rows
def write_replay_receipt(root,j,commands):
    def obj(name):
        p=root/name;b=p.read_bytes();need(b[:7]==b'\x7fELF\x02\x01\x01','compiler output not ELF64 LE')
        need(int.from_bytes(b[16:18],'little')==1 and int.from_bytes(b[18:20],'little')==183,'output must remain AArch64 ET_REL')
        return {'path':name,'bytes':len(b),'sha256':sha(b)}
    ui=[obj(r['output'])for r in j['compiler_records']if 'f1_user_ui_entry_'in r['output']]
    display=[obj(r['output'])for r in j['compiler_records']if 'f1_stock_display_payload_build_13'in r['output']]
    need(len(ui)==9 and len(display)==2,'rebuilt role separation')
    provenance={'schema':'iq4_source_bundle_recompiled_objects_02','bundle_members_digest':sha((json.dumps(j['members'],sort_keys=True,separators=(',',':'))+'\n').encode()),
      'original_project_root':j['original_project_root'],'replay_project_root':str(root),
      'target_executed':False,'old_freeze_manifest_artifact_rows_revalidated':False,
      'whole_object_hash_identity_claimed':False,
      'limitation':'UI objects include DWARF paths; changed source-root paths can change whole .o hashes. The backend discards nonallocated debug sections. Independently compare the final User against its actual final hash.',
      'commands':commands,'objects':ui+display}
    dest=root/'analysis/firmware/f1_card_source_replay_02/REPLAY.json'
    need(not dest.exists(),'fresh replay receipt');dest.parent.mkdir(parents=True,exist_ok=True)
    dest.write_text(json.dumps(provenance,indent=2,sort_keys=True)+'\n')
    return dest
def create_replay_lock(root,j,output):
    """Use the actual rebuilt .o hashes with the original finite backend API."""
    receipt=root/'analysis/firmware/f1_card_source_replay_02/REPLAY.json'
    r=json.loads(receipt.read_text())
    need(r['schema']=='iq4_source_bundle_recompiled_objects_02'and not r['target_executed'],'actual replay receipt required')
    need(r['bundle_members_digest']==sha((json.dumps(j['members'],sort_keys=True,separators=(',',':'))+'\n').encode()),'replay source-set identity mismatch')
    backend=root/'tools/firmware/f1_user_elf_append_02';sys.path.insert(0,str(backend))
    spec=importlib.util.spec_from_file_location('source_bundle_original_lock',backend/'input_lock.py')
    original=importlib.util.module_from_spec(spec);spec.loader.exec_module(original)
    source=[f"tools/firmware/f1_user_ui_entry_{j['UI_revision']}/SOURCE_SHA256.json",'tools/firmware/f1_stock_display_payload_13/SOURCE_SHA256.json']
    lib='analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf'
    lock={'schema':'iq4_f1_actual_payload_set_01','roles':['UI','display'],'UI_revision':'03','display_revision':'13','synthetic_fixture':False,
      'objects':r['objects'],'source_manifests':[original.row(n)for n in source],
      'support_evidence':[original.row(str(receipt.relative_to(root)))],
      'original_libstdcxx':original.row(lib),'new_import_original_export':original.lib_export(lib),
      'target_executed':False,'compiler_replay_not_original_object_identity':True}
    original.validate(lock);need(not output.exists(),'fresh actual replay lock required')
    output.parent.mkdir(parents=True,exist_ok=True);output.write_text(json.dumps(lock,indent=2,sort_keys=True)+'\n')
    return sha(output.read_bytes())
def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--manifest',type=Path,default=ROOT/'BUNDLE_MANIFEST.json')
    ap.add_argument('--zig',type=Path);ap.add_argument('--compile-objects',action='store_true');ap.add_argument('--make-payload-lock',type=Path);a=ap.parse_args()
    j=json.loads(a.manifest.read_text());need(j['schema']==SCHEMA and j['UI_revision']=='03'and j['UI_source_frozen']and j['backend_source_frozen'],'final frozen source closure required')
    verify_members(ROOT,j)
    if a.make_payload_lock:
        need(not a.compile_objects,'lock creation is a separate read-only review step')
        print(json.dumps({'payload_lock_sha256':create_replay_lock(ROOT,j,a.make_payload_lock),'target_executed':False}));return
    need(a.zig is not None and a.zig.is_file(),'exact local compiler missing')
    toolchain_files=verify_toolchain(j,a.zig.resolve())
    rows=compiler_commands(j,ROOT,a.zig.resolve())
    if not a.compile_objects:
        print(json.dumps({'compile_commands':len(rows),'exact_toolchain_files_verified':toolchain_files,'default':'file-only preflight; no compiler/target/SDK run','target_executed':False}));return
    version=subprocess.run([str(a.zig.resolve()),'version'],check=True,text=True,capture_output=True)
    need(version.stdout.strip()==j['toolchain_lock']['version'],'compiler version mismatch')
    commands=[]
    for r,argv,out in rows:
        out.parent.mkdir(parents=True,exist_ok=True)
        if '-MF'in argv:
            d=Path(argv[argv.index('-MF')+1]);d.parent.mkdir(parents=True,exist_ok=True)
        result=subprocess.run(argv,cwd=ROOT,text=True,capture_output=True)
        commands.append({'argv':argv,'exit':result.returncode,'stdout':result.stdout,'stderr':result.stderr,'target_executed':False})
        need(result.returncode==0,'compiler failed for '+r['source']+'\n'+result.stderr)
    dest=write_replay_receipt(ROOT,j,commands)
    print(json.dumps({'compiled_ET_REL_objects':11,'receipt':str(dest),'target_executed':False,'firmware_generated':False}))
if __name__=='__main__':
    try:main()
    except (Refused,OSError,KeyError,ValueError,subprocess.CalledProcessError)as e:raise SystemExit('REFUSED: '+str(e))
