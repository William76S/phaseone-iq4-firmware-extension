#!/usr/bin/env python3
"""Actual F1+F4 User link. Frozen exact inputs, no target run or installer claim."""
from pathlib import Path
import argparse,hashlib,importlib.util,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
BACKEND=ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py'
ARTIFACT_MAP={}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=sha(p))
def verify(e):
 p=ROOT/ARTIFACT_MAP.get(e['path'],e['path']);assert p.resolve().is_relative_to(ROOT) and p.stat().st_size==e['bytes'] and sha(p)==e['sha256'],e['path'];return p
def lock(p):
 x=json.loads(p.read_text());a=x.get('members',x.get('files'));a=[dict(path=k,**v)for k,v in a.items()]if isinstance(a,dict)else a
 assert a;result=[verify(e)for e in a]
 for key in ['dependencies','target_header_closure']:
  if key in x:result.extend(verify(e)for e in x[key])
 for key in ['build','commands','movie_scanner_consumer_inspected']:
  if key in x and isinstance(x[key],dict)and {'path','bytes','sha256'}<=set(x[key]):result.append(verify(x[key]))
 return result
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--output',type=Path,required=True);ap.add_argument('--f4-build',type=Path,required=True);ap.add_argument('--f4-source-overlay',type=Path,required=True);ap.add_argument('--cleanup-overlay',type=Path,required=True);ap.add_argument('--mkv-overlay',type=Path,required=True);ap.add_argument('--app-version',default='6.03.29');ap.add_argument('--artifact-map',type=Path);a=ap.parse_args();out=a.output.resolve()
 if a.artifact_map:
  remap=json.loads(a.artifact_map.read_text());assert remap['schema']=='iq4_frozen_target_objects_fresh_recompile_01';ARTIFACT_MAP.update(remap['remap'])
  assert ARTIFACT_MAP and all(Path(k).suffix=='.o' and Path(v).suffix=='.o' and not Path(k).is_absolute() and not Path(v).is_absolute()for k,v in ARTIFACT_MAP.items())
 assert not out.exists() and out.is_relative_to(ROOT)
 assert sha(BACKEND)=='3c6b4ccaafa1a524f39bac98f91058791526cef0289dd33b89967dd3f50d3fd9'
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)=='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
 f4=ROOT/'tools/firmware/f4_native_source_02';lock(f4/'SOURCE_SHA256.json')
 for rel in ['tools/firmware/f1_stock_menu_04/SOURCE_SHA256.json','tools/firmware/f3_native_card_bridge_06/SOURCE_SHA256.json','tools/firmware/movie_card_01/SOURCE_SHA256.json','tools/firmware/f3_native_jpeg8_binding_01/SOURCE_SHA256.json','analysis/firmware/native_mkv_build_01/SOURCE_SHA256.json','tools/firmware/f3_core_native_receipt_01/SOURCE_SHA256.json']:
  lock(ROOT/rel)
 build=json.loads(a.f4_build.read_text());assert not build['target_executed'] and not build['camera_access']
 for e in build['source_inputs']+build['dependencies']:verify(e)
 objects=[]
 for e in build['objects']:
  p=verify(e);objects.append((e['path'],p.read_bytes()))
 assert len(objects)==9
 overlay_path=a.f4_source_overlay.resolve();assert sha(overlay_path)=='8847e0e28ae0c5b3d77eefb2249f57aa0e7af706c696cf481896ed3d494e332f'
 overlay=json.loads(overlay_path.read_text());lock(ROOT/'tools/firmware/f4_native_source_03/SOURCE_SHA256.json')
 for k in ['frozen_source02','frozen_link02','replace_only','replacement']:verify(overlay[k])
 assert overlay['other_eight_objects_unchanged'] and overlay['ABI02_unchanged'] and not overlay['additional_aliases'] and not overlay['target_executed']
 old_object=overlay['replace_only'];replacement=verify(overlay['replacement']);matches=[i for i,(rel,_)in enumerate(objects)if rel==old_object['path']];assert len(matches)==1
 objects[matches[0]]=(overlay['replacement']['path'],replacement.read_bytes())
 out.mkdir(parents=True);commands=[]
 def run(argv,kind):
  q=subprocess.run(list(map(str,argv)),cwd=ROOT,capture_output=True,text=True);commands.append(dict(kind=kind,argv=list(map(str,argv)),exit=q.returncode,stdout=q.stdout,stderr=q.stderr));(out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
  if q.returncode:raise RuntimeError(q.stdout+q.stderr)
  return q.stdout
 flags=['-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-DIQ4_JPEG_API_VERSION=82','-ffp-contract=off','-fno-strict-aliasing','-ffreestanding','-fno-stack-protector','-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer','-fno-optimize-sibling-calls','-ffunction-sections','-fdata-sections','-fPIC','-Wall','-Wextra','-Werror']
 source=[('tools/firmware/f1_stock_menu_04/runtime.c','f1_menu.o'),('tools/firmware/f1_stock_display_payload_16/payload.c','f1_display.o'),('tools/firmware/f1_stock_display_payload_16/wrapper.S','f1_display_wrapper.o'),('tools/firmware/f1_f4_user_integration_01/lv_settings_wrapper.S','lv_settings_wrapper.o'),('tools/firmware/native_runtime_01/self_read.c','self_read.o'),('tools/firmware/f3_native_card_bridge_06/card.c','card.o'),('tools/firmware/f3_native_card_bridge_06/card_linux.c','card_linux.o'),('tools/firmware/f3_native_card_bridge_06/fdinfo.c','fdinfo.o'),('tools/firmware/f3_native_card_bridge_06/fs05.c','fs05.o'),('tools/firmware/f3_native_card_bridge_06/native_calls.cpp','card_native_calls.o'),('tools/firmware/f3_native_fs_adapter_04/native_linux.c','fs_native_linux.o'),('tools/firmware/movie_card_01/movie.c','movie.o'),('tools/firmware/movie_card_01/native_linux.c','movie_linux.o'),('src/recording/native_mkv.c','native_mkv.o'),('src/codec/bounded_jpeg.c','bounded_jpeg.o'),('tools/firmware/f3_native_jpeg8_binding_01/native_jpeg82.c','native_jpeg82.o'),('tools/firmware/f3_stream_transaction_02/stream.c','checked_stream02.o')]
 compiled=[]
 for rel,name in source:
  p=ROOT/rel;obj=out/name;cpp=p.suffix=='.cpp';opts=['-target','aarch64-linux-gnu.2.28','-g0','-fPIC']if p.suffix=='.S'else[( '-std=c++17'if cpp and f=='-std=c11'else f)for f in flags]
  run([zig,'c++'if cpp else'cc',*opts,'-c',p,'-o',obj],'actual_target_compile_only');objects.append((str(obj.relative_to(ROOT)),obj.read_bytes()));compiled.append(dict(source=row(p),object=row(obj)))
 cleanup_path=a.cleanup_overlay.resolve();assert sha(cleanup_path)=='c815d63bf2fb69ec210d54f893ef3b1baaa71a2c2622ca7f8600e2f17910c21f'
 cleanup=json.loads(cleanup_path.read_text());verify(cleanup['source']);lock(ROOT/cleanup['source']['path']);assert cleanup['ABI_unchanged'] and cleanup['other_objects_unchanged'] and not cleanup['additional_aliases'] and not cleanup['target_executed']
 for r in cleanup['replacements']:
  old=r['replace_only'];p=verify(r['replacement']);matches=[i for i,(rel,b)in enumerate(objects)if Path(rel).name==Path(old['path']).name and len(b)==old['bytes']and hashlib.sha256(b).hexdigest()==old['sha256']];assert len(matches)==1
  objects[matches[0]]=(r['replacement']['path'],p.read_bytes())
 mkv_path=a.mkv_overlay.resolve();assert sha(mkv_path)=='5838a6d9ab68cddcf35f00cceb401f44ebf06ff46615f07f32285ae32918d801'
 mkv=json.loads(mkv_path.read_text());verify(mkv['source']);lock(ROOT/mkv['source']['path']);assert mkv['ABI_unchanged']and not mkv['additional_aliases']and not mkv['target_executed']
 old=mkv['replace_only'];p=verify(mkv['replacement']);matches=[i for i,(rel,b)in enumerate(objects)if Path(rel).name==Path(old['path']).name and len(b)==old['bytes']and hashlib.sha256(b).hexdigest()==old['sha256']];assert len(matches)==1;objects[matches[0]]=(mkv['replacement']['path'],p.read_bytes())
 spec=importlib.util.spec_from_file_location('frozen_iq4_f1_f4_linker',BACKEND);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
 m.HOOKS=((0x51ddcc,bytes.fromhex('9b64fd97'),0x477038,'iq4_f1_lv_draw_wrapper_16'),(0x4eea58,bytes.fromhex('43320094'),0x4fb364,'iq4_extensions_lv_menu_wrapper_01'),(0x4fb454,bytes.fromhex('14b2ff97'),0x4e7ca4,'iq4_f4_menu_native_pop_wrapper_03'))
 stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';original=m.original_contract(stock.read_bytes());link=json.loads((f4/'LINK_INPUT.json').read_text())
 m.ALIASES={'iq4_stock_menu_set_01':(0x4fb364,'native_SetMenu')}
 for e in link['original_aliases']:
  va=int(e['va'],16);before=original.data[original.va_offset(va,16):original.va_offset(va,16)+16]
  assert before.hex()==e['original_first16_le'] and hashlib.sha256(before).hexdigest()==e['original_first16_sha256']
  m.ALIASES[e['symbol']]=(va,'finite_original_F4_dependency')
 m.INITIALIZER='iq4_f1_menu_initialize_04';m.REQUIRED_SYMBOLS=tuple(h[3]for h in m.HOOKS)+(m.INITIALIZER,'iq4_f4_native_menu_entry_02','iq4_f4_worker_pump_one_02','iq4_f4_session_init_on_ui_02','iq4_f4_movie_binding_init_on_ui_02','f4_movie_finish_01','iq4_mkv_packet','iq4_jpeg_encode_bounded','iq4_native_jpeg82_bind_01')
 version=tuple(int(v)for v in a.app_version.split('.'));assert len(version)==3
 payload,report=m.Linker(stock.read_bytes(),objects).build(version)
 user=out/('P1Linux_RatioMask_LVRecording_'+a.app_version+'.bin');user.write_bytes(payload);(out/'LINK_REPORT.json').write_text(json.dumps(report,indent=2)+'\n')
 result=dict(schema='iq4_F1_F4_actual_User_link_01',stock=row(stock),f4_build=row(a.f4_build.resolve()),f4_source_overlay=row(overlay_path),cleanup_overlay=row(cleanup_path),mkv_overlay=row(mkv_path),artifact_map=row(a.artifact_map.resolve())if a.artifact_map else None,canonical_RGB_source_guard_linked=True,unknown_codec_cleanup_retains_owner_graph=True,actual_software_ID_zero_supported=True,compiled=compiled,User=row(user),object_count=len(objects),link_report=row(out/'LINK_REPORT.json'),target_executed=False,device_accessed=False,F3_JPEG_feature_included=False,in_camera_recording_accepted=False,FWP_produced=False,persistent_installation_safe=False)
 (out/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
if __name__=='__main__':main()
