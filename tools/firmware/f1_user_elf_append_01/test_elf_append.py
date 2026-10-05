#!/usr/bin/env python3
"""Host data-only verification; synthetic target objects never execute."""
import json,struct,subprocess,sys,tempfile,unittest
from pathlib import Path
from elf_append import *
ROOT=Path(__file__).resolve().parents[3]
STOCK=ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
ZIG=ROOT/'build/toolchains/zig-aarch64-macos-0.15.2/zig'

class Tests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.stock=STOCK.read_bytes();cls.tmp=tempfile.TemporaryDirectory();out=Path(cls.tmp.name)/'fixture.o'
        p=subprocess.run([str(ZIG),'cc','-target','aarch64-linux-gnu','-c',str(Path(__file__).with_name('fixture.S')),'-o',str(out)],capture_output=True)
        if p.returncode:raise RuntimeError(p.stderr.decode())
        cls.obj=out.read_bytes();cls.link=Linker(cls.stock,[('SYNTHETIC_UNEXECUTED_FIXTURE',cls.obj)])
        cls.output,cls.report=cls.link.build((6,3,22))
    @classmethod
    def tearDownClass(cls):cls.tmp.cleanup()
    def test_plan_is_not_candidate(self):self.assertFalse(plan(self.stock)['candidate_emitted'])
    def test_bad_baseline_hash(self):
        data=bytearray(self.stock);data[300]^=1
        with self.assertRaises(Reject):original_contract(data)
    def test_no_payload_refused(self):
        with self.assertRaises(Reject):Linker(self.stock,[])
    def test_SO_refused(self):
        data=bytearray(self.obj);struct.pack_into('<H',data,16,3)
        with self.assertRaises(Reject):Linker(self.stock,[('SO',data)])
    def test_no_new_import(self):
        self.assertNotIn('bcmp',original_imports(original_contract(self.stock)))
        self.assertIn('__gxx_personality_v0',original_imports(original_contract(self.stock)))
    def test_PHDR_gap_and_kernel_bias(self):
        e=Elf(self.output,2);self.assertEqual(e.e[5],PH_OFF);verify_loads(e)
        self.assertEqual(e.ph[0][3],BASE_VA+PH_OFF)
        self.assertEqual(self.stock[0x40:0x270],self.output[0x40:0x270])
    def test_original_BODY_bytes_exact(self):
        verify_preservation(self.stock,self.output,self.report['allowed_original_spans'])
        data=bytearray(self.output);data[1000]^=1
        with self.assertRaises(Reject):verify_preservation(self.stock,data,self.report['allowed_original_spans'])
    def test_INIT_order_DT_INIT(self):
        e=Elf(self.output,2);idx=e.index('.f1.init_array');a=e.section_bytes(idx)
        self.assertEqual(a[:2720],original_contract(self.stock).section_bytes(original_contract(self.stock).index('.init_array')))
        self.assertEqual(struct.unpack_from('<Q',a,2720)[0],self.report['initializer_va'])
        tags=dict(struct.unpack_from('<qQ',e.section_bytes(e.index('.dynamic')),at) for at in range(0,e.sh[e.index('.dynamic')][5],16))
        self.assertEqual(tags[12],0x409b90);self.assertEqual(tags[27],2728);self.assertEqual(tags[25],e.sh[idx][3])
    def test_EH_merge_original_index(self):
        old=original_contract(self.stock);oi=old.index('.eh_frame_hdr');blob=old.section_bytes(oi);ova=old.sh[oi][3]
        orig={(ova+struct.unpack_from('<i',blob,k)[0],ova+struct.unpack_from('<i',blob,k+4)[0])for k in range(12,len(blob),8)}
        self.assertEqual(len(orig),32455);self.assertTrue(orig<=set(self.link.eh_pairs))
        self.assertEqual(len(self.link.own_eh_pairs),7)
        e=Elf(self.output,2);new=e.sh[e.index('.f1.eh_frame_hdr')];self.assertEqual(e.ph[7][3],new[3])
        self.assertEqual(e.ph[7][5],new[5]);self.assertEqual(self.output[old.sh[oi][4]:old.sh[oi][4]+old.sh[oi][5]],blob)
    def test_exact_three_BLs(self):
        for x in self.report['hooks']:
            word=int.from_bytes(self.output[x['file_offset']:x['file_offset']+4],'little');imm=word&0x3ffffff
            if imm&0x2000000:imm-=0x4000000
            self.assertEqual(x['va']+imm*4,x['new_target'])
    def test_data_ABS64(self):
        a=self.link.symbol_addresses['fixture_data'];s=next(s for s in self.link.sections if s.va<=a<s.va+s.size)
        self.assertEqual(struct.unpack_from('<Q',self.output,s.off+a-s.va)[0],self.link.symbol_addresses['iq4_f1_mode_get_01'])
    def test_version_refused(self):
        with self.assertRaises(Reject):Linker(self.stock,[('fixture',self.obj)]).build((6,3,21))
    def test_NO_unwind_refused(self):
        data=bytearray(self.obj);e=Elf(data,1)
        i=e.index('.eh_frame');h=e.sh[i][:];h[2]=0;SHDR.pack_into(data,e.e[6]+i*64,*h)
        with self.assertRaises(Reject):Linker(self.stock,[('NO_FDE',data)]).build((6,3,22))
    def test_unapproved_original_change_refused(self):
        a=bytearray(self.output);a[0x40]^=1
        with self.assertRaises(Reject):verify_preservation(self.stock,a,self.report['allowed_original_spans'])
    def test_overflow_rejected(self):
        with self.assertRaises(Reject):integer(1<<31,32,True)
    def test_TLS_refused(self):
        data=bytearray(self.obj);e=Elf(data,1);i=e.index('.data');h=e.sh[i][:];h[2]|=0x400;SHDR.pack_into(data,e.e[6]+i*64,*h)
        with self.assertRaises(Reject):Linker(self.stock,[('TLS',data)])
    def test_bad_relocation_refused(self):
        data=bytearray(self.obj);e=Elf(data,1);i=e.index('.rela.text');off=e.sh[i][4];a,info,add=RELA.unpack_from(data,off);RELA.pack_into(data,off,a,(info&~0xffffffff)|9999,add)
        with self.assertRaises(Reject):Linker(self.stock,[('UNKNOWN_RELOC',data)]).build((6,3,22))
    def test_load_overlap_rejected(self):
        e=Elf(self.output,2);e.ph[-1][3]=e.ph[-2][3]
        with self.assertRaises(Reject):verify_loads(e)
    def test_actual_new_dynamic_symbol_and_GLOB_DAT(self):
        out=Path(self.tmp.name)/'import.o'
        p=subprocess.run([str(ZIG),'cc','-target','aarch64-linux-gnu','-DTEST_TERMINATE_IMPORT','-c',str(Path(__file__).with_name('fixture.S')),'-o',str(out)],capture_output=True)
        self.assertEqual(p.returncode,0,p.stderr.decode())
        link=Linker(self.stock,[('SYNTHETIC_DYNAMIC_IMPORT',out.read_bytes())]);candidate,r=link.build((6,3,22));e=Elf(candidate,2)
        old=original_contract(self.stock);ds=e.section_bytes(e.index('.dynsym'));self.assertEqual(ds[:13080],old.section_bytes(old.index('.dynsym')))
        sy=e.symbols(e.index('.dynsym'));self.assertEqual(len(sy),546);self.assertEqual(sy[545][6],NEW_IMPORT);self.assertEqual(sy[545][3],0)
        vs=e.section_bytes(e.index('.gnu.version'));self.assertEqual(vs[:1090],old.section_bytes(old.index('.gnu.version')))
        self.assertEqual(struct.unpack_from('<H',vs,1090)[0],terminate_version(old))
        rela=e.section_bytes(e.index('.rela.dyn'));self.assertEqual(rela[:960],old.section_bytes(old.index('.rela.dyn')))
        address,info,add=RELA.unpack_from(rela,960);self.assertEqual((address,info,add),(link.terminate_got_va,(545<<32)|1025,0))
        self.assertEqual(candidate[e.va_offset(address,8):e.va_offset(address,8)+8],bytes(8))
        # Independent GNU hash bucket-chain search, every original index intact.
        h=e.section_bytes(e.index('.gnu.hash'));buckets,first,bloomcount,shift=struct.unpack_from('<4I',h)
        self.assertEqual((buckets,first,bloomcount,shift),(1,1,1,6))
        for index,x in enumerate(sy[1:],1):
            value=gnu_hash(x[6]);self.assertEqual(struct.unpack_from('<I',h,28+4*(index-1))[0]&~1,value&~1)
        self.assertEqual(struct.unpack_from('<I',h,len(h)-4)[0]&1,1)
        self.assertEqual(e.section_bytes(e.index('.gnu.version_r')),old.section_bytes(old.index('.gnu.version_r')))
        self.assertFalse(r['new_dynamic_import']['added_DT_NEEDED'])
    def test_actual_source_lock_two_revisions_not_relabelled(self):
        from input_lock import validate
        p=ROOT/'analysis/firmware/f1_user_elf_append_static_01'
        for name in ('ACTUAL_INPUT_LOCK.json','ACTUAL_INPUT_LOCK_UI02.json'):
            r=json.loads((p/name).read_text());self.assertEqual(len(validate(r)),11)
        r=json.loads((p/'ACTUAL_INPUT_LOCK.json').read_text());r['UI_revision']='02'
        with self.assertRaises(Reject):validate(r)
    def test_duplicate_object_role_rejected(self):
        from input_lock import validate
        p=ROOT/'analysis/firmware/f1_user_elf_append_static_01/ACTUAL_INPUT_LOCK_UI02.json';r=json.loads(p.read_text())
        r['objects'][1]=r['objects'][0].copy()
        with self.assertRaises(Reject):validate(r)

if __name__=='__main__':unittest.main()
