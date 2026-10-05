#!/usr/bin/env python3
"""Record real synthetic host tests. Does not execute the target or monitor PID."""
from pathlib import Path
import hashlib
import io
import json
import unittest

ROOT = Path(__file__).resolve().parents[3]
SOURCE = Path(__file__).resolve().parent
OUT = ROOT / 'analysis/firmware/f4_ram_loader_static/host_validation.json'


class RecordedResult(unittest.TextTestResult):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.passed = []

    def addSuccess(self, test):
        super().addSuccess(test)
        self.passed.append(test.id())


def main():
    suite = unittest.defaultTestLoader.discover(str(SOURCE), pattern='test_*.py')
    stream = io.StringIO()
    result = unittest.TextTestRunner(stream=stream, verbosity=2,
                    resultclass=RecordedResult).run(suite)
    if not result.wasSuccessful():
        print(stream.getvalue())
        raise SystemExit(1)
    assert result.testsRun == 18 and len(result.passed) == 18
    source_hashes = {str(p.relative_to(ROOT)): hashlib.sha256(p.read_bytes()).hexdigest()
                     for p in sorted(SOURCE.iterdir()) if p.suffix in ['.py', '.c', '.md']}
    receipt = {'evidence_level': 'host_synthetic_tests_only', 'tests_run': result.testsRun,
               'passed_test_ids': sorted(result.passed), 'failures': [], 'errors': [],
               'skipped': [], 'sources_sha256': source_hashes,
               'test_fixtures': ['C parser of synthetic proc stat bytes',
                                 'one-shot pure state model',
                                 'host temporary-directory inode/open-fd fixture'],
               'device_accessed': False, 'SDK_loaded': False,
               'target_executed': False, 'actual_pid_monitored': False}
    OUT.write_text(json.dumps(receipt, indent=2) + '\n')
    print(json.dumps({'tests_passed': result.testsRun,
                      'receipt_sha256': hashlib.sha256(OUT.read_bytes()).hexdigest()}))


if __name__ == '__main__':
    main()
