#!/usr/bin/env python3
"""File-only independent CSU/DT init-array consistency check; no target execution."""
import argparse
import hashlib
import json
from pathlib import Path
import struct


def elf(data):
    assert data[:7] == b'\x7fELF\x02\x01\x01'
    assert struct.unpack_from('<HH', data, 16) == (2, 183)
    off = struct.unpack_from('<Q', data, 32)[0]
    size, count = struct.unpack_from('<HH', data, 54)
    assert size == 56
    headers = [struct.unpack_from('<IIQQQQQQ', data, off + i * 56)
               for i in range(count)]

    def at(va, length):
        matches = [p for p in headers if p[0] == 1 and p[3] <= va
                   and va + length <= p[3] + p[5]]
        assert len(matches) == 1, 'address must be backed by one LOAD'
        p = matches[0]
        return data[p[2] + va - p[3]:p[2] + va - p[3] + length]

    dynamic = [p for p in headers if p[0] == 2]
    assert len(dynamic) == 1
    p = dynamic[0]
    tags = {}
    for i in range(0, p[5], 16):
        tag, value = struct.unpack_from('<QQ', data, p[2] + i)
        if not tag:
            break
        if tag in (25, 27):
            assert tag not in tags
        tags[tag] = value
    return at, tags


def pointer_pair(at, pc, register):
    adrp, add = struct.unpack('<II', at(pc, 8))
    assert adrp & 0x9f000000 == 0x90000000 and adrp & 31 == register
    immediate = (((adrp >> 5) & 0x7ffff) << 2) | ((adrp >> 29) & 3)
    if immediate & 0x100000:
        immediate -= 0x200000
    page = (pc & ~4095) + (immediate << 12)
    assert add & 0xffc00000 == 0x91000000
    assert add & 31 == register and (add >> 5) & 31 == register
    return page + ((add >> 10) & 4095)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--stock', type=Path, required=True)
    p.add_argument('--candidate', type=Path, required=True)
    p.add_argument('--initializer-va', type=lambda x: int(x, 0), required=True)
    p.add_argument('--report', type=Path, required=True)
    a = p.parse_args()
    assert not a.report.exists(), 'preserve earlier evidence; use a fresh report'
    stock, candidate = a.stock.read_bytes(), a.candidate.read_bytes()
    assert hashlib.sha256(stock).hexdigest() == '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    old_at, old_tags = elf(stock)
    at, tags = elf(candidate)
    # The actual original _start passes this nonnull CSU entry to libc.
    assert at(0x40b3b4, 36) == old_at(0x40b3b4, 36)
    assert old_at(0x40b3b4, 16).hex() == '0300e0d20300c0f2c313a0f203169ef2'
    # Preserve the real loop body and original .init call, apart from four words.
    for begin, length in [(0x9ef0b0, 12), (0x9ef0c4, 4), (0x9ef0d0, 0x5c)]:
        assert at(begin, length) == old_at(begin, length)
    start = pointer_pair(at, 0x9ef0c8, 21)
    end = pointer_pair(at, 0x9ef0bc, 20)
    assert end > start and (end - start) % 8 == 0
    count = (end - start) // 8
    assert count <= 4096 and tags[27] % 8 == 0
    actual_slots = list(struct.unpack('<' + 'Q' * count, at(start, end - start)))
    old_count = old_tags[27] // 8
    old_slots = list(struct.unpack('<' + 'Q' * old_count, old_at(old_tags[25], old_tags[27])))
    result = {
        'candidate_sha256': hashlib.sha256(candidate).hexdigest(),
        'original_constructor_count': old_count,
        'actual_CSU_start': hex(start), 'actual_CSU_end': hex(end),
        'actual_CSU_count': count,
        'DT_INIT_ARRAY': hex(tags[25]), 'DT_INIT_ARRAY_count': tags[27] // 8,
        'actual_CSU_matches_DT_array': start == tags[25] and end - start == tags[27],
        'original_constructor_order_preserved': actual_slots[:old_count] == old_slots,
        'own_initializer_va': hex(a.initializer_va),
        'own_initializer_is_only_last_slot': actual_slots[old_count:] == [a.initializer_va],
        'target_executed': False, 'camera_SDK_remote_operations': 0,
        'scope': 'static actual startup instruction/array consistency; not runtime acceptance',
    }
    result['passed'] = all(result[k] for k in (
        'actual_CSU_matches_DT_array', 'original_constructor_order_preserved',
        'own_initializer_is_only_last_slot'))
    a.report.parent.mkdir(parents=True, exist_ok=True)
    a.report.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))
    raise SystemExit(0 if result['passed'] else 2)


if __name__ == '__main__':
    main()
