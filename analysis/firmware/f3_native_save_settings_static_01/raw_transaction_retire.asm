  8dc13c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8dc140: 910003fd     	mov	x29, sp
  8dc144: f9000fe0     	str	x0, [sp, #0x18]
  8dc148: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc14c: 97fffe25     	bl	0x8db9e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351b4>
  8dc150: 7100001f     	cmp	w0, #0x0
  8dc154: 540000e1     	b.ne	0x8dc170 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35944>
  8dc158: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc15c: f9402400     	ldr	x0, [x0, #0x48]
  8dc160: f100001f     	cmp	x0, #0x0
  8dc164: 54000060     	b.eq	0x8dc170 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35944>
  8dc168: 52800020     	mov	w0, #0x1                // =1
  8dc16c: 14000002     	b	0x8dc174 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35948>
  8dc170: 52800000     	mov	w0, #0x0                // =0
  8dc174: 7100001f     	cmp	w0, #0x0
  8dc178: 54000480     	b.eq	0x8dc208 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x359dc>
  8dc17c: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc180: f9401c00     	ldr	x0, [x0, #0x38]
  8dc184: 9106e000     	add	x0, x0, #0x1b8
  8dc188: 97eee467     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  8dc18c: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc190: f9401c02     	ldr	x2, [x0, #0x38]
  8dc194: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc198: f9402400     	ldr	x0, [x0, #0x48]
  8dc19c: aa0003e1     	mov	x1, x0
  8dc1a0: aa0203e0     	mov	x0, x2
  8dc1a4: 97ffa5fb     	bl	0x8c5990 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f164>
  8dc1a8: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc1ac: f900241f     	str	xzr, [x0, #0x48]
  8dc1b0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc1b4: f9400c00     	ldr	x0, [x0, #0x18]
  8dc1b8: 91038000     	add	x0, x0, #0xe0
  8dc1bc: 97ece25b     	bl	0x414b28 <.text+0x98f8>
  8dc1c0: 7100001f     	cmp	w0, #0x0
  8dc1c4: 1a9f17e0     	cset	w0, eq
  8dc1c8: 12001c00     	and	w0, w0, #0xff
  8dc1cc: 7100001f     	cmp	w0, #0x0
  8dc1d0: 54000100     	b.eq	0x8dc1f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x359c4>
  8dc1d4: d00026e0     	adrp	x0, 0xdba000
  8dc1d8: 91208003     	add	x3, x0, #0x820
  8dc1dc: 52803fa2     	mov	w2, #0x1fd              // =509
  8dc1e0: d00026e0     	adrp	x0, 0xdba000
  8dc1e4: 911e0001     	add	x1, x0, #0x780
  8dc1e8: 52800040     	mov	w0, #0x2                // =2
  8dc1ec: 97f9a8d8     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8dc1f0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc1f4: f9400c00     	ldr	x0, [x0, #0x18]
  8dc1f8: 91038000     	add	x0, x0, #0xe0
  8dc1fc: 97f8c45a     	bl	0x70d364 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1f2e4>
  8dc200: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc204: 9400009d     	bl	0x8dc478 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35c4c>
  8dc208: d503201f     	nop
  8dc20c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8dc210: d65f03c0     	ret
