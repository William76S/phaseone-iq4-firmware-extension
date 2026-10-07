#!/usr/bin/env python3
"""Exact original A64 lookup/store plus actual new wrapper/guard; no hardware."""
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
 b=USER.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
 path=ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py';spec=importlib.util.spec_from_file_location('router_delete_reloc',path);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
 objects=[OUT/'runtime.o',OUT/'delete_lookup.o'];m.REQUIRED_SYMBOLS=('iq4_stock_delete_lookup_guard_55','iq4_stock_delete_lookup_wrapper_55')
 linker=m.Linker(b,[(p.name,p.read_bytes())for p in objects]);fixture=0x7000000
 imports={};names=set()
 for table in linker.symtabs.values():
  for sym in table:
   if sym[6] and sym[4]==0:names.add(sym[6])
 names.discard('iq4_stock_delete_lookup_guard_55');names.discard('iq4_stock_delete_lookup_wrapper_55')
 for i,name in enumerate(sorted(names)):
  imports[name]=fixture+8*i;linker.imports[name]={'va':imports[name],'host_fixture':True}
 linker.imports['iq4_stock_original_catalog_lookup_55']={'va':0x48f4f0,'kind':'exact original'}
 linker.relocate();u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);mapped=[]
 phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 for i in range(num):
  typ,fl,off,va,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
  if typ==1:
   lo=va&~4095;hi=(va+ms+4095)&~4095;u.mem_map(lo,hi-lo);mapped.append((lo,hi));u.mem_write(va,b[off:off+fs])
 for lo,size in ((m.NEW_RX_VA,(linker.rx_size+4095)&~4095),(linker.rw_va,(linker.rw_size+4095)&~4095),(fixture,0x1000),(0x28000000,0x10000),(0x30000000,0x10000)):
  u.mem_map(lo,size);mapped.append((lo,lo+size))
 for section in linker.sections:
  if section.data:u.mem_write(section.va,bytes(section.data))
 scope=None;pending_scope=None
 for (oi,table),symbols in linker.symtabs.items():
  for no,sym in enumerate(symbols):
   if sym[6]=='_ZL8deleting':scope=linker.symbol((oi,table,no))
   if sym[6]=='_ZL13pending_scope':pending_scope=linker.symbol((oi,table,no))
 assert scope is not None and pending_scope is not None
 def wr(a,v,n=8):u.mem_write(a,v.to_bytes(n,'little'))
 def rd(a,n=8):return int.from_bytes(u.mem_read(a,n),'little')
 def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
 def ret(v=0):u.reg_write(UC_ARM64_REG_X0,v);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 def checked(a,n):return a>=4096 and n>0 and any(lo<=a and a+n<=hi for lo,hi in mapped)
 current_tid=77;original_calls=0;clear_calls=0;locks=0;unlocks=0;stop=0x496f34
 def hook(uc,pc,size,ctx):
  nonlocal original_calls,clear_calls,locks,unlocks
  if pc==stop:u.emu_stop()
  elif pc==0x48793c:clear_calls+=1
  elif pc==0x411bc0:locks+=1;ret(0)
  elif pc==0x411bf4:unlocks+=1;ret(0)
  elif pc==0x48f4f0:original_calls+=1
  elif pc==imports['iq4_native_current_tid_01']:ret(current_tid)
  elif pc==imports['iq4_native_self_read_01']:
   assert reg(0)==0
   if checked(reg(1),reg(3)) and checked(reg(2),reg(3)):u.mem_write(reg(2),bytes(u.mem_read(reg(1),reg(3))));ret(1)
   else:ret(0)
  elif pc in imports.values():raise AssertionError(('unexpected external',hex(pc)))
 u.hook_add(UC_HOOK_CODE,hook)
 target=linker.named('iq4_stock_delete_lookup_wrapper_55');delta=target-0x496f28;assert delta%4==0 and -(1<<27)<=delta<(1<<27)
 u.mem_write(0x496f28,struct.pack('<I',0x94000000|((delta//4)&0x3ffffff)))
 map_=0x28000000;entries=map_+0x1000;node=map_+0x2000;entry=entries+40
 wr(map_,entries);sp=0x3000f000;fp=sp+0x100;records=[]
 for name,state,index,record_node,tid,expected in [('outside',0,1,node,77,16),('owned',2,1,node,77,16),('stale_index',2,2,node,77,18),('stale_node',2,1,node+0x100,77,18),('foreign_thread',2,1,node,99,16)]:
  current_tid=tid;original_calls=0;wr(entry+0x20,record_node);wr(entry+0xe,18,1)
  wr(scope,node);wr(scope+8,index,4);wr(scope+12,state,4);wr(scope+16,0,4);wr(scope+24,77)
  u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_X29,fp);u.reg_write(UC_ARM64_REG_X0,map_);u.reg_write(UC_ARM64_REG_X1,1);u.reg_write(UC_ARM64_REG_X19,16)
  for i in range(20,29):u.reg_write(UC_ARM64_REG_X0+i,0x1000+i)
  u.emu_start(0x496f28,0,count=3000)
  assert original_calls==1 and reg(0)==entry and rd(entry+0xe,1)==expected
  assert u.reg_read(UC_ARM64_REG_SP)==sp and u.reg_read(UC_ARM64_REG_X29)==fp
  assert all(reg(i)==0x1000+i for i in range(20,29))
  records.append(dict(case=name,flags_after=expected,original_lookup_calls=original_calls,actual_compiled_guard=True))
 pending_records=[];cat=map_+0x3000;ifm=map_+0x4000
 wr(cat+0x1b0,map_);wr(cat+0x1b8,2,4);wr(ifm+0xfa8,cat)
 target=linker.named('iq4_stock_jpeg_pending_clear_guard_55');delta=target-0x497630
 assert delta%4==0 and -(1<<27)<=delta<(1<<27)
 u.mem_write(0x497630,struct.pack('<I',0x94000000|((delta//4)&0x3ffffff)))
 stop=fixture+0x800
 for name,state,record_node,tid,expected in [('owned_same',2,node,77,128),('stale_slot',2,node+0x100,77,384),('foreign_thread_original',2,node+0x100,99,128)]:
  current_tid=tid;original_calls=clear_calls=locks=unlocks=0
  wr(entry+0x20,record_node);wr(entry+0xe,18,1);wr(entry+0x10,384,2)
  wr(pending_scope,node);wr(pending_scope+8,1,4);wr(pending_scope+12,state,4)
  wr(pending_scope+16,0,4);wr(pending_scope+24,77);wr(pending_scope+32,cat)
  u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_X29,fp);u.reg_write(UC_ARM64_REG_LR,stop)
  u.reg_write(UC_ARM64_REG_X0,ifm);u.reg_write(UC_ARM64_REG_X1,1)
  u.emu_start(0x8e25b0,0,count=10000)
  assert rd(entry+0x10,2)==expected and rd(entry+0xe,1)==18
  assert locks==1 and unlocks==1 and clear_calls==(expected==128)
  assert rd(pending_scope+16,4)==(name=='owned_same')
  assert u.reg_read(UC_ARM64_REG_SP)==sp and u.reg_read(UC_ARM64_REG_X29)==fp
  pending_records.append(dict(case=name,pending_after=expected,raw_flags_after=18,
   original_mutex_locks=locks,original_mutex_unlocks=unlocks,original_pending_clear_calls=clear_calls,
   actual_native_8e25b0_4975c8_48793c=True,actual_compiled_guard=True))
 result=dict(schema='iq4_storage_delete_lookup_A64_55',input=row(USER),objects=[row(p)for p in objects],source=row(Path(__file__)),relocator=row(path),cases=records,pending_cases=pending_records,actual_original_lookup_and_final_store=True,actual_new_guard_and_wrapper=True,external_fixtures=['self-read exact memory','current thread id'],filesystem_deletion_executed=False,camera_accessed=False)
 (OUT/'A64_DELETE_LOOKUP.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS 5 original A64 RAW lookup/store + 3 original locked pending-retirement cases; stale slot untouched')
if __name__=='__main__':main()
