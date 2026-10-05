  8c5d98: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8c5d9c: 910003fd     	mov	x29, sp
  8c5da0: f90017e0     	str	x0, [sp, #0x28]
  8c5da4: f90013e1     	str	x1, [sp, #0x20]
  8c5da8: 39007fe2     	strb	w2, [sp, #0x1f]
  8c5dac: f94017e0     	ldr	x0, [sp, #0x28]
  8c5db0: f9419000     	ldr	x0, [x0, #0x320]
  8c5db4: f100001f     	cmp	x0, #0x0
  8c5db8: 54000120     	b.eq	0x8c5ddc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f5b0>
  8c5dbc: f94017e0     	ldr	x0, [sp, #0x28]
  8c5dc0: f9419003     	ldr	x3, [x0, #0x320]
  8c5dc4: f94013e0     	ldr	x0, [sp, #0x20]
  8c5dc8: b940d800     	ldr	w0, [x0, #0xd8]
  8c5dcc: 39407fe2     	ldrb	w2, [sp, #0x1f]
  8c5dd0: 2a0003e1     	mov	w1, w0
  8c5dd4: aa0303e0     	mov	x0, x3
  8c5dd8: 97ef426b     	bl	0x496784 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x607d8>
  8c5ddc: d503201f     	nop
  8c5de0: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8c5de4: d65f03c0     	ret
