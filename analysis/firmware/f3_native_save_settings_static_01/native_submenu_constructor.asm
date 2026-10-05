  4e5744: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  4e5748: 910003fd     	mov	x29, sp
  4e574c: f9000bf3     	str	x19, [sp, #0x10]
  4e5750: f9001fe0     	str	x0, [sp, #0x38]
  4e5754: b90037e1     	str	w1, [sp, #0x34]
  4e5758: f90017e2     	str	x2, [sp, #0x28]
  4e575c: f90013e3     	str	x3, [sp, #0x20]
  4e5760: f9401fe0     	ldr	x0, [sp, #0x38]
  4e5764: 97ffffed     	bl	0x4e5718 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf76c>
  4e5768: d0003540     	adrp	x0, 0xb8f000
  4e576c: 9126e001     	add	x1, x0, #0x9b8
  4e5770: f9401fe0     	ldr	x0, [sp, #0x38]
  4e5774: f9000001     	str	x1, [x0]
  4e5778: f9401fe0     	ldr	x0, [sp, #0x38]
  4e577c: b94037e1     	ldr	w1, [sp, #0x34]
  4e5780: b9001401     	str	w1, [x0, #0x14]
  4e5784: f9401fe0     	ldr	x0, [sp, #0x38]
  4e5788: 91006000     	add	x0, x0, #0x18
  4e578c: 940002a4     	bl	0x4e621c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0270>
  4e5790: f9401fe0     	ldr	x0, [sp, #0x38]
  4e5794: 52800021     	mov	w1, #0x1                // =1
  4e5798: 39010001     	strb	w1, [x0, #0x40]
  4e579c: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57a0: 52800021     	mov	w1, #0x1                // =1
  4e57a4: 39010401     	strb	w1, [x0, #0x41]
  4e57a8: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57ac: 3901081f     	strb	wzr, [x0, #0x42]
  4e57b0: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57b4: 39010c1f     	strb	wzr, [x0, #0x43]
  4e57b8: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57bc: 52800021     	mov	w1, #0x1                // =1
  4e57c0: 39011001     	strb	w1, [x0, #0x44]
  4e57c4: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57c8: f94017e1     	ldr	x1, [sp, #0x28]
  4e57cc: f9002401     	str	x1, [x0, #0x48]
  4e57d0: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57d4: f94013e1     	ldr	x1, [sp, #0x20]
  4e57d8: f9002801     	str	x1, [x0, #0x50]
  4e57dc: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57e0: f9002c1f     	str	xzr, [x0, #0x58]
  4e57e4: f9401fe0     	ldr	x0, [sp, #0x38]
  4e57e8: 91018002     	add	x2, x0, #0x60
  4e57ec: d0003540     	adrp	x0, 0xb8f000
  4e57f0: 9124e001     	add	x1, x0, #0x938
  4e57f4: aa0203e0     	mov	x0, x2
  4e57f8: 9408a64d     	bl	0x70f12c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x210ac>
  4e57fc: 1400000b     	b	0x4e5828 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf87c>
  4e5800: aa0003f3     	mov	x19, x0
  4e5804: f9401fe0     	ldr	x0, [sp, #0x38]
  4e5808: 91006000     	add	x0, x0, #0x18
  4e580c: 94000291     	bl	0x4e6250 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb02a4>
  4e5810: 14000002     	b	0x4e5818 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf86c>
  4e5814: aa0003f3     	mov	x19, x0
  4e5818: f9401fe0     	ldr	x0, [sp, #0x38]
  4e581c: 97ffff05     	bl	0x4e5430 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf484>
  4e5820: aa1303e0     	mov	x0, x19
  4e5824: 97fc93cb     	bl	0x40a750 <_Unwind_Resume@plt>
  4e5828: f9400bf3     	ldr	x19, [sp, #0x10]
  4e582c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4e5830: d65f03c0     	ret
  4e5834: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4e5838: 910003fd     	mov	x29, sp
  4e583c: f9000fe0     	str	x0, [sp, #0x18]
  4e5840: d0003540     	adrp	x0, 0xb8f000
  4e5844: 9126e001     	add	x1, x0, #0x9b8
  4e5848: f9400fe0     	ldr	x0, [sp, #0x18]
  4e584c: f9000001     	str	x1, [x0]
  4e5850: f9400fe0     	ldr	x0, [sp, #0x18]
  4e5854: 91018000     	add	x0, x0, #0x60
  4e5858: 9408a66c     	bl	0x70f208 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21188>
  4e585c: f9400fe0     	ldr	x0, [sp, #0x18]
  4e5860: 91006000     	add	x0, x0, #0x18
  4e5864: 9400027b     	bl	0x4e6250 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb02a4>
  4e5868: f9400fe0     	ldr	x0, [sp, #0x18]
  4e586c: 97fffef1     	bl	0x4e5430 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf484>
  4e5870: d503201f     	nop
  4e5874: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4e5878: d65f03c0     	ret
  4e587c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4e5880: 910003fd     	mov	x29, sp
  4e5884: f9000fe0     	str	x0, [sp, #0x18]
  4e5888: f9400fe0     	ldr	x0, [sp, #0x18]
  4e588c: 97ffffea     	bl	0x4e5834 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf888>
  4e5890: d2802301     	mov	x1, #0x118              // =280
  4e5894: f9400fe0     	ldr	x0, [sp, #0x18]
  4e5898: 97fc9152     	bl	0x409de0 <_ZdlPvm@plt>
  4e589c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4e58a0: d65f03c0     	ret
