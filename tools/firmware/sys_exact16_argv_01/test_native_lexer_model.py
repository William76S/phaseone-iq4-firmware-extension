#!/usr/bin/env python3
"""Synthetic, host-only finite tests. No EEPROM, actual addresses or device."""
import subprocess
import unittest
from native_lexer_model import (ModelBounds, finite_sys_rejoin, format_octal_only,
                                parse_in_place, two_layer_tokens, finite_native_shell_line,
                                xargs_fixed_whitespace)


class NativeLexerTests(unittest.TestCase):
    def test_plain_equal_is_destroyed(self):
        tokens = two_layer_tokens(b'Bridge "Sys Echo alpha=beta" ')
        self.assertEqual(tokens, (b'Sys', b'Echo', b'alpha', b'beta'))
        self.assertEqual(finite_sys_rejoin(tokens), b' Echo alpha beta')

    def test_escaped_double_quote_is_not_unescaped(self):
        tokens = two_layer_tokens(br'Bridge "Sys Echo \"alpha=beta\"" ')
        # The literal quote scanner advances onto, then tests, the quote after
        # a backslash. It does not implement shell escaped-quote semantics.
        self.assertEqual(tokens, (b'Sys', b'Echo', b'\\', b'alpha', b'beta\\""'))

    def test_inner_unescaped_quote_truncates_outer(self):
        tokens = two_layer_tokens(b'Bridge "Sys Echo "alpha=beta"" ')
        self.assertEqual(tokens, (b'Sys', b'Echo'))

    def test_single_quote_is_ordinary_native_byte(self):
        tokens = two_layer_tokens(b'Bridge "Sys Echo \'alpha=beta\'" ')
        self.assertEqual(tokens, (b'Sys', b'Echo', b"'alpha", b"beta'"))

    def test_native_quote_preserves_equal_for_one_layer(self):
        b = bytearray(b'"alpha=beta" \0')
        result = parse_in_place(b, 0, len(b))
        self.assertEqual(result.token_offsets, (1,))
        self.assertEqual(bytes(b[1:11]), b'alpha=beta')

    def test_native_quote_does_not_memmove_escape(self):
        b = bytearray(br'"a\zb" ' + b'\0')
        result = parse_in_place(b, 0, len(b))
        self.assertEqual(bytes(b[result.token_offsets[0]:5]), br'a\zb')

    def test_fixed_octal_token_survives_native_layers(self):
        tokens = two_layer_tokens(br'''Bridge "Sys /usr/bin/printf 'alpha\075beta\012'" ''')
        self.assertEqual(tokens, (b'Sys', b'/usr/bin/printf', br"'alpha\075beta\012'"))
        self.assertNotIn(b'=', finite_sys_rejoin(tokens))

    def test_octal_model_builds_equal_after_native_parse(self):
        self.assertEqual(format_octal_only(br'alpha\075beta\012'), b'alpha=beta\n')

    def test_newline_argv_model_fixed(self):
        data = format_octal_only(br'alpha\075beta\012count\07516\012')
        self.assertEqual(xargs_fixed_whitespace(data), (b'alpha=beta', b'count=16'))

    def test_empty_xargs_input_remains_empty(self):
        self.assertEqual(xargs_fixed_whitespace(b''), ())

    def test_nul_mode_is_not_candidate(self):
        with self.assertRaises(ModelBounds):
            xargs_fixed_whitespace(b'alpha=beta\0')

    def test_xargs_quotes_and_escapes_rejected(self):
        for value in (b'a"b', b"a'b", b'a\\b'):
            with self.assertRaises(ModelBounds):
                xargs_fixed_whitespace(value)

    def test_octal_overflow_and_nonoctal_rejected(self):
        for value in (br'\400', br'\078', br'\07', br'\x3d'):
            with self.assertRaises(ModelBounds):
                format_octal_only(value)

    def test_nonfinite_format_conversion_rejected(self):
        for value in (b'%s', b'$(other)', b'`other`'):
            with self.assertRaises(ModelBounds):
                format_octal_only(value)

    def test_slot_limit_rejected(self):
        with self.assertRaises(ModelBounds):
            two_layer_tokens(b'Bridge "Sys ' + b'x ' * 40 + b'" ')

    def test_rejoin_255_including_leading_space(self):
        self.assertEqual(len(finite_sys_rejoin((b'Sys', b'x' * 254))), 255)
        with self.assertRaises(ModelBounds):
            finite_sys_rejoin((b'Sys', b'x' * 255))

    def test_cstring_guard(self):
        with self.assertRaises(ModelBounds):
            parse_in_place(bytearray(b'x'), 0, 1)

    def test_quote_at_buffer_end_requires_owned_guard(self):
        with self.assertRaises(ModelBounds):
            two_layer_tokens(b'Bridge "Sys Echo x"')

    def test_actual_native_line_has_owned_tail_zeros(self):
        result = finite_native_shell_line(b'"Sys Echo x"')
        self.assertEqual(result.tokens, (b'Sys', b'Echo', b'x'))
        self.assertLess(result.max_owned_index_read, result.line_capacity)

    def test_actual_line_242_text_still_has_guard(self):
        text = b'"Sys Echo ' + b'x' * 231 + b'"'
        self.assertEqual(len(text), 242)
        result = finite_native_shell_line(text)
        self.assertEqual(result.prefix_and_text_length, 254)
        self.assertEqual(result.max_owned_index_read, 255)

    def test_actual_line_243_text_rejected_before_parse(self):
        text = b'"Sys Echo ' + b'x' * 232 + b'"'
        self.assertEqual(len(text), 243)
        with self.assertRaises(ModelBounds):
            finite_native_shell_line(text)

    def test_native_line_all_short_lengths(self):
        for count in range(232):
            result = finite_native_shell_line(b'"Sys Echo ' + b'x' * count + b'"')
            self.assertLess(result.max_owned_index_read, 256)

    def test_actual_line_octal_format_unchanged(self):
        result = finite_native_shell_line(br'''"Sys /usr/bin/printf 'alpha\075beta\012'"''')
        self.assertEqual(result.tokens, (b'Sys', b'/usr/bin/printf', br"'alpha\075beta\012'"))

    def test_fixture_prefix_is_not_device_wrapper(self):
        with self.assertRaises(ModelBounds):
            two_layer_tokens(b'Other "Sys Echo x"')

    def test_host_fixed_printf_only(self):
        tokens = two_layer_tokens(br'''Bridge "Sys /usr/bin/printf 'alpha\075beta\012'" ''')
        command = finite_sys_rejoin(tokens)
        result = subprocess.run(['/bin/sh', '-c', command.decode('ascii')],
                                capture_output=True, timeout=2, check=True)
        self.assertEqual(result.stdout, b'alpha=beta\n')
        self.assertEqual(result.stderr, b'')

    def test_host_fixed_printf_xargs_sink_only(self):
        # Entire fixture is constant and sink is printf. No dd, destination,
        # record address, actual credential, RAM file or camera packet exists.
        fixture = (br'''Bridge "Sys /usr/bin/printf 'alpha\075beta\012count\07516\012' '''
                   br'''| /usr/bin/xargs /usr/bin/printf '<%s>\012'" ''')
        tokens = two_layer_tokens(fixture)
        command = finite_sys_rejoin(tokens)
        self.assertNotIn(b'=', command)
        result = subprocess.run(['/bin/sh', '-c', command.decode('ascii')],
                                capture_output=True, timeout=2, check=True)
        self.assertEqual(result.stdout, b'<alpha=beta>\n<count=16>\n')
        self.assertEqual(result.stderr, b'')


if __name__ == '__main__':
    unittest.main()
