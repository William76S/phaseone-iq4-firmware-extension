#!/usr/bin/env python3
"""Run actual wrapper A64 with explicit before/append/after call fixtures."""
from pathlib import Path
import argparse,hashlib,json,struct,importlib.util,sys
from unicorn import Uc,UC_ARCH_ARM64,UC_MODE_ARM,UC_HOOK_CODE
from unicorn.arm64_const import *
ROOT=Path(__file__).resolve().parents[3]
HERE=Path(__file__).resolve().parent
def row(p):
    b=p.read_bytes();return dict(path=str(p.relative_to(ROOT)),bytes=len(b),sha256=hashlib.sha256(b).hexdigest())
def main():
    ap=argparse.ArgumentParser();ap.add_argument('--build',type=Path,required=True);a=ap.parse_args();out=a.build.resolve()
    loader=importlib.util.spec_from_file_location('half_menu_ELF',ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py');m=importlib.util.module_from_spec(loader);sys.modules[loader.name]=m;loader.loader.exec_module(m)
    p=out/'wrapper.o';e=m.Elf(p.read_bytes(),1,'new53 size wrapper');u=Uc(UC_ARCH_ARM64,UC_MODE_ARM)
    code=0x4300000;cursor=code;u.mem_map(code,0x20000);u.mem_map(0x4e5000,0x1000);u.mem_map(0x4f0000,0x1000)
    defs={'iq4_stock_jpeg_size_child_02':code+0x1f000,
        'iq4_stock_jpeg_original_append_02':0x4e58b8,
        'iq4_stock_jpeg_after_menu_append_01':code+0x1f100}
    base={}
    for i,s in enumerate(e.sh):
        if s[2]&2 and s[5]:
            alignment=max(s[8],4);cursor=(cursor+alignment-1)&~(alignment-1);base[i]=cursor
            if s[1]!=8:u.mem_write(cursor,e.data[s[4]:s[4]+s[5]])
            cursor+=s[5]
    symtab={}
    for i,s in enumerate(e.sh):
        if s[1]==2:
            syms=[]
            for no,info,other,ndx,value,size,name in e.symbols(i):
                syms.append((name,ndx,value))
                if name and ndx in base:defs[name]=base[ndx]+value
            symtab[i]=syms
    for s in e.sh:
        if s[1]!=4 or s[7] not in base:continue
        for off in range(s[4],s[4]+s[5],24):
            ro,info,addend=struct.unpack_from('<QQq',e.data,off);kind=info&0xffffffff
            name,ndx,value=symtab[s[6]][info>>32];place=base[s[7]]+ro;target=(base[ndx]+value if ndx in base else defs[name])+addend
            if kind==283:
                delta=target-place;assert delta%4==0 and -(1<<27)<=delta<(1<<27)
                u.mem_write(place,struct.pack('<I',0x94000000|((delta//4)&0x3ffffff)))
            elif kind==261:u.mem_write(place,struct.pack('<I',(target-place)&0xffffffff))
            else:raise AssertionError((name,kind))
    stack=0x30000000;u.mem_map(stack,0x10000);stop=0x4f052c
    GP=[UC_ARM64_REG_X0+i for i in range(29)]+[UC_ARM64_REG_X29,UC_ARM64_REG_X30]
    original=[];vectors=[];selected_child=0;trace=[];result_gp=[];result_q=[]
    def volatile(seed):
        for i in range(19):u.reg_write(GP[i],seed+i)
        for i in range(32):u.reg_write(UC_ARM64_REG_Q0+i,(seed<<64)+i)
        u.reg_write(UC_ARM64_REG_NZCV,0x90000000)
    def hook(uc,pc,size,ctx):
        lr=uc.reg_read(UC_ARM64_REG_LR)
        if pc==defs['iq4_stock_jpeg_size_child_02']:
            assert [uc.reg_read(GP[i])for i in range(3)]==[original[0],original[1],stop]
            trace.append('before_size_selection');volatile(0x11000)
            uc.reg_write(UC_ARM64_REG_X0,selected_child);uc.reg_write(UC_ARM64_REG_PC,lr)
        elif pc==defs['iq4_stock_jpeg_original_append_02']:
            assert uc.reg_read(UC_ARM64_REG_X0)==original[0]
            assert uc.reg_read(UC_ARM64_REG_X1)==selected_child
            assert all(uc.reg_read(GP[i])==original[i]for i in range(2,30))
            assert all(uc.reg_read(UC_ARM64_REG_Q0+i)==vectors[i]for i in range(32))
            assert uc.reg_read(UC_ARM64_REG_NZCV)==0xa0000000
            trace.append('original_append_once');volatile(0x22000)
            uc.reg_write(UC_ARM64_REG_NZCV,0x50000000)
            result_gp[:]=[uc.reg_read(r)for r in GP];result_q[:]=[uc.reg_read(UC_ARM64_REG_Q0+i)for i in range(32)]
            uc.reg_write(UC_ARM64_REG_PC,lr)
        elif pc==defs['iq4_stock_jpeg_after_menu_append_01']:
            assert [uc.reg_read(GP[i])for i in range(3)]==[original[0],original[1],stop]
            trace.append('existing_export_menu_attachment');volatile(0x33000);uc.reg_write(UC_ARM64_REG_PC,lr)
    u.hook_add(UC_HOOK_CODE,hook);results=[]
    for replace in [False,True]:
        sp=stack+0xf000;original[:]=[0x8800000000000000+i for i in range(31)]
        original[0]=0x21111000;original[1]=0x21112000;original[29]=stack+0xf200;original[30]=stop
        selected_child=0x21113000 if replace else original[1]
        for i,value in enumerate(original):u.reg_write(GP[i],value)
        vectors[:]=[(0x123456789abcdef0123456789abcdef0+i)&((1<<128)-1)for i in range(32)]
        for i,value in enumerate(vectors):u.reg_write(UC_ARM64_REG_Q0+i,value)
        u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_NZCV,0xa0000000);trace=[]
        u.emu_start(defs['iq4_stock_jpeg_size_append_wrapper_02'],stop,count=2000)
        assert uc_at_stop(u,stop) and u.reg_read(UC_ARM64_REG_SP)==sp
        assert trace==['before_size_selection','original_append_once','existing_export_menu_attachment']
        assert all(u.reg_read(GP[i])==result_gp[i]for i in range(29))
        assert u.reg_read(GP[29])==original[29] and u.reg_read(GP[30])==stop
        assert all(u.reg_read(UC_ARM64_REG_Q0+i)==result_q[i]for i in range(32))
        assert u.reg_read(UC_ARM64_REG_NZCV)==0x50000000
        results.append(dict(replacement=replace,chosen_child=hex(selected_child),call_order=trace,
            original_append_count=1,original_append_result_preserved=True,SP_preserved=True,passed=True))
    report=dict(schema='iq4_half_size_menu_A64_wrapper_02',object=row(p),proof_source=row(HERE/'prove_wrapper.py'),cases=results,
        actual_target_wrapper_executed=True,external_fixtures=['before-choice helper success/fallback','original native append args/result','52 export-menu after-append helper'],
        native_menu_constructors_executed=False,producer_implementation_executed=False,host_emulation=True,target_device_executed=False,camera_accessed=False)
    (out/'A64_WRAPPER.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(dict(cases=len(results),receipt=row(out/'A64_WRAPPER.json'))))
def uc_at_stop(u,stop):return u.reg_read(UC_ARM64_REG_PC)==stop
if __name__=='__main__':main()
