#!/usr/bin/env python3
"""Finite exact original Access ABI supplements; no firmware or SDK execution."""
import argparse,bisect,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3]
def sha(b):return hashlib.sha256(b).hexdigest()
def main():
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--output',required=True,type=Path);a=p.parse_args()
    elf=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';raw=elf.read_bytes();assert len(raw)==11874544 and sha(raw)=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    unwind=ROOT/'analysis/firmware/unwind_functions.json';starts=json.loads(unwind.read_text())['functions'];records=[];a.output.mkdir(parents=True,exist_ok=False)
    for name,start in [('access_lock',0x6b618c),('access_unlock',0x6b6250),('access_size',0x6b61fc),('access_id',0x6b62c0),
                       ('engine_lock_cpu',0x6b6d1c),('engine_size',0x6b6d44),('engine_unlock',0x6b6da0),('engine_id',0x6b6dc8),
                       ('video_lock',0x6b6a3c),('video_unlock',0x6b6b30),('video_size',0x6b6b70),('video_id',0x6b6c80),('current_original_thread',0x710b0c),('engine_video_storage_initialization',0x793540)]:
        i=bisect.bisect_left(starts,start);assert starts[i]==start;end=starts[i+1];code=raw[start-0x400000:end-0x400000]
        dis=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={start:#x}',f'--stop-address={end:#x}',elf],text=True)
        f=a.output/(name+'.txt');f.write_text('STATIC ONLY; complete .eh_frame start-to-next-start interval; nearest labels are not private symbols\n'+dis)
        records.append({'name':name,'start_va':hex(start),'end_va_exclusive':hex(end),'length':len(code),'sha256':sha(code),'hex':code.hex(),'disassembly_sha256':sha(f.read_bytes())})
    tables=[]
    for name,va,n in [('ui_queue_vt',0xb91f48,32),('manager_vt',0xb8f358,32),('lv_vt',0xb9a9d8,32),('access_vt',0xc07da8,32),('event_vt',0xc237a0,32),('ui_client_name',0xb9a4e0,32)]:
        b=raw[va-0x400000:va-0x400000+n];tables.append({'name':name,'va':hex(va),'length':n,'sha256':sha(b),'hex':b.hex()})
    report={'action':'finite_native_metadata_access_abi_static_supplement','input_sha256':sha(raw),'unwind_sha256':sha(unwind.read_bytes()),'complete_functions':records,'vt_and_name_windows':tables,
            'sdk_loaded':False,'camera_access':False,'target_executed':False,'mode_field_bound':False,'source_allocation_capacity_bound':False,'pixel_copy_enabled':False}
    (a.output/'exact_static.json').write_text(json.dumps(report,indent=2)+'\n');print('14 complete original windows and 6 VT/name windows; static only')
if __name__=='__main__':main()
