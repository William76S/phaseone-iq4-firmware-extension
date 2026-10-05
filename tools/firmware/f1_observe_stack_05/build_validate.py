#!/usr/bin/env python3
"""Compile OWN host tests; compile/link/inspect AArch64 SO without loading."""
from pathlib import Path
import difflib,hashlib,json,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent;OUT=ROOT/'analysis/sdk_reference/f1_observe_stack_build_05'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    assert not(HERE/'SOURCE_SHA256.json').exists(),'frozen outputs may not be rewritten'
    OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\nhost_*\n*.bin\n');commands=[]
    def run(args):
        a=list(map(str,args));commands.append(a);p=subprocess.run(a,cwd=ROOT,text=True,capture_output=True)
        if p.returncode:raise SystemExit(p.stdout+p.stderr)
        return p.stdout
    # Frozen inputs verified as bytes before source/build use, never rewritten.
    for rel in ('f1_module_entry_01','f1_observe_geometry_04','f1_observe_role_02'):
        lock=json.loads((HERE.parent/rel/'SOURCE_SHA256.json').read_text())
        for r in lock['members']+lock['frozen_refs']:
            p=ROOT/r['path'];assert p.stat().st_size==r['bytes'] and sha(p)==r['sha256'],r['path']
    sdk=run(['xcrun','--show-sdk-path']).strip()
    core=[HERE/'observe.cpp',HERE.parent/'f1_observe_geometry_04/observe.cpp',HERE.parent/'f1_geometry_probe_03/probe.cpp',HERE.parent/'f1_module_entry_01/module.cpp',HERE.parent/'f1_native_ui_02/ui.cpp',HERE.parent/'f1_native_ui_02/candidates.cpp',HERE.parent/'f4_ui_bootstrap_02/bootstrap.cpp',HERE.parent/'f4_ui_counter_01/counter.cpp']
    inc=['-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
    common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-ffunction-sections','-fdata-sections','-isystem',sdk+'/usr/include/c++/v1',*inc]
    host=core+[HERE/'test_observe.cpp',HERE.parent/'f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp'];tests={}
    for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=OUT/('host_'+name);fixture=OUT/('host_'+name+'_fixture.bin')
        if sys.argv[1:]==['--target-only']:
            previous=json.loads((OUT/(name+'.json')).read_text());receipt=previous['cpp_receipt']+'\n';decoder=previous['decoder']
            old=json.loads((OUT/'BUILD_VALIDATION.json').read_text())['tests'][name]['fixture'];assert old['bytes']==fixture.stat().st_size and old['sha256']==sha(fixture)
        else:
            run(common+flags+host+['-o',exe]);receipt=run([exe,fixture]);decoder=json.loads(run([sys.executable,HERE/'test_decode.py',fixture]));(OUT/(name+'.json')).write_text(json.dumps({'cpp_receipt':receipt.strip(),'decoder':decoder},indent=2)+'\n')
        assert receipt=='33 Stack05 graph/source/relation/fault groups PASS; vendor/target execution zero\n' and decoder['passed'] and decoder['checks']==56
        tests[name]={'groups':33,'decoder_checks':decoder['checks'],'fixture':{'bytes':fixture.stat().st_size,'sha256':sha(fixture)},'prior_fixture':{'bytes':Path(str(fixture)+'.prior.bin').stat().st_size,'sha256':sha(Path(str(fixture)+'.prior.bin'))}}
    tool=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig';assert sha(zig)==tool['zig_binary_sha256'] and run([zig,'version']).strip()==tool['version']
    cc=[zig,'c++','-target',tool['target'],'-std=c++17','-O2','-fPIC','-fno-omit-frame-pointer','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Wpedantic','-Werror',*inc]
    objs=[]
    for i,source in enumerate(core+[HERE/'runtime_linux.cpp']):
        obj=OUT/(str(i)+'_'+source.stem+'.o');flags=['-mcpu=generic-neon-fp_armv8'] if source.name=='runtime_linux.cpp'else [];run([*cc,*flags,'-c',source,'-o',obj]);objs.append(obj)
    # Inspect the real linked wrapper below. Compiler layout is verified from
    # this exact new object, not inferred from Geo04's different local frame.
    objdump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
    # The original Role02 data-only status constructor is retained, with actual
    # original config EN0. No materializer/launcher/installation file is emitted.
    (OUT/'role_config.h').write_bytes((HERE.parent/'f1_observe_role_02/role_config.preview.h').read_bytes())
    ctor=OUT/'role_ctor_default_off.o';run([*cc,'-Wno-macro-redefined','-I',OUT,'-c',HERE.parent/'f1_observe_role_02/ctor_status.cpp','-o',ctor])
    # No enabled Role02 branch is linked or materialized for this new SO.
    so=OUT/'libiq4_f1_observe_stack_05_default_off.so';run([zig,'c++','-target',tool['target'],'-nostdlib++','-shared',*objs,ctor,'-Wl,--gc-sections','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',so])
    sys.path.insert(0,str(HERE.parent/'f4_ui_bootstrap_02'));from build_validate import elf
    raw=so.read_bytes();head,sections,exports,undefined=elf(raw)
    assert head[1]==3 and head[2]==183
    assert set(exports)=={'pthread_mutex_unlock','iq4_f1_entry_observed','iq4_f1_geometry_observed_04','iq4_f1_role_ctor_status','iq4_f1_stack_observed_05'},exports
    denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','pwrite','write','pthread_create'}
    assert not set(undefined)&denied and not any(n.startswith('_ZNSt3__1')for n in undefined),undefined
    dynamic=run([objdump,'-p',so]);(OUT/'TARGET_DYNAMIC.txt').write_text(dynamic);assert 'libc++.so'not in dynamic and 'libstdc++.so'not in dynamic
    # Inspect literal original-first call body plus bounded scalar entry. These
    # bytes are not evidence that SO was loaded or its real owners were valid.
    disasm=run([objdump,'-d','--disassemble-symbols=pthread_mutex_unlock',so]);(OUT/'TARGET_UNLOCK.disasm.txt').write_text(disasm);assert '<pthread_mutex_unlock>:'in disasm and disasm.count('\tblr\t')==2,disasm
    assert '\tmov\tx29, sp'in disasm and '\tadd\tx29, sp, #0x8'not in disasm
    indirect=[n for n,line in enumerate(disasm.splitlines())if '\tblr\t'in line];lines=disasm.splitlines();assert indirect[0]<indirect[1] and indirect[1]<next(n for n,line in enumerate(lines)if 'Module12after_unlock'in line)
    assert disasm.index('Module12after_unlock')<disasm.index('observe049Collector7capture')<disasm.index('stack059Collector7capture'),disasm
    nm=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--defined-only',so]);(OUT/'TARGET_DEFINED.txt').write_text(nm)
    # Linker GC must remove paint-scope and pointer-based native integration.
    assert 'collect_paint_scope'not in nm and 'iq4_f1_entry_concrete_ports'not in nm and 'iq4_f1_entry_button_ports'not in nm and 'iq4_f1_entry_read_metadata'not in nm
    # Verify actual symbol sizes and constructor order from exact ELF sections.
    sh=[struct.unpack_from('<IIQQQQIIQQ',raw,head[6]+i*head[11])for i in range(head[12])];sym=sections['.symtab'];strings=sh[sym[6]];names=raw[strings[4]:strings[4]+strings[5]];symbols={};labels={}
    for pos in range(sym[4],sym[4]+sym[5],sym[9]):
        name,info,other,index,value,size=struct.unpack_from('<IBBHQQ',raw,pos)
        if name and index:
            text=names[name:names.index(0,name)].decode();symbols[text]={'value':value,'size':size}
            if info&15==2:labels[value]=text
    assert symbols['iq4_f1_entry_observed']['size']==440 and symbols['iq4_f1_geometry_observed_04']['size']==760 and symbols['iq4_f1_stack_observed_05']['size']==1192
    init=sections['.init_array'];rela=sections['.rela.dyn'];pointers={}
    for pos in range(rela[4],rela[4]+rela[5],24):
        address,info,addend=struct.unpack_from('<QQq',raw,pos)
        if init[3]<=address<init[3]+init[5]:assert info==1027;pointers[address]=addend
    order=[labels[pointers[init[3]+8*i]]for i in range(init[5]//8)]
    assert len(order)==1 and 'prepare'in order[0],order
    assert sum(struct.unpack_from('<QQq',raw,pos)[1]&0xffffffff==1031 for pos in range(rela[4],rela[4]+rela[5],24))==1
    # Only static rootfs exported-symbol availability; no runtime loader proof.
    sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
    disk=ROOT/'analysis/firmware/P1_ramdisk.ext2';assert sha(disk)=='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb'
    available=set();providers=[]
    for n,b in Ext2(disk.read_bytes()).walk():
        if n['path'].startswith(('/lib/libc-','/lib/libpthread-','/usr/lib/libstdc++.so.6.'))and b[:7]==b'\x7fELF\x02\x01\x01':
            _,_,e,_=elf(b);available.update(e);providers.append({'path':n['path'],'bytes':len(b),'sha256':hashlib.sha256(b).hexdigest(),'matched':sorted(set(undefined)&set(e))})
    assert set(undefined)<=available,set(undefined)-available
    report={'schema':'f1_observe_stack_target_compile_05','host_tests_reused_not_rerun':sys.argv[1:]==['--target-only'], 'host_receipts':[{"path":str((OUT/(n+'.json')).relative_to(ROOT)),"bytes":(OUT/(n+'.json')).stat().st_size,"sha256":sha(OUT/(n+'.json'))}for n in ('normal','asan_ubsan')],'camera_access':False,'SDK_started':False,'target_loaded':False,'vendor_code_executed':False,'installer_emitted':False,'production_mask_enabled':False,'paint_scope_called':False,'full_source_mapping_verified':False,'fresh_blit_verified':False,'surface_lease_verified':False,'tests':tests,'target':{'path':str(so.relative_to(ROOT)),'bytes':so.stat().st_size,'sha256':sha(so),'exports':exports,'undefined':undefined,'init_order':order,'publication_symbols':{n:symbols[n]for n in ('iq4_f1_entry_observed','iq4_f1_geometry_observed_04','iq4_f1_stack_observed_05')},'role_enabled':0,'UI_observe_default_env':'absent','runtime_resolution_verified':False},'actual_wrapper_inspection':{'original_unlock_blr_count':1,'subsequent_owned_TLS_descriptor_blr_count':1,'single_R_AARCH64_TLSDESC':True,'first_call_original_before_TLS_and_inspection':True,'runtime_TU_CPU':'generic-neon-fp_armv8','actual_FP_is_SP_16byte_aligned':True},'static_rootfs_provider_witness':providers,'commands':commands,'sources':{str(p.relative_to(ROOT)):sha(p)for p in core+[HERE/'observe.hpp',HERE/'home_tables.hpp',HERE/'runtime_linux.cpp',HERE.parent/'f1_observe_role_02/ctor_status.cpp']}}
    (OUT/'BUILD_VALIDATION.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'tests':tests,'target':report['target']},indent=2))
if __name__=='__main__':main()
