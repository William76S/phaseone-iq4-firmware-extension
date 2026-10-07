#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_half_export_54';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,x):p.write_text(json.dumps(x,indent=2)+'\n')
def main():
 if '--verify'in sys.argv:
  source=json.loads((OUT/'SOURCE_SHA256.json').read_text());assert all(row(ROOT/q['path'])==q for q in source['files'])
  link=json.loads((OUT/'LINK.json').read_text());assert row(ROOT/link['source_manifest'])['sha256']==link['source_manifest_sha256']
  assert all(row(ROOT/q['path'])==q for q in link['objects']);print('PASS frozen Half runtime/sink/config/header/native evidence closure');return
 build=json.loads((OUT/'BUILD.json').read_text());commands=json.loads((OUT/'COMMANDS.json').read_text())
 assert len(build['host_runtime_cases'])==7 and all(q['exit']==0 for q in commands)
 assert all(row(ROOT/q['path'])==q for q in build['objects'])
 sink_build=ROOT/build['actual_host_sink_build']['path'];assert row(sink_build)==build['actual_host_sink_build']
 sink=json.loads(sink_build.read_text());assert all(row(ROOT/q['path'])==q for q in sink['sources']+sink['objects'])
 baseline=json.loads((HERE/'BASELINE.json').read_text());assert all(row(ROOT/q['path'])==q for q in baseline['files'])
 files={p for p in HERE.iterdir()if p.is_file()}
 files|={OUT/'BUILD.json',OUT/'COMMANDS.json',OUT/'EXACT.json',sink_build,sink_build.parent/'COMMANDS.json'}
 files|={p for p in OUT.iterdir()if p.suffix=='.asm'}
 files|={ROOT/q['path']for q in build['objects']+sink['sources']+baseline['files']}
 files|={ROOT/'tools/firmware/native_runtime_01/self_read.h',
  ROOT/'tools/firmware/f3_native_half_01/half.h',ROOT/'tools/firmware/f3_native_jpeg8_binding_01/native_jpeg82.h',
  ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01/EXACT.json',
  ROOT/'analysis/firmware/stock_jpeg_policy_build_01/SOURCE_SHA256.json',
  ROOT/'analysis/firmware/native_half_01/SOURCE_SHA256.json',
  ROOT/'analysis/firmware/native_half_lease_audit_01/SOURCE_SHA256.json',
  ROOT/'analysis/firmware/native_jpeg_ARGB_audit_01/RECEIPT.json'}
 # Lock the independent audit contents as well as each audit manifest.
 for folder,manifest in [('native_half_lease_audit_01','SOURCE_SHA256.json'),('native_jpeg_ARGB_audit_01','RECEIPT.json')]:
  directory=ROOT/'analysis/firmware'/folder
  files|={p for p in directory.iterdir()if p.is_file()and p.suffix in ['.py','.json','.asm']}
 source=OUT/'SOURCE_SHA256.json';emit(source,dict(schema='iq4_stock_half_export_source_54',files=[row(p)for p in sorted(files)],
  camera_accessed=False,target_device_executed=False))
 b=USER.read_bytes();phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 def raw(va,n):
  for i in range(num):
   typ,fl,off,a,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
   if typ==1 and a<=va and va+n<=a+fs:return b[off+va-a:off+va-a+n]
  raise AssertionError(hex(va))
 aliases=[]
 for symbol,va in [('_setjmp',0x40a140),('calloc',0x40a760),('free',0x40b120),('longjmp',0x40b060),('memset',0x40a1a0)]:
  data=raw(va,16);aliases.append(dict(symbol=symbol,va=va,kind='original imported routine',original_first16_LE=data.hex(),
                                  original_first16_sha256=hashlib.sha256(data).hexdigest()))
 exact=json.loads((OUT/'EXACT.json').read_text());sr=row(source)
 link=dict(schema='iq4_stock_half_export_link_54',objects=build['objects'],aliases=aliases,
  BL_hooks=[exact['wait_hook']],auxiliary_hooks=[],source_manifest=sr['path'],source_manifest_sha256=sr['sha256'],
  required_functions=['iq4_stock_half_acquire_01','iq4_stock_jpeg_extended_size_get_02',
   'iq4_stock_jpeg_extended_size_set_02','iq4_stock_jpeg_quality_get_02','iq4_stock_half_ifm_wait_02'],
  replaces_objects=['analysis/firmware/f3_stock_jpeg_xqd_01/build/runtime.o'],
  retains_52_objects=['publish.o','settings.o','wrappers.o'],retains_53_policy=True,
  requires_native_half_component='analysis/firmware/native_half_01/LINK_INPUTS_01.json',
  requires_native_jpeg82_binding_symbol='iq4_native_jpeg82_bind_01',
  stock_pin_header='tools/firmware/f3_stock_half_export_01/stock_pins_54.h',
  half_pin_header='tools/firmware/f3_stock_half_export_01/half_pins.h',
  native_size_enum=1,quality=100,size_choices={'0':'4K','1':'50% width and height'},
  half_dimensions=[7102,5326],half_native_rotation=0,half_wait_milliseconds=60000,
  stock_wait_unchanged=True,existing_done16_unchanged=True,raw_path_original=True,
  camera_accessed=False,target_device_executed=False)
 emit(OUT/'LINK.json',link);print(json.dumps(dict(link=row(OUT/'LINK.json'),source=sr,objects=build['objects'])))
if __name__=='__main__':main()
