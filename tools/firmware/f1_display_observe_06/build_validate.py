#!/usr/bin/env python3
"""Execute only owned host fixtures; compile/link/inspect target without loading."""
from pathlib import Path
import difflib,hashlib,json,subprocess,struct,sys
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f1_display_observe_build_06'
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def main():
    assert not(HERE/'SOURCE_SHA256.json').exists(),'frozen outputs may not be rewritten'
    OUT.mkdir(parents=True,exist_ok=True);(OUT/'.gitignore').write_text('*.o\n*.so\nhost_*\n*.bin\n')
    commands=[]
    def run(args):
        args=list(map(str,args));commands.append(args)
        p=subprocess.run(args,cwd=ROOT,text=True,capture_output=True)
        assert p.returncode==0,p.stdout+p.stderr
        return p.stdout
    dependencies={}
    for package in ('f1_observe_stack_05','f1_observe_geometry_04','f1_module_entry_01','f1_entry_button_ports_01','f1_observe_role_02'):
        lock=HERE.parent/package/'SOURCE_SHA256.json';data=json.loads(lock.read_text());dependencies[str(lock.relative_to(ROOT))]=digest(lock)
        for m in data.get('members',data.get('files',[]))+data.get('frozen_refs',[]):
            p=ROOT/m['path'];assert ('bytes'not in m or p.stat().st_size==m['bytes']) and digest(p)==m['sha256'],m['path']
            dependencies[m['path']]=m['sha256']
    core=[HERE/'observe.cpp',HERE.parent/'f1_observe_stack_05/observe.cpp',HERE.parent/'f1_observe_geometry_04/observe.cpp',HERE.parent/'f1_geometry_probe_03/probe.cpp',HERE.parent/'f1_module_entry_01/module.cpp',HERE.parent/'f1_native_ui_02/ui.cpp',HERE.parent/'f1_native_ui_02/candidates.cpp',HERE.parent/'f4_ui_bootstrap_02/bootstrap.cpp',HERE.parent/'f4_ui_counter_01/counter.cpp']
    inc=['-I',ROOT/'src/core/include','-I',ROOT/'src/display/include']
    sdk=run(['xcrun','--show-sdk-path']).strip()
    host=core+[HERE/'test_observe.cpp',HERE.parent/'f1_native_overlay_01/overlay.cpp',ROOT/'src/core/lib/image_core.cpp',ROOT/'src/display/lib/display_mask.cpp']
    common=['/usr/bin/clang++','-std=c++17','-O2','-Wall','-Wextra','-Wpedantic','-Werror','-ffunction-sections','-fdata-sections','-isystem',sdk+'/usr/include/c++/v1',*inc]
    tests={}
    for name,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=OUT/('host_'+name);fixture=OUT/('host_'+name+'_fixture.bin')
        run([*common,*flags,*host,'-o',exe]);receipt=run([exe,fixture]);assert receipt=='21 display06 owned boundary/paint/forwarding/fault groups PASS; native/target execution zero\n',receipt
        decoder=json.loads(run([sys.executable,HERE/'test_decode.py',fixture]));assert decoder['passed'] and decoder['checks']==21
        tests[name]={'decoder':decoder,'groups':21,'receipt':receipt.strip(),'fixture_bytes':fixture.stat().st_size,'fixture_sha256':digest(fixture)}
    layout_exe=OUT/'host_layout';run([*common,HERE/'layout_probe.cpp','-o',layout_exe]);layout=json.loads(run([layout_exe]));assert layout['Published']['bytes']==1440 and layout['Metadata']['bytes']==1424; (HERE/'PUBLICATION_LAYOUT.json').write_text(json.dumps(layout,indent=2)+'\n')
    tool=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text());zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
    assert digest(zig)==tool['zig_binary_sha256'] and run([zig,'version']).strip()==tool['version']
    cc=[zig,'c++','-target',tool['target'],'-std=c++17','-O2','-fPIC','-fno-omit-frame-pointer','-fvisibility=hidden','-ffunction-sections','-fdata-sections','-Wall','-Wextra','-Wpedantic','-Werror',*inc]
    flat=[];expressions=[]
    for typename,spec in layout.items():
        flat.append(spec['bytes']);expressions.append('sizeof('+typename+')')
        for field,d in spec['fields'].items():
            flat.extend((d['offset'],d['bytes']));expressions.extend(('offsetof('+typename+','+field+')','sizeof((('+typename+'*)nullptr)->'+field+')'))
    source='#include \"observe.hpp\"\n#include <cstddef>\nusing namespace iq4::f1::display06;\nnamespace geometry03=iq4::f1::geometry03;\nextern \"C\" __attribute__((used,visibility(\"default\"))) const unsigned long long iq4_display06_layout[]={'+','.join(expressions)+'};\n'
    layout_source=HERE/'layout_target.cpp';layout_source.write_text(source);layout_obj=OUT/'layout_target.o';run([*cc,'-c',layout_source,'-o',layout_obj])
    raw=layout_obj.read_bytes();header=struct.unpack_from('<16sHHIQQQIHHHHHH',raw);sh=[struct.unpack_from('<IIQQQQIIQQ',raw,header[6]+i*header[11])for i in range(header[12])];witness=None
    for section in sh:
        if section[1]!=2:continue
        strings=sh[section[6]];names=raw[strings[4]:strings[4]+strings[5]]
        for pos in range(section[4],section[4]+section[5],section[9]):
            name,info,other,index,value,size=struct.unpack_from('<IBBHQQ',raw,pos)
            if name and names[name:names.index(0,name)]==b'iq4_display06_layout':
                witness=list(struct.unpack_from('<'+'Q'*(size//8),raw,sh[index][4]+value-sh[index][3]))
    assert witness==flat,'target/host publication ABI disagreement'
    layout_proof={'target_data_words':len(flat),'target_object_sha256':digest(layout_obj),'all_target_sizeof_offsets_equal_host':True}
    objects=[]
    for i,source in enumerate(core+[HERE/'runtime_linux.cpp']):
        obj=OUT/(str(i)+'_'+source.stem+'.o');flags=['-mcpu=generic-neon-fp_armv8','-fno-optimize-sibling-calls']if source.name=='runtime_linux.cpp'else[]
        run([*cc,*flags,'-c',source,'-o',obj]);objects.append(obj)
    (OUT/'role_config.h').write_bytes((HERE.parent/'f1_observe_role_02/role_config.preview.h').read_bytes())
    ctor=OUT/'role_ctor_default_off.o';run([*cc,'-Wno-macro-redefined','-I',OUT,'-c',HERE.parent/'f1_observe_role_02/ctor_status.cpp','-o',ctor])
    so=OUT/'libiq4_f1_display_observe_06_default_off.so';run([zig,'c++','-target',tool['target'],'-nostdlib++','-shared',*objects,ctor,'-Wl,--gc-sections','-Wl,-Bsymbolic','-Wl,-z,now','-Wl,-z,relro','-o',so])
    sys.path.insert(0,str(HERE.parent/'f4_ui_bootstrap_02'));from build_validate import elf
    header,sections,exports,undefined=elf(so.read_bytes())
    assert header[1]==3 and header[2]==183
    assert set(exports)=={'pthread_mutex_unlock','iq4_f1_entry_observed','iq4_f1_geometry_observed_04','iq4_f1_stack_observed_05','iq4_f1_role_ctor_status','iq4_f1_display_observed_06','iq4_f1_display_paint_callback_06'},exports
    denied={'kill','raise','ptrace','system','popen','execve','dlopen','dlsym','ioctl','reboot','pwrite','write','pthread_create'}
    assert not set(undefined)&denied and not any(n.startswith('_ZNSt3__1')for n in undefined),undefined
    dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump'
    dynamic=run([dump,'-p',so]);(OUT/'TARGET_DYNAMIC.txt').write_text(dynamic)
    assert 'libc++.so'not in dynamic and 'libstdc++.so'not in dynamic
    names=run(['/Library/Developer/CommandLineTools/usr/bin/llvm-nm','--defined-only',so]);(OUT/'TARGET_DEFINED.txt').write_text(names)
    unlock=run([dump,'-d','--disassemble-symbols=pthread_mutex_unlock',so]);(OUT/'TARGET_UNLOCK.disasm.txt').write_text(unlock)
    assert unlock.count('\tblr\t')==2 and '\tmov\tx29, sp'in unlock and 'display069Collector16capture_boundary'in unlock
    paint=run([dump,'-d','--disassemble-symbols=iq4_f1_display_paint_callback_06',so]);(OUT/'TARGET_PAINT_CALLBACK.disasm.txt').write_text(paint)
    assert '\tadd\tx29, sp, #0x40'in paint and '\tstp\tx29, x30, [sp, #0x40]'in paint and 'tpidr_el0'in paint.lower() and 'forward_once'in paint
    # Whole helper shows a single original callback call, preserving own x8
    # Rectangle24 indirect return. It never calls the provider getter or fill.
    forward_symbol=next(line.split()[-1]for line in names.splitlines()if 'display0612forward_once'in line)
    forward=run([dump,'-d','--disassemble-symbols='+forward_symbol,so]);(OUT/'TARGET_FORWARD_ONCE.disasm.txt').write_text(forward)
    assert forward.count('\tblr\t')==1,forward
    assert '\tmov\tx23, x8'in forward and '\tadd\tx8, sp, #0x20'in forward and '\tstr\tq0, [x23]'in forward and '\tstr\tx8, [x23, #0x10]'in forward
    old_build=json.loads((ROOT/'analysis/sdk_reference/f1_observe_stack_build_05/BUILD_VALIDATION.json').read_text());added=set(undefined)-set(old_build['target']['undefined']);assert added=={'__cxa_rethrow','_Unwind_Resume'},added
    sys.path.insert(0,str(HERE.parent));from inspect_boot import Ext2
    disk=ROOT/'analysis/firmware/P1_ramdisk.ext2';assert digest(disk)=='2ca2a497fb22cb3b16009f5dab2aad1f744982aaafb6c928ac688c0a3f9dbccb';providers=[];available=set()
    for node,blob in Ext2(disk.read_bytes()).walk():
        if not node['path'].startswith(('/lib/libc-','/lib/libpthread-','/usr/lib/libstdc++.so.6.','/lib/libgcc_s.so','/usr/lib/libgcc_s.so'))or blob[:7]!=b'\x7fELF\x02\x01\x01':continue
        _,_,symbols,_=elf(blob);matched=sorted(set(undefined)&set(symbols));available.update(symbols)
        providers.append({'path':node['path'],'bytes':len(blob),'sha256':hashlib.sha256(blob).hexdigest(),'matched':matched})
    assert set(undefined)<=available,set(undefined)-available
    exception_provider={'added_undefined':sorted(added),'providers':providers,'runtime_loader_acceptance':False,'source_ramdisk_sha256':digest(disk)}
    (OUT/'STATIC_EXCEPTION_PROVIDER_ADDITION.json').write_text(json.dumps(exception_provider,indent=2)+'\n')
    for token in ('Selector10build_on_ui','Selector10open_on_ui','Adapter27after_original_paint_on_ui','Module14selector_ports','Module13overlay_ports'):
        assert token not in names,token
    diff=''.join(difflib.unified_diff((HERE.parent/'f1_observe_stack_05/runtime_linux.cpp').read_text().splitlines(True),(HERE/'runtime_linux.cpp').read_text().splitlines(True),fromfile='frozen_stack05/runtime_linux.cpp',tofile='new_display06/runtime_linux.cpp'))
    (OUT/'RUNTIME_DERIVED.diff.txt').write_text(diff)
    report={'schema':'f1_display_observe_compile_06','tests':tests,'target':{'path':str(so.relative_to(ROOT)),'bytes':so.stat().st_size,'sha256':digest(so),'exports':exports,'undefined':undefined,'role_enabled':0,'observe_env_default':'absent','paint_installer_included':False,'native_callback_executed':False},'actual_original_forward_blr_count':1,'publication_layout_proof':layout_proof,'static_exception_provider_addition':exception_provider,'strict_startup_pe_reused_or_modified':False,'production_mask_enabled':False,'full_source_mapping_verified':False,'fresh_blit_verified':False,'surface_lease_verified':False,'device_or_SDK_or_Windows_or_network_used':False,'dependencies':dependencies,'sources':{str(p.relative_to(ROOT)):digest(p)for p in core+[HERE/'runtime_linux.cpp',HERE/'observe.hpp',HERE/'native_layout.hpp',HERE/'test_observe.cpp']},'commands':commands}
    (OUT/'BUILD_VALIDATION.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({'tests':tests,'target':report['target']},indent=2))
if __name__=='__main__':main()
