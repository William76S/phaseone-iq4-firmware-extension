  5e8c20: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  5e8c24: 910003fd     	mov	x29, sp
  5e8c28: f9000fe0     	str	x0, [sp, #0x18]
  5e8c2c: 910083e0     	add	x0, sp, #0x20
  5e8c30: 97f88db8     	bl	0x40c310 <.text+0x10e0>
  5e8c34: f9400fe0     	ldr	x0, [sp, #0x18]
  5e8c38: b940c000     	ldr	w0, [x0, #0xc0]
  5e8c3c: b9002fe0     	str	w0, [sp, #0x2c]
  5e8c40: 910083e0     	add	x0, sp, #0x20
  5e8c44: 97f88dbf     	bl	0x40c340 <.text+0x1110>
  5e8c48: b9402fe0     	ldr	w0, [sp, #0x2c]
  5e8c4c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  5e8c50: d65f03c0     	ret
  5e8c54: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  5e8c58: 910003fd     	mov	x29, sp
  5e8c5c: f9000bf3     	str	x19, [sp, #0x10]
  5e8c60: f90017e0     	str	x0, [sp, #0x28]
  5e8c64: b90027e1     	str	w1, [sp, #0x24]
  5e8c68: 9100e3e0     	add	x0, sp, #0x38
  5e8c6c: 97f88da9     	bl	0x40c310 <.text+0x10e0>
  5e8c70: f94017e0     	ldr	x0, [sp, #0x28]
  5e8c74: b940c800     	ldr	w0, [x0, #0xc8]
  5e8c78: 7100041f     	cmp	w0, #0x1
  5e8c7c: 54000101     	b.ne	0x5e8c9c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xefbec>
  5e8c80: f94017e0     	ldr	x0, [sp, #0x28]
  5e8c84: b940c000     	ldr	w0, [x0, #0xc0]
  5e8c88: b94027e1     	ldr	w1, [sp, #0x24]
  5e8c8c: 6b00003f     	cmp	w1, w0
  5e8c90: 54000061     	b.ne	0x5e8c9c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xefbec>
  5e8c94: 52800013     	mov	w19, #0x0               // =0
  5e8c98: 14000005     	b	0x5e8cac <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xefbfc>
  5e8c9c: f94017e0     	ldr	x0, [sp, #0x28]
  5e8ca0: b94027e1     	ldr	w1, [sp, #0x24]
  5e8ca4: b900c001     	str	w1, [x0, #0xc0]
  5e8ca8: 52800033     	mov	w19, #0x1               // =1
  5e8cac: 9100e3e0     	add	x0, sp, #0x38
  5e8cb0: 97f88da4     	bl	0x40c340 <.text+0x1110>
  5e8cb4: 7100067f     	cmp	w19, #0x1
  5e8cb8: 54000081     	b.ne	0x5e8cc8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xefc18>
  5e8cbc: f94017e0     	ldr	x0, [sp, #0x28]
  5e8cc0: 91002000     	add	x0, x0, #0x8
  5e8cc4: 9404998d     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  5e8cc8: f9400bf3     	ldr	x19, [sp, #0x10]
  5e8ccc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  5e8cd0: d65f03c0     	ret
