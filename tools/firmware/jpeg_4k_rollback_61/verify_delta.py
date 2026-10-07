#!/usr/bin/env python3
"""Verify actual61 removal and all retained original JPEG/storage guards."""
import argparse,importlib.util,json,sys
from pathlib import Path
from build_components import ROOT,HERE,BASE,BASE_SHA,row
from prepare import REPLACEMENTS,REMOVED_OBJECTS,REMOVED_SITES,REMOVED_ALIASES,FORBIDDEN_PREFIXES,GALLERY_FUNCTIONS,delete_module
from assemble import HEADERS
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);a=ap.parse_args();out=a.build.resolve();j=json.loads((out/'BUILD.json').read_text());s=json.loads((ROOT/j['spec']['path']).read_text());base=json.loads((ROOT/BASE).read_text());assert row(BASE)['sha256']==BASE_SHA
 kept=[x for x in base['objects']if x['path']not in REMOVED_OBJECTS]
 added=dict(objects=[],BL_hooks=[],aliases=[],required_functions=[],source_manifests=[],pin_headers=[])
 if 'paired_delete_module'in s:
  added,receipt=delete_module(ROOT/s['paired_delete_module']['path']);assert receipt==s['paired_delete_module']
 n=len(added['objects']);assert n in (0,2)
 changes=[dict(before=x,after=y)for x,y in zip(kept,s['objects'][:36])if x!=y]
 assert len(base['objects'])==43 and len(s['objects'])==36+n and len(changes)==3 and j['object_count']==38+n
 assert s['objects'][36:]==added['objects']
 assert {v['before']['path']for v in changes}==set(REPLACEMENTS.values())
 for v in changes:assert Path(v['after']['path']).name==next(name for name,old in REPLACEMENTS.items()if old==v['before']['path'])
 assert s['BL_hooks']==[h for h in base['BL_hooks']if h['va']not in REMOVED_SITES]+added['BL_hooks']
 assert base['auxiliary_hooks']==s['auxiliary_hooks'] and base['compile']==s['compile']
 assert s['aliases']==[v for v in base['aliases']if v['symbol']not in REMOVED_ALIASES]+added.get('aliases',[])
 assert s['required_functions']==[v for v in base['required_functions']if not v.startswith(FORBIDDEN_PREFIXES)]+GALLERY_FUNCTIONS+added.get('required_functions',[])
 assert s['expected_hook_count']==49+len(added['BL_hooks']) and s['JPEG_size_choices']==['4K']
 for o in s['objects']:assert row(o['path'])==o
 before_build=json.loads((ROOT/'analysis/firmware/half_render_contract_60_build_final/BUILD.json').read_text())
 assert [(v['source'],v['object']['sha256'],v['object']['bytes'])for v in j['compiled']]==[(v['source'],v['object']['sha256'],v['object']['bytes'])for v in before_build['compiled']]
 rep=json.loads((ROOT/j['link_report']['path']).read_text());own=set(rep['own_symbols'])
 assert not {n for n in own if n.startswith(FORBIDDEN_PREFIXES)}
 assert {n for n in own if n.startswith(('iq4_f4_','f4_movie_','iq4_mkv_'))}=={'iq4_f4_menu_new_03','iq4_f4_menu_ctor_03','iq4_f4_menu_append_03','iq4_f4_native_current_02'}
 required_symbols={'iq4_stock_xqd_format_get_55','iq4_stock_xqd_format_set_55','iq4_stock_storage_after_policy_55','iq4_stock_jpeg_encode_write_01','iq4_new_raw_bind_55','iq4_new_raw_end_55','iq4_stock_jpeg_gallery_bind_55'}
 required_symbols.update(GALLERY_FUNCTIONS)
 required_symbols.update(added.get('required_functions',[]))
 assert required_symbols<=own,sorted(required_symbols-own)
 sp=importlib.util.spec_from_file_location('delta61_elf',ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py');m=importlib.util.module_from_spec(sp);sys.modules[sp.name]=m;sp.loader.exec_module(m);e=m.Elf((ROOT/j['User']['path']).read_bytes(),2);stock=m.Elf((ROOT/base['stock']['path']).read_bytes(),2)
 restored=[]
 for h in base['BL_hooks']:
  if h['va']not in REMOVED_SITES:continue
  off=e.va_offset(h['va'],4);assert e.data[off:off+4]==bytes.fromhex(h['old_hex'])
  restored.append(dict(va=hex(h['va']),stock_hex=h['old_hex'],removed=h['target_symbol']))
 assert len(restored)==6
 untouched=[]
 for lo,hi,name in [(0x963d28,0x963d2c,'original_RAW_reader'),(0x964860,0x964864,'original_core_call'),(0x4959ec,0x495ce0,'original_IFM_buffers')]:
  n=hi-lo;want=stock.data[stock.va_offset(lo,n):stock.va_offset(lo,n)+n];have=e.data[e.va_offset(lo,n):e.va_offset(lo,n)+n];assert have==want;untouched.append(dict(va=hex(lo),bytes=n,name=name))
 assert e.data[e.va_offset(0x4fb454,4):e.va_offset(0x4fb454,4)+4]==bytes.fromhex('14b2ff97')
 own_bytes=b''.join(e.section_bytes(i)for i,n in enumerate(e.names)if n.startswith('.f1.'))
 for text in [b'LV Recording',b'50% source mismatch',b'50% render failed',b'iq4-half-jpeg.cfg']:assert text not in own_bytes,text
 manifests=[json.loads((ROOT/r['path']).read_text())for r in s['source_manifests']]
 selected=[m for m in manifests if m.get('schema')=='iq4_JPEG_4K_rollback_source_61'];assert len(selected)==1
 manifest=selected[0];headers={r['path']for r in manifest['target_header_closure']}
 original_gallery=row('tools/firmware/stock_jpeg_gallery_55/gallery.cpp')
 assert original_gallery['sha256']=='8cdbc44952e1a316a265bd6470e65c6bb5bca4e16d5ccabf47242badb2af8fad'
 assert original_gallery in manifest['target_header_closure']
 assert '#include "../stock_jpeg_gallery_55/gallery.cpp"'in(HERE/'gallery.cpp').read_text()
 required={'tools/firmware/jpeg_binding_fix_57/stock_pins_57.h','tools/firmware/stock_storage_router_55/router_pins_55.h','tools/firmware/stock_jpeg_half_status_menu_55/pins.h'};assert required<=headers
 banned={'tools/firmware/f3_stock_half_export_01/half_pins.h','tools/firmware/half_request_owner_59/request_pins.h','tools/firmware/f3_native_half_01/pins.h','tools/firmware/half_render_contract_60/rgb24_terminal.h','tools/firmware/f3_native_jpeg8_binding_01/native_jpeg82.h'};assert not(headers&banned)
 pins=json.loads((out/'ORIGINAL_PIN_CHECK.json').read_text());checked={g['header']['path']for g in pins['groups']};assert checked==set(HEADERS+added.get('pin_headers',[])) and required<=checked and pins['all_match']
 result=dict(schema='iq4_JPEG_4K_only_actual_User_61',User=j['User'],exact_object_changes=changes,removed_objects=[v for v in base['objects']if v['path']in REMOVED_OBJECTS],restored_original_instructions=restored,removed_aliases=sorted(REMOVED_ALIASES),added_objects=added['objects'],added_hooks=added['BL_hooks'],unchanged_precompiled_objects=33,original_initializers_unchanged=True,retained_hooks_unchanged=True,all_Half_symbols_absent=True,original_auxiliary_buffers=untouched,recording_symbols_text_absent=True,original_gallery_source_included_unchanged=original_gallery,gallery_identity_API_added=GALLERY_FUNCTIONS,JPEG_only_receipt_gallery_storage_symbols_retained=sorted(required_symbols),actually_compiled_runtime_pin_tables_verified=sorted(required),camera_accessed=False,hardware_acceptance=False)
 (out/'DELTA_CHECK.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS 4K-only: seven Half objects/six hooks removed; three objects replaced; XQD/SD/JPEG-only/Ratio/Dual retained; actual pins verified')
if __name__=='__main__':main()
