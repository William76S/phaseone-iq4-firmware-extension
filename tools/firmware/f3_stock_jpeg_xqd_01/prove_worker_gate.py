#!/usr/bin/env python3
"""Execute original worker admission and native Mode/Size getters, not a device run."""
from pathlib import Path
import struct,json,hashlib
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE,UC_HOOK_MEM_READ
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def main():
 b=USER.read_bytes();sha=hashlib.sha256(b).hexdigest();assert sha=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 for i in range(num):
  typ,fl,off,va,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
  if typ==1:u.mem_map(va&~4095,((va+ms+4095)&~4095)-(va&~4095));u.mem_write(va,b[off:off+fs])
 task=0x20000000;group=0x28000000;ifm=0x29000000;sd_power=0x2a000000;stack=0x30000000;timer=0x2b000000
 for a,n in [(task,0x1000),(task+0x6400000,0x1000),(group,0x3000),(ifm,0x2000),(sd_power,0x1000),(timer,0x1000),(stack,0x10000)]:u.mem_map(a,n)
 def wr(a,n,z=4):u.mem_write(a,n.to_bytes(z,'little'))
 def rd(a,z=4):return int.from_bytes(u.mem_read(a,z),'little')
 def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
 def ret(n=0):u.reg_write(UC_ARM64_REG_X0,n);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 sp=stack+0xf000;wr(task+0x1c8,group,8);wr(task+0x1d0,ifm,8);wr(task+0x1d8,sd_power,8);wr(sd_power+0x178,1,1)
 # SD present property memory remains zero. Its exact layout is not needed:
 # read tracing confirms admission never accesses that whole native property.
 trace=[];jobs=[];reads=[];phase=''
 def read(uc,access,a,size,value,ctx):
  if group<=a<group+0x3000 or sd_power<=a<sd_power+0x1000:reads.append([hex(a),size])
 def hook(uc,pc,size,ctx):
  if pc in (0x8e111c,0x8e0c28):u.emu_stop()
  elif pc in (0x40c310,0x40c340,0x74649c):ret()
  elif pc==0x8e2628:assert reg(0)==ifm and reg(1)==1;trace.append(['native_enable',reg(1)]);ret()
  elif pc==0x8e2590:assert reg(0)==ifm;ret(1)
  elif pc==0x4175a8:assert reg(0)==group+0x1070;ret()
  elif pc==0x8e2600:assert reg(0)==ifm;trace.append(['catalog_pending',reg(1)]);ret(7)
  elif pc in (0x8e1264,0x8e17c8):assert reg(0)==task and reg(1)==7;jobs.append(hex(pc));u.emu_stop()
  elif pc in (0x41497c,0x525034):raise AssertionError('SD presence/free space reached before job')
 u.hook_add(UC_HOOK_CODE,hook);u.hook_add(UC_HOOK_MEM_READ,read)
 def execute(pc):u.reg_write(UC_ARM64_REG_SP,sp);u.emu_start(pc,0,count=5000);assert u.reg_read(UC_ARM64_REG_PC) in (0x8e111c,0x8e0c28,0x8e1264,0x8e17c8)
 cases=[]
 for mode,size in [(1,0),(1,1),(2,0),(2,1),(0,0),(0,1)]:
  trace.clear();jobs.clear();reads.clear();wr(sp+0x28,task,8);wr(sp+0x30,timer,8);wr(sp+0x40,timer,8)
  wr(group+0xe8+0xc0,mode);wr(group+0x2a8+0xc0,size)
  if mode:
   execute(0x8e0d34);assert rd(task+0x1c0)==mode and u.reg_read(UC_ARM64_REG_PC)==0x8e111c
  else:wr(task+0x1c0,mode)
  execute(0x8e0e64);expected=[] if not mode else [hex(0x8e1264 if size==0 else 0x8e17c8)];assert jobs==expected
  assert all(not(group+0x468<=int(a,16)<group+0x518 or sd_power<=int(a,16)<sd_power+0x1000)for a,z in reads)
  cases.append(dict(mode=mode,size=size,sd_presence=0,sd_requester_disabled=1,entered_native_job=jobs,native_property_read_offsets=[hex(int(a,16)-group)for a,z in reads],trace=list(trace)))
 out=dict(schema='iq4_stock_worker_admission_original_A64_01',input_sha256=sha,executed_original_windows=['0x8e0d34..0x8e0e60 native Mode notification','0x8e0e64..0x8e0f58 timer admission','0x5e8c20 native Mode getter','0x5e7350 native Size getter'],cases=cases,fixtures=['thread event already dequeued','native event guard ctor/dtor','logging','IFM pending index=7 / enable / count / display notification'],not_executed=['thread dequeue infrastructure','actual catalog/source read','JPEG decoder/encoder','device/card hardware'],no_SD_presence_or_disabled_gate_before_job=True,camera_accessed=False,target_device_executed=False)
 (OUT/'WORKER_GATE_A64.json').write_text(json.dumps(out,indent=2)+'\n');print('PASS original worker New/All + Thumbnail/4K enter jobs with SD absent/disabled; Off does not enter')
if __name__=='__main__':main()
