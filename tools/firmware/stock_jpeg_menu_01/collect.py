#!/usr/bin/env python3
"""Freeze only original native menu ABI windows; no device."""
from pathlib import Path
import hashlib
import json

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent

def row(p):
    b=p.read_bytes()
    return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())

def main():
    stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
    assert row(stock)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    b=stock.read_bytes()
    ranges=[('native_size_argument',0x4f04f4,52),('native_size_return',0x4f052c,20),
        ('submenu_ctor',0x4e5744,32),('eventitem_ctor',0x4e9d30,32),
        ('submenu_append',0x4e58b8,32),('thread_current',0x710b0c,20),
        ('thread_TLS',0x713f60,20),('submenu_vtable',0xb8f9a8,192),
        ('eventitem_vtable',0xb90738,176),('native_size_DTO_vtable',0xbbf3f8,312)]
    lines=['#pragma once','#include <stdint.h>','#include <stddef.h>',
        'struct MenuPin01 { uintptr_t va; size_t bytes; const unsigned char *data; };']
    windows=[]
    for i,(name,va,n) in enumerate(ranges):
        raw=b[va-0x400000:va-0x400000+n]
        assert len(raw)==n
        lines.append('static const unsigned char MenuPinData%d[]={%s};'%
            (i,','.join('0x%02x'%x for x in raw)))
        windows.append(dict(name=name,va=va,bytes=n,sha256=hashlib.sha256(raw).hexdigest(),hex=raw.hex()))
    lines.append('static const struct MenuPin01 MenuPins01[]={'+','.join(
        '{0x%x,%d,MenuPinData%d}'%(va,n,i) for i,(_,va,n) in enumerate(ranges))+'};')
    (HERE/'pins.h').write_text('\n'.join(lines)+'\n')
    hook=dict(va=0x4f0528,old_hex=b[0xf0528:0xf052c].hex(),original_target=0x4e58b8,
        target_symbol='iq4_stock_jpeg_menu_append_01')
    assert hook['old_hex']=='e4d4ff97'
    (HERE/'EXACT.json').write_text(json.dumps(dict(schema='iq4_stock_jpeg_menu_native_contract_01',
        stock=row(stock),BL_hook=hook,original_windows=windows,
        title=389,native_size_item_VT=0xb8fd40,native_size_DTO_VT=0xbbf3f8,
        original_size_child_modified=False,original_append_once_before_own_attachment=True,
        mode_enum=[0,1,2],destination_card_ids=[10,11],
        old_F3_menu_source_dependency=False,target_executed=False,camera_accessed=False),indent=2)+'\n')
    print(json.dumps(hook))

if __name__=='__main__': main()
