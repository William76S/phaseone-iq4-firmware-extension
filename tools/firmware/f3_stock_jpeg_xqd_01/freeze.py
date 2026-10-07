#!/usr/bin/env python3
from pathlib import Path
import json,hashlib,struct,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01';BUILD=OUT/'build';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,v):p.write_text(json.dumps(v,indent=2)+'\n')
def main():
 if '--verify' in sys.argv:
  lock=json.loads((HERE/'SOURCE_SHA256.json').read_text());assert all(row(ROOT/x['path'])==x for x in lock['files']);link=json.loads((HERE/'LINK_INPUT.json').read_text());assert row(ROOT/link['source']['path'])==link['source']and all(row(ROOT/x['path'])==x for x in link['objects']);print('PASS frozen core sources/receipts/four target objects');return
 build=json.loads((BUILD/'BUILD.json').read_text());assert build['host_publish_cases']==6 and build['host_routing_cases']==4 and build['actual_A64_requester_clients']==2;assert all(q['exit']==0 for q in json.loads((BUILD/'COMMANDS.json').read_text()))
 files={p for p in HERE.iterdir()if p.is_file()and p.name not in ['SOURCE_SHA256.json','LINK_INPUT.json']};files|={p for p in OUT.iterdir()if p.suffix in ['.json','.asm']};files|={BUILD/'BUILD.json',BUILD/'COMMANDS.json'};files|={ROOT/x['path']for x in build['objects']};files|={BUILD/(Path(x['path']).name+'.asm')for x in build['objects']};files|={ROOT/'tools/firmware/native_runtime_01/self_read.h'}
 emit(HERE/'SOURCE_SHA256.json',dict(schema='iq4_stock_jpeg_xqd_source_01',files=[row(p)for p in sorted(files)],camera_accessed=False,target_executed=False))
 b=USER.read_bytes();phoff=struct.unpack_from('<Q',b,32)[0];sz,num=struct.unpack_from('<HH',b,54)
 def rd(va,n):
  for i in range(num):
   typ,fl,off,a,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*sz)
   if typ==1 and a<=va and va+n<=a+fs:return b[off+va-a:off+va-a+n]
  raise ValueError(hex(va))
 aliases=[]
 for symbol,va in [('strnlen',0x409e80),('strcmp',0x40ab40),('strlen',0x40aea0),('memchr',0x40aa50),('memcpy',0x40a530),('memcmp',0x40b160),('iq4_f3_original_syscall_03',0x40ae40),('iq4_f3_original_errno_location_03',0x40a4e0)]:
  data=rd(va,16);aliases.append(dict(symbol=symbol,va=va,kind='original imported routine',original_first16_LE=data.hex(),original_first16_sha256=hashlib.sha256(data).hexdigest()))
 exact=json.loads((OUT/'EXACT.json').read_text());hooks=[dict(va=int(q['va'],16),old_hex=q['pre'],original_target=int(q['original_target'],16),target_symbol=q['symbol'])for q in exact['hooks']]
 manifest=row(HERE/'SOURCE_SHA256.json')
 emit(HERE/'LINK_INPUT.json',dict(schema='iq4_stock_jpeg_xqd_link_01',source=manifest,source_manifest=manifest['path'],source_manifest_sha256=manifest['sha256'],objects=build['objects'],BL_hooks=hooks,aliases=aliases,required_functions=['iq4_stock_jpeg_bound_01','iq4_stock_jpeg_destination_get_01','iq4_stock_jpeg_destination_set_01','iq4_stock_jpeg_mode_get_01','iq4_stock_jpeg_mode_set_01','iq4_stock_jpeg_size_get_01','iq4_stock_jpeg_size_set_01'],requires_stock_jpeg_catalog_01=True,stock_quality=90,stock_sizes=['Thumbnail','4K'],raw_path_original=True,camera_accessed=False,target_executed=False))
 print(json.dumps(dict(link=row(HERE/'LINK_INPUT.json'),source=row(HERE/'SOURCE_SHA256.json'),objects=build['objects'])))
if __name__=='__main__':main()
