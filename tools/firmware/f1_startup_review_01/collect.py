#!/usr/bin/env python3
"""Reproduce the final UI02 candidate's real constructor-path defect, offline."""
from pathlib import Path
import hashlib,json,re,struct,subprocess,sys
ROOT=Path(__file__).resolve().parents[3]
OUT=ROOT/'analysis/firmware/f1_card_boot_failure_review_01'
sys.path.insert(0,str(ROOT/'tools/firmware/f1_user_elf_append_01'))
from verify_candidate import View
def sha(b):return hashlib.sha256(b).hexdigest()
def row(p):b=p.read_bytes();return {'path':str(p.relative_to(ROOT)),'bytes':len(b),'sha256':sha(b)}
def main():
    stock=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
    candidate=ROOT/'build/f1_user_elf_candidate_02/P1Linux_IQ4_F1_6.03.22.bin'
    a,b=stock.read_bytes(),candidate.read_bytes()
    assert sha(a)=='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
    assert sha(b)=='aa9c594ac60f594ed7e14b8cc5d765c356d759b72001f1c4ec5469087aa8d115'
    av,bv=View(a),View(b);d=bv.dynamic();arr=bv.named('.f1.init_array');old=av.named('.init_array')
    assert arr[:-8]==old and len(arr)==341*8
    start,end=0xf41da0,0xf42840
    assert (end-start)//8==340
    windows=[('candidate_start',candidate,bv,0x40b38c,0x50),('candidate_csu_init',candidate,bv,0x9ef0b0,0x7c),
             ('candidate_initializer',candidate,bv,0x4240080,0xc80)]
    libc=OUT/'libc-2.28.so.analysis_only';ld=OUT/'ld-2.28.so.analysis_only'
    assert sha(libc.read_bytes())=='0618e1d7f7731c5e07a201cb89e6a9e62db34ff0ee96e80fee781ac4193437dd'
    assert sha(ld.read_bytes())=='9be1d9704ad489d8d573f6a9fb851d4522f92481de5795d9defee99ba96dce8f'
    # ET_DYN views have different e_ident; use the program-header mapping only.
    def liboff(data,va,n):
        phoff=struct.unpack_from('<Q',data,32)[0];num=struct.unpack_from('<H',data,56)[0]
        for i in range(num):
            p=struct.unpack_from('<IIQQQQQQ',data,phoff+56*i)
            if p[0]==1 and p[3]<=va and va+n<=p[3]+p[5]:return p[2]+va-p[3]
        raise ValueError('unmapped library window')
    class Library:
        def __init__(self,p):self.b=p.read_bytes()
        def off(self,va,n):return liboff(self.b,va,n)
    windows += [('libc_start_main',libc,Library(libc),0x20c00,0x1d8),('ld_start_user',ld,Library(ld),0x1040,0x90),
                ('ld_call_init',ld,Library(ld),0xd770,0x134),('ld_init',ld,Library(ld),0xd8a8,0x154)]
    evidence=[]
    for name,p,v,va,n in windows:
        raw=p.read_bytes();off=v.off(va,n)
        output=subprocess.run(['/Library/Developer/CommandLineTools/usr/bin/llvm-objdump','-d',
                 '--start-address='+hex(va),'--stop-address='+hex(va+n),str(p)],check=True,capture_output=True,text=True).stdout
        target=OUT/(name+'.txt');target.write_text('\n'.join(x.rstrip()for x in output.splitlines())+'\n')
        evidence.append({'name':name,'source':row(p),'va':hex(va),'file_offset':hex(off),'bytes':n,
                         'exact_window_sha256':sha(raw[off:off+n]),'disassembly':row(target)})
    hashes=[]
    for va,n,h in re.findall(r'\{(\d+)ULL,(\d+)ULL,"([0-9a-f]+)"\}',(ROOT/'tools/firmware/f1_user_ui_entry_02/stock_windows.hpp').read_text()):
        va,n=int(va),int(n);digest=sha(b[bv.off(va,n):bv.off(va,n)+n]);assert digest==h
        hashes.append({'va':hex(va),'bytes':n,'sha256':digest,'candidate_matches_expected':True})
    csu=b[bv.off(0x9ef0b0,0x7c):bv.off(0x9ef0b0,0x7c)+0x7c]
    assert csu==a[av.off(0x9ef0b0,0x7c):av.off(0x9ef0b0,0x7c)+0x7c]
    result={'schema':'iq4_f1_startup_actual_candidate_review_01','candidate':row(candidate),'stock':row(stock),
      'dynamic_DT_INIT':hex(d[12]),'dynamic_DT_INIT_ARRAY':hex(d[25]),'dynamic_DT_INIT_ARRAYSZ':d[27],
      'dynamic_constructor_count':341,'original_340_prefix_preserved':True,
      'appended_initializer':hex(struct.unpack_from('<Q',arr,len(arr)-8)[0]),
      'actual_start_passes_init_x3':'0x9ef0b0','actual_csu_start':hex(start),'actual_csu_end':hex(end),'actual_csu_count':340,
      'actual_csu_whole_body_unchanged':True,'actual_csu_reads_dynamic_tags':False,
      'libc_nonzero_init_calls_provided_x3':True,
      'ld_call_init_empty_name_type0_returns_without_DT_INIT_or_ARRAY':True,
      'candidate_stock_code_window_hashes':hashes,'exact_windows':evidence,
      'definite_defect':'DT_INIT_ARRAY was extended but the actual executable CSU startup loop retains its original fixed 340-entry span.',
      'runtime_failure_code_observed':False,'target_executed':False,'camera_access':False}
    (OUT/'REVIEW.json').write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print(json.dumps({k:v for k,v in result.items()if k not in ('exact_windows','candidate_stock_code_window_hashes')},indent=2))
if __name__=='__main__':main()
