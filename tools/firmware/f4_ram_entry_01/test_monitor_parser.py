"""Synthetic /proc data through the C parser; never monitor a real process."""
import ctypes
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[3]


class ParserTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory()
        library = Path(cls.temp.name) / "parser.dylib"
        source = Path(__file__).with_name("readonly_monitor.c")
        subprocess.run(["cc", "-std=c11", "-Wall", "-Wextra", "-Werror", "-shared",
                        "-fPIC", "-DF4_MONITOR_PARSER_ONLY", str(source), "-o", str(library)],
                       check=True)
        cls.library = ctypes.CDLL(str(library))
        cls.parse = cls.library.f4_parse_stat
        cls.parse.argtypes = [ctypes.c_char_p, ctypes.c_size_t, ctypes.c_uint64,
                              ctypes.POINTER(ctypes.c_uint64)]
        cls.parse.restype = ctypes.c_int

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def fixture(self, ticks="9000000001", name="p1linux", pid="401", state="S"):
        fields = ["1"] * 19  # fields 4..22
        fields[-1] = ticks
        return (f"{pid} ({name}) {state} " + " ".join(fields) + " 4096 0\n").encode()

    def call(self, raw, pid=401):
        out = ctypes.c_uint64(0xBAD)
        valid = self.parse(raw, len(raw), pid, ctypes.byref(out))
        return valid, out.value

    def test_64bit_start_ticks(self):
        self.assertEqual(self.call(self.fixture()), (1, 9000000001))

    def test_max_u64(self):
        self.assertEqual(self.call(self.fixture(ticks=str(2**64 - 1))), (1, 2**64 - 1))

    def test_sign_overflow_zero_and_malformed(self):
        for t in ["-1", "0", "+1", "1e9", "18446744073709551616", "", "12x"]:
            self.assertEqual(self.call(self.fixture(ticks=t))[0], 0, t)

    def test_identity_exact(self):
        for kw in [{"pid": "402"}, {"name": "p1linux-extra"},
                   {"name": "other"}, {"name": "p1linux) x"}, {"state": "?"}]:
            self.assertEqual(self.call(self.fixture(**kw))[0], 0, kw)

    def test_truncated_or_embedded_nul(self):
        valid = self.fixture()
        for raw in [b"", valid[:20], valid.replace(b"4096", b"\0"), valid[:valid.index(b"4096") - 1]]:
            self.assertEqual(self.call(raw)[0], 0)

    def test_signed_other_fields_and_empty_token(self):
        raw = self.fixture().replace(b" S 1 ", b" S -1 ", 1)
        self.assertEqual(self.call(raw)[0], 1)
        self.assertEqual(self.call(self.fixture().replace(b" S 1 ", b" S  ", 1))[0], 0)

    def test_size_limit(self):
        self.assertEqual(self.call(self.fixture() + b" " * 4096)[0], 0)


if __name__ == "__main__":
    unittest.main()
