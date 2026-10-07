#!/usr/bin/env python3
"""Execute the real linked production JPEG constructor's inlined pins predicate.

No test macro, rebuild or expected-byte source is used. The self-read fixture
copies actual linked ELF file-backed VA bytes. Native allocation/constructor
is skipped; after pins succeed the first Main+460 identity read deliberately
fails. This proves production pin admission only, not a live camera binding.
"""
from pathlib import Path
import argparse
import hashlib
import importlib.util
import json
import struct
import sys
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import (UC_ARM64_REG_X0, UC_ARM64_REG_X1,
    UC_ARM64_REG_X2, UC_ARM64_REG_X3, UC_ARM64_REG_X6,
    UC_ARM64_REG_X30, UC_ARM64_REG_PC, UC_ARM64_REG_SP)

ROOT = Path(__file__).resolve().parents[3]


def row(p):
    p = p.resolve()
    b = p.read_bytes()
    return dict(path=str(p.relative_to(ROOT)), bytes=len(b),
                sha256=hashlib.sha256(b).hexdigest())


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--build', type=Path, required=True)
    ap.add_argument('--expect', type=int, choices=[0, 1], required=True)
    ap.add_argument('--output', type=Path, required=True)
    a = ap.parse_args()
    buildpath = a.build.resolve() / 'BUILD.json'
    build = json.loads(buildpath.read_text())
    payload = ROOT / build['User']['path']
    assert row(payload) == build['User']
    reportpath = ROOT / build['link_report']['path']
    assert row(reportpath) == build['link_report']
    report = json.loads(reportpath.read_text())
    backend = ROOT / 'tools/firmware/f1_user_elf_append_03/elf_append.py'
    assert row(backend)['sha256'] == '05c7bb3eabcd471d7ef2fbe8a53c014abcc62e212a9234810521e0ec91557b6d'
    spec = importlib.util.spec_from_file_location('production_pins_elf_backend', backend)
    m = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = m
    spec.loader.exec_module(m)
    elf = m.Elf(payload.read_bytes(), 2)
    ctor = report['own_symbols']['iq4_stock_jpeg_ctor_01']
    reader = report['own_symbols']['iq4_native_self_read_01']
    cmp_va = report['original_import_bindings']['memcmp']['va']
    u = Uc(UC_ARCH_ARM64, UC_MODE_ARM)
    phoff = struct.unpack_from('<Q', elf.data, 32)[0]
    esz, count = struct.unpack_from('<HH', elf.data, 54)
    loads = []
    for i in range(count):
        typ, flags, off, va, _, fs, ms, _ = struct.unpack_from(
            '<IIQQQQQQ', elf.data, phoff + i * esz)
        if typ == 1:
            low, high = va & ~4095, (va + ms + 4095) & ~4095
            u.mem_map(low, high - low)
            u.mem_write(va, elf.data[off:off + fs])
            loads.append((va, off, fs))
    main_sp, stack, end = 0x28002000, 0x3000f000, 0x7000000
    u.mem_map(0x28000000, 0x10000)
    u.mem_map(0x30000000, 0x10000)
    u.mem_map(end, 0x1000)
    for i in range(6):
        u.reg_write(UC_ARM64_REG_X0 + i, 0x28003000 + i * 0x100)
    u.reg_write(UC_ARM64_REG_X6, main_sp)
    u.reg_write(UC_ARM64_REG_SP, stack)
    u.reg_write(UC_ARM64_REG_X30, end)
    stats = dict(stock_constructor_fixture_calls=0, pin_reads=0,
                 memcmp_calls=0, reached_Main_identity_read=False, returned=False)
    mismatch = []
    last_read = None
    main_read_return_pc = None

    def native_return(value):
        u.reg_write(UC_ARM64_REG_X0, value & ((1 << 64) - 1))
        u.reg_write(UC_ARM64_REG_PC, u.reg_read(UC_ARM64_REG_X30))

    def file_bytes(at, n):
        # Strictly actual linked ELF VA mapping, never expected pin arrays.
        for va, off, fs in loads:
            if va <= at and n <= fs and at - va <= fs - n:
                return elf.data[off + at - va:off + at - va + n]
        return None

    def hook(uc, pc, size, context):
        nonlocal last_read, main_read_return_pc
        if pc == 0x8e0928:
            stats['stock_constructor_fixture_calls'] += 1
            native_return(0)
        elif pc == reader:
            at, dest, n = (u.reg_read(r) for r in
                          (UC_ARM64_REG_X1, UC_ARM64_REG_X2, UC_ARM64_REG_X3))
            assert 0 < n <= 64, (hex(at), n)
            if at == main_sp + 0x460:
                stats['reached_Main_identity_read'] = True
                main_read_return_pc = u.reg_read(UC_ARM64_REG_X30)
                # Do not pretend the synthetic Main contains a real registry.
                native_return(0)
                return
            actual = file_bytes(at, n)
            assert actual is not None, ('unexpected non-file read', hex(at), n)
            stats['pin_reads'] += 1
            last_read = dict(va=at, bytes=n, actual=actual.hex())
            u.mem_write(dest, actual)
            native_return(1)
        elif pc == cmp_va:
            lhs, rhs, n = (u.reg_read(r) for r in
                           (UC_ARM64_REG_X0, UC_ARM64_REG_X1, UC_ARM64_REG_X2))
            left, right = bytes(u.mem_read(lhs, n)), bytes(u.mem_read(rhs, n))
            value = next((x - y for x, y in zip(left, right) if x != y), 0)
            stats['memcmp_calls'] += 1
            if value:
                assert last_read and last_read['bytes'] == n
                mismatch.append(dict(**last_read, expected=right.hex(),
                    first_differences=[dict(va=last_read['va']+i,
                                           actual=left[i], expected=right[i])
                                       for i in range(n) if left[i] != right[i]],
                    native_memcmp_return=value))
            native_return(value)
        elif pc == end:
            stats['returned'] = True
            u.emu_stop()

    u.hook_add(UC_HOOK_CODE, hook)
    u.emu_start(ctor, 0, count=1000000)
    assert stats['returned'] and stats['stock_constructor_fixture_calls'] == 1
    pins = int(stats['reached_Main_identity_read'])
    assert pins == a.expect, (pins, a.expect, stats, mismatch)
    if pins:
        assert not mismatch
    else:
        assert len(mismatch) == 1
        assert any(v['va'] == 0x825fcc for v in mismatch[0]['first_differences'])
    out = a.output.resolve()
    out.parent.mkdir(parents=True, exist_ok=True)
    result = dict(schema='iq4_actual_production_inlined_JPEG_pins_57',
        source=row(Path(__file__)), build=row(buildpath), User=row(payload),
        link_report=row(reportpath), backend=row(backend),
        production_constructor_va=ctor, production_self_read_fixture_va=reader,
        original_memcmp_fixture_va=cmp_va,
        inlined_pins_result=pins, expected=a.expect, statistics=stats,
        Main_identity_read_return_pc=main_read_return_pc, mismatch=mismatch,
        test_macro_or_expected_bytes_source_used=False,
        fixtures=['original 8e0928 constructor skipped; no objects/resources created',
                  'self_read copies only actual linked ELF file-backed VA bytes',
                  'memcmp compares actual emulated memory',
                  'after pin pass Main+460 read finitely refuses synthetic identity'],
        full_constructor_binding_proved=False, camera_accessed=False,
        target_device_executed=False)
    out.write_text(json.dumps(result, indent=2) + '\n')
    print('PASS real production inlined pins =', pins,
          '; actual linked ELF source, no test macro; full binding not claimed')


if __name__ == '__main__':
    main()
