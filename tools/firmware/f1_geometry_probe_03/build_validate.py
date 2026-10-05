#!/usr/bin/env python3
"""Finite host facts; compile/link AArch64 probe only. No target execution."""
from pathlib import Path
import hashlib,json,struct,subprocess,sys
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];OUT=ROOT/'analysis/firmware/f1_geometry_probe_03'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def run(cmd):
 r=subprocess.run(list(map(str,cmd)),cwd=ROOT,text=True,capture_output=True)
 if r.returncode:raise SystemExit(r.stdout+r.stderr)
 return r.stdout
def inspect_shared(path):
 # This is a link-only SO, not a PIE executable: require ET_DYN without an
 # interpreter, record its actual dependency/version set and never claim that
 # the target's loader has accepted it. Own ET_REL constructor checks follow.
 b=path.read_bytes()
 if len(b)<64 or b[:7]!=b'\x7fELF\x02\x01\x01'or struct.unpack_from('<HH',b,16)!=(3,183):raise ValueError('Wrong shared-object architecture')
 phoff=struct.unpack_from('<Q',b,32)[0];phsize,phcount=struct.unpack_from('<HH',b,54)
 shoff=struct.unpack_from('<Q',b,40)[0];shsize,shcount=struct.unpack_from('<HH',b,58)
 if phsize!=56 or not 0<phcount<4096 or phoff+phsize*phcount>len(b)or shsize!=64 or not 0<shcount<4096 or shoff+shsize*shcount>len(b):raise ValueError('ELF table bounds')
 for i in range(phcount):
  p=struct.unpack_from('<IIQQQQQQ',b,phoff+i*56)
  if p[0]==3:raise ValueError('Link-only SO unexpectedly has interpreter')
  if p[2]+p[5]>len(b):raise ValueError('ELF segment bounds')
 ss=[struct.unpack_from('<IIQQQQIIQQ',b,shoff+i*64)for i in range(shcount)]
 for s in ss:
  if s[1]!=8 and s[4]+s[5]>len(b):raise ValueError('ELF section bounds')
 def string(st,off):
  if not 0<=off<len(st):raise ValueError('ELF string index')
  end=st.find(b'\0',off)
  if end<0:raise ValueError('ELF unterminated string')
  return st[off:end].decode('ascii')
 imports=set();exports=set();needed=set();versions=set()
 for s in ss:
  if s[1]in(2,11):
   if s[9]!=24 or s[5]%24 or s[6]>=shcount:raise ValueError('ELF symbol bounds')
   st=ss[s[6]];strings=b[st[4]:st[4]+st[5]]
   for off in range(s[4],s[4]+s[5],24):
    n,info,other,index,value,size=struct.unpack_from('<IBBHQQ',b,off)
    if not n or not info>>4:continue
    name=string(strings,n)
    if index==0:imports.add(name)
    elif s[1]==11 and other&3==0:exports.add(name)
  if s[1]==6:
   if s[9]!=16 or s[5]%16 or s[6]>=shcount:raise ValueError('ELF dynamic bounds')
   st=ss[s[6]];strings=b[st[4]:st[4]+st[5]]
   for off in range(s[4],s[4]+s[5],16):
    tag,value=struct.unpack_from('<QQ',b,off)
    if tag==1:needed.add(string(strings,value))
   versions.update(v.decode('ascii')for v in strings.split(b'\0')if v.startswith(b'GLIBC_'))
 return dict(ELF_type=3,machine=183,sha256=sha(path),bytes=len(b),undefined_symbols=sorted(imports),exports=sorted(exports),needed=sorted(needed),glibc_versions=sorted(versions),interpreter=None,target_loader_compatibility_verified=False)
def main():
 OUT.mkdir(exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\n*.zip\nprivate/\n')
 build=ROOT/'build/f1_geometry_probe03_host';build.mkdir(exist_ok=True)
 sdk=run(['xcrun','--show-sdk-path']).strip();include=['-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
 deps=[ROOT/'tools/firmware/f1_native_ui_02/ui.cpp',ROOT/'tools/firmware/f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp']
 common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-isystem',sdk+'/usr/include/c++/v1']+include
 tests={}
 for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
  exe=build/name;run(common+flags+[HERE/'probe.cpp',HERE/'test_probe.cpp']+deps+['-o',exe]);receipt=run([exe])
  if receipt!='30 F1 geometry03 finite host groups; native/device execution zero\n':raise SystemExit('Unexpected host receipt: '+receipt)
  tests[name]=dict(groups=30,receipt=receipt.strip(),exit_code=0)
 exe=build/'production';run(common+[HERE/'probe.cpp',HERE/'test_production.cpp']+deps+['-o',exe]);receipt=run([exe])
 if receipt!='3 production guard groups; zero native reads/calls\n':raise SystemExit('Production guard changed')
 tests['production']=dict(groups=3,receipt=receipt.strip(),exit_code=0)
 zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text())
 if sha(zig)!=lock['zig_binary_sha256']or run([zig,'version']).strip()!=lock['version']:raise SystemExit('Pinned compiler mismatch')
 sys.path.insert(0,str(ROOT/'tools/firmware/windows_aarch64_toolchain_01'));import probes
 obj=OUT/'probe.aarch64.o';targetflags=[zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-Wall','-Wextra','-Wpedantic','-Werror']+include
 run(targetflags+['-c',HERE/'probe.cpp','-o',obj]);object_report=probes.inspect_elf(obj,1)
 # The SO is a link validation of own code and frozen dependencies only; no
 # constructor, interpose symbol, actual entry or loader/install action.
 # Compile with the pinned C++ headers, then link only object files without
 # the compiler's default C++ runtime; -nostdlib++ also hides those headers.
 dependency_objects=[]
 for source in deps:
  depobj=OUT/(source.stem+'_dependency.aarch64.o');run(targetflags+['-c',source,'-o',depobj]);dependency_objects.append(depobj)
 so=OUT/'probe_link_only.aarch64.so';run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',obj]+dependency_objects+['-o',so]);so_report=inspect_shared(so)
 sections=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','--section-headers',obj]);(OUT/'probe_sections.txt').write_text('\n'.join(s.rstrip()for s in sections.splitlines())+'\n')
 if '.init_array'in sections or '.fini_array'in sections:raise SystemExit('Implicit own constructor')
 denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','pwrite','pthread_create'}
 for t in [object_report,so_report]:
  if set(t['undefined_symbols'])&denied:raise SystemExit('Unexpected target side-effect import')
 report=dict(schema='iq4_f1_geometry03_build_v1',tests=tests,target_objects=[object_report,so_report],frozen_dependency_ET_REL={str(p.relative_to(ROOT)):sha(p)for p in dependency_objects},production_overlay_enabled=False,
  actual_geometry_mapping_verified=False,actual_fresh_blit_verified=False,actual_surface_lease_verified=False,
  device_accessed=False,target_executed=False,vendor_code_executed=False,
  sources={str(p.relative_to(ROOT)):sha(p)for p in [HERE/'probe.cpp',HERE/'probe.hpp',HERE/'test_probe.cpp',HERE/'test_production.cpp']+deps})
 (OUT/'build_validation.json').write_text(json.dumps(report,indent=2)+'\n')
 print(json.dumps(dict(host_groups_each=30,target_link_compile_only=[object_report['sha256'],so_report['sha256']],production_overlay_enabled=False)))
if __name__=='__main__':main()
