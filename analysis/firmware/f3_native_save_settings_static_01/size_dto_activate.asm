  5bbb80: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5bbb84: 910003fd     	mov	x29, sp
  5bbb88: f9000fe0     	str	x0, [sp, #0x18]
  5bbb8c: b90017e1     	str	w1, [sp, #0x14]
  5bbb90: f9400fe0     	ldr	x0, [sp, #0x18]
  5bbb94: f9400000     	ldr	x0, [x0]
  5bbb98: 91036000     	add	x0, x0, #0xd8
  5bbb9c: f9400002     	ldr	x2, [x0]
  5bbba0: b94017e1     	ldr	w1, [sp, #0x14]
  5bbba4: f9400fe0     	ldr	x0, [sp, #0x18]
  5bbba8: d63f0040     	blr	x2
  5bbbac: 12001c00     	and	w0, w0, #0xff
  5bbbb0: 52000000     	eor	w0, w0, #0x1
  5bbbb4: 12001c00     	and	w0, w0, #0xff
  5bbbb8: 7100001f     	cmp	w0, #0x0
  5bbbbc: 54000240     	b.eq	0x5bbc04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc2b54>
  5bbbc0: f9400fe0     	ldr	x0, [sp, #0x18]
  5bbbc4: f9400000     	ldr	x0, [x0]
  5bbbc8: 91008000     	add	x0, x0, #0x20
  5bbbcc: f9400001     	ldr	x1, [x0]
  5bbbd0: f9400fe0     	ldr	x0, [sp, #0x18]
  5bbbd4: d63f0020     	blr	x1
  5bbbd8: b94017e5     	ldr	w5, [sp, #0x14]
  5bbbdc: aa0003e4     	mov	x4, x0
  5bbbe0: d0003000     	adrp	x0, 0xbbd000
  5bbbe4: 911fe003     	add	x3, x0, #0x7f8
  5bbbe8: 528024a2     	mov	w2, #0x125              // =293
  5bbbec: d0003000     	adrp	x0, 0xbbd000
  5bbbf0: 91208001     	add	x1, x0, #0x820
  5bbbf4: 52800080     	mov	w0, #0x4                // =4
  5bbbf8: 94062a55     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  5bbbfc: 52800000     	mov	w0, #0x0                // =0
  5bbc00: 14000012     	b	0x5bbc48 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc2b98>
  5bbc04: f9400fe0     	ldr	x0, [sp, #0x18]
  5bbc08: f9400000     	ldr	x0, [x0]
  5bbc0c: 91040000     	add	x0, x0, #0x100
  5bbc10: f9400002     	ldr	x2, [x0]
  5bbc14: f9400fe0     	ldr	x0, [sp, #0x18]
  5bbc18: f9400803     	ldr	x3, [x0, #0x10]
  5bbc1c: b94017e1     	ldr	w1, [sp, #0x14]
  5bbc20: aa0103e0     	mov	x0, x1
  5bbc24: d37ff800     	lsl	x0, x0, #1
  5bbc28: 8b010000     	add	x0, x0, x1
  5bbc2c: d37df000     	lsl	x0, x0, #3
  5bbc30: 8b000060     	add	x0, x3, x0
  5bbc34: b9401000     	ldr	w0, [x0, #0x10]
  5bbc38: 2a0003e1     	mov	w1, w0
  5bbc3c: f9400fe0     	ldr	x0, [sp, #0x18]
  5bbc40: d63f0040     	blr	x2
