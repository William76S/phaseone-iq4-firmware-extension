#!/usr/bin/env python3
"""Finite original A64 ABI/close/catalog/pending proof. No sensor/card IO."""
from pathlib import Path
import json,struct,hashlib
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/stock_new_raw_receipt_55';B=O/'build';U=R/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
b=U.read_bytes();sha=hashlib.sha256(b).hexdigest();assert sha=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);ph=struct.unpack_from('<Q',b,32)[0];sz,nn=struct.unpack_from('<HH',b,54);loads=[]
for i in range(nn):
 t,fl,off,va,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',b,ph+i*sz)
 if t==1:u.mem_map(va&~4095,((va+ms+4095)&~4095)-(va&~4095));u.mem_write(va,b[off:off+fs]);loads.append((va,fs,off))
base=0x28000000;stack=0x30000000;fixture=0x50000000;stop=fixture+0xff0
u.mem_map(base,0x20000);u.mem_map(stack,0x40000);u.mem_map(fixture,0x2000)
ifm=base;cat=base+0x2000;mapping=base+0x3000;entry=base+0x4000;node=base+0x5000;storage=base+0x6000;fs=base+0x7000;file=base+0x8000
trace=[];osclose=1;suppress=False;mutex_depth=0;captureArgs=[];dispatchArgs=[]
def wr(p,n,z=8):u.mem_write(p,int(n).to_bytes(z,'little',signed=False))
def rd(p,z=8):return int.from_bytes(u.mem_read(p,z),'little')
def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
def ret(n=0):u.reg_write(UC_ARM64_REG_X0,n&((1<<64)-1));u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
def hook(uc,pc,n,ctx):
 global mutex_depth
 if pc==stop:u.emu_stop()
 elif pc==0x411bc0:mutex_depth+=1;trace.append(('lock',reg(1)));ret()
 elif pc==0x411bf4:assert mutex_depth>0;mutex_depth-=1;trace.append(('unlock',reg(0)));ret()
 elif pc==0x48f4f0:assert reg(0)==mapping and reg(1)==3;ret(entry)
 elif pc==0x48ae68:assert reg(0)==cat and reg(1)==4;wr(cat+0x1b8,4,4);ret()
 elif pc==0x49037c:ret(7)
 elif pc in [0x40c310,0x40c340,0x70f2f8]:ret()
 elif pc==0x40c8b4:trace.append(('nativeStoredNotification',reg(0),reg(1)));ret()
 elif pc==0x826ca8:assert reg(0)==fs and reg(1)==file and rd(file+0x14,1)==0;trace.append(('nativeFSclose',osclose));ret(osclose)
 elif pc==0x49686c and suppress:
  assert reg(0)==ifm and reg(1)==3 and mutex_depth==0
  trace.append(('extension_callback_fixture_skipBackup',reg(0),reg(1)));u.reg_write(UC_ARM64_REG_PC,pc+4)
 elif pc==fixture+0x100:dispatchArgs.append([reg(i)for i in range(8)]);ret(1)
 elif pc==fixture+0x200:captureArgs.append([reg(i)for i in range(3)]);ret()
 elif pc==0x74654c:raise AssertionError('unexpected native diagnostic')
u.hook_add(UC_HOOK_CODE,hook)
def call(pc,args,end=stop,sp=None):
 for i,n in enumerate(args):u.reg_write(UC_ARM64_REG_X0+i,n)
 u.reg_write(UC_ARM64_REG_SP,sp or stack+0x3e000);u.reg_write(UC_ARM64_REG_LR,stop);u.emu_start(pc,end,count=40000);assert u.reg_read(UC_ARM64_REG_PC)==end,(hex(pc),hex(u.reg_read(UC_ARM64_REG_PC)));return u.reg_read(UC_ARM64_REG_W0)
wr(ifm+0xfa8,cat);wr(cat+0x1b0,mapping);wr(cat+0x1b8,4,4);wr(entry+0x20,node);wr(fs,0xd91450)
close_cases=[]
for osclose in [1,0]:
 trace.clear();call(0x825770,[file]);wr(file+8,fs);wr(file+0x10,77,4);wr(file+0x14,1,1)
 r=call(0x82580c,[file]);assert r==osclose and rd(file+0x14,1)==0
 count=len([q for q in trace if q[0]=='nativeFSclose']);call(0x8257b4,[file]);assert len([q for q in trace if q[0]=='nativeFSclose'])==count==1
 close_cases.append(dict(native_bool=r,open_byte_after=0,original_dtor_does_not_repeat_close=True,trace=list(trace)))
# Execute original SD preparation, replacing ONLY its dispatch instruction with
# a BL to an argument-recorder fixture. X7 remains the actual VT+48 target.
sp=stack+0x3e000;wr(storage,0xdbc6b8);wr(storage+0x2c0,fs);wr(storage+0x2c8,0x11111110);wr(storage+0x2d0,0x22222220);wr(storage+0x2d8,0x33333330);wr(sp+0x28,storage);wr(sp+0x20,node)
old=bytes(u.mem_read(0x8e0618,4));delta=fixture+0x100-0x8e0618
# Fixture must be in branch reach for a genuine BL; use a nearby RX pad.
pad=0x4300000;u.mem_map(pad,0x1000);dispatch_stub=pad;u.mem_write(dispatch_stub,struct.pack('<I',0xd65f03c0));delta=dispatch_stub-0x8e0618
u.mem_write(0x8e0618,struct.pack('<I',0x94000000|((delta//4)&0x3ffffff)))
def record_dispatch(uc,pc,n,ctx):
 if pc==dispatch_stub:dispatchArgs.append([reg(i)for i in range(8)]);ret(1)
u.hook_add(UC_HOOK_CODE,record_dispatch)
call(0x8e05c4,[],0x8e061c,sp);assert dispatchArgs[-1]==[storage,node,fs,0x11111110,0x22222220,0x33333330,sp+0x40,0x8dcf98];u.mem_write(0x8e0618,old)
# Original UI inserts the SAME capture node into new catalog slot+20 and
# writes that slot's index into node+D8. Allocation/map are finite fixtures.
trace.clear();wr(cat+0x1b8,3,4);wr(entry+0x10,0,2);wr(sp+0x28,cat);wr(sp+0x58,node)
call(0x492654,[],0x4926f8,sp);assert rd(entry+0x20)==node and rd(node+0xd8,4)==3 and rd(entry+0x10,2)==2 and mutex_depth==1
# Stop before the rest of original UI; its actual later unlock is outside
# this evidence slice. Reset the fixture depth for independent stored cases.
mutex_depth=0
pending=[]
for flags,suppress in [(2,False),(2,True),(4,False)]:
 trace.clear();wr(entry+0xe,0,1);wr(entry+0x10,2,2);wr(ifm+0xfb4,1,1);wr(ifm+0xfb5,1,1);wr(cat+0x1b8,4,4)
 call(0x496784,[ifm,3,flags]);want=3|(0x80 if flags==2 and not suppress else 0)|(0x100 if flags==2 else 0)
 assert rd(entry+0x10,2)==want and rd(entry+0xe,1)==flags and mutex_depth==0
 pending.append(dict(flags=flags,backup_suppression_fixture=suppress,pending_after=want,raw_presence=flags,trace=list(trace)))
# Relocate the actual tiny enqueue wrapper object; only its downstream C body
# is trapped here. The production C++ body is separately host/file tested.
q=(B/'wrappers.o').read_bytes();shoff=struct.unpack_from('<Q',q,40)[0];esz,num,names=struct.unpack_from('<HHH',q,58);sections=[struct.unpack_from('<IIQQQQIIQQ',q,shoff+i*esz)for i in range(num)]
s=next(s for s in sections if s[2]&4 and s[5]);code=q[s[4]:s[4]+s[5]];assert code[:4]==bytes.fromhex('e20313aa') and len(code)==8
addr=pad+0x100;u.mem_write(addr,code[:4]+struct.pack('<I',0x14000000|(((pad+0x200-(addr+4))//4)&0x3ffffff)))
def record_capture(uc,pc,n,ctx):
 if pc==pad+0x200:captureArgs.append([reg(i)for i in range(3)]);ret()
u.hook_add(UC_HOOK_CODE,record_capture);u.reg_write(UC_ARM64_REG_X19,base+0x11000);call(addr,[base+0x12000,node]);assert captureArgs==[[base+0x12000,node,base+0x11000]]
result=dict(schema='iq4_new_RAW_55_original_A64_ABI',input_sha256=sha,wrapper_object_sha256=hashlib.sha256(q).hexdigest(),close_cases=close_cases,sd_dispatch_args=[hex(v)for v in dispatchArgs[-1]],same_UI_capture_node=dict(node=hex(node),slot20=hex(rd(entry+0x20)),node_D8=rd(node+0xd8,4)),pending_cases=pending,enqueue_args=[hex(v)for v in captureArgs[0]],original_code_executed=['825770 File ctor','82580c checked close','8257b4 File dtor','8e05c4..618 SD original argument preparation','492654..6f8 original UI node/index assignment','8c322c native index setter','496784 original stored flags','4989c0/498994 pending wrappers','49752c pending lock wrapper','487818 original pending OR','target enqueue wrapper machine code'],fixtures=['catalog allocator and map lookup','native mutex boundaries','native FS close bool','event notification boundaries','extension backup callback trap; production callback NOT A64-executed','SD C++ dispatch body trap; production body separately host-tested','enqueue C++ body trap; production body separately host-tested'],full_RAW_pixels_executed=False,physical_cards_accessed=False,camera_accessed=False)
(O/'NATIVE_A64.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS finite actual A64 File lifecycle, SD X7 ABI, capture-node catalog identity, pending masks, linked enqueue wrapper; fixtures explicit')
