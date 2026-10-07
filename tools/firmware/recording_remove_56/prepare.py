#!/usr/bin/env python3
"""Derive no-recording release only from locked55 and two small UI objects."""
import argparse,copy,hashlib,importlib.util,json,subprocess,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
BASE='analysis/firmware/stock_storage_release_55_inputs_final02/inputs/INPUTS_CLEANUP_DRAFT.json'
BASE_SHA='c4f178155ea608d11e1fa2e5a78207e71f97f5afa326484410c92b7151aca410'
REMOVE=set(range(9))|{12}|set(range(14,24))|{25,26}
UI={'iq4_f4_menu_new_03','iq4_f4_menu_ctor_03','iq4_f4_menu_append_03','iq4_f4_native_current_02'}
RETIRED_REQ={'iq4_f4_native_menu_entry_02','iq4_f4_native_queue_lock_05','iq4_f4_source_native_owned_on_ui_06'}
DROP_MANIFESTS={'tools/firmware/f4_native_diagnostics_04/SOURCE_SHA256.json','tools/firmware/f4_native_entry_03/SOURCE_SHA256.json','tools/firmware/native_activity_01/SOURCE_SHA256.json','tools/firmware/f4_native_source_05/SOURCE_SHA256.json','tools/firmware/f4_native_session_05/SOURCE_SHA256.json','tools/firmware/f4_start_repair_05/SOURCE_SHA256.json','tools/firmware/f4_native_stop_06/SOURCE_SHA256.json','tools/firmware/f3_native_fs_unique_06/SOURCE_SHA256.json','analysis/firmware/f3_native_fs_root_overlay_06/SOURCE_SHA256.json','tools/firmware/f3_card_fdinfo_path_repair_01/SOURCE_SHA256.json','tools/firmware/f3_hold_diagnostics_01/SOURCE_SHA256.json','tools/firmware/f3_filesystem_identity_01/SOURCE_SHA256.json'}
def row(path,expected=None):
 p=Path(path);p=(ROOT/p).resolve()if not p.is_absolute()else p.resolve();b=p.read_bytes();r=dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
 if expected:assert r==expected,r['path']
 return r
def symbols(r):
 row(r['path'],r);s=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--format=posix',str(ROOT/r['path'])],text=True);d=set();u=set()
 for line in s.splitlines():
  f=line.split()
  if len(f)<2:continue
  if f[1]=='U':u.add(f[0])
  elif f[1].upper()in{'T','B','D','R','V','W','A','C'}:d.add(f[0])
 return d,u

def main():
 p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);p.add_argument('--components',type=Path,required=True);a=p.parse_args();out=a.output.resolve();assert out.is_relative_to(ROOT)and not out.exists();assert row(BASE)['sha256']==BASE_SHA
 base=json.loads((ROOT/BASE).read_text());assert len(base['objects'])==62 and base['expected_hook_count']==55;spec=copy.deepcopy(base)
 removed=[o for i,o in enumerate(base['objects'])if i in REMOVE];spec['objects']=[o for i,o in enumerate(base['objects'])if i not in REMOVE];assert len(removed)==22
 comp=a.components.resolve();m=json.loads((comp/'SOURCE_SHA256.json').read_text());new=[row(r['path'],r)for r in m['objects']];assert len(new)==2;spec['objects']+=new
 removed_defs=set().union(*(symbols(o)[0]for o in removed));defs=set();uses=set()
 for o in spec['objects']:
  d,u=symbols(o);defs|=d;uses|=u
 # Preserve compiled initializer and contract; account for their actual
 # compiled undefined sets from55, matched to the same source/flags.
 build=json.loads((ROOT/'analysis/firmware/jpeg_restart_55_build_final02/BUILD.json').read_text())
 for c in build['compiled']:
  assert c['source']in[x['source']for x in spec['compile']];d,u=symbols(c['object']);defs|=d;uses|=u
 # Only the four proven shared UI compatibility functions survive f4 names.
 assert {x for x in defs if x.startswith(('iq4_f4_','f4_movie_','iq4_mkv_'))}==UI
 assert not(uses&removed_defs-defs),sorted(uses&removed_defs-defs)
 removed_aliases=[r for r in base['aliases']if r['symbol']not in uses];spec['aliases']=[r for r in base['aliases']if r['symbol']in uses]
 loader=importlib.util.spec_from_file_location('remove56_imports',ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py');backend=importlib.util.module_from_spec(loader);sys.modules[loader.name]=backend;loader.loader.exec_module(backend)
 imports=backend.original_imports(backend.original_contract((ROOT/base['stock']['path']).read_bytes()))
 external=uses-defs-{r['symbol']for r in spec['aliases']}
 assert not(external-set(imports)-{backend.NEW_IMPORT}),sorted(external-set(imports)-{backend.NEW_IMPORT})
 assert RETIRED_REQ<=set(spec['required_functions']);spec['required_functions']=[r for r in spec['required_functions']if r not in RETIRED_REQ];assert set(spec['required_functions'])<=defs
 pop=[h for h in base['BL_hooks']if h['va']==0x4fb454];assert len(pop)==1 and pop[0]['old_hex']=='14b2ff97'and pop[0]['original_target']==0x4e7ca4;spec['BL_hooks']=[h for h in base['BL_hooks']if h['va']!=0x4fb454]
 lv=[h for h in spec['BL_hooks']if h['va']==0x4eea58];assert len(lv)==1 and lv[0]['target_symbol']=='iq4_extensions_lv_menu_wrapper_01'and lv[0]['old_hex']=='43320094'
 spec['source_manifests']=[r for r in base['source_manifests']if r['path']not in DROP_MANIFESTS]+[row(comp/'SOURCE_SHA256.json')]
 spec['receipts']+=[row(BASE),row(__file__),row(HERE/'build.py'),row(HERE/'assemble.py'),row(HERE/'verify_removed.py'),row(HERE/'verify_user.py')]
 spec.pop('recording_default_fs_id');spec.update(recording_implementation_linked=False,recording_removed=True,integration_revision='recording_removed_56',scope='Ratio Mask, Dual EXP and stock55 JPEG only; no LV Recording page, frame source, session, codec/movie writer or card backend. Shared native JPEG codec and four native menu adapters retained.',expected_hook_count=54)
 out.mkdir();(out/'INPUTS.json').write_text(json.dumps(spec,indent=2)+'\n')
 receipt=dict(schema='iq4_recording_removed_input_56',base=row(BASE),removed_objects=removed,added_objects=new,removed_hooks=pop,replaced_lv_menu_hook=lv,removed_required_exports=sorted(RETIRED_REQ),shared_UI_exports=sorted(UI),shared_native_JPEG_codec_retained=base['objects'][24],shared_RTTI_retained=base['objects'][27],retained_55_objects=40,removed_aliases=removed_aliases,removed_manifests=[r for r in base['source_manifests']if r['path']in DROP_MANIFESTS],retained_to_removed_unresolved_edges=[],existing_original_imports_used=sorted(external&set(imports)),compiler_noexcept_dependency=sorted(external&{backend.NEW_IMPORT}),all_JPEG_Ratio_Dual_objects_byte_identical=True,camera_accessed=False)
 (out/'REMOVAL.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps(dict(spec=row(out/'INPUTS.json'),objects=44,hooks=54,removed_objects=22)))
if __name__=='__main__':main()
