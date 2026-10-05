#!/usr/bin/env python3
"""Pure host model of exact native lexer/rejoin; no transport or device API.

Addresses bind only the frozen User ELF. The model is for finite synthetic
fixtures, never for generating a camera payload or selecting EEPROM offsets.
"""
from dataclasses import dataclass


class ModelBounds(ValueError):
    pass


@dataclass(frozen=True)
class ParseResult:
    token_offsets: tuple[int, ...]
    stopped_at_slot_limit: bool


@dataclass(frozen=True)
class ShellLineResult:
    tokens: tuple[bytes, ...]
    max_owned_index_read: int
    prefix_and_text_length: int
    line_capacity: int


class _TrackedBuffer(bytearray):
    max_index_read = -1

    def __getitem__(self, p):
        if isinstance(p, int):
            self.max_index_read = max(self.max_index_read, p)
        return super().__getitem__(p)


def _byte(buf: bytearray, p: int) -> int:
    if not 0 <= p < len(buf):
        raise ModelBounds('model read beyond owned fixture')
    return buf[p]


def _cstring(buf: bytearray, p: int) -> bytes:
    end = buf.find(0, p)
    if end < 0:
        raise ModelBounds('fixture has no C-string terminator')
    return bytes(buf[p:end])


def parse_in_place(buf: bytearray, start: int, length: int) -> ParseResult:
    """740144 + 740700/7407cc/740858: borrowed pointers, destructive parse."""
    p = 0
    slots = []
    while _byte(buf, start + p) and p < length:
        # 740858 returns exactly one separator, not a general whitespace loop.
        if _byte(buf, start + p) in (9, 32, 61):
            p += 1
        c = _byte(buf, start + p)
        if c == 0:
            break
        if c in (9, 32, 61):
            pass
        elif c == 34:
            slots.append(start + p + 1)
            # Literal translation of 740700; backslashes are retained. It tests
            # the incremented byte before skipping its next non-NUL byte.
            i = 1
            while _byte(buf, start + p + i) not in (0, c):
                i += 1
                if (_byte(buf, start + p + i) == 92 and
                        _byte(buf, start + p + i + 1)):
                    i += 1
            if _byte(buf, start + p + i):
                i += 1
            p += i
            if _byte(buf, start + p - 1) == 34:
                buf[start + p - 1] = 0
        else:
            slots.append(start + p)
            i = 0
            while _byte(buf, start + p + i) not in (0, 9, 32, 61):
                i += 1
            p += i
            buf[start + p] = 0
        if len(slots) > 39:
            return ParseResult(tuple(slots), True)
        p += 1
    return ParseResult(tuple(slots), False)


def two_layer_tokens(fixture: bytes) -> tuple[bytes, ...]:
    """8728c8 reparse after token1; fixture prefix is deliberately 'Bridge'."""
    if not fixture.startswith(b'Bridge ') or b'\0' in fixture:
        raise ModelBounds('finite synthetic wrapper required')
    buf = bytearray(fixture + b'\0')
    first = parse_in_place(buf, 0, len(buf))
    if first.stopped_at_slot_limit or len(first.token_offsets) < 2:
        raise ModelBounds('synthetic wrapper not complete')
    p = first.token_offsets[1]
    second = parse_in_place(buf, p, len(buf) - p)
    if second.stopped_at_slot_limit:
        raise ModelBounds('slot limit')
    return tuple(_cstring(buf, p) for p in second.token_offsets)


def finite_native_shell_line(text: bytes) -> ShellLineResult:
    """Main4246ec->Shell+260->Readline743298 + tailzero744378 model.

    The literal synthetic text is not a device packet. Capacity includes native
    IqpDevelRaw + space and terminator/next zero; reject the full-line boundary.
    """
    if (not text or any(c < 32 or c > 126 for c in text) or b'#' in text or
            not text.startswith(b'"') or not text.endswith(b'"')):
        raise ModelBounds('finite printable quoted text required')
    line = b'IqpDevelRaw ' + text
    if len(line) > 254:
        raise ModelBounds('prefix plus text lacks two owned terminators')
    # Use stale nonzero storage to verify each completed Readline clears tail,
    # not merely the first Shell entry's zero initialization.
    buf = _TrackedBuffer(b'\xa5' * 256)
    buf[:len(line)] = line
    buf[len(line):] = bytes(256 - len(line))
    first = parse_in_place(buf, 0, 256)
    if first.stopped_at_slot_limit or len(first.token_offsets) != 2:
        raise ModelBounds('not finite native wrapper shape')
    p = first.token_offsets[1]
    second = parse_in_place(buf, p, 256 - p)
    if second.stopped_at_slot_limit:
        raise ModelBounds('slot limit')
    tokens = tuple(_cstring(buf, p) for p in second.token_offsets)
    return ShellLineResult(tokens, buf.max_index_read, len(line), 256)


def finite_sys_rejoin(tokens: tuple[bytes, ...]) -> bytes:
    """Conservative finite profile, deliberately stricter than native snprintf."""
    if not tokens or tokens[0] != b'Sys' or len(tokens) > 39:
        raise ModelBounds('not the finite Sys fixture')
    if any(b'\0' in t for t in tokens):
        raise ModelBounds('embedded terminator')
    result = b''.join(b' ' + t for t in tokens[1:])
    if len(result) > 255:
        raise ModelBounds('native command truncation would be possible')
    return result


def format_octal_only(value: bytes) -> bytes:
    """8f354 limited branch: literal printable bytes and 3-digit octal only."""
    result = bytearray()
    i = 0
    while i < len(value):
        c = value[i]
        if c == 92:
            digits = value[i + 1:i + 4]
            if len(digits) != 3 or any(d < 48 or d > 55 for d in digits):
                raise ModelBounds('not a fixed three-digit octal fixture')
            v = int(digits.decode('ascii'), 8)
            if v > 255:
                raise ModelBounds('octal overflow')
            result.append(v)
            i += 4
        else:
            if not 32 <= c <= 126 or c in (37, 39, 34, 36, 96):
                raise ModelBounds('unsupported format fixture character')
            result.append(c)
            i += 1
    return bytes(result)


def xargs_fixed_whitespace(value: bytes) -> tuple[bytes, ...]:
    """845bc restricted candidate: printable operands + newline separators.

    Unlike a universal xargs emulator, reject NUL/quotes/escapes/control bytes.
    Target's -0/-d are absent and must not be modeled as available.
    """
    if b'\0' in value or any(c in value for c in (b"'", b'"', b'\\')):
        raise ModelBounds('not fixed printable argv')
    if any(c < 32 and c not in (9, 10, 32) for c in value):
        raise ModelBounds('control byte')
    return tuple(value.split())
