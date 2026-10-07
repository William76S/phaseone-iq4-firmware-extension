#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,subprocess
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
def row(p):
    b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
    stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';b=stock.read_bytes()
    assert row(stock)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    hooks=[];aliases=[]
    for name,va in [('fs',0x493600),('path',0x49360c)]:
        hooks.append(dict(va=va,old_hex=b[va-0x400000:va-0x400000+4].hex(),branch_kind='B',target_symbol='iq4_stock_jpeg_catalog_'+name+'_wrapper_01'))
        aliases.append(dict(symbol='iq4_stock_jpeg_catalog_'+name+'_resume_01',va=va+4,kind='original scanner interior resume',original_first16_LE=b[va-0x400000+4:va-0x400000+20].hex()))
    windows=[]
    for name,lo,hi in [('native_scan_selector',0x493598,0x49365c),('native_scan_loop',0x49365c,0x493994),('native_clear',0x493994,0x493a10),('native_directory_ctor',0x4921fc,0x492394),('Main_directory_binding',0x424990,0x424aec),('native_rescan_dispatch',0x492a38,0x492da8)]:
        raw=b[lo-0x400000:hi-0x400000];windows.append(dict(name=name,va=lo,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest(),hex=raw.hex()))
        d=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d','--start-address='+hex(lo),'--stop-address='+hex(hi),str(stock)],text=True)
        (HERE/(name+'.asm')).write_text(d)
    (HERE/'EXACT.json').write_text(json.dumps(dict(schema='iq4_native_jpeg_catalog_selection_contract_01',stock=row(stock),auxiliary_hooks=hooks,aliases=aliases,original_windows=windows,original_JPEG_scan_callers=[0x492b94,0x492c68,0x492d54],original_JPEG_clear_callers=[0x492ba4,0x492c94,0x492d80],native_scan_args=['catalog','.JPG','minimum bytes1024','file presence flag16'],clear_requires_external_catalog_mutex=True,scan_takes_catalog_mutex_itself=True,Main_SD_path_from_group_VT28=True,Main_XQD_path_from_group_VT28=True,recursive_all_DCIM_proven=False,target_executed=False,camera_accessed=False),indent=2)+'\n')
    print(json.dumps(dict(auxiliary_hooks=hooks,aliases=aliases)))
if __name__=='__main__':main()
