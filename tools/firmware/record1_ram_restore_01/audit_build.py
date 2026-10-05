#!/usr/bin/env python3
"""Compile target IO branches with known synthetic constants into ET_REL.

No actual original, enabled installation ELF, target execution or transport.
"""
import importlib.util
import json
import os
from pathlib import Path
import struct
import subprocess
import sys
import tempfile

HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(HERE))
import generate as g
import test_binding as fixtures
spec=importlib.util.spec_from_file_location('ram02_audit',HERE.parent/'f4_ram_entry_02/audit_build.py')
a=importlib.util.module_from_spec(spec);spec.loader.exec_module(a)

def main():
    if g.sha(g.ZIG.read_bytes())!=g.ZIG_SHA:raise SystemExit('Locked compiler mismatch')
    out=g.OUT/'compile_audit';out.mkdir(parents=True,exist_ok=True)
    proof,image,receipt=fixtures.fixture_proof()
    offset,opaque,role=g.validate(proof,image,image,lambda _:receipt)
    config=g.private_config(proof,offset,opaque,role)
    if 'SYNTHETIC_ONLY' not in config or 'synthetic-eeprom' not in config:raise SystemExit('Synthetic fixture changed')
    env=dict(os.environ);env['ZIG_GLOBAL_CACHE_DIR']=str(g.OUT/'.zig-cache/global');env['ZIG_LOCAL_CACHE_DIR']=str(g.OUT/'.zig-cache/local')
    with tempfile.TemporaryDirectory(prefix='iq4_r1_compile_only_') as directory:
        d=Path(directory);(d/'config.h').write_text(config)
        # No main symbol or constructor; this relocatable object cannot be
        # installed/executed. The actual production target IO is compiled.
        (d/'all_branches.c').write_text('#define main r1_compile_only_entry\n#include '+json.dumps(str(HERE/'target.c'))+'\n')
        target=out/'all_branches.o'
        subprocess.run([str(g.ZIG),'cc','-target','aarch64-linux-gnu.2.17','-std=c11','-O2','-Wall','-Wextra','-Werror','-fPIC',
                        '-ffile-prefix-map='+str(d)+'=/iq4_r1_compile_only','-I'+str(d),'-c',str(d/'all_branches.c'),'-o',str(target)],check=True,env=env)
    b=target.read_bytes();kind,machine=struct.unpack_from('<HH',b,16)
    if kind!=1 or machine!=183:raise SystemExit('Compile audit must be AArch64 ET_REL')
    names=a.undefined(b)
    prohibited={'kill','raise','ptrace','system','popen','execvp','execve','dlopen','ioctl','reboot','fsync','ftruncate','truncate','pthread_create'}
    if set(names)&prohibited or 'pwrite' not in names or 'pread' not in names:raise SystemExit('IO import contract changed')
    if (HERE/'target.c').read_text().count('pwrite(')!=1:raise SystemExit('Write syscall contract changed')
    g.dump(out/'build.json',{'schema':'iq4_record1_all_branches_compile_only_v1','ELF_type':kind,'machine':machine,
      'object_sha256':g.sha(b),'object_bytes':len(b),'undefined_symbols':names,
      'not_installable_object_no_main_no_constructor':True,'synthetic_fixture_only':True,
      'actual_private_profile_emitted':False,'device_accessed':False,'target_executed':False,
      'source_sha256':g.sha((HERE/'target.c').read_bytes()),'toolchain_sha256':g.ZIG_SHA})
    print(json.dumps({'all_branches_object_sha256':g.sha(b),'imports':len(names),'target_executed':False}))

if __name__=='__main__':main()
