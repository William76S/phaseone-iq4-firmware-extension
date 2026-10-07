#!/usr/bin/env python3
"""Finite original A64 deletion-policy counterexamples; no camera or card I/O."""
from pathlib import Path
import json,hashlib,struct,importlib.util
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
R=Path(__file__).resolve().parents[3];D=Path(__file__).resolve().parent;O=R/'analysis/firmware/jpeg_pair_delete_61'
p=R/'analysis/firmware/half_request_owner_independent_59/verify_final.py';s=importlib.util.spec_from_file_location('delete_elf',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m);stock=R/'analysis/firmware/extracted/P1Linux_6.03.21.bin';e=m.Elf(stock)
assert hashlib.sha256(stock.read_bytes()).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
u=Uc(UC_ARCH_ARM64,UC_MODE_ARM)
for typ,fl,off,va,pa,fs,ms,al in e.ph:
 if typ==1:u.mem_map(va&~4095,((va+ms+4095)&~4095)-(va&~4095));u.mem_write(va,e.data[off:off+fs])
base=0x28000000;stack=0x30000000;u.mem_map(base,0x10000);u.mem_map(stack,0x10000);cat=base;fs0=base+0x1000;fs1=base+0x2000;dir0=base+0x3000;dir1=base+0x3100;power0=base+0x4000;power1=base+0x4400;sp=stack+0xf000
for fs in(fs0,fs1):u.mem_write(fs,struct.pack('<Q',0xd91450))
u.mem_write(dir0,b'DCIM/100PHASE\0');u.mem_write(dir1,b'DCIM/100PHASE\0')
def wr(a,v,z=8):u.mem_write(a,v.to_bytes(z,'little'))
def rd(a,z=8):return int.from_bytes(u.mem_read(a,z),'little')
for off,v in((0x7a0,fs0),(0x7d0,fs1),(0x7b0,dir0),(0x7e0,dir1),(0x788,power0),(0x7b8,power1),(0x790,3),(0x7c0,4)):wr(cat+off,v,4 if off in(0x790,0x7c0) else 8)
def string(a):return bytes(u.mem_read(a,256)).split(b'\0')[0].decode()
def reg(i):return u.reg_read(UC_ARM64_REG_X0+i)
def ret(v=0):u.reg_write(UC_ARM64_REG_X0,v);u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
trace=[];names={}
def trap(uc,pc,size,ctx):
 if pc==0x494844:u.emu_stop()
 elif pc==0x409f30:
  fmt=string(reg(2));out=fmt%(string(reg(3)),string(reg(4)));u.mem_write(reg(0),out.encode()+b'\0');ret(len(out))
 elif pc in(0x74649c,0x74654c):ret()
 elif pc==0x8ca888:trace.append(dict(kind='original_native_card_request',power=hex(reg(0)),token=reg(1),timeout_ms=reg(2)));ret(0)
 elif pc==0x825ed4:
  names[reg(1)]=(reg(0),string(reg(2)));wr(reg(1)+8,reg(0));wr(reg(1)+0x10,9,4);wr(reg(1)+0x14,1,1);ret(1)
 elif pc==0x82595c:
  fs,name=names[reg(0)];trace.append(dict(kind='native_File_delete_boundary',card=10 if fs==fs0 else 11,path=name));ret(1)
 elif pc==0x826ca8:trace.append(dict(kind='native_File_close_boundary',card=10 if reg(0)==fs0 else 11));ret(1)
 elif pc==0x8bf7e4:trace.append(dict(kind='popup',code=reg(0)));ret()
u.hook_add(UC_HOOK_CODE,trap);cases=[]
for mode in(0,1,2,4,5):
 u.mem_write(sp,bytes(0x140));wr(sp+0x28,cat);wr(sp+0x130,0xb7eaa0+mode*8);wr(sp+0x121,1,1);wr(sp+0x122,1,1);wr(sp+0x120,1,1);wr(sp+0x11f,0,1);wr(sp+0x12b,1,1);u.mem_write(sp+0x38,b'IMG0001\0');u.reg_write(UC_ARM64_REG_SP,sp);trace.clear();names.clear();u.emu_start(0x4943bc,0,count=10000);assert u.reg_read(UC_ARM64_REG_PC)==0x494844
 deletes=[t for t in trace if t['kind']=='native_File_delete_boundary'];assert all(not(t['card']==11 and t['path'].endswith('.JPG'))for t in deletes);cases.append(dict(sd_mode=mode,trace=list(trace)))
result=dict(schema='iq4_pair_delete_original_a64_61',stock_sha256=hashlib.sha256(stock.read_bytes()).hexdigest(),original_region_executed=['0x4943bc','0x494844'],cases=cases,xqd_JPEG_never_deleted=True,external_fixtures=['native card request returns ready','FS.open creates a File handle','File.delete and OS close are observed boundary fixtures','logging/snprint'],precondition_fixture='native DeleteFile has already retired catalog and copied/stripped filename; all local original RAW+JPEG flags set',camera_accessed=False,card_accessed=False,target_device_executed=False)
(O/'A64_ORIGINAL_GAP.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS 5 actual original native deletion-policy counterexamples')
