"""Synthetic proof/opaque bytes only. No private profile files or device."""
import copy
import importlib.util
from pathlib import Path
import unittest
from test_engine import image,OFFSET

HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('r1gen',HERE/'generate.py');g=importlib.util.module_from_spec(spec);spec.loader.exec_module(g)

def fixture_proof(role='clear'):
    raw=image();receipt=b'synthetic fixture; not an actual receipt\n'
    gates=g.COMMON_GATES+([] if role=='read' else g.WRITE_GATES)+(g.CLEAR_GATES if role=='clear' else [])
    p={k:True for k in gates}
    p.update(schema='iq4_record1_private_binding_v1',operator='root_windows_unique_executor',role=role,
      actual_extent=0x4000,whole_original_sha256=g.sha(raw),leaf='/sys/devices/synthetic-eeprom/eeprom',
      metadata={'inode':999999,'major':0,'minor':10,'mode':0o600,'stat_size':0,'uid':0,'gid':0,'kind':'regular_binary_attribute'},
      actual_driver='at24',actual_kernel='SYNTHETIC_ONLY',
      User={'sha256':g.USER_SHA,'canonical_path':'/mnt/qspi/User/p1linux','pid':2,'start_ticks':123},
      RAM_state={'path':'/run/iq4_record1_01','fstype':'tmpfs','major':0,'minor':11},
      receipts={k:{'path':'synthetic_only.json','sha256':g.sha(receipt)} for k in gates})
    return p,raw,receipt

class Binding(unittest.TestCase):
    def test_synthetic_scope_and_private_opaque_mapping(self):
        p,raw,receipt=fixture_proof();off,opaque,role=g.validate(p,raw,raw,lambda _:receipt)
        self.assertEqual(off,OFFSET);self.assertEqual(opaque,raw[OFFSET:OFFSET+16])
        c=g.private_config(p,off,opaque,role)
        self.assertIn('R1_KERNEL "SYNTHETIC_ONLY"',c);self.assertIn('R1_EEP_STAT_SIZE 0LL',c)
        self.assertNotIn('R1_OFFSET 0U',c)
    def test_each_actual_gate_false_wrong_type_and_missing_refused(self):
        p,raw,receipt=fixture_proof()
        for k in g.COMMON_GATES+g.WRITE_GATES+g.CLEAR_GATES:
            for v in [False,None,1,'true']:
                q=copy.deepcopy(p);q[k]=v
                with self.assertRaises(ValueError):g.validate(q,raw,raw,lambda _:receipt)
    def test_extent_not_inferred_from_st_size_zero(self):
        p,raw,receipt=fixture_proof()
        for n in [0,4096,8192,32768,True]:
            q=copy.deepcopy(p);q['actual_extent']=n
            with self.assertRaises(ValueError):g.validate(q,raw,raw,lambda _:receipt)
        q=copy.deepcopy(p);q['actual_source_extent_independently_verified']=False
        with self.assertRaises(ValueError):g.validate(q,raw,raw,lambda _:receipt)
    def test_originals_or_provenance_change_refused(self):
        p,raw,receipt=fixture_proof()
        with self.assertRaises(ValueError):g.validate(p,raw,raw[:-1]+b'X',lambda _:receipt)
        with self.assertRaises(ValueError):g.validate(p,raw,raw,lambda _:b'changed')
    def test_undefined_missing_moved_wrongtype_refused(self):
        p,raw,receipt=fixture_proof()
        q=copy.deepcopy(p);q['metadata']['uid']=False
        with self.assertRaises(ValueError):g.validate(q,raw,raw,lambda _:receipt)
        raw=image([(1,b'\xff'*16),(23,b'abcd'),(24,b'X')]);p['whole_original_sha256']=g.sha(raw)
        with self.assertRaises(ValueError):g.validate(p,raw,raw,lambda _:receipt)
        p['role']='read'
        self.assertEqual(g.validate(p,raw,raw,lambda _:receipt)[2],'read')

if __name__=='__main__':unittest.main()
