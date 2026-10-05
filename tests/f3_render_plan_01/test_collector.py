#!/usr/bin/env python3
import importlib.util, json, tempfile, unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('f3_collector',ROOT/'tools/firmware/f3_render_plan_01/collect_static.py')
c=importlib.util.module_from_spec(spec);spec.loader.exec_module(c)
class CollectorTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):cls.image=c.ExactImage(c.ORIGINAL)
    def test_program_header_mapping(self):
        off,data=self.image.get(0x48c7d4,4)
        self.assertEqual(off,0x8c7d4);self.assertEqual(data.hex(),'ef0a0094')
    def test_filebacked_only(self):
        with self.assertRaises(ValueError):self.image.get(0,4)
    def test_limit(self):
        with self.assertRaises(ValueError):self.image.get(0x400000,65537)
        with self.assertRaises(ValueError):self.image.get((1<<64)-1,2)
    def test_negative_bl_is_decoded(self):
        self.assertEqual(c.bl_target(0x7b8250,0x94000577),0x7b982c)
        self.assertEqual(c.bl_target(0x963f44,0x97fed785),0x919d58)
        with self.assertRaises(ValueError):c.bl_target(0x48c7d4,0xd65f03c0)
    def test_short_original_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'short';p.write_bytes(b'\x7fELF')
            with self.assertRaises(ValueError):c.ExactImage(p)
    def test_one_changed_byte_rejected(self):
        with tempfile.TemporaryDirectory() as d:
            p=Path(d)/'wrong-original';copy=bytearray(self.image.data);copy[-1]^=1;p.write_bytes(copy)
            with self.assertRaises(ValueError):c.ExactImage(p)
        self.assertEqual(c.sha(c.ORIGINAL.read_bytes()),c.SHA)
if __name__=='__main__':
    suite=unittest.defaultTestLoader.loadTestsFromTestCase(CollectorTests)
    result=unittest.TextTestRunner(verbosity=2).run(suite)
    report={'schema':'iq4_f3_collector_host_01','tests':result.testsRun,
            'failed':len(result.failures),'errors':len(result.errors),
            'original_preserved':c.sha(c.ORIGINAL.read_bytes())==c.SHA,
            'target_executed':False}
    p=ROOT/'evidence/f3_render_plan_01/COLLECTOR_TESTS.json'
    p.write_text(json.dumps(report,indent=2)+'\n')
    raise SystemExit(not result.wasSuccessful())
