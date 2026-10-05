  5e9868: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  5e986c: 910003fd     	mov	x29, sp
  5e9870: f9000bf3     	str	x19, [sp, #0x10]
  5e9874: f90017e0     	str	x0, [sp, #0x28]
  5e9878: b90027e1     	str	w1, [sp, #0x24]
  5e987c: 9100e3e0     	add	x0, sp, #0x38
  5e9880: 97f88aa4     	bl	0x40c310 <.text+0x10e0>
  5e9884: f94017e0     	ldr	x0, [sp, #0x28]
  5e9888: b940c800     	ldr	w0, [x0, #0xc8]
  5e988c: 7100041f     	cmp	w0, #0x1
  5e9890: 54000101     	b.ne	0x5e98b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xf0800>
  5e9894: f94017e0     	ldr	x0, [sp, #0x28]
  5e9898: b940c000     	ldr	w0, [x0, #0xc0]
  5e989c: b94027e1     	ldr	w1, [sp, #0x24]
  5e98a0: 6b00003f     	cmp	w1, w0
  5e98a4: 54000061     	b.ne	0x5e98b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xf0800>
  5e98a8: 52800013     	mov	w19, #0x0               // =0
  5e98ac: 14000005     	b	0x5e98c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xf0810>
  5e98b0: f94017e0     	ldr	x0, [sp, #0x28]
  5e98b4: b94027e1     	ldr	w1, [sp, #0x24]
  5e98b8: b900c001     	str	w1, [x0, #0xc0]
  5e98bc: 52800033     	mov	w19, #0x1               // =1
  5e98c0: 9100e3e0     	add	x0, sp, #0x38
  5e98c4: 97f88a9f     	bl	0x40c340 <.text+0x1110>
  5e98c8: 7100067f     	cmp	w19, #0x1
  5e98cc: 54000081     	b.ne	0x5e98dc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xf082c>
  5e98d0: f94017e0     	ldr	x0, [sp, #0x28]
  5e98d4: 91002000     	add	x0, x0, #0x8
  5e98d8: 94049688     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  5e98dc: f9400bf3     	ldr	x19, [sp, #0x10]
  5e98e0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  5e98e4: d65f03c0     	ret
  5e98e8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  5e98ec: 910003fd     	mov	x29, sp
  5e98f0: f9000fe0     	str	x0, [sp, #0x18]
  5e98f4: b90017e1     	str	w1, [sp, #0x14]
  5e98f8: 9100a3e0     	add	x0, sp, #0x28
  5e98fc: 97f88a85     	bl	0x40c310 <.text+0x10e0>
  5e9900: f9400fe0     	ldr	x0, [sp, #0x18]
  5e9904: b94017e1     	ldr	w1, [sp, #0x14]
  5e9908: b900c001     	str	w1, [x0, #0xc0]
  5e990c: 9100a3e0     	add	x0, sp, #0x28
  5e9910: 97f88a8c     	bl	0x40c340 <.text+0x1110>
  5e9914: d503201f     	nop
  5e9918: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  5e991c: d65f03c0     	ret
