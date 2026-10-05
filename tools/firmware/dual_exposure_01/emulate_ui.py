#!/usr/bin/env python3
"""Actual linked machine code + original label dispatch/property setter.
UI model, thread identity, locks, notification delivery and display refresh are
explicit host fixtures. This does not claim real touch input or sensor capture.
"""
from emulate_native import *
BUILD=ROOT/'analysis/firmware/dual_exposure_link_dev_01'
class UI(Native):
 def __init__(self):
  self.j=json.loads((BUILD/'BUILD.json').read_text());self.r=json.loads((BUILD/'LINK_REPORT.json').read_text())
  super().__init__(ROOT/self.j['User']['path'],self.j['User']['sha256'])
  self.u.mem_map(0x10000000,0x30000);self.nots=0;self.updates=0;self.nativebusy=0;self.other=0
  self.symbols=self.r['own_symbols'];self.imp=self.r['original_import_bindings']
  functions={self.symbols['iq4_native_self_read_01']:'read',self.symbols['iq4_f4_native_current_02']:'thread',self.symbols['iq4_activity_snapshot_01']:'activity',0x40c310:'lock',0x40c340:'unlock',0x70f2f8:'notify',0x5384cc:'update',self.imp['memcmp']['va']:'memcmp',0x10018000:'busy'}
  for pc,name in functions.items():self.u.hook_add(UC_HOOK_CODE,self.stub,name,begin=pc,end=pc)
  self.p(0x10000000,0xba2608);self.p(0x10000108,0xba2898);self.u.mem_write(0x10000128,b'\1');self.p(0x100000b0,0x10002000);self.p(0x10002000,0xb8f358);self.p(0x10002008,0x10004000);self.p(0x10002790,0x10005000);self.p(0x10004000,0xb91f48);self.p(0x100041c8,0x10002000);self.p(0x10005030,0x10006000);self.p(0x10005038,0x1000a000);self.p(0x100003e8,0x1000b370);self.p(0x1000b370,0xbc1088);self.p(0x1000b378,0x10007080);self.p(0x10007080,0x9f8508);self.p(0x100003c8,0x10001000);self.p(0x10001000,0xb846f0);self.u.mem_write(0x10007140,struct.pack('<f',8));self.p(0x10000380,0x10019000);self.p(0x10019000,0x1001a000);self.p(0x1001a040,0x10018000);self.u.mem_write(0x1001b000,struct.pack('<I',1))
 def p(self,a,v):self.u.mem_write(a,struct.pack('<Q',v))
 def stub(self,u,pc,sz,name):
  x=[u.reg_read(UC_ARM64_REG_X0+i) for i in range(4)] # X0..X3 contiguous
  r=0
  if name=='read':
   try:u.mem_write(x[2],bytes(u.mem_read(x[1],x[3])));r=1
   except Exception:r=0
  elif name=='thread':self.p(x[0],0x10004000);r=1
  elif name=='activity':u.mem_write(x[0],struct.pack('<QII',1,self.other,0));r=0
  elif name=='notify':self.nots+=1
  elif name=='update':self.updates+=1
  elif name=='memcmp':
   a=bytes(u.mem_read(x[0],x[2]));b=bytes(u.mem_read(x[1],x[2]));r=0 if a==b else 1
  elif name=='busy':r=self.nativebusy
  elif name not in ('lock','unlock'):raise AssertionError(name)
  u.reg_write(UC_ARM64_REG_X0,r);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 def call(self,pc,*args):
  for i,x in enumerate(args):self.u.reg_write(UC_ARM64_REG_X0+i,x)
  self.run(pc)
 def ratio(self):return struct.unpack('<f',self.u.mem_read(0x10007140,4))[0]
 def tap(self):self.call(0x4ac590,0x10001000,0x1001b000)
def main():
 u=UI();u.call(u.symbols['iq4_dual_after_open_01'],0x10000000)
 assert struct.unpack('<Q',u.u.mem_read(0x10001060,8))[0]==0x10000108
 assert struct.unpack('<I',u.u.mem_read(0x10001068,4))[0]==4
 rows=[]
 for i in range(18):
  before=u.nots;u.tap();expected=unbits(bits(2**((i%9+1)/3)));assert u.ratio()==expected,(i,u.ratio(),expected)
  assert u.nots==before+1 and u.updates==i+1
  rows.append({'tap':i+1,'ratio':u.ratio(),'notifications':u.nots})
 for mode in ('busy','other'):
  u.nativebusy=int(mode=='busy');u.other=int(mode=='other');r=u.ratio();before=u.nots;u.tap();assert u.ratio()==r and u.nots==before
 out=Path(sys.argv[1]);assert not out.exists();out.write_text(json.dumps(dict(schema='iq4_actual_dual_label_dispatch_emulation_01',User=u.j['User'],rows=rows,original_busy_refusal=True,extension_activity_refusal=True,executed_actual_linked_patch=True,executed_original_label_set_and_dispatch=True,executed_original_float_setter=True,fixtures=['thread','lock/unlock','property notification receiver','post-change native display refresh','UI object graph'],hardware_executed=False),indent=2)+'\n');print('18 actual compiled cycles, original dispatch/setter, two busy refusals PASS; host emulation only')
if __name__=='__main__':main()
