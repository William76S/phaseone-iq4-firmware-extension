#!/usr/bin/env python3
"""Finite, offline AArch64 ET_REL linker for the exact IQ4 User baseline.

Never executes input/output. No raw SO, TLS addition, new imports, or device I/O.
The public API is also used by host tests; CLI is plan-only unless --emit is set.
"""
from __future__ import annotations
import argparse, hashlib, json, struct
from dataclasses import dataclass
from pathlib import Path

BASE_SHA = '9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
BASE_SIZE = 11874544
BASE_VA = 0x400000
RX_END = 0xb31752
PH_OFF = 0xb31758
RW_OLD_OFF = 0xb31da0
NEW_RX_VA = 0x4240000
ALIGN = 0x10000
MAX_OBJECT_BYTES = 16 << 20
MAX_APPEND_BYTES = 32 << 20
EHDR = struct.Struct('<16sHHIQQQIHHHHHH')
PHDR = struct.Struct('<IIQQQQQQ')
SHDR = struct.Struct('<IIQQQQIIQQ')
SYMENT = struct.Struct('<IBBHQQ')
RELA = struct.Struct('<QQq')
HOOKS = (
 (0x51ddcc, bytes.fromhex('9b64fd97'), 0x477038, 'iq4_f1_lv_draw_wrapper_12'),
 (0x6be8a8, bytes.fromhex('a22ff597'), 0x40a730, 'iq4_f1_firmware_unlock_01'),
 (0x4eef2c, bytes.fromhex('a3a10094'), 0x5175b8, 'iq4_f1_lv_ctor_wrapper_01'),
)
INITIALIZER = 'iq4_f1_firmware_initialize_01'
REQUIRED_SYMBOLS = tuple(h[3] for h in HOOKS) + (INITIALIZER, 'iq4_f1_mode_get_01', 'iq4_f1_mode_set_on_ui_01')
ALIASES = {'iq4_stock_lv_ctor_01': (0x5175b8, 'native_lv_constructor'),
           'iq4_stock_pthread_mutex_unlock_01': (0x40a730, 'original_plt_unlock')}
NEW_IMPORT = '_ZSt9terminatev'

class Reject(ValueError): pass
def need(condition, reason):
    if not condition: raise Reject(reason)
def sha(data): return hashlib.sha256(data).hexdigest()
def align(n, a):
    need(a > 0 and a & (a-1) == 0 and a <= ALIGN, 'invalid section alignment')
    return (n+a-1) & -a
def integer(value, bits, signed=False):
    lo = -(1 << (bits-1)) if signed else 0
    hi = (1 << (bits-1))-1 if signed else (1 << bits)-1
    need(lo <= value <= hi, f'{bits}-bit relocation overflow: {value}')
    return value & ((1 << bits)-1)
def cstring(data, at):
    need(0 <= at < len(data), 'string offset')
    end = data.find(b'\0', at)
    need(end >= 0, 'unterminated ELF string')
    return data[at:end].decode('utf-8', 'strict')
def slice_bytes(data, at, size):
    need(at >= 0 and size >= 0 and at+size <= len(data), 'ELF span outside file')
    return data[at:at+size]

@dataclass
class Section:
    obj: int
    index: int
    name: str
    header: list
    data: bytearray
    va: int = 0
    off: int = 0
    @property
    def size(self): return self.header[5]
    @property
    def flags(self): return self.header[2]
    @property
    def writable(self): return bool(self.flags & 1)
    @property
    def executable(self): return bool(self.flags & 4)

class Elf:
    def __init__(self, data, expected_type, label='input'):
        self.data = bytes(data); self.label = label
        need(len(data) >= 64, 'short ELF')
        self.e = list(EHDR.unpack_from(data))
        need(self.e[0][:7] == b'\x7fELF\x02\x01\x01', 'requires ELF64 little-endian version 1')
        need(self.e[1] == expected_type and self.e[2] == 183 and self.e[3] == 1, 'wrong ELF type/machine/version')
        need(self.e[8] == 64 and self.e[11] == 64, 'wrong ELF header/section entry size')
        need(0 < self.e[12] < 65535 and 0 < self.e[13] < self.e[12], 'extended section numbering not supported')
        self.sh = [list(SHDR.unpack(slice_bytes(data, self.e[6]+64*i, 64))) for i in range(self.e[12])]
        strings = self.section_bytes(self.e[13])
        self.names = [cstring(strings,s[0]) for s in self.sh]
        self.ph = []
        if self.e[10]:
            need(self.e[9] == 56, 'PHDR size')
            self.ph = [list(PHDR.unpack(slice_bytes(data,self.e[5]+56*i,56))) for i in range(self.e[10])]
        for i,s in enumerate(self.sh):
            if s[1] != 8: self.section_bytes(i)
    def section_bytes(self, index):
        need(0 <= index < len(self.sh), 'section index')
        s=self.sh[index]
        if s[1] == 8: return b'\0'*s[5]
        return slice_bytes(self.data,s[4],s[5])
    def index(self,name):
        found=[i for i,n in enumerate(self.names) if n==name]
        need(len(found)==1, 'missing/ambiguous section '+name)
        return found[0]
    def va_offset(self,va,n=1):
        found=[p[2]+va-p[3] for p in self.ph if p[0]==1 and p[3]<=va and va+n<=p[3]+p[5]]
        need(len(found)==1,'unmapped/ambiguous original VA')
        return found[0]
    def symbols(self,index):
        s=self.sh[index]
        need(s[1] in (2,11) and s[9]==24 and s[5]%24==0,'invalid symbol table')
        st=self.section_bytes(s[6]);result=[]
        for at in range(0,s[5],24):
            x=list(SYMENT.unpack_from(self.section_bytes(index),at));x.append(cstring(st,x[0]));result.append(x)
        return result

def original_contract(data):
    need(len(data)==BASE_SIZE and sha(data)==BASE_SHA,'stock User length/SHA mismatch')
    e=Elf(data,2,'original User')
    need(e.e[5]==0x40 and len(e.ph)==10,'stock PHDR identity')
    need(e.ph[2]==[1,5,0,BASE_VA,BASE_VA,RX_END,RX_END,ALIGN],'stock RX descriptor changed')
    need(e.ph[3][2]==RW_OLD_OFF,'stock RW descriptor changed')
    need(not any(data[RX_END:RW_OLD_OFF]),'PHDR gap must be original all-zero padding')
    need(PH_OFF%8==0 and PH_OFF+12*56<=RW_OLD_OFF,'PHDR gap capacity')
    need(e.ph[3][3]+e.ph[3][6]<=NEW_RX_VA,'appended LOAD overlaps original BSS')
    for va, old, target, _ in HOOKS:
        off=e.va_offset(va,4);need(data[off:off+4]==old,'old BL mismatch')
        word=int.from_bytes(old,'little');delta=word&0x3ffffff
        if delta&0x2000000:delta-=0x4000000
        need(word>>26==0x25 and va+delta*4==target,'old BL target mismatch')
    init=e.index('.init_array');need(e.sh[init][3]==0xf41da0 and e.sh[init][5]==340*8,'stock init array')
    need(sha(e.section_bytes(init))=='1aa6645e0bef5d8fa96f0a99cfc37a951d2aa74d2c55968e6bcdef66a742f71e','stock init array SHA')
    dynamic=e.index('.dynamic');tags=[]
    for at in range(0,e.sh[dynamic][5],16):tags.append(struct.unpack_from('<qQ',e.section_bytes(dynamic),at))
    need(dict(tags)[12]==0x409b90 and dict(tags)[25]==0xf41da0 and dict(tags)[27]==2720,'original dynamic init tags')
    for i,s in enumerate(e.sh):
        if s[1]==4:
            need(s[9]==24 and s[5]%24==0,'original RELA format')
            for at in range(0,s[5],24):
                r,_,_=RELA.unpack_from(e.section_bytes(i),at)
                need(not 0xf41da0<=r<0xf42840,'original init-array relocation must not be moved')
    image=e.index('.imageHeader');need(e.sh[image][3]==0xdda870 and e.sh[image][5]==180,'image header identity')
    return e

def original_imports(e):
    """Only existing original PLT slots/defined dynsym objects, not new deps."""
    result={};sym=e.symbols(e.index('.dynsym'))
    rela=e.index('.rela.plt');plt=e.sh[e.index('.plt')]
    need(plt[5] == 32+16*(e.sh[rela][5]//24),'original PLT layout')
    for at in range(0,e.sh[rela][5],24):
        offset,info,addend=RELA.unpack_from(e.section_bytes(rela),at)
        need(info&0xffffffff==1026 and addend==0,'original JUMP_SLOT contract')
        x=sym[info>>32];name=x[6];va=plt[3]+32+16*(at//24)
        code=e.data[e.va_offset(va,16):e.va_offset(va,16)+16]
        a,b,c,d=struct.unpack('<IIII',code)
        need(a&0x9f00001f==0x90000010 and b&0xffc003ff==0xf9400211 and c&0xffc003ff==0x91000210 and d==0xd61f0220,'original PLT instruction identity')
        imm=((a>>5)&0x7ffff)<<2|((a>>29)&3)
        if imm&0x100000:imm-=0x200000
        got=(va&~4095)+(imm<<12)+(((b>>10)&4095)*8)
        need(got==offset and ((c>>10)&4095)==(offset&4095),'PLT slot/GOT match')
        need(name not in result,'ambiguous existing PLT name')
        result[name]={'va':va,'kind':'original_plt','proof_va':va,'proof_bytes':code.hex(),'got':offset}
    for x in sym:
        if x[3] not in (0,0xfff1,0xfff2) and x[4] and x[6] not in result and any(p[0]==1 and p[3]<=x[4] and x[4]+min(x[5] or 1,16)<=p[3]+p[5] for p in e.ph):
            # Exact defined original dynamic symbols can provide data pointers.
            off=e.va_offset(x[4],min(x[5] or 1,16))
            result[x[6]]={'va':x[4],'kind':'original_defined_dynsym','proof_va':x[4], 'proof_bytes':e.data[off:off+min(x[5] or 1,16)].hex()}
    for name,(va,kind) in ALIASES.items():
        off=e.va_offset(va,16)
        result[name]={'va':va,'kind':kind,'proof_va':va,'proof_bytes':e.data[off:off+16].hex()}
    return result

def gnu_hash(name):
    value=5381
    for byte in name.encode():value=(value*33+byte)&0xffffffff
    return value
def one_bucket_gnu_hash(names):
    """Preserve dynsym indices; one bucket permits the entire existing order."""
    need(len(names)>1,'GNU hash symbol count');values=[gnu_hash(n) for n in names[1:]]
    bloom=0
    for value in values:bloom|=(1<<(value%64))|(1<<((value>>6)%64))
    result=bytearray(struct.pack('<IIIIQI',1,1,1,6,bloom,1))
    for i,value in enumerate(values):result.extend(struct.pack('<I',(value&~1)|(i==len(values)-1)))
    return bytes(result)
def terminate_version(e):
    strings=e.section_bytes(e.index('.dynstr'));blob=e.section_bytes(e.index('.gnu.version_r'));at=0;found=[]
    while True:
        version,count,file,aux,next=struct.unpack_from('<HHIII',blob,at)
        need(version==1 and count>0 and aux>=16,'original version need format')
        library=cstring(strings,file);p=at+aux
        for _ in range(count):
            hashvalue,flags,other,name,anext=struct.unpack_from('<IHHII',blob,p)
            if library=='libstdc++.so.6' and cstring(strings,name)=='GLIBCXX_3.4':found.append(other&0x7fff)
            if not anext:break
            p+=anext;need(p<len(blob),'version need aux span')
        if not next:break
        at+=next;need(at<len(blob),'version need next span')
    need(len(found)==1 and found[0]>1,'existing exact libstdc++ GLIBCXX_3.4 version requirement absent')
    return found[0]

def uleb(data,at):
    value=0
    for shift in range(0,70,7):
        need(at<len(data),'truncated ULEB');b=data[at];at+=1;value|=(b&127)<<shift
        if not b&128:return value,at
    raise Reject('oversize ULEB')
def sleb(data,at):
    value=0;shift=0
    for _ in range(10):
        need(at<len(data),'truncated SLEB');b=data[at];at+=1;value|=(b&127)<<shift;shift+=7
        if not b&128:
            if b&64:value-=1<<shift
            return value,at
    raise Reject('oversize SLEB')
def encoded(data,at,encoding,va,base=0,range_only=False):
    need(encoding!=255,'omitted required EH pointer');start=at
    fmt=encoding&15
    if fmt==0:n=8;signed=False
    elif fmt in (2,3,4):n={2:2,3:4,4:8}[fmt];signed=False
    elif fmt in (10,11,12):n={10:2,11:4,12:8}[fmt];signed=True
    elif fmt==1:value,at=uleb(data,at);n=0
    elif fmt==9:value,at=sleb(data,at);n=0
    else:raise Reject('unsupported EH pointer encoding')
    if n:
        value=int.from_bytes(slice_bytes(data,at,n),'little',signed=signed);at+=n
    if not range_only:
        application=encoding&0x70
        if application==0x10:value+=va+start
        elif application==0x30:value+=base
        elif application:raise Reject('unsupported EH pointer application')
    return value,at

def fde_entries(section,executable):
    """Parse linked new CIE/FDE; leave CFI, personality, LSDA bytes unchanged."""
    data=bytes(section.data);at=0;cies={};entries=[]
    while at<len(data):
        need(at+4<=len(data),'truncated EH length');size=int.from_bytes(data[at:at+4],'little')
        if size==0:
            need(not any(data[at:]),'nonzero bytes after EH terminator');break
        need(size!=0xffffffff and size>=4 and at+4+size<=len(data),'unsupported/truncated EH record')
        end=at+4+size;ident=int.from_bytes(data[at+4:at+8],'little');p=at+8
        if ident==0:
            need(p<end,'short CIE');version=data[p];p+=1;need(version in (1,3),'CIE version')
            z=data.find(b'\0',p,end);need(z>=0,'CIE augmentation');aug=data[p:z].decode('ascii');p=z+1
            _,p=uleb(data,p);_,p=sleb(data,p)
            if version==1:need(p<end,'CIE return register');p+=1
            else:_,p=uleb(data,p)
            enc=0
            if aug:
                need(aug.startswith('z'),'unsupported non-z CIE augmentation');alen,p=uleb(data,p);ae=p+alen;need(ae<=end,'CIE augmentation extent')
                for item in aug[1:]:
                    if item in ('R','L'):
                        need(p<ae,'CIE encoding missing');v=data[p];p+=1
                        if item=='R':enc=v
                    elif item=='P':
                        need(p<ae,'CIE personality missing');v=data[p];p+=1;_,p=encoded(data,p,v,section.va)
                    elif item=='S':pass
                    else:raise Reject('unsupported CIE augmentation '+item)
                need(p==ae,'CIE augmentation trailing bytes')
            cies[at]=enc
        else:
            cie=at+4-ident;need(cie in cies,'FDE references unknown CIE')
            enc=cies[cie];need(not enc&0x80,'indirect FDE PC not supported')
            pc,p=encoded(data,p,enc,section.va);length,p=encoded(data,p,enc&15,section.va,range_only=True)
            need(length>0 and any(a<=pc and pc+length<=b for a,b in executable),'FDE PC/range outside new executable section')
            entries.append((pc,section.va+at))
        at=end
    return entries

class Linker:
    def __init__(self,stock,objects):
        self.stock=bytes(stock);self.base=original_contract(stock)
        need(0<len(objects)<=64,'requires actual finite object set')
        self.objects=[];self.sections=[];self.lookup={};self.symtabs={};self.imports=original_imports(self.base)
        self.definitions={};self.used_imports={};self.relocations=[];self.got={};self.symbol_addresses={}
        for oi,(label,data) in enumerate(objects):
            need(0<len(data)<=MAX_OBJECT_BYTES,'object size limit')
            e=Elf(data,1,label);need(not e.ph,'ET_REL must not have PHDRs');self.objects.append(e)
            for si,h in enumerate(e.sh):
                if h[2]&2:
                    need(not h[2]&0x400,'new TLS is unsupported')
                    need(h[1] in (1,8,14,15,16),'unsupported allocated section type')
                    need(not h[1] in (14,15,16),'own compiler init/fini arrays require explicit initializer, not implicit order')
                    need(not (h[2]&1 and h[2]&4),'new RWX section forbidden')
                    need(h[5]<=MAX_APPEND_BYTES,'section size limit')
                    need(h[8] in (0,1) or h[8]& (h[8]-1)==0,'section alignment')
                    s=Section(oi,si,e.names[si],h[:],bytearray(e.section_bytes(si)))
                    self.sections.append(s);self.lookup[(oi,si)]=s
                if h[1]==2:
                    symbols=e.symbols(si);self.symtabs[(oi,si)]=symbols
                    for sy,x in enumerate(symbols):
                        bind=x[1]>>4
                        if bind not in (1,2) or x[3]==0 or not x[6]:continue
                        need(x[3]!=0xfff2,'COMMON unsupported; compile -fno-common')
                        key=x[6];old=self.definitions.get(key)
                        if old:
                            prev=self.symtabs[old[:2]][old[2]]
                            need(bind==2 or prev[1]>>4==2,'duplicate strong symbol '+key)
                            if bind==1:self.definitions[key]=(oi,si,sy)
                        else:self.definitions[key]=(oi,si,sy)
            for si,h in enumerate(e.sh):
                if h[1] not in (4,9):continue
                need(h[1]==4,'REL without explicit addend is unsupported')
                need(h[9]==24 and h[5]%24==0 and (oi,h[6]) in self.symtabs,'invalid own RELA')
                target=self.lookup.get((oi,h[7]))
                if not target:continue # Non-allocated debug relocations aren't deployed.
                for at in range(0,h[5],24):
                    off,info,addend=RELA.unpack_from(e.section_bytes(si),at)
                    need(info>>32<len(self.symtabs[(oi,h[6])]),'RELA symbol index')
                    self.relocations.append((target,off,info&0xffffffff,(oi,h[6],info>>32),addend))
        need(sum(s.size for s in self.sections)<=MAX_APPEND_BYTES,'allocated payload limit')
    def symbol(self,key):
        oi,table,index=key;x=self.symtabs[(oi,table)][index];bind=x[1]>>4
        if bind in (1,2) and x[6] in self.definitions:key=self.definitions[x[6]];oi,table,index=key;x=self.symtabs[(oi,table)][index]
        if x[3]==0:
            if x[6]==NEW_IMPORT:
                need(self.new_import,'new terminate import layout missing')
                return self.terminate_stub_va
            need(x[6] in self.imports,'new unresolved import '+x[6]);proof=self.imports[x[6]]
            self.used_imports[x[6]]=proof;return proof['va']
        if x[3]==0xfff1:return x[4]
        need((oi,x[3]) in self.lookup,'symbol outside allocated section '+x[6]);s=self.lookup[(oi,x[3])]
        need(x[4]<=s.size and x[4]+x[5]<=s.size,'own symbol extent')
        return s.va+x[4]
    def named(self,name):
        need(name in self.definitions,'missing real function payload '+name)
        key=self.definitions[name];x=self.symtabs[key[:2]][key[2]];s=self.lookup.get((key[0],x[3]))
        need(s and s.executable and x[1]&15==2 and x[5]>0,'required payload must be nonempty function '+name)
        return self.symbol(key)
    def layout(self):
        self.new_import=any(self.symtabs[k[:2]][k[2]][3]==0 and self.symtabs[k[:2]][k[2]][6]==NEW_IMPORT for _,_,_,k,_ in self.relocations)
        self.rx_file=align(len(self.stock),ALIGN);cursor=0
        for s in self.sections:
            if not s.writable:cursor=align(cursor,s.header[8] or 1);s.va=NEW_RX_VA+cursor;s.off=self.rx_file+cursor;cursor+=s.size
        self.rx_sections_end=cursor
        self.dynamic_clones={}
        if self.new_import:
            # Only this compiler-provided noexcept dependency is admitted.
            # No added DT_NEEDED, version_r, lazy PLT relocation or new library.
            self.terminate_version=terminate_version(self.base)
            symbols=self.base.symbols(self.base.index('.dynsym'));self.terminate_symbol_index=len(symbols)
            need(self.terminate_symbol_index==545,'original dynamic symbol count')
            dynstr=self.base.section_bytes(self.base.index('.dynstr'));self.terminate_string_offset=len(dynstr)
            cloned={
              '.dynstr':dynstr+NEW_IMPORT.encode()+b'\0',
              '.dynsym':self.base.section_bytes(self.base.index('.dynsym'))+SYMENT.pack(len(dynstr),0x12,0,0,0,0),
              '.gnu.version':self.base.section_bytes(self.base.index('.gnu.version'))+struct.pack('<H',self.terminate_version),
              '.gnu.hash':one_bucket_gnu_hash([x[6] for x in symbols]+[NEW_IMPORT]),
              '.rela.dyn':self.base.section_bytes(self.base.index('.rela.dyn'))+bytes(24)}
            cursor=align(cursor,16);self.terminate_stub_offset=cursor;self.terminate_stub_va=NEW_RX_VA+cursor;cursor+=16
            for name,blob in cloned.items():
                original=self.base.sh[self.base.index(name)];cursor=align(cursor,original[8] or 1)
                self.dynamic_clones[name]={'offset':cursor,'va':NEW_RX_VA+cursor,'bytes':blob};cursor+=len(blob)
        # EH header contains every original + own FDE; capacity derived first.
        old=self.base.section_bytes(self.base.index('.eh_frame_hdr'))
        need(old[:4]==b'\x01\x1b\x03\x3b','original EH header encodings')
        self.old_eh_count=struct.unpack_from('<I',old,8)[0]
        need(len(old)==12+self.old_eh_count*8,'original EH header exact span')
        self.new_fde_capacity=sum(s.size//12 for s in self.sections if s.name=='.eh_frame')
        self.eh_header_offset=align(cursor,4);self.eh_header_capacity=12+8*(self.old_eh_count+self.new_fde_capacity)
        self.rx_size=self.eh_header_offset+self.eh_header_capacity
        self.rw_file=align(self.rx_file+self.rx_size,ALIGN);self.rw_va=align(NEW_RX_VA+self.rx_size,ALIGN);cursor=0
        for s in self.sections:
            if s.writable:cursor=align(cursor,s.header[8] or 1);s.va=self.rw_va+cursor;s.off=self.rw_file+cursor;cursor+=s.size
        self.init_offset=align(cursor,8);cursor=self.init_offset+341*8
        for _,_,typ,key,_ in self.relocations:
            if typ in (309,311,312) and key not in self.got:self.got[key]=len(self.got)
        self.got_offset=align(cursor,8);self.rw_size=self.got_offset+len(self.got)*8
        if self.new_import:
            self.terminate_got_offset=self.rw_size;self.terminate_got_va=self.rw_va+self.rw_size;self.rw_size+=8
        need(self.rx_size+self.rw_size<=MAX_APPEND_BYTES,'final allocated payload bound')
        for name,key in self.definitions.items():self.symbol_addresses[name]=self.symbol(key)
    def relocate(self):
        self.layout()
        for s,at,typ,key,A in self.relocations:
            width=8 if typ in (257,260) else 2 if typ==262 else 4
            need(0<=at and at+width<=s.size,'relocation target extent')
            S=self.symbol(key);P=s.va+at;value=S+A
            if typ in (257,258,260,261,262):
                bits={257:64,258:32,260:64,261:32,262:16}[typ];signed=typ in (260,261,262)
                v=integer(value-P if signed else value,bits,signed)
                s.data[at:at+width]=v.to_bytes(width,'little');continue
            word=int.from_bytes(s.data[at:at+4],'little')
            if typ in (282,283):
                need(word>>26==(0x25 if typ==283 else 5),'CALL26/JUMP26 opcode')
                delta=value-P;need(delta%4==0,'branch target alignment');v=integer(delta//4,26,True);word=(word&0xfc000000)|v
            elif typ in (274,275,276,311):
                page=typ!=274
                need(word&0x9f000000==(0x90000000 if page else 0x10000000),'ADR/ADRP opcode')
                if typ==311:value=self.rw_va+self.got_offset+8*self.got[key]+A
                delta=(value>>12)-(P>>12) if page else value-P;v=integer(delta,21,True)
                word=(word&~0x60ffffe0)|((v&3)<<29)|((v>>2)<<5)
            elif typ==277:
                need(word&0x7f000000==0x11000000 and not word&(1<<22),'ADD_ABS_LO12 opcode/shift')
                word=(word&~0x003ffc00)|((value&4095)<<10)
            elif typ in (278,284,285,286,299,312):
                scale={278:0,284:1,285:2,286:3,299:4,312:3}[typ]
                need(word&0x3b000000==0x39000000,'LDST unsigned immediate opcode')
                if typ==312:
                    need(word&0xffc00000==0xf9400000,'GOT LD64 opcode');value=self.rw_va+self.got_offset+8*self.got[key]+A
                elif scale==4:need(word&0x04800000==0x04800000,'LDST128 vector width')
                else:need(word>>30==scale,'LDST width')
                need(value&((1<<scale)-1)==0,'LDST target alignment')
                word=(word&~0x003ffc00)|(((value&4095)>>scale)<<10)
            elif typ in (273,280,309):
                if typ==280:need(word&0xff000010==0x54000000,'CONDBR19 opcode')
                else:need(word&0x3b000000==0x18000000,'literal load opcode')
                if typ==309:value=self.rw_va+self.got_offset+8*self.got[key]+A
                delta=value-P;need(delta%4==0,'imm19 alignment');v=integer(delta//4,19,True);word=(word&~0x00ffffe0)|(v<<5)
            elif 263<=typ<=269:
                need(word&0x1f800000==0x12800000,'MOVW opcode')
                shift={263:0,264:0,265:16,266:16,267:32,268:32,269:48}[typ]
                need((word>>21)&3==shift//16,'MOVW shift')
                if typ in (263,265,267):integer(value,shift+16)
                word=(word&~0x001fffe0)|(((value>>shift)&65535)<<5)
            else:raise Reject('unsupported AArch64 relocation '+str(typ))
            s.data[at:at+4]=word.to_bytes(4,'little')
        for name in REQUIRED_SYMBOLS:self.named(name)
    def merge_eh(self):
        old_index=self.base.index('.eh_frame_hdr');old=self.base.section_bytes(old_index);old_va=self.base.sh[old_index][3]
        pairs=[]
        for at in range(12,len(old),8):
            pc,fde=struct.unpack_from('<ii',old,at);pairs.append((old_va+pc,old_va+fde))
        need(len(pairs)==32455 and all(pairs[i][0]<pairs[i+1][0] for i in range(len(pairs)-1)),'stock EH sorted identity')
        executable=[(s.va,s.va+s.size) for s in self.sections if s.executable]
        own=[]
        for s in self.sections:
            if s.name=='.eh_frame':own.extend(fde_entries(s,executable))
        need(own,'real payload requires unwind FDEs')
        for name in (INITIALIZER,)+tuple(h[3] for h in HOOKS):
            need(self.named(name) in {p for p,_ in own},'required wrapper/initializer lacks FDE '+name)
        all_pairs=sorted(pairs+own)
        need(len({pc for pc,_ in all_pairs})==len(all_pairs),'conflicting merged FDE PC')
        va=NEW_RX_VA+self.eh_header_offset
        old_eh=self.base.sh[self.base.index('.eh_frame')][3]
        header=bytearray(b'\x01\x1b\x03\x3b')
        header.extend(struct.pack('<II',integer(old_eh-(va+4),32,True),len(all_pairs)))
        for pc,fde in all_pairs:header.extend(struct.pack('<II',integer(pc-va,32,True),integer(fde-va,32,True)))
        need(len(header)<=self.eh_header_capacity,'EH capacity miscalculation')
        self.eh_bytes=bytes(header);self.eh_pairs=all_pairs;self.own_eh_pairs=own
        return header
    def build(self,version):
        need(len(version)==3 and 0<=version[0]<=255 and 0<=version[1]<=255 and 0<=version[2]<=65535,'header app version range')
        need(tuple(version)>(6,3,21),'explicit newer candidate appversion required')
        self.relocate();self.merge_eh()
        out=bytearray(self.stock);out.extend(b'\0'*(self.rw_file+self.rw_size-len(out)))
        for s in self.sections:out[s.off:s.off+s.size]=s.data
        if self.new_import:
            # ADRP x16,GOT; LDR x17,[x16,#lo12]; BR x17; NOP. This tail jump
            # creates no extra frame, and std::terminate is noreturn/noexcept.
            page_delta=(self.terminate_got_va>>12)-(self.terminate_stub_va>>12);imm=integer(page_delta,21,True)
            words=[0x90000010|((imm&3)<<29)|((imm>>2)<<5),
                   0xf9400211|(((self.terminate_got_va&4095)//8)<<10),0xd61f0220,0xd503201f]
            stuboff=self.rx_file+self.terminate_stub_offset;out[stuboff:stuboff+16]=struct.pack('<4I',*words)
            for name,clone in self.dynamic_clones.items():
                blob=clone['bytes']
                if name=='.rela.dyn':blob=blob[:-24]+RELA.pack(self.terminate_got_va,(self.terminate_symbol_index<<32)|1025,0)
                clone['bytes']=blob;off=self.rx_file+clone['offset'];out[off:off+len(blob)]=blob
        ehoff=self.rx_file+self.eh_header_offset;out[ehoff:ehoff+len(self.eh_bytes)]=self.eh_bytes
        init=self.base.section_bytes(self.base.index('.init_array'))+struct.pack('<Q',self.named(INITIALIZER))
        init_off=self.rw_file+self.init_offset;out[init_off:init_off+len(init)]=init
        for key,index in self.got.items():struct.pack_into('<Q',out,self.rw_file+self.got_offset+8*index,self.symbol(key))
        original_dynamic=self.base.sh[self.base.index('.dynamic')]
        dynamic_changes=[]
        for at in range(0,original_dynamic[5],16):
            fileoff=original_dynamic[4]+at;tag,value=struct.unpack_from('<qQ',out,fileoff)
            replacements={25:self.rw_va+self.init_offset,27:len(init)}
            if self.new_import:
                replacements.update({5:self.dynamic_clones['.dynstr']['va'],6:self.dynamic_clones['.dynsym']['va'],
                  10:len(self.dynamic_clones['.dynstr']['bytes']),0x6ffffef5:self.dynamic_clones['.gnu.hash']['va'],
                  0x6ffffff0:self.dynamic_clones['.gnu.version']['va'],7:self.dynamic_clones['.rela.dyn']['va'],
                  8:len(self.dynamic_clones['.rela.dyn']['bytes'])})
            if tag in replacements:
                replacement=replacements[tag]
                struct.pack_into('<Q',out,fileoff+8,replacement);dynamic_changes.append({'tag':tag,'file_offset':fileoff+8,'old':value,'new':replacement})
        hook_changes=[]
        for va,old,target,name in HOOKS:
            destination=self.named(name);delta=destination-va
            need(delta%4==0,'hook target alignment');word=0x94000000|integer(delta//4,26,True)
            off=self.base.va_offset(va,4);out[off:off+4]=struct.pack('<I',word)
            hook_changes.append({'va':va,'file_offset':off,'old_bytes':old.hex(),'old_target':target,'new_target':destination,'new_bytes':out[off:off+4].hex(),'symbol':name})
        imageoff=self.base.sh[self.base.index('.imageHeader')][4]+16
        out[imageoff:imageoff+4]=struct.pack('<BBH',*version)
        ph=[p[:] for p in self.base.ph]
        ph[0]=[6,4,PH_OFF,BASE_VA+PH_OFF,BASE_VA+PH_OFF,12*56,12*56,8]
        ph[2][5]=ph[2][6]=PH_OFF+12*56
        ph[7]=[0x6474e550,4,ehoff,NEW_RX_VA+self.eh_header_offset,NEW_RX_VA+self.eh_header_offset,len(self.eh_bytes),len(self.eh_bytes),4]
        ph.extend([[1,5,self.rx_file,NEW_RX_VA,NEW_RX_VA,self.rx_size,self.rx_size,ALIGN],
                   [1,6,self.rw_file,self.rw_va,self.rw_va,self.rw_size,self.rw_size,ALIGN]])
        out[PH_OFF:PH_OFF+12*56]=b''.join(PHDR.pack(*p) for p in ph)
        # Preserve every original section body, and all original section indices.
        # Change active section string metadata, append explicit own section rows.
        sh=[h[:] for h in self.base.sh];names=self.base.names[:]
        for name,clone in self.dynamic_clones.items():
            h=sh[self.base.index(name)];h[3]=clone['va'];h[4]=self.rx_file+clone['offset'];h[5]=len(clone['bytes'])
        for i,s in enumerate(self.sections):
            names.append(f'.f1.{s.obj}.{s.index}.{s.name.lstrip(".")}')
            sh.append([0,1,s.flags,s.va,s.off,s.size,0,0,s.header[8] or 1,0])
        names.extend(['.f1.eh_frame_hdr','.f1.init_array','.f1.got'])
        sh.extend([[0,1,2,NEW_RX_VA+self.eh_header_offset,ehoff,len(self.eh_bytes),0,0,4,0],
                   [0,14,3,self.rw_va+self.init_offset,init_off,len(init),0,0,8,8],
                   [0,1,3,self.rw_va+self.got_offset,self.rw_file+self.got_offset,len(self.got)*8,0,0,8,8]])
        if self.new_import:
            names.extend(['.f1.terminate_stub','.f1.terminate_got'])
            sh.extend([[0,1,6,self.terminate_stub_va,self.rx_file+self.terminate_stub_offset,16,0,0,16,0],
                       [0,1,3,self.terminate_got_va,self.rw_file+self.terminate_got_offset,8,0,0,8,8]])
        strtab=bytearray(b'\0');symrows=[bytes(24)]
        for name in sorted(self.definitions):
            key=self.definitions[name];x=self.symtabs[key[:2]][key[2]]
            sec=self.lookup.get((key[0],x[3]));
            if not sec:continue
            n=len(strtab);strtab.extend(name.encode()+b'\0');si=len(self.base.sh)+self.sections.index(sec)
            symrows.append(SYMENT.pack(n,x[1],x[2],si,self.symbol(key),x[5]))
        off=align(len(out),8);out.extend(b'\0'*(off-len(out)));symoff=len(out);symblob=b''.join(symrows);out.extend(symblob)
        st_off=len(out);out.extend(strtab);symindex=len(sh);stindex=symindex+1
        names.extend(['.f1.symtab','.f1.strtab']);sh.extend([[0,2,0,0,symoff,len(symblob),stindex,1,8,24],[0,3,0,0,st_off,len(strtab),0,0,1,0]])
        strings=bytearray(b'\0')
        for name,h in zip(names,sh):h[0]=len(strings);strings.extend(name.encode()+b'\0')
        stringoff=len(out);out.extend(strings);sh[self.base.e[13]][4]=stringoff;sh[self.base.e[13]][5]=len(strings)
        shoff=align(len(out),8);out.extend(b'\0'*(shoff-len(out)));out.extend(b''.join(SHDR.pack(*h) for h in sh))
        eh=self.base.e[:];eh[5]=PH_OFF;eh[6]=shoff;eh[10]=12;eh[12]=len(sh)
        out[:64]=EHDR.pack(*eh)
        allowed=[(0,64,'ELF header'),(PH_OFF,12*56,'relocated active PHDR'),(imageoff,4,'explicit appversion')]
        allowed += [(x['file_offset'],4,'exact BL '+x['symbol']) for x in hook_changes]
        allowed += [(x['file_offset'],8,'DT_INIT_ARRAY metadata') for x in dynamic_changes]
        verify_preservation(self.stock,out,allowed)
        new=Elf(out,2,'candidate');verify_loads(new)
        need(out[0x40:0x270]==self.stock[0x40:0x270],'old PHDR bytes changed')
        need(out[init_off:init_off+2720]==self.base.section_bytes(self.base.index('.init_array')),'original constructor order changed')
        result={'schema':'iq4_f1_user_elf_append_01','baseline_sha256':BASE_SHA,'baseline_bytes':len(self.stock),
          'candidate_sha256':sha(out),'candidate_bytes':len(out),'app_version':list(version),
          'objects':[{'label':e.label,'bytes':len(e.data),'sha256':sha(e.data)} for e in self.objects],
          'hooks':hook_changes,'initializer_va':self.named(INITIALIZER),'original_init_entries_preserved':340,'new_init_entries':1,
          'DT_INIT_unchanged':0x409b90,'dynamic_changes':dynamic_changes,'phdr_file_offset':PH_OFF,
          'AT_PHDR_expected_va':BASE_VA+PH_OFF,'program_headers':ph,
          'original_EH_entries_preserved':self.old_eh_count,'own_EH_entries':len(self.own_eh_pairs),'new_EH_entries':len(self.eh_pairs),
          'own_fde_pairs':self.own_eh_pairs,'original_import_bindings':self.used_imports,
          'new_dynamic_import':None if not self.new_import else {'name':NEW_IMPORT,'library':'libstdc++.so.6','version':'GLIBCXX_3.4',
            'version_index':self.terminate_version,'dynsym_index':self.terminate_symbol_index,'GLOB_DAT_va':self.terminate_got_va,'tail_stub_va':self.terminate_stub_va,
            'added_DT_NEEDED':False,'original_dynsym_indices_preserved':545,'original_general_RELA_bytes_preserved':960,
            'new_general_RELA_count':1,'active_GNU_hash_strategy':'one bucket; original dynsym order retained'},
          'own_symbols':self.symbol_addresses,'changed_original_spans':diff_spans(self.stock,out),
          'allowed_original_spans':allowed,'original_body_preservation_verified':True,
          'ELF_inspection_only':True,'target_executed':False,'camera_access':False,'firmware_accepted':False,
          'restoration_verified':False,'F1_camera_acceptance':False}
        return bytes(out),result

def diff_spans(before,after):
    spans=[];at=0
    while at<len(before):
        if before[at]==after[at]:at+=1;continue
        start=at
        while at<len(before) and before[at]!=after[at]:at+=1
        spans.append({'offset':start,'bytes':at-start,'original_hex':before[start:at].hex(),'candidate_hex':after[start:at].hex()})
    return spans
def verify_preservation(before,after,allowed):
    need(len(after)>=len(before),'candidate truncates original')
    spans=sorted((a,a+n) for a,n,_ in allowed);cursor=0
    for a,b in spans:
        need(0<=a<=b<=len(before) and a>=cursor,'invalid overlapping original mutation whitelist')
        need(before[cursor:a]==after[cursor:a],'unapproved original byte change')
        cursor=b
    need(before[cursor:]==after[cursor:len(before)],'unapproved original tail change')
def verify_loads(e):
    loads=[p for p in e.ph if p[0]==1];need(len(loads)==4,'requires original two + own two LOADs')
    for p in loads:
        need(p[5]<=p[6] and p[2]+p[5]<=len(e.data),'LOAD size/extent')
        need(p[7]==ALIGN and p[2]%ALIGN==p[3]%ALIGN,'LOAD alignment congruence')
        need(p[1] in (5,6),'LOAD W^X')
    need(all(a[3]+a[6]<=b[3] for a,b in zip(loads,loads[1:])),'LOAD virtual overlap/order')
    ph=e.ph[0];need(ph[0]==6 and ph[3]==BASE_VA+e.e[5] and ph[5]==e.e[10]*56,'AT_PHDR load bias contract')
    need(e.va_offset(ph[3],ph[5])==e.e[5],'active PHDR not mapped at AT_PHDR')

def plan(stock):
    e=original_contract(stock)
    return {'schema':'iq4_f1_user_elf_append_plan_01','baseline_sha256':BASE_SHA,'candidate_emitted':False,
      'functional_payload_required':True,'required_symbols':REQUIRED_SYMBOLS,'hooks':[{'va':x[0],'old_bytes':x[1].hex(),'target':x[2],'wrapper':x[3]} for x in HOOKS],
      'PHDR_strategy':'active 12-entry table within original all-zero RX/RW file gap; first RX extended only into gap',
      'active_PHDR_file_offset':PH_OFF,'active_PHDR_va':BASE_VA+PH_OFF,'new_RX_va':NEW_RX_VA,
      'original_DT_INIT':0x409b90,'original_INIT_ARRAY_entries':340,'original_EH_entries':32455,
      'target_executed':False,'camera_access':False,'firmware_accepted':False,'F1_camera_acceptance':False}

def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--stock',type=Path,required=True)
    ap.add_argument('--payload-lock',type=Path);ap.add_argument('--expected-payload-lock-sha256');ap.add_argument('--app-version')
    ap.add_argument('--emit',type=Path);ap.add_argument('--report',type=Path,required=True)
    args=ap.parse_args();need(not args.report.exists(),'report must be fresh')
    stock=args.stock.read_bytes()
    if not args.emit:
        need(not args.payload_lock and not args.expected_payload_lock_sha256 and not args.app_version,'plan mode has no ignored payload/version inputs');r=plan(stock)
    else:
        need(not args.emit.exists() and args.emit.resolve()!=args.stock.resolve(),'candidate must be fresh and separate from stock')
        need(args.payload_lock and args.expected_payload_lock_sha256 and args.app_version,'emit requires actual locked functional payload and explicit version')
        from input_lock import validate
        need(sha(args.payload_lock.read_bytes())==args.expected_payload_lock_sha256,'input lock SHA mismatch')
        objects=validate(json.loads(args.payload_lock.read_text()))
        version=tuple(int(x) for x in args.app_version.split('.'))
        link=Linker(stock,objects);candidate,r=link.build(version)
        r['actual_payload_lock_sha256']=args.expected_payload_lock_sha256
        args.emit.parent.mkdir(parents=True,exist_ok=True)
        with args.emit.open('xb') as f:f.write(candidate)
    args.report.parent.mkdir(parents=True,exist_ok=True)
    with args.report.open('x') as f:json.dump(r,f,indent=2,sort_keys=True);f.write('\n')
    print(json.dumps({'schema':r['schema'],'report':str(args.report),'candidate_emitted':bool(args.emit),'target_executed':False}))
if __name__=='__main__':
    try:main()
    except (Reject,OSError,UnicodeError,struct.error) as exc:raise SystemExit('REFUSED: '+str(exc))
