  6f0988: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  6f098c: 910003fd     	mov	x29, sp
  6f0990: f9000bf3     	str	x19, [sp, #0x10]
  6f0994: f90017e0     	str	x0, [sp, #0x28]
  6f0998: f90013e1     	str	x1, [sp, #0x20]
  6f099c: 9100e3e0     	add	x0, sp, #0x38
  6f09a0: 9400877c     	bl	0x712790 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24710>
  6f09a4: f94013e0     	ldr	x0, [sp, #0x20]
  6f09a8: f100001f     	cmp	x0, #0x0
  6f09ac: 54000141     	b.ne	0x6f09d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2954>
  6f09b0: 52800d23     	mov	w3, #0x69               // =105
  6f09b4: 90002940     	adrp	x0, 0xc18000
  6f09b8: 9135c002     	add	x2, x0, #0xd70
  6f09bc: 90002940     	adrp	x0, 0xc18000
  6f09c0: 91372001     	add	x1, x0, #0xdc8
  6f09c4: 90002940     	adrp	x0, 0xc18000
  6f09c8: 91348000     	add	x0, x0, #0xd20
  6f09cc: 97f466ed     	bl	0x40a580 <printf@plt>
  6f09d0: 9401ef4e     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  6f09d4: f94013e0     	ldr	x0, [sp, #0x20]
  6f09d8: b9401800     	ldr	w0, [x0, #0x18]
  6f09dc: 7100001f     	cmp	w0, #0x0
  6f09e0: 54000201     	b.ne	0x6f0a20 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29a0>
  6f09e4: f94017e0     	ldr	x0, [sp, #0x28]
  6f09e8: f9404001     	ldr	x1, [x0, #0x80]
  6f09ec: f94013e2     	ldr	x2, [sp, #0x20]
  6f09f0: f94013e0     	ldr	x0, [sp, #0x20]
  6f09f4: b9401800     	ldr	w0, [x0, #0x18]
  6f09f8: 2a0003e6     	mov	w6, w0
  6f09fc: aa0203e5     	mov	x5, x2
  6f0a00: aa0103e4     	mov	x4, x1
  6f0a04: 90002940     	adrp	x0, 0xc18000
  6f0a08: 91374003     	add	x3, x0, #0xdd0
  6f0a0c: 52800da2     	mov	w2, #0x6d               // =109
  6f0a10: 90002940     	adrp	x0, 0xc18000
  6f0a14: 9135c001     	add	x1, x0, #0xd70
  6f0a18: 52800080     	mov	w0, #0x4                // =4
  6f0a1c: 940156cc     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  6f0a20: f94013e0     	ldr	x0, [sp, #0x20]
  6f0a24: b9401801     	ldr	w1, [x0, #0x18]
  6f0a28: 51000421     	sub	w1, w1, #0x1
  6f0a2c: b9001801     	str	w1, [x0, #0x18]
  6f0a30: f94013e0     	ldr	x0, [sp, #0x20]
  6f0a34: b9401800     	ldr	w0, [x0, #0x18]
  6f0a38: 7100001f     	cmp	w0, #0x0
  6f0a3c: 540001a1     	b.ne	0x6f0a70 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29f0>
  6f0a40: f94017e0     	ldr	x0, [sp, #0x28]
  6f0a44: 91002002     	add	x2, x0, #0x8
  6f0a48: f94013e0     	ldr	x0, [sp, #0x20]
  6f0a4c: f100001f     	cmp	x0, #0x0
  6f0a50: 54000080     	b.eq	0x6f0a60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29e0>
  6f0a54: f94013e0     	ldr	x0, [sp, #0x20]
  6f0a58: 91012000     	add	x0, x0, #0x48
  6f0a5c: 14000002     	b	0x6f0a64 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29e4>
  6f0a60: d2800000     	mov	x0, #0x0                // =0
  6f0a64: aa0003e1     	mov	x1, x0
  6f0a68: aa0203e0     	mov	x0, x2
  6f0a6c: 940000b7     	bl	0x6f0d48 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2cc8>
  6f0a70: 9100e3e0     	add	x0, sp, #0x38
  6f0a74: 94008754     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  6f0a78: 14000006     	b	0x6f0a90 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2a10>
  6f0a7c: aa0003f3     	mov	x19, x0
  6f0a80: 9100e3e0     	add	x0, sp, #0x38
  6f0a84: 94008750     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  6f0a88: aa1303e0     	mov	x0, x19
  6f0a8c: 97f46731     	bl	0x40a750 <_Unwind_Resume@plt>
  6f0a90: f9400bf3     	ldr	x19, [sp, #0x10]
  6f0a94: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  6f0a98: d65f03c0     	ret
