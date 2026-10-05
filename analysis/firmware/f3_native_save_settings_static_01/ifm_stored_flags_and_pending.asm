  496784: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  496788: 910003fd     	mov	x29, sp
  49678c: f9000bf3     	str	x19, [sp, #0x10]
  496790: f90017e0     	str	x0, [sp, #0x28]
  496794: b90027e1     	str	w1, [sp, #0x24]
  496798: 39008fe2     	strb	w2, [sp, #0x23]
  49679c: b94027e0     	ldr	w0, [sp, #0x24]
  4967a0: 7100001f     	cmp	w0, #0x0
  4967a4: 540009eb     	b.lt	0x4968e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60934>
  4967a8: f94017e0     	ldr	x0, [sp, #0x28]
  4967ac: f947d400     	ldr	x0, [x0, #0xfa8]
  4967b0: b941b800     	ldr	w0, [x0, #0x1b8]
  4967b4: b94027e1     	ldr	w1, [sp, #0x24]
  4967b8: 6b00003f     	cmp	w1, w0
  4967bc: 5400092a     	b.ge	0x4968e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60934>
  4967c0: f94017e0     	ldr	x0, [sp, #0x28]
  4967c4: f947d400     	ldr	x0, [x0, #0xfa8]
  4967c8: 91070001     	add	x1, x0, #0x1c0
  4967cc: 9100e3e0     	add	x0, sp, #0x38
  4967d0: 97fdecfc     	bl	0x411bc0 <.text+0x6990>
  4967d4: f94017e0     	ldr	x0, [sp, #0x28]
  4967d8: f947d400     	ldr	x0, [x0, #0xfa8]
  4967dc: f940d800     	ldr	x0, [x0, #0x1b0]
  4967e0: b98027e1     	ldrsw	x1, [sp, #0x24]
  4967e4: 97ffe343     	bl	0x48f4f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x59544>
  4967e8: 39403802     	ldrb	w2, [x0, #0xe]
  4967ec: 39408fe1     	ldrb	w1, [sp, #0x23]
  4967f0: 2a010041     	orr	w1, w2, w1
  4967f4: 12001c21     	and	w1, w1, #0xff
  4967f8: 39003801     	strb	w1, [x0, #0xe]
  4967fc: f94017e0     	ldr	x0, [sp, #0x28]
  496800: f947d400     	ldr	x0, [x0, #0xfa8]
  496804: 52800022     	mov	w2, #0x1                // =1
  496808: b94027e1     	ldr	w1, [sp, #0x24]
  49680c: 97ffc403     	bl	0x487818 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5186c>
  496810: 9100e3e0     	add	x0, sp, #0x38
  496814: 97fdecf8     	bl	0x411bf4 <.text+0x69c4>
  496818: 39408fe0     	ldrb	w0, [sp, #0x23]
  49681c: 7100081f     	cmp	w0, #0x2
  496820: 540001a0     	b.eq	0x496854 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x608a8>
  496824: 7100081f     	cmp	w0, #0x2
  496828: 5400008c     	b.gt	0x496838 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6088c>
  49682c: 7100001f     	cmp	w0, #0x0
  496830: 5400038b     	b.lt	0x4968a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x608f4>
  496834: 1400002d     	b	0x4968e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6093c>
  496838: 7100201f     	cmp	w0, #0x8
  49683c: 54000560     	b.eq	0x4968e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6093c>
  496840: 7100401f     	cmp	w0, #0x10
  496844: 54000520     	b.eq	0x4968e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6093c>
  496848: 7100101f     	cmp	w0, #0x4
  49684c: 540004e0     	b.eq	0x4968e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x6093c>
  496850: 14000014     	b	0x4968a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x608f4>
  496854: f94017e0     	ldr	x0, [sp, #0x28]
  496858: 397ed000     	ldrb	w0, [x0, #0xfb4]
  49685c: 7100001f     	cmp	w0, #0x0
  496860: 54000080     	b.eq	0x496870 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x608c4>
  496864: b94027e1     	ldr	w1, [sp, #0x24]
  496868: f94017e0     	ldr	x0, [sp, #0x28]
  49686c: 94000855     	bl	0x4989c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x62a14>
  496870: f94017e0     	ldr	x0, [sp, #0x28]
  496874: 397ed400     	ldrb	w0, [x0, #0xfb5]
  496878: 7100001f     	cmp	w0, #0x0
  49687c: 54000080     	b.eq	0x49688c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x608e0>
  496880: b94027e1     	ldr	w1, [sp, #0x24]
  496884: f94017e0     	ldr	x0, [sp, #0x28]
  496888: 94000843     	bl	0x498994 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x629e8>
  49688c: f94017e0     	ldr	x0, [sp, #0x28]
  496890: 911de000     	add	x0, x0, #0x778
  496894: b94027e1     	ldr	w1, [sp, #0x24]
  496898: 97fdd807     	bl	0x40c8b4 <.text+0x1684>
  49689c: 14000014     	b	0x4968ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60940>
  4968a0: 39408fe0     	ldrb	w0, [sp, #0x23]
  4968a4: 2a0003e4     	mov	w4, w0
  4968a8: b0003740     	adrp	x0, 0xb7f000
  4968ac: 91174003     	add	x3, x0, #0x5d0
  4968b0: 52802642     	mov	w2, #0x132              // =306
  4968b4: b0003740     	adrp	x0, 0xb7f000
  4968b8: 91166001     	add	x1, x0, #0x598
  4968bc: 52800040     	mov	w0, #0x2                // =2
  4968c0: 940abf23     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  4968c4: d503201f     	nop
  4968c8: 14000009     	b	0x4968ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60940>
  4968cc: aa0003f3     	mov	x19, x0
  4968d0: 9100e3e0     	add	x0, sp, #0x38
  4968d4: 97fdecc8     	bl	0x411bf4 <.text+0x69c4>
  4968d8: aa1303e0     	mov	x0, x19
  4968dc: 97fdcf9d     	bl	0x40a750 <_Unwind_Resume@plt>
  4968e0: d503201f     	nop
  4968e4: 14000002     	b	0x4968ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60940>
  4968e8: d503201f     	nop
  4968ec: f9400bf3     	ldr	x19, [sp, #0x10]
  4968f0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4968f4: d65f03c0     	ret
