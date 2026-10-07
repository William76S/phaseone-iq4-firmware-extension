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
    retained_wrapper=ROOT/'analysis/firmware/stock_jpeg_half_menu_build_02/wrapper.o'
    removed_menu=ROOT/'analysis/firmware/stock_jpeg_menu_build_02/menu.o'
    retained_size=ROOT/'analysis/firmware/stock_jpeg_half_menu_build_02/menu.o'
    (HERE/'EXACT.json').write_text(json.dumps(dict(schema='iq4_stock_storage_menu_native_contract_55',
        stock=row(stock),original_windows=windows,title=389,original_size_item_VT=0xb8fd40,
        original_size_DTO_VT=0xbbf3f8,existing_hook_va=0x4f0528,existing_hook_original_LE='e4d4ff97',
        replacement_helper='iq4_stock_jpeg_after_menu_append_01',new_UI_hooks=[],
        retained_wrapper=row(retained_wrapper),retained_size_menu=row(retained_size),removed_menu=row(removed_menu),
        display_labels=['JPEG Only','IIQ Only','IIQ+JPEG'],backend_values=[1,0,2],
        original_SD_Storage_changed=False,original_Size_DTO_changed=False,camera_accessed=False),indent=2)+'\n')
    # Exact stock SD composite identity and enum; descriptions are kept out of UI.
    tables=json.loads((ROOT/'analysis/firmware/f3_native_save_settings_static_01/tables.json').read_text())
    sd=next(x for x in tables if x.get('label')=='sd_storage_mode')
    assert sd['va']==0xf528d0 and sd['file_offset']==0xb428d0
    assert sd['hex']==b[sd['file_offset']:sd['file_offset']+144].hex()
    texts={0:'Off',2:'JPEG Only',3:'Mirror Mode',4:'Archive Mode',5:'Primary Storage',1:'Overflow'}
    pairs={49:0xc0e250,775:0xc10ff0,777:0xc11010,778:0xc11020,779:0xc11030,1040:0xc12080,1041:0xc12090}
    resources=[]
    for title,va in pairs.items():
        raw=b[va-0x400000:va-0x400000+16]
        import struct
        got,ptr=struct.unpack('<QQ',raw);assert got==title
        end=b.index(0,ptr-0x400000);label=b[ptr-0x400000:end].decode('utf8')
        resources.append(dict(title_id=title,va=hex(va),hex=raw.hex(),label=label))
    (HERE/'FACTORY_LAYOUT.json').write_text(json.dumps(dict(stock=row(stock),
        root_title=389,root_children=['Storage switch DTO+8','Advanced Setup','SD Storage DTO+408','JPEG Size DTO+608'],
        advanced_children=['Host DTO+308','XQD/CFX DTO+108','SD DTO+208'],
        SD_Storage=dict(append='0x4f04f0',dto_ctor='0x5b7d60',dto_offset='0x408',
            VM_offset='0x1d8',getter='0x495448',setter='0x5b66bc',vtable='0xbbd228',
            getter_slot='0x40',setter_slot='0x48',table=sd,labels_by_enum=texts),
        raw_events=dict(VM_XQD='VM+1c0 -> XQDgroup+8',VM_SD='VM+1c8 -> SDgroup+8',
            native_raw_values={'0':'Off','1':'Optional','2':'Primary'},card_presence='group+468; getter41497c',
            raw_group_status='8dbbac; Primary no-card is status1, eligible card is status2'),
        original_resources=resources,backend_three_format_values_are_independent=True,camera_accessed=False),indent=2)+'\n')
    print('PASS finite native UI windows and original SD composite enum/identity frozen')

if __name__=='__main__': main()
