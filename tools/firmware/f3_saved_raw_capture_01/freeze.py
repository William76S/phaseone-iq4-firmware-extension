#!/usr/bin/env python3
"""Freeze this bounded local source/result, never vendor binaries."""
from pathlib import Path
import hashlib,json,zipfile
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return dict(path=p.relative_to(ROOT).as_posix(),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 source=[p for p in HERE.iterdir()if p.is_file()and p.name not in ('SOURCE_SHA256.json','LINK_INPUT.json')]
 refs=[ROOT/p for p in ['tools/firmware/f3_native_card_bridge_06/SOURCE_SHA256.json','tools/firmware/f3_native_card_bridge_06/card.h','tools/firmware/f3_native_card_bridge_05/card.h','tools/firmware/f3_native_fs_adapter_04/fs.h','tools/firmware/f3_stream_transaction_02/sha256.h','tools/firmware/native_activity_01/activity.h','tools/firmware/native_activity_01/SOURCE_SHA256.json','tools/firmware/f3_capture_menu_03/policy.h']]
 artifacts=[p for d in ['f3_saved_raw_capture_static_01','f3_saved_raw_capture_build_01']for p in (ROOT/'analysis/firmware'/d).iterdir()if p.is_file()]
 lock=dict(schema='iq4_f3_saved_raw_capture_source_01',files=[row(p)for p in sorted(source)],references=[row(p)for p in refs],artifacts=[row(p)for p in sorted(artifacts)],target_executed=False,sdk_loaded=False,device_connected=False)
 (HERE/'SOURCE_SHA256.json').write_text(json.dumps(lock,indent=2)+'\n')
 objects=[ROOT/'analysis/firmware/f3_saved_raw_capture_build_01'/(n+'.o')for n in ['capture','directories_linux','runtime','acquired_wrapper','native_factory']]
 link=dict(schema='iq4_f3_saved_raw_capture_link_01',source=row(HERE/'SOURCE_SHA256.json'),objects=[row(p)for p in objects],original_bindings=row(HERE/'ORIGINAL_BINDINGS.json'),required_consumer='actual synchronous coordinator06 saved callback',automatic_capture_scope='SD only; XQD stock RAW remains',public_raw_removed=False,target_executed=False)
 (HERE/'LINK_INPUT.json').write_text(json.dumps(link,indent=2)+'\n')
 dest=ROOT/'build/f3_saved_raw_capture_source_01/IQ4_F3_Saved_RAW_Capture_01.zip';dest.parent.mkdir(parents=True,exist_ok=True)
 with zipfile.ZipFile(dest,'w',compression=zipfile.ZIP_DEFLATED)as z:
  for p in sorted(source+refs+artifacts+[HERE/'SOURCE_SHA256.json',HERE/'LINK_INPUT.json']):z.write(p,p.relative_to(ROOT).as_posix())
 print(json.dumps(dict(source=row(HERE/'SOURCE_SHA256.json'),link=row(HERE/'LINK_INPUT.json'),zip=row(dest),hash_rows=len(source)+len(refs)+len(artifacts),target_executed=False)))
if __name__=='__main__':main()
