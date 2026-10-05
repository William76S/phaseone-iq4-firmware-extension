#!/usr/bin/env python3
"""Execute frozen original IQ4 AArch64 shutter maths on the host, never hardware.
Unicorn maps only local ELF bytes. The sole external math import, pow, uses
Python libm; native integer/float/table selection instructions run unchanged.
"""
from pathlib import Path
import hashlib, json, math, struct, sys
from unicorn import Uc, UC_ARCH_ARM64, UC_MODE_ARM, UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3]
STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def bits(f):return struct.unpack('<I',struct.pack('<f',f))[0]
def unbits(i):return struct.unpack('<f',struct.pack('<I',i))[0]
def dbits(f):return struct.unpack('<Q',struct.pack('<d',f))[0]
def undbits(i):return struct.unpack('<d',struct.pack('<Q',i))[0]
class Native:
 def __init__(self, path=STOCK, expected=SHA):
  self.b=path.read_bytes();assert hashlib.sha256(self.b).hexdigest()==expected
  self.u=Uc(UC_ARCH_ARM64,UC_MODE_ARM)
  # Exact stock PT_LOAD layout; no host pointers or device APIs are exposed.
  e=struct.unpack_from('<16sHHIQQQIHHHHHH',self.b)
  for i in range(e[10]):
   p=struct.unpack_from('<IIQQQQQQ',self.b,e[5]+i*e[9])
   if p[0]!=1:continue
   start=p[3]&~4095;end=(p[3]+p[6]+4095)&~4095
   self.u.mem_map(start,end-start);self.u.mem_write(p[3],self.b[p[2]:p[2]+p[5]])
  self.u.mem_map(0x70000000,0x20000);self.u.mem_map(0x1000,4096)
  self.u.reg_write(UC_ARM64_REG_CPACR_EL1,3<<20)
  self.u.hook_add(UC_HOOK_CODE,self.hook,begin=0x40a020,end=0x40a020)
  self.calls=0
 def hook(self,u,pc,size,data):
  assert pc==0x40a020
  f=math.pow(undbits(u.reg_read(UC_ARM64_REG_D0)),undbits(u.reg_read(UC_ARM64_REG_D1)))
  u.reg_write(UC_ARM64_REG_D0,dbits(f));u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 def run(self,pc,w=None,s=None):
  u=self.u;u.reg_write(UC_ARM64_REG_SP,0x7001f000);u.reg_write(UC_ARM64_REG_LR,0x1000)
  if w is not None:u.reg_write(UC_ARM64_REG_W0,w&0xffffffff)
  if s is not None:u.reg_write(UC_ARM64_REG_S0,bits(s))
  u.emu_start(pc,0x1000,count=150000);assert u.reg_read(UC_ARM64_REG_PC)==0x1000
  self.calls+=1
 def seconds(self,tick):self.run(0x71b538,w=tick);return unbits(self.u.reg_read(UC_ARM64_REG_S0))
 def tick(self,seconds):
  self.run(0x71b804,s=seconds);v=self.u.reg_read(UC_ARM64_REG_W0);return v-(1<<32) if v>>31 else v
 def table(self):return [struct.unpack_from('<ffiII',self.b,0xc264d8-0x400000+20*i) for i in range(163)]
def main():
 out=Path(sys.argv[1]);assert not out.exists();out.parent.mkdir(parents=True,exist_ok=True)
 n=Native();rows=[]
 # All ordinary source table positions no slower than 0.8 second; no assertion
 # that every table entry is enabled by the real camera's readout limits.
 for row in n.table()[1:-1]:
  sec,_,tick,_,_=row
  if not 0.00024999<=sec<=0.80001:continue
  actual=n.seconds(tick);assert abs(actual-sec)<1e-6
  for third in range(1,10):
   ratio=unbits(bits(2**(third/3)));wanted=unbits(bits(actual*ratio));long=n.tick(wanted)
   got=n.seconds(long)
   rows.append(dict(short_tick=tick,short_seconds=actual,third_stops=third,ratio=ratio,long_tick=long,long_seconds=got,display_EV=(tick-long)/12))
 out.write_text(json.dumps(dict(schema='iq4_dual_native_shutter_instruction_emulation_01',stock_sha256=SHA,unicorn_version='2.1.4',stock_code_executed=True,external_pow='Python math.pow fixture',cases=rows,native_calls=n.calls,hardware_executed=False),indent=2)+'\n')
 print(json.dumps(dict(cases=len(rows),native_calls=n.calls,examples=rows[:9])))
if __name__=='__main__':main()
