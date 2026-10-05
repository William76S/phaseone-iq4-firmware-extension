  8c3990: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8c3994: 910003fd     	mov	x29, sp
  8c3998: f9000bf3     	str	x19, [sp, #0x10]
  8c399c: f90017e0     	str	x0, [sp, #0x28]
  8c39a0: f90013e1     	str	x1, [sp, #0x20]
  8c39a4: 9100e3e0     	add	x0, sp, #0x38
  8c39a8: 97f93b7a     	bl	0x712790 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24710>
  8c39ac: f94013e0     	ldr	x0, [sp, #0x20]
  8c39b0: f100001f     	cmp	x0, #0x0
  8c39b4: 54000141     	b.ne	0x8c39dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d1b0>
  8c39b8: 52801003     	mov	w3, #0x80               // =128
  8c39bc: b0002780     	adrp	x0, 0xdb4000
  8c39c0: 91026002     	add	x2, x0, #0x98
  8c39c4: b0002780     	adrp	x0, 0xdb4000
  8c39c8: 9103c001     	add	x1, x0, #0xf0
  8c39cc: 90002780     	adrp	x0, 0xdb3000
  8c39d0: 913b8000     	add	x0, x0, #0xee0
  8c39d4: 97ed1aeb     	bl	0x40a580 <printf@plt>
  8c39d8: 97faa34c     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c39dc: f94013e0     	ldr	x0, [sp, #0x20]
  8c39e0: b9401800     	ldr	w0, [x0, #0x18]
  8c39e4: 7100041f     	cmp	w0, #0x1
  8c39e8: 540000e9     	b.ls	0x8c3a04 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d1d8>
  8c39ec: f94013e0     	ldr	x0, [sp, #0x20]
  8c39f0: aa0003e1     	mov	x1, x0
  8c39f4: f94017e0     	ldr	x0, [sp, #0x28]
  8c39f8: 97ffffa1     	bl	0x8c387c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d050>
  8c39fc: 52800013     	mov	w19, #0x0               // =0
  8c3a00: 14000018     	b	0x8c3a60 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d234>
  8c3a04: f94013e0     	ldr	x0, [sp, #0x20]
  8c3a08: b900181f     	str	wzr, [x0, #0x18]
  8c3a0c: f94013e0     	ldr	x0, [sp, #0x20]
  8c3a10: aa0003e2     	mov	x2, x0
  8c3a14: f94013e0     	ldr	x0, [sp, #0x20]
  8c3a18: f9400000     	ldr	x0, [x0]
  8c3a1c: 91004000     	add	x0, x0, #0x10
  8c3a20: f9400001     	ldr	x1, [x0]
  8c3a24: aa0203e0     	mov	x0, x2
  8c3a28: d63f0020     	blr	x1
  8c3a2c: f94017e0     	ldr	x0, [sp, #0x28]
  8c3a30: 9100c002     	add	x2, x0, #0x30
  8c3a34: f94013e0     	ldr	x0, [sp, #0x20]
  8c3a38: f100001f     	cmp	x0, #0x0
  8c3a3c: 54000080     	b.eq	0x8c3a4c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d220>
  8c3a40: f94013e0     	ldr	x0, [sp, #0x20]
  8c3a44: 91012000     	add	x0, x0, #0x48
  8c3a48: 14000002     	b	0x8c3a50 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d224>
  8c3a4c: d2800000     	mov	x0, #0x0                // =0
  8c3a50: aa0003e1     	mov	x1, x0
  8c3a54: aa0203e0     	mov	x0, x2
  8c3a58: 940004ef     	bl	0x8c4e14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1e5e8>
  8c3a5c: 52800033     	mov	w19, #0x1               // =1
  8c3a60: 9100e3e0     	add	x0, sp, #0x38
  8c3a64: 97f93b58     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c3a68: 7100067f     	cmp	w19, #0x1
  8c3a6c: 14000006     	b	0x8c3a84 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d258>
  8c3a70: aa0003f3     	mov	x19, x0
  8c3a74: 9100e3e0     	add	x0, sp, #0x38
  8c3a78: 97f93b53     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c3a7c: aa1303e0     	mov	x0, x19
  8c3a80: 97ed1b34     	bl	0x40a750 <_Unwind_Resume@plt>
  8c3a84: f9400bf3     	ldr	x19, [sp, #0x10]
  8c3a88: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8c3a8c: d65f03c0     	ret
