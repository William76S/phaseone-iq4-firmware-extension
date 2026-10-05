#!/usr/bin/env python3
"""New finite firmware copy of frozen UI source; never edits those inputs."""
from pathlib import Path
import hashlib,json,difflib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def edit(text,a,b):
 assert a in text,a[:100]
 return text.replace(a,b)
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists()
 for name in ('module.hpp','module.cpp'):
  src=ROOT/'tools/firmware/f1_module_entry_01'/name;t=src.read_text()
  t=t.replace('whole_user','immutable_stock_code_windows').replace('original_pthread','original_pthread')
  t=t.replace('Full User RO verification is required above.','Exact immutable mapped stock-code windows are verified above.')
  t=t.replace('after full User/mapped-code/pthread verification.','after immutable stock-code/mapped-code/pthread verification.')
  t=t.replace("// This revision's executable stage is observation only. It supplies real native\n// ports for the separately reviewed selector/geometry binding, never a fake\n// owner or completion flag. No subscribing, vptr writing or filling occurs.","// Firmware derivation: this Module keeps the bounded metadata cap and real\n// native ports. New runtime separately calls the persistent production\n// Binding; this Module itself never subscribes, writes vptrs or fills pixels.")
  (HERE/name).write_text(t)
 # This firmware uses the new concrete Binding; old Selector/overlay code is
 # neither retained nor linked. All eight exact Inspector methods are copied.
 src=ROOT/'tools/firmware/f1_native_ui_02/ui.cpp';t=src.read_text();t=t[:t.index('Selector::Selector()')]
 t=t.replace('#include "ui.hpp"','#include "../f1_native_ui_02/ui.hpp"')
 a=t.index('constexpr std::array<MaskMode,5>Modes=');z=t.index('\n}\nbool Inspector::read',a)
 t=t[:a]+t[z:];t+='}\n';(HERE/'inspector.cpp').write_text(t)
 for name in ('entry_binding_10.hpp','entry_binding_10.cpp'):
  src=ROOT/'tools/firmware/f1_scaler_hook_install_11'/name;t=src.read_text()
  t=t.replace('../f1_module_entry_01/module.hpp','module.hpp')
  t=t.replace('#include "../f1_display_observe_06/observe.hpp"\n','')
  t=t.replace('#include "../f1_display_observe_06/native_layout.hpp"\n','')
  t=t.replace('native_object_construction_reviewed','immutable_UI_ABI_verified').replace('registry_quiescence_held','actual_registry_mutex_held').replace('RAM_restore_route_held','stock_fallback_retained')
  t=t.replace('Root must hold these actual constructor/restore admission facts. Default is\n// OFF; none comes from a successful compile or display scalar publication.','Computed firmware admission: exact stock windows, actual UI boundary and\n// held original recursive registry mutex. No Root-supplied runtime flags.')
  t=t.replace('Selection={},const display06::Collector* = nullptr,Synchronization={}','Selection={},Synchronization={}')
  t=t.replace('Selection selection,const display06::Collector*display,Synchronization sync','Selection selection,Synchronization sync')
  t=t.replace('display_=display;','').replace('const display06::Collector*display_{};','')
  a=t.find(' if(v==0xb9a9d8)return true;\n')
  if a!=-1:
   z=t.index('\n}\nbool Binding::boundary_matches',a)
   t=t[:a]+' return v==0xb9a9d8;'+t[z:]
  t=t.replace('SelectResult(*apply_on_ui)','bool(*apply_on_ui)')
  if name.endswith('.cpp'):
   t=t.replace('const auto applied=selection_.apply_on_ui?selection_.apply_on_ui(selection_.context,Modes[i],status_.generation):SelectResult::AlreadyOff;','const bool applied=selection_.apply_on_ui&&selection_.apply_on_ui(selection_.context,Modes[i],status_.generation);')
   t=t.replace('if(applied==SelectResult::Rejected)','if(!applied)')
   t=t.replace(' if(applied==SelectResult::AlreadyOff&&i!=0){hold();--callback_depth_;return;}\n','')
   t=t.replace(' status_.stock_paint_restored=applied==SelectResult::AlreadyOff;\n status_.phase=static_cast<unsigned>(applied==SelectResult::AlreadyOff?Phase::Ready:Phase::AwaitingStockPaint);--callback_depth_;',' status_.stock_paint_restored=0; // Firmware UI does not issue pixel receipts.\n status_.mask_state_known=0;status_.mask_enabled=0;\n status_.phase=static_cast<unsigned>(Phase::Ready);--callback_depth_;')
   t=t.replace(' if(!listener_inspector_.configure({memory_.context,memory_.read},listener_native,{false,true,true,true,0}))',' if(!listener_inspector_.configure({memory_.context,memory_.read},listener_native,{false,false,false,true,0}))')
  (HERE/name).write_text(t)
 # Required callbacks remain actual native methods, not an observed-only port.
 binding=(HERE/'entry_binding_10.cpp').read_text();assert 'ports_.text_button_ctor'in binding and 'ports_.notify(events_[5].data())'in binding and 'selection_.apply_on_ui(selection_.context,Modes[i],status_.generation)'in binding
 stock=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes();assert hashlib.sha256(stock).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 # Exactly three offline BL locations; the newly relocated PHDR is appended
 # after this original RX extent, so no broad code exception is granted.
 ranges=[(0,0x270),(0x4eef2c-0x400000,4),(0x51ddcc-0x400000,4),(0x6be8a8-0x400000,4),(0x9da880,4)]
 windows=[];cursor=0
 for off,n in sorted(ranges):
  if off>cursor:windows.append((0x400000+cursor,off-cursor,hashlib.sha256(stock[cursor:off]).hexdigest()))
  cursor=off+n
 windows.append((0x400000+cursor,0xb31752-cursor,hashlib.sha256(stock[cursor:0xb31752]).hexdigest()))
 header='#pragma once\nstruct StockCodeWindow01 {unsigned long long va,bytes;const char*sha;};\ninline constexpr StockCodeWindow01 StockCodeWindows01[]={\n'+''.join(f'{{{a}ULL,{n}ULL,"{s}"}},\n'for a,n,s in windows)+'};\n'
 (HERE/'stock_windows.hpp').write_text(header)
 diff=[]
 for src,name in [(ROOT/'tools/firmware/f1_module_entry_01'/n,n)for n in ('module.hpp','module.cpp')]+[(ROOT/'tools/firmware/f1_scaler_hook_install_11'/n,n)for n in ('entry_binding_10.hpp','entry_binding_10.cpp')]+[(ROOT/'tools/firmware/f1_native_ui_02/ui.cpp','inspector.cpp')]:
  diff.extend(difflib.unified_diff(src.read_text().splitlines(True),(HERE/name).read_text().splitlines(True),fromfile=str(src.relative_to(ROOT)),tofile=str((HERE/name).relative_to(ROOT))))
 (HERE/'SOURCE_DIFF.txt').write_text(''.join(diff))
 print(json.dumps({'new_UI_copies':4,'immutable_stock_windows':len(windows),'default_mode':0,'target_executed':False}))
if __name__=='__main__':main()
