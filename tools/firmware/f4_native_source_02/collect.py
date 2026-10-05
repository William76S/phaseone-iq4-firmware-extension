#!/usr/bin/env python3
"""Exact unchanged source functions, native ABI and allocation chain only."""
import bisect,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
RAW=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def main():
 raw=RAW.read_bytes();assert len(raw)==11874544 and hashlib.sha256(raw).hexdigest()==SHA
 starts=json.loads((ROOT/'analysis/firmware/unwind_functions.json').read_text())['functions']
 out=ROOT/'analysis/firmware/f4_native_source_02/static';out.mkdir(parents=True,exist_ok=False)
 funcs=[('access_lock',0x6b618c),('access_size',0x6b61fc),('access_unlock',0x6b6250),('access_id',0x6b62c0),
  ('observer_construct',0x70fe3c),('observer_register',0x70fed8),('observer_unregister',0x70ff08),('current_thread',0x710b0c),
  ('event_construct',0x70f12c),('event_notify',0x70f2f8),
  ('queue_register',0x710060),('queue_unregister',0x71015c),('queue_remove_listener',0x7102d0),('video_init',0x793540),
  ('native_lv_start',0x5202a0),('native_lv_paint',0x51da0c),('video_lock',0x6b6a3c),('video_unlock',0x6b6b30),
  ('event_isr_gate',0x7171d0),('event_debug_trace',0x70fafc),('thread_tls_read',0x713f60),
  ('listener_construct',0x710524),('listener_notify',0x710820),('queue_enqueue',0x713c6c),
  ('queue_mark_pending',0x7144a8),('queue_list_append',0x7104d8),('native_list_append',0x70bc18),
  ('listener_from_node',0x6bebc8),('mutex_lock',0x6be844),('mutex_unlock',0x6be880),
  ('unique_lock_construct',0x6becb8),('unique_lock_destroy',0x6bed04),
  ('unique_lock_lock',0x6bedf0),('unique_lock_unlock',0x6bee50),('native_mutex_lock',0x6be92c),
  ('native_mutex_unlock',0x6be964)]
 pins=[];rows=[]
 for name,va in funcs:
  i=bisect.bisect_left(starts,va);assert starts[i]==va;end=starts[i+1];b=raw[va-0x400000:end-0x400000]
  dis=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={va:#x}',f'--stop-address={end:#x}',str(RAW)],text=True)
  (out/(name+'.txt')).write_text('\n'.join(x.rstrip() for x in dis.splitlines())+'\n')
  rows.append(dict(name=name,va=hex(va),end=hex(end),offset=hex(va-0x400000),sha256=hashlib.sha256(b).hexdigest(),hex=b.hex()))
  if name in {'access_lock','access_size','access_unlock','access_id','observer_construct','observer_register','observer_unregister','current_thread','queue_register','queue_unregister','queue_remove_listener','video_lock','video_unlock','event_construct','event_notify','event_isr_gate','event_debug_trace','thread_tls_read','listener_notify','queue_enqueue'}:pins.append((name,va,b))
 for name,va,n in [('pthread_trylock_plt',0x40ae80,16),('pthread_unlock_plt',0x40a730,16),('pthread_create_plt',0x40a220,16),('pthread_join_plt',0x40a8c0,16),('queue_vt',0xb91f48,32),('manager_vt',0xb8f358,32),('lv_vt',0xb9a9d8,32),('access_vt',0xc07da8,32),('frame_event_vt',0xc237a0,32),('observer_rtti',0xc23ab0,16)]:
  b=raw[va-0x400000:va-0x400000+n];pins.append((name,va,b));rows.append(dict(name=name,va=hex(va),end=hex(va+n),offset=hex(va-0x400000),sha256=hashlib.sha256(b).hexdigest(),hex=b.hex()))
 h=['/* Generated from exact original User; function pins, not whole modified-image hash. */','#ifndef IQ4_F4_SOURCE_CODE_PINS_H','#define IQ4_F4_SOURCE_CODE_PINS_H','typedef struct {uintptr_t va;size_t length;const unsigned char*bytes;} Iq4F4Pin02;']
 for i,(name,va,b) in enumerate(pins):h.append('static const unsigned char pin_%d[]={%s};'%(i,','.join('0x%02x'%x for x in b)))
 h.append('static const Iq4F4Pin02 iq4_f4_pins_02[]={')
 for i,(name,va,b) in enumerate(pins):h.append('{0x%x,%d,pin_%d},/* %s */'%(va,len(b),i,name))
 h+=['};','#endif'];(OWN/'code_pins.h').write_text('\n'.join(h)+'\n')
 (out/'EXACT.json').write_text(json.dumps(dict(input_sha256=SHA,windows=rows,production_pin_count=len(pins),camera_access=False,target_executed=False),indent=2)+'\n')
 print('exact windows',len(rows),'production pins',len(pins))
if __name__=='__main__':main()
