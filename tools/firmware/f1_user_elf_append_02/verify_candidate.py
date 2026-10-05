#!/usr/bin/env python3
"""Independent read-only candidate audit: no linker build or target execution."""
import argparse,hashlib,json,struct
from pathlib import Path

EXPECTED_STOCK='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
ORIGINAL_BYTES=11874544
H=struct.Struct('<16sHHIQQQIHHHHHH');P=struct.Struct('<IIQQQQQQ');S=struct.Struct('<IIQQQQIIQQ')
class Failure(ValueError):pass
def check(c,m):
    if not c:raise Failure(m)
def digest(x):return hashlib.sha256(x).hexdigest()
def text(data,off):end=data.index(0,off);return data[off:end].decode()
class View:
    def __init__(self,data):
        self.data=data;self.h=H.unpack_from(data);check(self.h[:4]==(bytes.fromhex('7f454c46020101030000000000000000'),2,183,1),'ELF header identity')
        self.ph=[P.unpack_from(data,self.h[5]+i*56)for i in range(self.h[10])]
        self.sh=[S.unpack_from(data,self.h[6]+i*64)for i in range(self.h[12])]
        strings=self.body(self.h[13]);self.names=[text(strings,s[0])for s in self.sh]
    def index(self,n):check(self.names.count(n)==1,'section uniqueness '+n);return self.names.index(n)
    def body(self,i):s=self.sh[i];return self.data[s[4]:s[4]+s[5]]
    def named(self,n):return self.body(self.index(n))
    def off(self,va,n):
        a=[p[2]+va-p[3]for p in self.ph if p[0]==1 and p[3]<=va and va+n<=p[3]+p[5]]
        check(len(a)==1,'mapped candidate address');return a[0]
    def dynamic(self):return dict(struct.unpack_from('<qQ',self.named('.dynamic'),i)for i in range(0,len(self.named('.dynamic')),16))
def pairs(header,va):
    check(header[:4]==bytes.fromhex('011b033b'),'EH header encoding')
    count=struct.unpack_from('<I',header,8)[0];check(len(header)==12+8*count,'EH index length')
    rows=[tuple(va+x for x in struct.unpack_from('<ii',header,12+8*i))for i in range(count)]
    check(all(a[0]<b[0]for a,b in zip(rows,rows[1:])),'EH sorted unique PCs');return rows
def analyze(stock,candidate,expected_sha,link_report):
    check(len(stock)==ORIGINAL_BYTES and digest(stock)==EXPECTED_STOCK,'actual baseline identity')
    check(digest(candidate)==expected_sha and len(candidate)>len(stock),'candidate identity')
    a,b=View(stock),View(candidate);orig_tags=a.dynamic();new_tags=b.dynamic()
    for i in range(14):
        if i not in (5,6,10,12):check(a.h[i]==b.h[i],'unapproved ELF header field')
    check(b.h[5]==0xb31758 and b.h[10]==12,'active PHDR relocation')
    check(candidate[0x40:0x270]==stock[0x40:0x270],'old PHDR byte preservation')
    check(not any(stock[0xb31752:0xb31da0]),'original zero gap')
    for i,(old,new)in enumerate(zip(a.ph,b.ph[:10])):
        if i==0:check(new==(6,4,0xb31758,0xf31758,0xf31758,672,672,8),'active PHDR descriptor')
        elif i==2:check(new[:5]==old[:5] and new[5:7]==(0xb319f8,0xb319f8) and new[7]==old[7],'original RX extent only to PHDR end')
        elif i==7:check(new[0:2]==old[0:2] and new[7]==4,'GNU EH descriptor type/flags')
        else:check(old==new,'original PHDR changed')
    loads=[p for p in b.ph if p[0]==1];check(len(loads)==4,'LOAD count')
    for p in loads:check(p[1]in(5,6) and p[5]<=p[6] and p[2]+p[5]<=len(candidate) and p[2]%65536==p[3]%65536,'LOAD W^X/extent/congruence')
    check(all(x[3]+x[6]<=y[3]for x,y in zip(loads,loads[1:])),'LOAD order/non-overlap')
    check(b.off(0xf31758,672)==0xb31758,'actual AT_PHDR mapping')
    check(a.names==b.names[:len(a.names)],'original section order/names')
    init=b.named('.f1.init_array');check(init==a.named('.init_array')+struct.pack('<Q',link_report['initializer_va']),'exact constructor order appended')
    check(orig_tags[12]==new_tags[12]==0x409b90 and new_tags[25]==b.sh[b.index('.f1.init_array')][3] and new_tags[27]==2728,'DT_INIT/init-array values')
    # Executable entry supplies a nonzero init callback to packaged libc.
    # That callback uses its own ADRP/ADD bounds; DT tags alone are insufficient.
    entry_init=bytes.fromhex('0300e0d20300c0f2c313a0f203169ef2')
    check(candidate[b.off(0x40b3b4,16):b.off(0x40b3b4,16)+16]==entry_init,'entry provided CSU callback retained')
    csu_bounds={}
    csu_pairs=[(0x9ef0bc,20,bytes.fromhex('942a00f094022191')),(0x9ef0c8,21,bytes.fromhex('952a00d0b5823691'))]
    for pc,reg,old in csu_pairs:
        check(stock[a.off(pc,8):a.off(pc,8)+8]==old,'stock CSU exact pair')
        w,z=struct.unpack_from('<II',candidate,b.off(pc,8))
        check(w&0x9f00001f==0x90000000|reg and z&0xffc003ff==0x91000000|reg|(reg<<5),'candidate CSU opcodes and registers')
        imm=((w>>29)&3)|(((w>>5)&0x7ffff)<<2)
        if imm&(1<<20):imm-=1<<21
        csu_bounds[reg]=(pc&~4095)+imm*4096+((z>>10)&4095)
    check(csu_bounds[21]==new_tags[25] and csu_bounds[20]==new_tags[25]+new_tags[27],'actual CSU matches dynamic linked init table')
    check((csu_bounds[20]-csu_bounds[21])//8==341,'actual CSU iteration count')
    check(candidate[b.off(csu_bounds[21],2728):b.off(csu_bounds[21],2728)+2728]==init,'actual CSU pointer sequence')
    permitted_tags={25,27,5,6,10,0x6ffffef5,0x6ffffff0,7,8}
    check({t for t in orig_tags if orig_tags[t]!=new_tags[t]}==permitted_tags,'exact dynamic changes')
    for n in ('.dynsym','.dynstr','.gnu.version','.rela.dyn'):check(b.named(n).startswith(a.named(n)),'original cloned prefix '+n)
    check(b.named('.dynstr')[len(a.named('.dynstr')):]==b'_ZSt9terminatev\0','only new imported name')
    check(len(b.named('.dynsym'))==546*24 and len(b.named('.gnu.version'))==546*2 and len(b.named('.rela.dyn'))==41*24,'new dynamic counts')
    check(b.named('.gnu.version_r')==a.named('.gnu.version_r') and b.named('.rela.plt')==a.named('.rela.plt'),'version requirement/PLT unchanged')
    ng=b.named('.gnu.hash');check(struct.unpack_from('<4I',ng)==(1,1,1,6),'GNU hash one bucket/same indices')
    ds=b.named('.dynsym');strings=b.named('.dynstr');bloom=struct.unpack_from('<Q',ng,16)[0]
    for index in range(1,546):
        offset,info,other,si,value,size=struct.unpack_from('<IBBHQQ',ds,index*24);name=text(strings,offset);hv=5381
        for byte in name.encode():hv=(hv*33+byte)&0xffffffff
        actual=struct.unpack_from('<I',ng,28+(index-1)*4)[0]
        check(actual&~1==hv&~1 and bool(actual&1)==(index==545),'GNU chain hash/index')
        check(bloom&(1<<(hv%64)) and bloom&(1<<((hv>>6)%64)),'GNU bloom')
    symbols={}
    own_sy=b.named('.f1.symtab');own_st=b.named('.f1.strtab')
    for off in range(24,len(own_sy),24):
        n,i,o,s,v,z=struct.unpack_from('<IBBHQQ',own_sy,off);symbols[text(own_st,n)]=(v,z,s)
    expected_hooks=[(0x51ddcc,'9b64fd97','iq4_f1_lv_draw_wrapper_13'),(0x6be8a8,'a22ff597','iq4_f1_firmware_unlock_01'),(0x4eef2c,'a3a10094','iq4_f1_lv_ctor_wrapper_01')]
    allowed=[(0,64),(0xb31758,672),(0x9da880,4)]
    allowed.extend((a.off(pc,8),8)for pc,_,_ in csu_pairs)
    for va,oldhex,name in expected_hooks:
        off=a.off(va,4);check(stock[off:off+4].hex()==oldhex,'old hook bytes');word=struct.unpack_from('<I',candidate,off)[0]
        delta=word&0x3ffffff
        if delta&0x2000000:delta-=0x4000000
        check(word>>26==0x25 and va+delta*4==symbols[name][0],'real hook linked function');allowed.append((off,4))
    check(candidate[0x9da880:0x9da884]==struct.pack('<BBH',6,3,23),'experimental LinuxApp version')
    dy=a.sh[a.index('.dynamic')]
    for off in range(0,dy[5],16):
        tag,val=struct.unpack_from('<qQ',stock,dy[4]+off)
        if tag in permitted_tags:allowed.append((dy[4]+off+8,8))
    cursor=0
    for off,n in sorted(allowed):check(stock[cursor:off]==candidate[cursor:off],'unapproved original bytes');cursor=off+n
    check(stock[cursor:]==candidate[cursor:len(stock)],'unapproved original tail')
    old_pairs=pairs(a.named('.eh_frame_hdr'),a.sh[a.index('.eh_frame_hdr')][3]);new_eh=b.sh[b.index('.f1.eh_frame_hdr')]
    new_pairs=pairs(b.named('.f1.eh_frame_hdr'),new_eh[3]);check(len(old_pairs)==32455 and set(old_pairs)<=set(new_pairs),'original EH pair preservation')
    check(b.ph[7][2]==new_eh[4] and b.ph[7][3]==new_eh[3] and b.ph[7][5]==new_eh[5],'actual GNU EH points new index')
    check(set(tuple(x)for x in link_report['own_fde_pairs'])==set(new_pairs)-set(old_pairs),'actual own EH table pairs')
    for pc,fde in set(new_pairs)-set(old_pairs):
        check(any(p[1]==5 and p[3]<=pc<p[3]+p[5]for p in loads[2:]),'own EH PC RX');b.off(fde,12)
        at=b.off(fde,12);rel=struct.unpack_from('<i',candidate,at+8)[0];check(fde+8+rel==pc,'actual linked FDE initial PC')
    return {'schema':'iq4_f1_actual_elf_independent_audit_02','baseline_sha256':digest(stock),'candidate_sha256':digest(candidate),
      'candidate_bytes':len(candidate),'original_constructor_count':340,'own_EH_entries':len(new_pairs)-len(old_pairs),'original_EH_entries':len(old_pairs),
      'actual_hook_targets':{name:hex(symbols[name][0])for _,_,name in expected_hooks},'actual_AT_PHDR_va':'0xf31758',
      'complete_original_byte_whitelist_verified':True,'original_section_names_order_preserved':True,
      'original_dynamic_indices_and_RELA_prefixes_preserved':True,'actual_GNU_hash_all_545_nonzero_indices_verified':True,
      'actual_own_FDE_pcrel_PC_bytes_verified':True,'target_executed':False,'firmware_accepted':False,'camera_function_accepted':False,
      'actual_CSU_start':hex(csu_bounds[21]),'actual_CSU_end':hex(csu_bounds[20]),'actual_CSU_constructor_count':341,
      'actual_CSU_and_DT_INIT_ARRAY_identical':True,'UI_payload_revision':'UI03','actual_runtime_initializer_observed':False}
def main():
    ap=argparse.ArgumentParser(description=__doc__);ap.add_argument('--stock',type=Path,required=True);ap.add_argument('--candidate',type=Path,required=True)
    ap.add_argument('--expected-candidate-sha256',required=True);ap.add_argument('--link-report',type=Path,required=True);ap.add_argument('--output',type=Path,required=True)
    a=ap.parse_args();check(not a.output.exists(),'fresh audit output required')
    r=analyze(a.stock.read_bytes(),a.candidate.read_bytes(),a.expected_candidate_sha256,json.loads(a.link_report.read_text()))
    a.output.parent.mkdir(parents=True,exist_ok=True);a.output.write_text(json.dumps(r,indent=2,sort_keys=True)+'\n');print(json.dumps(r))
if __name__=='__main__':
    try:main()
    except (Failure,OSError,KeyError,struct.error)as e:raise SystemExit('REFUSED: '+str(e))
