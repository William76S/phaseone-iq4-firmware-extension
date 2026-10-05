#!/usr/bin/env python3
"""Offline exact-byte freeze of finite native Locked command contract."""
from pathlib import Path
import struct
import subprocess
from save_setup_security_collect_static import ROOT, INPUTS, sha, sections, span, dump

OUT = ROOT / 'analysis/firmware/volatile_lock_command_static'
REPORT = ROOT / 'analysis/firmware/VOLATILE_LOCK_COMMAND_STATIC.md'
WINDOWS = [
    ('global_Shell_constructor',0x40bc18,0x40bc58),
    ('Main_shared_directory_pass',0x40bd78,0x40bdbc),
    ('OsCommands_actual_directory_registration',0x40bdf4,0x40be3c),
    ('OsCommands_ctor_complete',0x6ba4e4,0x6ba730),
    ('OsCommands_id2_dispatch',0x6bd814,0x6bd9ac),
    ('OsCommands_execute_completion',0x6bdf70,0x6bdfb0),
    ('DevelopmentShell_shared_owner',0x424700,0x424714),
    ('DevelopmentShell_execute_complete',0x8728c8,0x872a38),
    ('Main_PinGroup_actual_create',0x41a100,0x41a118),
    ('PinGroup_ctor_complete',0x63da2c,0x63dd14),
    ('Locked_bool_ctor_complete',0x415354,0x41541c),
    ('OsEvent_base_ctor_complete',0x70f12c,0x70f208),
    ('OsEvent_registry_register_complete',0x711aa0,0x711b0c),
    ('OsEvent_node_owner_store_and_append',0x711cd8,0x711d28),
    ('OsEvent_command_complete',0x6bb978,0x6bc7d4),
    ('OsEvent_formatter_complete',0x6bdfb0,0x6be390),
    ('OsEvent_list_node_read',0x6bebe0,0x6bec4c),
    ('CommandLine_whole_token_compare',0x7408d4,0x740a70),
    ('CommandLine_any_token_compare',0x740b08,0x740b78),
    ('OsEvent_prefix_pattern_parse',0x744e8c,0x744ff4),
    ('OsEvent_prefix_pattern_match',0x744ff4,0x7451b8),
    ('bool_RTTI_name_complete',0x418270,0x418298),
    ('RTTI_name_and_equality',0x40bfb4,0x40c064),
    ('bool_formatter_complete',0x418298,0x418768),
    ('bool_decoder_complete_and_thunk',0x418768,0x418bdc),
    ('ordinary_bool_getter_setter',0x41497c,0x414a30),
    ('OsEvent_notify_complete',0x70f2f8,0x70f4e4),
    ('Main_PinDTO_actual_owner',0x41b10c,0x41b128),
    ('Main_second_DTO_actual_owner',0x41b1b4,0x41b1d4),
    ('Main_SecurityHandler_actual_owners',0x41c090,0x41c0dc),
    ('SecurityHandler_subscribe_and_callback',0x6aab5c,0x6aac70),
    ('SecurityHandler_recompute_complete',0x6aac70,0x6ab23c),
    ('PinDTO_lock_flag_wrapper',0x5efaa4,0x5efad0),
    ('PinDTO_lock_flag_change_and_notify',0x5f1acc,0x5f1b44),
    ('second_DTO_lock_flag_wrapper',0x5afd18,0x5afd44),
    ('second_DTO_lock_flag_change_and_notify',0x5b4f08,0x5b4f80),
    ('PinUI_constructor_and_subscriptions',0x57682c,0x576a18),
    ('PinUI_event_callback_complete',0x576a18,0x576d04),
    ('PinHandler_constructor_direct_subscriptions',0x6aa228,0x6aa3b8),
    ('PinDTO_only_Level_value_binding',0x63de0c,0x63de68),
    ('System_Level_Fails_storage_registration',0x6a7d4c,0x6a7dac),
]
STRINGS = [
    ('OsCommands_name',0xc13258),('OsEvent_name',0xc132d0),
    ('Locked_name',0xbe1ba0),('OsEvent_list_help',0xc13818),
    ('OsEvent_set_help',0xc13888),('OsEvent_set_token',0xc139c8),
    ('OsEvent_list_token',0xc13a28),('full_name_flag',0xc134f8),
    ('no_notify_flag',0xc139e0),('heading',0xc13e10),('heading_divider',0xc13e80),
    ('row_format',0xc13f48),('bool_scan_decimal',0x9f11f0),
    ('bool_format_true',0x9f1230),('bool_format_false',0x9efb98),
    ('bool_format_string',0x9f1238),
]


def main():
    rel, expected = INPUTS['user_candidate']
    raw = (ROOT / rel).read_bytes()
    assert sha(raw) == expected
    layout = sections(raw)
    OUT.mkdir(exist_ok=True)
    exact = {'input':{'path':rel,'sha256':expected,'bytes':len(raw)},
             'evidence_level':'static_only','device_accessed':False,'sdk_loaded':False,
             'runtime_User_identity_verified':False,'PIN_or_key_value_read':False,
             'event_or_record_changed':False,'ranges':[],'data_records':[]}
    for name,a,b in WINDOWS:
        offset,chunk,sec=span(raw,layout,a,b)
        out=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump',
              '-d','--section=.text',f'--start-address={a:#x}',f'--stop-address={b:#x}',rel],cwd=ROOT,text=True)
        text='STATIC ONLY; linked VAs; exported nearest labels are not recovered private names.\n'+out
        dest=OUT/(name+'.disasm.txt')
        dest.write_text('\n'.join(line.rstrip() for line in text.splitlines()).rstrip()+'\n')
        exact['ranges'].append({'name':name,'start_va':hex(a),'end_va_exclusive':hex(b),
              'file_offset':hex(offset),'section':sec,'bytes_hex':chunk.hex(),
              'bytes_sha256':sha(chunk),'disassembly':str(dest.relative_to(ROOT))})
    for name,va in STRINGS:
        off,_,sec=span(raw,layout,va,va+1)
        chunk=raw[off:raw.index(0,off)+1]
        exact['data_records'].append({'name':name,'va':hex(va),'file_offset':hex(off),
              'section':sec,'text':chunk[:-1].decode(),'bytes_hex':chunk.hex(),'bytes_sha256':sha(chunk)})
    for name,va,size in [('OsCommands_vtable',0xc14108,0x50),('Locked_interior_event_vtable',0x9f1988,0x30)]:
        off,chunk,sec=span(raw,layout,va,va+size)
        exact['data_records'].append({'name':name,'va':hex(va),'file_offset':hex(off),
              'section':sec,'bytes_hex':chunk.hex(),'bytes_sha256':sha(chunk),
              'U64_slots':[hex(x) for x in struct.unpack('<'+'Q'*(size//8),chunk)]})
    assert exact['data_records'][-2]['U64_slots'][9] == '0x6bd814'
    assert exact['data_records'][-1]['U64_slots'][3:6] == ['0x418760','0x418bd4','0x418290']
    # Preserve the exact relocation record and its symbol binding, rather than
    # claiming the file's zero COPY destination has a loaded RTTI object.
    dynsym=next(s for s in layout if s['name']=='.dynsym')
    dynstr=next(s for s in layout if s['name']=='.dynstr')
    relasec=next(s for s in layout if s['name']=='.rela.dyn')
    records=[]
    for off in range(relasec['offset'],relasec['offset']+relasec['size'],24):
        addr,info,addend=struct.unpack_from('<QQq',raw,off)
        if addr != 0xf42d40: continue
        symoff=dynsym['offset']+(info>>32)*24
        nameindex=struct.unpack_from('<I',raw,symoff)[0]
        noff=dynstr['offset']+nameindex
        symname=raw[noff:raw.index(0,noff)].decode()
        assert (info&0xffffffff)==1024 and symname=='_ZTIb'
        chunk=raw[off:off+24]
        records.append({'name':'bool_RTTI_COPY_relocation','destination_va':hex(addr),
                        'relocation_type':1024,'symbol':symname,'file_offset':hex(off),
                        'bytes_hex':chunk.hex(),'bytes_sha256':sha(chunk),'addend':addend,
                        'symbol_entry_file_offset':hex(symoff),
                        'symbol_entry_hex':raw[symoff:symoff+24].hex()})
    assert len(records)==1
    exact['data_records']+=records
    dump(OUT/'exact_bytes.json',exact)
    # Run meaningful finite host response checks; they execute no target code.
    result=subprocess.run(['python3','tools/firmware/test_os_event_locked_host.py'],cwd=ROOT,
                          capture_output=True,text=True)
    assert result.returncode==0,result.stderr
    dump(OUT/'host_tests.json',{'evidence_level':'host_synthetic_validation',
          'tests':7,'returncode':result.returncode,'device_accessed':False,'sdk_loaded':False,
          'stdout':result.stdout,'stderr_summary':'7 synthetic tests passed; runtime timing excluded'})
    files=sorted(p for p in OUT.iterdir() if p.is_file() and p.name!='manifest.json')
    files += [Path(__file__).resolve(), REPORT,ROOT/'tools/firmware/os_event_locked_host.py',
              ROOT/'tools/firmware/test_os_event_locked_host.py',
              ROOT/'tools/firmware/sys_read_backup_host.py',
              ROOT/'tools/firmware/save_setup_security_collect_static.py']
    dump(OUT/'manifest.json',{'input_sha256':expected,'evidence_level':'static_and_host_only',
          'files':{str(p.relative_to(ROOT)):sha(p.read_bytes()) for p in files}})
    print(f'{len(WINDOWS)} exact windows; {len(exact["data_records"])} data records; '
          f'{len(files)} manifest members; manifest {sha((OUT/"manifest.json").read_bytes())}')


if __name__=='__main__':main()
