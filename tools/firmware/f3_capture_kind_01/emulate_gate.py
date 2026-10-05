#!/usr/bin/env python3
"""Execute stock A64 save gate without calling any OS/hardware code."""
from pathlib import Path
import hashlib,itertools,json,struct,sys
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];P=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
def main():
 b=P.read_bytes();assert hashlib.sha256(b).hexdigest()==SHA
 u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);u.mem_map(0x790000,0x10000);u.mem_write(0x790000,b[0x390000:0x3a0000]);u.mem_map(0x10000000,0x20000)
 cm=0x10000000;production=cm+0x10000
 rows=[];terminal=[]
 def hook(uc,pc,size,_):
  if pc in(0x79cdc0,0x79cf98):terminal.append(pc);uc.emu_stop()
 u.hook_add(UC_HOOK_CODE,hook)
 for enable,first_black,cancel,dont_save,control in itertools.product(range(2),range(2),range(2),range(2),range(7)):
  u.mem_write(cm+0x80f8,struct.pack('<Q',production));u.mem_write(cm+0x2708,bytes([first_black]));u.mem_write(cm+0xc08,bytes([cancel]));u.mem_write(cm+0x26fc,struct.pack('<I',control));u.mem_write(production+0x1a0,bytes([enable]));u.mem_write(production+0xdb0,bytes([dont_save]))
  for r,v in((UC_ARM64_REG_X19,cm),(UC_ARM64_REG_X20,cm+0x8000),(UC_ARM64_REG_X25,cm+0xb48),(UC_ARM64_REG_X27,cm+0x2000)):u.reg_write(r,v)
  terminal.clear();u.emu_start(0x79cd98,0x79d154,count=50);assert len(terminal)==1
  actual=terminal[0]==0x79cdc0;expected=not first_black and not cancel and(not dont_save if enable else control!=5)
  assert actual==expected
  rows.append(dict(production=enable,first_black=first_black,cancel=cancel,dont_save=dont_save,black_control=control,native_save=actual,extension_eligible=not enable and not first_black and not cancel and control<=4,terminal=hex(terminal[0])))
 out=Path(sys.argv[1]);out.write_text(json.dumps(dict(stock_sha256=SHA,level='host_original_A64_emulation',cases=len(rows),all_passed=True,peer_memory='synthetic',device_executed=False,rows=rows),indent=2)+'\n');print(len(rows),'original A64 save-gate cases passed')
if __name__=='__main__':main()
