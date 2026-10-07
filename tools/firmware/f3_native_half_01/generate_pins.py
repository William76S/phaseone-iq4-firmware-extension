#!/usr/bin/env python3
from pathlib import Path
import hashlib,importlib.util,json,struct
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
s=importlib.util.spec_from_file_location('exact',ROOT/'tools/firmware/f3_render_plan_01/collect_static.py');e=importlib.util.module_from_spec(s);s.loader.exec_module(e)
WINDOWS=[
('request_identity',0x48c880,0x48c8f4),('catalog_photo_index',0x48da44,0x48da5c),
('queue_to_worker_request',0x490098,0x4900d0),('request_assignment',0x48fea8,0x48ff8c),
('worker_request',0x7b74bc,0x7b74f0),('worker_profile',0x7b7a14,0x7b7ad0),('worker_preview',0x7b7df8,0x7b7ed4),
('preview_source_gate',0x963a28,0x963b10),('preview_whole_reader',0x963cc4,0x963d80),('preview_half_dispatch',0x963dd0,0x963eac),
('preview_half_core',0x9647ec,0x964870),('core_input_allocation',0x919d58,0x919f78),('core_scratch',0x91a160,0x91a19c),
('core_join',0x91a77c,0x91a7a0),('core_terminal',0x91a92c,0x91a978),('core_capacity_failure',0x91ae58,0x91af20),
('cib_getters',0x904348,0x904480),('cib_reset',0x904550,0x9045a0),('cib_destroy',0x903ca8,0x903d10),
('whole_reader_geometry',0x922170,0x9222e0),('generator_capacity',0x9621e4,0x962204),('processing_worker_vtable',0xd854c8,0xd854f0)]

def main():
 im=e.ExactImage(e.ORIGINAL);chunks=[];records=[]
 for name,lo,hi in WINDOWS:
  off,b=im.get(lo,hi-lo);chunks.append(f'static const unsigned char half_pin_{name}[] = {{'+','.join(f'0x{x:02x}' for x in b)+'};')
  records.append(dict(name=name,va=hex(lo),end=hex(hi),offset=hex(off),bytes=len(b),hex=b.hex(),sha256=hashlib.sha256(b).hexdigest()))
 chunks+=['struct Iq4HalfPin01 { uintptr_t va; size_t bytes; const unsigned char*data; };','static const Iq4HalfPin01 iq4_half_pins_01[] = {']
 chunks+=[f'{{{hex(lo)},sizeof half_pin_{name},half_pin_{name}}},' for name,lo,hi in WINDOWS];chunks+=['};']
 (HERE/'pins.h').write_text('#ifndef IQ4_NATIVE_HALF_PINS_01\n#define IQ4_NATIVE_HALF_PINS_01\n#include <stdint.h>\n#include <stddef.h>\n'+'\n'.join(chunks)+'\n#endif\n')
 hooks=[]
 for va,to,symbol in [(0x7b7ed0,0x963a28,'iq4_half_preview_wrapper_01'),(0x91a78c,0x716e60,'iq4_half_join_wrapper_01'),(0x91a964,0x40a8f0,'iq4_half_terminal_wrapper_01')]:
  _,b=im.get(va,4);w=struct.unpack('<I',b)[0];i=w&0x3ffffff;i=i-0x4000000 if i&0x2000000 else i
  assert w&0xfc000000==0x94000000 and va+4*i==to
  hooks.append(dict(va=va,original_target=to,old_hex=b.hex(),target_symbol=symbol))
 (HERE/'PINS.json').write_text(json.dumps(dict(stock_sha256=hashlib.sha256(e.ORIGINAL.read_bytes()).hexdigest(),windows=records,replace_BL_hooks=hooks,transparent_existing_hooks=[0x963d28,0x964860]),indent=2)+'\n')
 print('half',sum(x['bytes'] for x in records),'original bytes',len(hooks),'BL hooks')
if __name__=='__main__':main()
