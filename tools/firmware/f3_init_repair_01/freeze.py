#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_init_repair_01';BUILD=OUT/'build'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,j):p.write_text(json.dumps(j,indent=2)+'\n')
def main():
 if '--verify' in sys.argv:
  j=json.loads((HERE/'SOURCE_SHA256.json').read_text())
  for item in j['files']:assert row(ROOT/item['path'])==item,item['path']
  print(len(j['files']),'exact source/artifact rows verified');return
 b=json.loads((BUILD/'BUILD.json').read_text());assert b['regressions_normal']==b['regressions_san']==256 and b['actual_ELF_model_cases']==27
 assert all(c['exit']==0 for c in json.loads((BUILD/'COMMANDS.json').read_text()))
 graph=json.loads((OUT/'GRAPH.json').read_text());assert graph['base_alignment']==4096 and len(graph['spans'])==31
 files={p for p in HERE.iterdir() if p.is_file() and p.name not in ('SOURCE_SHA256.json','ABI_PROOF.json','LINK_INPUT.json')}
 files|={OUT/n for n in ['LOADER_STATIC.json','GRAPH.json','INSTALL_PINS.json','load_segment_alignment.asm','et_dyn_mapping_and_bias.asm','mmap_syscall.asm']}
 files|={BUILD/n for n in ['BUILD.json','COMMANDS.json','LOADED_MODEL.json','rtti.o','rtti_repeat.o']}
 files|={ROOT/'tools/firmware'/n for n in ['native_copy_rtti_01/rtti.h','native_copy_rtti_01/rtti.cpp','native_copy_rtti_01/rtti_pins.inc','f1_user_elf_append_02/elf_append.py','f3_gallery_source_snapshot_01/pins.inc','f3_saved_raw_capture_03/capture_pins.inc','f3_native_render_02/api_pins.h','f3_native_jpeg8_binding_01/code_pins.h']}
 files|={ROOT/n for n in [graph['library']['path'],graph['user']['path'],'analysis/firmware/native_copy_rtti_static_01/GRAPH.json','analysis/firmware/f4_ram_loader_static/ld-2.28.analysis.elf','analysis/firmware/kernel.config.txt','analysis/firmware/f1_f3_f4_user_integration_build_04_recording_repair_01/P1Linux_RatioMask_JPEG_LVRecording_6.03.33.bin',b['compiler']['path']]}
 emit(HERE/'SOURCE_SHA256.json',dict(schema='iq4_f3_init_repair_source_01',files=[row(p)for p in sorted(files)],target_executed=False,camera_accessed=False,proof_excluded_to_avoid_cycle=True))
 proof=json.loads((ROOT/'tools/firmware/native_copy_rtti_01/ABI_PROOF.json').read_text());proof.update(runtime_verifier_object=b['object'],source_manifest=row(HERE/'SOURCE_SHA256.json'),static_graph=row(OUT/'GRAPH.json'),base_alignment=4096,ELF_PT_LOAD_p_align=65536,bias_alignment_evidence=row(OUT/'LOADER_STATIC.json'))
 emit(HERE/'ABI_PROOF.json',proof)
 emit(HERE/'LINK_INPUT.json',dict(schema='iq4_native_copy_rtti_link_01',source=row(HERE/'SOURCE_SHA256.json'),objects=[b['object']],loader_abi_proof=row(HERE/'ABI_PROOF.json'),runtime_verifier_symbol=proof['runtime_verifier_symbol'],undefined_symbols=['memcmp','memcpy'],replaces='analysis/firmware/native_copy_rtti_build_01/rtti.o',target_executed=False))
 print(json.dumps(dict(source=row(HERE/'SOURCE_SHA256.json'),proof=row(HERE/'ABI_PROOF.json'),object=b['object'])))
if __name__=='__main__':main()
