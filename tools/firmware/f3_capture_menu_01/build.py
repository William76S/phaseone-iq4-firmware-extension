#!/usr/bin/env python3
"""Own host tests + AArch64 ET_REL only; no firmware/link/package/target execution."""
import argparse
import hashlib
import json
import struct
import subprocess
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
USER=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
USER_SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
ZIG_SHA='c65cd34917923f575448cc0603dd7c2326da0af0e5c323043d090662dcdf351c'
HOST='/Library/Developer/CommandLineTools/usr/bin/clang'
OBJ='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def row(p):return dict(path=str(p.relative_to(ROOT)),bytes=p.stat().st_size,sha256=sha(p))
def inspect(p):
    b=p.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',b)
    if h[0][:6]!=b'\x7fELF\x02\x01' or h[1]!=1 or h[2]!=183:raise ValueError('AArch64 ELF ET_REL required')
    sections=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11]) for i in range(h[12])]
    if any(s[2]&0x400 or s[1]==6 for s in sections):raise ValueError('TLS/dynamic section forbidden')
    undefined=[]
    for s in sections:
        if s[1]!=2:continue
        strings=sections[s[6]];st=b[strings[4]:strings[4]+strings[5]]
        for off in range(s[4],s[4]+s[5],s[9]):
            name,info,other,index,value,size=struct.unpack_from('<IBBHQQ',b,off)
            if index==0 and name:
                end=st.index(b'\0',name);n=st[name:end].decode('ascii');undefined.append(n)
                if not n.startswith('iq4_f3_'):raise ValueError('Unexpected external import/helper: '+n)
    return dict(**row(p),machine=183,type='ET_REL',undefined_symbols=sorted(set(undefined)),
                target_executed=False)

def main():
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True);a=p.parse_args()
    out=a.output.resolve()
    if out.exists() or not out.is_relative_to(ROOT):raise ValueError('Fresh project-local output required')
    if sha(USER)!=USER_SHA or sha(ZIG)!=ZIG_SHA:raise ValueError('Pinned baseline/toolchain identity mismatch')
    abi=json.loads((HERE/'NATIVE_CONTRACT.json').read_text());data=USER.read_bytes()
    for r in abi['original_regions']:
        b=data[int(r['va'],16)-0x400000:][:r['bytes']]
        if hashlib.sha256(b).hexdigest()!=r['sha256']:raise ValueError('Native original window mismatch: '+r['name'])
    out.mkdir(parents=True);commands=[]
    def run(argv,kind):
        q=subprocess.run([str(x) for x in argv],cwd=ROOT,text=True,capture_output=True)
        commands.append(dict(kind=kind,argv=[str(x) for x in argv],exit=q.returncode,stdout=q.stdout,stderr=q.stderr))
        (out/'COMMANDS.json').write_text(json.dumps(commands,indent=2)+'\n')
        if q.returncode:raise RuntimeError(q.stdout+q.stderr)
        return q.stdout
    if run([ZIG,'version'],'compiler_identity').strip()!='0.15.2':raise ValueError('Zig version mismatch')
    run([HOST,'--version'],'host_compiler_identity')
    host_sdk=run(['/usr/bin/xcrun','--show-sdk-path'],'host_sdk_identity').strip()
    if not Path(host_sdk).is_dir():raise ValueError('Actual host SDK directory required')
    hostflags=['-isysroot',host_sdk,'-std=c11','-O2','-Wall','-Wextra','-Werror']
    host_runs=[]
    for sanitizer in (False,True):
        suffix='sanitized' if sanitizer else 'normal'
        flags=hostflags+(['-fsanitize=address,undefined','-fno-omit-frame-pointer'] if sanitizer else [])
        menu=out/('test_menu_'+suffix);policy=out/('test_policy_'+suffix);disabled=out/('test_disabled_'+suffix)
        run([HOST,*flags,HERE/'test_menu.c',HERE/'policy.c','-o',menu],'own_host_compile')
        run([HOST,*flags,'-pthread',HERE/'test_policy.c',HERE/'policy.c','-o',policy],'own_host_compile')
        run([HOST,*flags,HERE/'test_production_disabled.c',HERE/'runtime.c',HERE/'policy.c','-o',disabled],'own_host_compile')
        for exe,args in [(menu,[]),*[(menu,[str(i)]) for i in range(1,9)],(policy,[]),(disabled,[])]:
            text=run([exe,*args],'own_host_fixture_execution');host_runs.append(dict(sanitizer=sanitizer,executable=exe.name,args=args,result=text.strip()))
    cflags=['-target','aarch64-linux-gnu.2.28','-std=c11','-O2','-g0','-ffreestanding','-fno-stack-protector',
            '-mno-outline-atomics','-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer',
            '-fno-optimize-sibling-calls','-ffunction-sections','-fdata-sections','-fPIC','-Wall','-Wextra','-Werror']
    objects=[]
    for source,name,extra in [(HERE/'policy.c','policy.o',[]),(HERE/'runtime.c','menu_EN0.o',[]),
                              (HERE/'runtime.c','menu_EN1_inspection_only.o',['-DIQ4_F3_MENU_PRODUCTION_ENABLE=1'])]:
        obj=out/name;run([ZIG,'cc',*cflags,*extra,'-MMD','-MF',out/(name+'.d'),'-c',source,'-o',obj],'cross_compile_only');objects.append(inspect(obj))
    obj=out/'wrapper.o';run([ZIG,'cc','-target','aarch64-linux-gnu.2.28','-g0','-fPIC','-c',HERE/'wrapper.S','-o',obj],'cross_compile_only');objects.append(inspect(obj))
    wrapper_text=run([OBJ,'-d',obj],'static_disassemble_ET_REL')
    (out/'wrapper.asm').write_text('\n'.join(x.rstrip() for x in wrapper_text.splitlines())+'\n')
    for pth in (out/'policy.o',out/'menu_EN1_inspection_only.o',out/'wrapper.o'):
        text=run([OBJ,'-r',pth],'static_relocations_ET_REL');(out/(pth.name+'.relocs')).write_text('\n'.join(x.rstrip() for x in text.splitlines())+'\n')
    report=dict(schema='iq4_f3_capture_menu_build_01',original_User=row(USER),compiler=row(ZIG),
        native_contract=row(HERE/'NATIVE_CONTRACT.json'),objects=objects,host_tests=host_runs,
        production_default_EN0=True,EN1_object_purpose='static ABI inspect only; never linked/installed',
        native_complete_RAW_consumer_bound=False,native_source_lease_bound=False,
        firmware_candidate_produced=False,target_executed=False,sdk_loaded=False,device_access=False)
    (out/'BUILD.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))

if __name__=='__main__':main()
