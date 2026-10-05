#!/usr/bin/env python3
"""Offline capture of opaque16B backend, weak readback and local range tests."""
from pathlib import Path
import json
import subprocess
from save_setup_security_collect_static import ROOT, INPUTS, sha, sections, span, dump

OUT=ROOT/'analysis/firmware/pin_record1_opaque_restore_static'
REPORT=ROOT/'analysis/firmware/PIN_RECORD1_OPAQUE_RESTORE_STATIC.md'
DEPS={
 'analysis/firmware/SECURITY_PIN_CLEAR_NATIVE_STATIC.md':'445fe1bf0e4e78d5e7f50cc14d7bf326260dbe801bd98936a262b9ac25f9d38f',
 'analysis/firmware/security_pin_clear_native_static/manifest.json':'5844d7cd554659828599207edf574d118d76b22b8c3ccb1a95887186f057b42d',
 'tools/firmware/validate_security_eeprom_structure.py':'1a689c94e4756042ad6633b568e57ed4c61d962d03593809648093aafcd3d4a8',
}
WINDOWS=[
 ('Eeprom_raw_Write_complete',0x72104c,0x72115c),
 ('Eeprom_raw_Write_helper_complete',0x7214c4,0x721560),
 ('Partition_Write_full_15B_verify_and_status',0x71e97c,0x71ec64),
 ('Device_Write_mutex_single_IO_complete',0x71f21c,0x71f3b0),
 ('Eeprom_raw_Read_complete',0x721328,0x721400),
 ('Eeprom_raw_Read_helper_complete',0x721400,0x7214c4),
 ('Eeprom_device_Read_complete',0x71f088,0x71f21c),
 ('PinHandler_ctor_load_cache_only',0x6aa228,0x6aa3b8),
 ('PinHandler_SetPinCode_cache_writer_branch',0x6aa520,0x6aa620),
 ('System_backend_existing_key_Open_complete',0x720e00,0x72104c),
 ('PinHandler_Load_all_undefined_boundary',0x6aa620,0x6aa7fc),
 ('PinHandler_Record1_Write_complete',0x6aa7fc,0x6aa94c),
]


def main():
    for p,h in DEPS.items():
        if h:assert sha((ROOT/p).read_bytes())==h,p
        if p.endswith('/manifest.json'):
            for f,expected in json.loads((ROOT/p).read_bytes())['files'].items():
                assert sha((ROOT/f).read_bytes())==expected,f
    rel,expected=INPUTS['user_candidate'];raw=(ROOT/rel).read_bytes();assert sha(raw)==expected
    layout=sections(raw);OUT.mkdir(exist_ok=True)
    exact={'input':{'path':rel,'bytes':len(raw),'sha256':expected},
           'evidence_level':'static_and_host_synthetic_only','device_accessed':False,
           'actual_private_EEPROM_read':False,'PIN_decoded':False,'SDK_loaded':False,
           'outgoing_command_or_payload_generated':False,'ranges':[]}
    for name,a,b in WINDOWS:
        off,ch,sec=span(raw,layout,a,b)
        output=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump',
             '-d','--section=.text',f'--start-address={a:#x}',f'--stop-address={b:#x}',rel],cwd=ROOT,text=True)
        dest=OUT/(name+'.disasm.txt')
        text='STATIC ONLY; linked VAs; nearest exported labels are not private function names.\n'+output
        dest.write_text('\n'.join(s.rstrip() for s in text.splitlines()).rstrip()+'\n')
        exact['ranges'].append({'name':name,'start_va':hex(a),'end_va_exclusive':hex(b),
           'file_offset':hex(off),'section':sec,'bytes_hex':ch.hex(),'bytes_sha256':sha(ch),
           'disassembly':str(dest.relative_to(ROOT))})
    dump(OUT/'exact_bytes.json',exact)
    graph=json.loads((ROOT/'analysis/firmware/unwind_functions.json').read_bytes())
    direct={}
    for target in (0x6aa620,0x6aa94c):
        direct[hex(target)]=[{'function_va':hex(int(k)),'call_va':hex(c['pc'])}
          for k,cs in graph['calls'].items() for c in cs if c['target']==target]
    dump(OUT/'direct_calls.json',{'scope':'recorded direct BL only; no indirect-call exclusion',
         'input_graph_sha256':sha((ROOT/'analysis/firmware/unwind_functions.json').read_bytes()),
         'calls':direct})
    result=subprocess.run(['python3','tools/firmware/test_audit_security_record1_range.py'],
                          cwd=ROOT,capture_output=True,text=True)
    assert result.returncode==0,result.stderr
    dump(OUT/'host_tests.json',{'evidence_level':'host_synthetic_only','tests':12,
         'returncode':0,'real_private_snapshot_or_device_accessed':False,
         'summary':'Twelve finite opaque range/privacy/read-only tests passed; timing excluded'})
    members=sorted(p for p in OUT.iterdir() if p.is_file() and p.name!='manifest.json')
    members+=[Path(__file__).resolve(),REPORT,ROOT/'tools/firmware/audit_security_record1_range.py',
         ROOT/'tools/firmware/test_audit_security_record1_range.py',
         ROOT/'tools/firmware/save_setup_security_collect_static.py',
         ROOT/'analysis/firmware/unwind_functions.json']+[ROOT/p for p in DEPS]
    dump(OUT/'manifest.json',{'input_sha256':expected,'evidence_level':'static_and_host_only',
         'files':{str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in members}})
    print(f'{len(WINDOWS)} exact windows; 12 synthetic tests; {len(members)} members; '
          f'manifest {sha((OUT/"manifest.json").read_bytes())}')


if __name__=='__main__':main()
