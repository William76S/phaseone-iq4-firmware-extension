#!/usr/bin/env python3
from pathlib import Path
import hashlib,json,struct,subprocess

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/stock_jpeg_policy_build_01'
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'

def row(p):
 b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def emit(p,o):p.write_text(json.dumps(o,indent=2)+'\n')
def main():
 OUT.mkdir(exist_ok=True,parents=True);b=USER.read_bytes()
 assert len(b)==11874544 and hashlib.sha256(b).hexdigest()==SHA
 phoff=struct.unpack_from('<Q',b,32)[0];esz,num=struct.unpack_from('<HH',b,54)
 def raw(va,n):
  for i in range(num):
   typ,fl,off,a,pa,fs,ms,align=struct.unpack_from('<IIQQQQQQ',b,phoff+i*esz)
   if typ==1 and a<=va and va+n<=a+fs:return b[off+va-a:off+va-a+n]
  raise AssertionError(hex(va))
 audit=ROOT/'analysis/firmware/stock_jpeg_mode_reset_audit_01/EXACT_WINDOWS.json'
 evidence=json.loads(audit.read_text());assert evidence['input_sha256']==SHA
 sites=[q['va']for q in evidence['sites']]
 assert sites==[0x6a9cd4,0x6a9d58,0x6a9e90,0x6a9f30,0x6a9fb4,0x6aa074]
 windows=[(q['preceding_window']['va'],44)for q in evidence['sites']]
 for q in evidence['identity_and_order']:
  # The retained core and this new ctor wrapper both replace 424bcc.
  # Keep both unchanged sides, never pin bytes that this release patches.
  va,n=q['va'],q['bytes']
  if va<=0x424bcc<va+n:
   if va<0x424bcc:windows.append((va,0x424bcc-va))
   if 0x424bd0<va+n:windows.append((0x424bd0,va+n-0x424bd0))
  else:windows.append((va,n))
 windows.extend([(0xbcaaa8,16),(0x5e8c20,16),(0x5e8c54,16)])
 lines=['#ifndef IQ4_STOCK_JPEG_POLICY_PINS_01_H','#define IQ4_STOCK_JPEG_POLICY_PINS_01_H',
 '#include <stdint.h>','#include <stddef.h>',
 'struct StockJpegPolicyPin01{uintptr_t va;size_t bytes;const unsigned char*data;};']
 pins=[]
 for i,(va,n)in enumerate(windows):
  data=raw(va,n);lines.append('static const unsigned char StockJpegPolicyBytes%u[]={%s};'%(i,','.join('0x%02x'%v for v in data)))
  pins.append(dict(va=va,bytes=n,hex=data.hex(),sha256=hashlib.sha256(data).hexdigest()))
 lines.append('static const StockJpegPolicyPin01 StockJpegPolicyPins01[]={')
 lines.extend('{0x%x,%u,StockJpegPolicyBytes%u},'%(va,n,i)for i,(va,n)in enumerate(windows))
 lines+=['};','#endif'];(HERE/'pins.h').write_text('\n'.join(lines)+'\n')
 exact=dict(schema='iq4_stock_jpeg_policy_exact_01',input=row(USER),pins=pins,
  setter_hooks=[dict(va=va,old_hex=raw(va,4).hex(),original_operation='BLR x2, virtual JPEGMode setter',
     target_symbol='iq4_stock_jpeg_policy_set_01',branch_kind='BL')for va in sites],
  ctor_hook=dict(va=0x424bcc,old_hex=raw(0x424bcc,4).hex(),original_target=0x8e0928,
      target_symbol='iq4_stock_jpeg_policy_ctor_wrapper_01'),independent_original_windows=row(audit))
 assert all(q['old_hex']=='40003fd6'for q in exact['setter_hooks']);emit(OUT/'EXACT.json',exact)
 commands=[]
 def run(argv,label):
  p=subprocess.run(list(map(str,argv)),cwd=ROOT,text=True,capture_output=True)
  commands.append(dict(label=label,argv=list(map(str,argv)),exit=p.returncode,stdout=p.stdout,stderr=p.stderr))
  emit(OUT/'COMMANDS.json',commands);assert p.returncode==0,(label,p.stdout,p.stderr);return p.stdout
 flags=['-target','aarch64-linux-gnu.2.28','-O2','-g0','-ffreestanding','-fPIC','-fno-stack-protector',
    '-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer',
    '-Wall','-Wextra','-Werror']
 objects=[]
 for src,driver,std in [('policy.cpp','c++','-std=c++17'),('ctor_wrapper.S','cc',None)]:
  obj=OUT/(Path(src).stem+'.o')
  run([ZIG,driver,*flags,*([std]if std else []),'-c',HERE/src,'-o',obj],src)
  objects.append(row(obj));(OUT/(obj.name+'.asm')).write_text(run([
    '/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',obj],src+'_inspect'))
  run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','-u',obj],src+'_undefined')
 # The independent A64 proof uses the project's actual relocation engine,
 # rather than a second ELF linker layout or a host implementation mirror.
 result=dict(schema='iq4_stock_jpeg_policy_build_01',objects=objects,
  fixed_original_sha256=SHA,camera_accessed=False,target_device_executed=False,
  retained_52_core_source='tools/firmware/f3_stock_jpeg_xqd_01/SOURCE_SHA256.json',
  expected_event='constructor published SDgroup+e8; no dynamic card mask in policy predicate')
 emit(OUT/'BUILD.json',result);print(json.dumps(result))
if __name__=='__main__':main()
