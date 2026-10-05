#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_size_menu_02'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 u=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';b=u.read_bytes();assert row(u)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 ranges=[('original_size_argument',0x4f04f4,52),('original_size_return',0x4f052c,20),('submenu_ctor',0x4e5744,32),('eventitem_ctor',0x4e9d30,32),('submenu_append',0x4e58b8,32),('thread_current',0x710b0c,20),('thread_tls',0x713f60,20),('submenu_vtable',0xb8f9a8,192),('event_vtable',0xb90738,176),('size_dto_vtable',0xbbf3f8,312)]
 pins=[];source=['#pragma once','#include <stdint.h>','#include <stddef.h>','struct SizePin01{uintptr_t va;size_t bytes;const unsigned char*data;};']
 for i,(name,va,n) in enumerate(ranges):
  raw=b[va-0x400000:va-0x400000+n];assert len(raw)==n;pins.append(dict(name=name,va=va,bytes=n,sha256=hashlib.sha256(raw).hexdigest(),hex=raw.hex()))
  source.append('static const unsigned char SizePinData%d[]={%s};'%(i,','.join('0x%02x'%v for v in raw)))
 source.append('static const struct SizePin01 SizePins01[]={'+','.join('{0x%x,%d,SizePinData%d}'%(va,n,i)for i,(_,va,n)in enumerate(ranges))+'};')
 (HERE/'pins.h').write_text('\n'.join(source)+'\n')
 hook=dict(va=0x4f0528,old_hex=b[0xf0528:0xf052c].hex(),original_target=0x4e58b8,target_symbol='iq4_f3_storage_size_append_wrapper_01');assert hook['old_hex']=='e4d4ff97'
 (OUT/'EXACT.json').write_text(json.dumps(dict(schema='iq4_native_size_menu_exact_01',original=row(u),BL_hook=hook,pins=pins,DTO_old_values=[0,1],new_policy_scales=[4,5,1,2,3,0],native_DTO_event_modified=False,target_executed=False),indent=2)+'\n')
 print(json.dumps(hook))
if __name__=='__main__':main()
