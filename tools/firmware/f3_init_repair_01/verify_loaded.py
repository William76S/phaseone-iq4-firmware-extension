#!/usr/bin/env python3
"""Host-only ELF relocation model, independent of the generated RTTI pin graph."""
from pathlib import Path
import ctypes as C, hashlib, importlib.util, json, struct, sys
ROOT=Path(__file__).resolve().parents[3]
s=importlib.util.spec_from_file_location('rtti_repair_elf',ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py')
m=importlib.util.module_from_spec(s);sys.modules[s.name]=m;s.loader.exec_module(m)
USER=ROOT/'analysis/firmware/f1_f3_f4_user_integration_build_04_recording_repair_01/P1Linux_RatioMask_JPEG_LVRecording_6.03.33.bin'
LIB=ROOT/'analysis/firmware/f1_user_ui_entry_01/libstdcxx_original_ANALYSIS_ONLY.elf'
class Model:
 def __init__(self,base):
  self.mem=[];self.missing=[];self.base=base;self.user=m.Elf(USER.read_bytes(),2);self.lib=m.Elf(LIB.read_bytes(),3)
  for e,bias in [(self.user,0),(self.lib,base)]:
   for p in e.ph:
    if p[0]==1:self.mem.append((bias+p[3],bytearray(e.data[p[2]:p[2]+p[5]])+bytearray(p[6]-p[5])))
  us={v[6]:v for v in self.user.symbols(self.user.index('.dynsym')) if v[3] and v[6]}
  ls=self.lib.symbols(self.lib.index('.dynsym'));lm={v[6]:v for v in ls if v[3] and v[6]}
  sec=self.lib.section_bytes(self.lib.index('.rela.dyn'))
  for off in range(0,len(sec),24):
   at,info,add=struct.unpack_from('<QQq',sec,off);kind=info&0xffffffff;ix=info>>32
   value=None
   if kind==1027:value=base+add
   elif kind in (257,1025):
    sym=ls[ix];name=sym[6]
    if name in us:value=us[name][4]+add
    elif sym[3]:value=base+sym[4]+add
    else:self.missing.append((at,name))
   if value is not None:self.write(base+at,struct.pack('<Q',value))
  sec=self.user.section_bytes(self.user.index('.rela.dyn'));ul=self.user.symbols(self.user.index('.dynsym'))
  for off in range(0,len(sec),24):
   at,info,add=struct.unpack_from('<QQq',sec,off)
   if info&0xffffffff==1024:
    sym=ul[info>>32];name=sym[6]
    if name in lm:
     assert lm[name][5]>=sym[5]
     self.write(at,self.bytes(base+lm[name][4],sym[5]))
 def bytes(self,p,n):
  for start,data in self.mem:
   if start<=p and p+n<=start+len(data):return bytes(data[p-start:p-start+n])
  raise ValueError(('unmapped',hex(p),n))
 def write(self,p,data):
  for start,b in self.mem:
   if start<=p and p+len(data)<=start+len(b):b[p-start:p-start+len(data)]=data;return
  raise ValueError(('unmapped write',hex(p),len(data)))
 def read(self,ctx,p,out,n):
  try:C.memmove(out,self.bytes(p,n),n);return 1
  except ValueError:return 0
Read=C.CFUNCTYPE(C.c_int,C.c_void_p,C.c_size_t,C.c_void_p,C.c_size_t)
def row(p):
 data=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(data),sha256=hashlib.sha256(data).hexdigest())
def main():
 out=Path(sys.argv[1]);a=C.CDLL(str(out/'old.dylib'));b=C.CDLL(str(out/'new.dylib'))
 for dll in (a,b):dll.iq4_native_copy_rtti_current_01.argtypes=[C.c_void_p,Read];dll.iq4_native_copy_rtti_current_01.restype=C.c_int
 results=[]
 for i in range(16):
  base=0x7000000000+i*4096;model=Model(base);rd=Read(model.read)
  old=a.iq4_native_copy_rtti_current_01(None,rd);new=b.iq4_native_copy_rtti_current_01(None,rd)
  assert old==int(i==0) and new==1,(i,old,new)
  results.append(dict(case='valid_loader_4K_bias',bias=hex(base),old=old,new=new))
 for delta in (1,4,8,128,2048,4095):
  model=Model(0x7000001000+delta);rd=Read(model.read);assert b.iq4_native_copy_rtti_current_01(None,rd)==0
  results.append(dict(case='non_page_bias_rejected',delta=delta,new=0))
 for name,addr in [('copy_vptr',0xf42a70),('copy_slot',0xf429e0),('library_header',0x7000001000+18),('destructor',0x7000001000+0x8ee38),('type_name',0x7000001000+0x130d90)]:
  model=Model(0x7000001000);old=model.bytes(addr,1);model.write(addr,bytes([old[0]^1]));rd=Read(model.read);assert b.iq4_native_copy_rtti_current_01(None,rd)==0
  results.append(dict(case='corruption_rejected',field=name,new=0))
 report=dict(schema='iq4_rtti_loader_bias_host_model_01',user=row(USER),library=row(LIB),cases=results,host_C_verifiers_executed=True,model_from_actual_ELF_program_headers_and_relocations=True,pin_graph_used_to_make_model=False,target_executed=False,camera_accessed=False)
 (out/'LOADED_MODEL.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(cases=len(results),old_valid_bias_accept=1,new_valid_bias_accept=16,target_executed=False)))
if __name__=='__main__':main()
