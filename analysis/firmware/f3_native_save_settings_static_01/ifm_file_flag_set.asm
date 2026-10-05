  49752c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  497530: 910003fd     	mov	x29, sp
  497534: f9000bf3     	str	x19, [sp, #0x10]
  497538: f90017e0     	str	x0, [sp, #0x28]
  49753c: b90027e1     	str	w1, [sp, #0x24]
  497540: b90023e2     	str	w2, [sp, #0x20]
  497544: b94027e0     	ldr	w0, [sp, #0x24]
  497548: 7100001f     	cmp	w0, #0x0
  49754c: 5400036b     	b.lt	0x4975b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6160c>
  497550: f94017e0     	ldr	x0, [sp, #0x28]
  497554: f947d400     	ldr	x0, [x0, #0xfa8]
  497558: b941b800     	ldr	w0, [x0, #0x1b8]
  49755c: b94027e1     	ldr	w1, [sp, #0x24]
  497560: 6b00003f     	cmp	w1, w0
  497564: 540002aa     	b.ge	0x4975b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6160c>
  497568: f94017e0     	ldr	x0, [sp, #0x28]
  49756c: f947d400     	ldr	x0, [x0, #0xfa8]
  497570: 91070001     	add	x1, x0, #0x1c0
  497574: 9100e3e0     	add	x0, sp, #0x38
  497578: 97fde992     	bl	0x411bc0 <.text+0x6990>
  49757c: f94017e0     	ldr	x0, [sp, #0x28]
  497580: f947d400     	ldr	x0, [x0, #0xfa8]
  497584: b94023e1     	ldr	w1, [sp, #0x20]
  497588: 12003c21     	and	w1, w1, #0xffff
  49758c: 2a0103e2     	mov	w2, w1
  497590: b94027e1     	ldr	w1, [sp, #0x24]
  497594: 97ffc0a1     	bl	0x487818 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5186c>
  497598: 9100e3e0     	add	x0, sp, #0x38
  49759c: 97fde996     	bl	0x411bf4 <.text+0x69c4>
  4975a0: 14000007     	b	0x4975bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x61610>
  4975a4: aa0003f3     	mov	x19, x0
  4975a8: 9100e3e0     	add	x0, sp, #0x38
  4975ac: 97fde992     	bl	0x411bf4 <.text+0x69c4>
  4975b0: aa1303e0     	mov	x0, x19
  4975b4: 97fdcc67     	bl	0x40a750 <_Unwind_Resume@plt>
  4975b8: d503201f     	nop
  4975bc: f9400bf3     	ldr	x19, [sp, #0x10]
  4975c0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4975c4: d65f03c0     	ret
