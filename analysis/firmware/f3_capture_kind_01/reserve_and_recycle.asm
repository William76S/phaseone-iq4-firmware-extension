
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c5770: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c5774: 910003fd     	mov	x29, sp
  8c5778: f9000fe0     	str	x0, [sp, #0x18]
  8c577c: f9000be1     	str	x1, [sp, #0x10]
  8c5780: f9400fe0     	ldr	x0, [sp, #0x18]
  8c5784: f9418c00     	ldr	x0, [x0, #0x318]
  8c5788: f9400be1     	ldr	x1, [sp, #0x10]
  8c578c: 9400056c     	bl	0x8c6d3c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20510>
  8c5790: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c5794: d65f03c0     	ret
  8c5798: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c579c: 910003fd     	mov	x29, sp
  8c57a0: f9000fe0     	str	x0, [sp, #0x18]
  8c57a4: f9000be1     	str	x1, [sp, #0x10]
  8c57a8: f9400fe0     	ldr	x0, [sp, #0x18]
  8c57ac: f9418c00     	ldr	x0, [x0, #0x318]
  8c57b0: f9400be1     	ldr	x1, [sp, #0x10]
  8c57b4: 940005c6     	bl	0x8c6ecc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x206a0>
  8c57b8: d503201f     	nop
  8c57bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c57c0: d65f03c0     	ret
  8c57c4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c57c8: 910003fd     	mov	x29, sp
  8c57cc: f9000fe0     	str	x0, [sp, #0x18]
  8c57d0: f9000be1     	str	x1, [sp, #0x10]
  8c57d4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c57d8: f9418c00     	ldr	x0, [x0, #0x318]
  8c57dc: f9400be1     	ldr	x1, [sp, #0x10]
  8c57e0: 940005f8     	bl	0x8c6fc0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20794>
  8c57e4: d503201f     	nop
  8c57e8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c57ec: d65f03c0     	ret
  8c57f0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8c57f4: 910003fd     	mov	x29, sp
  8c57f8: f9000fe0     	str	x0, [sp, #0x18]
  8c57fc: f9400fe0     	ldr	x0, [sp, #0x18]
  8c5800: f9418c00     	ldr	x0, [x0, #0x318]
  8c5804: d2800001     	mov	x1, #0x0                // =0
  8c5808: 9400054d     	bl	0x8c6d3c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20510>
  8c580c: f90017e0     	str	x0, [sp, #0x28]
  8c5810: f94017e0     	ldr	x0, [sp, #0x28]
  8c5814: f100001f     	cmp	x0, #0x0
  8c5818: 54000061     	b.ne	0x8c5824 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1eff8>
  8c581c: f94017e0     	ldr	x0, [sp, #0x28]
  8c5820: 14000022     	b	0x8c58a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f07c>
  8c5824: f0002760     	adrp	x0, 0xdb4000
  8c5828: 9117c003     	add	x3, x0, #0x5f0
  8c582c: 52800a22     	mov	w2, #0x51               // =81
  8c5830: f0002760     	adrp	x0, 0xdb4000
  8c5834: 9113e001     	add	x1, x0, #0x4f8
  8c5838: 52802000     	mov	w0, #0x100              // =256
  8c583c: 97fa0344     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5840: f94017e0     	ldr	x0, [sp, #0x28]
  8c5844: 97fff6a5     	bl	0x8c32d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1caac>
  8c5848: f94017e0     	ldr	x0, [sp, #0x28]
  8c584c: 97fff35d     	bl	0x8c25c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd94>
  8c5850: f100001f     	cmp	x0, #0x0
  8c5854: 1a9f17e0     	cset	w0, eq
  8c5858: 12001c00     	and	w0, w0, #0xff
  8c585c: 7100001f     	cmp	w0, #0x0
  8c5860: 540001a0     	b.eq	0x8c5894 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f068>
  8c5864: f0002760     	adrp	x0, 0xdb4000
  8c5868: 91194002     	add	x2, x0, #0x650
  8c586c: 52800ae1     	mov	w1, #0x57               // =87
  8c5870: f0002760     	adrp	x0, 0xdb4000
  8c5874: 9113e000     	add	x0, x0, #0x4f8
  8c5878: 97fa0309     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8c587c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c5880: f9418c00     	ldr	x0, [x0, #0x318]
  8c5884: f94017e1     	ldr	x1, [sp, #0x28]
  8c5888: 94000591     	bl	0x8c6ecc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x206a0>
  8c588c: d2800000     	mov	x0, #0x0                // =0
  8c5890: 14000006     	b	0x8c58a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f07c>
  8c5894: f94017e0     	ldr	x0, [sp, #0x28]
  8c5898: 97fff3ae     	bl	0x8c2750 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bf24>
  8c589c: f94017e0     	ldr	x0, [sp, #0x28]
  8c58a0: 97fff40a     	bl	0x8c28c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c09c>
  8c58a4: f94017e0     	ldr	x0, [sp, #0x28]
  8c58a8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8c58ac: d65f03c0     	ret
  8c58b0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c58b4: 910003fd     	mov	x29, sp
  8c58b8: f9000fe0     	str	x0, [sp, #0x18]
  8c58bc: f9000be1     	str	x1, [sp, #0x10]
  8c58c0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c58c4: 91002002     	add	x2, x0, #0x8
  8c58c8: f9400be0     	ldr	x0, [sp, #0x10]
  8c58cc: 9101e000     	add	x0, x0, #0x78
  8c58d0: aa0003e1     	mov	x1, x0
  8c58d4: aa0203e0     	mov	x0, x2
  8c58d8: 940005f1     	bl	0x8c709c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20870>
  8c58dc: d503201f     	nop
  8c58e0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c58e4: d65f03c0     	ret
  8c58e8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c58ec: 910003fd     	mov	x29, sp
  8c58f0: f9000fe0     	str	x0, [sp, #0x18]
  8c58f4: f9000be1     	str	x1, [sp, #0x10]
  8c58f8: f9400fe0     	ldr	x0, [sp, #0x18]
  8c58fc: 91026002     	add	x2, x0, #0x98
  8c5900: f9400be0     	ldr	x0, [sp, #0x10]
  8c5904: 9101e000     	add	x0, x0, #0x78
  8c5908: aa0003e1     	mov	x1, x0
  8c590c: aa0203e0     	mov	x0, x2
  8c5910: 940005e3     	bl	0x8c709c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20870>
  8c5914: d503201f     	nop
  8c5918: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c591c: d65f03c0     	ret
  8c5920: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c5924: 910003fd     	mov	x29, sp
  8c5928: f9000fe0     	str	x0, [sp, #0x18]
  8c592c: f9000be1     	str	x1, [sp, #0x10]
  8c5930: f9400fe0     	ldr	x0, [sp, #0x18]
  8c5934: 9104a002     	add	x2, x0, #0x128
  8c5938: f9400be0     	ldr	x0, [sp, #0x10]
  8c593c: 9101e000     	add	x0, x0, #0x78
  8c5940: aa0003e1     	mov	x1, x0
  8c5944: aa0203e0     	mov	x0, x2
  8c5948: 940005d5     	bl	0x8c709c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20870>
  8c594c: d503201f     	nop
  8c5950: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c5954: d65f03c0     	ret
  8c5958: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c595c: 910003fd     	mov	x29, sp
  8c5960: f9000fe0     	str	x0, [sp, #0x18]
  8c5964: f9000be1     	str	x1, [sp, #0x10]
  8c5968: f9400fe0     	ldr	x0, [sp, #0x18]
  8c596c: 9106e002     	add	x2, x0, #0x1b8
  8c5970: f9400be0     	ldr	x0, [sp, #0x10]
  8c5974: 9101e000     	add	x0, x0, #0x78
  8c5978: aa0003e1     	mov	x1, x0
  8c597c: aa0203e0     	mov	x0, x2
  8c5980: 940005c7     	bl	0x8c709c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20870>
  8c5984: d503201f     	nop
  8c5988: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c598c: d65f03c0     	ret
  8c5990: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c5994: 910003fd     	mov	x29, sp
  8c5998: f9000fe0     	str	x0, [sp, #0x18]
  8c599c: f9000be1     	str	x1, [sp, #0x10]
  8c59a0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c59a4: f9419000     	ldr	x0, [x0, #0x320]
  8c59a8: f100001f     	cmp	x0, #0x0
  8c59ac: 54000100     	b.eq	0x8c59cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f1a0>
  8c59b0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c59b4: f9419002     	ldr	x2, [x0, #0x320]
  8c59b8: f9400be0     	ldr	x0, [sp, #0x10]
  8c59bc: b940d800     	ldr	w0, [x0, #0xd8]
  8c59c0: 2a0003e1     	mov	w1, w0
  8c59c4: aa0203e0     	mov	x0, x2
  8c59c8: 97ef434b     	bl	0x4966f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60748>
  8c59cc: f9400be0     	ldr	x0, [sp, #0x10]
  8c59d0: 97fff384     	bl	0x8c27e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bfb4>
  8c59d4: f9400be0     	ldr	x0, [sp, #0x10]
  8c59d8: 97f8ab55     	bl	0x6f072c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x26ac>
  8c59dc: 12001c00     	and	w0, w0, #0xff
  8c59e0: 7100001f     	cmp	w0, #0x0
  8c59e4: 54000060     	b.eq	0x8c59f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f1c4>
  8c59e8: f9400be0     	ldr	x0, [sp, #0x10]
  8c59ec: 97fff3db     	bl	0x8c2958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c12c>
  8c59f0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c59f4: 91092002     	add	x2, x0, #0x248
  8c59f8: f9400be0     	ldr	x0, [sp, #0x10]
  8c59fc: 9101e000     	add	x0, x0, #0x78
  8c5a00: aa0003e1     	mov	x1, x0
  8c5a04: aa0203e0     	mov	x0, x2
  8c5a08: 940005a5     	bl	0x8c709c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20870>
  8c5a0c: d503201f     	nop
  8c5a10: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c5a14: d65f03c0     	ret
  8c5a18: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8c5a1c: 910003fd     	mov	x29, sp
  8c5a20: f9000fe0     	str	x0, [sp, #0x18]
  8c5a24: f9000be1     	str	x1, [sp, #0x10]
  8c5a28: f9400be0     	ldr	x0, [sp, #0x10]
  8c5a2c: f9404400     	ldr	x0, [x0, #0x88]
  8c5a30: f100001f     	cmp	x0, #0x0
  8c5a34: 54000fe0     	b.eq	0x8c5c30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f404>
  8c5a38: b9002fff     	str	wzr, [sp, #0x2c]
  8c5a3c: 3900afff     	strb	wzr, [sp, #0x2b]
  8c5a40: f9400be0     	ldr	x0, [sp, #0x10]
  8c5a44: f9404400     	ldr	x0, [x0, #0x88]
  8c5a48: b9401800     	ldr	w0, [x0, #0x18]
  8c5a4c: 7100041f     	cmp	w0, #0x1
  8c5a50: 54000e09     	b.ls	0x8c5c10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f3e4>
  8c5a54: f0002760     	adrp	x0, 0xdb4000
  8c5a58: 911a8002     	add	x2, x0, #0x6a0
  8c5a5c: 52801481     	mov	w1, #0xa4               // =164
  8c5a60: f0002760     	adrp	x0, 0xdb4000
  8c5a64: 9113e000     	add	x0, x0, #0x4f8
  8c5a68: 97fa028d     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8c5a6c: b9002fff     	str	wzr, [sp, #0x2c]
  8c5a70: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5a74: 710f9c1f     	cmp	w0, #0x3e7
  8c5a78: 5400074c     	b.gt	0x8c5b60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f334>
  8c5a7c: 52800140     	mov	w0, #0xa                // =10
  8c5a80: 97f92bee     	bl	0x710a38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x229b8>
  8c5a84: f9400be0     	ldr	x0, [sp, #0x10]
  8c5a88: f9404400     	ldr	x0, [x0, #0x88]
  8c5a8c: b9401800     	ldr	w0, [x0, #0x18]
  8c5a90: 7100041f     	cmp	w0, #0x1
  8c5a94: 540003a1     	b.ne	0x8c5b08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f2dc>
  8c5a98: 52800020     	mov	w0, #0x1                // =1
  8c5a9c: 3900afe0     	strb	w0, [sp, #0x2b]
  8c5aa0: f001c9a0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c5aa4: 910f5000     	add	x0, x0, #0x3d4
  8c5aa8: b9400000     	ldr	w0, [x0]
  8c5aac: b9402fe1     	ldr	w1, [sp, #0x2c]
  8c5ab0: 6b00003f     	cmp	w1, w0
  8c5ab4: 5400054d     	b.le	0x8c5b5c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f330>
  8c5ab8: f001c9a0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c5abc: 910f5000     	add	x0, x0, #0x3d4
  8c5ac0: b9402fe1     	ldr	w1, [sp, #0x2c]
  8c5ac4: b9000001     	str	w1, [x0]
  8c5ac8: f001c9a0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c5acc: 910f5000     	add	x0, x0, #0x3d4
  8c5ad0: b9400001     	ldr	w1, [x0]
  8c5ad4: 2a0103e0     	mov	w0, w1
  8c5ad8: 531e7400     	lsl	w0, w0, #2
  8c5adc: 0b010000     	add	w0, w0, w1
  8c5ae0: 531f7800     	lsl	w0, w0, #1
  8c5ae4: 2a0003e4     	mov	w4, w0
  8c5ae8: f0002760     	adrp	x0, 0xdb4000
  8c5aec: 911b8003     	add	x3, x0, #0x6e0
  8c5af0: 528015c2     	mov	w2, #0xae               // =174
  8c5af4: f0002760     	adrp	x0, 0xdb4000
  8c5af8: 9113e001     	add	x1, x0, #0x4f8
  8c5afc: 52800040     	mov	w0, #0x2                // =2
  8c5b00: 97fa0293     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5b04: 14000016     	b	0x8c5b5c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f330>
  8c5b08: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5b0c: 7100281f     	cmp	w0, #0xa
  8c5b10: 540001e1     	b.ne	0x8c5b4c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f320>
  8c5b14: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b18: b940dc01     	ldr	w1, [x0, #0xdc]
  8c5b1c: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b20: f9404400     	ldr	x0, [x0, #0x88]
  8c5b24: b9401800     	ldr	w0, [x0, #0x18]
  8c5b28: 2a0003e5     	mov	w5, w0
  8c5b2c: 2a0103e4     	mov	w4, w1
  8c5b30: f0002760     	adrp	x0, 0xdb4000
  8c5b34: 911c0003     	add	x3, x0, #0x700
  8c5b38: 528016a2     	mov	w2, #0xb5               // =181
  8c5b3c: f0002760     	adrp	x0, 0xdb4000
  8c5b40: 9113e001     	add	x1, x0, #0x4f8
  8c5b44: 52800040     	mov	w0, #0x2                // =2
  8c5b48: 97fa0281     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5b4c: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5b50: 11000400     	add	w0, w0, #0x1
  8c5b54: b9002fe0     	str	w0, [sp, #0x2c]
  8c5b58: 17ffffc6     	b	0x8c5a70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f244>
  8c5b5c: d503201f     	nop
  8c5b60: 3940afe0     	ldrb	w0, [sp, #0x2b]
  8c5b64: 52000000     	eor	w0, w0, #0x1
  8c5b68: 12001c00     	and	w0, w0, #0xff
  8c5b6c: 7100001f     	cmp	w0, #0x0
  8c5b70: 54000200     	b.eq	0x8c5bb0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f384>
  8c5b74: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b78: b940dc01     	ldr	w1, [x0, #0xdc]
  8c5b7c: f9400be0     	ldr	x0, [sp, #0x10]
  8c5b80: f9404400     	ldr	x0, [x0, #0x88]
  8c5b84: b9401800     	ldr	w0, [x0, #0x18]
  8c5b88: 2a0003e5     	mov	w5, w0
  8c5b8c: 2a0103e4     	mov	w4, w1
  8c5b90: f0002760     	adrp	x0, 0xdb4000
  8c5b94: 911cc003     	add	x3, x0, #0x730
  8c5b98: 52801762     	mov	w2, #0xbb               // =187
  8c5b9c: f0002760     	adrp	x0, 0xdb4000
  8c5ba0: 9113e001     	add	x1, x0, #0x4f8
  8c5ba4: 52800080     	mov	w0, #0x4                // =4
  8c5ba8: 97fa0269     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5bac: 14000019     	b	0x8c5c10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f3e4>
  8c5bb0: b9402fe0     	ldr	w0, [sp, #0x2c]
  8c5bb4: 7100281f     	cmp	w0, #0xa
  8c5bb8: 540002cd     	b.le	0x8c5c10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f3e4>
  8c5bbc: b9402fe1     	ldr	w1, [sp, #0x2c]
  8c5bc0: 2a0103e0     	mov	w0, w1
  8c5bc4: 531e7400     	lsl	w0, w0, #2
  8c5bc8: 0b010000     	add	w0, w0, w1
  8c5bcc: 531f7800     	lsl	w0, w0, #1
  8c5bd0: 2a0003e2     	mov	w2, w0
  8c5bd4: f9400be0     	ldr	x0, [sp, #0x10]
  8c5bd8: b940dc01     	ldr	w1, [x0, #0xdc]
  8c5bdc: f9400be0     	ldr	x0, [sp, #0x10]
  8c5be0: f9404400     	ldr	x0, [x0, #0x88]
  8c5be4: b9401800     	ldr	w0, [x0, #0x18]
  8c5be8: 2a0003e6     	mov	w6, w0
  8c5bec: 2a0103e5     	mov	w5, w1
  8c5bf0: 2a0203e4     	mov	w4, w2
  8c5bf4: f0002760     	adrp	x0, 0xdb4000
  8c5bf8: 911e2003     	add	x3, x0, #0x788
  8c5bfc: 52801822     	mov	w2, #0xc1               // =193
  8c5c00: f0002760     	adrp	x0, 0xdb4000
  8c5c04: 9113e001     	add	x1, x0, #0x4f8
  8c5c08: 52808000     	mov	w0, #0x400              // =1024
  8c5c0c: 97fa0250     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8c5c10: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c14: 97fff2b1     	bl	0x8c26d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1beac>
  8c5c18: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c1c: f9404400     	ldr	x0, [x0, #0x88]
  8c5c20: f100001f     	cmp	x0, #0x0
  8c5c24: 54000060     	b.eq	0x8c5c30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f404>
  8c5c28: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c2c: 97fff28f     	bl	0x8c2668 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be3c>
  8c5c30: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c34: f9404800     	ldr	x0, [x0, #0x90]
  8c5c38: f100001f     	cmp	x0, #0x0
  8c5c3c: 54000060     	b.eq	0x8c5c48 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f41c>
  8c5c40: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c44: 97fff303     	bl	0x8c2850 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c024>
  8c5c48: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c4c: 97fff247     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  8c5c50: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c54: 97fff5a1     	bl	0x8c32d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1caac>
  8c5c58: d503201f     	nop
  8c5c5c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8c5c60: d65f03c0     	ret
  8c5c64: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c5c68: 910003fd     	mov	x29, sp
  8c5c6c: f9000fe0     	str	x0, [sp, #0x18]
  8c5c70: f9000be1     	str	x1, [sp, #0x10]
  8c5c74: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c78: 97fff2f6     	bl	0x8c2850 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c024>
  8c5c7c: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c80: 97f8aaab     	bl	0x6f072c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x26ac>
  8c5c84: 12001c00     	and	w0, w0, #0xff
  8c5c88: 7100001f     	cmp	w0, #0x0
  8c5c8c: 54000080     	b.eq	0x8c5c9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f470>
  8c5c90: f9400be0     	ldr	x0, [sp, #0x10]
  8c5c94: 97fff34d     	bl	0x8c29c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c19c>
  8c5c98: 14000007     	b	0x8c5cb4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f488>
  8c5c9c: f0002760     	adrp	x0, 0xdb4000
  8c5ca0: 911f0002     	add	x2, x0, #0x7c0
  8c5ca4: 52801d61     	mov	w1, #0xeb               // =235
  8c5ca8: f0002760     	adrp	x0, 0xdb4000
  8c5cac: 9113e000     	add	x0, x0, #0x4f8
  8c5cb0: 97fa01fb     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8c5cb4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c5cb8: 91092002     	add	x2, x0, #0x248
  8c5cbc: f9400be0     	ldr	x0, [sp, #0x10]
  8c5cc0: 9101e000     	add	x0, x0, #0x78
  8c5cc4: aa0003e1     	mov	x1, x0
  8c5cc8: aa0203e0     	mov	x0, x2
  8c5ccc: 940004f4     	bl	0x8c709c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20870>
  8c5cd0: d503201f     	nop
  8c5cd4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c5cd8: d65f03c0     	ret
  8c5cdc: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
