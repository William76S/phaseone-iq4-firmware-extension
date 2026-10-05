#!/usr/bin/env python3
"""Exact original queue + compiled unlock thunk. Mutex/event callbacks are
explicit host fixtures, not hardware or an OS execution of the vendor ELF."""
from pathlib import Path
import hashlib,json,struct,sys
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
OBJ=ROOT/'analysis/firmware/f3_ordinary_capture_build_01/enqueue_thunk.o'
Q=0x10000000;L=Q+0x1000;EVENT=Q+0x2000;OLD=Q+0x3000;THUNK=0x5000000;WRAPPER=THUNK+0x1000
def branch(pc,target,link=False):
 d=target-pc;assert d%4==0 and -(1<<27)<=d<(1<<27);return struct.pack('<I',(0x94000000 if link else 0x14000000)|((d>>2)&0x3ffffff))
def object_text(b):
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',b);sections=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11])for i in range(h[12])];strs=sections[h[13]];names=b[strs[4]:strs[4]+strs[5]]
 name=lambda s:names[s[0]:names.index(0,s[0])].decode();text=next(s for s in sections if name(s)=='.text');symsec=next(s for s in sections if s[1]==2);symnamesec=sections[symsec[6]];sn=b[symnamesec[4]:symnamesec[4]+symnamesec[5]];syms=[]
 for off in range(symsec[4],symsec[4]+symsec[5],symsec[9]):
  x=struct.unpack_from('<IBBHQQ',b,off);syms.append((sn[x[0]:sn.index(0,x[0])].decode(),x[4]))
 code=bytearray(b[text[4]:text[4]+text[5]]);entry=next(v for n,v in syms if n=='iq4_f3_ordinary_queue_unlock_thunk_01')
 for s in sections:
  if s[1]==4 and sections[s[7]]==text:
   for off in range(s[4],s[4]+s[5],s[9]):
    ro,info,add=struct.unpack_from('<QQq',b,off);assert info&0xffffffff==282;symbol=syms[info>>32][0]
    target=WRAPPER if symbol=='iq4_f3_ordinary_queue_unlock_wrapper_01'else WRAPPER+0x100
    code[ro:ro+4]=branch(THUNK+ro,target+add)
 return bytes(code),entry
def main():
 b=STOCK.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA;ob=OBJ.read_bytes();code,entry=object_text(ob);rows=[]
 for scenario in('empty','nonempty','already_linked','null_link','notification_exception_entry'):
  u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);h=struct.unpack_from('<16sHHIQQQIHHHHHH',b)
  for i in range(h[10]):
   p=struct.unpack_from('<IIQQQQQQ',b,h[5]+i*h[9])
   if p[0]==1:
    start=p[3]&~4095;end=(p[3]+p[6]+4095)&~4095;u.mem_map(start,end-start);u.mem_write(p[3],b[p[2]:p[2]+p[5]])
  u.mem_map(Q,0x10000);u.mem_map(0x70000000,0x10000);u.mem_map(0x1000,4096);u.mem_map(THUNK,0x2000);u.mem_write(THUNK,code);u.mem_write(0x8c7184,branch(0x8c7184,THUNK+entry,True))
  def w(p,v):u.mem_write(p,struct.pack('<Q',v))
  def r(p):return struct.unpack('<Q',u.mem_read(p,8))[0]
  w(Q+0x18,EVENT);trace=[];state=dict(held=False,ready=False,normal_unlock=False,exception=False)
  if scenario=='nonempty':w(Q+8,OLD);w(Q+16,OLD)
  if scenario=='already_linked':w(L,OLD)
  def hook(uc,pc,size,_):
   if pc==0x712130:assert not state['held'];state['held']=True;trace.append('native mutex acquired');uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
   elif pc==0x70f2f8:
    assert state['held'] and not state['ready'];trace.append('notification while native mutex remains held')
    if scenario=='notification_exception_entry':
     # Explicit injection at the original unwind landing pad; not proof of a
     # hardware exception or a full C++ personality/unwinder implementation.
     state['exception']=True;uc.reg_write(UC_ARM64_REG_X0,0x1234);uc.reg_write(UC_ARM64_REG_PC,0x8c7190)
    else:uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
   elif pc==WRAPPER:
    assert state['held'];args=[uc.reg_read(k)for k in(UC_ARM64_REG_X0,UC_ARM64_REG_X1,UC_ARM64_REG_X2,UC_ARM64_REG_X3)];guard,queue,link,success=args
    assert r(guard)==Q+0x20 and queue==Q and link==L
    expected=scenario in('empty','nonempty');assert success==int(expected)
    if success:assert r(Q+16)==L and r(Q+8);state['ready']=True
    state['normal_unlock']=True;trace.append('compiled thunk supplies exact queue, link, insertion bool under mutex');uc.reg_write(UC_ARM64_REG_PC,0x411bf4)
   elif pc==0x712204:
    assert state['held'];state['held']=False;trace.append('original mutex release; ready='+str(state['ready']));uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
   elif pc==0x74654c:uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
   elif pc==0x40a750:assert state['exception'] and not state['ready'] and not state['normal_unlock'];uc.emu_stop()
  u.hook_add(UC_HOOK_CODE,hook);u.reg_write(UC_ARM64_REG_SP,0x7000f000);u.reg_write(UC_ARM64_REG_LR,0x1000);u.reg_write(UC_ARM64_REG_X0,Q);u.reg_write(UC_ARM64_REG_X1,0 if scenario=='null_link'else L);u.emu_start(0x8c709c,0x1000,count=1000)
  assert not state['held'];expected=scenario in('empty','nonempty');assert state['ready']==expected
  if not state['exception']:assert u.reg_read(UC_ARM64_REG_PC)==0x1000 and u.reg_read(UC_ARM64_REG_X0)==int(expected)
  rows.append(dict(scenario=scenario,passed=True,trace=trace,**state))
 out=Path(sys.argv[1]);out.write_text(json.dumps(dict(stock_sha256=SHA,compiled_thunk_sha256=hashlib.sha256(ob).hexdigest(),level='host_original_A64_and_compiled_thunk_emulation',device_executed=False,cpp_wrapper='observation fixture; actual C++ wrapper separately host-tested',cases=rows),indent=2)+'\n');print(len(rows),'original queue / compiled A64 thunk cases passed')
if __name__=='__main__':main()
