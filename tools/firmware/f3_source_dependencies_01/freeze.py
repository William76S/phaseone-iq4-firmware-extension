#!/usr/bin/env python3
"""Local exact source lock; excludes original vendor binaries."""
import hashlib,json,zipfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return dict(path=p.relative_to(ROOT).as_posix(),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 source=[p for p in HERE.iterdir()if p.is_file()and p.name not in ('SOURCE_SHA256.json','LINK_INPUT.json')]
 refs=[ROOT/'tools/firmware/f3_raw_file_source_01/reader_stage.hpp']
 artifacts=[p for d in ['f3_source_dependencies_static_01','f3_source_dependencies_build_01']for p in (ROOT/'analysis/firmware'/d).iterdir()if p.is_file()]
 lock=dict(schema='iq4_f3_source_dependencies_source_01',files=[row(p)for p in sorted(source)],references=[row(p)for p in refs],artifacts=[row(p)for p in sorted(artifacts)],target_executed=False,sdk_loaded=False,device_connected=False)
 (HERE/'SOURCE_SHA256.json').write_text(json.dumps(lock,indent=2)+'\n')
 obj=ROOT/'analysis/firmware/f3_source_dependencies_build_01/dependencies.o'
 link=dict(schema='iq4_f3_source_dependencies_link_01',source=row(HERE/'SOURCE_SHA256.json'),objects=[row(obj)],exports=['snapshot_from_ifm','snapshot_from_raw_manager','constructor_inputs','recheck'],new_native_calls=0,original_user_sha256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb',target_executed=False)
 (HERE/'LINK_INPUT.json').write_text(json.dumps(link,indent=2)+'\n')
 dest=ROOT/'build/f3_source_dependencies_source_01/IQ4_F3_Source_Dependencies_01.zip';dest.parent.mkdir(parents=True,exist_ok=True)
 with zipfile.ZipFile(dest,'w',compression=zipfile.ZIP_DEFLATED)as z:
  for p in sorted(source+refs+artifacts+[HERE/'SOURCE_SHA256.json',HERE/'LINK_INPUT.json']):z.write(p,p.relative_to(ROOT).as_posix())
 print(json.dumps(dict(source=row(HERE/'SOURCE_SHA256.json'),link=row(HERE/'LINK_INPUT.json'),zip=row(dest),hash_rows=len(source)+len(refs)+len(artifacts),target_executed=False)))
if __name__=='__main__':main()
