#!/usr/bin/env python3
"""Finite source/object freeze or read-only verification; no target execution."""
import argparse,hashlib,json,struct
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
MENU=ROOT/'tools/firmware/f4_native_menu_03'
ORIGINAL=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
ORIGINAL_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def row(p):
 p=p.resolve();assert p.is_relative_to(ROOT)and p.is_file()
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def save(p,j):p.write_text(json.dumps(j,indent=2)+'\n');return row(p)
def sources(directory):return [p for p in sorted(directory.iterdir())if p.is_file()and p.name not in {'SOURCE_SHA256.json','LINK_INPUT.json'}and p.suffix in {'.h','.c','.cpp','.py','.md'}]
def verify(p):
 j=json.loads(p.read_text());seen=set()
 for x in j['files']:
  assert set(x)=={'path','bytes','sha256'}and x['path']not in seen;seen.add(x['path'])
  assert row(ROOT/x['path'])==x,x['path']
 print(p.relative_to(ROOT),len(seen),'members PASS',row(p)['sha256'])
 return j
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--verify',action='store_true');ap.add_argument('--build',type=Path);a=ap.parse_args()
 if a.verify:
  assert a.build is None;verify(MENU/'SOURCE_SHA256.json');verify(OWN/'SOURCE_SHA256.json');return
 assert a.build is not None
 build=a.build.resolve();assert build.is_relative_to(ROOT)
 for p in [MENU/'SOURCE_SHA256.json',OWN/'SOURCE_SHA256.json',OWN/'LINK_INPUT.json']:assert not p.exists(),'frozen identity cannot be overwritten'
 raw=ORIGINAL.read_bytes();assert len(raw)==11874544 and hashlib.sha256(raw).hexdigest()==ORIGINAL_SHA
 report=json.loads((build/'BUILD.json').read_text());assert report['schema']=='iq4_f4_native_source_menu_build_02'
 assert len(report['objects'])==9 and len(report['tests'])==43
 for x in report['source_inputs']+report['dependencies']:assert row(ROOT/x['path'])==x,x['path']
 for x in report['objects']:
  p=ROOT/x['path'];assert row(p)=={k:x[k]for k in ['path','bytes','sha256']}
  h=struct.unpack_from('<16sHHI',p.read_bytes());assert h[0][:6]==b'\x7fELF\x02\x01'and h[1:3]==(1,183)and not x['executed']
 assert not any(report[k]for k in ['target_executed','sdk_loaded','camera_access','actual_recording_tested','hardware_modes_verified'])
 menu_files=sources(MENU)+sorted((ROOT/'analysis/firmware/f4_native_menu_03/static').glob('*'))
 menu_files+=[ROOT/x['path']for x in report['objects']if Path(x['path']).name in {'menu.o','menu_native_calls.o'}]
 menu_source=save(MENU/'SOURCE_SHA256.json',dict(schema='iq4_f4_native_menu_source_freeze_03',files=[row(p)for p in sorted(set(menu_files))],camera_access=False,target_executed=False,actual_menu_tested=False))
 # Existing Root syscall reader is the only external production source-reader.
 aliases={'memcpy':'0x40a530','memset':'0x40a1a0','memcmp':'0x40b160','__cxa_begin_catch':'0x409d00','__cxa_end_catch':'0x40aa00','__gxx_personality_v0':'0x40a640',
  'iq4_native_original_syscall_01':'0x40ae40','iq4_f3_original_syscall_03':'0x40ae40','iq4_f3_original_errno_location_03':'0x40a4e0',
  'iq4_f3_register_client_05':'0x8ca3ec','iq4_f3_wait_request_05':'0x8ca888','iq4_f3_release_request_05':'0x8ca708','iq4_f3_request_device_06':'0x8ca598','iq4_f3_current_native_thread_06':'0x710b0c'}
 original_aliases=[]
 for name,v in aliases.items():
  va=int(v,16);b=raw[va-0x400000:va-0x400000+16];original_aliases.append(dict(symbol=name,va=v,original_first16_le=b.hex(),original_first16_sha256=hashlib.sha256(b).hexdigest()))
 dependencies=[row(ROOT/x['path'])for x in report['dependencies']]
 link=dict(schema='iq4_f4_source02_menu03_link_inputs',original_user=dict(bytes=len(raw),sha256=ORIGINAL_SHA),menu_source=menu_source,
  entry=dict(symbol='iq4_f4_native_menu_entry_02',arguments='original selector x0, original root x1, returnPC4eea5c, explicit defaultSD10',callsite='0x4eea58',old_bytes_le='43320094',original_target='0x4fb364',shared_with_F1=True,original_called_exactly_once_by_Root_wrapper=True),
  back=dict(symbol='iq4_f4_menu_native_pop_wrapper_03',callsite='0x4fb454',old_bytes_le='14b2ff97',original_target='0x4e7ca4',unowned_native_exception_passthrough=True),
  objects=report['objects'],original_aliases=original_aliases,dependencies=dependencies,
  required_link_source_groups=['own nine objects once','native_runtime_01/self_read.c','f3_native_jpeg8_binding_01/native_jpeg82.c','src/codec/bounded_jpeg.c','src/recording/native_mkv.c','Card06 superset only: card.c native_calls.cpp card_linux.c fdinfo.c fs05.c','Movie01: movie.c native_linux.c and their frozen FS/SHA dependencies'],
  do_not_link=['Card05 card.c together with Card06 card.c','old F4 EN0/backend/desktop UI','raw SO or raw ET_REL without relocation/unwind merge'],
  production_guard='exact original bytes, actualUI/current owner, registeredtriple/native liveclient/bank/pairedunlock/page, async selectedcard mounted root; no evidence booleans',
  source_metadata='nativeRGB24 W/H/3W capacity; original U32softwareID, observerMonotonicNS notsensorclock',
  publication='Movie01 seals once/sync/wholeSHA/nativeScanner/JPEG/CRC/noreplace/dirsync; UI native release last',
  actual_recording_tested=False,actual_mode_or_fps_verified=False,camera_access=False,target_executed=False)
 save(OWN/'LINK_INPUT.json',link)
 own_files=sources(OWN)+sorted((ROOT/'analysis/firmware/f4_native_source_02/static').glob('*'))
 own_files+=[OWN/'LINK_INPUT.json',MENU/'SOURCE_SHA256.json',build/'BUILD.json',build/'COMMANDS.json']
 own_files+=[ROOT/x['path']for x in report['objects']]
 own_files+=[ROOT/x['path']for x in dependencies]
 save(OWN/'SOURCE_SHA256.json',dict(schema='iq4_f4_native_source_freeze_02',files=[row(p)for p in sorted(set(own_files))],original_user_sha256=ORIGINAL_SHA,
  test_runs=len(report['tests']),aarch64_objects=9,camera_access=False,target_executed=False,actual_recording_tested=False))
 verify(MENU/'SOURCE_SHA256.json');verify(OWN/'SOURCE_SHA256.json')
 print('LINK',row(OWN/'LINK_INPUT.json'))
if __name__=='__main__':main()
