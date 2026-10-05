  7bc7e4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7bc7e8: 910003fd     	mov	x29, sp
  7bc7ec: f9000fe0     	str	x0, [sp, #0x18]
  7bc7f0: f9000be1     	str	x1, [sp, #0x10]
  7bc7f4: f9400fe0     	ldr	x0, [sp, #0x18]
  7bc7f8: f9400401     	ldr	x1, [x0, #0x8]
  7bc7fc: f9400fe0     	ldr	x0, [sp, #0x18]
  7bc800: f9400800     	ldr	x0, [x0, #0x10]
  7bc804: eb00003f     	cmp	x1, x0
  7bc808: 540001c0     	b.eq	0x7bc840
  7bc80c: f9400fe3     	ldr	x3, [sp, #0x18]
  7bc810: f9400fe0     	ldr	x0, [sp, #0x18]
  7bc814: f9400400     	ldr	x0, [x0, #0x8]
  7bc818: f9400be2     	ldr	x2, [sp, #0x10]
  7bc81c: aa0003e1     	mov	x1, x0
  7bc820: aa0303e0     	mov	x0, x3
  7bc824: 940003a1     	bl	0x7bd6a8
  7bc828: f9400fe0     	ldr	x0, [sp, #0x18]
  7bc82c: f9400400     	ldr	x0, [x0, #0x8]
  7bc830: 91001001     	add	x1, x0, #0x4
  7bc834: f9400fe0     	ldr	x0, [sp, #0x18]
  7bc838: f9000401     	str	x1, [x0, #0x8]
  7bc83c: 14000007     	b	0x7bc858
  7bc840: f9400fe0     	ldr	x0, [sp, #0x18]
  7bc844: 97f1e00e     	bl	0x43487c
  7bc848: f9400be2     	ldr	x2, [sp, #0x10]
  7bc84c: aa0003e1     	mov	x1, x0
  7bc850: f9400fe0     	ldr	x0, [sp, #0x18]
  7bc854: 940003a3     	bl	0x7bd6e0
  7bc858: d503201f     	nop
  7bc85c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7bc860: d65f03c0     	ret
