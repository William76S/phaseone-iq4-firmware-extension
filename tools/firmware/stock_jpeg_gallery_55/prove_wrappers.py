#!/usr/bin/env python3
"""Focused original-A64 Rectangle and linked LCD guard ABI evidence."""
from pathlib import Path
import argparse,hashlib,json,struct,sys,importlib.util,math
from collections import deque
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
 ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);args=ap.parse_args();out=args.build.resolve()
 stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';b=stock.read_bytes();assert row(stock)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
 p=ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py';spec=importlib.util.spec_from_file_location('gallery_elf',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
 m.REQUIRED_SYMBOLS=tuple('iq4_stock_jpeg_gallery_'+n+'_55'for n in ('zoom_gate','preview_gate','final_gate','metadata_entry'))
 obj=out/'wrappers.o';geom=out/'geometry.o';m.REQUIRED_SYMBOLS+=('iq4_jpeg_gallery_inverse_roi_55',);link=m.Linker(b,[(obj.name,obj.read_bytes()),(geom.name,geom.read_bytes())]);fixture=0x7000000
 exact=json.loads((HERE/'EXACT.json').read_text())
 aliases={a['symbol']:a['va']for a in exact['aliases']};aliases.update(iq4_stock_jpeg_gallery_is_photo_55=fixture,iq4_stock_jpeg_gallery_metadata_55=fixture+8)
 for name,va in aliases.items():link.imports[name]={'va':va,'focused_fixture':name.endswith(('is_photo_55','metadata_55'))}
 link.relocate();u=Uc(UC_ARCH_ARM64,UC_MODE_ARM);mapped=[]
 for typ,fl,off,va,pa,fs,ms,align in link.base.ph:
  if typ==1:
   lo=va&~4095;hi=(va+ms+4095)&~4095;u.mem_map(lo,hi-lo);mapped.append((lo,hi));u.mem_write(va,b[off:off+fs])
 for lo,size in ((m.NEW_RX_VA,(link.rx_size+4095)&~4095),(link.rw_va,(link.rw_size+4095)&~4095)):
  u.mem_map(lo,size);mapped.append((lo,lo+size))
 for s in link.sections:
  if s.data:u.mem_write(s.va,bytes(s.data))
 base=0x28000000;stack=0x30000000;finish=fixture+0xff0
 for lo,size in ((base,0x100000),(stack,0x10000),(fixture,0x1000)):u.mem_map(lo,size);mapped.append((lo,lo+size))
 def wr(a,v,n=8):u.mem_write(a,(v&((1<<(n*8))-1)).to_bytes(n,'little'))
 def rd(a,n=8):return int.from_bytes(u.mem_read(a,n),'little')
 def reg(n):return u.reg_read(UC_ARM64_REG_X0+n)
 def ret(v=0):u.reg_write(UC_ARM64_REG_X0,v&((1<<64)-1));u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
 def fget(n):return struct.unpack('<d',u.reg_read(UC_ARM64_REG_D0+n).to_bytes(8,'little'))[0]
 def fset(n,v):u.reg_write(UC_ARM64_REG_D0+n,int.from_bytes(struct.pack('<d',v),'little'))
 imports=m.original_imports(link.base);mathpc={v['va']:k for k,v in imports.items() if k in ('sin','cos','sincos','sqrt','pow','__hypot_finite','hypot','memset','memcpy','memmove','_Znwm','_Znam','malloc','_ZdlPvm','_ZdlPv','_ZdaPv','free')}
 outcome=1;calls=0;stopset=set();alloc=base+0x80000;trace=deque(maxlen=20)
 def hook(uc,pc,size,ctx):
  nonlocal calls,alloc
  trace.append(hex(pc))
  if pc in stopset or pc==finish:uc.emu_stop();return
  if pc in (fixture,fixture+8):
   calls+=1
   assert reg(0)==base and reg(1)==base+0x1000
   if pc==fixture:
    for n in range(19):uc.reg_write(UC_ARM64_REG_X0+n,0xbad00000+n)
    for n in range(32):uc.reg_write(UC_ARM64_REG_Q0+n,0x123456789abcdef0123456789abcdef)
    uc.reg_write(UC_ARM64_REG_NZCV,0xf0000000)
   ret(outcome);return
  if pc in mathpc:
   name=mathpc[pc]
   if name in ('sin','cos','sqrt','pow','__hypot_finite','hypot'):
    fset(0,{'sin':math.sin,'cos':math.cos,'sqrt':math.sqrt,'pow':lambda x:math.pow(x,fget(1)),'__hypot_finite':lambda x:math.hypot(x,fget(1)),'hypot':lambda x:math.hypot(x,fget(1))}[name](fget(0)));u.reg_write(UC_ARM64_REG_PC,u.reg_read(UC_ARM64_REG_LR))
   elif name=='sincos':wr(reg(0),int.from_bytes(struct.pack('<d',math.sin(fget(0))),'little'));wr(reg(1),int.from_bytes(struct.pack('<d',math.cos(fget(0))),'little'));ret()
   elif name in ('memcpy','memmove'):u.mem_write(reg(0),bytes(u.mem_read(reg(1),reg(2))));ret(reg(0))
   elif name=='memset':u.mem_write(reg(0),bytes([reg(1)&255])*reg(2));ret(reg(0))
   elif name in ('_Znwm','_Znam','malloc'):a=alloc;alloc=(alloc+reg(0)+15)&~15;assert alloc<base+0x100000;ret(a)
   else:ret()
 u.hook_add(UC_HOOK_CODE,hook);results=[];GP=[UC_ARM64_REG_X0+n for n in range(29)]+[UC_ARM64_REG_X29,UC_ARM64_REG_X30]
 for label,frame,nodeoff in [('zoom',0x3e0,0x3b0),('preview',0x320,0x2f8),('final',0x360,0x338)]:
  for source_exists,owned in [(True,False),(False,False),(False,True)]:
   sp=stack+0xf000;wr(sp+0x28,base);wr(sp+nodeoff,base+0x1000);before=[]
   for n in range(31):v=0x8877665544332200+n;u.reg_write(GP[n],v);before.append(v)
   vectors=[]
   for n in range(32):v=0x102030405060708090a0b0c0d0e0f000+n;u.reg_write(UC_ARM64_REG_Q0+n,v);vectors.append(v)
   u.reg_write(UC_ARM64_REG_SP,sp);nzcv=0x20000000 if source_exists else 0x60000000;u.reg_write(UC_ARM64_REG_NZCV,nzcv);outcome=int(owned);calls=0
   passpc=aliases[f'iq4_stock_jpeg_gallery_{label}_continue_55'];failpc=aliases[f'iq4_stock_jpeg_gallery_{label}_failure_55'];stopset={passpc,failpc}
   u.emu_start(link.named(f'iq4_stock_jpeg_gallery_{label}_gate_55'),0,count=3000)
   assert u.reg_read(UC_ARM64_REG_PC)==(passpc if source_exists or owned else failpc)
   assert calls==int(not source_exists) and u.reg_read(UC_ARM64_REG_SP)==sp and u.reg_read(UC_ARM64_REG_NZCV)==nzcv
   assert all(u.reg_read(GP[n])==before[n]for n in range(31));assert all(u.reg_read(UC_ARM64_REG_Q0+n)==vectors[n]for n in range(32))
   results.append(dict(kind=label,source_exists=source_exists,owned_JPEG=owned,all_GPR_SIMD_NZCV_SP_preserved=True,passed=True))
 for result in (-2,0,1):
  sp=stack+0xf000;fp=sp+0x100;u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_X29,fp);u.reg_write(UC_ARM64_REG_LR,finish)
  for n,v in enumerate((base,base+0x1000,1,4,5,6,7,8,9)):u.reg_write(UC_ARM64_REG_X0+n,v)
  outcome=result;stopset={aliases['iq4_stock_jpeg_gallery_metadata_resume_55']};u.emu_start(link.named('iq4_stock_jpeg_gallery_metadata_entry_55'),0,count=3000)
  if result==-2:
   assert u.reg_read(UC_ARM64_REG_PC)in stopset and u.reg_read(UC_ARM64_REG_SP)==sp-0xe0 and rd(sp-0xe0)==fp and rd(sp-0xd8)==finish
   assert [reg(n)for n in range(9)]==[base,base+0x1000,1,4,5,6,7,8,9]
  else:assert u.reg_read(UC_ARM64_REG_PC)==finish and u.reg_read(UC_ARM64_REG_SP)==sp and u.reg_read(UC_ARM64_REG_X29)==fp
  results.append(dict(kind='metadata',owned_result=result,original_entry_replayed_only_for_RAW=result==-2,passed=True))
 # Original Rectangle ctor/copy (not a host mirror) and original rotation
 # transform/integer inverse run on eight finite rectangles.  Standard math functions
 # and heap service only are fixtures; matrix/coordinate code is original A64.
 node=base+0x1000;rect=base+0x2000;forward=base+0x2100;back=base+0x2200;stopset=set();wr(node+0x38,4000,4);wr(node+0x3c,3000,4)
 def execute(pc,args,x8=0):
  sp=stack+0xf000;u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_X29,sp+0x100);u.reg_write(UC_ARM64_REG_LR,finish);u.reg_write(UC_ARM64_REG_X8,x8)
  for n,v in enumerate(args):u.reg_write(UC_ARM64_REG_X0+n,v)
  u.emu_start(pc,0,count=1000000);assert u.reg_read(UC_ARM64_REG_PC)==finish and u.reg_read(UC_ARM64_REG_SP)==sp,(hex(pc),hex(u.reg_read(UC_ARM64_REG_PC)),hex(u.reg_read(UC_ARM64_REG_SP)),list(trace))
 for angle in (0,90,180,270):
  for coordinates in ((0,0,4000,3000),(800,600,1200,900)):
   wr(node+0x70,angle,4);execute(0x457cf0,[rect,*coordinates]);execute(0x487e98,[rect,node,1],forward)
   observed=struct.unpack('<iiii',bytes(u.mem_read(forward+8,16)))
   execute(link.named('iq4_jpeg_gallery_inverse_roi_55'),[4000,3000,angle,forward+8,back]);assert reg(0)==1;restored=struct.unpack('<iiii',bytes(u.mem_read(back,16)))
   assert all(abs(x-y)<=2 for x,y in zip(coordinates,restored)),(angle,coordinates,observed,restored)
   assert rd(forward)==0xb73b98
   results.append(dict(kind='native_rectangle',angle=angle,source=coordinates,original_forward=observed,integer_EXIF_inverse=restored,two_pixel_factory_rounding_bound=True,passed=True))
 receipt=dict(schema='iq4_real_JPEG_LCD_wrapper_A64_55',stock=row(stock),objects=[row(obj),row(geom)],source=row(HERE/'prove_wrappers.py'),relocator=row(p),cases=results,original_Rectangle_and_forward_matrix_code_executed=True,new_integer_EXIF_inverse_A64_executed=True,fixtures=['JPEG ownership/metadata classification','original standard math/heap/copy PLT service'],not_executed=['LCD hardware','full catalog enumeration','full native LCD outer functions','compressed file entropy decoding (separate real decoder evidence)'],camera_accessed=False,target_executed=False)
 (out/'A64_WRAPPERS.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps({'cases':len(results),'receipt':row(out/'A64_WRAPPERS.json')}))
if __name__=='__main__':main()
