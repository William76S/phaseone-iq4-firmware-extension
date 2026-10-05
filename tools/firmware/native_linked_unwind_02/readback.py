#!/usr/bin/env python3
"""Run the host C seal verifier against actual ELF bytes; never execute ARM."""
from pathlib import Path
import argparse, ctypes, hashlib, importlib.util, json, sys

ROOT = Path(__file__).resolve().parents[3]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--build', type=Path, required=True)
    ap.add_argument('--library', type=Path, required=True)
    args = ap.parse_args()
    directory, library = args.build.resolve(), args.library.resolve()
    build = json.loads((directory / 'BUILD.json').read_text())
    report = json.loads((directory / 'LINK_REPORT.json').read_text())
    review = json.loads((directory / 'LINKED_UNWIND_STATIC.json').read_text())
    user = ROOT / build['User']['path']
    original = user.read_bytes()
    assert hashlib.sha256(original).hexdigest() == build['User']['sha256'] == report['candidate_sha256']
    path = ROOT / 'tools/firmware/f1_user_elf_append_02/elf_append.py'
    spec = importlib.util.spec_from_file_location('unwind02_readback_backend', path)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    elf = module.Elf(original, 2)
    lib = ctypes.CDLL(str(library))
    native_seal = (ctypes.c_uint8 * 131072).in_dll(lib, 'iq4_linked_contract_seal_01')
    host_seal = ctypes.addressof(native_seal)
    target_seal = report['own_symbols']['iq4_linked_contract_seal_01']
    callback_type = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_void_p, ctypes.c_size_t,
                                     ctypes.c_void_p, ctypes.c_size_t)
    current = bytearray(original)
    nonexact = False

    def read(_context, address, output, size):
        if nonexact:
            return 2
        if not size or size > 4096:
            return 0
        if host_seal <= address and size <= 131072 and address - host_seal <= 131072 - size:
            address = target_seal + (address - host_seal)
        try:
            offset = elf.va_offset(address, size)
        except Exception:
            return 0
        if offset + size > len(current):
            return 0
        ctypes.memmove(output, bytes(current[offset:offset + size]), size)
        return 1

    callback = callback_type(read)

    class Reader(ctypes.Structure):
        _fields_ = [('context', ctypes.c_void_p), ('read', callback_type)]

    reader = Reader(None, callback)
    lib.iq4_linked_contract_current_01.argtypes = [ctypes.c_void_p]
    lib.iq4_linked_contract_current_01.restype = ctypes.c_int
    cases = []

    def check(name, expected, address=None):
        result = lib.iq4_linked_contract_current_01(ctypes.byref(reader))
        assert result == expected, (name, result, expected)
        cases.append(dict(case=name, result=result, expected=expected, mutated_va=address))

    def mutate(name, address, expected=0):
        offset = elf.va_offset(address, 1)
        current[offset] ^= 1
        check(name, expected, address)
        current[offset] ^= 1

    check('actual_sealed_ELF', 1)
    cells = [r for r in review['immutable_unwind_dependencies']
             if r['writable_section'] and r['kind'] == 'personality_indirection_cell']
    assert cells
    mutate('actual_RW_personality_cell_mutation_rejected', cells[0]['va'])
    for kind in ('type_indirection_cell', 'own_immutable_RTTI'):
        matches = [r for r in review['immutable_unwind_dependencies'] if r['kind'] == kind]
        if matches:
            mutate('actual_' + kind + '_mutation_rejected', matches[0]['va'])
    selectors = [r for r in review['immutable_unwind_dependencies'] if r['kind'] == 'loader_COPY_dynamic_selector']
    if selectors:
        mutate('actual_active_dynamic_selector_mutation_rejected', selectors[0]['va'] + 8)
    metadata = [r for r in review['immutable_unwind_dependencies'] if r['kind'] == 'loader_COPY_binding_metadata']
    if metadata:
        mutate('actual_loader_COPY_binding_metadata_mutation_rejected', metadata[0]['va'])
    executable = [h for h in elf.sh if h[2] & 6 == 6 and h[5] and h[4] >= report['baseline_bytes']]
    assert executable
    mutate('actual_RX_mutation_rejected', executable[0][3])
    mutate('actual_FDE_mutation_rejected', review['own_FDEs'][0]['fde'] + 8)
    offset = elf.va_offset(target_seal, 131072)
    saved = current[offset:offset + 131072]
    current[offset:offset + 131072] = bytes(131072)
    check('actual_unsealed_manifest_rejected', 0)
    current[offset:offset + 131072] = saved
    nonexact = True
    check('nonexact_reader_rejected', 0)
    nonexact = False
    regions = report['linked_contract_seal']['regions']
    for i, section in enumerate(elf.sh):
        if elf.names[i].startswith('.f1.') and '.data' in elf.names[i] and section[1] == 1 and section[2] & 1 and section[5]:
            candidates = [section[3], section[3] + section[5] - 1]
            found = next((p for p in candidates if not any(r['va'] <= p < r['va'] + r['bytes'] for r in regions)), None)
            if found is not None and 'rel.ro' not in elf.names[i] and 'DW.ref' not in elf.names[i]:
                mutate('ordinary_mutable_data_excluded_from_unwind_seal', found, 1)
                break
    else:
        raise AssertionError('no genuine nonsealed writable data witness')
    result = dict(schema='iq4_unwind02_actual_ELF_host_C_readback_01', User=build['User'],
                  library=dict(path=str(library.relative_to(ROOT)), bytes=library.stat().st_size,
                               sha256=hashlib.sha256(library.read_bytes()).hexdigest()),
                  cases=cases, host_C_verifier_executed=True, loader_guard_executed=False,
                  actual_target_process=False, target_executed=False, camera_accessed=False)
    output = directory / 'ACTUAL_ELF_HOST_READBACK.json'
    assert not output.exists()
    output.write_text(json.dumps(result, indent=2) + '\n')
    print(len(cases), 'actual ELF byte/failure host C cases passed; no target execution')


if __name__ == '__main__':
    main()
