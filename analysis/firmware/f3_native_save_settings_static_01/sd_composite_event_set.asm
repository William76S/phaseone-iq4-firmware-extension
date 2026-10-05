  5b66bc: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  5b66c0: 910003fd     	mov	x29, sp
  5b66c4: f9000bf3     	str	x19, [sp, #0x10]
  5b66c8: f90017e0     	str	x0, [sp, #0x28]
  5b66cc: b90027e1     	str	w1, [sp, #0x24]
  5b66d0: 9100e3e0     	add	x0, sp, #0x38
  5b66d4: 97f9570f     	bl	0x40c310 <.text+0x10e0>
  5b66d8: f94017e0     	ldr	x0, [sp, #0x28]
  5b66dc: b940c800     	ldr	w0, [x0, #0xc8]
  5b66e0: 7100041f     	cmp	w0, #0x1
  5b66e4: 54000101     	b.ne	0x5b6704 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xbd654>
  5b66e8: f94017e0     	ldr	x0, [sp, #0x28]
  5b66ec: b940c000     	ldr	w0, [x0, #0xc0]
  5b66f0: b94027e1     	ldr	w1, [sp, #0x24]
  5b66f4: 6b00003f     	cmp	w1, w0
  5b66f8: 54000061     	b.ne	0x5b6704 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xbd654>
  5b66fc: 52800013     	mov	w19, #0x0               // =0
  5b6700: 14000005     	b	0x5b6714 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xbd664>
  5b6704: f94017e0     	ldr	x0, [sp, #0x28]
  5b6708: b94027e1     	ldr	w1, [sp, #0x24]
  5b670c: b900c001     	str	w1, [x0, #0xc0]
  5b6710: 52800033     	mov	w19, #0x1               // =1
  5b6714: 9100e3e0     	add	x0, sp, #0x38
  5b6718: 97f9570a     	bl	0x40c340 <.text+0x1110>
  5b671c: 7100067f     	cmp	w19, #0x1
  5b6720: 54000081     	b.ne	0x5b6730 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xbd680>
  5b6724: f94017e0     	ldr	x0, [sp, #0x28]
  5b6728: 91002000     	add	x0, x0, #0x8
  5b672c: 940562f3     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  5b6730: f9400bf3     	ldr	x19, [sp, #0x10]
  5b6734: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  5b6738: d65f03c0     	ret
  5b673c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  5b6740: 910003fd     	mov	x29, sp
  5b6744: f9000fe0     	str	x0, [sp, #0x18]
  5b6748: b90017e1     	str	w1, [sp, #0x14]
  5b674c: 9100a3e0     	add	x0, sp, #0x28
  5b6750: 97f956f0     	bl	0x40c310 <.text+0x10e0>
  5b6754: f9400fe0     	ldr	x0, [sp, #0x18]
  5b6758: b94017e1     	ldr	w1, [sp, #0x14]
  5b675c: b900c001     	str	w1, [x0, #0xc0]
  5b6760: 9100a3e0     	add	x0, sp, #0x28
  5b6764: 97f956f7     	bl	0x40c340 <.text+0x1110>
  5b6768: d503201f     	nop
  5b676c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  5b6770: d65f03c0     	ret
