#!/usr/bin/env python3
"""Freeze host-only Sys read planner/validator and its synthetic checks."""
import io
import json
from pathlib import Path
import unittest
from save_setup_security_collect_static import ROOT, sha, dump
from sys_read_backup_host import discovery_commands
import test_sys_read_backup_host

OUT = ROOT / 'analysis/firmware/sys_read_backup_host'
REPORT = ROOT / 'analysis/firmware/SYS_READ_BACKUP_HOST_CONTRACT.md'
REFERENCES = {
    'analysis/firmware/SECURITY_EEPROM_SYS_READ_CONTRACT_STATIC.md':
        'b26ae807808313c5cda2ff3bed5cfcee568edd4934600bec30e8f77e6dc9933e',
    'analysis/firmware/DEVELOPMENT_SHELL_LIFECYCLE_STATIC.md':
        'af9f35349835b14c566dc959d7157e9bf3bb06ed429fa7b3398f2974043afafb',
    'tools/firmware/validate_security_eeprom_structure.py':
        '1a689c94e4756042ad6633b568e57ed4c61d962d03593809648093aafcd3d4a8',
}


def main():
    for rel, expected in REFERENCES.items():
        assert sha((ROOT/rel).read_bytes()) == expected, rel
    OUT.mkdir(exist_ok=True)
    stream = io.StringIO()
    suite = unittest.defaultTestLoader.loadTestsFromModule(test_sys_read_backup_host)
    ids = [case.id() for sub in suite for case in sub]
    result = unittest.TextTestRunner(stream=stream,verbosity=2).run(suite)
    assert result.wasSuccessful(), stream.getvalue()
    dump(OUT/'synthetic_checks.json', {
        'scope':'host-only synthetic data, no device or SDK', 'tests':ids,
        'tests_run':result.testsRun,'failures':len(result.failures),'errors':len(result.errors),
        'passed':result.wasSuccessful(),'device_accessed':False,'sdk_loaded':False,
        'target_or_OS_commands_executed':False,'actual_originals_read':False,
        'device_unlock_attempted':False})
    dump(OUT/'discovery_host_only_plan.json', {
        'evidence_level':'host_only_plan_not_camera_acceptance', 'camera_accessed':False,
        'outgoing_wire_created':False,'not_a_demonstrated_channel_or_tool':True,
        'commands':[c.public_plan() for c in discovery_commands('12345678ab')]})
    files = [p for p in sorted(OUT.iterdir()) if p.is_file() and p.name!='manifest.json']
    files += [REPORT,Path(__file__).resolve(),
              ROOT/'tools/firmware/sys_read_backup_host.py',
              ROOT/'tools/firmware/test_sys_read_backup_host.py']
    dump(OUT/'manifest.json', {
        'evidence_level':'host_only_synthetic_validation', 'device_accessed':False,
        'referenced_frozen_sha256':REFERENCES,
        'files':{str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in files}})
    print(f'{result.testsRun} host-only synthetic tests passed; '
          f'manifest {sha((OUT/"manifest.json").read_bytes())}')


if __name__=='__main__':
    main()
