#!/usr/bin/env python3
"""Meaningful synthetic completeness/failure tests; no camera, SDK, or shell."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import struct
import unittest
from sys_read_backup_host import *

NONCE = '12345678ab'
PATH = '/sys/devices/platform/amba/ff030000.i2c/i2c-1/1-0057/eeprom'
META = {'size':4,'mode':0x81a4,'uid':0,'gid':0,'permissions':0o644,'mtime':1,'inode':10}


def marked(command, text):
    return (command.begin_marker + text + command.end_marker).encode('ascii')


def reply(data,correlation=7,flags=3,seq=0):
    # Synthetic RECEIVE fixture, not an outgoing command or real wire packet.
    p = bytearray(20)
    p[0],p[4],p[5],p[6],p[7] = 2,1,correlation,flags,seq
    struct.pack_into('<I',p,8,len(data))
    struct.pack_into('<H',p,12,20)
    struct.pack_into('<I',p,16,20+len(data))
    return bytes(p)+data


class HostOnlyTests(unittest.TestCase):
    def test_discovery_two_layer_wrapper_and_length(self):
        commands = discovery_commands(NONCE)
        self.assertEqual(len(commands),6)
        for c in commands:
            self.assertLessEqual(verify_two_layer_text(c.host_text)['sys_bytes_with_leading_space'],255)
            self.assertTrue(c.host_text.startswith('"Sys '))

    def test_two_layer_unquoted_rejected(self):
        with self.assertRaises(ContractError):verify_two_layer_text('Sys /bin/pidof p1linux')

    def test_equals_assignment_rejected(self):
        with self.assertRaises(ContractError):verify_two_layer_text('"Sys /bin/dd if=/x"')

    def test_inner_quotes_rejected(self):
        with self.assertRaises(ContractError):verify_two_layer_text('"Sys /bin/stat -c "%s %a" /x"')

    def test_backslash_and_newline_rejected(self):
        for s in ['"Sys printf abc\\n"','"Sys printf abc\n"']:
            with self.assertRaises(ContractError):verify_two_layer_text(s)

    def test_snprintf_truncation_rejected(self):
        with self.assertRaises(ContractError):verify_two_layer_text('"Sys printf '+'a'*256+'"')

    def test_max_tokens_rejected(self):
        with self.assertRaises(ContractError):verify_two_layer_text('"Sys '+' '.join(['x']*39)+'"')

    def test_pid_and_single_process_only(self):
        c=discovery_commands(NONCE)[0]
        self.assertEqual(parse_pid(c,marked(c,'123\n')),123)
        for s in ['123 124\n','','0','-1','123junk']:
            with self.assertRaises(ContractError):parse_pid(c,marked(c,s))

    def test_observed_eeprom_bus_consistency(self):
        c=discovery_commands(NONCE)[1]
        self.assertEqual(parse_eeprom_path(c,marked(c,PATH+'\n')),PATH)
        for s in [PATH+'\n'+PATH,PATH.replace('/1-','/2-'),PATH.replace('i2c-1','i2c-11'),'']:
            with self.assertRaises(ContractError):parse_eeprom_path(c,marked(c,s))

    def test_exe_identity_deleted_and_factory_rejected(self):
        c=process_identity_commands(123,NONCE)[0]
        self.assertEqual(parse_user_exe_path(c,marked(c,'/mnt/qspi/User/p1linux\n')),'/mnt/qspi/User/p1linux')
        for s in ['/mnt/qspi/User/p1linux (deleted)','/mnt/qspi/Factory/p1linux','/run/other']:
            with self.assertRaises(ContractError):parse_user_exe_path(c,marked(c,s))

    def test_arbitrary_sensitive_paths_rejected(self):
        for p in ['/etc/shadow','/mnt/qspi/User/debug','/proc/123/mem','/tmp/x;rm','',None]:
            with self.assertRaises(ContractError):metadata_command(p,NONCE)

    def test_metadata_positive_regular_fields(self):
        c=metadata_command(PATH,NONCE)
        self.assertEqual(parse_metadata(c,marked(c,'4:81a4:0:0:644:1:10\n')),META)
        for s in ['0:81a4:0:0:644:1:10','4:41a4:0:0:644:1:10','4:81a4:0:0:644:1:10:extra',
                  'stat error','4:81a4:0:0:999:1:10']:
            with self.assertRaises(ContractError):parse_metadata(c,marked(c,s))

    def test_marker_error_extra_missing_and_duplicate_rejected(self):
        c=hex_read_command(PATH,0,4,NONCE)
        good=marked(c,' 00 01 02 03\n')
        for output in [good+b'Command executed unsuccessfully!',good[:-1],b'echo'+good,
                       marked(c,c.begin_marker+' 00 01 02 03'),b'']:
            with self.assertRaises(ContractError):parse_hex_chunk(c,output)

    def test_hex_reconstructs_zero_and_high_bytes(self):
        c=hex_read_command(PATH,0,4,NONCE)
        self.assertEqual(parse_hex_chunk(c,marked(c,' 00 0a\n fe FF\n')),bytes([0,10,254,255]))

    def test_hex_short_extra_odd_fold_address_and_error_rejected(self):
        c=hex_read_command(PATH,0,4,NONCE)
        for body in ['00 01','00 01 02 03 04','0 01 02 03','*','0000000 00 01 02 03',
                     '00 01 02 03 read error','00010203']:
            with self.assertRaises(ContractError):parse_hex_chunk(c,marked(c,body))

    def test_nul_and_nonascii_rejected(self):
        c=hex_read_command(PATH,0,4,NONCE)
        for s in [b'\0',b'\xff']:
            with self.assertRaises(ContractError):extract_marked_text(c,s)

    def test_chunk_limit_offsets_and_eeprom_long_path(self):
        verify_two_layer_text(hex_read_command(PATH,2**30,8192,NONCE).host_text)
        for offset,count in [(-1,4),(2**31,4),(0,0),(0,8193)]:
            with self.assertRaises(ContractError):hex_read_command(PATH,offset,count,NONCE)

    def test_eof_probe_exact_empty(self):
        c=eof_probe_command(PATH,4,NONCE)
        self.assertEqual(parse_hex_chunk(c,marked(c,'')),b'')
        with self.assertRaises(ContractError):parse_hex_chunk(c,marked(c,'00'))

    def test_target_digest_exact_path_and_format(self):
        c=digest_command(PATH,NONCE);h='a'*64
        self.assertEqual(parse_digest(c,marked(c,h+'  '+PATH+'\n'),PATH),h)
        for s in [h+' '+PATH,h+'  /other','a'*63+'  '+PATH]:
            with self.assertRaises(ContractError):parse_digest(c,marked(c,s),PATH)

    def test_single_and_multi_fragment_completion(self):
        a=FragmentAssembler(7);a.accept(0xff,0x81,reply(b'abc'));self.assertEqual(a.result(),b'abc')
        a=FragmentAssembler(7)
        a.accept(0xff,0x81,reply(b'ab',flags=1))
        a.accept(0xff,0x81,reply(b'cd',flags=0,seq=1))
        a.accept(0xff,0x81,reply(b'ef',flags=2,seq=2))
        self.assertEqual(a.result(),b'abcdef')

    def test_no_final_fragment_is_not_completion(self):
        a=FragmentAssembler(7);a.accept(0xff,0x81,reply(b'abc',flags=1))
        with self.assertRaises(ContractError):a.result()

    def test_wrong_common_discriminator_rawtype_and_correlation(self):
        for cls,typ,p in [(0x69,0x81,reply(b'a')),(0xff,1,reply(b'a')),
                          (0xff,0x81,reply(b'a',correlation=8))]:
            with self.assertRaises(ContractError):FragmentAssembler(7).accept(cls,typ,p)
        for offset,value in [(0,1),(4,0x81)]:
            p=bytearray(reply(b'a'));p[offset]=value
            with self.assertRaises(ContractError):FragmentAssembler(7).accept(0xff,0x81,p)

    def test_fragment_gap_duplicate_and_invalid_flags(self):
        for flags,seq in [(0,0),(2,0),(3,1),(1,1)]:
            with self.assertRaises(ContractError):FragmentAssembler(7).accept(0xff,0x81,reply(b'a',flags=flags,seq=seq))
        a=FragmentAssembler(7);a.accept(0xff,0x81,reply(b'a',flags=1))
        with self.assertRaises(ContractError):a.accept(0xff,0x81,reply(b'b',flags=0,seq=0))

    def test_span_mismatch_and_bounds_rejected(self):
        for field,fmt,value in [(8,'<I',9),(12,'<H',21),(16,'<I',99)]:
            p=bytearray(reply(b'a'));struct.pack_into(fmt,p,field,value)
            with self.assertRaises(ContractError):FragmentAssembler(7).accept(0xff,0x81,p)
        with self.assertRaises(ContractError):FragmentAssembler(7,1).accept(0xff,0x81,reply(b'ab'))

    def test_post_final_and_nul_fragment_rejected(self):
        a=FragmentAssembler(7);a.accept(0xff,0x81,reply(b'a'))
        with self.assertRaises(ContractError):a.accept(0xff,0x81,reply(b'b',seq=1))
        with self.assertRaises(ContractError):FragmentAssembler(7).accept(0xff,0x81,reply(b'\0'))

    def test_backup_pass_complete_independent_digest_and_eof(self):
        b=BackupPass(PATH,META);c=hex_read_command(PATH,0,4,NONCE)
        b.append(c,marked(c,'00 01 02 03'))
        eof=eof_probe_command(PATH,4,'abcdef1234')
        raw=b.finish(META,eof,marked(eof,''),hashlib.sha256(bytes(range(4))).hexdigest())
        self.assertEqual(raw,bytes(range(4)))

    def test_backup_gap_duplicate_changed_metadata_digest_and_short(self):
        b=BackupPass(PATH,META);c=hex_read_command(PATH,1,4,NONCE)
        with self.assertRaises(ContractError):b.append(c,marked(c,'00 01 02 03'))
        c=hex_read_command(PATH,0,4,NONCE);b.append(c,marked(c,'00 01 02 03'))
        with self.assertRaises(ContractError):b.append(c,marked(c,'00 01 02 03'))
        eof=eof_probe_command(PATH,4,'abcdef1234')
        for meta,digest in [({**META,'inode':11},hashlib.sha256(bytes(range(4))).hexdigest()),(META,'0'*64)]:
            with self.assertRaises(ContractError):b.finish(meta,eof,marked(eof,''),digest)
        with self.assertRaises(ContractError):BackupPass(PATH,META).finish(META,eof,marked(eof,''),'0'*64)

    def test_private_double_save_and_no_overwrite_or_value_report(self):
        # Exclusive local synthetic directory, not an actual original or camera output.
        base=Path(__file__).resolve().parents[2]/'analysis/firmware/sys_read_backup_host'
        base.mkdir(exist_ok=True)
        d=base/'synthetic_private_test'
        self.assertFalse(d.exists())
        try:
            flags=save_private_double_read(d,bytes(range(4)),bytes(range(4)),META,META)
            self.assertFalse(flags['payload_or_PIN_semantics_parsed'])
            self.assertEqual(os.stat(d/'original_read1.bin').st_mode & 0o777,0o600)
            self.assertEqual(os.stat(d).st_mode & 0o777,0o700)
            self.assertNotIn('raw_hex',flags)
            with self.assertRaises(FileExistsError):save_private_double_read(d,bytes(range(4)),bytes(range(4)),META,META)
        finally:
            if d.exists():shutil.rmtree(d)
        with self.assertRaises(ContractError):save_private_double_read(d,b'1234',b'1235',META,META)


if __name__ == '__main__':
    unittest.main()
