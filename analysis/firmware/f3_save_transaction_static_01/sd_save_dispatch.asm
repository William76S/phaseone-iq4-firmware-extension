  8e00c0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8e00c4: 910003fd     	mov	x29, sp
  8e00c8: f9000fe0     	str	x0, [sp, #0x18]
  8e00cc: f9000be1     	str	x1, [sp, #0x10]
  8e00d0: f9400fe0     	ldr	x0, [sp, #0x18]
  8e00d4: f9400000     	ldr	x0, [x0]
  8e00d8: 9100e000     	add	x0, x0, #0x38
  8e00dc: f9400001     	ldr	x1, [x0]
  8e00e0: f9400fe0     	ldr	x0, [sp, #0x18]
  8e00e4: d63f0020     	blr	x1
  8e00e8: 12001c00     	and	w0, w0, #0xff
  8e00ec: 52000000     	eor	w0, w0, #0x1
  8e00f0: 12001c00     	and	w0, w0, #0xff
  8e00f4: 7100001f     	cmp	w0, #0x0
  8e00f8: 54000060     	b.eq	0x8e0104 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x398d8>
  8e00fc: 52800020     	mov	w0, #0x1                // =1
  8e0100: 1400000f     	b	0x8e013c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39910>
  8e0104: f9400fe0     	ldr	x0, [sp, #0x18]
  8e0108: 52800021     	mov	w1, #0x1                // =1
  8e010c: 390ae001     	strb	w1, [x0, #0x2b8]
  8e0110: f9400be1     	ldr	x1, [sp, #0x10]
  8e0114: f9400fe0     	ldr	x0, [sp, #0x18]
  8e0118: 9400000b     	bl	0x8e0144 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x39918>
  8e011c: b9002fe0     	str	w0, [sp, #0x2c]
  8e0120: f9400fe0     	ldr	x0, [sp, #0x18]
  8e0124: 390ae01f     	strb	wzr, [x0, #0x2b8]
  8e0128: f9400fe0     	ldr	x0, [sp, #0x18]
  8e012c: 91072000     	add	x0, x0, #0x1c8
  8e0130: 52807d01     	mov	w1, #0x3e8              // =1000
  8e0134: 97f8d605     	bl	0x715948 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x278c8>
  8e0138: b9402fe0     	ldr	w0, [sp, #0x2c]
  8e013c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8e0140: d65f03c0     	ret
