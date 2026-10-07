#!/usr/bin/env python3
"""Freeze the LV shortcut change over exact 6.03.45 inputs; no device access."""
from pathlib import Path
import hashlib, json, importlib.util
ROOT=Path(__file__).resolve().parents[3]
def row(p):
 p=ROOT/p; b=p.read_bytes(); return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 old=ROOT/'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_16.json'
 assert hashlib.sha256(old.read_bytes()).hexdigest()=='d7a137af82be4f93bc4b5dfd00f1c9d02f10b98561cee71dc102763e0ed5a287'
 j=json.loads(old.read_text())
 j['source_manifests']=[x for x in j['source_manifests'] if x['path']!='tools/firmware/ratio_dual_repair_01/RATIO_SETTINGS_SOURCE.json']
 for f in ('analysis/firmware/ratio_mask_settings_repair_02/SOURCE_SHA256.json',
           'analysis/firmware/ratio_quick_menu_build_01/SOURCE_SHA256.json',
           'analysis/firmware/ratio_quick_button_native_01/build/BUILD.json'):
  j['source_manifests'].append(row(f))
 replacements={
  'analysis/firmware/ratio_mask_settings_repair/settings.o':'analysis/firmware/ratio_mask_settings_repair_02/settings.o',
  'analysis/firmware/ratio_mask_menu_persistence_repair/f1_menu.o':'analysis/firmware/ratio_quick_menu_build_01/f1_menu.o'}
 j['objects']=[row(replacements.get(x['path'],x['path'])) for x in j['objects']]
 for f in ('analysis/firmware/ratio_quick_button_native_01/build/quick_button.o',
           'analysis/firmware/ratio_quick_button_native_01/build/quick_wrapper.o'):
  j['objects'].append(row(f))
 source=ROOT/j['stock']['path']
 loader=importlib.util.spec_from_file_location('append_backend',ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py')
 m=importlib.util.module_from_spec(loader)
 import sys
 sys.modules[loader.name]=m;loader.loader.exec_module(m)
 elf=m.original_contract(source.read_bytes())
 at=elf.va_offset(0x519204,4)
 assert elf.data[at:at+4].hex()=='21dcfe97'
 before=elf.data[elf.va_offset(0x4d0288,16):elf.va_offset(0x4d0288,16)+16]
 j['aliases'].append(dict(symbol='iq4_stock_quick_append_01',va=0x4d0288,kind='FUNC',original_first16_LE=before.hex()))
 j['BL_hooks'].append(dict(va=0x519204,old_hex='21dcfe97',original_target=0x4d0288,target_symbol='iq4_ratio_quick_append_wrapper_01'))
 cleanup_before=elf.data[elf.va_offset(0x52122c,4):elf.va_offset(0x52122c,4)+4]
 assert cleanup_before.hex()=='e5fffe97'
 dtor_before=elf.data[elf.va_offset(0x4e11c0,16):elf.va_offset(0x4e11c0,16)+16]
 j['aliases'].append(dict(symbol='iq4_stock_quick_dialog_dtor_01',va=0x4e11c0,kind='native_lv_dialog_base_destructor',original_first16_LE=dtor_before.hex()))
 j['BL_hooks'].append(dict(va=0x52122c,old_hex='e5fffe97',original_target=0x4e11c0,target_symbol='iq4_ratio_quick_cleanup_wrapper_01'))
 for name in ('iq4_f1_toggle_on_ui_01','iq4_f1_quick_menu_root_on_ui_01'):
  j['required_functions'].append(name)
 j['expected_hook_count']+=2
 j['integration_revision']='17_ratio_quick_native_button'
 j['scope']='Ratio Mask LV right tools second row right column: tap toggle, long press own ratio/opacity menu, original blue on dot and submenu corner; remember ratio while off'
 j['release_date']='2026-10-07'
 j['ratio_mask_settings_schema']=2
 j['ratio_mask_quick_UI_hardware_accepted']=False
 dest=ROOT/'tools/firmware/f1_f3_f4_user_integration_05/INPUTS_REPAIR_17.json'
 dest.write_text(json.dumps(j,ensure_ascii=False,indent=2)+'\n')
 print(json.dumps(row(dest),ensure_ascii=False))
if __name__=='__main__': main()
