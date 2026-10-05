
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000006ee080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_>:
  6f07cc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  6f07d0: 910003fd     	mov	x29, sp
  6f07d4: a90153f3     	stp	x19, x20, [sp, #0x10]
  6f07d8: f90017e0     	str	x0, [sp, #0x28]
  6f07dc: f90013e1     	str	x1, [sp, #0x20]
  6f07e0: 3900ffff     	strb	wzr, [sp, #0x3f]
  6f07e4: 9100c3e0     	add	x0, sp, #0x30
  6f07e8: 940087ea     	bl	0x712790 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24710>
  6f07ec: f94013e0     	ldr	x0, [sp, #0x20]
  6f07f0: f100001f     	cmp	x0, #0x0
  6f07f4: 54000741     	b.ne	0x6f08dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x285c>
  6f07f8: f94017e0     	ldr	x0, [sp, #0x28]
  6f07fc: 9100c000     	add	x0, x0, #0x30
  6f0800: 94000131     	bl	0x6f0cc4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2c44>
  6f0804: 12001c00     	and	w0, w0, #0xff
  6f0808: 52000000     	eor	w0, w0, #0x1
  6f080c: 12001c00     	and	w0, w0, #0xff
  6f0810: 7100001f     	cmp	w0, #0x0
  6f0814: 54000120     	b.eq	0x6f0838 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x27b8>
  6f0818: f94017e0     	ldr	x0, [sp, #0x28]
  6f081c: 9100c000     	add	x0, x0, #0x30
  6f0820: 52800021     	mov	w1, #0x1                // =1
  6f0824: 94000131     	bl	0x6f0ce8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2c68>
  6f0828: 91012000     	add	x0, x0, #0x48
  6f082c: 94000141     	bl	0x6f0d30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2cb0>
  6f0830: f90013e0     	str	x0, [sp, #0x20]
  6f0834: 1400002a     	b	0x6f08dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x285c>
  6f0838: f94017e0     	ldr	x0, [sp, #0x28]
  6f083c: 91002000     	add	x0, x0, #0x8
  6f0840: 52800021     	mov	w1, #0x1                // =1
  6f0844: 94000129     	bl	0x6f0ce8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2c68>
  6f0848: f90013e0     	str	x0, [sp, #0x20]
  6f084c: f94013e0     	ldr	x0, [sp, #0x20]
  6f0850: f100001f     	cmp	x0, #0x0
  6f0854: 54000181     	b.ne	0x6f0884 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2804>
  6f0858: 90002940     	adrp	x0, 0xc18000
  6f085c: 91352003     	add	x3, x0, #0xd48
  6f0860: 52800922     	mov	w2, #0x49               // =73
  6f0864: 90002940     	adrp	x0, 0xc18000
  6f0868: 9135c001     	add	x1, x0, #0xd70
  6f086c: 90002940     	adrp	x0, 0xc18000
  6f0870: 91368000     	add	x0, x0, #0xda0
  6f0874: 94015762     	bl	0x7465fc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c8d0>
  6f0878: d2800014     	mov	x20, #0x0               // =0
  6f087c: 52800013     	mov	w19, #0x0               // =0
  6f0880: 14000029     	b	0x6f0924 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28a4>
  6f0884: f94013e0     	ldr	x0, [sp, #0x20]
  6f0888: b9401800     	ldr	w0, [x0, #0x18]
  6f088c: 7100001f     	cmp	w0, #0x0
  6f0890: 54000140     	b.eq	0x6f08b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2838>
  6f0894: 528009a3     	mov	w3, #0x4d               // =77
  6f0898: 90002940     	adrp	x0, 0xc18000
  6f089c: 9135c002     	add	x2, x0, #0xd70
  6f08a0: 90002940     	adrp	x0, 0xc18000
  6f08a4: 9136a001     	add	x1, x0, #0xda8
  6f08a8: 90002940     	adrp	x0, 0xc18000
  6f08ac: 91348000     	add	x0, x0, #0xd20
  6f08b0: 97f46734     	bl	0x40a580 <printf@plt>
  6f08b4: 9401ef95     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  6f08b8: f94013e2     	ldr	x2, [sp, #0x20]
  6f08bc: f94013e0     	ldr	x0, [sp, #0x20]
  6f08c0: f9400000     	ldr	x0, [x0]
  6f08c4: 91004000     	add	x0, x0, #0x10
  6f08c8: f9400001     	ldr	x1, [x0]
  6f08cc: aa0203e0     	mov	x0, x2
  6f08d0: d63f0020     	blr	x1
  6f08d4: 52800020     	mov	w0, #0x1                // =1
  6f08d8: 3900ffe0     	strb	w0, [sp, #0x3f]
  6f08dc: f94017e0     	ldr	x0, [sp, #0x28]
  6f08e0: 91016002     	add	x2, x0, #0x58
  6f08e4: f94013e0     	ldr	x0, [sp, #0x20]
  6f08e8: f100001f     	cmp	x0, #0x0
  6f08ec: 54000080     	b.eq	0x6f08fc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x287c>
  6f08f0: f94013e0     	ldr	x0, [sp, #0x20]
  6f08f4: 91012000     	add	x0, x0, #0x48
  6f08f8: 14000002     	b	0x6f0900 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2880>
  6f08fc: d2800000     	mov	x0, #0x0                // =0
  6f0900: aa0003e1     	mov	x1, x0
  6f0904: aa0203e0     	mov	x0, x2
  6f0908: 94000110     	bl	0x6f0d48 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2cc8>
  6f090c: f94013e0     	ldr	x0, [sp, #0x20]
  6f0910: b9401800     	ldr	w0, [x0, #0x18]
  6f0914: 11000401     	add	w1, w0, #0x1
  6f0918: f94013e0     	ldr	x0, [sp, #0x20]
  6f091c: b9001801     	str	w1, [x0, #0x18]
  6f0920: 52800033     	mov	w19, #0x1               // =1
  6f0924: 9100c3e0     	add	x0, sp, #0x30
  6f0928: 940087a7     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  6f092c: 7100067f     	cmp	w19, #0x1
  6f0930: 54000181     	b.ne	0x6f0960 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28e0>
  6f0934: 3940ffe0     	ldrb	w0, [sp, #0x3f]
  6f0938: 7100001f     	cmp	w0, #0x0
  6f093c: 54000100     	b.eq	0x6f095c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28dc>
  6f0940: f94013e2     	ldr	x2, [sp, #0x20]
  6f0944: f94013e0     	ldr	x0, [sp, #0x20]
  6f0948: f9400000     	ldr	x0, [x0]
  6f094c: 91006000     	add	x0, x0, #0x18
  6f0950: f9400001     	ldr	x1, [x0]
  6f0954: aa0203e0     	mov	x0, x2
  6f0958: d63f0020     	blr	x1
  6f095c: f94013f4     	ldr	x20, [sp, #0x20]
  6f0960: aa1403e0     	mov	x0, x20
  6f0964: 14000006     	b	0x6f097c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x28fc>
  6f0968: aa0003f3     	mov	x19, x0
  6f096c: 9100c3e0     	add	x0, sp, #0x30
  6f0970: 94008795     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  6f0974: aa1303e0     	mov	x0, x19
  6f0978: 97f46776     	bl	0x40a750 <_Unwind_Resume@plt>
  6f097c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  6f0980: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  6f0984: d65f03c0     	ret
