#!/usr/bin/env python3
"""Native development query/auth ABI evidence, offline only, no packets."""
from pathlib import Path
import subprocess
from save_setup_security_collect_static import ROOT, INPUTS, sha, sections, span, dump

OUT = ROOT / 'analysis/firmware/development_protocol_query_static'
REPORT = ROOT / 'analysis/firmware/DEVELOPMENT_PROTOCOL_QUERY_STATIC.md'
WINDOWS = [
    ('native_common_receive_dispatch', 0x862d5c, 0x863028),
    ('development_payload_dispatch_and_protocol_reply', 0x8637e0, 0x863960),
    ('protocol_reply_payload_constructor', 0x863a44, 0x863aa0),
    ('native_response_allocate_header_zero_and_body', 0x863280, 0x863570),
    ('native_response_queue_and_failure_release', 0x863570, 0x863618),
    ('development_common_header_constructor', 0x863b3c, 0x863bd0),
    ('common_base_header_constructor', 0x84b73c, 0x84b7a4),
    ('development_common_header_version', 0x863bd0, 0x863c8c),
    ('shell_dispatch_separate_branch', 0x863028, 0x863204),
    ('shell_accept_input_pointer_and_lifecycle', 0x871e24, 0x872088),
    ('native_auth_required_source', 0x851d44, 0x851d80),
    ('native_auth_token_compare_and_connection_allow', 0x851fac, 0x852140),
    ('native_auth_result_return', 0x852140, 0x8522ec),
    ('native_state_auth_and_allow_owner_saved', 0x8512bc, 0x8512d4),
    ('development_factory_auth_and_allow_args', 0x85db34, 0x85dc48),
    ('channel_manager_state_auth_and_allow_args', 0x85becc, 0x85bf58),
    ('native_auth_bool_ctor_default', 0x663fec, 0x664018),
    ('native_development_auth_owners_main', 0x41a570, 0x41a5f0),
    ('factory_usb_auth_params_main', 0x424f88, 0x425068),
    ('factory_auth_group_and_allow_saved', 0x85cc54, 0x85cd68),
]
TABLES = [
    ('reply_allocation_name', 0xda4060, 0xda4073),
    ('auth_required_name', 0xbec230, 0xbec242),
    ('auth_digest_name', 0xbec248, 0xbec256),
    ('usb_development_auth_name', 0x9f45b0, 0x9f45b9),
    ('auth_denial_log', 0xd9d398, 0xd9d3e0),
    ('unsupported_shell_split_log', 0xda3e38, 0xda3e80),
]


def main():
    rel, expected = INPUTS['user_candidate']
    raw = (ROOT / rel).read_bytes()
    assert sha(raw) == expected
    layout = sections(raw)
    assert span(raw, layout, 0xda4060, 0xda4072)[1] == b'DevHandlerProtoVer'
    OUT.mkdir(exist_ok=True)
    exact = {'input': {'path': rel, 'sha256': expected}, 'evidence_level': 'static_only',
             'candidate_is_live_user_verified': False, 'device_accessed': False,
             'sdk_loaded': False, 'query_payload_or_packet_generated': False,
             'actual_security_code_or_token_read': False, 'ranges': [], 'tables': []}
    for name, start, end in WINDOWS:
        off, data, section = span(raw, layout, start, end)
        output = subprocess.check_output([
            '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump', '-d',
            '--section=.text', f'--start-address={start:#x}', f'--stop-address={end:#x}', rel],
            cwd=ROOT, text=True)
        p = OUT / (name + '.disasm.txt')
        output = 'STATIC ONLY; nearest exported labels are not private function names.\n' + output
        p.write_text('\n'.join(s.rstrip() for s in output.splitlines()).rstrip() + '\n')
        exact['ranges'].append({'name': name, 'start_va': hex(start), 'end_va_exclusive': hex(end),
                                'file_offset': hex(off), 'section': section,
                                'bytes_sha256': sha(data), 'bytes_hex': data.hex(),
                                'disassembly': str(p.relative_to(ROOT))})
    for name, start, end in TABLES:
        off, data, section = span(raw, layout, start, end)
        exact['tables'].append({'name': name, 'start_va': hex(start), 'end_va_exclusive': hex(end),
                                'file_offset': hex(off), 'section': section,
                                'bytes_sha256': sha(data), 'bytes_hex': data.hex()})
    dump(OUT / 'exact_bytes.json', exact)
    files = sorted(p for p in OUT.iterdir() if p.is_file() and p.name != 'manifest.json')
    files += [Path(__file__).resolve(), REPORT, ROOT / 'tools/firmware/save_setup_security_collect_static.py']
    dump(OUT / 'manifest.json', {'input_sha256': expected, 'evidence_level': 'static_only',
                               'files': {str(p.relative_to(ROOT)): sha(p.read_bytes()) for p in files}})
    print(f'{len(WINDOWS)} windows; {len(TABLES)} tables; manifest {sha((OUT/"manifest.json").read_bytes())}')


if __name__ == '__main__':
    main()
