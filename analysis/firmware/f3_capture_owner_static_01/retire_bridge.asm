  8c5990: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c5994: 910003fd     	mov	x29, sp
  8c5998: f9000fe0     	str	x0, [sp, #0x18]
  8c599c: f9000be1     	str	x1, [sp, #0x10]
  8c59a0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c59a4: f9419000     	ldr	x0, [x0, #0x320]
  8c59a8: f100001f     	cmp	x0, #0x0
  8c59ac: 54000100     	b.eq	0x8c59cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f1a0>
  8c59b0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c59b4: f9419002     	ldr	x2, [x0, #0x320]
  8c59b8: f9400be0     	ldr	x0, [sp, #0x10]
  8c59bc: b940d800     	ldr	w0, [x0, #0xd8]
  8c59c0: 2a0003e1     	mov	w1, w0
  8c59c4: aa0203e0     	mov	x0, x2
  8c59c8: 97ef434b     	bl	0x4966f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x60748>
  8c59cc: f9400be0     	ldr	x0, [sp, #0x10]
  8c59d0: 97fff384     	bl	0x8c27e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bfb4>
  8c59d4: f9400be0     	ldr	x0, [sp, #0x10]
  8c59d8: 97f8ab55     	bl	0x6f072c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x26ac>
  8c59dc: 12001c00     	and	w0, w0, #0xff
  8c59e0: 7100001f     	cmp	w0, #0x0
  8c59e4: 54000060     	b.eq	0x8c59f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f1c4>
  8c59e8: f9400be0     	ldr	x0, [sp, #0x10]
  8c59ec: 97fff3db     	bl	0x8c2958 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c12c>
  8c59f0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c59f4: 91092002     	add	x2, x0, #0x248
  8c59f8: f9400be0     	ldr	x0, [sp, #0x10]
  8c59fc: 9101e000     	add	x0, x0, #0x78
  8c5a00: aa0003e1     	mov	x1, x0
  8c5a04: aa0203e0     	mov	x0, x2
  8c5a08: 940005a5     	bl	0x8c709c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x20870>
  8c5a0c: d503201f     	nop
  8c5a10: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c5a14: d65f03c0     	ret
