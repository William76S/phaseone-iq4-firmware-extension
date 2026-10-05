#!/usr/bin/env python3
"""Source-locked offline capture of five finite native permission bool reads."""
from pathlib import Path
import subprocess
from save_setup_security_collect_static import ROOT, INPUTS, sha, sections, span, dump

OUT=ROOT/'analysis/firmware/volatile_permission_read_static'
REPORT=ROOT/'analysis/firmware/VOLATILE_PERMISSION_READ_STATIC.md'
LOCKED_INPUTS={
    'analysis/firmware/VOLATILE_LOCK_COMMAND_STATIC.md':'6d7435514c2ddcb08f631802cf3671384fa8772572bcfb30bde284ba1ab6bea0',
    'analysis/firmware/volatile_lock_command_static/manifest.json':'df13f2222abb25c6c2e31835b1fc862fa44d9fd0df5bd9741ff6a17a029fdf50',
    'tools/firmware/os_event_locked_host.py':'8eef927b93ecf1926876889b9ef2a3476c4153b47026e83b284e7ad6a268fdb1',
    'tools/firmware/sys_read_backup_host.py':'840ea3b3fb589bfe50f65445a53f72261a01581106db24aad627b40e45cd9d5d',
}
WINDOWS=[
    ('five_Permission_bool_constructors',0x63db5c,0x63dbfc),
    ('bool_ctor_event_registration',0x415354,0x41541c),
    ('Locked_listener_and_recompute_callback',0x6aac0c,0x6aac70),
    ('Unlocked_inverse_and_permission_branch',0x6aac90,0x6aad44),
    ('Level_NoLock_four_permission_stores',0x6aad44,0x6aad94),
    ('Level_Basic_four_permission_stores',0x6aae38,0x6aae88),
    ('Locked_false_four_permission_stores_and_guards',0x6ab140,0x6ab23c),
    ('native_bool_get_and_set_notification',0x41497c,0x414a30),
]
NAMES=[('Unlocked',0xbe1c38,0x768),('UnlockFirmwareUpdate',0xbe1c48,0x840),
       ('UnlockUI',0xbe1c60,0x918),('UnlockCapture',0xbe1c70,0x9f0),
       ('UnlockRestoreToDefault',0xbe1c80,0xac8)]


def main():
    import json
    for p,h in LOCKED_INPUTS.items():assert sha((ROOT/p).read_bytes())==h,p
    lm=json.loads((ROOT/'analysis/firmware/volatile_lock_command_static/manifest.json').read_bytes())
    for p,h in lm['files'].items():assert sha((ROOT/p).read_bytes())==h,p
    rel,expected=INPUTS['user_candidate'];raw=(ROOT/rel).read_bytes();assert sha(raw)==expected
    layout=sections(raw);OUT.mkdir(exist_ok=True)
    exact={'input':{'path':rel,'sha256':expected,'bytes':len(raw)},'evidence_level':'static_only',
           'device_accessed':False,'sdk_loaded':False,'network_accessed':False,
           'runtime_identity_verified':False,'event_or_record_changed':False,
           'ranges':[],'name_records':[],'frozen_dependencies':LOCKED_INPUTS}
    for name,a,b in WINDOWS:
        off,chunk,sec=span(raw,layout,a,b)
        out=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump',
             '-d','--section=.text',f'--start-address={a:#x}',f'--stop-address={b:#x}',rel],cwd=ROOT,text=True)
        text='STATIC ONLY; linked VAs; nearest exported labels are not recovered private names.\n'+out
        dest=OUT/(name+'.disasm.txt')
        dest.write_text('\n'.join(s.rstrip() for s in text.splitlines()).rstrip()+'\n')
        exact['ranges'].append({'name':name,'start_va':hex(a),'end_va_exclusive':hex(b),
            'file_offset':hex(off),'section':sec,'bytes_hex':chunk.hex(),'bytes_sha256':sha(chunk),
            'disassembly':str(dest.relative_to(ROOT))})
    for name,va,groupoff in NAMES:
        off,_,sec=span(raw,layout,va,va+1);chunk=raw[off:raw.index(0,off)+1]
        assert chunk==name.encode()+b'\0'
        exact['name_records'].append({'name':name,'name_va':hex(va),'file_offset':hex(off),
            'section':sec,'PinGroup_bool_offset':hex(groupoff),'interior_event_offset':hex(groupoff+8),
            'bytes_hex':chunk.hex(),'bytes_sha256':sha(chunk)})
    dump(OUT/'exact_bytes.json',exact)
    result=subprocess.run(['python3','tools/firmware/test_os_event_permissions_host.py'],cwd=ROOT,
                          capture_output=True,text=True)
    assert result.returncode==0,result.stderr
    dump(OUT/'host_tests.json',{'evidence_level':'host_synthetic_validation','tests':10,
         'returncode':0,'sdk_loaded':False,'device_accessed':False,
         'summary':'Ten synthetic finite whitelist/reply/snapshot tests passed; timing excluded'})
    files=sorted(p for p in OUT.iterdir() if p.is_file() and p.name!='manifest.json')
    files += [Path(__file__).resolve(),REPORT,ROOT/'tools/firmware/os_event_permissions_host.py',
              ROOT/'tools/firmware/test_os_event_permissions_host.py',
              ROOT/'tools/firmware/save_setup_security_collect_static.py']
    files += [ROOT/p for p in LOCKED_INPUTS]
    dump(OUT/'manifest.json',{'input_sha256':expected,'evidence_level':'static_and_host_only',
        'files':{str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in files}})
    print(f'{len(WINDOWS)} windows; {len(NAMES)} exact names; {len(files)} manifest members; '
          f'manifest {sha((OUT/"manifest.json").read_bytes())}')


if __name__=='__main__':main()
