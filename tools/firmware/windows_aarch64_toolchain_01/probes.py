#!/usr/bin/env python3
"""Only the frozen public EN0 record1 ELF and known synthetic IO ET_REL.

No actual EEPROM/profile inputs, execution, generic command or SDK binding.
"""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import struct
import subprocess
import sys

HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2];R1=ROOT/'tools/firmware/record1_ram_restore_01'
SOURCE_PATHS=['tools/firmware/record1_ram_restore_01/target.c','tools/firmware/record1_ram_restore_01/engine.c',
 'tools/firmware/record1_ram_restore_01/engine.h','tools/firmware/record1_ram_restore_01/config.preview.h',
 'tools/firmware/record1_ram_restore_01/generate.py','tools/firmware/record1_ram_restore_01/test_binding.py',
 'tools/firmware/record1_ram_restore_01/test_engine.py','tools/firmware/f4_ram_entry_02/sha256.h',
 'tools/firmware/f4_ram_entry_01/readonly_monitor.c','tools/firmware/audit_security_record1_range.py',
 'tools/firmware/validate_security_eeprom_structure.py']

def sha(b):return hashlib.sha256(b).hexdigest()
def source_check():
    locked=json.loads((HERE/'source_dependencies.json').read_text())
    if locked.get('schema')!='iq4_windows_public_source_dependencies_v1' or set(locked.get('files',{}))!=set(SOURCE_PATHS):raise ValueError('finite source set changed')
    for rel,digest in locked['files'].items():
        p=ROOT/rel
        if p.is_symlink() or sha(p.read_bytes())!=digest:raise ValueError('public source changed')
    return locked['files']

def inspect_elf(path,kind):
    b=path.read_bytes()
    if len(b)<64 or b[:6]!=b'\x7fELF\x02\x01' or struct.unpack_from('<HH',b,16)!=(kind,183):raise ValueError('ELF type/machine mismatch')
    shoff=struct.unpack_from('<Q',b,40)[0];shsize,shcount=struct.unpack_from('<HH',b,58)
    if shsize!=64 or not 0<shcount<4096 or shoff+shsize*shcount>len(b):raise ValueError('ELF section extent')
    sections=[struct.unpack_from('<IIQQQQIIQQ',b,shoff+i*shsize) for i in range(shcount)]
    for s in sections:
        if s[1]!=8 and s[4]+s[5]>len(b):raise ValueError('ELF section bounds')
    def string(data,offset):
        if not 0<=offset<len(data):raise ValueError('ELF string bounds')
        end=data.find(b'\0',offset)
        if end<0:raise ValueError('ELF unterminated string')
        return data[offset:end].decode('ascii')
    imports=set();needed=set();versions=set()
    for s in sections:
        if s[1] in (2,11):
            if s[9]!=24 or s[5]%24 or s[6]>=shcount:raise ValueError('ELF symbol bounds')
            st=sections[s[6]];strings=b[st[4]:st[4]+st[5]]
            for off in range(s[4],s[4]+s[5],24):
                name,info,other,index,value,size=struct.unpack_from('<IBBHQQ',b,off)
                if index==0 and name and info>>4:imports.add(string(strings,name))
        if s[1]==6:
            if s[9]!=16 or s[5]%16 or s[6]>=shcount:raise ValueError('ELF dynamic bounds')
            st=sections[s[6]];strings=b[st[4]:st[4]+st[5]]
            for off in range(s[4],s[4]+s[5],16):
                tag,value=struct.unpack_from('<QQ',b,off)
                if tag==1:needed.add(string(strings,value))
            for value in strings.split(b'\0'):
                if value.startswith(b'GLIBC_'):
                    version=value.decode('ascii')
                    if not version[6:].replace('.','').isdigit():raise ValueError('Unknown glibc requirement')
                    if tuple(map(int,version[6:].split('.')))>(2,17):raise ValueError('glibc target requirement exceeds2.17')
                    versions.add(version)
    interp=None
    if kind==3:
        phoff=struct.unpack_from('<Q',b,32)[0];phsize,phcount=struct.unpack_from('<HH',b,54)
        if phsize!=56 or not phcount or phoff+phsize*phcount>len(b):raise ValueError('ELF program headers')
        for i in range(phcount):
            p=struct.unpack_from('<IIQQQQQQ',b,phoff+i*56)
            if p[0]==3:
                if p[2]+p[5]>len(b):raise ValueError('ELF interpreter bounds')
                value=b[p[2]:p[2]+p[5]]
                if value!=b'/lib/ld-linux-aarch64.so.1\0':raise ValueError('ELF interpreter mismatch')
                interp=value[:-1].decode('ascii')
        if interp is None or not needed or needed!={'libc.so.6'}:raise ValueError('ELF loader/dependency contract')
    return {'ELF_type':kind,'machine':183,'sha256':sha(b),'bytes':len(b),'undefined_symbols':sorted(imports),
      'needed':sorted(needed),'glibc_versions':sorted(versions),'interpreter':interp}

def build(compiler,out,compiler_sha,Windows_actual=False):
    sources=source_check()
    if sha(compiler.read_bytes())!=compiler_sha:raise ValueError('compiler changed before build')
    if out.exists():raise ValueError('probe output must be fresh')
    out.mkdir(parents=True)
    config=(R1/'config.preview.h').read_text()
    if '#define R1_BOUND_READ 0\n' not in config or '#define R1_BOUND_WRITE 0\n' not in config:raise ValueError('preview must stay EN0')
    (out/'config.h').write_text(config)
    env=dict(os.environ);env['ZIG_GLOBAL_CACHE_DIR']=str(out/'.zig-cache/global');env['ZIG_LOCAL_CACHE_DIR']=str(out/'.zig-cache/local')
    temp=out/'.tmp';temp.mkdir()
    for k in ['TMP','TEMP','TMPDIR']:env[k]=str(temp)
    common=[str(compiler),'cc','-target','aarch64-linux-gnu.2.17','-std=c11','-O2','-Wall','-Wextra','-Werror',
      '-ffile-prefix-map='+str(out)+'=/iq4_windows_public_probe','-I'+str(out)]
    parser=ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c'
    with (out/'compiler_public.log').open('wb') as log:
        subprocess.run(common+['-fPIE','-pie','-Wl,--build-id=sha1','-DF4_MONITOR_PARSER_ONLY',str(R1/'target.c'),str(R1/'engine.c'),str(parser),'-o',str(out/'record1_EN0.elf')],check=True,env=env,stdout=log,stderr=log,timeout=300)
        # Known opaque-fixture!! only; never Root actual originals/profile.
        sys.path.insert(0,str(R1))
        import test_binding as fixtures
        proof,image,receipt=fixtures.fixture_proof();off,opaque,role=fixtures.g.validate(proof,image,image,lambda _:receipt)
        synthetic=fixtures.g.private_config(proof,off,opaque,role)
        if 'SYNTHETIC_ONLY' not in synthetic or 'synthetic-eeprom' not in synthetic:raise ValueError('synthetic fixture changed')
        (out/'config.h').write_text(synthetic)
        wrapper='#define main r1_compile_only_entry\n#include '+json.dumps(str(R1/'target.c'))+'\n'
        (out/'synthetic_io.c').write_text(wrapper)
        subprocess.run(common+['-fPIC','-c',str(out/'synthetic_io.c'),'-o',str(out/'synthetic_io.o')],check=True,env=env,stdout=log,stderr=log,timeout=300)
    preview=inspect_elf(out/'record1_EN0.elf',3);synthetic=inspect_elf(out/'synthetic_io.o',1)
    prohibited={'kill','raise','ptrace','system','popen','execvp','execve','dlopen','ioctl','reboot','fsync','ftruncate','truncate','pthread_create'}
    if set(preview['undefined_symbols'])&({'open','pread','pwrite','read','readlink','write','flock'}|prohibited):raise ValueError('EN0 retained device IO')
    if set(synthetic['undefined_symbols'])&prohibited or not {'pread','pwrite'}.issubset(synthetic['undefined_symbols']):raise ValueError('synthetic IO contract changed')
    result={'schema':'iq4_windows_zig_public_cross_build_v1','Windows_compiler_actual':Windows_actual,
      'compiler_whole_sha256':compiler_sha,'target':'aarch64-linux-gnu.2.17','public_source_sha256':sources,
      'EN0':preview,'synthetic_ET_REL':synthetic,'actual_private_profile_emitted':False,
      'target_executed':False,'device_accessed':False,'private_originals_read':False}
    (out/'build.json').write_text(json.dumps(result,indent=2)+'\n')
    return {'public_cross_build_verified':True,'Windows_compiler_actual':Windows_actual,'EN0_sha256':preview['sha256'],
      'synthetic_ET_REL_sha256':synthetic['sha256'],'actual_private_profile_emitted':False,'target_executed':False,'device_accessed':False}
