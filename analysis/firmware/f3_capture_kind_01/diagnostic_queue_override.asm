
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000006ee080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_>:
  6eea1c: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  6eea20: 910003fd     	mov	x29, sp
  6eea24: f9000fe0     	str	x0, [sp, #0x18]
  6eea28: f9000be1     	str	x1, [sp, #0x10]
  6eea2c: 52800040     	mov	w0, #0x2                // =2
  6eea30: b9004fe0     	str	w0, [sp, #0x4c]
  6eea34: f9400be4     	ldr	x4, [sp, #0x10]
  6eea38: 52800003     	mov	w3, #0x0                // =0
  6eea3c: d0002940     	adrp	x0, 0xc18000
  6eea40: 911a8002     	add	x2, x0, #0x6a0
  6eea44: 52800041     	mov	w1, #0x2                // =2
  6eea48: aa0403e0     	mov	x0, x4
  6eea4c: 940147a2     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eea50: 12001c00     	and	w0, w0, #0xff
  6eea54: 7100001f     	cmp	w0, #0x0
  6eea58: 540003e0     	b.eq	0x6eead4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xa54>
  6eea5c: f9400fe0     	ldr	x0, [sp, #0x18]
  6eea60: f9401800     	ldr	x0, [x0, #0x30]
  6eea64: 94075b63     	bl	0x8c57f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1efc4>
  6eea68: aa0003e1     	mov	x1, x0
  6eea6c: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eea70: 91336000     	add	x0, x0, #0xcd8
  6eea74: f9000001     	str	x1, [x0]
  6eea78: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eea7c: 91336000     	add	x0, x0, #0xcd8
  6eea80: f9400000     	ldr	x0, [x0]
  6eea84: f100001f     	cmp	x0, #0x0
  6eea88: 54000140     	b.eq	0x6eeab0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xa30>
  6eea8c: f9400be0     	ldr	x0, [sp, #0x10]
  6eea90: f9400000     	ldr	x0, [x0]
  6eea94: 91008000     	add	x0, x0, #0x20
  6eea98: f9400002     	ldr	x2, [x0]
  6eea9c: d0002940     	adrp	x0, 0xc18000
  6eeaa0: 911aa001     	add	x1, x0, #0x6a8
  6eeaa4: f9400be0     	ldr	x0, [sp, #0x10]
  6eeaa8: d63f0040     	blr	x2
  6eeaac: 140000b5     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eeab0: f9400be0     	ldr	x0, [sp, #0x10]
  6eeab4: f9400000     	ldr	x0, [x0]
  6eeab8: 91008000     	add	x0, x0, #0x20
  6eeabc: f9400002     	ldr	x2, [x0]
  6eeac0: d0002940     	adrp	x0, 0xc18000
  6eeac4: 911b2001     	add	x1, x0, #0x6c8
  6eeac8: f9400be0     	ldr	x0, [sp, #0x10]
  6eeacc: d63f0040     	blr	x2
  6eead0: 140000ac     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eead4: f9400be4     	ldr	x4, [sp, #0x10]
  6eead8: 52800003     	mov	w3, #0x0                // =0
  6eeadc: d0002940     	adrp	x0, 0xc18000
  6eeae0: 911be002     	add	x2, x0, #0x6f8
  6eeae4: 52800041     	mov	w1, #0x2                // =2
  6eeae8: aa0403e0     	mov	x0, x4
  6eeaec: 9401477a     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eeaf0: 12001c00     	and	w0, w0, #0xff
  6eeaf4: 7100001f     	cmp	w0, #0x0
  6eeaf8: 54000440     	b.eq	0x6eeb80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xb00>
  6eeafc: f9400fe0     	ldr	x0, [sp, #0x18]
  6eeb00: f9401800     	ldr	x0, [x0, #0x30]
  6eeb04: 91002000     	add	x0, x0, #0x8
  6eeb08: 97f69a07     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  6eeb0c: f90023e0     	str	x0, [sp, #0x40]
  6eeb10: f94023e0     	ldr	x0, [sp, #0x40]
  6eeb14: f100001f     	cmp	x0, #0x0
  6eeb18: 54000141     	b.ne	0x6eeb40 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xac0>
  6eeb1c: f9400be0     	ldr	x0, [sp, #0x10]
  6eeb20: f9400000     	ldr	x0, [x0]
  6eeb24: 91008000     	add	x0, x0, #0x20
  6eeb28: f9400002     	ldr	x2, [x0]
  6eeb2c: d0002940     	adrp	x0, 0xc18000
  6eeb30: 911c0001     	add	x1, x0, #0x700
  6eeb34: f9400be0     	ldr	x0, [sp, #0x10]
  6eeb38: d63f0040     	blr	x2
  6eeb3c: 14000091     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eeb40: f9400fe0     	ldr	x0, [sp, #0x18]
  6eeb44: f9401802     	ldr	x2, [x0, #0x30]
  6eeb48: f94023e0     	ldr	x0, [sp, #0x40]
  6eeb4c: f9400400     	ldr	x0, [x0, #0x8]
  6eeb50: aa0003e1     	mov	x1, x0
  6eeb54: aa0203e0     	mov	x0, x2
  6eeb58: 94075b64     	bl	0x8c58e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f0bc>
  6eeb5c: f9400be0     	ldr	x0, [sp, #0x10]
  6eeb60: f9400000     	ldr	x0, [x0]
  6eeb64: 91008000     	add	x0, x0, #0x20
  6eeb68: f9400002     	ldr	x2, [x0]
  6eeb6c: d0002940     	adrp	x0, 0xc18000
  6eeb70: 911ca001     	add	x1, x0, #0x728
  6eeb74: f9400be0     	ldr	x0, [sp, #0x10]
  6eeb78: d63f0040     	blr	x2
  6eeb7c: 14000081     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eeb80: f9400be4     	ldr	x4, [sp, #0x10]
  6eeb84: 52800003     	mov	w3, #0x0                // =0
  6eeb88: d0002940     	adrp	x0, 0xc18000
  6eeb8c: 911d2002     	add	x2, x0, #0x748
  6eeb90: 52800041     	mov	w1, #0x2                // =2
  6eeb94: aa0403e0     	mov	x0, x4
  6eeb98: 9401474f     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eeb9c: 12001c00     	and	w0, w0, #0xff
  6eeba0: 7100001f     	cmp	w0, #0x0
  6eeba4: 54000440     	b.eq	0x6eec2c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xbac>
  6eeba8: f9400fe0     	ldr	x0, [sp, #0x18]
  6eebac: f9401800     	ldr	x0, [x0, #0x30]
  6eebb0: 91026000     	add	x0, x0, #0x98
  6eebb4: 97f699dc     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  6eebb8: f9001fe0     	str	x0, [sp, #0x38]
  6eebbc: f9401fe0     	ldr	x0, [sp, #0x38]
  6eebc0: f100001f     	cmp	x0, #0x0
  6eebc4: 54000141     	b.ne	0x6eebec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xb6c>
  6eebc8: f9400be0     	ldr	x0, [sp, #0x10]
  6eebcc: f9400000     	ldr	x0, [x0]
  6eebd0: 91008000     	add	x0, x0, #0x20
  6eebd4: f9400002     	ldr	x2, [x0]
  6eebd8: d0002940     	adrp	x0, 0xc18000
  6eebdc: 911d6001     	add	x1, x0, #0x758
  6eebe0: f9400be0     	ldr	x0, [sp, #0x10]
  6eebe4: d63f0040     	blr	x2
  6eebe8: 14000066     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eebec: f9400fe0     	ldr	x0, [sp, #0x18]
  6eebf0: f9401802     	ldr	x2, [x0, #0x30]
  6eebf4: f9401fe0     	ldr	x0, [sp, #0x38]
  6eebf8: f9400400     	ldr	x0, [x0, #0x8]
  6eebfc: aa0003e1     	mov	x1, x0
  6eec00: aa0203e0     	mov	x0, x2
  6eec04: 94075b47     	bl	0x8c5920 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f0f4>
  6eec08: f9400be0     	ldr	x0, [sp, #0x10]
  6eec0c: f9400000     	ldr	x0, [x0]
  6eec10: 91008000     	add	x0, x0, #0x20
  6eec14: f9400002     	ldr	x2, [x0]
  6eec18: d0002940     	adrp	x0, 0xc18000
  6eec1c: 911e0001     	add	x1, x0, #0x780
  6eec20: f9400be0     	ldr	x0, [sp, #0x10]
  6eec24: d63f0040     	blr	x2
  6eec28: 14000056     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eec2c: f9400be4     	ldr	x4, [sp, #0x10]
  6eec30: 52800003     	mov	w3, #0x0                // =0
  6eec34: d0002940     	adrp	x0, 0xc18000
  6eec38: 911e6002     	add	x2, x0, #0x798
  6eec3c: 52800041     	mov	w1, #0x2                // =2
  6eec40: aa0403e0     	mov	x0, x4
  6eec44: 94014724     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eec48: 12001c00     	and	w0, w0, #0xff
  6eec4c: 7100001f     	cmp	w0, #0x0
  6eec50: 54000440     	b.eq	0x6eecd8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xc58>
  6eec54: f9400fe0     	ldr	x0, [sp, #0x18]
  6eec58: f9401800     	ldr	x0, [x0, #0x30]
  6eec5c: 9104a000     	add	x0, x0, #0x128
  6eec60: 97f699b1     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  6eec64: f9001be0     	str	x0, [sp, #0x30]
  6eec68: f9401be0     	ldr	x0, [sp, #0x30]
  6eec6c: f100001f     	cmp	x0, #0x0
  6eec70: 54000141     	b.ne	0x6eec98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xc18>
  6eec74: f9400be0     	ldr	x0, [sp, #0x10]
  6eec78: f9400000     	ldr	x0, [x0]
  6eec7c: 91008000     	add	x0, x0, #0x20
  6eec80: f9400002     	ldr	x2, [x0]
  6eec84: d0002940     	adrp	x0, 0xc18000
  6eec88: 911e8001     	add	x1, x0, #0x7a0
  6eec8c: f9400be0     	ldr	x0, [sp, #0x10]
  6eec90: d63f0040     	blr	x2
  6eec94: 1400003b     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eec98: f9400fe0     	ldr	x0, [sp, #0x18]
  6eec9c: f9401802     	ldr	x2, [x0, #0x30]
  6eeca0: f9401be0     	ldr	x0, [sp, #0x30]
  6eeca4: f9400400     	ldr	x0, [x0, #0x8]
  6eeca8: aa0003e1     	mov	x1, x0
  6eecac: aa0203e0     	mov	x0, x2
  6eecb0: 94075b2a     	bl	0x8c5958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f12c>
  6eecb4: f9400be0     	ldr	x0, [sp, #0x10]
  6eecb8: f9400000     	ldr	x0, [x0]
  6eecbc: 91008000     	add	x0, x0, #0x20
  6eecc0: f9400002     	ldr	x2, [x0]
  6eecc4: d0002940     	adrp	x0, 0xc18000
  6eecc8: 911f0001     	add	x1, x0, #0x7c0
  6eeccc: f9400be0     	ldr	x0, [sp, #0x10]
  6eecd0: d63f0040     	blr	x2
  6eecd4: 1400002b     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eecd8: f9400be4     	ldr	x4, [sp, #0x10]
  6eecdc: 52800003     	mov	w3, #0x0                // =0
  6eece0: d0002940     	adrp	x0, 0xc18000
  6eece4: 911f8002     	add	x2, x0, #0x7e0
  6eece8: 52800041     	mov	w1, #0x2                // =2
  6eecec: aa0403e0     	mov	x0, x4
  6eecf0: 940146f9     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eecf4: 12001c00     	and	w0, w0, #0xff
  6eecf8: 7100001f     	cmp	w0, #0x0
  6eecfc: 54000420     	b.eq	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eed00: f9400fe0     	ldr	x0, [sp, #0x18]
  6eed04: f9401800     	ldr	x0, [x0, #0x30]
  6eed08: 9106e000     	add	x0, x0, #0x1b8
  6eed0c: 97f69986     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  6eed10: f90017e0     	str	x0, [sp, #0x28]
  6eed14: f94017e0     	ldr	x0, [sp, #0x28]
  6eed18: f100001f     	cmp	x0, #0x0
  6eed1c: 54000141     	b.ne	0x6eed44 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xcc4>
  6eed20: f9400be0     	ldr	x0, [sp, #0x10]
  6eed24: f9400000     	ldr	x0, [x0]
  6eed28: 91008000     	add	x0, x0, #0x20
  6eed2c: f9400002     	ldr	x2, [x0]
  6eed30: d0002940     	adrp	x0, 0xc18000
  6eed34: 911fa001     	add	x1, x0, #0x7e8
  6eed38: f9400be0     	ldr	x0, [sp, #0x10]
  6eed3c: d63f0040     	blr	x2
  6eed40: 14000010     	b	0x6eed80 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xd00>
  6eed44: f9400fe0     	ldr	x0, [sp, #0x18]
  6eed48: f9401802     	ldr	x2, [x0, #0x30]
  6eed4c: f94017e0     	ldr	x0, [sp, #0x28]
  6eed50: f9400400     	ldr	x0, [x0, #0x8]
  6eed54: aa0003e1     	mov	x1, x0
  6eed58: aa0203e0     	mov	x0, x2
  6eed5c: 94075b0d     	bl	0x8c5990 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f164>
  6eed60: f9400be0     	ldr	x0, [sp, #0x10]
  6eed64: f9400000     	ldr	x0, [x0]
  6eed68: 91008000     	add	x0, x0, #0x20
  6eed6c: f9400002     	ldr	x2, [x0]
  6eed70: d0002940     	adrp	x0, 0xc18000
  6eed74: 91202001     	add	x1, x0, #0x808
  6eed78: f9400be0     	ldr	x0, [sp, #0x10]
  6eed7c: d63f0040     	blr	x2
  6eed80: d503201f     	nop
  6eed84: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  6eed88: d65f03c0     	ret
  6eed8c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  6eed90: 910003fd     	mov	x29, sp
  6eed94: f9000bf3     	str	x19, [sp, #0x10]
  6eed98: f90017e0     	str	x0, [sp, #0x28]
  6eed9c: f90013e1     	str	x1, [sp, #0x20]
  6eeda0: f94013e0     	ldr	x0, [sp, #0x20]
  6eeda4: 52800002     	mov	w2, #0x0                // =0
  6eeda8: 52800041     	mov	w1, #0x2                // =2
  6eedac: 94014834     	bl	0x740e7c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x27150>
  6eedb0: b90037e0     	str	w0, [sp, #0x34]
  6eedb4: 528000a0     	mov	w0, #0x5                // =5
  6eedb8: b9003be0     	str	w0, [sp, #0x38]
  6eedbc: 9100e3e1     	add	x1, sp, #0x38
  6eedc0: 9100d3e0     	add	x0, sp, #0x34
  6eedc4: 97f51209     	bl	0x4335e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0x1ea0>
  6eedc8: b9400000     	ldr	w0, [x0]
  6eedcc: b90037e0     	str	w0, [sp, #0x34]
  6eedd0: f94013e4     	ldr	x4, [sp, #0x20]
  6eedd4: 52800003     	mov	w3, #0x0                // =0
  6eedd8: d0002940     	adrp	x0, 0xc18000
  6eeddc: 9120a002     	add	x2, x0, #0x828
  6eede0: 52800021     	mov	w1, #0x1                // =1
  6eede4: aa0403e0     	mov	x0, x4
  6eede8: 940146bb     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eedec: 12001c00     	and	w0, w0, #0xff
  6eedf0: 7100001f     	cmp	w0, #0x0
  6eedf4: 54000780     	b.eq	0x6eeee4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xe64>
  6eedf8: b94037e1     	ldr	w1, [sp, #0x34]
  6eedfc: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eee00: 9132a000     	add	x0, x0, #0xca8
  6eee04: 2a0103e1     	mov	w1, w1
  6eee08: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6eee0c: f100001f     	cmp	x0, #0x0
  6eee10: 54000260     	b.eq	0x6eee5c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xddc>
  6eee14: f94017e0     	ldr	x0, [sp, #0x28]
  6eee18: f9401800     	ldr	x0, [x0, #0x30]
  6eee1c: f9416c02     	ldr	x2, [x0, #0x2d8]
  6eee20: b94037e1     	ldr	w1, [sp, #0x34]
  6eee24: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eee28: 9132a000     	add	x0, x0, #0xca8
  6eee2c: 2a0103e1     	mov	w1, w1
  6eee30: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6eee34: b94037f3     	ldr	w19, [sp, #0x34]
  6eee38: aa0003e1     	mov	x1, x0
  6eee3c: aa0203e0     	mov	x0, x2
  6eee40: 94000663     	bl	0x6f07cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x274c>
  6eee44: aa0003e2     	mov	x2, x0
  6eee48: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eee4c: 9132a000     	add	x0, x0, #0xca8
  6eee50: 2a1303e1     	mov	w1, w19
  6eee54: f8217802     	str	x2, [x0, x1, lsl #3]
  6eee58: 1400000c     	b	0x6eee88 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xe08>
  6eee5c: f94017e0     	ldr	x0, [sp, #0x28]
  6eee60: f9401800     	ldr	x0, [x0, #0x30]
  6eee64: f9416c00     	ldr	x0, [x0, #0x2d8]
  6eee68: b94037f3     	ldr	w19, [sp, #0x34]
  6eee6c: d2800001     	mov	x1, #0x0                // =0
  6eee70: 94000657     	bl	0x6f07cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x274c>
  6eee74: aa0003e2     	mov	x2, x0
  6eee78: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eee7c: 9132a000     	add	x0, x0, #0xca8
  6eee80: 2a1303e1     	mov	w1, w19
  6eee84: f8217802     	str	x2, [x0, x1, lsl #3]
  6eee88: f94013e0     	ldr	x0, [sp, #0x20]
  6eee8c: f9400000     	ldr	x0, [x0]
  6eee90: 91008000     	add	x0, x0, #0x20
  6eee94: f9400004     	ldr	x4, [x0]
  6eee98: b94037e2     	ldr	w2, [sp, #0x34]
  6eee9c: b94037e1     	ldr	w1, [sp, #0x34]
  6eeea0: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eeea4: 9132a000     	add	x0, x0, #0xca8
  6eeea8: 2a0103e1     	mov	w1, w1
  6eeeac: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6eeeb0: f100001f     	cmp	x0, #0x0
  6eeeb4: 54000080     	b.eq	0x6eeec4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xe44>
  6eeeb8: d0002940     	adrp	x0, 0xc18000
  6eeebc: 9120c000     	add	x0, x0, #0x830
  6eeec0: 14000003     	b	0x6eeecc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xe4c>
  6eeec4: d0002940     	adrp	x0, 0xc18000
  6eeec8: 9120e000     	add	x0, x0, #0x838
  6eeecc: aa0003e3     	mov	x3, x0
  6eeed0: d0002940     	adrp	x0, 0xc18000
  6eeed4: 91210001     	add	x1, x0, #0x840
  6eeed8: f94013e0     	ldr	x0, [sp, #0x20]
  6eeedc: d63f0080     	blr	x4
  6eeee0: 140000a2     	b	0x6ef168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10e8>
  6eeee4: f94013e4     	ldr	x4, [sp, #0x20]
  6eeee8: 52800003     	mov	w3, #0x0                // =0
  6eeeec: d0002940     	adrp	x0, 0xc18000
  6eeef0: 91218002     	add	x2, x0, #0x860
  6eeef4: 52800021     	mov	w1, #0x1                // =1
  6eeef8: aa0403e0     	mov	x0, x4
  6eeefc: 94014676     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eef00: 12001c00     	and	w0, w0, #0xff
  6eef04: 7100001f     	cmp	w0, #0x0
  6eef08: 540005e0     	b.eq	0x6eefc4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xf44>
  6eef0c: b94037e1     	ldr	w1, [sp, #0x34]
  6eef10: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eef14: 9132a000     	add	x0, x0, #0xca8
  6eef18: 2a0103e1     	mov	w1, w1
  6eef1c: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6eef20: f100001f     	cmp	x0, #0x0
  6eef24: 54000181     	b.ne	0x6eef54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xed4>
  6eef28: f94013e0     	ldr	x0, [sp, #0x20]
  6eef2c: f9400000     	ldr	x0, [x0]
  6eef30: 91008000     	add	x0, x0, #0x20
  6eef34: f9400003     	ldr	x3, [x0]
  6eef38: b94037e0     	ldr	w0, [sp, #0x34]
  6eef3c: 2a0003e2     	mov	w2, w0
  6eef40: d0002940     	adrp	x0, 0xc18000
  6eef44: 9121a001     	add	x1, x0, #0x868
  6eef48: f94013e0     	ldr	x0, [sp, #0x20]
  6eef4c: d63f0060     	blr	x3
  6eef50: 14000086     	b	0x6ef168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10e8>
  6eef54: f94017e0     	ldr	x0, [sp, #0x28]
  6eef58: f9401800     	ldr	x0, [x0, #0x30]
  6eef5c: f9416c02     	ldr	x2, [x0, #0x2d8]
  6eef60: b94037e1     	ldr	w1, [sp, #0x34]
  6eef64: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eef68: 9132a000     	add	x0, x0, #0xca8
  6eef6c: 2a0103e1     	mov	w1, w1
  6eef70: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6eef74: aa0003e1     	mov	x1, x0
  6eef78: aa0203e0     	mov	x0, x2
  6eef7c: 94000683     	bl	0x6f0988 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2908>
  6eef80: f94013e0     	ldr	x0, [sp, #0x20]
  6eef84: f9400000     	ldr	x0, [x0]
  6eef88: 91008000     	add	x0, x0, #0x20
  6eef8c: f9400004     	ldr	x4, [x0]
  6eef90: b94037e2     	ldr	w2, [sp, #0x34]
  6eef94: b94037e1     	ldr	w1, [sp, #0x34]
  6eef98: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eef9c: 9132a000     	add	x0, x0, #0xca8
  6eefa0: 2a0103e1     	mov	w1, w1
  6eefa4: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6eefa8: b9401800     	ldr	w0, [x0, #0x18]
  6eefac: 2a0003e3     	mov	w3, w0
  6eefb0: d0002940     	adrp	x0, 0xc18000
  6eefb4: 91222001     	add	x1, x0, #0x888
  6eefb8: f94013e0     	ldr	x0, [sp, #0x20]
  6eefbc: d63f0080     	blr	x4
  6eefc0: 1400006a     	b	0x6ef168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10e8>
  6eefc4: f94013e4     	ldr	x4, [sp, #0x20]
  6eefc8: 52800003     	mov	w3, #0x0                // =0
  6eefcc: d0002940     	adrp	x0, 0xc18000
  6eefd0: 9122e002     	add	x2, x0, #0x8b8
  6eefd4: 52800021     	mov	w1, #0x1                // =1
  6eefd8: aa0403e0     	mov	x0, x4
  6eefdc: 9401463e     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6eefe0: 12001c00     	and	w0, w0, #0xff
  6eefe4: 7100001f     	cmp	w0, #0x0
  6eefe8: 540005e0     	b.eq	0x6ef0a4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1024>
  6eefec: b94037e1     	ldr	w1, [sp, #0x34]
  6eeff0: b001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6eeff4: 9132a000     	add	x0, x0, #0xca8
  6eeff8: 2a0103e1     	mov	w1, w1
  6eeffc: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6ef000: f100001f     	cmp	x0, #0x0
  6ef004: 54000181     	b.ne	0x6ef034 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0xfb4>
  6ef008: f94013e0     	ldr	x0, [sp, #0x20]
  6ef00c: f9400000     	ldr	x0, [x0]
  6ef010: 91008000     	add	x0, x0, #0x20
  6ef014: f9400003     	ldr	x3, [x0]
  6ef018: b94037e0     	ldr	w0, [sp, #0x34]
  6ef01c: 2a0003e2     	mov	w2, w0
  6ef020: b0002940     	adrp	x0, 0xc18000
  6ef024: 9121a001     	add	x1, x0, #0x868
  6ef028: f94013e0     	ldr	x0, [sp, #0x20]
  6ef02c: d63f0060     	blr	x3
  6ef030: 1400004e     	b	0x6ef168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10e8>
  6ef034: f94017e0     	ldr	x0, [sp, #0x28]
  6ef038: f9401800     	ldr	x0, [x0, #0x30]
  6ef03c: f9416c02     	ldr	x2, [x0, #0x2d8]
  6ef040: b94037e1     	ldr	w1, [sp, #0x34]
  6ef044: 9001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6ef048: 9132a000     	add	x0, x0, #0xca8
  6ef04c: 2a0103e1     	mov	w1, w1
  6ef050: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6ef054: aa0003e1     	mov	x1, x0
  6ef058: aa0203e0     	mov	x0, x2
  6ef05c: 94000690     	bl	0x6f0a9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2a1c>
  6ef060: f94013e0     	ldr	x0, [sp, #0x20]
  6ef064: f9400000     	ldr	x0, [x0]
  6ef068: 91008000     	add	x0, x0, #0x20
  6ef06c: f9400004     	ldr	x4, [x0]
  6ef070: b94037e2     	ldr	w2, [sp, #0x34]
  6ef074: b94037e1     	ldr	w1, [sp, #0x34]
  6ef078: 9001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6ef07c: 9132a000     	add	x0, x0, #0xca8
  6ef080: 2a0103e1     	mov	w1, w1
  6ef084: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6ef088: b9401800     	ldr	w0, [x0, #0x18]
  6ef08c: 2a0003e3     	mov	w3, w0
  6ef090: b0002940     	adrp	x0, 0xc18000
  6ef094: 91222001     	add	x1, x0, #0x888
  6ef098: f94013e0     	ldr	x0, [sp, #0x20]
  6ef09c: d63f0080     	blr	x4
  6ef0a0: 14000032     	b	0x6ef168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10e8>
  6ef0a4: f94013e4     	ldr	x4, [sp, #0x20]
  6ef0a8: 52800003     	mov	w3, #0x0                // =0
  6ef0ac: b0002940     	adrp	x0, 0xc18000
  6ef0b0: 91230002     	add	x2, x0, #0x8c0
  6ef0b4: 52800021     	mov	w1, #0x1                // =1
  6ef0b8: aa0403e0     	mov	x0, x4
  6ef0bc: 94014606     	bl	0x7408d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x26ba8>
  6ef0c0: 12001c00     	and	w0, w0, #0xff
  6ef0c4: 7100001f     	cmp	w0, #0x0
  6ef0c8: 54000500     	b.eq	0x6ef168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10e8>
  6ef0cc: b9003fff     	str	wzr, [sp, #0x3c]
  6ef0d0: b9803fe0     	ldrsw	x0, [sp, #0x3c]
  6ef0d4: f100141f     	cmp	x0, #0x5
  6ef0d8: 54000488     	b.hi	0x6ef168 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10e8>
  6ef0dc: 9001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6ef0e0: 9132a000     	add	x0, x0, #0xca8
  6ef0e4: b9803fe1     	ldrsw	x1, [sp, #0x3c]
  6ef0e8: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6ef0ec: f100001f     	cmp	x0, #0x0
  6ef0f0: 54000161     	b.ne	0x6ef11c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x109c>
  6ef0f4: f94013e0     	ldr	x0, [sp, #0x20]
  6ef0f8: f9400000     	ldr	x0, [x0]
  6ef0fc: 91008000     	add	x0, x0, #0x20
  6ef100: f9400003     	ldr	x3, [x0]
  6ef104: b9403fe2     	ldr	w2, [sp, #0x3c]
  6ef108: b0002940     	adrp	x0, 0xc18000
  6ef10c: 91232001     	add	x1, x0, #0x8c8
  6ef110: f94013e0     	ldr	x0, [sp, #0x20]
  6ef114: d63f0060     	blr	x3
  6ef118: 14000010     	b	0x6ef158 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x10d8>
  6ef11c: f94013e0     	ldr	x0, [sp, #0x20]
  6ef120: f9400000     	ldr	x0, [x0]
  6ef124: 91008000     	add	x0, x0, #0x20
  6ef128: f9400004     	ldr	x4, [x0]
  6ef12c: 9001bde0     	adrp	x0, 0x3eab000 <_ZNSt5ctypeIcE2idE+0x2f47ed8>
  6ef130: 9132a000     	add	x0, x0, #0xca8
  6ef134: b9803fe1     	ldrsw	x1, [sp, #0x3c]
  6ef138: f8617800     	ldr	x0, [x0, x1, lsl #3]
  6ef13c: b9401800     	ldr	w0, [x0, #0x18]
  6ef140: 2a0003e3     	mov	w3, w0
  6ef144: b9403fe2     	ldr	w2, [sp, #0x3c]
  6ef148: b0002940     	adrp	x0, 0xc18000
  6ef14c: 91238001     	add	x1, x0, #0x8e0
  6ef150: f94013e0     	ldr	x0, [sp, #0x20]
  6ef154: d63f0080     	blr	x4
  6ef158: b9403fe0     	ldr	w0, [sp, #0x3c]
  6ef15c: 11000400     	add	w0, w0, #0x1
  6ef160: b9003fe0     	str	w0, [sp, #0x3c]
  6ef164: 17ffffdb     	b	0x6ef0d0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1050>
  6ef168: d503201f     	nop
  6ef16c: f9400bf3     	ldr	x19, [sp, #0x10]
  6ef170: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  6ef174: d65f03c0     	ret
  6ef178: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  6ef17c: 910003fd     	mov	x29, sp
  6ef180: f9000bf3     	str	x19, [sp, #0x10]
  6ef184: f90017e0     	str	x0, [sp, #0x28]
  6ef188: f90013e1     	str	x1, [sp, #0x20]
  6ef18c: f94013e3     	ldr	x3, [sp, #0x20]
