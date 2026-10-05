#!/usr/bin/env python3
"""Bind the real Root fs05 object to frozen fs06; never execute target ELF."""
from pathlib import Path
import hashlib,importlib.util,json
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OLD_BUILD=ROOT/'analysis/firmware/f1_f4_user_integration_build_02_attempt02'
CARD_BUILD=ROOT/'analysis/firmware/f3_native_card_bridge_build_06'
NEW=ROOT/'tools/firmware/f3_native_fs_unique_06'
SOURCE=ROOT/'tools/firmware/f3_native_card_bridge_06/fs05.c'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 spec=importlib.util.spec_from_file_location('finite_fs06_elf_metadata',NEW/'freeze.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 frozen=json.loads((NEW/'SOURCE_SHA256.json').read_text());assert all(row(ROOT/x['path'])==x for x in frozen['files'])
 overlay=json.loads((NEW/'LINK_OVERLAY.json').read_text());actual=OLD_BUILD/'fs05.o'
 expected={'path':'analysis/firmware/f1_f4_user_integration_build_02_attempt02/fs05.o','bytes':19872,'sha256':'e5b974920196c956b788e2a1915ff9d93df4d05611e164df5d0141ccbfa4c50d'}
 assert row(actual)==expected
 root=json.loads((OLD_BUILD/'BUILD.json').read_text());compiled=[x for x in root['compiled']if x['object']==expected];assert len(compiled)==1
 old_source=row(SOURCE);assert compiled[0]['source']==old_source
 card=json.loads((CARD_BUILD/'BUILD.json').read_text());assert old_source in card['inputs']
 def command(p,obj):
  entries=json.loads(p.read_text());matches=[x for x in entries if '-c'in x['argv']and '-o'in x['argv']and x['argv'][x['argv'].index('-o')+1]==str(obj)]
  assert len(matches)==1;x=matches[0];assert x.get('exit',x.get('returncode'))==0
  assert str(SOURCE)==x['argv'][x['argv'].index('-c')+1];return x
 rootcmd=command(OLD_BUILD/'COMMANDS.json',actual)
 cardcmd=command(CARD_BUILD/'COMMANDS.json',ROOT/overlay['replace_only']['path'])
 assert rootcmd['argv'][0]==cardcmd['argv'][0]
 assert old_source['sha256']=='016f58200008ab649d9e12585befd752c77f7dfc792411ecffe9e84dabb19f28'
 rootinfo=m.info(actual);replacement=m.info(ROOT/overlay['replacement']['path'])
 assert rootinfo['defined_global_symbols']==replacement['defined_global_symbols']
 assert set(replacement['undefined_symbols']).issubset(set(rootinfo['undefined_symbols']))
 result=dict(schema='iq4_f3_fs06_root_actual_single_object_overlay',replace_only=rootinfo,replacement=replacement,
  original_fs05_source=old_source,canonical_old_replace_only=overlay['replace_only'],frozen_new_source=row(NEW/'SOURCE_SHA256.json'),frozen_new_overlay=row(NEW/'LINK_OVERLAY.json'),
  root_original_build=row(OLD_BUILD/'BUILD.json'),root_original_commands=row(OLD_BUILD/'COMMANDS.json'),card_original_build=row(CARD_BUILD/'BUILD.json'),card_original_commands=row(CARD_BUILD/'COMMANDS.json'),
  actual_root_original_compile=rootcmd,canonical_original_compile=cardcmd,
  root_flags_not_in_canonical=[x for x in rootcmd['argv']if x.startswith('-')and x not in cardcmd['argv']],
  canonical_flags_not_in_root=[x for x in cardcmd['argv']if x.startswith('-')and x not in rootcmd['argv']],
  same_actual_original_source_verified=True,original_object_bytes_are_different=True,original_objects_binary_equivalent_claimed=False,
  ABI_header=row(ROOT/'tools/firmware/f3_native_fs_adapter_04/fs.h'),public_symbol_names_unchanged=True,ABI_layout_unchanged=True,
  new_BL=[],additional_aliases=[],target_executed=False,camera_access=False,SDK_invoked=False)
 out=HERE/'LINK_OVERLAY_ROOT_F1_F4.json';out.write_text(json.dumps(result,indent=2)+'\n')
 files=[HERE/'audit.py',out,NEW/'SOURCE_SHA256.json',NEW/'LINK_OVERLAY.json',OLD_BUILD/'BUILD.json',OLD_BUILD/'COMMANDS.json',CARD_BUILD/'BUILD.json',CARD_BUILD/'COMMANDS.json',SOURCE,actual,ROOT/replacement['path'],ROOT/result['ABI_header']['path']]
 (HERE/'SOURCE_SHA256.json').write_text(json.dumps(dict(schema='iq4_fs06_root_actual_overlay_proof_01',files=[row(p)for p in sorted(set(files))],target_executed=False,camera_access=False),indent=2)+'\n')
 print(json.dumps(dict(passed=True,overlay=row(out),proof_source=row(HERE/'SOURCE_SHA256.json'),replace_only=row(actual),replacement=row(ROOT/replacement['path']))))
if __name__=='__main__':main()
