#!/usr/bin/env python3
"""Snapshot explicit frozen inputs for the first full native feature link."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 p=p.resolve();assert p.is_relative_to(ROOT);b=p.read_bytes()
 return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def read(rel):return json.loads((ROOT/rel).read_text())
def normal(e):
 p=Path(e.get('path',e.get('label')));p=p if p.is_absolute()else ROOT/p
 a=row(p);assert a['bytes']==e['bytes']and a['sha256']==e['sha256'];return a
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,default=HERE/'INPUTS.json');a=ap.parse_args()
 output=a.output.resolve();assert output.is_relative_to(ROOT)and not output.exists()
 old='analysis/firmware/f1_f4_user_integration_build_02_attempt02/LINK_REPORT.json';f4=read(old)
 objects=[normal(e)for e in f4['objects']];receipts=[old];manifests=['tools/firmware/f1_f4_user_integration_01/SOURCE_SHA256.json']
 def add_build(rel,field='objects',exclude=()):
  j=read(rel);receipts.append(rel)
  for e in j[field]:
   if Path(e['path']).name not in exclude:objects.append(normal(e))
 def add_link(directory):
  link=directory+'/LINK_INPUT.json';j=read(link);receipts.append(link)
  for e in j['objects']:objects.append(normal(e['builds'][0]if 'builds'in e else e))
  source=directory+'/SOURCE_SHA256.json';manifests.append(source);return j
 add_link('tools/firmware/f3_native_render_02')
 source=read('evidence/f3_raw_file_source_01/VALIDATION.json');receipts.append('evidence/f3_raw_file_source_01/VALIDATION.json')
 for e in source['target_objects']:objects.append(normal(e['builds'][0]))
 manifests+=['tools/firmware/f3_raw_file_source_01/SOURCE.json','tools/firmware/f3_file_arena_01/SOURCE_SHA256.json','tools/firmware/f3_core_native_receipt_01/SOURCE_SHA256.json','tools/firmware/f3_stream_export_03/SOURCE_SHA256.json','tools/firmware/f3_stream_export_04/SOURCE_SHA256.json','tools/firmware/native_activity_01/SOURCE_SHA256.json']
 add_build('analysis/firmware/f3_file_arena_build_01/BUILD.json')
 add_build('analysis/firmware/f3_core_native_receipt_build_01_combined_decode/BUILD.json',exclude=('self_read.o',))
 add_build('analysis/firmware/f3_stream_export_build_04_attempt01/BUILD.json')
 add_build('analysis/firmware/native_activity_build_01/BUILD.json')
 add_link('tools/firmware/f3_source_dependencies_02');add_link('tools/firmware/f3_gallery_source_snapshot_01')
 capture=add_link('tools/firmware/f3_saved_raw_capture_01')
 replace=read('tools/firmware/f3_saved_raw_capture_02/LINK_INPUT.json');receipts.append('tools/firmware/f3_saved_raw_capture_02/LINK_INPUT.json');manifests.append('tools/firmware/f3_saved_raw_capture_02/SOURCE_SHA256.json')
 matches=[i for i,e in enumerate(objects)if e['path']=='analysis/firmware/f3_saved_raw_capture_build_01/runtime.o'];assert len(matches)==1;objects[matches[0]]=normal(replace['objects'][0])
 executor=add_link('tools/firmware/f3_native_executor_01');menu=add_link('tools/firmware/f3_capture_menu_04');add_link('tools/firmware/f3_save_coordinator_06')
 add_link('tools/firmware/native_copy_rtti_01')
 # Overlay-only changes preserve the exact API and replace, never duplicate.
 for directory in ['tools/firmware/f4_native_entry_03','tools/firmware/f3_capture_menu_05',
   'tools/firmware/f3_native_fs_unique_06','tools/firmware/f3_file_arena_unique_02',
   'tools/firmware/f3_native_executor_02','tools/firmware/f3_save_coordinator_07']:
  link='analysis/firmware/f3_native_fs_root_overlay_06/LINK_OVERLAY_ROOT_F1_F4.json'if directory=='tools/firmware/f3_native_fs_unique_06'else directory+'/LINK_OVERLAY.json'
  j=read(link);receipts.append(link);manifests.append(directory+'/SOURCE_SHA256.json')
  if directory=='tools/firmware/f3_native_fs_unique_06':manifests.append('analysis/firmware/f3_native_fs_root_overlay_06/SOURCE_SHA256.json')
  old=normal(j['replace_only']);new=normal(j['replacement'])
  # The F1/F4 source reproduction stores byte-identical frozen objects under
  # its own build path. Admit only the unique whole-object identity, never a
  # name-only substitution or an extra duplicate object.
  at=[i for i,e in enumerate(objects)if(e['bytes'],e['sha256'])==(old['bytes'],old['sha256'])];assert len(at)==1;objects[at[0]]=new
 assert len({e['path']for e in objects})==len(objects)
 backend=ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py';sp=importlib.util.spec_from_file_location('spec_original_reader',backend);m=importlib.util.module_from_spec(sp);sys.modules[sp.name]=m;sp.loader.exec_module(m)
 stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';e=m.original_contract(stock.read_bytes())
 aliases={k:(v['va'],v['kind'])for k,v in f4['original_import_bindings'].items()}
 aliases.update({k:(v,'frozen_original_native_render_02')for k,v in read('tools/firmware/f3_native_render_02/LINK_INPUT.json')['original_aliases'].items()})
 aliases.update({k:(int(v,0),'frozen_original_IFM_wait')for k,v in executor['aliases'].items()})
 bindings=read('tools/firmware/f3_saved_raw_capture_01/ORIGINAL_BINDINGS.json');receipts.append('tools/firmware/f3_saved_raw_capture_01/ORIGINAL_BINDINGS.json')
 aliases.update({v['symbol']:(v['va'],'frozen_original_saved_RAW')for v in bindings['bindings']})
 gallery=read('tools/firmware/f3_gallery_source_snapshot_01/ORIGINAL_BINDINGS.json');receipts.append('tools/firmware/f3_gallery_source_snapshot_01/ORIGINAL_BINDINGS.json')
 aliases.update({v['symbol']:(v['va'],'frozen_original_gallery_mutex')for v in gallery['bindings']})
 aliases.update({'iq4_f3_original_core_01':(0x919d58,'original_full_R0_core'),'iq4_f3_original_pool_join_01':(0x716e60,'original_core_join'),'iq4_f3_original_pipeline_clock_01':(0x40a8f0,'original_core_clock'),'bcmp':(0x40b160,'memcmp_equivalent_zero_vs_nonzero_only')})
 alias_rows=[]
 for symbol,(va,kind) in sorted(aliases.items()):
  at=e.va_offset(va,16);alias_rows.append(dict(symbol=symbol,va=va,kind=kind,original_first16_LE=e.data[at:at+16].hex()))
 hooks=[dict(va=h['va'],old_hex=h['old_bytes'],original_target=h['old_target'],target_symbol=h['symbol'])for h in f4['hooks']]
 for h in read('tools/firmware/f3_native_render_02/LINK_INPUT.json')['hook_replacements']:
  at=e.va_offset(h['va'],4);hooks.append(dict(va=h['va'],old_hex=e.data[at:at+4].hex(),original_target=h['original_target'],target_symbol=h['wrapper']))
 for va,target,name in [(0x964860,0x919d58,'iq4_f3_core_native_wrapper_01'),(0x91a78c,0x716e60,'iq4_f3_core_native_join_wrapper_01'),(0x91a964,0x40a8f0,'iq4_f3_core_native_terminal_wrapper_01')]:
  at=e.va_offset(va,4);hooks.append(dict(va=va,old_hex=e.data[at:at+4].hex(),original_target=target,target_symbol=name))
 for j in [executor,menu]:
  h=j['hook'];hooks.append(dict(va=int(h['va'],0),old_hex=h['old_LE'],original_target=int(h['original_target'],0),target_symbol=h['entry']))
 aux=[]
 for h in bindings['hooks']:
  if h['va']==0x8dd440:
   hooks.append(dict(va=h['va'],old_hex=h['old_hex'],original_target=0x7d8a38,target_symbol=h['target_symbol']))
  else:aux.append(h)
 flags=['-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-DIQ4_JPEG_API_VERSION=82','-ffp-contract=off','-fno-strict-aliasing','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-ffunction-sections','-fdata-sections','-fPIC','-Wall','-Wextra','-Werror']
 source=[('tools/firmware/f1_f3_f4_user_integration_01/initialize.c','initialize.o'),('tools/firmware/native_linked_contract_01/contract.c','contract.o')]
 result=dict(schema='iq4_F1_F3_F4_exact_native_inputs_01',stock=row(stock),compiler=row(ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'),source_manifests=[row(ROOT/p)for p in sorted(set(manifests))],receipts=[row(ROOT/p)for p in sorted(set(receipts))],objects=objects,aliases=alias_rows,BL_hooks=hooks,auxiliary_hooks=aux,C_flags=flags,compile=[dict(source=row(ROOT/p),object_name=n)for p,n in source],required_functions=['iq4_linked_contract_current_01','iq4_extensions_contract_current_01','iq4_native_copy_rtti_current_01','f3_coordinator_install_native_06','f3_coordinator_worker_run_06','f3_coordinator_saved_callback_06','iq4_f4_native_menu_entry_02'],SD_automatic_only=True,target_executed=False)
 output.write_text(json.dumps(result,indent=2)+'\n');print(len(objects)+len(source),'actual objects;',len(hooks),'BL +',len(aux),'exact non-BL sites; spec',row(output)['sha256'])
if __name__=='__main__':main()
