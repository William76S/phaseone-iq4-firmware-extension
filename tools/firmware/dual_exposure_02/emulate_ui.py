#!/usr/bin/env python3
"""Actual linked A64 UI and stock update; no camera/firmware execution.
Only model/owner, mutex, event delivery, language and UI text sinks are fixtures.
Native short/ratio getters, ratio/long setters, clamp arithmetic and math execute.
"""
from emulate_native import *
BUILD=ROOT/'analysis/firmware/dual_exposure_link_dev_02'
class UI(Native):
 def __init__(self):
  self.j=json.loads((BUILD/'BUILD.json').read_text());self.r=json.loads((BUILD/'LINK_REPORT.json').read_text())
  super().__init__(ROOT/self.j['User']['path'],self.j['User']['sha256'])
  self.u.mem_map(0x10000000,0x30000);self.nots=0;self.updates=0;self.nativebusy=0;self.other=0;self.long_events=0;self.ratio_events=0;self.ev=0.;self.minimum=-108;self.maximum=144;self.quantizer=0
  self.symbols=self.r['own_symbols'];self.imp=self.r['original_import_bindings']
  functions={self.symbols['iq4_native_self_read_01']:'read',self.symbols['iq4_f4_native_current_02']:'thread',self.symbols['iq4_activity_snapshot_01']:'activity',0x40c310:'lock',0x40c340:'unlock',0x70f2f8:'notify',self.imp['memcmp']['va']:'memcmp',0x10018000:'busy',0x1001d000:'minimum',0x1001d004:'maximum',0x1001d008:'language',0x409f30:'format',0x457b10:'label'}
  for pc,name in functions.items():self.u.hook_add(UC_HOOK_CODE,self.stub,name,begin=pc,end=pc)
  for pc,name in [(0x5384cc,'update'),(0x71b804,'quantizer')]:self.u.hook_add(UC_HOOK_CODE,self.observe,name,begin=pc,end=pc)
  self.p(0x10000000,0xba2608);self.p(0x10000108,0xba2898);self.u.mem_write(0x10000128,b'\1');self.p(0x100000b0,0x10002000);self.p(0x10002000,0xb8f358);self.p(0x10002008,0x10004000);self.p(0x10002790,0x10005000);self.p(0x10004000,0xb91f48);self.p(0x100041c8,0x10002000);self.p(0x10005030,0x10006000);self.p(0x10005038,0x1000a000);self.p(0x100003e8,0x1000b370);self.p(0x1000b370,0xbc1088);self.p(0x1000b378,0x10007080);self.p(0x10007080,0x9f8508);self.p(0x100003c8,0x10001000);self.p(0x10001000,0xb846f0);self.u.mem_write(0x10007140,struct.pack('<f',8));self.p(0x10000380,0x10019000);self.p(0x10019000,0x1001a000);self.p(0x1001a040,0x10018000);self.u.mem_write(0x1001b000,struct.pack('<I',1))
  self.p(0x100003e0,0x1000b468);self.p(0x1000b468,0x1001c000);self.p(0x1001c0f8,0x1001d000);self.p(0x1001c100,0x1001d004)
  self.p(0x10002788,0x1001e000);self.p(0x1001e010,0x1001e100);self.p(0x1001e100,0x1001e200);self.p(0x1001e210,0x1001d008)
  self.setbase(138)
 def p(self,a,v):self.u.mem_write(a,struct.pack('<Q',v))
 def setbase(self,t):self.u.mem_write(0x100061a8,struct.pack('<i',t))
 def setratio(self,f):self.u.mem_write(0x10007140,struct.pack('<f',f))
 def longtick(self):return struct.unpack('<i',self.u.mem_read(0x10007220,4))[0]
 def observe(self,u,pc,sz,name):
  if name=='update':self.updates+=1
  elif name=='quantizer':self.quantizer+=1
 def stub(self,u,pc,sz,name):
  x=[u.reg_read(UC_ARM64_REG_X0+i) for i in range(4)];r=0
  if name=='read':
   try:u.mem_write(x[2],bytes(u.mem_read(x[1],x[3])));r=1
   except Exception:r=0
  elif name=='thread':self.p(x[0],0x10004000);r=1
  elif name=='activity':u.mem_write(x[0],struct.pack('<QII',1,self.other,0));r=0
  elif name=='notify':
   self.nots+=1
   if x[0]==0x10007088:self.ratio_events+=1
   elif x[0]==0x10007168:self.long_events+=1
  elif name=='memcmp':r=0 if bytes(u.mem_read(x[0],x[2]))==bytes(u.mem_read(x[1],x[2]))else 1
  elif name=='busy':r=self.nativebusy
  elif name=='minimum':r=self.minimum&0xffffffff
  elif name=='maximum':r=self.maximum&0xffffffff
  elif name=='language':r=0
  elif name=='format':
   self.ev=undbits(u.reg_read(UC_ARM64_REG_D0));text=('%g'%self.ev).encode();u.mem_write(x[0],text+b'\0');r=len(text)
  elif name=='label':pass
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
 cycles=[]
 for i in range(18):
  before=u.ratio_events;u.tap();n=i%9+1;expected=unbits(bits(2**(n/3)));assert u.ratio()==expected,(i,u.ratio(),expected)
  assert u.ratio_events==before+1 and u.updates==i+1
  assert u.longtick()==138-4*n and abs(u.ev-n/3)<1e-6 and not u.quantizer
  cycles.append(dict(tap=i+1,ratio=u.ratio(),long_tick=u.longtick(),formatted_EV=u.ev,ratio_notifications=u.ratio_events))
 for mode in ('busy','other'):
  u.nativebusy=int(mode=='busy');u.other=int(mode=='other');r=u.ratio();before=u.nots;beforeupdates=u.updates;u.tap();assert u.ratio()==r and u.nots==before and u.updates==beforeupdates
 u.nativebusy=u.other=0
 rows=[]
 for row in u.table()[1:-1]:
  sec,_,tick,_,_=row
  if not 0.00024999<=sec<=0.80001:continue
  for third in range(1,10):
   ratio=unbits(bits(2**(third/3)));u.setbase(tick);u.setratio(ratio);before=u.quantizer
   u.call(0x5384cc,0x10000000)
   assert u.longtick()==tick-4*third and u.quantizer==before
   assert abs(u.ev-third/3)<1e-6 and u.ratio()==ratio
   rows.append(dict(short_tick=tick,short_seconds=sec,third_stops=third,long_tick=u.longtick(),formatted_EV=u.ev,ratio_after_update=u.ratio()))
 # Preserve native max/min application; it must still change returned longtick.
 u.setbase(138);u.setratio(unbits(bits(2**(1/3))));u.minimum=136;u.call(0x5384cc,0x10000000);assert u.longtick()==136
 u.minimum=-108;u.maximum=130;u.call(0x5384cc,0x10000000);assert u.longtick()==130
 # Unknown known-stock ratio 16 delegates original math and keeps ratio unchanged.
 u.minimum=-108;u.maximum=144;u.setbase(138);u.setratio(16);before=u.quantizer;u.call(0x5384cc,0x10000000);assert u.quantizer==before+1 and u.ratio()==16
 out=Path(sys.argv[1]);assert not out.exists();out.write_text(json.dumps(dict(schema='iq4_actual_dual_update_math_emulation_02',User=u.j['User'],cycles=cycles,math_cases=rows,original_busy_refusal=True,extension_activity_refusal=True,original_min_max_clamps_executed=True,unknown_ratio_stock_quantizer_executed=True,executed_actual_linked_patch=True,executed_original_label_set_and_dispatch=True,executed_original_short_ratio_getters=True,executed_original_float_and_long_setters=True,ratio_unchanged_by_long_update=True,fixtures=['native thread','mutex','property notification delivery','UI object graph','configured native min/max methods','language and text sink'],hardware_executed=False),indent=2)+'\n');print('18 actual cycle->original update->new tick chains; 639 actual update/math cases; native clamps/fallback/busy PASS; host emulation only')
if __name__=='__main__':main()
