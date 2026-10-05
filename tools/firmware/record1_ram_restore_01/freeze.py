#!/usr/bin/env python3
"""Freeze synthetic host tests, inert cross build and finite production source."""
import io
import json
from pathlib import Path
import subprocess
import sys
import unittest

HERE=Path(__file__).resolve().parent;sys.path.insert(0,str(HERE))
import generate as g
import audit_build as audit
import test_binding
import test_engine

def main():
    subprocess.run([sys.executable,str(HERE/'generate.py')],check=True)
    subprocess.run([sys.executable,str(HERE/'audit_build.py')],check=True)
    suite=unittest.TestSuite(unittest.defaultTestLoader.loadTestsFromModule(m) for m in [test_engine,test_binding])
    buffer=io.StringIO();result=unittest.TextTestRunner(stream=buffer,verbosity=2).run(suite)
    if not result.wasSuccessful():print(buffer.getvalue());raise SystemExit('Host validation failed')
    names=audit.a.undefined((g.OUT/'preview/record1.elf').read_bytes())
    if set(names)&{'open','pread','pwrite','read','readlink','write','flock','kill','execve','system','popen','dlopen','ioctl'}:raise SystemExit('Unbound preview retained device branch')
    g.dump(g.OUT/'host_validation.json',{'schema':'iq4_record1_host_validation_v1','host_tests_run':result.testsRun,
      'host_tests_passed':True,'failures':len(result.failures),'errors':len(result.errors),
      'actual_production_engine_compiled_for_host':True,'host_regular_file_pwrite_fixture':True,
      'target_kernel_provider_or_device_acceptance':False,'changed_then_restored_coldboot_verified':False,
      'persistent_unlock_verified':False,'actual_original_read':False,'actual_private_profile_emitted':False,
      'device_accessed':False,'target_executed':False,'unbound_preview_imports':names})
    (g.OUT/'host_test_output.txt').write_text('\n'.join(line.rstrip() for line in buffer.getvalue().splitlines() if line and not line.startswith('Ran '))+'\n')
    report=g.ROOT/'analysis/firmware/RECORD1_RAM_RESTORE_IMPLEMENTATION_01.md'
    files=[p for p in HERE.iterdir() if p.is_file()]
    files += [g.OUT/'.gitignore',g.OUT/'preview/config.h',g.OUT/'preview/build.json',g.OUT/'compile_audit/build.json',g.OUT/'host_validation.json',g.OUT/'host_test_output.txt',report]
    deps=[g.ROOT/'tools/firmware/f4_ram_entry_02/sha256.h',g.ROOT/'tools/firmware/f4_ram_entry_02/audit_build.py',
      g.ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c',g.ROOT/'tools/firmware/audit_security_record1_range.py',
      g.ROOT/'tools/firmware/validate_security_eeprom_structure.py',g.ROOT/'analysis/firmware/PIN_RECORD1_OPAQUE_RESTORE_STATIC.md',
      g.ROOT/'analysis/firmware/pin_record1_opaque_restore_static/manifest.json',g.ROOT/'analysis/firmware/SYS_EEPROM_RANGE_RESTORE_STATIC.md',
      g.ROOT/'analysis/firmware/sys_eeprom_range_restore_static/manifest.json',g.ROOT/'analysis/firmware/SECURITY_PIN_CLEAR_NATIVE_STATIC.md',
      g.ROOT/'analysis/firmware/security_pin_clear_native_static/manifest.json']
    binaries=[g.OUT/'preview/record1.elf',g.OUT/'compile_audit/all_branches.o']
    manifest={'schema':'iq4_record1_ram_restore01_freeze_v1','evidence_level':'synthetic_host_and_cross_compile_only',
      'files':{str(p.relative_to(g.ROOT)):g.sha(p.read_bytes()) for p in sorted(files)},
      'frozen_dependencies':{str(p.relative_to(g.ROOT)):g.sha(p.read_bytes()) for p in deps},
      'ignored_rebuildable_inert_or_ET_REL_artifacts':{str(p.relative_to(g.ROOT)):g.sha(p.read_bytes()) for p in binaries},
      'actual_private_profile_emitted':False,'device_accessed':False,'target_executed':False,
      'changed_then_restored_coldboot_verified':False,'persistent_unlock_verified':False}
    g.dump(g.OUT/'manifest.json',manifest)
    print(json.dumps({'manifest_sha256':g.sha((g.OUT/'manifest.json').read_bytes()),'files':len(files),'tests':result.testsRun,'actual_acceptance':False}))

if __name__=='__main__':main()
