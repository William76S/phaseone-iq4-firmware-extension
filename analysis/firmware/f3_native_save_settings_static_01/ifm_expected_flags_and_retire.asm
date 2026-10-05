  496668: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  49666c: 910003fd     	mov	x29, sp
  496670: f9000bf3     	str	x19, [sp, #0x10]
  496674: f90017e0     	str	x0, [sp, #0x28]
  496678: b90027e1     	str	w1, [sp, #0x24]
  49667c: 39008fe2     	strb	w2, [sp, #0x23]
  496680: b94027e0     	ldr	w0, [sp, #0x24]
  496684: 7100001f     	cmp	w0, #0x0
  496688: 540002eb     	b.lt	0x4966e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60738>
  49668c: f94017e0     	ldr	x0, [sp, #0x28]
  496690: f947d400     	ldr	x0, [x0, #0xfa8]
  496694: b941b800     	ldr	w0, [x0, #0x1b8]
  496698: b94027e1     	ldr	w1, [sp, #0x24]
  49669c: 6b00003f     	cmp	w1, w0
  4966a0: 5400022a     	b.ge	0x4966e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60738>
  4966a4: f94017e0     	ldr	x0, [sp, #0x28]
  4966a8: f947d400     	ldr	x0, [x0, #0xfa8]
  4966ac: 91070001     	add	x1, x0, #0x1c0
  4966b0: 9100e3e0     	add	x0, sp, #0x38
  4966b4: 97fded43     	bl	0x411bc0 <.text+0x6990>
  4966b8: 39408ff3     	ldrb	w19, [sp, #0x23]
  4966bc: f94017e0     	ldr	x0, [sp, #0x28]
  4966c0: f947d400     	ldr	x0, [x0, #0xfa8]
  4966c4: f940d800     	ldr	x0, [x0, #0x1b0]
  4966c8: b98027e1     	ldrsw	x1, [sp, #0x24]
  4966cc: 97ffe389     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4966d0: 2a1303e1     	mov	w1, w19
  4966d4: 39003801     	strb	w1, [x0, #0xe]
  4966d8: 9100e3e0     	add	x0, sp, #0x38
  4966dc: 97fded46     	bl	0x411bf4 <.text+0x69c4>
  4966e0: 14000002     	b	0x4966e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6073c>
  4966e4: d503201f     	nop
  4966e8: f9400bf3     	ldr	x19, [sp, #0x10]
  4966ec: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4966f0: d65f03c0     	ret
  4966f4: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  4966f8: 910003fd     	mov	x29, sp
  4966fc: f9000bf3     	str	x19, [sp, #0x10]
  496700: f90017e0     	str	x0, [sp, #0x28]
  496704: b90027e1     	str	w1, [sp, #0x24]
  496708: b94027e0     	ldr	w0, [sp, #0x24]
  49670c: 7100001f     	cmp	w0, #0x0
  496710: 5400032b     	b.lt	0x496774 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x607c8>
  496714: f94017e0     	ldr	x0, [sp, #0x28]
  496718: f947d400     	ldr	x0, [x0, #0xfa8]
  49671c: b941b800     	ldr	w0, [x0, #0x1b8]
  496720: b94027e1     	ldr	w1, [sp, #0x24]
  496724: 6b00003f     	cmp	w1, w0
  496728: 5400026a     	b.ge	0x496774 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x607c8>
  49672c: f94017e0     	ldr	x0, [sp, #0x28]
  496730: f947d400     	ldr	x0, [x0, #0xfa8]
  496734: 91070001     	add	x1, x0, #0x1c0
  496738: 9100e3e0     	add	x0, sp, #0x38
  49673c: 97fded21     	bl	0x411bc0 <.text+0x6990>
  496740: f94017e0     	ldr	x0, [sp, #0x28]
  496744: f947d400     	ldr	x0, [x0, #0xfa8]
  496748: 52800402     	mov	w2, #0x20               // =32
  49674c: b94027e1     	ldr	w1, [sp, #0x24]
  496750: 97ffc432     	bl	0x487818 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5186c>
  496754: 9100e3e0     	add	x0, sp, #0x38
  496758: 97fded27     	bl	0x411bf4 <.text+0x69c4>
  49675c: 14000007     	b	0x496778 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x607cc>
  496760: aa0003f3     	mov	x19, x0
  496764: 9100e3e0     	add	x0, sp, #0x38
  496768: 97fded23     	bl	0x411bf4 <.text+0x69c4>
  49676c: aa1303e0     	mov	x0, x19
  496770: 97fdcff8     	bl	0x40a750 <_Unwind_Resume@plt>
  496774: d503201f     	nop
  496778: f9400bf3     	ldr	x19, [sp, #0x10]
  49677c: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  496780: d65f03c0     	ret
