  6f0a9c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  6f0aa0: 910003fd     	mov	x29, sp
  6f0aa4: f9000bf3     	str	x19, [sp, #0x10]
  6f0aa8: f90017e0     	str	x0, [sp, #0x28]
  6f0aac: f90013e1     	str	x1, [sp, #0x20]
  6f0ab0: 9100e3e0     	add	x0, sp, #0x38
  6f0ab4: 94008737     	bl	0x712790 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24710>
  6f0ab8: f94013e0     	ldr	x0, [sp, #0x20]
  6f0abc: f100001f     	cmp	x0, #0x0
  6f0ac0: 54000141     	b.ne	0x6f0ae8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2a68>
  6f0ac4: 52801003     	mov	w3, #0x80               // =128
  6f0ac8: 90002940     	adrp	x0, 0xc18000
  6f0acc: 9135c002     	add	x2, x0, #0xd70
  6f0ad0: 90002940     	adrp	x0, 0xc18000
  6f0ad4: 91372001     	add	x1, x0, #0xdc8
  6f0ad8: 90002940     	adrp	x0, 0xc18000
  6f0adc: 91348000     	add	x0, x0, #0xd20
  6f0ae0: 97f466a8     	bl	0x40a580 <printf@plt>
  6f0ae4: 9401ef09     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  6f0ae8: f94013e0     	ldr	x0, [sp, #0x20]
  6f0aec: b9401800     	ldr	w0, [x0, #0x18]
  6f0af0: 7100041f     	cmp	w0, #0x1
  6f0af4: 540000e9     	b.ls	0x6f0b10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2a90>
  6f0af8: f94013e0     	ldr	x0, [sp, #0x20]
  6f0afc: aa0003e1     	mov	x1, x0
  6f0b00: f94017e0     	ldr	x0, [sp, #0x28]
  6f0b04: 97ffffa1     	bl	0x6f0988 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2908>
  6f0b08: 52800013     	mov	w19, #0x0               // =0
  6f0b0c: 14000018     	b	0x6f0b6c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2aec>
  6f0b10: f94013e0     	ldr	x0, [sp, #0x20]
  6f0b14: b900181f     	str	wzr, [x0, #0x18]
  6f0b18: f94013e0     	ldr	x0, [sp, #0x20]
  6f0b1c: aa0003e2     	mov	x2, x0
  6f0b20: f94013e0     	ldr	x0, [sp, #0x20]
  6f0b24: f9400000     	ldr	x0, [x0]
  6f0b28: 91004000     	add	x0, x0, #0x10
  6f0b2c: f9400001     	ldr	x1, [x0]
  6f0b30: aa0203e0     	mov	x0, x2
  6f0b34: d63f0020     	blr	x1
  6f0b38: f94017e0     	ldr	x0, [sp, #0x28]
  6f0b3c: 9100c002     	add	x2, x0, #0x30
  6f0b40: f94013e0     	ldr	x0, [sp, #0x20]
  6f0b44: f100001f     	cmp	x0, #0x0
  6f0b48: 54000080     	b.eq	0x6f0b58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2ad8>
  6f0b4c: f94013e0     	ldr	x0, [sp, #0x20]
  6f0b50: 91012000     	add	x0, x0, #0x48
  6f0b54: 14000002     	b	0x6f0b5c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2adc>
  6f0b58: d2800000     	mov	x0, #0x0                // =0
  6f0b5c: aa0003e1     	mov	x1, x0
  6f0b60: aa0203e0     	mov	x0, x2
  6f0b64: 94000079     	bl	0x6f0d48 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2cc8>
  6f0b68: 52800033     	mov	w19, #0x1               // =1
  6f0b6c: 9100e3e0     	add	x0, sp, #0x38
  6f0b70: 94008715     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  6f0b74: 7100067f     	cmp	w19, #0x1
  6f0b78: 14000006     	b	0x6f0b90 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2b10>
  6f0b7c: aa0003f3     	mov	x19, x0
  6f0b80: 9100e3e0     	add	x0, sp, #0x38
  6f0b84: 94008710     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  6f0b88: aa1303e0     	mov	x0, x19
  6f0b8c: 97f466f1     	bl	0x40a750 <_Unwind_Resume@plt>
  6f0b90: f9400bf3     	ldr	x19, [sp, #0x10]
  6f0b94: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  6f0b98: d65f03c0     	ret
