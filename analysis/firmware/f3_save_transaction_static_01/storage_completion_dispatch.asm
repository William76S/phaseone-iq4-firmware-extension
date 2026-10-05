  8db480: b90037ff     	str	wzr, [sp, #0x34]
  8db484: f94017e0     	ldr	x0, [sp, #0x28]
  8db488: b9400801     	ldr	w1, [x0, #0x8]
  8db48c: b94037e0     	ldr	w0, [sp, #0x34]
  8db490: 6b00003f     	cmp	w1, w0
  8db494: 54001189     	b.ls	0x8db6c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x34e98>
  8db498: f94017e0     	ldr	x0, [sp, #0x28]
  8db49c: f9400801     	ldr	x1, [x0, #0x10]
  8db4a0: b98037e0     	ldrsw	x0, [sp, #0x34]
  8db4a4: d37df000     	lsl	x0, x0, #3
  8db4a8: 8b000020     	add	x0, x1, x0
  8db4ac: f9400000     	ldr	x0, [x0]
  8db4b0: 9129c000     	add	x0, x0, #0xa70
  8db4b4: 97ecf2cc     	bl	0x417fe4 <.text+0xcdb4>
  8db4b8: aa0003e1     	mov	x1, x0
  8db4bc: f94013e0     	ldr	x0, [sp, #0x20]
  8db4c0: eb01001f     	cmp	x0, x1
  8db4c4: 1a9f17e0     	cset	w0, eq
  8db4c8: 12001c00     	and	w0, w0, #0xff
  8db4cc: 7100001f     	cmp	w0, #0x0
  8db4d0: 540001e0     	b.eq	0x8db50c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x34ce0>
  8db4d4: b94037f3     	ldr	w19, [sp, #0x34]
  8db4d8: f94017e0     	ldr	x0, [sp, #0x28]
  8db4dc: f9400801     	ldr	x1, [x0, #0x10]
  8db4e0: b98037e0     	ldrsw	x0, [sp, #0x34]
  8db4e4: d37df000     	lsl	x0, x0, #3
  8db4e8: 8b000020     	add	x0, x1, x0
  8db4ec: f9400000     	ldr	x0, [x0]
  8db4f0: 9129c000     	add	x0, x0, #0xa70
  8db4f4: 97ece522     	bl	0x41497c <.text+0x974c>
  8db4f8: 12001c00     	and	w0, w0, #0xff
  8db4fc: 2a0003e2     	mov	w2, w0
  8db500: 2a1303e1     	mov	w1, w19
  8db504: f94017e0     	ldr	x0, [sp, #0x28]
  8db508: 94000294     	bl	0x8dbf58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3572c>
  8db50c: f94017e0     	ldr	x0, [sp, #0x28]
