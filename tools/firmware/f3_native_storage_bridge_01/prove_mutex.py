#!/usr/bin/env python3
"""Read stock rootfs and emulate original default pthread ABI on host only."""
from pathlib import Path
import hashlib,importlib.util,json,struct,subprocess
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f3_native_storage_bridge_01'
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 disk=ROOT/'analysis/firmware/P1_ramdisk.ext2';assert row(disk)['sha256']=='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'
 spec=importlib.util.spec_from_file_location('iq4_stock_ext2',ROOT/'tools/firmware/inspect_boot.py');m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
 matches=[b for n,b in m.Ext2(disk.read_bytes()).walk()if n['path']=='/lib/libpthread-2.28.so'];assert len(matches)==1;b=matches[0];assert hashlib.sha256(b).hexdigest()=='9305ff30980749a3f64b3e445764db2bc378d14d1ef8bbe004d0ecc768d00f77';lib=OUT/'libpthread_original.analysis.elf';lib.write_bytes(b)
 objdump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump';proof=[]
 for name,start,end in [('pthread_init',0x9328,0x94e4),('pthread_lock',0x9b08,0x9d88),('pthread_unlock',0xb0e8,0xb250)]:
  text=subprocess.check_output([objdump,'-d','--start-address='+hex(start),'--stop-address='+hex(end),str(lib)],text=True);(OUT/(name+'.asm')).write_text('\n'.join(l.rstrip()for l in text.splitlines()if l.startswith('  '))+'\n');proof.append(dict(name=name,va=start,bytes=end-start,sha256=hashlib.sha256(b[start:end]).hexdigest()))
 stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';imports=[]
 for name,va in [('pthread_mutex_lock',0x40aae0),('pthread_mutex_unlock',0x40a730)]:
  text=subprocess.check_output([objdump,'-d','--start-address='+hex(va),'--stop-address='+hex(va+16),str(stock)],text=True);assert '<'+name+'@plt>'in text;imports.append(dict(name=name,va=va));(OUT/(name+'_plt.asm')).write_text(text)
 u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);e=struct.unpack_from('<16sHHIQQQIHHHHHH',b);base=0x10000000
 for i in range(e[10]):
  p=struct.unpack_from('<IIQQQQQQ',b,e[5]+i*e[9]);
  if p[0]!=1:continue
  start=p[3]&~4095;end=(p[3]+p[6]+4095)&~4095;u.mem_map(base+start,end-start);u.mem_write(base+p[3],b[p[2]:p[2]+p[5]])
 u.mem_map(0x70000000,0x20000);u.mem_map(0x20000000,0x3000);u.mem_map(0x1000,4096)
 u.reg_write(UC_ARM64_REG_TPIDR_EL0,0x20001800);u.mem_write(0x200011d0,struct.pack('<I',77));mutex=0x20000008
 def call(pc):
  u.reg_write(UC_ARM64_REG_X0,mutex);u.reg_write(UC_ARM64_REG_X1,0);u.reg_write(UC_ARM64_REG_SP,0x7001f000);u.reg_write(UC_ARM64_REG_LR,0x1000);u.emu_start(base+pc,0x1000,count=10000);assert u.reg_read(UC_ARM64_REG_PC)==0x1000 and u.reg_read(UC_ARM64_REG_W0)==0
 u.mem_write(mutex-8,b'\xa5'*64);call(0x9328);assert bytes(u.mem_read(mutex,48))==b'\0'*48;assert bytes(u.mem_read(mutex-8,8))==b'\xa5'*8 and bytes(u.mem_read(mutex+48,8))==b'\xa5'*8
 for _ in range(3):
  call(0x9b08);assert struct.unpack('<I',u.mem_read(mutex,4))[0]==1;assert struct.unpack('<I',u.mem_read(mutex+8,4))[0]==77;assert struct.unpack('<I',u.mem_read(mutex+16,4))[0]==0
  call(0xb248);assert bytes(u.mem_read(mutex,48))==b'\0'*48
 result=dict(schema='iq4_native_storage_pthread_ABI_01',rootfs=row(disk),provider=row(lib),target_path='/lib/libpthread-2.28.so',imports=imports,finite_windows=proof,default_init_48_exact_zero=True,surrounding_canaries_unchanged=True,default_kind_offset=16,lock_word_offset=0,target_alignment_static_assert=8,actual_stock_uncontended_lock_unlock_cycles=3,host_emulation=True,tls_thread_id_fixture=77,camera_accessed=False)
 (OUT/'MUTEX_ABI.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS original pthread init(NULL) exact48B; 3 actual A64 lock/unlock fast paths; stock PLTs')
if __name__=='__main__':main()
