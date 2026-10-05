  8e0928: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  8e092c: 910003fd     	mov	x29, sp
  8e0930: f9000bf3     	str	x19, [sp, #0x10]
  8e0934: f90027e0     	str	x0, [sp, #0x48]
  8e0938: f90023e1     	str	x1, [sp, #0x40]
  8e093c: f9001fe2     	str	x2, [sp, #0x38]
  8e0940: f9001be3     	str	x3, [sp, #0x30]
  8e0944: f90017e4     	str	x4, [sp, #0x28]
  8e0948: f90013e5     	str	x5, [sp, #0x20]
  8e094c: f94027e5     	ldr	x5, [sp, #0x48]
  8e0950: d2800004     	mov	x4, #0x0                // =0
  8e0954: 52820003     	mov	w3, #0x1000             // =4096
  8e0958: 52800022     	mov	w2, #0x1                // =1
  8e095c: 900026e0     	adrp	x0, 0xdbc000
  8e0960: 91214001     	add	x1, x0, #0x850
  8e0964: aa0503e0     	mov	x0, x5
  8e0968: 97f8ca1c     	bl	0x7131d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x25158>
  8e096c: 900026e0     	adrp	x0, 0xdbc000
  8e0970: 91390001     	add	x1, x0, #0xe40
  8e0974: f94027e0     	ldr	x0, [sp, #0x48]
  8e0978: f9000001     	str	x1, [x0]
  8e097c: f94027e0     	ldr	x0, [sp, #0x48]
  8e0980: b901a81f     	str	wzr, [x0, #0x1a8]
  8e0984: f94027e0     	ldr	x0, [sp, #0x48]
  8e0988: f94013e1     	ldr	x1, [sp, #0x20]
  8e098c: f900d801     	str	x1, [x0, #0x1b0]
  8e0990: f94027e0     	ldr	x0, [sp, #0x48]
  8e0994: 52800201     	mov	w1, #0x10               // =16
  8e0998: b901b801     	str	w1, [x0, #0x1b8]
  8e099c: f94027e0     	ldr	x0, [sp, #0x48]
  8e09a0: 12800001     	mov	w1, #-0x1               // =-1
  8e09a4: b901bc01     	str	w1, [x0, #0x1bc]
  8e09a8: f94027e0     	ldr	x0, [sp, #0x48]
  8e09ac: f94023e1     	ldr	x1, [sp, #0x40]
  8e09b0: f900e401     	str	x1, [x0, #0x1c8]
  8e09b4: f94027e0     	ldr	x0, [sp, #0x48]
  8e09b8: f9401fe1     	ldr	x1, [sp, #0x38]
  8e09bc: f900e801     	str	x1, [x0, #0x1d0]
  8e09c0: f94027e0     	ldr	x0, [sp, #0x48]
  8e09c4: f9401be1     	ldr	x1, [sp, #0x30]
  8e09c8: f900ec01     	str	x1, [x0, #0x1d8]
  8e09cc: f94027e0     	ldr	x0, [sp, #0x48]
  8e09d0: f94017e1     	ldr	x1, [sp, #0x28]
  8e09d4: f900f001     	str	x1, [x0, #0x1e0]
  8e09d8: f94027e1     	ldr	x1, [sp, #0x48]
  8e09dc: d2805f00     	mov	x0, #0x2f8              // =760
  8e09e0: f2a0c800     	movk	x0, #0x640, lsl #16
  8e09e4: 8b000022     	add	x2, x1, x0
  8e09e8: 900026e0     	adrp	x0, 0xdbc000
  8e09ec: 9121a001     	add	x1, x0, #0x868
  8e09f0: aa0203e0     	mov	x0, x2
  8e09f4: 97f8d383     	bl	0x715800 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x27780>
  8e09f8: f94027e1     	ldr	x1, [sp, #0x48]
  8e09fc: d2a0c800     	mov	x0, #0x6400000          // =104857600
  8e0a00: 8b000020     	add	x0, x1, x0
  8e0a04: 390fa01f     	strb	wzr, [x0, #0x3e8]
  8e0a08: 9402b150     	bl	0x98cf48 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x15ea8>
  8e0a0c: aa0003e1     	mov	x1, x0
  8e0a10: f94027e0     	ldr	x0, [sp, #0x48]
  8e0a14: f900f801     	str	x1, [x0, #0x1f0]
  8e0a18: f94027e0     	ldr	x0, [sp, #0x48]
  8e0a1c: f940ec00     	ldr	x0, [x0, #0x1d8]
  8e0a20: aa0003e2     	mov	x2, x0
  8e0a24: 900026e0     	adrp	x0, 0xdbc000
  8e0a28: 9121e001     	add	x1, x0, #0x878
  8e0a2c: aa0203e0     	mov	x0, x2
  8e0a30: 97ffa66f     	bl	0x8ca3ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x23bc0>
  8e0a34: 2a0003e1     	mov	w1, w0
  8e0a38: f94027e0     	ldr	x0, [sp, #0x48]
  8e0a3c: b901e801     	str	w1, [x0, #0x1e8]
  8e0a40: f94027e0     	ldr	x0, [sp, #0x48]
  8e0a44: f940f000     	ldr	x0, [x0, #0x1e0]
  8e0a48: aa0003e2     	mov	x2, x0
  8e0a4c: 900026e0     	adrp	x0, 0xdbc000
  8e0a50: 9121e001     	add	x1, x0, #0x878
  8e0a54: aa0203e0     	mov	x0, x2
  8e0a58: 97ffa665     	bl	0x8ca3ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x23bc0>
  8e0a5c: 2a0003e1     	mov	w1, w0
  8e0a60: f94027e0     	ldr	x0, [sp, #0x48]
  8e0a64: b901ec01     	str	w1, [x0, #0x1ec]
  8e0a68: 1400000d     	b	0x8e0a9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3a270>
  8e0a6c: aa0003f3     	mov	x19, x0
  8e0a70: f94027e1     	ldr	x1, [sp, #0x48]
  8e0a74: d2805f00     	mov	x0, #0x2f8              // =760
  8e0a78: f2a0c800     	movk	x0, #0x640, lsl #16
  8e0a7c: 8b000020     	add	x0, x1, x0
  8e0a80: 97f8d391     	bl	0x7158c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x27844>
  8e0a84: 14000002     	b	0x8e0a8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3a260>
  8e0a88: aa0003f3     	mov	x19, x0
  8e0a8c: f94027e0     	ldr	x0, [sp, #0x48]
  8e0a90: 97f8ca9c     	bl	0x713500 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x25480>
  8e0a94: aa1303e0     	mov	x0, x19
  8e0a98: 97eca72e     	bl	0x40a750 <_Unwind_Resume@plt>
  8e0a9c: f9400bf3     	ldr	x19, [sp, #0x10]
  8e0aa0: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  8e0aa4: d65f03c0     	ret
