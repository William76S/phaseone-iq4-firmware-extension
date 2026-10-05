#!/usr/bin/env python3
"""Execute actual A64 wrappers + stock setter bodies in host Unicorn.
Only enter/leave helper and original Notify are fixtures. No camera API exists.
"""
from pathlib import Path
import hashlib,json,struct,subprocess
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/firmware/f3_native_storage_bridge_01';BUILD=OUT/'build';STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';OBJ=BUILD/'storage_wrappers.o'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def elf(b):
 e=struct.unpack_from('<16sHHIQQQIHHHHHH',b);s=[struct.unpack_from('<IIQQQQIIQQ',b,e[6]+i*e[11])for i in range(e[12])];names=b[s[e[13]][4]:s[e[13]][4]+s[e[13]][5]]
 def name(i):return names[i:].split(b'\0',1)[0].decode()
 return e,s,{name(x[0]):(i,x)for i,x in enumerate(s)}
def main():
 orig=STOCK.read_bytes();assert row(STOCK)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 b=OBJ.read_bytes();e,ss,names=elf(b);ti,ts=names['.text'];_,sy=names['.symtab'];st=ss[sy[6]];strings=b[st[4]:st[4]+st[5]];symbols=[]
 for p in range(sy[4],sy[4]+sy[5],24):
  v=struct.unpack_from('<IBBHQQ',b,p);symbols.append((strings[v[0]:].split(b'\0',1)[0].decode(),v[3],v[4],v[5]))
 base=0x6000000;func={n:base+v for n,i,v,z in symbols if n and i==ti};stubs={'iq4_f3_storage_output_child_01':0x6100000,'iq4_f3_storage_enter_01':0x6100010,'iq4_f3_storage_leave_01':0x6100020};text=bytearray(b[ts[4]:ts[4]+ts[5]])
 _,rs=names['.rela.text']
 for p in range(rs[4],rs[4]+rs[5],24):
  off,info,add=struct.unpack_from('<QQq',b,p);assert info&0xffffffff==283
  n,section,value,_=symbols[info>>32];target=func[n]if section==ti else stubs[n];delta=target+add-(base+off);assert delta%4==0 and -(1<<27)<=delta<(1<<27);struct.pack_into('<I',text,off,0x94000000|((delta//4)&0x3ffffff))
 u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);e=elf(orig)[0]
 for i in range(e[10]):
  p=struct.unpack_from('<IIQQQQQQ',orig,e[5]+i*e[9]);
  if p[0]!=1:continue
  start=p[3]&~4095;end=(p[3]+p[6]+4095)&~4095;u.mem_map(start,end-start);u.mem_write(p[3],orig[p[2]:p[2]+p[5]])
 u.mem_map(base,0x1000);u.mem_write(base,bytes(text));u.mem_map(0x6100000,0x1000);u.mem_map(0x10000000,0x1000);u.mem_map(0x70000000,0x20000);u.mem_map(0x1000,4096);u.reg_write(UC_ARM64_REG_CPACR_EL1,3<<20)
 pairs=[(0x5e9884,'regular_enter'),(0x5e98c0,'regular_leave'),(0x5e9900,'silent_enter'),(0x5e990c,'silent_leave')]
 for va,n in pairs:u.mem_write(va,struct.pack('<I',0x14000000|(((func['iq4_f3_storage_'+n+'_01']-va)//4)&0x3ffffff)))
 state={}
 def hook(u,pc,sz,_):
  if pc==stubs['iq4_f3_storage_enter_01']:
   assert u.reg_read(UC_ARM64_REG_X0)==0x10000000
   assert u.reg_read(UC_ARM64_REG_W1)==state['requested']
   assert u.reg_read(UC_ARM64_REG_X2)==state['caller']
   assert u.reg_read(UC_ARM64_REG_W3)==state['silent']
   assert not state['entered'];state['entered']=True;state['owned']=state['token']==1
   u.reg_write(UC_ARM64_REG_X0,(state['token']<<32)|state['effective'])
  elif pc==stubs['iq4_f3_storage_leave_01']:
   assert state['entered'] and not state['left']
   assert u.reg_read(UC_ARM64_REG_W0)==state['token'];state['left']=True;state['owned']=False
  elif pc==0x70f2f8:
   assert state['left'] and not state['owned'];state['notifications']+=1
  else:raise AssertionError(hex(pc))
  # Callee-saved registers are left intact; aggressively clobber caller-saved
  # GP/SIMD/flags to prove wrappers preserve live original body registers.
  for i in range(1,19):u.reg_write(UC_ARM64_REG_X0+i,0xcc000000+i)
  for i in range(8):u.reg_write(UC_ARM64_REG_Q0+i,0x1234+i)
  u.reg_write(UC_ARM64_REG_NZCV,0xf0000000);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 for pc in [stubs['iq4_f3_storage_enter_01'],stubs['iq4_f3_storage_leave_01'],0x70f2f8]:u.hook_add(UC_HOOK_CODE,hook,begin=pc,end=pc)
 rows=[]
 for kind in ['normal','silent','ui']:
  for before in range(3):
   for wanted in range(3):
    for token in [0,1]:
     for initialized in [0,1]:
      effective=(wanted+1)%3 if token else wanted;silent=int(kind=='silent');caller=func['iq4_f3_storage_ui_set_return_01']if kind=='ui' else 0x1000
      state=dict(requested=wanted,effective=effective,silent=silent,token=token,caller=caller,entered=False,left=False,owned=False,notifications=0)
      sp=0x7001f000;u.mem_write(sp-0x1000,b'\xa5'*0x1000);u.mem_write(0x10000000,b'\0'*0x100);u.mem_write(0x100000c0,struct.pack('<I',before));u.mem_write(0x100000c8,struct.pack('<I',initialized));u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_LR,0x1000)
      saved={i:0xdead0000+i for i in range(19,30)}
      for i,v in saved.items():u.reg_write((UC_ARM64_REG_X29 if i==29 else UC_ARM64_REG_X0+i),v)
      u.reg_write(UC_ARM64_REG_X0,0x10000000);u.reg_write(UC_ARM64_REG_W1,wanted)
      entry=func['iq4_f3_storage_ui_set_call_01']if kind=='ui' else (0x5e98e8 if silent else 0x5e9868)
      u.emu_start(entry,0x1000,count=10000);assert u.reg_read(UC_ARM64_REG_PC)==0x1000 and u.reg_read(UC_ARM64_REG_SP)==sp
      assert all(u.reg_read(UC_ARM64_REG_X29 if i==29 else UC_ARM64_REG_X0+i)==v for i,v in saved.items()),kind
      assert state['entered']and state['left']and not state['owned']
      assert struct.unpack('<I',u.mem_read(0x100000c0,4))[0]==effective
      expected=0 if silent else int(initialized!=1 or before!=effective);assert state['notifications']==expected,(kind,state,expected)
      frame=(0x30 if silent else 0x40)+(16 if kind=='ui'else 0);padding=0x20 if silent else 0x30
      assert struct.unpack('<I',u.mem_read(sp-frame+padding,4))[0]==token
      # Remaining four padding bytes preserve caller sentinel; no token overlaps
      # the original NullLock object at +0x38/+0x28 or saved registers.
      assert bytes(u.mem_read(sp-frame+padding+4,4))==b'\xa5'*4
      rows.append(dict(kind=kind,before=before,requested=wanted,effective=effective,initialized=initialized,lock_token=token,notifications=expected))
 dump=subprocess.check_output(['/Library/Developer/CommandLineTools/usr/bin/llvm-dwarfdump','--eh-frame',str(OBJ)],text=True);(BUILD/'storage_wrappers.eh_frame.txt').write_text(dump)
 for n in ['regular_enter','regular_leave','silent_enter','silent_leave']:
  symbol='iq4_f3_storage_'+n+'_01';off=func[symbol]-base;part=[p for p in dump.split('\n\n')if ' FDE 'in p and ('pc=%08x...'%off)in p];assert len(part)==1
  # Dwarfdump decoded state follows as separate paragraph.
  start=dump.index(part[0]);end=dump.find('\n0000',start+len(part[0]));block=dump[start:end if end>=0 else len(dump)];lines=[l for l in block.splitlines()if ': CFA='in l]
  assert lines
  for line in lines:
   assert 'W29=[CFA-%d]'%(48 if n.startswith('silent')else 64)in line
   assert 'W30=[CFA-%d]'%(40 if n.startswith('silent')else 56)in line
   if n.startswith('regular'):assert 'W19=[CFA-48]'in line
 result=dict(schema='iq4_storage_actual_a64_wrapper_emulation_01',original=row(STOCK),wrapper=row(OBJ),cases=rows,total_cases=len(rows),inherited_regular_x19_cfi=True,same_value_exit_unlock=True,token_only_original_padding=True,caller_callee_saved_preserved=True,helper_and_notification_fixtures=True,hardware_executed=False)
 (OUT/'WRAPPER_EMULATION.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS',len(rows),'actual A64 setter/wrapper chains; CFI/saved x19/padding/noNotify unlock')
if __name__=='__main__':main()
