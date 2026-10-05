#!/usr/bin/env python3
"""Execute exact stock node resource getters and their existing-resource branch.
Mutex and list bookkeeping are explicit fixtures. No ICE/hardware emulation.
"""
from pathlib import Path
import hashlib,json,struct,sys
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3]
STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
BASE=0x10000000;NODE=BASE;OWNER=BASE+0x1000;POOL=BASE+0x2000;RESOURCE=BASE+0x3000;PAYLOAD=BASE+0x4000
def main():
 b=STOCK.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA;h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);rows=[]
 for kind,entry,slot,pool_slot,link_call,no_allocation_range in [
  ('raw',0x8c25c0,0x88,0x2d8,0x6f0d48,(0x6f07f8,0x6f08dc)),
  ('metadata',0x8c2750,0x90,0x2e0,0x8c4e14,(0x8c36ec,0x8c37d0))]:
  for initial in (1,7):
   u=Uc(UC_ARCH_ARM64,UC_MODE_ARM)
   for i in range(h[10]):
    p=struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])
    if p[0]==1:
     start=p[3]&~4095;end=(p[3]+p[6]+4095)&~4095;u.mem_map(start,end-start);u.mem_write(p[3],b[p[2]:p[2]+p[5]])
   u.mem_map(BASE,0x10000);u.mem_map(0x70000000,0x10000);u.mem_map(0x1000,4096)
   def w(p,v):u.mem_write(p,struct.pack('<Q',v))
   def r(p):return struct.unpack('<Q',u.mem_read(p,8))[0]
   w(0x41fc268,OWNER);w(OWNER+pool_slot,POOL);w(NODE+slot,RESOURCE);w(RESOURCE+0x40,PAYLOAD)
   u.mem_write(RESOURCE+0x18,struct.pack('<I',initial));trace=[];state=dict(held=False)
   def hook(uc,pc,size,_):
    assert not no_allocation_range[0]<=pc<no_allocation_range[1], 'existing resource unexpectedly entered allocation/init'
    if pc==0x712790:
     assert not state['held'];state['held']=True;trace.append('fixture lock acquired');uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
    elif pc==link_call:
     assert state['held'];assert uc.reg_read(UC_ARM64_REG_X0)==POOL+0x58 and uc.reg_read(UC_ARM64_REG_X1)==RESOURCE+0x48
     trace.append('fixture active-list bookkeeping of same resource');uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
    elif pc==0x7127c4:
     assert state['held'];state['held']=False;trace.append('fixture lock released');uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
   u.hook_add(UC_HOOK_CODE,hook);u.reg_write(UC_ARM64_REG_SP,0x7000f000);u.reg_write(UC_ARM64_REG_LR,0x1000);u.reg_write(UC_ARM64_REG_X0,NODE)
   u.emu_start(entry,0x1000,count=1000)
   actual=struct.unpack('<I',u.mem_read(RESOURCE+0x18,4))[0]
   assert u.reg_read(UC_ARM64_REG_PC)==0x1000 and not state['held']
   assert u.reg_read(UC_ARM64_REG_X0)==RESOURCE and r(NODE+slot)==RESOURCE and r(RESOURCE+0x40)==PAYLOAD and r(RESOURCE+0x10)==NODE and actual==initial+1
   rows.append(dict(kind=kind,initial_refs=initial,final_refs=actual,same_node_resource=True,same_payload_pointer=True,allocation_path_entered=False,passed=True,trace=trace))
 out=Path(sys.argv[1]);out.write_text(json.dumps(dict(stock_sha256=SHA,level='host_original_A64_emulation',device_executed=False,fixtures=['mutex guard','active-list bookkeeping'],scope='Existing non-null resource branch only; no full calibration pipeline execution',cases=rows),indent=2)+'\n');print(len(rows),'original node accessor/resource reuse cases passed')
if __name__=='__main__':main()
