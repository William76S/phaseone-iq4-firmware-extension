#!/usr/bin/env python3
"""Host status tests + target-only compile/link/inspect. No loading/execution."""
from pathlib import Path
import hashlib,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/sdk_reference/f1_observe_role_build_02'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    commands=[]
    def run(args):
        a=list(map(str,args));commands.append(a);p=subprocess.run(a,text=True,cwd=ROOT,capture_output=True)
        if p.returncode:raise SystemExit(p.stdout+p.stderr)
        return p.stdout
    source_lock=json.loads((ROOT/'tools/firmware/f1_module_entry_01/SOURCE_SHA256.json').read_text())
    for r in source_lock['members']+source_lock['frozen_refs']:
        p=ROOT/r['path'];assert p.stat().st_size==r['bytes'] and sha(p)==r['sha256']
    run([sys.executable,HERE/'materialize.py'])
    test=OUT/'host_status';run(['/usr/bin/clang','-std=c11','-O2','-Wall','-Wextra','-Werror',HERE/'test_status.c','-o',test]);result=run([test]);assert result=='26 finite constructor status checks PASS; no target/vendor execution\n';(OUT/'status_host.txt').write_text(result)
    lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
    c=[zig,'cc','-target',lock['target'],'-std=c11','-O2','-Wall','-Wextra','-Werror','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections']
    parser=OUT/'parser.o';run([*c,'-DF4_MONITOR_PARSER_ONLY','-c',ROOT/'tools/firmware/f4_ram_entry_01/readonly_monitor.c','-o',parser])
    entry=OUT/'entry_preview.o';run([*c,'-I',OUT,'-I',ROOT/'tools/firmware/f4_ram_entry_02','-c',OUT/'entry.c','-o',entry])
    # Explicit enabled branch ET_REL only, with no installation artifact. This
    # proves the ownership code compiles rather than optimizing it away at EN0.
    enabled=OUT/'enabled_branch_config';enabled.mkdir(exist_ok=True);(enabled/'role_config.h').write_text((HERE/'role_config.preview.h').read_text().replace('F1_ROLE_ENABLED 0','F1_ROLE_ENABLED 1'));(enabled/'config.h').write_text((OUT/'config.h').read_text().replace('F4_ENABLED 0','F4_ENABLED 1'))
    (enabled/'entry.c').write_bytes((OUT/'entry.c').read_bytes())
    # O0 preserves all branch bodies with intentionally zero/unverified inode
    # and mount gates. It is ET_REL only, never an enabled runnable artifact.
    all_entry=OUT/'entry_enabled_branch_ET_REL_only.o';run([*c,'-O0','-I',enabled,'-I',OUT,'-I',ROOT/'tools/firmware/f4_ram_entry_02','-c',enabled/'entry.c','-o',all_entry])
    branch_symbols=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only',all_entry]);assert ' rename' in branch_symbols and ' execve' in branch_symbols
    (OUT/'ENTRY_ENABLED_IMPORTS.txt').write_text(branch_symbols)
    cc=[zig,'c++','-target',lock['target'],'-std=c++17','-O2','-fPIC','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Werror','-Wno-macro-redefined','-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
    ctor=OUT/'ctor_all_branches.o';run([*cc,'-I',enabled,'-c',HERE/'ctor_status.cpp','-o',ctor])
    inactive=OUT/'ctor_default_off.o';run([*cc,'-I',OUT,'-c',HERE/'ctor_status.cpp','-o',inactive])
    # Default-off composed SO only. Reuse exact already-linked Entry01 objects;
    # actual inode/source/hash receipts still required before a enabled build.
    core=ROOT/'analysis/sdk_reference/f1_module_entry_build_01';core_report=json.loads((core/'BUILD_VALIDATION.json').read_text())
    # Recompile exact frozen Entry01 command inputs. Ignored old object files
    # are not a provenance authority and are never accepted as substitutes.
    objs=[]
    for command in core_report['commands']:
        if '-c' in command and command[-1].endswith('.aarch64.o'):
            a=list(command);obj=OUT/('core_'+Path(command[-1]).name);a[-1]=str(obj);run(a);objs.append(obj)
    assert len(objs)==6
    so=OUT/'libiq4_f1_observe_role02_default_off.so';run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*objs,inactive,parser,'-Wl,--gc-sections','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',so])
    sys.path.insert(0,str(ROOT/'tools/firmware/f4_ui_bootstrap_02'));from build_validate import elf
    _,sections,exports,undefined=elf(so.read_bytes());assert set(exports)==set(core_report['target_SO']['exports'])|{'iq4_f1_role_ctor_status'};assert sections['.init_array'][5] in (8,16)
    assert not any(n.startswith('_ZNSt3__1')for n in undefined)
    dynamic=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-p',so]);(OUT/'TARGET_DYNAMIC.txt').write_text(dynamic)
    # Inspect the enabled constructor object without loading it or linking it
    # into a target artifact. Its calls are actual OS APIs, no vendor aliases.
    disasm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-dr',ctor]);(OUT/'CTOR_ENABLED_OBJECT.disasm.txt').write_text(disasm)
    symbols=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--undefined-only',ctor]);(OUT/'CTOR_ENABLED_IMPORTS.txt').write_text(symbols)
    assert all(name not in symbols for name in ('pthread_create','dlopen','dlsym','system','popen','ioctl','pwrite','kill'))
    candidate=OUT/'libiq4_f1_observe_role02_ctor_candidate.so';run([zig,'c++','-target',lock['target'],'-nostdlib++','-shared',*objs,ctor,parser,'-Wl,--gc-sections','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',candidate])
    raw=candidate.read_bytes();head,candidate_sections,ce,cu=elf(raw);assert set(ce)==set(exports) and candidate_sections['.init_array'][5]==16
    init=candidate_sections['.init_array'];rela=candidate_sections['.rela.dyn'];pointers={}
    for pos in range(rela[4],rela[4]+rela[5],24):
        address,info,addend=struct.unpack_from('<QQq',raw,pos)
        if init[3]<=address<init[3]+init[5]:assert info==1027;pointers[address]=addend
    syms=candidate_sections['.symtab'];sh=[struct.unpack_from('<IIQQQQIIQQ',raw,head[6]+i*head[11])for i in range(head[12])];names_section=sh[syms[6]];names=raw[names_section[4]:names_section[4]+names_section[5]];labels={}
    for pos in range(syms[4],syms[4]+syms[5],syms[9]):
        name,info,other,index,value,size=struct.unpack_from('<IBBHQQ',raw,pos)
        if name and index and info&15==2:labels[value]=names[name:names.index(0,name)].decode()
    order=[labels[pointers[init[3]+8*i]] for i in range(2)];assert 'prepare' in order[0] and 'role_constructor' in order[1],order
    (OUT/'CANDIDATE_INIT_ORDER.json').write_text(json.dumps({'actual_ELF_sha256':sha(candidate),'R_AARCH64_RELATIVE_init_array_order':order,'module_prepare_precedes_authenticated_status':True,'target_loaded':False},indent=2)+'\n')
    candidate_dynamic=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-p',candidate]);(OUT/'CANDIDATE_DYNAMIC.txt').write_text(candidate_dynamic);assert 'libc++.so' not in candidate_dynamic and 'libstdc++.so' not in candidate_dynamic
    # Static availability only, not actual rootfs/runtime loader resolution.
    sys.path.insert(0,str(ROOT/'tools/firmware'));from inspect_boot import Ext2
    disk=ROOT/'analysis/firmware/P1_ramdisk.ext2';assert sha(disk)=='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'
    available=set();providers=[]
    for n,b in Ext2(disk.read_bytes()).walk():
        if n['path'].startswith(('/lib/libc-','/lib/libpthread-','/usr/lib/libstdc++.so.6.')) and b[:7]==b'\x7fELF\x02\x01\x01':
            _,_,names,_=elf(b);available.update(names);providers.append({'path':n['path'],'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest(),'matched':sorted(set(cu)&set(names))})
    assert set(cu)<=available,set(cu)-available
    (OUT/'PACKAGE_SYMBOLS.json').write_text(json.dumps({'runtime_resolution_proven':False,'rootfs_sha256':sha(disk),'providers':providers,'candidate_all_undefined_present':True},indent=2)+'\n')
    report={'schema':'iq4_f1_observe_role_target_compile_02','camera_access':False,'SDK_started':False,'target_loaded':False,'installer_emitted':False,'preview_F4_ENABLED':0,'preview_F1_ROLE_ENABLED':0,'enabled_launcher_ET_REL_only':True,'constructor_candidate_SO_not_installation':True,'host_status_tests':26,'host_status_receipt':result.strip(),'composed_default_off_SO':{'path':str(so.relative_to(ROOT)),'bytes':so.stat().st_size,'sha256':sha(so),'exports':exports,'undefined_symbols':undefined,'init_array_bytes':sections['.init_array'][5]},'ctor_candidate_SO':{'path':str(candidate.relative_to(ROOT)),'bytes':candidate.stat().st_size,'sha256':sha(candidate),'exports':ce,'undefined_symbols':cu,'init_array_bytes':16,'init_order':order,'loading_not_authorized':True},'inputs':{'entry01_SO_sha256':core_report['target_SO']['sha256'],'entry01_objects':{x.name:sha(x) for x in objs}},'artifacts':{x.name:{'bytes':x.stat().st_size,'sha256':sha(x)} for x in (parser,entry,all_entry,ctor,inactive)},'commands':commands}
    (OUT/'BUILD_VALIDATION.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report['composed_default_off_SO'],indent=2))
if __name__=='__main__':main()
