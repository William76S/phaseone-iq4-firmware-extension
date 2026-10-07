"""Host synthetic ZIP/PE/ELF/guard tests. No download or Windows execution."""
import contextlib
import io
import json
from pathlib import Path
import stat
import struct
import tempfile
import unittest
from unittest import mock
import warnings
import zipfile

import acquire as a
import probes as p

def zipped(items):
    b=io.BytesIO()
    with warnings.catch_warnings(),zipfile.ZipFile(b,'w') as z:
        warnings.simplefilter('ignore',UserWarning)
        for name,data,mode in items:
            info=zipfile.ZipInfo(name);info.external_attr=mode<<16;z.writestr(info,data)
    return b.getvalue()
def inspect(data):
    with zipfile.ZipFile(io.BytesIO(data)) as z:return a.inspect_members(z)
ROOT=a.ARCHIVE_ROOT
VALID=[(ROOT+'/zig.exe',b'PE fixture only',stat.S_IFREG|0o600),(ROOT+'/lib/f.c',b'public',stat.S_IFREG|0o600)]

class Toolchain(unittest.TestCase):
    def test_default_preflight_no_network_or_files(self):
        with mock.patch('sys.argv',['acquire.py']),mock.patch.object(a,'download',side_effect=AssertionError),mock.patch.object(a,'acquire',side_effect=AssertionError),contextlib.redirect_stdout(io.StringIO()) as out:
            self.assertEqual(a.main(),0)
        j=json.loads(out.getvalue());self.assertTrue(j['preflight_only']);self.assertFalse(j['network_accessed']);self.assertFalse(j['private_originals_read'])
    def test_pinned_official_size_sha_source(self):
        lock=a.source_lock();self.assertEqual(lock['archive_size'],92614574);self.assertEqual(lock['archive_sha256'],a.ZIP_SHA);self.assertIsNone(lock['zig_exe_sha256'])
    def test_non_Windows_acquire_refuses_before_network(self):
        with mock.patch.object(a.os,'name','posix'),mock.patch.object(a,'download',side_effect=AssertionError):
            with self.assertRaises(ValueError):a.host_gate()
    def test_safe_valid_entries_and_bound_total(self):
        members,total=inspect(zipped(VALID));self.assertEqual(len(members),2);self.assertEqual(total,21)
    def test_path_traversal_absolute_ADS_backslash_refused(self):
        for name in ['../zig.exe','/'+ROOT+'/zig.exe',ROOT+'/../zig.exe',ROOT+'/x:y',ROOT+'\\zig.exe',ROOT+'//zig.exe',ROOT+'/./zig.exe']:
            with self.assertRaises(ValueError):inspect(zipped(VALID+[(name,b'X',stat.S_IFREG)]))
    def test_reserved_trailing_control_and_NUL_refused(self):
        for leaf in ['CON','aux.c','COM1.h','LPT².x','x.','x ','x\x01']:
            with self.assertRaises(ValueError):inspect(zipped(VALID+[(ROOT+'/'+leaf,b'X',stat.S_IFREG)]))
        with self.assertRaises(ValueError):a.safe_parts(zipfile.ZipInfo(ROOT+'/x\0hidden'))
    def test_symlink_special_encryption_refused(self):
        for mode in [stat.S_IFLNK|0o777,stat.S_IFIFO|0o600,stat.S_IFCHR|0o600]:
            with self.assertRaises(ValueError):inspect(zipped(VALID+[(ROOT+'/alias',b'x',mode)]))
        info=zipfile.ZipInfo(ROOT+'/x');info.flag_bits=1
        with self.assertRaises(ValueError):a.safe_parts(info)
    def test_duplicate_case_and_parentcase_collisions_refused(self):
        for name in [ROOT+'/zig.exe',ROOT+'/ZIG.exe',ROOT+'/LIB/new.c']:
            with self.assertRaises(ValueError):inspect(zipped(VALID+[(name,b'x',stat.S_IFREG)]))
    def test_file_directory_conflict_refused(self):
        with self.assertRaises(ValueError):inspect(zipped(VALID+[(ROOT+'/lib',b'x',stat.S_IFREG)]))
    def test_count_total_member_limits_refused(self):
        data=zipped(VALID)
        for name,value in [('MAX_ENTRIES',1),('MAX_TOTAL',1),('MAX_MEMBER',1)]:
            with mock.patch.object(a,name,value):
                with self.assertRaises(ValueError):inspect(data)
    def test_verified_archive_size_digest_and_fresh_extraction(self):
        data=zipped(VALID)
        with tempfile.TemporaryDirectory() as name:
            root=Path(name).resolve();archive=root/'fixture.zip';archive.write_bytes(data)
            a.verify_archive(archive,len(data),a.sha(data))
            with self.assertRaises(ValueError):a.verify_archive(archive,len(data)+1,a.sha(data))
            with self.assertRaises(ValueError):a.verify_archive(archive,len(data),'0'*64)
            members,total=a.extract_verified(archive,root/'tree');a.check_tree(root/'tree',members)
            self.assertEqual(members,a.archive_members(archive))
            with self.assertRaises(ValueError):a.extract_verified(archive,root/'tree')
    def test_tree_tamper_extra_file_and_symlink_refused(self):
        with tempfile.TemporaryDirectory() as name:
            root=Path(name).resolve();archive=root/'fixture.zip';archive.write_bytes(zipped(VALID));members,_=a.extract_verified(archive,root/'tree')
            extra=root/'tree/extra';extra.write_bytes(b'x')
            with self.assertRaises(ValueError):a.check_tree(root/'tree',members)
            extra.unlink();(root/'tree/lib/f.c').write_bytes(b'changed')
            with self.assertRaises(ValueError):a.check_tree(root/'tree',members)
            (root/'tree/lib/f.c').unlink();(root/'tree/lib/f.c').symlink_to(archive)
            with self.assertRaises(ValueError):a.check_tree(root/'tree',members)
    def test_PE64_machine_and_magic(self):
        b=bytearray(256);b[:2]=b'MZ';struct.pack_into('<I',b,60,128);b[128:132]=b'PE\0\0';struct.pack_into('<H',b,132,0x8664);struct.pack_into('<H',b,152,0x20b)
        with tempfile.TemporaryDirectory() as name:
            f=Path(name)/'fixture.exe';f.write_bytes(b);a.pe_x64(f)
            struct.pack_into('<H',b,132,0xaa64);f.write_bytes(b)
            with self.assertRaises(ValueError):a.pe_x64(f)
    def test_missing_compiler_or_root_refused(self):
        with self.assertRaises(ValueError):inspect(zipped(VALID[1:]))
        with self.assertRaises(ValueError):inspect(zipped([('wrong/zig.exe',b'x',stat.S_IFREG)]))
    def test_frozen_public_sources_and_ELF_actual_receipts(self):
        self.assertEqual(set(p.source_check()),set(p.SOURCE_PATHS))
        path=a.ROOT/'analysis/firmware/record1_ram_restore_01/preview/record1.elf'
        if path.exists():
            j=p.inspect_elf(path,3);self.assertEqual(j['machine'],183);self.assertEqual(j['needed'],['libc.so.6'])
            with self.assertRaises(ValueError):p.inspect_elf(path,1)
    def test_no_private_input_or_camera_or_global_install(self):
        text=(a.HERE/'acquire.py').read_text()+(a.HERE/'probes.py').read_text()
        for forbidden in ['--original-a','--original-b','--emit-private','CameraSdk','StartDeviceControl','EnsureClosed','shell=True','runas','Set-Acl','Get-FileHash']:
            self.assertNotIn(forbidden,text)

if __name__=='__main__':unittest.main()
