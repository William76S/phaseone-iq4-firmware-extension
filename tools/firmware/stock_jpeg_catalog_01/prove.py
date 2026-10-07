#!/usr/bin/env python3
"""Run original selection + linked new A64 loads, with card getter fixture."""
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
    stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin';b=stock.read_bytes();assert row(stock)['sha256']=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    loader=importlib.util.spec_from_file_location('catalog_ELF',ROOT/'tools/firmware/f1_user_elf_append_03/elf_append.py');m=importlib.util.module_from_spec(loader);sys.modules[loader.name]=m;loader.loader.exec_module(m)
    u=Uc(UC_ARCH_ARM64,UC_MODE_ARM)
    original=m.Elf(b,2)
    for typ,fl,off,va,pa,fs,ms,align in original.ph:
        if typ!=1:continue
        lo=va&~4095;hi=(va+ms+4095)&~4095;u.mem_map(lo,hi-lo);u.mem_write(va,b[off:off+fs])
    code=0x4300000;cursor=code;u.mem_map(code,0x20000)
    defs={'iq4_stock_jpeg_destination_get_01':code+0x1f000,
          'iq4_stock_jpeg_catalog_fs_resume_01':0x493604,
          'iq4_stock_jpeg_catalog_path_resume_01':0x493610}
    sections=[];objects=[]
    for name in ['select.o','wrappers.o']:
        p=out/name;e=m.Elf(p.read_bytes(),1,name);base={}
        for i,s in enumerate(e.sh):
            if s[2]&2 and s[5]:
                cursor=(cursor+max(s[8],4)-1)&~(max(s[8],4)-1)
                base[i]=cursor;raw=e.data[s[4]:s[4]+s[5]]
                if s[1]!=8:u.mem_write(cursor,raw)
                cursor+=s[5]
        symtab={}
        for i,s in enumerate(e.sh):
            if s[1]==2:
                strings=e.sh[s[6]];names=e.data[strings[4]:strings[4]+strings[5]]
                syms=[]
                for off in range(s[4],s[4]+s[5],24):
                    no,info,other,ndx,value,size=struct.unpack_from('<IBBHQQ',e.data,off)
                    name=names[no:names.find(b'\0',no)].decode() if no else ''
                    syms.append((name,ndx,value))
                    if name and ndx in base:defs[name]=base[ndx]+value
                symtab[i]=syms
        objects.append((e,base,symtab));sections.append(dict(object=row(p),allocated_section_count=len(base)))
    for e,base,symtab in objects:
        for s in e.sh:
            if s[1]!=4 or s[7] not in base:continue
            for off in range(s[4],s[4]+s[5],24):
                ro,info,addend=struct.unpack_from('<QQq',e.data,off);kind=info&0xffffffff
                name,ndx,value=symtab[s[6]][info>>32];place=base[s[7]]+ro
                target=(base[ndx]+value if ndx in base else defs[name])+addend
                if kind in [282,283]:
                    delta=target-place;assert delta%4==0 and -(1<<27)<=delta<(1<<27);word=(0x94000000 if kind==283 else 0x14000000)|((delta//4)&0x3ffffff);u.mem_write(place,struct.pack('<I',word))
                elif kind==261:u.mem_write(place,struct.pack('<I',(target-place)&0xffffffff))
                elif kind==257:u.mem_write(place,struct.pack('<Q',target))
                else:raise AssertionError((name,kind))
    exact=json.loads((HERE/'EXACT.json').read_text())
    for h in exact['auxiliary_hooks']:
        target=defs[h['target_symbol']];delta=target-h['va'];assert delta%4==0 and -(1<<27)<=delta<(1<<27)
        u.mem_write(h['va'],struct.pack('<I',0x14000000|((delta//4)&0x3ffffff)))
    catalog=0x20000000;stack=0x30000000;u.mem_map(catalog,0x2000);u.mem_map(stack,0x10000)
    def wr(p,value,n=8):u.mem_write(p,value.to_bytes(n,'little'))
    def rd(p,n=8):return int.from_bytes(u.mem_read(p,n),'little')
    sd_fs,sd_path,xqd_fs,xqd_path=[0x21111110,0x22222220,0x23333330,0x24444440]
    for off,value in [(0x7a0,sd_fs),(0x7b0,sd_path),(0x7d0,xqd_fs),(0x7e0,xqd_path)]:wr(catalog+off,value)
    selected=10;getter_calls=0
    def hook(uc,pc,size,ctx):
        nonlocal getter_calls
        if pc==defs['iq4_stock_jpeg_destination_get_01']:
            getter_calls+=1;uc.reg_write(UC_ARM64_REG_W0,selected);uc.reg_write(UC_ARM64_REG_PC,uc.reg_read(UC_ARM64_REG_LR))
        elif pc==0x74654c:raise AssertionError('native invalid-flag diagnostic')
    u.hook_add(UC_HOOK_CODE,hook)
    results=[];GP=[UC_ARM64_REG_X0+i for i in range(29)]+[UC_ARM64_REG_X29,UC_ARM64_REG_X30]
    for selected in [10,11]:
        for flag in [4,16,2]:
            sp=stack+0xf000;wr(sp+0x28,flag,4);wr(sp+0x38,catalog);wr(sp+0x218,0);wr(sp+0x258,0)
            before=[]
            for i in range(31):
                value=(0x8877665544332200+i)&0xffffffffffffffff
                if i==29:value=sp
                u.reg_write(GP[i],value);before.append(value)
            vectors=[]
            for i in range(32):
                value=(0x123456789abcdef0123456789abcdef0+i)&((1<<128)-1);u.reg_write(UC_ARM64_REG_Q0+i,value);vectors.append(value)
            u.reg_write(UC_ARM64_REG_SP,sp);u.reg_write(UC_ARM64_REG_NZCV,0xa0000000);getter_calls=0
            u.emu_start(0x4935dc,0x49365c,count=2000)
            assert u.reg_read(UC_ARM64_REG_PC)==0x49365c
            want_xqd=flag==2 or (flag==16 and selected==11)
            assert rd(sp+0x218)==(xqd_fs if want_xqd else sd_fs)
            assert rd(sp+0x258)==(xqd_path if want_xqd else sd_path)
            assert u.reg_read(UC_ARM64_REG_SP)==sp
            assert all(u.reg_read(GP[i])==before[i] for i in range(1,31))
            assert all(u.reg_read(UC_ARM64_REG_Q0+i)==vectors[i] for i in range(32))
            assert u.reg_read(UC_ARM64_REG_NZCV)==0x60000000
            assert getter_calls==(2 if flag==16 else 0)
            assert rd(sp+0x28,4)==flag and rd(sp+0x38)==catalog
            results.append(dict(destination=selected,input_flag=flag,fs=hex(rd(sp+0x218)),path=hex(rd(sp+0x258)),getter_calls=getter_calls,passed=True))
    receipt=dict(schema='iq4_native_JPEG_catalog_selector_A64_01',stock=row(stock),objects=sections,
        exact=row(HERE/'EXACT.json'),source=row(HERE/'prove.py'),cases=results,
        original_scan_selection_branches_executed=True,new_A64_selector_and_wrapper_executed=True,
        original_RAW_SD_and_XQD_routes_preserved=True,original_presence_flag_preserved=True,
        GP_except_x0_SP_all_SIMD_and_native_NZCV_preserved=True,fixture='Destination getter10/11 only; native fs pointers and scan-frame fixture; enumeration outside executed selector window',
        file_enumeration_executed=False,host_emulation=True,target_device_executed=False,camera_accessed=False)
    (out/'A64_SELECTION.json').write_text(json.dumps(receipt,indent=2)+'\n');print(json.dumps(dict(cases=len(results),receipt=row(out/'A64_SELECTION.json'))))
if __name__=='__main__':main()
