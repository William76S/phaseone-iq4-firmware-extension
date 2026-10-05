import struct,unittest
from decode_observation import decode_samples
class Decoder(unittest.TestCase):
    def fixture(self):
        b=bytearray(440);struct.pack_into('<4I',b,0,2,440,4,0);struct.pack_into('<4I',b,16,1,424,2,2)
        struct.pack_into('<3Q',b,32,1,1,0);struct.pack_into('<10Q',b,56,*[0x10000+i*8 for i in range(10)])
        struct.pack_into('<Q',b,104,0x6be8ac)
        struct.pack_into('<Q4i',b,136,0xb73b98,0,0,640,480);struct.pack_into('<3if',b,160,0,0,0,1.0)
        struct.pack_into('<6I',b,176,0,1,1,1,0,0);struct.pack_into('<4I',b,232,1,1,1,1)
        struct.pack_into('<Q',b,248,0x10018+0x88);struct.pack_into('<Q',b,312,0x10018);struct.pack_into('<Q',b,376,0xb9abf8);return bytes(b)
    def test_candidates_not_attestations(self):
        b=self.fixture();v=decode_samples(b,b);self.assertEqual(v['dispatch_epoch'],1)
        self.assertFalse(v['hardware_facts_verified']);self.assertFalse(v['publication_is_source_frame_count'])
    def test_failures(self):
        original=self.fixture()
        for off,value in ((0,1),(4,441),(8,9),(12,1),(16,2),(20,425),(24,1),(28,6),(40,65),(188,0),(192,1),(196,1),(232,9),(236,0),(240,0),(244,0)):
            with self.subTest(off=off):
                b=bytearray(original);struct.pack_into('<I',b,off,value)
                with self.assertRaises(ValueError):decode_samples(bytes(b),bytes(b))
        with self.assertRaises(ValueError):decode_samples(original,original[:-1])
        changed=bytearray(original);changed[0]=4
        with self.assertRaises(ValueError):decode_samples(original,bytes(changed))
if __name__=='__main__':unittest.main()
