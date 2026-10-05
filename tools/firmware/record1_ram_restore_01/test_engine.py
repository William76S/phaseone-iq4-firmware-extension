"""Synthetic opaque EEPROM fixtures, real production C engine, no device."""
import ctypes
import hashlib
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import unittest

HERE=Path(__file__).resolve().parent
EXTENT=0x4000;OFFSET=0x416

class Config(ctypes.Structure):
    _fields_=[('extent',ctypes.c_uint32),('offset',ctypes.c_uint32),
              ('original',ctypes.c_uint8*16),('whole_sha',ctypes.c_char*65),('write_enabled',ctypes.c_int)]
header=re.sub(r'/\*.*?\*/','',(HERE/'engine.h').read_text(),flags=re.S)
fields=re.search(r'typedef struct \{int (.*?)\} R1Result;',header,re.S).group(1)
names=[s.strip() for s in re.split('[,;]',re.sub(r'\bint\b','',fields)) if s.strip()]
class Result(ctypes.Structure):_fields_=[(n,ctypes.c_int) for n in names]
Reader=ctypes.CFUNCTYPE(ctypes.c_int,ctypes.c_void_p,ctypes.POINTER(ctypes.c_uint8))
Writer=ctypes.CFUNCTYPE(ctypes.c_long,ctypes.c_void_p,ctypes.c_uint32,ctypes.POINTER(ctypes.c_uint8))
class IO(ctypes.Structure):_fields_=[('context',ctypes.c_void_p),('read_whole',Reader),('write16',Writer)]

def image(records=None):
    if records is None:records=[(1,b'opaque-fixture!!'),(23,b'abcd'),(24,b'X'),(42,b'xyz')]
    b=bytearray(b'\xa5'*EXTENT);s=bytearray(b'\xff'*0x800);s[:6]=b'\xfe\x12\x01\x00\x14\x00';p=20
    for key,value in records:s[p:p+2]=bytes((key,len(value)));s[p+2:p+2+len(value)]=value;p+=2+len(value)
    b[0x400:0xc00]=s;return bytes(b)

class Engine(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.tmp=tempfile.TemporaryDirectory(prefix='iq4_r1_host_only_')
        p=Path(cls.tmp.name);lib=p/('engine.dylib' if sys.platform=='darwin' else 'engine.so')
        subprocess.run(['cc','-std=c11','-O1','-Wall','-Wextra','-Werror','-shared','-fPIC',str(HERE/'engine.c'),'-o',str(lib)],check=True)
        cls.lib=ctypes.CDLL(str(lib));cls.lib.r1_run.argtypes=[ctypes.POINTER(Config),ctypes.POINTER(IO),ctypes.c_int];cls.lib.r1_run.restype=Result
    @classmethod
    def tearDownClass(cls):cls.tmp.cleanup()
    def setUp(self):
        self.original=image();self.current=bytearray(self.original);self.reads=0;self.writes=[];self.read_fault=None;self.write_fault=None
        self.config=Config(EXTENT,OFFSET,(ctypes.c_uint8*16).from_buffer_copy(self.original[OFFSET:OFFSET+16]),hashlib.sha256(self.original).hexdigest().encode(),1)
        self.reader=Reader(self.read);self.writer=Writer(self.write);self.io=IO(None,self.reader,self.writer)
    def read(self,ctx,out):
        self.reads+=1
        if self.read_fault and not self.read_fault(self.reads):return 0
        ctypes.memmove(out,bytes(self.current),EXTENT);return 1
    def write(self,ctx,offset,data):
        value=bytes(data[:16]);self.writes.append((offset,value))
        if self.write_fault:return self.write_fault(len(self.writes),offset,value)
        self.current[offset:offset+16]=value;return 16
    def run_action(self,action):return self.lib.r1_run(ctypes.byref(self.config),ctypes.byref(self.io),action)
    def test_default_readonly_and_never_coldboot_acceptance(self):
        r=self.run_action(0);self.assertTrue(r.success);self.assertEqual(self.writes,[])
        self.assertFalse(r.changed_then_restored_coldboot_verified);self.assertFalse(r.persistent_unlock_verified)
    def test_same_original_exact16_transport_is_not_changed_restore(self):
        r=self.run_action(1);self.assertTrue(r.same_original_transport_verified);self.assertFalse(r.restore_transport_verified)
        self.assertEqual(self.current,self.original);self.assertEqual(self.writes,[(OFFSET,self.original[OFFSET:OFFSET+16])])
        self.assertFalse(r.changed_then_restored_coldboot_verified)
    def test_clear_then_restore_only16_all_other_bytes_exact(self):
        c=self.run_action(2);self.assertTrue(c.clear_payload_verified);self.assertTrue(c.success)
        self.assertEqual(self.current[:OFFSET],self.original[:OFFSET]);self.assertEqual(self.current[OFFSET+16:],self.original[OFFSET+16:])
        r=self.run_action(3);self.assertTrue(r.restore_transport_verified);self.assertEqual(self.current,self.original)
        self.assertFalse(r.changed_then_restored_coldboot_verified);self.assertFalse(r.persistent_unlock_verified)
    def test_clear_short_write_rolls_original_once_no_clear_retry(self):
        def fault(n,offset,value):
            count=7 if n==1 else 16;self.current[offset:offset+count]=value[:count];return count
        self.write_fault=fault;r=self.run_action(2)
        self.assertFalse(r.success);self.assertTrue(r.rollback_attempted);self.assertTrue(r.rollback_verified)
        self.assertEqual(self.current,self.original);self.assertEqual(len(self.writes),2)
        self.assertEqual(self.writes[0][1],b'\xff'*16);self.assertEqual(self.writes[1][1],self.original[OFFSET:OFFSET+16])
    def test_error_after_complete_clear_still_not_success(self):
        def fault(n,offset,value):self.current[offset:offset+16]=value;return -1 if n==1 else 16
        self.write_fault=fault;r=self.run_action(2)
        self.assertFalse(r.success);self.assertTrue(r.rollback_verified);self.assertEqual(self.current,self.original)
    def test_failed_clear_with_original_unchanged_does_not_rewrite(self):
        self.write_fault=lambda n,o,v:-1;r=self.run_action(2)
        self.assertTrue(r.original_after_failure_verified);self.assertFalse(r.rollback_attempted);self.assertEqual(len(self.writes),1)
    def test_other_record_changed_after_write_forbids_rollback(self):
        def fault(n,offset,value):self.current[offset:offset+7]=value[:7];self.current[0x429]^=1;return 7
        self.write_fault=fault;r=self.run_action(2)
        self.assertFalse(r.success);self.assertFalse(r.rollback_attempted);self.assertEqual(len(self.writes),1)
    def test_unreadable_postwrite_never_blind_rollback(self):
        self.read_fault=lambda n:n<=4;r=self.run_action(2)
        self.assertFalse(r.success);self.assertFalse(r.rollback_attempted);self.assertEqual(len(self.writes),1)
    def test_snapshot_change_before_write_aborts(self):
        def fault(n):
            if n==3:self.current[OFFSET]^=1
            return True
        self.read_fault=fault;r=self.run_action(3)
        self.assertFalse(r.write_attempted);self.assertEqual(self.writes,[])
    def test_config_bounds_overflow_and_extent_refused_before_IO(self):
        for offset,extent in [(0,EXTENT),(0xffffffff,EXTENT),(0xbf0,EXTENT),(OFFSET,0x1000)]:
            self.config.offset=offset;self.config.extent=extent;r=self.run_action(1)
            self.assertFalse(r.input_valid)
        self.assertEqual(self.reads,0);self.assertEqual(self.writes,[])
    def test_write_disabled_refuses(self):
        self.config.write_enabled=0;r=self.run_action(2);self.assertFalse(r.write_attempted);self.assertEqual(self.writes,[])
    def test_missing_moved_duplicate_or_wrong_length_record_refused(self):
        for records in [[(23,b'abcd'),(24,b'X')],[(42,b'abc'),(1,b'opaque-fixture!!')],[(1,b'x'*15)],[(1,b'x'*16),(1,b'y'*16)]]:
            self.current=bytearray(image(records));self.config.whole_sha=hashlib.sha256(self.current).hexdigest().encode()
            r=self.run_action(1);self.assertFalse(r.write_attempted)
        self.assertEqual(self.writes,[])
    def test_unknown_initial_otherbytes_never_written(self):
        for p in [0,0x440,EXTENT-1]:
            self.current=bytearray(self.original);self.current[p]^=1;r=self.run_action(3);self.assertFalse(r.write_attempted)
        self.assertEqual(self.writes,[])
    def test_actual_host_pwrite_fixture_and_full_EOF(self):
        with tempfile.TemporaryFile() as f:
            f.write(self.original);f.flush()
            def reader(ctx,out):
                b=os.pread(f.fileno(),EXTENT+1,0)
                if len(b)!=EXTENT:return 0
                ctypes.memmove(out,b,EXTENT);return 1
            calls=[]
            def writer(ctx,offset,data):
                calls.append((offset,16));return os.pwrite(f.fileno(),bytes(data[:16]),offset)
            rcb=Reader(reader);wcb=Writer(writer);io=IO(None,rcb,wcb)
            r=self.lib.r1_run(ctypes.byref(self.config),ctypes.byref(io),2);self.assertTrue(r.success)
            r=self.lib.r1_run(ctypes.byref(self.config),ctypes.byref(io),3);self.assertTrue(r.success)
            self.assertEqual(os.pread(f.fileno(),EXTENT+1,0),self.original);self.assertEqual(calls,[(OFFSET,16),(OFFSET,16)])
    def test_static_target_has_one_pwrite_no_reload_or_PIN_output(self):
        text=(HERE/'target.c').read_text();self.assertEqual(text.count('pwrite('),1)
        for api in ['kill(','raise(','system(','popen(','ioctl(','fsync(','truncate(','execve(','dlopen(']:self.assertNotIn(api,text)
        self.assertIn('persistent_unlock_verified\\\":false',text)
        self.assertNotIn('sha256\\\":',text)

if __name__=='__main__':unittest.main()
