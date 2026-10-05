
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c36c0: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8c36c4: 910003fd     	mov	x29, sp
  8c36c8: a90153f3     	stp	x19, x20, [sp, #0x10]
  8c36cc: f90017e0     	str	x0, [sp, #0x28]
  8c36d0: f90013e1     	str	x1, [sp, #0x20]
  8c36d4: 3900ffff     	strb	wzr, [sp, #0x3f]
  8c36d8: 9100c3e0     	add	x0, sp, #0x30
  8c36dc: 97f93c2d     	bl	0x712790 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24710>
  8c36e0: f94013e0     	ldr	x0, [sp, #0x20]
  8c36e4: f100001f     	cmp	x0, #0x0
  8c36e8: 54000741     	b.ne	0x8c37d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cfa4>
  8c36ec: f94017e0     	ldr	x0, [sp, #0x28]
  8c36f0: 9100c000     	add	x0, x0, #0x30
  8c36f4: 940005a7     	bl	0x8c4d90 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1e564>
  8c36f8: 12001c00     	and	w0, w0, #0xff
  8c36fc: 52000000     	eor	w0, w0, #0x1
  8c3700: 12001c00     	and	w0, w0, #0xff
  8c3704: 7100001f     	cmp	w0, #0x0
  8c3708: 54000120     	b.eq	0x8c372c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cf00>
  8c370c: f94017e0     	ldr	x0, [sp, #0x28]
  8c3710: 9100c000     	add	x0, x0, #0x30
  8c3714: 52800021     	mov	w1, #0x1                // =1
  8c3718: 940005a7     	bl	0x8c4db4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1e588>
  8c371c: 91012000     	add	x0, x0, #0x48
  8c3720: 940005b7     	bl	0x8c4dfc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1e5d0>
  8c3724: f90013e0     	str	x0, [sp, #0x20]
  8c3728: 1400002a     	b	0x8c37d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cfa4>
  8c372c: f94017e0     	ldr	x0, [sp, #0x28]
  8c3730: 91002000     	add	x0, x0, #0x8
  8c3734: 52800021     	mov	w1, #0x1                // =1
  8c3738: 9400059f     	bl	0x8c4db4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1e588>
  8c373c: f90013e0     	str	x0, [sp, #0x20]
  8c3740: f94013e0     	ldr	x0, [sp, #0x20]
  8c3744: f100001f     	cmp	x0, #0x0
  8c3748: 54000181     	b.ne	0x8c3778 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cf4c>
  8c374c: b0002780     	adrp	x0, 0xdb4000
  8c3750: 9101c003     	add	x3, x0, #0x70
  8c3754: 52800922     	mov	w2, #0x49               // =73
  8c3758: b0002780     	adrp	x0, 0xdb4000
  8c375c: 91026001     	add	x1, x0, #0x98
  8c3760: b0002780     	adrp	x0, 0xdb4000
  8c3764: 91032000     	add	x0, x0, #0xc8
  8c3768: 97fa0ba5     	bl	0x7465fc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c8d0>
  8c376c: d2800014     	mov	x20, #0x0               // =0
  8c3770: 52800013     	mov	w19, #0x0               // =0
  8c3774: 14000029     	b	0x8c3818 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cfec>
  8c3778: f94013e0     	ldr	x0, [sp, #0x20]
  8c377c: b9401800     	ldr	w0, [x0, #0x18]
  8c3780: 7100001f     	cmp	w0, #0x0
  8c3784: 54000140     	b.eq	0x8c37ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cf80>
  8c3788: 528009a3     	mov	w3, #0x4d               // =77
  8c378c: b0002780     	adrp	x0, 0xdb4000
  8c3790: 91026002     	add	x2, x0, #0x98
  8c3794: b0002780     	adrp	x0, 0xdb4000
  8c3798: 91034001     	add	x1, x0, #0xd0
  8c379c: 90002780     	adrp	x0, 0xdb3000
  8c37a0: 913b8000     	add	x0, x0, #0xee0
  8c37a4: 97ed1b77     	bl	0x40a580 <printf@plt>
  8c37a8: 97faa3d8     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c37ac: f94013e2     	ldr	x2, [sp, #0x20]
  8c37b0: f94013e0     	ldr	x0, [sp, #0x20]
  8c37b4: f9400000     	ldr	x0, [x0]
  8c37b8: 91004000     	add	x0, x0, #0x10
  8c37bc: f9400001     	ldr	x1, [x0]
  8c37c0: aa0203e0     	mov	x0, x2
  8c37c4: d63f0020     	blr	x1
  8c37c8: 52800020     	mov	w0, #0x1                // =1
  8c37cc: 3900ffe0     	strb	w0, [sp, #0x3f]
  8c37d0: f94017e0     	ldr	x0, [sp, #0x28]
  8c37d4: 91016002     	add	x2, x0, #0x58
  8c37d8: f94013e0     	ldr	x0, [sp, #0x20]
  8c37dc: f100001f     	cmp	x0, #0x0
  8c37e0: 54000080     	b.eq	0x8c37f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cfc4>
  8c37e4: f94013e0     	ldr	x0, [sp, #0x20]
  8c37e8: 91012000     	add	x0, x0, #0x48
  8c37ec: 14000002     	b	0x8c37f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cfc8>
  8c37f0: d2800000     	mov	x0, #0x0                // =0
  8c37f4: aa0003e1     	mov	x1, x0
  8c37f8: aa0203e0     	mov	x0, x2
  8c37fc: 94000586     	bl	0x8c4e14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1e5e8>
  8c3800: f94013e0     	ldr	x0, [sp, #0x20]
  8c3804: b9401800     	ldr	w0, [x0, #0x18]
  8c3808: 11000401     	add	w1, w0, #0x1
  8c380c: f94013e0     	ldr	x0, [sp, #0x20]
  8c3810: b9001801     	str	w1, [x0, #0x18]
  8c3814: 52800033     	mov	w19, #0x1               // =1
  8c3818: 9100c3e0     	add	x0, sp, #0x30
  8c381c: 97f93bea     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c3820: 7100067f     	cmp	w19, #0x1
  8c3824: 54000181     	b.ne	0x8c3854 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d028>
  8c3828: 3940ffe0     	ldrb	w0, [sp, #0x3f]
  8c382c: 7100001f     	cmp	w0, #0x0
  8c3830: 54000100     	b.eq	0x8c3850 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d024>
  8c3834: f94013e2     	ldr	x2, [sp, #0x20]
  8c3838: f94013e0     	ldr	x0, [sp, #0x20]
  8c383c: f9400000     	ldr	x0, [x0]
  8c3840: 91006000     	add	x0, x0, #0x18
  8c3844: f9400001     	ldr	x1, [x0]
  8c3848: aa0203e0     	mov	x0, x2
  8c384c: d63f0020     	blr	x1
  8c3850: f94013f4     	ldr	x20, [sp, #0x20]
  8c3854: aa1403e0     	mov	x0, x20
  8c3858: 14000006     	b	0x8c3870 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d044>
  8c385c: aa0003f3     	mov	x19, x0
  8c3860: 9100c3e0     	add	x0, sp, #0x30
  8c3864: 97f93bd8     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c3868: aa1303e0     	mov	x0, x19
  8c386c: 97ed1bb9     	bl	0x40a750 <_Unwind_Resume@plt>
  8c3870: a94153f3     	ldp	x19, x20, [sp, #0x10]
  8c3874: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8c3878: d65f03c0     	ret
