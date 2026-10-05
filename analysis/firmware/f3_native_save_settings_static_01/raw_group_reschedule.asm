  8db860: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8db864: 910003fd     	mov	x29, sp
  8db868: f9000fe0     	str	x0, [sp, #0x18]
  8db86c: b90017e1     	str	w1, [sp, #0x14]
  8db870: f9400fe0     	ldr	x0, [sp, #0x18]
  8db874: b9400800     	ldr	w0, [x0, #0x8]
  8db878: b94017e1     	ldr	w1, [sp, #0x14]
  8db87c: 6b00003f     	cmp	w1, w0
  8db880: 54000143     	b.lo	0x8db8a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3507c>
  8db884: 52801cc3     	mov	w3, #0xe6               // =230
  8db888: f00026e0     	adrp	x0, 0xdba000
  8db88c: 911e0002     	add	x2, x0, #0x780
  8db890: f00026e0     	adrp	x0, 0xdba000
  8db894: 911fe001     	add	x1, x0, #0x7f8
  8db898: f00026e0     	adrp	x0, 0xdba000
  8db89c: 911f4000     	add	x0, x0, #0x7d0
  8db8a0: 97ecbb38     	bl	0x40a580 <printf@plt>
  8db8a4: 97fa4399     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8db8a8: f9400fe0     	ldr	x0, [sp, #0x18]
  8db8ac: f9402400     	ldr	x0, [x0, #0x48]
  8db8b0: f100001f     	cmp	x0, #0x0
  8db8b4: 54000880     	b.eq	0x8db9c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35198>
  8db8b8: f9400fe0     	ldr	x0, [sp, #0x18]
  8db8bc: f9400801     	ldr	x1, [x0, #0x10]
  8db8c0: b94017e0     	ldr	w0, [sp, #0x14]
  8db8c4: d37df000     	lsl	x0, x0, #3
  8db8c8: 8b000020     	add	x0, x1, x0
  8db8cc: f9400000     	ldr	x0, [x0]
  8db8d0: 97f86cb5     	bl	0x6f6ba4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x8b24>
  8db8d4: f90017e0     	str	x0, [sp, #0x28]
  8db8d8: b94017e1     	ldr	w1, [sp, #0x14]
  8db8dc: f9400fe0     	ldr	x0, [sp, #0x18]
  8db8e0: 940000b3     	bl	0x8dbbac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35380>
  8db8e4: 7100041f     	cmp	w0, #0x1
  8db8e8: 54000440     	b.eq	0x8db970 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35144>
  8db8ec: 7100081f     	cmp	w0, #0x2
  8db8f0: 540006e1     	b.ne	0x8db9cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351a0>
  8db8f4: f9400fe0     	ldr	x0, [sp, #0x18]
  8db8f8: f9400801     	ldr	x1, [x0, #0x10]
  8db8fc: b94017e0     	ldr	w0, [sp, #0x14]
  8db900: d37df000     	lsl	x0, x0, #3
  8db904: 8b000020     	add	x0, x1, x0
  8db908: f9400000     	ldr	x0, [x0]
  8db90c: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8db910: 52800021     	mov	w1, #0x1                // =1
  8db914: 390fc001     	strb	w1, [x0, #0x3f0]
  8db918: f9400fe0     	ldr	x0, [sp, #0x18]
  8db91c: f9400801     	ldr	x1, [x0, #0x10]
  8db920: b94017e0     	ldr	w0, [sp, #0x14]
  8db924: d37df000     	lsl	x0, x0, #3
  8db928: 8b000020     	add	x0, x1, x0
  8db92c: f9400000     	ldr	x0, [x0]
  8db930: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8db934: 52800021     	mov	w1, #0x1                // =1
  8db938: 390fc401     	strb	w1, [x0, #0x3f1]
  8db93c: f9400fe0     	ldr	x0, [sp, #0x18]
  8db940: f9400801     	ldr	x1, [x0, #0x10]
  8db944: b94017e0     	ldr	w0, [sp, #0x14]
  8db948: d37df000     	lsl	x0, x0, #3
  8db94c: 8b000020     	add	x0, x1, x0
  8db950: f9400000     	ldr	x0, [x0]
  8db954: 91262002     	add	x2, x0, #0x988
  8db958: f9400fe0     	ldr	x0, [sp, #0x18]
  8db95c: f9402400     	ldr	x0, [x0, #0x48]
  8db960: aa0003e1     	mov	x1, x0
  8db964: aa0203e0     	mov	x0, x2
  8db968: 97ed8d1f     	bl	0x43ede4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x8e38>
  8db96c: 1400001b     	b	0x8db9d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351ac>
  8db970: f9400fe0     	ldr	x0, [sp, #0x18]
  8db974: f9400801     	ldr	x1, [x0, #0x10]
  8db978: b94017e0     	ldr	w0, [sp, #0x14]
  8db97c: d37df000     	lsl	x0, x0, #3
  8db980: 8b000020     	add	x0, x1, x0
  8db984: f9400000     	ldr	x0, [x0]
  8db988: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8db98c: 394fc400     	ldrb	w0, [x0, #0x3f1]
  8db990: 52000000     	eor	w0, w0, #0x1
  8db994: 12001c00     	and	w0, w0, #0xff
  8db998: 7100001f     	cmp	w0, #0x0
  8db99c: 540001c0     	b.eq	0x8db9d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351a8>
  8db9a0: f9400fe0     	ldr	x0, [sp, #0x18]
  8db9a4: f9400801     	ldr	x1, [x0, #0x10]
  8db9a8: b94017e0     	ldr	w0, [sp, #0x14]
  8db9ac: d37df000     	lsl	x0, x0, #3
  8db9b0: 8b000020     	add	x0, x1, x0
  8db9b4: f9400000     	ldr	x0, [x0]
  8db9b8: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8db9bc: 390fc01f     	strb	wzr, [x0, #0x3f0]
  8db9c0: 14000005     	b	0x8db9d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351a8>
  8db9c4: d503201f     	nop
  8db9c8: 14000004     	b	0x8db9d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351ac>
  8db9cc: d503201f     	nop
  8db9d0: 14000002     	b	0x8db9d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351ac>
  8db9d4: d503201f     	nop
  8db9d8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8db9dc: d65f03c0     	ret
