#!/usr/bin/env python3
"""Actual original inner-wait arguments plus compiled scope-aware timer bridge."""
from pathlib import Path
import hashlib,json,struct,sys,importlib.util
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/stock_storage_router_55'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 original=USER.read_bytes();assert hashlib.sha256(original).hexdigest()==SHA
 path=ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py';spec=importlib.util.spec_from_file_location('router_wait_reloc',path);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
 objects=[OUT/'runtime.o',OUT/'inner_wait.o'];m.REQUIRED_SYMBOLS=('iq4_stock_half_inner_wait_55','iq4_stock_half_inner_wait_wrapper_55')
 linker=m.Linker(original,[(p.name,p.read_bytes())for p in objects]);fixture=0x7000000;imports={};names=set()
 for table in linker.symtabs.values():
  for sym in table:
   if sym[6] and sym[4]==0:names.add(sym[6])
 names.discard('iq4_stock_half_inner_wait_55');names.discard('iq4_stock_half_inner_wait_wrapper_55')
 for i,name in enumerate(sorted(names)):
  imports[name]=fixture+8*i;linker.imports[name]={'va':imports[name],'host_fixture':True}
 linker.relocate();u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);mapped=[]
 phoff=struct.unpack_from('<Q',original,32)[0];esz,num=struct.unpack_from('<HH',original,54)
 for i in range(num):
  typ,fl,off,va,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',original,phoff+i*esz)
  if typ==1:
   lo=va&~4095;hi=(va+ms+4095)&~4095;u.mem_map(lo,hi-lo);mapped.append((lo,hi));u.mem_write(va,original[off:off+fs])
 worker=0x28005000;worker_owner=worker+0x65547918
 for lo,size in ((m.NEW_RX_VA,(linker.rx_size+4095)&~4095),(linker.rw_va,(linker.rw_size+4095)&~4095),(fixture,0x1000),(0x28000000,0x10000),(0x30000000,0x10000),(worker_owner&~4095,4096)):
  u.mem_map(lo,size);mapped.append((lo,lo+size))
 for section in linker.sections:
  if section.data:u.mem_write(section.va,bytes(section.data))
 locals_={}
 for (oi,table),symbols in linker.symtabs.items():
  for no,sym in enumerate(symbols):
   if sym[6].startswith('_ZL') and sym[4]!=0:locals_[sym[6]]=linker.symbol((oi,table,no))
 def wr(a,v,n=8):u.mem_write(a,v.to_bytes(n,'little'))
 def rd(a,n=8):return int.from_bytes(u.mem_read(a,n),'little')
 def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
 def ret(v=0):u.reg_write(UC_ARM64_REG_X0,v);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 def checked(a,n):return a>=4096 and n>0 and any(lo<=a and a+n<=hi for lo,hi in mapped)
 calls=[];gate=locals_['_ZL9half_gate']
 def hook(uc,pc,size,ctx):
  if pc==0x48c990:u.emu_stop()
  elif pc==0x710b0c:ret(0x777)
  elif pc==0x713a18:calls.append(dict(thread=reg(0),timeout=reg(1),observer=reg(2),gate_held=rd(gate,4)));ret(1)
  elif pc==imports['iq4_native_current_tid_01']:ret(99)
  elif pc==imports['iq4_native_self_read_01']:
   assert reg(0)==0
   if checked(reg(1),reg(3)) and checked(reg(2),reg(3)):u.mem_write(reg(2),bytes(u.mem_read(reg(1),reg(3))));ret(1)
   else:ret(0)
  elif pc==imports.get('memcmp'):ret(0 if bytes(u.mem_read(reg(0),reg(2)))==bytes(u.mem_read(reg(1),reg(2))) else 1)
  elif pc==imports.get('strlen'):
   a=reg(0);n=0
   while rd(a+n,1):n+=1
   ret(n)
  elif pc in imports.values():raise AssertionError(('unexpected external',hex(pc)))
 u.hook_add(UC_HOOK_CODE,hook)
 target=linker.named('iq4_stock_half_inner_wait_wrapper_55');delta=target-0x48c98c
 assert delta%4==0 and -(1<<27)<=delta<(1<<27)
 u.mem_write(0x48c98c,struct.pack('<I',0x94000000|((delta//4)&0x3ffffff)))
 ifm=0x28001000;cat=0x28002000;node=0x28004000;ice=0x28006000;fs=[0x28007000,0x28008000];sp=0x3000e000;fp=sp+0x20
 binding=locals_['_ZL7binding'];transaction=locals_['_ZL16half_transaction']
 wr(binding+56,ifm);wr(ifm,0xb7f960);wr(ifm+0xfa8,cat);wr(cat,0xb7ece0);wr(cat+0x328,ifm);wr(cat+0x7a0,fs[0]);wr(cat+0x7d0,fs[1])
 for i in range(2):wr(fs[i],0xd91450);u.mem_write(fs[i]+0x15,(b'/run/media/xqdcard/'if i else b'/run/media/sdcard/')+b'\0')
 wr(locals_['_ZL11half_worker'],worker);wr(locals_['_ZL8half_ice'],ice);wr(cat+0x4d0,ice);wr(worker_owner,ice)
 wr(transaction+8,node);wr(transaction+16,7,4);wr(transaction+20,1,4);wr(transaction+24,1001,4)
 wr(sp+0x78,cat);wr(sp+0x74,7,4);wr(sp+0x360,node);wr(node+0xdc,1001,4)
 records=[]
 for name,uid,context,choice,want in [('owned_half',1001,ice,1,60000),('foreign_node_UID',1002,ice,1,10000),('foreign_queue',1001,ice+16,1,10000),('native_4K',1001,ice,0,10000)]:
  calls.clear();wr(locals_['_ZL6active'],1,4);wr(locals_['_ZL4held'],0,4);wr(locals_['_ZL11half_choice'],choice,4);wr(gate,0,4);wr(node+0xdc,uid,4);wr(cat+0x4d0,context)
  u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_X29,fp)
  for i in range(19,29):u.reg_write(UC_ARM64_REG_X0+i,0x900+i)
  u.emu_start(0x48c974,0,count=20000)
  assert len(calls)==1 and calls[0]['thread']==0x777 and calls[0]['observer']==sp+0x128 and calls[0]['timeout']==want
  assert calls[0]['gate_held']==(want==60000) and not rd(gate,4)
  assert reg(0)==1 and u.reg_read(UC_ARM64_REG_SP)==sp and u.reg_read(UC_ARM64_REG_X29)==fp
  assert all(reg(i)==0x900+i for i in range(19,29))
  records.append(dict(case=name,**calls[0],gate_released_after_native_return=True,catalog_index=7,processing_UID=uid))
 result=dict(schema='iq4_stock_half_inner_wait_actual_A64_55',input=row(USER),objects=[row(p)for p in objects],source=row(Path(__file__)),relocator=row(path),cases=records,original_argument_window_executed=True,actual_new_wrapper_and_scope_helper=True,external_fixtures=['bounded exact self-read','current native thread id','factory wait result and duration capture','memcmp/strlen'],real_thread_scheduling=False,hardware_wait_duration_measured=False,camera_accessed=False)
 (OUT/'A64_HALF_WAIT.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS 4 actual original inner-wait + compiled same-node/UID/queue scoped 60s; others retain10s')
if __name__=='__main__':main()
