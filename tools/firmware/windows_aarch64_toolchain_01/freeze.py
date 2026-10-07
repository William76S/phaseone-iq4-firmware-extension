#!/usr/bin/env python3
"""Freeze source plan, host archive tests and Mac-host public cross proof.

No Windows ZIP download, Windows compiler execution or private inputs here.
"""
import io
import json
from pathlib import Path
import shutil
import sys
import tempfile
import unittest
import zipfile

HERE=Path(__file__).resolve().parent;sys.path.insert(0,str(HERE))
import acquire as a
import probes as p
import test_toolchain
OUT=a.ROOT/'analysis/firmware/windows_aarch64_toolchain_01'

def main():
    OUT.mkdir(exist_ok=True);(OUT/'.gitignore').write_text('*.elf\n*.o\n*.zip\n')
    # Existing frozen record1 source identity, no edits to its old manifest.
    old=json.loads((a.ROOT/'analysis/firmware/record1_ram_restore_01/manifest.json').read_text())
    known=dict(old['files']);known.update(old['frozen_dependencies'])
    files={rel:a.sha((a.ROOT/rel).read_bytes()) for rel in p.SOURCE_PATHS}
    if any(known.get(rel)!=digest for rel,digest in files.items()):raise SystemExit('Frozen record1 dependency mismatch')
    a.dump(HERE/'source_dependencies.json',{'schema':'iq4_windows_public_source_dependencies_v1','files':files,
      'actual_private_inputs_included':False,'record1_frozen_manifest_sha256':a.whole_hash(a.ROOT/'analysis/firmware/record1_ram_restore_01/manifest.json')})
    buffer=io.StringIO();suite=unittest.defaultTestLoader.loadTestsFromModule(test_toolchain)
    result=unittest.TextTestRunner(stream=buffer,verbosity=2).run(suite)
    if not result.wasSuccessful():print(buffer.getvalue());raise SystemExit('Host validation failed')
    compiler=a.ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
    digest='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
    with tempfile.TemporaryDirectory(prefix='iq4_windows_toolchain_host_proof_') as name:
        proofdir=Path(name)/'public_probe';p.build(compiler,proofdir,digest,Windows_actual=False)
        saved=OUT/'Mac_host_public_compile';saved.mkdir(exist_ok=True)
        for rel in ['record1_EN0.elf','synthetic_io.o','config.h','synthetic_io.c','build.json']:
            # Wrapper's ephemeral absolute include path has only public source;
            # normalize the source record to ROOT notation before freeze.
            if rel=='synthetic_io.c':
                text=(proofdir/rel).read_text().replace(str(a.ROOT),'<PROJECT_ROOT>');(saved/rel).write_text(text)
            else:shutil.copyfile(proofdir/rel,saved/rel)
    a.dump(OUT/'host_validation.json',{'schema':'iq4_windows_zig_host_source_validation_v1','host_tests_run':result.testsRun,
      'host_tests_passed':True,'failures':len(result.failures),'errors':len(result.errors),
      'Windows_archive_downloaded':False,'Windows_compiler_executed':False,'Mac_host_public_AArch64_compile':True,
      'actual_private_profile_emitted':False,'private_originals_read':False,'device_accessed':False,'target_executed':False})
    (OUT/'host_test_output.txt').write_text('\n'.join(line.rstrip() for line in buffer.getvalue().splitlines() if line and not line.startswith('Ran '))+'\n')
    report=a.ROOT/'analysis/firmware/WINDOWS_AARCH64_TOOLCHAIN_01.md'
    public=[f for f in HERE.iterdir() if f.is_file()]+[OUT/'.gitignore',OUT/'host_validation.json',OUT/'host_test_output.txt',report]
    public += [saved/'build.json',saved/'config.h',saved/'synthetic_io.c']
    deps=[a.ROOT/rel for rel in p.SOURCE_PATHS]+[a.ROOT/'tools/target/toolchain.lock.json',a.ROOT/'analysis/firmware/record1_ram_restore_01/manifest.json']
    binaries=[saved/'record1_EN0.elf',saved/'synthetic_io.o']
    manifest={'schema':'iq4_windows_zig_toolchain01_source_freeze_v1','evidence_level':'official_archive_metadata_and_host_source_proof',
      'files':{str(f.relative_to(a.ROOT)):a.whole_hash(f) for f in sorted(public)},
      'frozen_dependencies':{str(f.relative_to(a.ROOT)):a.whole_hash(f) for f in deps},
      'ignored_rebuildable_public_artifacts':{str(f.relative_to(a.ROOT)):a.whole_hash(f) for f in binaries},
      'Windows_archive_downloaded':False,'Windows_compiler_executed':False,'private_originals_read':False,'actual_private_profile_emitted':False,'device_accessed':False,'target_executed':False}
    a.dump(OUT/'manifest.json',manifest)
    # Explicit public-only allowlist. No original, private profile, ELF/cache,
    # response or low-entropy credential digest can enter this source ZIP.
    package=set(public+[a.ROOT/rel for rel in p.SOURCE_PATHS])
    zip_path=OUT/'windows_aarch64_toolchain_01_source.zip'
    with zipfile.ZipFile(zip_path,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=9) as z:
        for f in sorted(package):
            info=zipfile.ZipInfo(str(f.relative_to(a.ROOT)),date_time=(2026,10,4,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=0o100644<<16
            z.writestr(info,f.read_bytes())
    print(json.dumps({'manifest_sha256':a.whole_hash(OUT/'manifest.json'),'public_source_zip_sha256':a.whole_hash(zip_path),'host_tests':result.testsRun,'Windows_actual':False,'device_accessed':False}))

if __name__=='__main__':main()
