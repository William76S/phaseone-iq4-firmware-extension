#!/usr/bin/env python3
"""Check exact58 object delta, removal and all runtime-consumed pin tables."""
import argparse,importlib.util,json,sys,subprocess
from pathlib import Path
from build_components import ROOT,HERE,BASE,BASE_SHA,row
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);a=ap.parse_args();out=a.build.resolve();j=json.loads((out/'BUILD.json').read_text());s=json.loads((ROOT/j['spec']['path']).read_text());base=json.loads((ROOT/BASE).read_text());assert row(BASE)['sha256']==BASE_SHA
 changes=[dict(before=x,after=y) for x,y in zip(base['objects'],s['objects']) if x!=y];assert len(changes)==2 and j['object_count']==44
 assert {v['before']['path'] for v in changes}=={'analysis/firmware/half_entry_trace_58_components_final/runtime.o','analysis/firmware/half_entry_trace_58_components_final/bridge.o'}
 assert base['BL_hooks']==s['BL_hooks'] and base['auxiliary_hooks']==s['auxiliary_hooks'] and base['compile']==s['compile'] and base['aliases']==s['aliases']
 for o in s['objects']:assert row(o['path'])==o
 before_build=json.loads((ROOT/'analysis/firmware/half_entry_trace_58_build_final/BUILD.json').read_text())
 assert [(v['source'],v['object']['sha256'],v['object']['bytes']) for v in j['compiled']]==[(v['source'],v['object']['sha256'],v['object']['bytes']) for v in before_build['compiled']]
 rep=json.loads((ROOT/j['link_report']['path']).read_text());own=set(rep['own_symbols']);assert {n for n in own if n.startswith(('iq4_f4_','f4_movie_','iq4_mkv_'))}=={'iq4_f4_menu_new_03','iq4_f4_menu_ctor_03','iq4_f4_menu_append_03','iq4_f4_native_current_02'}
 assert 'iq4_stock_half_request_owner_59' in own
 sp=importlib.util.spec_from_file_location('delta57_elf',ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py');m=importlib.util.module_from_spec(sp);sys.modules[sp.name]=m;sp.loader.exec_module(m);e=m.Elf((ROOT/j['User']['path']).read_bytes(),2)
 assert e.data[e.va_offset(0x4fb454,4):e.va_offset(0x4fb454,4)+4]==bytes.fromhex('14b2ff97')
 assert not any(b'LV Recording' in e.section_bytes(i) for i,n in enumerate(e.names) if n.startswith('.f1.'))
 # This new table is genuinely compiled into the replacement runtime, and must
 # appear in the release verifier; neither a unused substitute nor an old table.
 manifest=json.loads((ROOT/s['source_manifests'][-1]['path']).read_text());headers={r['path'] for r in manifest['target_header_closure']}
 required={'tools/firmware/jpeg_binding_fix_57/stock_pins_57.h','tools/firmware/stock_storage_router_55/router_pins_55.h','tools/firmware/f3_stock_half_export_01/half_pins.h','tools/firmware/half_request_owner_59/request_pins.h'};assert required<=headers
 assert 'tools/firmware/f3_stock_half_export_01/stock_pins_54.h' not in headers
 pins=json.loads((out/'ORIGINAL_PIN_CHECK.json').read_text());checked={g['header']['path'] for g in pins['groups']};assert required<=checked and pins['all_match']
 # The native producer consumes sizeof-name tables which the generic parser
 # does not accept. Verify its exact original table, under the production
 # five-site exclusions, rather than assuming a similarly named release copy.
 original_producer_pins=ROOT/'tools/firmware/f3_native_half_01/PINS.json'
 producer=json.loads(original_producer_pins.read_text());producer_checks=[]
 assert 'tools/firmware/f3_native_half_01/pins.h' in headers
 excluded={0x7b7ed0,0x91a78c,0x91a964,0x963d28,0x964860}
 for r in producer['windows']:
  va=int(r['va'],0);expected=bytes.fromhex(r['hex']);actual=e.data[e.va_offset(va,len(expected)):e.va_offset(va,len(expected))+len(expected)]
  checked=[i for i in range(0,len(expected),4) if va+i not in excluded]
  assert all(expected[i:i+4]==actual[i:i+4] for i in checked),r['name']
  producer_checks.append(dict(name=r['name'],va=va,compared_bytes=4*len(checked),matches=True))
 assert len(producer_checks)==22
 result=dict(schema='iq4_Half_request_owner_actual_User_59',User=j['User'],exact_object_changes=changes,unchanged_precompiled_objects=40,original_initializers_unchanged=True,hook_sites_and_targets_unchanged=True,recording_symbols_text_absent=True,original_pop_restored=True,actually_compiled_runtime_pin_tables_verified=sorted(required),actual_native_producer_table=row(original_producer_pins),native_producer_checks=producer_checks,camera_accessed=False,hardware_acceptance=False)
 (out/'DELTA_CHECK.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS exactly two Half request ownership objects changed; Ratio/Dual/removal retained; actual consumed pin tables checked')
if __name__=='__main__':main()
