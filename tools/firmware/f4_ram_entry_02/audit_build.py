#!/usr/bin/env python3
"""Compile all mutation/launch branches into a non-executable ELF object only.

Synthetic nonzero compile constants ensure code generation; never device
receipts, installer, execution, shared module or enabled output package.
"""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import struct
import subprocess
import tempfile

HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('f4_build02',HERE/'generate.py')
g=importlib.util.module_from_spec(spec);spec.loader.exec_module(g)

def undefined(b):
    offset=struct.unpack_from('<Q',b,40)[0];size,count=struct.unpack_from('<HH',b,58)
    sections=[struct.unpack_from('<IIQQQQIIQQ',b,offset+i*size) for i in range(count)]
    names=set()
    for s in sections:
        if s[1] not in (2,11):continue
        strs=sections[s[6]];strings=b[strs[4]:strs[4]+strs[5]]
        for off in range(s[4],s[4]+s[5],s[9]):
            name,info,other,index,value,n=struct.unpack_from('<IBBHQQ',b,off)
            if index==0 and name and info>>4:
                names.add(strings[name:strings.index(0,name)].decode('ascii'))
    return sorted(names)

def main():
    if g.sha(g.ZIG.read_bytes())!=g.ZIG_SHA:raise SystemExit('Unknown locked compiler')
    out=g.OUT/'compile_audit';out.mkdir(parents=True,exist_ok=True)
    env=dict(os.environ);env['ZIG_GLOBAL_CACHE_DIR']=str(g.OUT/'.zig-cache/global');env['ZIG_LOCAL_CACHE_DIR']=str(g.OUT/'.zig-cache/local')
    with tempfile.TemporaryDirectory(prefix='f4_compile_only02_') as directory:
        d=Path(directory);config=(HERE/'config.preview.h').read_text()
        for name in ['F4_ENABLED','F4_ROOT_MOUNT_ID','F4_RUN_MOUNT_ID','F4_RUN_MINOR','F4_OLD_PID','F4_OLD_TICKS','F4_RUNNER_INODE']:
            config=re.sub(r'^#define '+name+r' .+$','#define '+name+' 2ULL',config,flags=re.M)
        # This .o has no main or constructors and is not an installation ELF.
        (d/'config.h').write_text(config)
        (d/'all_branches.c').write_text('#define F4_NO_MAIN\n#include '+json.dumps(str(HERE/'entry.c'))+'\nint (*const f4_compile_only_branches[])(void)={arm,launch,disable,stage_launcher};\n')
        target=out/'all_branches.o'
        subprocess.run([str(g.ZIG),'cc','-target','aarch64-linux-gnu.2.17','-std=c11','-O2','-Wall','-Wextra','-Werror',
                        '-fPIC','-ffile-prefix-map='+str(d)+'=/iq4_f4_compile_only','-I'+str(d),'-c',str(d/'all_branches.c'),'-o',str(target)],check=True,env=env)
    b=target.read_bytes();summary=g.elf_summary(target)
    if summary['ELF_type']!=1:raise SystemExit('Compile audit must stay ET_REL')
    names=undefined(b)
    denied={'kill','raise','ptrace','system','popen','execvp','dlopen','ioctl','setenv','unsetenv','pthread_create'}
    if set(names)&denied:raise SystemExit('Unexpected prohibited import')
    receipt={'schema':'iq4_f4_all_branches_compile_only_v2','target':summary,'undefined_symbols':names,
             'not_installable_object_no_main_no_constructor':True,'synthetic_constants_not_actual_receipts':True,
             'device_accessed':False,'target_executed':False,
             'sources':{str(p.relative_to(g.ROOT)):g.sha(p.read_bytes()) for p in [HERE/'entry.c',HERE/'sha256.h',HERE/'config.preview.h',HERE/'audit_build.py']}}
    g.dump(out/'build.json',receipt)
    print(json.dumps({'all_branches_object_sha256':summary['sha256'],'imports':len(names),'target_executed':False}))

if __name__=='__main__':main()
