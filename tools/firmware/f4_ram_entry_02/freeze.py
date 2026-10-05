#!/usr/bin/env python3
"""Host build/tests/hash snapshot. No target transport or target execution."""
import contextlib
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import subprocess
import sys
import unittest

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE))
import generate as g
import audit_build as audit
import test_entry as test

def main():
    subprocess.run([sys.executable,str(HERE/'generate.py')],check=True)
    subprocess.run([sys.executable,str(HERE/'audit_build.py')],check=True)
    buffer=io.StringIO();suite=unittest.defaultTestLoader.loadTestsFromModule(test)
    result=unittest.TextTestRunner(stream=buffer,verbosity=2).run(suite)
    if not result.wasSuccessful():print(buffer.getvalue());raise SystemExit('Host validation failed; no freeze')
    package=g.OUT/'preview_package'
    imports={name:audit.undefined((package/(name+'.elf')).read_bytes()) for name in ['entry','marker','readonly_facts']}
    forbidden={'kill','raise','ptrace','system','popen','execvp','dlopen','ioctl','pthread_create'}
    if any(set(v)&forbidden for v in imports.values()):raise SystemExit('Unexpected prohibited preview import')
    if set(imports['marker'])!={'send','close'}:raise SystemExit('Constructor import contract changed')
    readonly_forbidden={'write','rename','link','chmod','fchmod','fsync','execve','fork','pipe2','socket','unlink'}
    if set(imports['readonly_facts'])&readonly_forbidden:raise SystemExit('Readonly facts retained mutation branch')
    validation={'schema':'iq4_f4_ram_host_validation_v2','host_tests_run':result.testsRun,
      'host_tests_passed':result.wasSuccessful(),'failures':len(result.failures),'errors':len(result.errors),
      'verbatim_production_C_functions':test.EXTRACTED,'verbatim_functions_sha256':test.CFixtures.selected_sha,
      'source_sha256':g.sha((HERE/'entry.c').read_bytes()),
      'host_C_syscall_fixture_adaptations':['macOS flistxattr signature and automatic provenance only','AF_UNIX datagram pair for message ACK, not target seqpacket or credentials'],
      'target_imports':imports,'target_device_accessed':False,'target_executed':False,
      'actual_mount_User_exit_module_or_recovery_acceptance':False}
    g.dump(g.OUT/'host_validation.json',validation)
    (g.OUT/'host_test_output.txt').write_text('\n'.join(line.rstrip() for line in buffer.getvalue().splitlines() if line and not line.startswith('Ran '))+'\n')
    report=g.ROOT/'analysis/firmware/F4_RAM_ENTRY_IMPLEMENTATION_02.md'
    files=[p for p in HERE.iterdir() if p.is_file()]
    files+=list(package.glob('*.json'))+list(package.glob('*.h'))+list(package.glob('*.sh'))
    files+=[g.OUT/'compile_audit/build.json',g.OUT/'host_validation.json',g.OUT/'host_test_output.txt',g.OUT/'.gitignore',report]
    frozen=[g.ROOT/'analysis/firmware/f4_ram_loader_static/manifest.json',g.ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c',g.ROOT/'analysis/firmware/F4_RAM_ONE_SHOT_ENTRY_STATIC.md',g.ROOT/'tools/firmware/sys_exact16_argv_01/native_lexer_model.py']
    binary=list(package.glob('*.elf'))+[g.OUT/'compile_audit/all_branches.o']
    manifest={'schema':'iq4_f4_ram_entry02_freeze_v2','evidence_level':'host_and_cross_compile_only',
      'files':{str(p.relative_to(g.ROOT)):g.sha(p.read_bytes()) for p in sorted(files)},
      'frozen_dependencies':{str(p.relative_to(g.ROOT)):g.sha(p.read_bytes()) for p in frozen},
      'ignored_rebuildable_binary_artifacts':{str(p.relative_to(g.ROOT)):g.sha(p.read_bytes()) for p in binary},
      'enabled_device_profile_emitted':False,'device_accessed':False,'target_executed':False}
    g.dump(g.OUT/'manifest.json',manifest)
    print(json.dumps({'manifest_sha256':g.sha((g.OUT/'manifest.json').read_bytes()),'files':len(manifest['files']),'tests':result.testsRun,'actual_acceptance':False}))

if __name__=='__main__':main()
