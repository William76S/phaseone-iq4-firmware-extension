#!/usr/bin/env python3
"""Freeze the completed local build; no compiler, SDK, library or target run."""
from pathlib import Path
import hashlib,json,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/"analysis/firmware/native_copy_rtti_build_01"
STATIC=ROOT/"analysis/firmware/native_copy_rtti_static_01"
def row(p):
 b=p.read_bytes();return dict(path=p.relative_to(ROOT).as_posix(),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,j):p.write_text(json.dumps(j,indent=2)+"\n")
def main():
 build=json.loads((OUT/"BUILD.json").read_text());graph=json.loads((STATIC/"GRAPH.json").read_text())
 assert build["normal_cases"]==16 and build["san_cases"]==16 and build["target_objects"]==1
 assert all(c["exit_code"]==0 for c in build["commands"])
 assert not build["target_executed"] and not build["library_loaded"] and not build["sdk_loaded"]
 assert len(graph["COPY_dependencies"])==3 and len(graph["spans"])==31
 owned={p for p in HERE.iterdir() if p.is_file() and p.name not in ("SOURCE_SHA256.json","LINK_INPUT.json","ABI_PROOF.json")}
 references={ROOT/"tools/firmware/f1_user_elf_append_02/elf_append.py"}
 artifacts={OUT/n for n in ("BUILD.json","COMMANDS.json","rtti.d","rtti.o")}|{STATIC/"GRAPH.json"}
 source=dict(schema="iq4_native_copy_rtti_source_01",files=[row(p)for p in sorted(owned)],references=[row(p)for p in sorted(references)],artifacts=[row(p)for p in sorted(artifacts)],external_exact_inputs=[graph["user"],graph["library"],row(ROOT/"build/toolchains/zig-aarch64-macos-0.15.2/zig")],proof_emitted_after_source=True,proof_excluded_from_source_to_avoid_checksum_cycle=True,target_executed=False,library_loaded=False,sdk_loaded=False)
 emit(HERE/"SOURCE_SHA256.json",source)
 proof=dict(schema="iq4_native_COPY_RTTI_exact_static_ABI_01",runtime_verifier_symbol="iq4_native_copy_rtti_current_01",runtime_verifier_object=row(OUT/"rtti.o"),bindings=[{k:r[k]for k in ("symbol","va","bytes","dynsym_index","version_index","needed_library","version_name")}for r in graph["COPY_dependencies"]],actual_libstdcxx=graph["library"],original_user=graph["user"],source_manifest=row(HERE/"SOURCE_SHA256.json"),static_graph=row(STATIC/"GRAPH.json"),reader_maximum_bytes=448,library_bias_derived_from_actual_copy_function_slot=graph["anchor"],base_alignment=graph["base_alignment"],finite_runtime_spans=42,complete_function_bodies=18,active_final_elf_copy_metadata_requires_root_seal=True,target_executed=False,library_loaded=False,sdk_loaded=False)
 emit(HERE/"ABI_PROOF.json",proof)
 link=dict(schema="iq4_native_copy_rtti_link_01",source=row(HERE/"SOURCE_SHA256.json"),objects=[row(OUT/"rtti.o")],loader_abi_proof=row(HERE/"ABI_PROOF.json"),runtime_verifier_symbol=proof["runtime_verifier_symbol"],undefined_symbols=["memcmp","memcpy"],integration="combine current immutable linked-ELF seal with exact COPY RTTI selfread at every admission/ready/worker call",target_executed=False)
 emit(HERE/"LINK_INPUT.json",link)
 dest=ROOT/"build/native_copy_rtti_01_source_01/IQ4_Native_Copy_Rtti_01_Source_01.zip";dest.parent.mkdir(parents=True,exist_ok=True)
 members=owned|references|artifacts|{HERE/"SOURCE_SHA256.json",HERE/"LINK_INPUT.json",HERE/"ABI_PROOF.json"}
 with zipfile.ZipFile(dest,"w",zipfile.ZIP_DEFLATED)as z:
  for p in sorted(members):z.write(p,p.relative_to(ROOT).as_posix())
 result=dict(source=row(HERE/"SOURCE_SHA256.json"),proof=row(HERE/"ABI_PROOF.json"),link=row(HERE/"LINK_INPUT.json"),object=row(OUT/"rtti.o"),zip=row(dest),hash_rows=len(owned|references|artifacts),zip_members=len(members),normal_cases=16,san_cases=16,target_executed=False)
 emit(OUT/"FREEZE_RECEIPT.json",result);print(json.dumps(result))
if __name__=="__main__":main()
