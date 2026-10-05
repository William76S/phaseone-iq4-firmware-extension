  5bca5c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5bca60: 910003fd     	mov	x29, sp
  5bca64: f9000fe0     	str	x0, [sp, #0x18]
  5bca68: b90017e1     	str	w1, [sp, #0x14]
  5bca6c: f9400fe0     	ldr	x0, [sp, #0x18]
  5bca70: f9400000     	ldr	x0, [x0]
  5bca74: 91036000     	add	x0, x0, #0xd8
  5bca78: f9400002     	ldr	x2, [x0]
  5bca7c: b94017e1     	ldr	w1, [sp, #0x14]
  5bca80: f9400fe0     	ldr	x0, [sp, #0x18]
  5bca84: d63f0040     	blr	x2
  5bca88: 12001c00     	and	w0, w0, #0xff
  5bca8c: 52000000     	eor	w0, w0, #0x1
  5bca90: 12001c00     	and	w0, w0, #0xff
  5bca94: 7100001f     	cmp	w0, #0x0
  5bca98: 54000240     	b.eq	0x5bcae0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc3a30>
  5bca9c: f9400fe0     	ldr	x0, [sp, #0x18]
  5bcaa0: f9400000     	ldr	x0, [x0]
  5bcaa4: 91008000     	add	x0, x0, #0x20
  5bcaa8: f9400001     	ldr	x1, [x0]
  5bcaac: f9400fe0     	ldr	x0, [sp, #0x18]
  5bcab0: d63f0020     	blr	x1
  5bcab4: b94017e5     	ldr	w5, [sp, #0x14]
  5bcab8: aa0003e4     	mov	x4, x0
  5bcabc: b0003000     	adrp	x0, 0xbbd000
  5bcac0: 911fe003     	add	x3, x0, #0x7f8
  5bcac4: 528024a2     	mov	w2, #0x125              // =293
  5bcac8: b0003000     	adrp	x0, 0xbbd000
  5bcacc: 91208001     	add	x1, x0, #0x820
  5bcad0: 52800080     	mov	w0, #0x4                // =4
  5bcad4: 9406269e     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  5bcad8: 52800000     	mov	w0, #0x0                // =0
  5bcadc: 14000012     	b	0x5bcb24 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc3a74>
  5bcae0: f9400fe0     	ldr	x0, [sp, #0x18]
  5bcae4: f9400000     	ldr	x0, [x0]
  5bcae8: 91040000     	add	x0, x0, #0x100
  5bcaec: f9400002     	ldr	x2, [x0]
  5bcaf0: f9400fe0     	ldr	x0, [sp, #0x18]
  5bcaf4: f9400803     	ldr	x3, [x0, #0x10]
  5bcaf8: b94017e1     	ldr	w1, [sp, #0x14]
  5bcafc: aa0103e0     	mov	x0, x1
  5bcb00: d37ff800     	lsl	x0, x0, #1
  5bcb04: 8b010000     	add	x0, x0, x1
  5bcb08: d37df000     	lsl	x0, x0, #3
  5bcb0c: 8b000060     	add	x0, x3, x0
  5bcb10: b9401000     	ldr	w0, [x0, #0x10]
  5bcb14: 2a0003e1     	mov	w1, w0
  5bcb18: f9400fe0     	ldr	x0, [sp, #0x18]
  5bcb1c: d63f0040     	blr	x2
