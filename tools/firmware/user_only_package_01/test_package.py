#!/usr/bin/env python3
"""Local in-memory fixtures; no candidate firmware is saved or executed."""
import importlib.util
import io
from pathlib import Path
import struct
import unittest
import xml.etree.ElementTree as ET
import zipfile

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('package', HERE / 'package.py')
p = importlib.util.module_from_spec(spec)
spec.loader.exec_module(p)

class OfflinePackaging(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.stock, cls.xml, cls.attributes = p.load_stock(p.DEFAULT_FWR)

    def fixture(self):
        body = bytearray(self.stock)
        offset = p.elf_layout(body)['image_header_offset']
        struct.pack_into('<BBH', body, offset + 16, 6, 3, 22)
        return body

    def candidate(self, body=None):
        body = bytes(body if body is not None else self.fixture())
        return p.build(self.stock, body, p.sha(body), self.attributes, (6, 3, 19), (6, 3, 22))

    def test_original_identity_and_plan_only(self):
        plan, _, _ = p.build(self.stock, self.stock, p.USER_SHA, self.attributes, p.RELEASE, p.APP)
        self.assertFalse(plan['offline_candidate_generation_scope_passed'])
        self.assertFalse(plan['device_acceptance_observed'])
        self.assertFalse(plan['f1_feature_implementation_or_acceptance_proven'])

    def test_version_only_is_not_feature(self):
        plan, _, _ = self.candidate()
        self.assertTrue(plan['payload_changes_limited_to_image_header_version'])
        self.assertFalse(plan['candidate_elf_layout_differs_from_stock'])
        self.assertFalse(plan['f1_feature_implementation_or_acceptance_proven'])

    def test_deterministic_two_archives_and_manifest(self):
        a, fwr, fwp = self.candidate()
        self.assertEqual((a, fwr, fwp), self.candidate())
        with zipfile.ZipFile(io.BytesIO(fwr)) as archive:
            self.assertEqual(archive.namelist(), ['manifest.xml', 'P1Linux_6.03.22.bin'])
            xml = ET.fromstring(archive.read('manifest.xml'))
            self.assertEqual([e.attrib for e in xml], [{'type': 'LinuxApp'}])
            self.assertEqual(xml.attrib['compatible_version'], '5')
            self.assertEqual(xml.attrib['release_version'], '6.03.19')
        with zipfile.ZipFile(io.BytesIO(fwp)) as archive:
            self.assertEqual(archive.read(p.INNER_NAME), fwr)
            xml = ET.fromstring(archive.read('manifest.xml'))
            self.assertEqual(xml.tag, 'system_package')
            self.assertEqual(xml.attrib['compatible_version'], '2')
            self.assertEqual(xml[0].text, p.INNER_NAME)
            self.assertEqual(xml[0].attrib['hw_revisions'], '1,2,3')

    def test_payload_hash_mismatch(self):
        with self.assertRaises(ValueError):
            p.check_payload(self.stock, self.fixture(), p.USER_SHA, (6, 3, 22))

    def test_header_version_mismatch(self):
        b = self.fixture()
        with self.assertRaises(ValueError):
            p.check_payload(self.stock, b, p.sha(b), p.APP)

    def test_growth_not_rejected_as_fixed_extent(self):
        plan, _, _ = self.candidate(self.fixture() + b'HOST_ONLY_UNLOADED_FIXTURE')
        self.assertTrue(plan['candidate_extent_differs_from_stock'])
        self.assertFalse(plan['payload_elf_host_review']['target_memory_capacity_or_boot_verified'])

    def test_add_load_relocate_header_and_grow(self):
        b = self.fixture()
        old = p.elf_layout(b)
        phoff = struct.unpack_from('<Q', b, 32)[0]
        phcount = struct.unpack_from('<H', b, 56)[0]
        programs = [list(struct.unpack_from('<IIQQQQQQ', b, phoff + 56*i)) for i in range(phcount)]
        offset = (len(b) + 0xffff) & ~0xffff
        va = 0x8000000
        header_offset = offset + 0x1000
        new_header = b[old['image_header_offset']:old['image_header_offset'] + 180]
        b += bytes(offset + 0x2000 - len(b))
        for entry in programs:
            if entry[0] == 6: # PT_PHDR relocated coherently into the new load.
                entry[2:7] = [offset, va, va, 56*(phcount+1), 56*(phcount+1)]
        programs.append([1, 4, offset, va, va, 0x2000, 0x2000, 0x10000])
        struct.pack_into('<Q', b, 32, offset)
        struct.pack_into('<H', b, 56, phcount+1)
        for i, entry in enumerate(programs):
            struct.pack_into('<IIQQQQQQ', b, offset + 56*i, *entry)
        b[header_offset:header_offset+180] = new_header
        shoff = struct.unpack_from('<Q', b, 40)[0]
        shcount = struct.unpack_from('<H', b, 60)[0]
        for i in range(shcount):
            sh = shoff + i*64
            if struct.unpack_from('<Q', b, sh+24)[0] == old['image_header_offset']:
                struct.pack_into('<QQ', b, sh+16, va+0x1000, header_offset)
        plan, _, _ = self.candidate(b)
        layout = plan['payload_elf_host_review']
        self.assertEqual(layout['program_count'], 11)
        self.assertEqual(len(layout['loads']), 3)
        self.assertEqual(layout['image_header_offset'], header_offset)
        self.assertTrue(plan['candidate_elf_layout_differs_from_stock'])
        self.assertFalse(plan['device_acceptance_observed'])

    def test_bad_machine_and_endianness(self):
        for index, value in ((5, 2), (18, 62)):
            b = self.fixture(); b[index] = value
            with self.assertRaises(ValueError):
                self.candidate(b)

    def test_malformed_program_extent(self):
        b = self.fixture()
        ph = struct.unpack_from('<Q', b, 32)[0]
        struct.pack_into('<Q', b, ph+32, len(b)+1)
        with self.assertRaises(ValueError): self.candidate(b)

    def test_overlapping_load(self):
        b = self.fixture(); ph = struct.unpack_from('<Q', b, 32)[0]
        for i in range(10):
            pos=ph+56*i
            if struct.unpack_from('<I', b, pos)[0] == 1 and struct.unpack_from('<Q', b, pos+8)[0] != 0:
                struct.pack_into('<Q', b, pos+16, 0x400000+(struct.unpack_from('<Q', b, pos+8)[0] % 0x10000))
        with self.assertRaises(ValueError): self.candidate(b)

    def test_no_image_header(self):
        b = self.fixture(); offset = b.index(b'.imageHeader\0'); b[offset] = ord('_')
        with self.assertRaises(ValueError): self.candidate(b)

    def test_flat_zip_names_and_corrupt_crc(self):
        with self.assertRaises(ValueError): p.stored_zip([('../bad', b'x')])
        data = bytearray(p.stored_zip([('ok', b'ab')]))
        body_offset = 30+2
        data[body_offset] ^= 1
        with self.assertRaises((ValueError, zipfile.BadZipFile)):
            p.verify_zip(data, [('ok', b'ab')])

    def test_version_boundaries(self):
        self.assertEqual(p.version('255.255.65535'), (255,255,65535))
        for s in ('256.1.1', '6.3.65536', '6.3.-1', '6.3.1; x', '6.3'):
            with self.assertRaises(ValueError): p.version(s)

if __name__ == '__main__':
    unittest.main()
