  5e7350: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  5e7354: 910003fd     	mov	x29, sp
  5e7358: f9000fe0     	str	x0, [sp, #0x18]
  5e735c: 910083e0     	add	x0, sp, #0x20
  5e7360: 97f893ec     	bl	0x40c310 <.text+0x10e0>
  5e7364: f9400fe0     	ldr	x0, [sp, #0x18]
  5e7368: b940c000     	ldr	w0, [x0, #0xc0]
  5e736c: b9002fe0     	str	w0, [sp, #0x2c]
  5e7370: 910083e0     	add	x0, sp, #0x20
  5e7374: 97f893f3     	bl	0x40c340 <.text+0x1110>
  5e7378: b9402fe0     	ldr	w0, [sp, #0x2c]
  5e737c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  5e7380: d65f03c0     	ret
  5e7384: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  5e7388: 910003fd     	mov	x29, sp
  5e738c: f9000bf3     	str	x19, [sp, #0x10]
  5e7390: f90017e0     	str	x0, [sp, #0x28]
  5e7394: b90027e1     	str	w1, [sp, #0x24]
  5e7398: 9100e3e0     	add	x0, sp, #0x38
  5e739c: 97f893dd     	bl	0x40c310 <.text+0x10e0>
  5e73a0: f94017e0     	ldr	x0, [sp, #0x28]
  5e73a4: b940c800     	ldr	w0, [x0, #0xc8]
  5e73a8: 7100041f     	cmp	w0, #0x1
  5e73ac: 54000101     	b.ne	0x5e73cc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xee31c>
  5e73b0: f94017e0     	ldr	x0, [sp, #0x28]
  5e73b4: b940c000     	ldr	w0, [x0, #0xc0]
  5e73b8: b94027e1     	ldr	w1, [sp, #0x24]
  5e73bc: 6b00003f     	cmp	w1, w0
  5e73c0: 54000061     	b.ne	0x5e73cc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xee31c>
  5e73c4: 52800013     	mov	w19, #0x0               // =0
  5e73c8: 14000005     	b	0x5e73dc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xee32c>
  5e73cc: f94017e0     	ldr	x0, [sp, #0x28]
  5e73d0: b94027e1     	ldr	w1, [sp, #0x24]
  5e73d4: b900c001     	str	w1, [x0, #0xc0]
  5e73d8: 52800033     	mov	w19, #0x1               // =1
  5e73dc: 9100e3e0     	add	x0, sp, #0x38
  5e73e0: 97f893d8     	bl	0x40c340 <.text+0x1110>
  5e73e4: 7100067f     	cmp	w19, #0x1
  5e73e8: 54000081     	b.ne	0x5e73f8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xee348>
  5e73ec: f94017e0     	ldr	x0, [sp, #0x28]
  5e73f0: 91002000     	add	x0, x0, #0x8
  5e73f4: 94049fc1     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  5e73f8: f9400bf3     	ldr	x19, [sp, #0x10]
  5e73fc: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  5e7400: d65f03c0     	ret
