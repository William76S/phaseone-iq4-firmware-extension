  493994: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  493998: 910003fd     	mov	x29, sp
  49399c: f9000fe0     	str	x0, [sp, #0x18]
  4939a0: b90017e1     	str	w1, [sp, #0x14]
  4939a4: b9002fff     	str	wzr, [sp, #0x2c]
  4939a8: f9400fe0     	ldr	x0, [sp, #0x18]
  4939ac: b941b800     	ldr	w0, [x0, #0x1b8]
  4939b0: b9402fe1     	ldr	w1, [sp, #0x2c]
  4939b4: 6b00003f     	cmp	w1, w0
  4939b8: 5400026a     	b.ge	0x493a04 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5da58>
  4939bc: f9400fe0     	ldr	x0, [sp, #0x18]
  4939c0: f940d800     	ldr	x0, [x0, #0x1b0]
  4939c4: b9802fe1     	ldrsw	x1, [sp, #0x2c]
  4939c8: 97ffeeca     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4939cc: 39403801     	ldrb	w1, [x0, #0xe]
  4939d0: 13001c22     	sxtb	w2, w1
  4939d4: b94017e1     	ldr	w1, [sp, #0x14]
  4939d8: 13001c21     	sxtb	w1, w1
  4939dc: 2a2103e1     	mvn	w1, w1
  4939e0: 13001c21     	sxtb	w1, w1
  4939e4: 0a010041     	and	w1, w2, w1
  4939e8: 13001c21     	sxtb	w1, w1
  4939ec: 12001c21     	and	w1, w1, #0xff
  4939f0: 39003801     	strb	w1, [x0, #0xe]
  4939f4: b9402fe0     	ldr	w0, [sp, #0x2c]
  4939f8: 11000400     	add	w0, w0, #0x1
  4939fc: b9002fe0     	str	w0, [sp, #0x2c]
  493a00: 17ffffea     	b	0x4939a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5d9fc>
  493a04: d503201f     	nop
  493a08: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  493a0c: d65f03c0     	ret
  493a10: a9b37bfd     	stp	x29, x30, [sp, #-0xd0]!
  493a14: 910003fd     	mov	x29, sp
  493a18: f9000bf3     	str	x19, [sp, #0x10]
  493a1c: f90017e0     	str	x0, [sp, #0x28]
  493a20: b90027e1     	str	w1, [sp, #0x24]
  493a24: 910283e0     	add	x0, sp, #0xa0
  493a28: 52800021     	mov	w1, #0x1                // =1
  493a2c: 9409e0f9     	bl	0x70be10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1dd90>
  493a30: f94017e0     	ldr	x0, [sp, #0x28]
  493a34: 91070001     	add	x1, x0, #0x1c0
  493a38: 910263e0     	add	x0, sp, #0x98
  493a3c: 97fdf861     	bl	0x411bc0 <.text+0x6990>
  493a40: 52800020     	mov	w0, #0x1                // =1
  493a44: 39033fe0     	strb	w0, [sp, #0xcf]
  493a48: f94017e0     	ldr	x0, [sp, #0x28]
  493a4c: f940d800     	ldr	x0, [x0, #0x1b0]
  493a50: b98027e1     	ldrsw	x1, [sp, #0x24]
  493a54: 97ffeea7     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  493a58: 79402000     	ldrh	w0, [x0, #0x10]
  493a5c: 12000000     	and	w0, w0, #0x1
  493a60: 7100001f     	cmp	w0, #0x0
  493a64: 1a9f07e0     	cset	w0, ne
  493a68: 39033be0     	strb	w0, [sp, #0xce]
  493a6c: f94017e0     	ldr	x0, [sp, #0x28]
  493a70: f940d800     	ldr	x0, [x0, #0x1b0]
  493a74: b98027e1     	ldrsw	x1, [sp, #0x24]
  493a78: 97ffee9e     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  493a7c: 39403800     	ldrb	w0, [x0, #0xe]
  493a80: 121e0000     	and	w0, w0, #0x4
  493a84: 7100001f     	cmp	w0, #0x0
  493a88: 1a9f07e0     	cset	w0, ne
  493a8c: 390337e0     	strb	w0, [sp, #0xcd]
  493a90: f94017e0     	ldr	x0, [sp, #0x28]
  493a94: f940d800     	ldr	x0, [x0, #0x1b0]
  493a98: b98027e1     	ldrsw	x1, [sp, #0x24]
