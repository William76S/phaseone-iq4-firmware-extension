#!/usr/bin/env python3
import bisect,hashlib,json,subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];OWN=Path(__file__).resolve().parent
def main():
 p=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';raw=p.read_bytes();assert hashlib.sha256(raw).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 starts=json.loads((ROOT/'analysis/firmware/unwind_functions.json').read_text())['functions'];out=ROOT/'analysis/firmware/f4_native_menu_03/static';out.mkdir(parents=True,exist_ok=False)
 rows=[];pins=[]
 for name,va in [('submenu_ctor',0x4e5744),('submenu_append',0x4e58b8),('event_item_ctor',0x4e9d30),('current_thread',0x710b0c),('dialog_close',0x4e1320),('navigator_pop',0x4e7ca4),('navigator_pop_body',0x4e74a8),('navigator_current',0x4e7628),('selector_set_menu',0x4fb364),('selector_key_handler',0x4fb3f0),('navigator_activate',0x4e7ce4)]:
  i=bisect.bisect_left(starts,va);assert starts[i]==va;end=starts[i+1];b=raw[va-0x400000:end-0x400000]
  if name=='selector_key_handler':
   # This added callsite is patched by the integrating ELF backend. Every
   # other original instruction stays pinned; never expect old BL at runtime.
   pins.append((name+'_before_own_BL',va,b[:0x4fb454-va]));pins.append((name+'_after_own_BL',0x4fb458,b[0x4fb458-va:]))
  else:pins.append((name,va,b))
  text=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',f'--start-address={va:#x}',f'--stop-address={end:#x}',str(p)],text=True)
  (out/(name+'.txt')).write_text('\n'.join(x.rstrip() for x in text.splitlines())+'\n');rows.append(dict(name=name,va=hex(va),end=hex(end),offset=hex(va-0x400000),hex=b.hex(),sha256=hashlib.sha256(b).hexdigest()))
 # Complete tables copied, including native change-event slot +70.
 for name,va,n in [('submenu_table',0xb8f9a8,24*8),('event_item_table',0xb90738,22*8),('new_plt',0x409e60,16)]:
  b=raw[va-0x400000:va-0x400000+n];pins.append((name,va,b));rows.append(dict(name=name,va=hex(va),end=hex(va+n),hex=b.hex(),sha256=hashlib.sha256(b).hexdigest()))
 h=['#ifndef IQ4_F4_MENU_CODE_PINS_H','#define IQ4_F4_MENU_CODE_PINS_H','typedef struct{uintptr_t va;size_t length;const unsigned char*bytes;}Iq4F4MenuPin03;']
 for i,(name,va,b) in enumerate(pins):h.append('static const unsigned char pin_%d[]={%s};'%(i,','.join('0x%02x'%x for x in b)))
 h.append('static const Iq4F4MenuPin03 iq4_f4_menu_pins_03[]={')
 for i,(name,va,b) in enumerate(pins):h.append('{0x%x,%d,pin_%d},/*%s*/'%(va,len(b),i,name))
 h+=['};','#endif'];(OWN/'code_pins.h').write_text('\n'.join(h)+'\n')
 patches=[]
 for va,target,name in [(0x4eea58,0x4fb364,'shared LiveView Settings menu entry'),(0x4fb454,0x4e7ca4,'native Back current submenu pop')]:
  b=raw[va-0x400000:va-0x400000+4];ins=int.from_bytes(b,'little');off=ins&0x3ffffff;off=off-(1<<26) if off&(1<<25) else off;assert ins>>26==0x25 and va+off*4==target
  patches.append(dict(name=name,va=hex(va),original_target=hex(target),original_bytes_le=b.hex()))
 (out/'EXACT.json').write_text(json.dumps(dict(windows=rows,patch_candidates=patches,production_pin_excludes=[{'va':'0x4fb454','length':4,'reason':'own Back wrapper BL, whole candidate identity is Root integration responsibility'}],field_contract={'selector_navigator':hex(0x128),'navigator_depth':hex(0x348),'navigator_current_stack':hex(0x308),'depth_max':7},camera_access=False,target_executed=False),indent=2)+'\n')
 print('menu exact',len(rows),'patch candidates',patches)
if __name__=='__main__':main()
