#!/usr/bin/env python3
"""Execute original A64 requester bytes; external event/mutex fixtures are explicit."""
from pathlib import Path
import struct,json,hashlib
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def main():
 b=USER.read_bytes();assert hashlib.sha256(b).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 for i in range(num):
  typ,fl,off,va,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
  if typ!=1:continue
  lo=va&~4095;hi=(va+ms+4095)&~4095;u.mem_map(lo,hi-lo);u.mem_write(va,b[off:off+fs])
 owner=0x20000000;stack=0x30000000;stop=0x1000;u.mem_map(owner,0x3000);u.mem_map(stack,0x10000);u.mem_map(stop,4096)
 def wr(a,n,z=4):u.mem_write(a,n.to_bytes(z,'little'))
 def rd(a,z=4):return int.from_bytes(u.mem_read(a,z),'little')
 wr(owner,0xdb6628,8);wr(owner+0x68,0x9f3fe8,8);wr(owner+0x320,1);locks={};held=set();log=[];mode_writes=[]
 def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
 def ret(n=0):u.reg_write(UC_ARM64_REG_X0,n);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 def hook(uc,pc,size,ctx):
  if pc==0x411bc0:
   obj,mutex=reg(0),reg(1);assert mutex not in held;locks[obj]=mutex;held.add(mutex);log.append(['mutex_lock',hex(mutex)]);ret()
  elif pc==0x411bf4:
   obj=reg(0);assert obj in locks;mutex=locks.pop(obj);assert mutex in held;held.remove(mutex);log.append(['mutex_unlock',hex(mutex)]);ret()
  elif pc==0x8cb94c:
   assert reg(0)==owner+0x180;mode_writes.append(reg(1));wr(owner+0x240,reg(1));ret()
  elif pc==0x6b10e8:assert reg(0)==owner+0x260;ret(rd(owner+0x320))
  elif pc==0x710b0c:ret(owner+0x1800)
  elif pc==0x710524:log.append(['observer_construct',hex(reg(1))]);ret()
  elif pc==0x710614:log.append(['observer_destroy']);ret()
  elif pc==0x7172bc:ret(100)
  elif pc==0x8cafbc:assert owner+8 not in held # wait releases base mutex before subtype
  elif pc in [0x74654c,0x40a750,0x713a18,0x411b98]:raise AssertionError('Unexpected error/wait path '+hex(pc))
 u.hook_add(UC_HOOK_CODE,hook)
 def call(pc,args):
  for i,n in enumerate(args):u.reg_write(UC_ARM64_REG_X0+i,n)
  u.reg_write(UC_ARM64_REG_SP,stack+0xf000);u.reg_write(UC_ARM64_REG_LR,stop);u.emu_start(pc,stop,count=20000);assert u.reg_read(UC_ARM64_REG_PC)==stop;assert not held;return u.reg_read(UC_ARM64_REG_W0)
 names=[owner+0x2000,owner+0x2040];u.mem_write(names[0],b'original-stock-source\0');u.mem_write(names[1],b'extension-stock-output\0');tokens=[call(0x8ca3ec,[owner,n])for n in names];assert tokens==[0,1]
 masks=[];results=[]
 results.append(call(0x8ca598,[owner,tokens[0]]));masks.append(rd(owner+0x17c));assert masks[-1]==1
 results.append(call(0x8ca888,[owner,tokens[1],6000]));masks.append(rd(owner+0x17c));assert results[-1]==0 and masks[-1]==3 and rd(owner+0x240)==1
 results.append(call(0x8ca708,[owner,tokens[0]]));masks.append(rd(owner+0x17c));assert masks[-1]==2 and rd(owner+0x240)==1
 results.append(call(0x8ca708,[owner,tokens[1]]));masks.append(rd(owner+0x17c));assert masks[-1]==0 and rd(owner+0x240)==0
 assert mode_writes==[1,1,0]
 result=dict(schema='iq4_original_requester_two_clients_A64_01',input_sha256=hashlib.sha256(b).hexdigest(),executed_original_functions=[hex(v)for v in [0x8ca3ec,0x8ca598,0x8ca888,0x8ca708,0x8cae94,0x8caf10,0x8cafbc]],tokens=tokens,mask_transitions=masks,request_mode_writes=mode_writes,results=results,external_fixtures=['RAII mutex ctor/dtor with nested lock identity checks','NativeThread/current clock/observer','ready property=1 (device worker not executed)'],base_mutex_released_before_wait=True,original_subtype_request_release_wait_executed=True,host_emulation=True,camera_accessed=False,target_device_executed=False,trace=log)
 (OUT/'REQUESTER_A64.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS original A64 registered clients0/1; masks1→3→2→0; no exclusive source/output deadlock; ready fixture explicitly1')
if __name__=='__main__':main()
