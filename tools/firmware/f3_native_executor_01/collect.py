#!/usr/bin/env python3
import hashlib,json,pathlib,subprocess,struct
ROOT=pathlib.Path(__file__).resolve().parents[3]
HERE=pathlib.Path(__file__).resolve().parent
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
WINDOWS=[('Native_background_constructor',0x49d688,0x49d724),
 ('Native_background_run',0x49d7c0,0x49e1e0),('Native_listener_constructor',0x710524,0x710614),
 ('Native_listener_register',0x71068c,0x710718),('Native_queue_wait',0x71384c,0x7139ac),
 ('Native_listener_consume',0x710864,0x710880),('Native_pending_read',0x714490,0x7144a8),
 ('Native_selected_integer_getter',0x40c880,0x40c8b4),
 ('Actual_IFM_outer_construct_store',0x4872b4,0x4872d8),
 ('Actual_outer_selected_event_ctor',0x4959ec,0x495a34),
 ('Actual_outer_IFM_field',0x495c58,0x495c78),
 ('Native_background_vtable_RTTI',0xb805b0,0xb80610),
 ('Native_event_ctor',0x70f12c,0x70f208),('Native_event_notify',0x70f2f8,0x70f4e4),
 ('Native_current_thread',0x710b0c,0x710b20),('Native_TLS_current_thread',0x713f60,0x713f74),
 ('Original_pthread_self_PLT',0x40b1d0,0x40b1e0),
 ('Original_stock_JPEG_call',0x49dd98,0x49ddfc)]
PINS=[(0x49d688,32),(0x49d7c0,32),(0x710524,32),(0x71384c,32),
 (0x710864,28),(0x40c880,32),(0x70f12c,32),(0x70f2f8,32),
 (0xb805b0,40),(0xb7f950,32),(0xb7ecd0,32),
 (0x710b0c,20),(0x713f60,20),(0x40b1d0,16)]
def main():
 b=USER.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
 dest=ROOT/'analysis/firmware/f3_native_executor_static_01';dest.mkdir(parents=True,exist_ok=True)
 rows=[]
 for name,a,z in WINDOWS:
  raw=b[a-0x400000:z-0x400000];assert len(raw)==z-a
  argv=['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={a}',f'--stop-address={z}',str(USER)]
  r=subprocess.run(argv,capture_output=True,text=True,check=True)
  text='\n'.join(x.rstrip() for x in r.stdout.splitlines())+'\n'
  out=dest/(name+'.asm');out.write_text(text)
  rows.append(dict(name=name,start=a,end=z,offset=a-0x400000,bytes_hex=raw.hex(),sha256=hashlib.sha256(raw).hexdigest(),assembly_sha256=hashlib.sha256(out.read_bytes()).hexdigest()))
 header=['#ifndef IQ4_F3_EXECUTOR_PINS_01_H','#define IQ4_F3_EXECUTOR_PINS_01_H','#include <stdint.h>','#include <stddef.h>',
 'struct F3ExecutorPin01 {uintptr_t va;size_t length;const unsigned char*bytes;};']
 for k,(a,n) in enumerate(PINS):
  raw=b[a-0x400000:a-0x400000+n]
  header.append('static const unsigned char iq4_f3_executor_pin_%d[]={%s};'%(k,','.join('0x%02x'%x for x in raw)))
 header.append('static const F3ExecutorPin01 iq4_f3_executor_pins_01[]={')
 for k,(a,n) in enumerate(PINS):header.append('{0x%x,%d,iq4_f3_executor_pin_%d},'%(a,n,k))
 header+=['};','#endif']
 (HERE/'pins.h').write_text('\n'.join(header)+'\n')
 (dest/'EXACT.json').write_text(json.dumps(dict(schema='iq4_f3_native_executor_exact_v1',user=dict(path=str(USER.relative_to(ROOT)),bytes=len(b),sha256=SHA),windows=rows,patch=dict(va=0x49d9d0,old_hex=b[0x9d9d0:0x9d9d4].hex(),target=0x71384c,return_pc=0x49d9d4),level='static_only',target_executed=False),indent=2)+'\n')
 print(json.dumps({'windows':len(rows),'pins':len(PINS),'target_executed':False}))
if __name__=='__main__':main()
