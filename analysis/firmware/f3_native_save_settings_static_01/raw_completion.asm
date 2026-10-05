  8dbf58: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8dbf5c: 910003fd     	mov	x29, sp
  8dbf60: f9000fe0     	str	x0, [sp, #0x18]
  8dbf64: b90017e1     	str	w1, [sp, #0x14]
  8dbf68: 39004fe2     	strb	w2, [sp, #0x13]
  8dbf6c: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbf70: f9400801     	ldr	x1, [x0, #0x10]
  8dbf74: b94017e0     	ldr	w0, [sp, #0x14]
  8dbf78: d37df000     	lsl	x0, x0, #3
  8dbf7c: 8b000020     	add	x0, x1, x0
  8dbf80: f9400000     	ldr	x0, [x0]
  8dbf84: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dbf88: 390fc41f     	strb	wzr, [x0, #0x3f1]
  8dbf8c: 39404fe0     	ldrb	w0, [sp, #0x13]
  8dbf90: 52000000     	eor	w0, w0, #0x1
  8dbf94: 12001c00     	and	w0, w0, #0xff
  8dbf98: 7100001f     	cmp	w0, #0x0
  8dbf9c: 54000500     	b.eq	0x8dc03c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35810>
  8dbfa0: b94017e1     	ldr	w1, [sp, #0x14]
  8dbfa4: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbfa8: 97ffff01     	bl	0x8dbbac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35380>
  8dbfac: 7100081f     	cmp	w0, #0x2
  8dbfb0: 1a9f17e0     	cset	w0, eq
  8dbfb4: 12001c00     	and	w0, w0, #0xff
  8dbfb8: 7100001f     	cmp	w0, #0x0
  8dbfbc: 54000ba0     	b.eq	0x8dc130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35904>
  8dbfc0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbfc4: f9400801     	ldr	x1, [x0, #0x10]
  8dbfc8: b94017e0     	ldr	w0, [sp, #0x14]
  8dbfcc: d37df000     	lsl	x0, x0, #3
  8dbfd0: 8b000020     	add	x0, x1, x0
  8dbfd4: f9400000     	ldr	x0, [x0]
  8dbfd8: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dbfdc: 52800021     	mov	w1, #0x1                // =1
  8dbfe0: 390fc001     	strb	w1, [x0, #0x3f0]
  8dbfe4: f9400fe0     	ldr	x0, [sp, #0x18]
  8dbfe8: f9400801     	ldr	x1, [x0, #0x10]
  8dbfec: b94017e0     	ldr	w0, [sp, #0x14]
  8dbff0: d37df000     	lsl	x0, x0, #3
  8dbff4: 8b000020     	add	x0, x1, x0
  8dbff8: f9400000     	ldr	x0, [x0]
  8dbffc: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc000: 52800021     	mov	w1, #0x1                // =1
  8dc004: 390fc401     	strb	w1, [x0, #0x3f1]
  8dc008: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc00c: f9400801     	ldr	x1, [x0, #0x10]
  8dc010: b94017e0     	ldr	w0, [sp, #0x14]
  8dc014: d37df000     	lsl	x0, x0, #3
  8dc018: 8b000020     	add	x0, x1, x0
  8dc01c: f9400000     	ldr	x0, [x0]
  8dc020: 91262002     	add	x2, x0, #0x988
  8dc024: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc028: f9402400     	ldr	x0, [x0, #0x48]
  8dc02c: aa0003e1     	mov	x1, x0
  8dc030: aa0203e0     	mov	x0, x2
  8dc034: 97ed8b6c     	bl	0x43ede4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x8e38>
  8dc038: 1400003e     	b	0x8dc130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35904>
  8dc03c: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc040: f9400801     	ldr	x1, [x0, #0x10]
  8dc044: b94017e0     	ldr	w0, [sp, #0x14]
  8dc048: d37df000     	lsl	x0, x0, #3
  8dc04c: 8b000020     	add	x0, x1, x0
  8dc050: f9400000     	ldr	x0, [x0]
  8dc054: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc058: 394fc800     	ldrb	w0, [x0, #0x3f2]
  8dc05c: 7100001f     	cmp	w0, #0x0
  8dc060: 54000300     	b.eq	0x8dc0c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35894>
  8dc064: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc068: f9400801     	ldr	x1, [x0, #0x10]
  8dc06c: b94017e0     	ldr	w0, [sp, #0x14]
  8dc070: d37df000     	lsl	x0, x0, #3
  8dc074: 8b000020     	add	x0, x1, x0
  8dc078: f9400000     	ldr	x0, [x0]
  8dc07c: 91262000     	add	x0, x0, #0x988
  8dc080: 97ed8b4c     	bl	0x43edb0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x8e04>
  8dc084: f90017e0     	str	x0, [sp, #0x28]
  8dc088: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc08c: f9401c03     	ldr	x3, [x0, #0x38]
  8dc090: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc094: f9400801     	ldr	x1, [x0, #0x10]
  8dc098: b94017e0     	ldr	w0, [sp, #0x14]
  8dc09c: d37df000     	lsl	x0, x0, #3
  8dc0a0: 8b000020     	add	x0, x1, x0
  8dc0a4: f9400000     	ldr	x0, [x0]
  8dc0a8: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc0ac: 394fcc00     	ldrb	w0, [x0, #0x3f3]
  8dc0b0: 2a0003e2     	mov	w2, w0
  8dc0b4: f94017e1     	ldr	x1, [sp, #0x28]
  8dc0b8: aa0303e0     	mov	x0, x3
  8dc0bc: 97ffa737     	bl	0x8c5d98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f56c>
  8dc0c0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc0c4: f9400801     	ldr	x1, [x0, #0x10]
  8dc0c8: b94017e0     	ldr	w0, [sp, #0x14]
  8dc0cc: d37df000     	lsl	x0, x0, #3
  8dc0d0: 8b000020     	add	x0, x1, x0
  8dc0d4: f9400000     	ldr	x0, [x0]
  8dc0d8: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc0dc: 390fc01f     	strb	wzr, [x0, #0x3f0]
  8dc0e0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc0e4: f9400801     	ldr	x1, [x0, #0x10]
  8dc0e8: b94017e0     	ldr	w0, [sp, #0x14]
  8dc0ec: d37df000     	lsl	x0, x0, #3
  8dc0f0: 8b000020     	add	x0, x1, x0
  8dc0f4: f9400000     	ldr	x0, [x0]
  8dc0f8: 910e2000     	add	x0, x0, #0x388
  8dc0fc: 97f8c49a     	bl	0x70d364 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1f2e4>
  8dc100: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc104: f9400801     	ldr	x1, [x0, #0x10]
  8dc108: b94017e0     	ldr	w0, [sp, #0x14]
  8dc10c: d37df000     	lsl	x0, x0, #3
  8dc110: 8b000020     	add	x0, x1, x0
  8dc114: f9400000     	ldr	x0, [x0]
  8dc118: b953f401     	ldr	w1, [x0, #0x13f4]
  8dc11c: 11000421     	add	w1, w1, #0x1
  8dc120: b913f401     	str	w1, [x0, #0x13f4]
  8dc124: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc128: 94000005     	bl	0x8dc13c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35910>
  8dc12c: 14000002     	b	0x8dc134 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35908>
  8dc130: d503201f     	nop
  8dc134: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8dc138: d65f03c0     	ret
