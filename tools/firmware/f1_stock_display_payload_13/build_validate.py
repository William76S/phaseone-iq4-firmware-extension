#!/usr/bin/env python3
"""Build own ET_REL payload and run only own-memory host fixtures. No target run."""
from pathlib import Path
import hashlib,json,struct,subprocess
from native_static import collect
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
OUT=ROOT/'analysis/firmware/f1_stock_display_payload_build_13'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def elf(p):
    b=p.read_bytes();h=struct.unpack_from('<16sHHIQQQIHHHHHH',b)
    assert h[0][:6]==b'\x7fELF\x02\x01'and h[1]==1 and h[2]==183
    s=[struct.unpack_from('<IIQQQQIIQQ',b,h[6]+i*h[11])for i in range(h[12])]
    names=b[s[h[13]][4]:s[h[13]][4]+s[h[13]][5]]
    n=lambda o:names[o:names.index(0,o)].decode()
    rows=[];undefined=set();symbol_rows=[]
    for x in s:
        if x[1]!=2:continue
        st=s[x[6]];strings=b[st[4]:st[4]+st[5]]
        for o in range(x[4],x[4]+x[5],x[9]):
            no,info,other,index,value,size=struct.unpack_from('<IBBHQQ',b,o)
            name=strings[no:strings.index(0,no)].decode()if no else ''
            symbol_rows.append(dict(name=name,index=index,value=value,size=size))
            if name and index==0:undefined.add(name)
    alloc_reloc=[]
    for x in s:
        name=n(x[0]);rows.append(dict(name=name,type=x[1],flags=x[2],bytes=x[5],alignment=x[8]))
        if x[1]==4 and s[x[7]][2]&2:
            for o in range(x[4],x[4]+x[5],x[9]):
                at,info,addend=struct.unpack_from('<QQq',b,o)
                alloc_reloc.append(dict(section=n(s[x[7]][0]),offset=at,type=info&0xffffffff,
                    symbol_index=info>>32,addend=addend))
    return dict(bytes=len(b),sha256=sha(p),sections=rows,undefined=sorted(undefined),alloc_relocations=alloc_reloc,symbols=symbol_rows)
def main():
    OUT.mkdir(parents=True,exist_ok=True);commands=[]
    def run(a):
        a=list(map(str,a));commands.append(a);r=subprocess.run(a,cwd=ROOT,text=True,capture_output=True)
        assert r.returncode==0,r.stdout+r.stderr;return r.stdout
    lock=json.loads((ROOT/'tools/target/toolchain.lock.json').read_text())
    zig=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'
    assert sha(zig)==lock['zig_binary_sha256'];assert run([zig,'version']).strip()==lock['version']
    cc=[zig,'cc','-target',lock['target'],'-std=c11','-O2','-g0','-ffp-contract=off',
        '-fno-strict-aliasing','-ffreestanding','-fno-stack-protector','-mno-outline-atomics',
        '-funwind-tables','-fno-asynchronous-unwind-tables','-fno-omit-frame-pointer',
        '-fno-optimize-sibling-calls','-ffunction-sections','-fdata-sections','-fPIC',
        '-Wall','-Wextra','-Werror']
    run([*cc,'-MMD','-MF',OUT/'payload.d','-c',HERE/'payload.c','-o',OUT/'payload.o'])
    run([zig,'cc','-target',lock['target'],'-g0','-ffreestanding','-fPIC','-MMD','-MF',OUT/'wrapper.d','-c',HERE/'wrapper.S','-o',OUT/'wrapper.o'])
    tests={}
    for label,flags in [('normal',[]),('asan_ubsan',['-fsanitize=address,undefined','-fno-omit-frame-pointer'])]:
        exe=OUT/('host_'+label)
        run(['/usr/bin/clang','-std=c11','-O2','-ffp-contract=off','-Wall','-Wextra','-Werror',
             '-DIQ4_F1_DISPLAY13_HOST',*flags,HERE/'payload.c',HERE/'test_payload.c','-o',exe])
        out=run([exe]);test=json.loads(out);assert test=={'owned_host_groups':17,'passed':True,'target_executed':False}
        (OUT/(label+'_HOST.json')).write_text(json.dumps(test,indent=2)+'\n');tests[label]=test
    dump='/Library/Developer/CommandLineTools/usr/bin/llvm-objdump';objects={}
    for name in ('payload','wrapper'):
        p=OUT/(name+'.o');objects[name]=elf(p)
        (OUT/(name+'_COMPLETE.txt')).write_text(run([dump,'-dr',p]))
        assert any(s['name']=='.eh_frame'and s['bytes']for s in objects[name]['sections'])
        assert not any(s['flags']&0x400 or s['name'].startswith(('.init_array','.fini_array','.tdata','.tbss','.got')) for s in objects[name]['sections'])
        assert {r['type']for r in objects[name]['alloc_relocations']}<={261,283,275,299}
    assert objects['payload']['undefined']==['iq4_f1_mode_get_01']
    assert objects['wrapper']['undefined']==['iq4_f1_after_stock_draw_13']
    assembly=(OUT/'wrapper_COMPLETE.txt').read_text()
    assert assembly.count('blr\tx16')==1 and 'R_AARCH64_CALL26\tiq4_f1_after_stock_draw_13'in assembly
    # No branch can bypass or repeat stock call. All pre-stock instructions are
    # stores/stack setup/movz/movk; the only BLR precedes the only own-C call.
    assert assembly.index('blr\tx16')<assembly.index('R_AARCH64_CALL26\tiq4_f1_after_stock_draw_13')
    raw=(ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes()
    assert len(raw)==11874544 and hashlib.sha256(raw).hexdigest()=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    assert raw[0x51ddcc-0x400000:0x51ddd0-0x400000].hex()=='9b64fd97'
    body=run([dump,'-d','--start-address=0x51dd3c','--stop-address=0x51dde8',ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'])
    assert '0x51dde8'in body and '0x477038'in body
    (OUT/'stock_skip_and_call.txt').write_text(body)
    native_evidence=collect(ROOT,HERE,OUT,run,dump)
    result=dict(native_evidence_sha256=sha(OUT/'EXACT_NATIVE.json'),native_static_regions=len(native_evidence['regions']),schema='iq4_f1_stock_display_payload_build_13',objects=objects,tests=tests,
        target='aarch64-linux-gnu.2.28',kind='ET_REL only; combine with actual UI object and ELF backend',
        default_mode=0,accepted_surface='IQ4DisplaySurface 800x480 only; exact primary/IScreen/Draw signatures',rejected_surface=['base Surface','HdmiSurface','unknown'],display_supported_native_rotation=[0],other_rotation='factory rendering; overlay hidden',
        wrapper_stock_call_once_machine_body_checked=True,hidden_x8_input_preserved=True,
        post_stock_x0_to_x18_q0_to_q31_and_flags_restored=True,finite_EH_required=True,
        target_executed=False,sdk_executed=False,device_accessed=False,remote_accessed=False,
        stock_modified=False,card_candidate_built=False,commands=commands)
    (OUT/'BUILD.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'objects':{k:{'bytes':v['bytes'],'sha256':v['sha256'],'undefined':v['undefined']}for k,v in objects.items()},'tests':tests,'target_executed':False}))
if __name__=='__main__':main()
