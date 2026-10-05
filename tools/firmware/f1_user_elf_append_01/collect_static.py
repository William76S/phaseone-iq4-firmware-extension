#!/usr/bin/env python3
"""Read-only exact packaged kernel + User ELF metadata collector."""
from pathlib import Path
import hashlib,json,subprocess,sys
from elf_append import original_contract,sha,need,BASE_SHA,PH_OFF,BASE_VA
ROOT=Path(__file__).resolve().parents[3]
OUT=ROOT/'analysis/firmware/f1_user_elf_append_static_01'
BOOT_SHA='7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e'
KERNEL_BASE=0xffffff8008080000
KERNEL_FILE=0x97400
FUNCTIONS=[('load_elf_binary64',0xffffff8008206060,0xffffff80082072f0),
           ('load_elf_phdrs64',0xffffff8008204b30,0xffffff8008204c20)]
def dump(path,data):path.write_text(json.dumps(data,indent=2,sort_keys=True)+'\n')
def main():
    boot=(ROOT/'analysis/firmware/extracted/Boot_4.00.13.bin').read_bytes();need(sha(boot)==BOOT_SHA,'exact Boot SHA')
    stock=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes();e=original_contract(stock)
    kernel=ROOT/'analysis/firmware/sys_eeprom_range_restore_static/kernel_symbolized.analysis.elf'
    evidence=[]
    OUT.mkdir(parents=True,exist_ok=True)
    for name,start,end in FUNCTIONS:
        command=['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={start}',f'--stop-address={end}',str(kernel)]
        text=subprocess.check_output(command,text=True);normalized='\n'.join(x.rstrip()for x in text.splitlines())+'\n'
        (OUT/(name+'.txt')).write_text(normalized)
        at=KERNEL_FILE+start-KERNEL_BASE;data=boot[at:at+end-start]
        evidence.append({'name':name,'linked_va':start,'end_va':end,'Boot_file_offset':at,'bytes':len(data),'sha256':sha(data),
                        'command':command,'file':name+'.txt'})
    windows=[('machine_AARCH64',0xffffff80082060f4,0xffffff8008206100),
             ('first_LOAD_bias',0xffffff800820653c,0xffffff8008206578),
             ('AT_PHDR',0xffffff8008206b60,0xffffff8008206b9c)]
    for name,start,end in windows:
        off=KERNEL_FILE+start-KERNEL_BASE;data=boot[off:off+end-start]
        evidence.append({'name':name,'linked_va':start,'end_va':end,'Boot_file_offset':off,'bytes':len(data),'hex':data.hex(),'sha256':sha(data)})
    dump(OUT/'KERNEL_PHDR_CONTRACT.json',{'schema':'iq4_f1_packaged_kernel_PHDR_static_01','Boot_SHA256':BOOT_SHA,'User_SHA256':BASE_SHA,
      'kernel_source_URL':'https://raw.githubusercontent.com/torvalds/linux/v4.19/fs/binfmt_elf.c',
      'primary_source_SHA256':sha((OUT/'binfmt_elf_v4.19.c').read_bytes()),'exact_functions_and_windows':evidence,
      'first_LOAD_bias':BASE_VA,'new_e_phoff':PH_OFF,'kernel_AT_PHDR_expected':BASE_VA+PH_OFF,
      'stock_gap_original_zero_bytes':0xb31da0-0xb31752,'PHDR_table_bytes':12*56,
      'kernel_running_identity_proved':False,'ELF_executed':False})
    print(json.dumps({'functions':len(FUNCTIONS),'exact_windows':len(windows),'kernel_executed':False}))
if __name__=='__main__':main()
