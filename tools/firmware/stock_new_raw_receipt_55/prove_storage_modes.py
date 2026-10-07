#!/usr/bin/env python3
"""Finite original storage policy A64 trace; external infrastructure is fixture-only."""
from pathlib import Path
import hashlib,json,struct
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *

ROOT=Path(__file__).resolve().parents[3]
OUT=ROOT/'analysis/firmware/stock_new_raw_receipt_55'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'

def main():
 b=USER.read_bytes();assert len(b)==11874544 and hashlib.sha256(b).hexdigest()==SHA
 u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);loads=[]
 phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 for i in range(num):
  typ,fl,off,va,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
  if typ==1:
   u.mem_map(va&~4095,((va+ms+4095)&~4095)-(va&~4095));u.mem_write(va,b[off:off+fs]);loads.append((va,fs,off,fl))
 def raw(va,n):
  for v,fs,o,fl in loads:
   if v<=va and va+n<=v+fs:return b[o+va-v:o+va-v+n]
  raise AssertionError(hex(va))
 base=0x28000000;stack=0x30000000;fixture=0x50000000
 u.mem_map(base,0x10000);u.mem_map(stack,0x10000);u.mem_map(fixture,0x1000)
 observer=base;vm=base+0x1000;display=base+0x2000;camera=base+0x3000
 mode=base+0x4000;backup=base+0x5000;xqd=base+0x6000;sd=base+0x7000;host=base+0x8000
 def wr(a,v,z=8):u.mem_write(a,v.to_bytes(z,'little'))
 def rd(a,z=8):return int.from_bytes(u.mem_read(a,z),'little')
 def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
 def ret(v=0):u.reg_write(UC_ARM64_REG_X0,v);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 for off,v in ((0x18,vm),(0x20,display),(0x28,camera)):wr(observer+off,v)
 for off,v in ((0x1c0,xqd),(0x1c8,sd),(0x1d0,host),(0x2b8,mode),(0x2c8,backup)):wr(vm+off,v)
 wr(mode,0xbcaa68)
 for a in (backup,xqd,sd,host):wr(a,fixture+0x100)
 wr(fixture+0x110,fixture+0x300);wr(fixture+0x140,fixture+0x308);wr(fixture+0x148,fixture+0x310)
 calls=[];policy=[];notifies=[]
 def hook(uc,pc,size,ctx):
  if pc==fixture+0xff0:u.emu_stop()
  elif pc in (0x40c310,0x40c340,0x4149b0,0x5be6e0,0x5be730,0x74654c,0x8bf7e4):ret()
  elif pc==0x5b72f0:ret(raw_option)
  elif pc==0x41497c:ret(xqd_present)
  elif pc==0x414b28:ret(available_counter)
  elif pc==fixture+0x300:ret(reg(0)+8)
  elif pc==fixture+0x308:ret(rd(reg(0)+0xc0,4))
  elif pc==fixture+0x310:
   calls.append(dict(object=hex(reg(0)),value=reg(1),caller=hex(u.reg_read(UC_ARM64_REG_LR)-4)))
   wr(reg(0)+0xc0,reg(1),4);ret()
  elif pc==0x5e8c54:
   calls.append(dict(object='JPEGMode',value=reg(1),caller=hex(u.reg_read(UC_ARM64_REG_LR)-4)))
  elif pc==0x70f2f8:notifies.append(hex(reg(0)));ret()
  elif pc==0x6a9aa4:policy.append(pc)
 u.hook_add(UC_HOOK_CODE,hook)
 cases=[]
 scenarios=[(r,c,p,a)for r in (0,1)for c in range(6)for p,a in ([(0,0),(1,2)]if c==1 else [(1,2)])]
 for raw_option,composite,xqd_present,available_counter in scenarios:
   calls.clear();policy.clear();notifies.clear()
   wr(vm+0x1d8+0xc0,composite,4);wr(mode+0xc0,0,4);wr(mode+0xc8,1,4)
   wr(backup+0xc0,0,4);wr(xqd+0xc0,0,4);wr(sd+0xc0,0,4)
   u.reg_write(UC_ARM64_REG_SP,stack+0xf000);u.reg_write(UC_ARM64_REG_LR,fixture+0xff0)
   u.reg_write(UC_ARM64_REG_X0,observer)
   u.emu_start(0x6a9aa4,0,count=10000);assert u.reg_read(UC_ARM64_REG_PC)==fixture+0xff0
   assert policy==[0x6a9aa4]
   cases.append(dict(raw_option=raw_option,SD_composite=composite,XQD_condition_present=xqd_present,available_counter=available_counter,
      XQD_RAW_mode=rd(xqd+0xc0,4),SD_RAW_mode=rd(sd+0xc0,4),JPEG_mode=rd(mode+0xc0,4),Backup_mode=rd(backup+0xc0,4),setters=list(calls)))
 # Positive branches of required native card policy, not assumed UI labels.
 normal=[q for q in cases if q['raw_option']==0]
 assert next(q for q in normal if q['SD_composite']==5)['SD_RAW_mode']==2
 assert next(q for q in normal if q['SD_composite']==5)['XQD_RAW_mode']==0
 assert next(q for q in normal if q['SD_composite']==4)['Backup_mode']==1
 assert next(q for q in normal if q['SD_composite']==4)['SD_RAW_mode']==0
 assert next(q for q in normal if q['SD_composite']==1 and q['XQD_condition_present']==0)['SD_RAW_mode']==2
 assert next(q for q in normal if q['SD_composite']==1 and q['XQD_condition_present']==1)['XQD_RAW_mode']==2
 sites=[]
 for va in (0x6a9cd4,0x6a9d58,0x6a9e90,0x6a9f30,0x6a9fb4,0x6aa074):
  sites.append(dict(va=hex(va),old_le=raw(va,4).hex(),operation='BLR x2 JPEGMode VT+48'))
 incoming=[]
 for va,fs,off,fl in loads:
  if not fl&1:continue
  for delta in range(0,fs-3,4):
   word=struct.unpack_from('<I',b,off+delta)[0]
   if word>>26==0b100101:
    imm=word&0x3ffffff
    if imm&(1<<25):imm-=1<<26
    if va+delta+imm*4==0x6a9aa4:incoming.append(hex(va+delta))
 table=[]
 for i in range(6):
  data=raw(0xf528d0+i*24,24);title=struct.unpack_from('<I',data)[0];value=struct.unpack_from('<I',data,16)[0];table.append(dict(table_row=i,value=value,title_id=title,visible=data[20],enabled=data[21],hex=data.hex()))
 out=dict(schema='iq4_storage_six_mode_original_A64_55',input_sha256=SHA,cases=cases,
  exact_factory_names=['Off','Overflow','JPEG Only','Mirror Mode (hidden/unsupported branch)','Archive Mode','Primary Storage'],native_table=table,
  raw_option0_is_normal_RAW_branch=True,Archive_sets_Backup_New_only_when_previous_Off=True,
  fixture_notes=['original policy and 6aa120/178 executed','RAW format/camera condition getters fixture values0/1','native virtual storage setters/getters are fixtures','no capture queue or card IO','Mirror hidden unsupported branch retained'],camera_accessed=False,target_device_executed=False)
 (OUT/'STORAGE_MODE_A64.json').write_text(json.dumps(out,indent=2)+'\n')
 print('PASS 14 original A64 storage policy branches including Primary SD, Archive backup and Overflow fallback')

if __name__=='__main__':main()
