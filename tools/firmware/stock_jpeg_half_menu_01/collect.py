#!/usr/bin/env python3
from pathlib import Path
import hashlib,json
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
def row(p):
    b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
    stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';b=stock.read_bytes()
    assert row(stock)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    prior=ROOT/'tools/firmware/stock_jpeg_menu_01/EXACT.json'
    j=json.loads(prior.read_text())
    assert row(prior)['sha256']=='8c5ddb6e3eb3f0851cd3bad97fb9be509c181cdf7ddb1bcae0f5054dccf80843'
    lines=['#pragma once','#include <stdint.h>','#include <stddef.h>',
        'struct MenuPin01 { uintptr_t va; size_t bytes; const unsigned char *data; };']
    for i,w in enumerate(j['original_windows']):
        raw=b[w['va']-0x400000:w['va']-0x400000+w['bytes']]
        assert raw.hex()==w['hex'] and hashlib.sha256(raw).hexdigest()==w['sha256']
        lines.append('static const unsigned char MenuPinData%d[]={%s};'%
            (i,','.join('0x%02x'%v for v in raw)))
    lines.append('static const struct MenuPin01 MenuPins01[]={'+','.join(
        '{0x%x,%d,MenuPinData%d}'%(w['va'],w['bytes'],i)
        for i,w in enumerate(j['original_windows']))+'};')
    (HERE/'pins.h').write_text('\n'.join(lines)+'\n')
    hook=dict(va=0x4f0528,old_hex='e4d4ff97',original_target=0x4e58b8,
        target_symbol='iq4_stock_jpeg_size_append_wrapper_02')
    alias=dict(symbol='iq4_stock_jpeg_original_append_02',va=0x4e58b8,
        kind='original native SubMenu append',original_first16_LE=b[0xe58b8:0xe58c8].hex())
    (HERE/'EXACT.json').write_text(json.dumps(dict(schema='iq4_stock_half_menu_native_contract_02',
        stock=row(stock),prior_native_contract=row(prior),original_windows=j['original_windows'],
        BL_hook=hook,aliases=[alias],extended_choice_enum=[0,1],native_JPEG_size_value=1,
        native_enum2_used=False,original_size_DTO_modified=False,
        replacement_at_original_position=True,visible_labels=['4K','50%'],
        reuses_52_export_menu_object=row(ROOT/'analysis/firmware/stock_jpeg_menu_build_02/menu.o'),
        excludes_52_wrapper_object=row(ROOT/'analysis/firmware/stock_jpeg_menu_build_02/wrapper.o'),
        core_extended_choice_API_required=True,target_executed=False,camera_accessed=False),indent=2)+'\n')
    print(json.dumps(hook))
if __name__=='__main__':main()
