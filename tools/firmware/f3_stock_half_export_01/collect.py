#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_half_export_54';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def main():
 OUT.mkdir(parents=True,exist_ok=True);b=USER.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
 phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 def raw(va,n):
  for i in range(num):
   typ,fl,off,a,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
   if typ==1 and a<=va and va+n<=a+fs:return b[off+va-a:off+va-a+n]
  raise AssertionError(hex(va))
 windows=[('MainProcessingWorker600',0x422e78,28),('CatalogIndexBoundsAndMap',0x4961ec,92),
          ('CatalogSlot40Bytes',0x48f4f0,52),('NativeWaitArgumentsBeforeHook',0x8e1968,24),
          ('NativeFreshObserverCtor',0x710524,96),('NativeOwnReadyReader',0x714490,40),
          ('NativeWorkerVTable',0xd854c8,32)]
 lines=['#ifndef IQ4_STOCK_HALF_CORE_PINS_01_H','#define IQ4_STOCK_HALF_CORE_PINS_01_H',
  '#include <stdint.h>','#include <stddef.h>',
  'struct HalfCorePin01{uintptr_t va;size_t bytes;const unsigned char*data;};']
 pins=[]
 for i,(name,va,n)in enumerate(windows):
  data=raw(va,n);lines.append('static const unsigned char HalfCoreBytes%u[]={%s};'%(i,','.join('0x%02x'%v for v in data)))
  pins.append(dict(name=name,va=va,bytes=n,hex=data.hex(),sha256=hashlib.sha256(data).hexdigest()))
  asm=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',
   '--start-address='+hex(va),'--stop-address='+hex(va+n),str(USER)],text=True,capture_output=True,check=True)
  (OUT/(name+'.asm')).write_text(asm.stdout)
 lines.append('static const HalfCorePin01 HalfCorePins01[]={')
 lines.extend('{0x%x,%u,HalfCoreBytes%u},'%(va,n,i)for i,(_,va,n)in enumerate(windows));lines+=['};','#endif']
 (HERE/'half_pins.h').write_text('\n'.join(lines)+'\n')
 # Derive the already validated stock windows, adding only this release's
 # wait call to their exclusions. Frozen 52 pins are never edited or consumed
 # whole by the 54 runtime.
 stock=json.loads((ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01/EXACT.json').read_text())
 assert stock['input']['sha256']==SHA
 exclusions=sorted({int(q['va'],16)for q in stock['hooks']}|{0x8e1980})
 stock_lines=['#ifndef IQ4_STOCK_HALF_STOCK_PINS_54_H','#define IQ4_STOCK_HALF_STOCK_PINS_54_H',
  '#include <stdint.h>','#include <stddef.h>',
  'struct StockHalfStockPin54{uintptr_t va;size_t bytes;const unsigned char*data;};']
 stock_pins=[]
 for window in stock['windows']:
  if window['name'].endswith('_fs_record'):continue
  lo=int(window['va'],16);hi=lo+window['bytes'];assert raw(lo,hi-lo).hex()==window['hex']
  inside=[v for v in exclusions if lo<=v<hi]
  for a,z in zip([lo]+[v+4 for v in inside],inside+[hi]):
   if a>=z:continue
   data=raw(a,z-a);i=len(stock_pins)
   stock_lines.append('static const unsigned char StockHalfStockBytes54_%u[]={%s};'%(i,','.join('0x%02x'%v for v in data)))
   stock_pins.append(dict(va=a,bytes=z-a,hex=data.hex(),sha256=hashlib.sha256(data).hexdigest()))
 stock_lines.append('static const struct StockHalfStockPin54 StockHalfStockPins54[]={'+
  ','.join('{0x%x,%u,StockHalfStockBytes54_%u}'%(q['va'],q['bytes'],i)for i,q in enumerate(stock_pins))+'};')
 stock_lines.append('#endif');(HERE/'stock_pins_54.h').write_text('\n'.join(stock_lines)+'\n')
 hook=dict(va=0x8e1980,old_hex=raw(0x8e1980,4).hex(),original_target=0x713a18,target_symbol='iq4_stock_half_ifm_wait_02')
 word=int.from_bytes(bytes.fromhex(hook['old_hex']),'little');delta=word&0x3ffffff
 if delta&(1<<25):delta-=1<<26
 assert word>>26==0b100101 and hook['va']+4*delta==hook['original_target']
 (OUT/'EXACT.json').write_text(json.dumps(dict(schema='iq4_stock_half_core_exact_54',
  original_user_sha256=SHA,pins=pins,stock_pins=stock_pins,stock_pin_exclusions=exclusions,
  wait_hook=hook,camera_accessed=False),indent=2)+'\n')
 print('PASS exact original catalog/Main600/fresh-observer/wait bindings')
if __name__=='__main__':main()
