#!/usr/bin/env python3
"""SDK-free host tests and own-code AArch64 compilation, never target execution."""
import argparse, hashlib, json, struct, subprocess
from pathlib import Path
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;COUNTER=HERE.parent/'f4_ui_counter_01'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def elf(raw):
 h=struct.unpack_from('<16sHHIQQQIHHHHHH',raw)
 if h[0][:7]!=b'\x7fELF\x02\x01\x01' or h[2]!=183:raise ValueError('not target ELF64LE AArch64')
 ss=[struct.unpack_from('<IIQQQQIIQQ',raw,h[6]+i*h[11]) for i in range(h[12])];strsec=ss[h[13]];names=raw[strsec[4]:strsec[4]+strsec[5]]
 def name(n):return names[n:names.index(0,n)].decode()
 sections={name(s[0]):s for s in ss};symsec=sections['.dynsym'];strings=ss[symsec[6]];st=raw[strings[4]:strings[4]+strings[5]]
 exports=[];undefined=[]
 for off in range(symsec[4],symsec[4]+symsec[5],symsec[9]):
  n,info,other,idx,val,size=struct.unpack_from('<IBBHQQ',raw,off)
  if not n:continue
  text=st[n:st.index(0,n)].decode()
  if idx==0:undefined.append(text)
  elif info>>4 in (1,2) and other&3==0:exports.append(text)
 return h,sections,exports,undefined
def main():
 p=argparse.ArgumentParser();p.add_argument('--out',type=Path,default=ROOT/'analysis/sdk_reference/f4_ui_bootstrap_host_02');p.add_argument('--zig',type=Path,default=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig');a=p.parse_args();out=a.out.resolve();out.mkdir(parents=True,exist_ok=True);commands=[]
 def run(args):
  args=[str(x) for x in args];commands.append(args);r=subprocess.run(args,cwd=ROOT,text=True,capture_output=True)
  if r.returncode:raise SystemExit(r.stdout+r.stderr)
  return r.stdout
 sdk=run(['xcrun','--show-sdk-path']).strip();common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1'];tests={}
 for key,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=out/('host_'+key);run([*common,*flags,'-DIQ4_F4_SYNTHETIC_HOST=1',COUNTER/'counter.cpp',HERE/'bootstrap.cpp',HERE/'test_bootstrap.cpp','-o',exe]);receipt=run([exe])
  if receipt!='34 SDK-free synthetic bootstrap groups passed; no target code executed\n':raise SystemExit('unexpected tests receipt: '+receipt)
  (out/(key+'.txt')).write_text(receipt);tests[key]={'exit_code':0,'receipt':receipt.strip(),'binary_sha256':sha(exe)}
 exe=out/'host_production_reject';run([*common,COUNTER/'counter.cpp',HERE/'bootstrap.cpp',HERE/'test_production_reject.cpp','-o',exe]);receipt=run([exe]);assert receipt=='2 production guard groups passed; zero native calls and zero memory reads\n';tests['production_reject']={'exit_code':0,'receipt':receipt.strip(),'binary_sha256':sha(exe)};(out/'production_reject.txt').write_text(receipt)
 lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());assert sha(a.zig)==lock['zig_binary_sha256'] and run([a.zig,'version']).strip()==lock['version']
 objs=[]
 for key,src in [('counter',COUNTER/'counter.cpp'),('bootstrap',HERE/'bootstrap.cpp'),('runtime',HERE/'runtime_linux.cpp')]:
  obj=out/(key+'.aarch64.o');run([a.zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fno-omit-frame-pointer','-fvisibility=hidden','-Wall','-Wextra','-Wpedantic','-Werror','-c',src,'-o',obj]);raw=obj.read_bytes();assert raw[:7]==b'\x7fELF\x02\x01\x01' and struct.unpack_from('<HH',raw,16)==(1,183);objs.append(obj)
 so=out/'libiq4_f4_ui_bootstrap_02.so';run([a.zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*objs,'-Wl,-z,now','-Wl,-z,relro','-o',so]);raw=so.read_bytes();h,sections,exports,undefined=elf(raw);assert h[1]==3 and exports==['pthread_mutex_unlock'];assert all(n not in undefined for n in ['pthread_create','pthread_mutex_lock','dlsym','dlvsym','dlopen','kill','raise','exit','_exit','system','execve']);assert sections['.init_array'][5]==8
 report=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-p',so]);(out/'target_dynamic.txt').write_text(report)
 if 'libc++.so' in report or 'libstdc++.so' in report:raise SystemExit('own new C++ runtime dependency not permitted; inherit original User C++ ABI runtime')
 (out/'HOST_VALIDATION.json').write_text(json.dumps({'camera_operations':False,'sdk_loaded':False,'vendor_code_executed':False,'target_shared_object_executed':False,'tests':tests,'objects':{x.name:{'bytes':x.stat().st_size,'sha256':sha(x)} for x in objs},'target_shared_object':{'bytes':len(raw),'sha256':sha(so),'format':'ELF64LE AArch64 ET_DYN','exports':exports,'undefined_symbols':undefined,'init_array_bytes':8,'synthetic_macro_present':False,'runtime_abi_validated':False,'original_libstdcxx_and_libgcc_required':True},'commands':commands,'sources':{str(x.relative_to(ROOT)):sha(x) for x in [COUNTER/'counter.hpp',COUNTER/'counter.cpp',HERE/'bootstrap.hpp',HERE/'bootstrap.cpp',HERE/'runtime_linux.cpp',HERE/'sha256.h',HERE/'test_bootstrap.cpp',HERE/'test_production_reject.cpp',Path(__file__).resolve()] }},indent=2)+'\n')
 print('34/34 normal + 34/34 ASan/UBSan + 2/2 production reject; own target SO built/inspected only')
if __name__=='__main__':main()
