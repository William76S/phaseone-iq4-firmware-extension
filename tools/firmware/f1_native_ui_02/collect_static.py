#!/usr/bin/env python3
"""Exact User-only finite F1 UI02 evidence; no target execution."""
from pathlib import Path
import hashlib,json,re,struct,subprocess
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
OUT=ROOT/'analysis/firmware/f1_native_ui_02/static';ELF=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJDUMP='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
RANGES=[
 ('original_LV_selector_construct',0x517958,0x517974),('LV_original_control_callback_complete',0x51f9fc,0x520298),
 ('Selector_ctor_complete',0x4fad38,0x4fb1cc),('Selector_dtor_complete',0x4fb1cc,0x4fb2c8),
 ('Selector_observer',0x4fb2c8,0x4fb364),('Selector_setmenu_and_update',0x4fb364,0x4fb3f0),
 ('Selector_header_title_forward',0x4fa688,0x4fa6b4),('Selector_header_title_field',0x4faa5c,0x4faaa4),
 ('Navigator_ctor',0x4e7164,0x4e72c8),('Navigator_setmenu',0x4e7350,0x4e7380),
 ('Navigator_reset',0x4e756c,0x4e7628),('Navigator_transition',0x4e8010,0x4e80d8),
 ('Navigator_activate',0x4e7ce4,0x4e7e68),('SubMenu_ctor_dtor_size',0x4e5744,0x4e58a4),
 ('SubMenu_append',0x4e58b8,0x4e5990),('SubMenu_list_node_contract',0x4e621c,0x4e6318),
 ('EventItem_ctor_size',0x4e9d30,0x4e9e10),('EventItem_text_and_activate',0x4ea188,0x4ea324),
 ('MenuControl_text_fallback',0x4c0504,0x4c0594),('Control_invalidate',0x4ac06c,0x4ac0f4),
 ('Dialog_invalidate_and_show_close',0x4e1270,0x4e1360),('Dialog_redraw_request_and_current',0x4e14bc,0x4e15e8),
 ('Manager_redraw_request',0x4e4820,0x4e4898),('Manager_event_dispatch_complete',0x4e2f18,0x4e32d4),
 ('Manager_force_draw_complete',0x4e32d4,0x4e36b8),('Control_dirty_or_force_paint',0x4abd24,0x4ac06c),
 ('Configurator_redraw_event_ctor',0x4ed6a0,0x4ed6b8),('Configurator_manager_args',0x4edbf8,0x4edc48),
 ('Manager_current_complete',0x4e29b0,0x4e2bdc),('Manager_push_complete',0x4e27bc,0x4e28f8),
 ('Dialog_stack_tail_accessor',0x4e4de8,0x4e4e6c),('Native_list_append',0x70bb78,0x70bc44),
 ('Native_list_tail_getter',0x70bcc0,0x70bd10),('Node_next_previous',0x46037c,0x4603ac),
 ('Local_control_bounds_not_display',0x4ab9d8,0x4abac8),('LV_display_point_geometry',0x51f50c,0x51f690),
 ('Complete_LV_paint_no_fresh_receipt',0x51da0c,0x51df64),
 ('Original_UI_queue_loop',0x4ef960,0x4ef9a0),('Original_thread_TLS_getter',0x710b0c,0x710b3c),
 ('PLT_strncpy',0x40a9c0,0x40a9d0)]
ENTRIES=[('event_ctor',0x70f12c),('observer_ctor',0x70fe3c),('subscribe',0x70fed8),('unsubscribe',0x70ff08),('submenu_ctor',0x4e5744),('item_ctor',0x4e9d30),('append',0x4e58b8),('set_menu',0x4fb364),('show',0x4e12c8),('close',0x4e1320),('invalidate',0x4ac06c),('original_current',0x710b0c)]
TABLES=[('LV_primary_and_popup_locator',0xb9a9d8,0x1d8),('Selector_primary',0xb931b0,0x1f8),('Selector_node_and_other_interfaces',0xb933a8,0xe8),('Navigator_primary',0xb90020,0x20),('SubMenu_primary',0xb8f9b8,0xb0),('EventItem_primary',0xb90748,0xa0),('Manager_primary',0xb8f358,0xb8),('Dialog_stack_wrapper',0xb8f4e8,0x40),('SubMenu_list_node',0xb8f958,0x50),('List_vtable',0xc22908,0x40),('Node_vtable',0xc22960,0x30)]
STRINGS=[('UiIQ4Redraw',0xb91798,12),('Menu_dialog_name',0xb93190,16)]
def sha(d):return hashlib.sha256(d).hexdigest()
def main():
 raw=ELF.read_bytes()
 if sha(raw)!=SHA:raise SystemExit('Exact User mismatch')
 OUT.mkdir(parents=True,exist_ok=True);rows=[]
 for name,start,end in RANGES:
  data=raw[start-0x400000:end-0x400000]
  s=subprocess.check_output([OBJDUMP,'-d',f'--start-address={start:#x}',f'--stop-address={end:#x}',str(ELF.relative_to(ROOT))],cwd=ROOT,text=True)
  lines=[x.split(' <')[0].split(' //')[0].rstrip() for x in s.splitlines() if re.match(r'  [0-9a-f]+:',x)]
  p=OUT/(name+'.txt');p.write_text('EXACT USER SHA256 '+SHA+'\nSTATIC ONLY; no actual callable binding.\n'+'\n'.join(lines)+'\n')
  rows.append(dict(name=name,start_va=hex(start),end_va_exclusive=hex(end),file_offset=hex(start-0x400000),bytes_hex=data.hex(),bytes_sha256=sha(data),disassembly=str(p.relative_to(ROOT)),disassembly_sha256=sha(p.read_bytes())))
 tables=[]
 for name,va,n in TABLES+STRINGS:
  data=raw[va-0x400000:va-0x400000+n];row=dict(name=name,va=hex(va),file_offset=hex(va-0x400000),size=n,bytes_hex=data.hex(),sha256=sha(data))
  if (name,va,n)in TABLES:row['qwords']=[hex(struct.unpack_from('<Q',data,i)[0])for i in range(0,n//8*8,8)]
  tables.append(row)
 entries=[dict(name=name,va=hex(va),bytes_hex=raw[va-0x400000:va-0x400000+16].hex())for name,va in ENTRIES]
 reloc=subprocess.check_output([OBJDUMP,'-R',str(ELF.relative_to(ROOT))],cwd=ROOT,text=True)
 relocation=[line.rstrip()for line in reloc.splitlines()if re.match(r'^0000000000f436f8\s+R_AARCH64_JUMP_SLOT\s+strncpy$',line)]
 if len(relocation)!=1:raise SystemExit('Expected strncpy relocation changed')
 (OUT/'exact_bytes.json').write_text(json.dumps(dict(schema='iq4_f1_native_ui02_exact_v1',input_sha256=SHA,address_model='AArch64 ET_EXEC captured VA-0x400000 mapping',evidence_level='static_exact_bytes_and_instructions',device_accessed=False,target_executed=False,ranges=rows,tables=tables,entries=entries,dynamic_relocation_evidence=relocation),indent=2)+'\n')
 header='#pragma once\n#include <array>\n#include <cstdint>\nnamespace iq4::f1::native_ui02 {\nstruct EntryBytes {std::uintptr_t va;std::array<unsigned char,16> bytes;};\ninline constexpr std::array<EntryBytes,12> EntryChecks={{\n'
 for e in entries:header+='    {'+e['va']+', {'+','.join('0x'+e['bytes_hex'][i:i+2]for i in range(0,32,2))+'}}, // '+e['name']+'\n'
 header+='}};\n}\n';(HERE/'entry_bytes.hpp').write_text(header)
 print(f'{len(rows)} exact windows; {len(tables)} tables/strings; {len(entries)} candidate entry checks')
if __name__=='__main__':main()
