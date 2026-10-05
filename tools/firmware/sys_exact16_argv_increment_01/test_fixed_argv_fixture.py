#!/usr/bin/env python3
"""Constant host printf sink fixtures; no camera payload or EEPROM target."""
from pathlib import Path
import subprocess
import sys
import unittest

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'sys_exact16_argv_01'))
from native_lexer_model import (ModelBounds, finite_native_shell_line,
                                finite_sys_rejoin, format_octal_only,
                                xargs_fixed_whitespace)

# Constants are intentionally neutral. No destination, EEPROM offset, original
# bytes, address, credentials, dd invocation or caller-selected tool exists.
FIXTURE = (br'''"Sys /usr/bin/printf 'alpha\075beta\012count\07516\012' '''
           br'''| /usr/bin/xargs -r /usr/bin/printf '<%s>\012'"''')
EXPECTED = b'<alpha=beta>\n<count=16>\n'


class FixedArgvFixtureTests(unittest.TestCase):
    def test_no_literal_equal_at_either_native_layer(self):
        self.assertNotIn(b'=', FIXTURE)
        line = finite_native_shell_line(FIXTURE)
        self.assertNotIn(b'=', finite_sys_rejoin(line.tokens))
        self.assertLessEqual(len(FIXTURE), 242)
        self.assertLess(line.max_owned_index_read, 256)

    def test_actual_line_tokens_include_single_quotes_and_backslashes(self):
        line = finite_native_shell_line(FIXTURE)
        self.assertEqual(line.tokens, (
            b'Sys', b'/usr/bin/printf', br"'alpha\075beta\012count\07516\012'",
            b'|', b'/usr/bin/xargs', b'-r', b'/usr/bin/printf', br"'<%s>\012'"))

    def test_octal_equal_and_lf_are_created_after_native_parse(self):
        output = format_octal_only(br'alpha\075beta\012count\07516\012')
        self.assertEqual(output, b'alpha=beta\ncount=16\n')
        self.assertEqual(xargs_fixed_whitespace(output), (b'alpha=beta', b'count=16'))

    def test_fixed_host_sink_only(self):
        command = finite_sys_rejoin(finite_native_shell_line(FIXTURE).tokens)
        result = subprocess.run(['/bin/sh', '-c', command.decode('ascii')],
                                capture_output=True, timeout=2, check=True)
        self.assertEqual(result.stdout, EXPECTED)
        self.assertEqual(result.stderr, b'')

    def test_octals_use_exactly_three_digits_and_byte_range(self):
        for invalid in (br'\07', br'\078', br'\400'):
            with self.assertRaises(ModelBounds):
                format_octal_only(invalid)

    def test_nul_delimiter_mode_is_not_a_supported_fixture(self):
        with self.assertRaises(ModelBounds):
            xargs_fixed_whitespace(b'alpha=beta\0count=16\0')

    def test_operands_with_whitespace_would_not_be_one_argument(self):
        self.assertNotEqual(xargs_fixed_whitespace(b'alpha=two words\n'),
                            (b'alpha=two words',))

    def test_operand_quotes_or_backslash_are_rejected(self):
        for value in (b'alpha="beta"\n', b"alpha='beta'\n", b'alpha=be\\ta\n'):
            with self.assertRaises(ModelBounds):
                xargs_fixed_whitespace(value)

    def test_blank_input_is_empty_argv_under_finite_model(self):
        self.assertEqual(xargs_fixed_whitespace(b''), ())

    def test_no_path_or_actual_value_is_embedded_in_constant(self):
        for forbidden in (b'/sys/', b'/proc/', b'/run/', b'eeprom', b'Pin',
                          b'/bin/dd', b'if', b'of', b'seek'):
            self.assertNotIn(forbidden, FIXTURE)


if __name__ == '__main__':
    unittest.main()
