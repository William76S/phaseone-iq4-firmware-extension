#!/usr/bin/env python3
"""Independent local byte checks; does not execute target code or SDK."""
from pathlib import Path
import hashlib
import importlib.util
import json
import struct
import sys

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
report = json.loads((HERE / 'LINK_REPORT.json').read_text())
spec = importlib.util.spec_from_file_location('f1_static_elf', ROOT / 'tools/firmware/f1_user_elf_append_02/elf_append.py')
m = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = m
spec.loader.exec_module(m)
stock = m.Elf((ROOT / 'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes(), 2)
candidate = m.Elf((ROOT / 'build/f1_native_size_candidate_01/P1Linux_F1_NativeSize_6.03.26.bin').read_bytes(), 2)
assert hashlib.sha256(stock.data).hexdigest() == '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
allowed = bytearray(len(stock.data))
for off, n, _ in report['allowed_original_spans']:
    assert 0 <= off and off + n <= len(allowed)
    allowed[off:off + n] = b'\1' * n
assert all(a == b or allowed[i] for i, (a, b) in enumerate(zip(stock.data, candidate.data[:len(stock.data)])))
for name in ('.dynsym', '.dynstr', '.init_array'):
    assert stock.section_bytes(stock.index(name)) == candidate.section_bytes(candidate.index(name))
active = candidate.section_bytes(candidate.index('.f1.init_array'))
assert len(active) == 2728 and active[:2720] == stock.section_bytes(stock.index('.init_array'))
assert struct.unpack_from('<Q', active, 2720)[0] == report['initializer_va']
dynamic = candidate.section_bytes(candidate.index('.dynamic'))
tags = dict(struct.unpack_from('<qQ', dynamic, i) for i in range(0, len(dynamic), 16))
active_va = candidate.sh[candidate.index('.f1.init_array')][3]
assert tags[25] == active_va and tags[27] == len(active)
assert report['actual_CSU_startup']['start'] == active_va
assert report['actual_CSU_startup']['end'] == active_va + len(active)
actual_csu = m.verify_csu_startup(candidate, active_va, active)
assert actual_csu == report['actual_CSU_startup']
for h in report['hooks']:
    w = struct.unpack_from('<I', candidate.data, h['file_offset'])[0]
    imm = w & 0x3ffffff
    if imm & (1 << 25):
        imm -= 1 << 26
    assert w >> 26 == 0x25 and h['va'] + 4 * imm == h['new_target']
a = (ROOT / 'tools/firmware/f1_stock_display_payload_14/wrapper.S').read_text()
b = (ROOT / 'tools/firmware/f1_stock_display_payload_15/wrapper.S').read_text()
assert a == b.replace('iq4_f1_lv_draw_wrapper_15', 'iq4_f1_lv_draw_wrapper_14').replace('iq4_f1_after_stock_draw_15', 'iq4_f1_after_stock_draw_14')


def mode_memory_addresses(va, n):
    words = struct.unpack_from('<' + 'I' * n, candidate.data, candidate.va_offset(va, n * 4))
    registers, references = {}, []
    for i, w in enumerate(words):
        if w & 0x9f000000 == 0x90000000:  # ADRP
            imm = ((w >> 5) & 0x7ffff) << 2 | ((w >> 29) & 3)
            if imm & (1 << 20):
                imm -= 1 << 21
            registers[w & 31] = ((va + i * 4) & ~0xfff) + (imm << 12)
        elif w & 0xffc00000 == 0x91000000 and ((w >> 5) & 31) in registers:  # ADD X unsigned immediate
            registers[w & 31] = registers[(w >> 5) & 31] + ((w >> 10) & 4095)
        elif w & 0xffc00000 in (0xb9400000, 0xb9000000) and ((w >> 5) & 31) in registers:  # LDR/STR W
            references.append(registers[(w >> 5) & 31] + (((w >> 10) & 4095) << 2))
    return words, references


symbols = report['own_symbols']
get_words, get_refs = mode_memory_addresses(symbols['iq4_f1_mode_get_01'], 3)
set_words, set_refs = mode_memory_addresses(symbols['iq4_f1_mode_set_on_ui_01'], 16)
state = candidate.sh[candidate.index('.f1.0.36.bss.requested_mode')][3]
assert get_refs == [state] and state in set_refs
assert any(p[0] == 1 and p[1] & 2 and p[3] <= state < p[3] + p[6] for p in candidate.ph)
result = {
    'schema': 'iq4_f1_native_size_root_actual_bytes_01',
    'original_body_except_finite_declared_spans_equal': True,
    'original_import_symbol_and_string_bytes_equal': True,
    'original_legacy_init_section_unchanged': True,
    'active_DT_array_original_340_init_order_equal_and_one_added': True,
    'active_CSU_array_equal_DT_array': True,
    'actual_CSU_instruction_pair_decode': actual_csu,
    'BL_words_and_actual_targets_verified': report['hooks'],
    'actual_shared_mode_state_va': hex(state),
    'mode_getter_actual_words': [hex(x) for x in get_words],
    'mode_setter_actual_words': [hex(x) for x in set_words],
    'display_wrapper_normalized_exact14': True,
    'actual_target_executed': False,
    'camera_access': False,
    'user_sha256': hashlib.sha256(candidate.data).hexdigest(),
    'source_lock_sha256': hashlib.sha256((ROOT / 'tools/firmware/f1_stock_menu_03/SOURCE_SHA256.json').read_bytes()).hexdigest(),

}
(HERE / 'ROOT_ACTUAL_BYTES.json').write_text(json.dumps(result, indent=2) + '\n')
print(json.dumps(result, indent=2))
