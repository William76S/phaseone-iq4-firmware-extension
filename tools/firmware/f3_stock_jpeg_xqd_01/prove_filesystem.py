#!/usr/bin/env python3
"""Execute original LinuxFilesystem/File open, write, sync, close with IO fixtures."""
from pathlib import Path
import struct,json,hashlib
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];OUT=ROOT/'analysis/firmware/f3_stock_jpeg_xqd_01';USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
def main():
 b=USER.read_bytes();sha=hashlib.sha256(b).hexdigest();assert sha=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb';u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 for i in range(num):
  typ,fl,off,va,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
  if typ==1:lo=va&~4095;hi=(va+ms+4095)&~4095;u.mem_map(lo,hi-lo);u.mem_write(va,b[off:off+fs])
 base=0x20000000;stack=0x30000000;stop=0x1000;u.mem_map(base,0x4000);u.mem_map(stack,0x10000);u.mem_map(stop,4096);owner=base;file=base+0x1000;relative=base+0x2000;pixels=base+0x2200;log=[];open_fail=close_fail=False
 def wr(a,n,z=8):u.mem_write(a,n.to_bytes(z,'little'))
 def rd(a,z=8):return int.from_bytes(u.mem_read(a,z),'little')
 def string(p):
  z=bytearray()
  for i in range(1024):
   c=bytes(u.mem_read(p+i,1))[0]
   if not c:return z.decode()
   z.append(c)
  raise AssertionError('unterminated')
 def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
 def ret(n=0):u.reg_write(UC_ARM64_REG_X0,n&((1<<64)-1));u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 def hook(uc,pc,size,ctx):
  if pc==0x409f30:
   fmt=string(reg(2));assert fmt in ['%s%s','%s%s%s'];s=''.join(string(reg(i))for i in range(3,3+fmt.count('%s')));u.mem_write(reg(0),(s[:reg(1)-1]+'\0').encode());ret(len(s))
  elif pc==0x40a460:
   hay,needle=string(reg(0)),string(reg(1));i=hay.find(needle);ret(reg(0)+i if i>=0 else 0)
  elif pc==0x40aea0:ret(len(string(reg(0))))
  elif pc==0x40a4d0:log.append(dict(op='open',path=string(reg(0)),flags=reg(1),mode=reg(2)));ret(-1 if open_fail else 77)
  elif pc==0x40a930:assert reg(0)==77 and reg(2)==8;log.append(dict(op='write',fd=77,bytes=reg(2),payload=bytes(u.mem_read(reg(1),reg(2))).hex()));ret(reg(2))
  elif pc==0x40ad90:assert reg(0)==77;log.append(dict(op='fsync',fd=77));ret(0)
  elif pc==0x40aa90:assert reg(0)==77;log.append(dict(op='close',fd=77));ret(-1 if close_fail else 0)
  elif pc==0x74654c:log.append(dict(op='native_error_log'));ret()
 u.hook_add(UC_HOOK_CODE,hook)
 def call(pc,args):
  for i,n in enumerate(args):u.reg_write(UC_ARM64_REG_X0+i,n)
  u.reg_write(UC_ARM64_REG_SP,stack+0xf000);u.reg_write(UC_ARM64_REG_LR,stop);u.emu_start(pc,stop,count=40000);assert u.reg_read(UC_ARM64_REG_PC)==stop;return u.reg_read(UC_ARM64_REG_W0)
 wr(owner,0xd91450);u.mem_write(owner+0x15,b'/run/media/xqdcard/\0');u.mem_write(owner+0x115,b'/\0');u.mem_write(relative,b'DCIM/100PHASE/IMG0001.JPG\0');u.mem_write(pixels,b'\xff\xd8TEST\xff\xd9');assert rd(0xd91450+0x28)==0x825ed4 and rd(0xd91450+0xe8)==0x826ca8
 call(0x825770,[file]);assert call(0x825ed4,[owner,file,relative,1,1,0])==1;assert log[-1]['path']=='/run/media/xqdcard/DCIM/100PHASE/IMG0001.JPG' and log[-1]['flags']==0x80241
 assert rd(file+8)==owner and rd(file+0x10,4)==77 and rd(file+0x14,1)==1;assert call(0x8258b8,[file,pixels,8])==8;assert call(0x82580c,[file])==1;assert rd(file+0x14,1)==0;assert [x['op']for x in log]==['open','write','fsync','close']
 open_fail=True;assert call(0x825ed4,[owner,file,relative,1,1,0])==0;open_fail=False;assert call(0x825ed4,[owner,file,relative,1,1,0])==1;close_fail=True;assert call(0x82580c,[file])==0;assert rd(file+0x14,1)==0
 result=dict(schema='iq4_original_linuxfs_A64_01',input_sha256=sha,vt='0xd91450',open_slot='0x28 -> 0x825ed4',close_slot='0xe8 -> 0x826ca8',original_resolver_executed=True,current_directory_fixture='/',root_fixture='/run/media/xqdcard/',actual_original_file_lifecycle_executed=True,open_create_flags='0x80241 (O_TRUNC, no O_EXCL)',native_write_return=8,native_open_failure_return=0,native_close_failure_return=0,close_clears_open_byte_before_os_close=True,external_fixtures=['libc snprintf/strstr/strlen','OS open/write/fsync/close and error log'],trace=log,host_emulation=True,camera_accessed=False,target_device_executed=False)
 (OUT/'FILESYSTEM_A64.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS original XQD LinuxFilesystem resolves path; open/write/fsync/close; real byte return8 and bool failures0; create includes O_TRUNC')
if __name__=='__main__':main()
