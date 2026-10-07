#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
# Windows intentionally exclude changed BL words from runtime pins.
WINDOWS={'main_bind':(0x424b80,0x424be8),'ctor':(0x8e0928,0x8e0aa8),'preflight':(0x8e1180,0x8e1264),'thumbnail':(0x8e1264,0x8e17c8),'preview4k':(0x8e17c8,0x8e1d70),'writer':(0x8e1d70,0x8e1f7c),'choose':(0x8e1f7c,0x8e22d4),'registry_factory':(0x74e454,0x74e5a8),'fs_resolver':(0x827348,0x827804),'linux_open':(0x825ed4,0x826010),'linux_close':(0x826ca8,0x826d6c),'register_client':(0x8ca3ec,0x8ca4c4),'request':(0x8ca598,0x8ca708),'release':(0x8ca708,0x8ca870),'wait_request':(0x8ca888,0x8caa30),'async_request_release':(0x8cae94,0x8cafbc),'async_wait':(0x8cafbc,0x8cb198),'jpeg_mode':(0x5e8c20,0x5e8cd4),'jpeg_size':(0x5e7350,0x5e7404),'sd_fs_record':(0xf55e18,0xf55e38),'xqd_fs_record':(0xf55e38,0xf55e58),'catalog_clear':(0x493994,0x493a10),'jpeg_scan_name':(0xb7e920,0xb7e928),'fs_vt':(0xd91440,0xd915a0),'requester_vt':(0xdb6618,0xdb6670),'encoder_vt':(0xdce0f0,0xdce130),'mode_names':(0xdbcd38,0xdbce28)}
HOOKS=[(0x424bcc,0x8e0928,'iq4_stock_jpeg_ctor_wrapper_01'),(0x8e0f44,0x8e1264,'iq4_stock_jpeg_thumbnail_01'),(0x8e0f58,0x8e17c8,'iq4_stock_jpeg_4k_01'),(0x8e119c,0x41497c,'iq4_stock_jpeg_presence_01'),(0x8e11fc,0x525034,'iq4_stock_jpeg_free_space_01'),(0x8e1610,0x8e1d70,'iq4_stock_jpeg_encode_write_01'),(0x8e1b78,0x8e1d70,'iq4_stock_jpeg_encode_write_01')]
def main():
 b=USER.read_bytes();assert len(b)==11874544 and hashlib.sha256(b).hexdigest()==SHA
 phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54);segments=[]
 for i in range(num):
  typ,fl,off,va,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
  if typ==1:segments.append((va,va+fs,off))
 def bytes_(a,z):
  for lo,hi,off in segments:
   if lo<=a<=z<=hi:return b[off+a-lo:off+z-lo]
  raise ValueError(hex(a))
 OUT.mkdir(parents=True,exist_ok=True);h=['#ifndef IQ4_STOCK_JPEG_PINS_H','#define IQ4_STOCK_JPEG_PINS_H','#include <stdint.h>','#include <stddef.h>','struct StockJpegPin01 {uintptr_t va;size_t bytes;const unsigned char *data;};'];rows=[];pins=[]
 excluded={x[0] for x in HOOKS};# Dynamic registry owner words are deliberately not pinned.
 for name,(a,z) in WINDOWS.items():
  data=bytes_(a,z);rows.append(dict(name=name,va=hex(a),bytes=len(data),sha256=hashlib.sha256(data).hexdigest(),hex=data.hex()))
  if name.endswith('_fs_record'):continue
  starts=[a]+[v+4 for v in sorted(excluded)if a<=v<z];ends=[v for v in sorted(excluded)if a<=v<z]+[z]
  for lo,hi in zip(starts,ends):
   if lo>=hi:continue
   p=bytes_(lo,hi);ix=len(pins);h.append('static const unsigned char StockJpegBytes%u[]={%s};'%(ix,','.join('0x%02x'%v for v in p)));pins.append((lo,len(p),ix))
  if name not in ['fs_vt','requester_vt','encoder_vt','mode_names','sd_fs_record','xqd_fs_record']:
   q=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={a}',f'--stop-address={z}',str(USER)],capture_output=True,text=True,check=True);(OUT/(name+'.asm')).write_text(q.stdout)
 h.append('static const struct StockJpegPin01 StockJpegPins01[]={'+','.join('{0x%x,%u,StockJpegBytes%u}'%x for x in pins)+'};\n#endif\n');(HERE/'pins.h').write_text('\n'.join(h))
 hookrows=[]
 for va,target,symbol in HOOKS:
  pre=bytes_(va,va+4);word=struct.unpack('<I',pre)[0];disp=word&0x3ffffff;disp=disp-(1<<26)if disp&(1<<25)else disp;assert word>>26==0x25 and va+disp*4==target,(hex(va),hex(va+disp*4));hookrows.append(dict(va=hex(va),pre=pre.hex(),original_target=hex(target),symbol=symbol,kind='call'))
 exact=dict(schema='iq4_stock_jpeg_xqd_exact_01',input=dict(path=str(USER.relative_to(ROOT)),bytes=len(b),sha256=SHA),windows=rows,hooks=hookrows,pin_excludes=[hex(v)for v in sorted(excluded)],camera_accessed=False)
 (OUT/'EXACT.json').write_text(json.dumps(exact,indent=2)+'\n');(HERE/'HOOKS.json').write_text(json.dumps(hookrows,indent=2)+'\n');print('Bound original SHA; seven exact BL hooks; mutable registry owner words excluded.')
if __name__=='__main__':main()
