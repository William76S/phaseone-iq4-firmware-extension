  825724: d10083ff     	sub	sp, sp, #0x20
  825728: f9000fe0     	str	x0, [sp, #0x18]
  82572c: f9000be1     	str	x1, [sp, #0x10]
  825730: b9000fe2     	str	w2, [sp, #0xc]
  825734: 39002fe3     	strb	w3, [sp, #0xb]
  825738: f9400be0     	ldr	x0, [sp, #0x10]
  82573c: f9400fe1     	ldr	x1, [sp, #0x18]
  825740: f9000401     	str	x1, [x0, #0x8]
  825744: b9400fe1     	ldr	w1, [sp, #0xc]
  825748: f9400be0     	ldr	x0, [sp, #0x10]
  82574c: b9001001     	str	w1, [x0, #0x10]
  825750: f9400be0     	ldr	x0, [sp, #0x10]
  825754: 39402fe1     	ldrb	w1, [sp, #0xb]
  825758: 39005001     	strb	w1, [x0, #0x14]
  82575c: f9400be0     	ldr	x0, [sp, #0x10]
  825760: 3900541f     	strb	wzr, [x0, #0x15]
  825764: d503201f     	nop
  825768: 910083ff     	add	sp, sp, #0x20
  82576c: d65f03c0     	ret
  825770: d10043ff     	sub	sp, sp, #0x10
  825774: f90007e0     	str	x0, [sp, #0x8]
  825778: f0002b40     	adrp	x0, 0xd90000
  82577c: 91104001     	add	x1, x0, #0x410
  825780: f94007e0     	ldr	x0, [sp, #0x8]
  825784: f9000001     	str	x1, [x0]
  825788: f94007e0     	ldr	x0, [sp, #0x8]
  82578c: f900041f     	str	xzr, [x0, #0x8]
  825790: f94007e0     	ldr	x0, [sp, #0x8]
  825794: b900101f     	str	wzr, [x0, #0x10]
  825798: f94007e0     	ldr	x0, [sp, #0x8]
  82579c: 3900501f     	strb	wzr, [x0, #0x14]
  8257a0: f94007e0     	ldr	x0, [sp, #0x8]
  8257a4: 3900541f     	strb	wzr, [x0, #0x15]
  8257a8: d503201f     	nop
  8257ac: 910043ff     	add	sp, sp, #0x10
  8257b0: d65f03c0     	ret
  8257b4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8257b8: 910003fd     	mov	x29, sp
  8257bc: f9000fe0     	str	x0, [sp, #0x18]
  8257c0: f0002b40     	adrp	x0, 0xd90000
  8257c4: 91104001     	add	x1, x0, #0x410
  8257c8: f9400fe0     	ldr	x0, [sp, #0x18]
  8257cc: f9000001     	str	x1, [x0]
  8257d0: f9400fe0     	ldr	x0, [sp, #0x18]
  8257d4: 9400000e     	bl	0x82580c
  8257d8: d503201f     	nop
  8257dc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8257e0: d65f03c0     	ret
  8257e4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8257e8: 910003fd     	mov	x29, sp
  8257ec: f9000fe0     	str	x0, [sp, #0x18]
  8257f0: f9400fe0     	ldr	x0, [sp, #0x18]
  8257f4: 97fffff0     	bl	0x8257b4
  8257f8: d2800301     	mov	x1, #0x18               // =24
  8257fc: f9400fe0     	ldr	x0, [sp, #0x18]
  825800: 97ef9178     	bl	0x409de0
  825804: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  825808: d65f03c0     	ret
  82580c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  825810: 910003fd     	mov	x29, sp
  825814: f9000fe0     	str	x0, [sp, #0x18]
  825818: f9400fe0     	ldr	x0, [sp, #0x18]
  82581c: 39405000     	ldrb	w0, [x0, #0x14]
  825820: 7100001f     	cmp	w0, #0x0
  825824: 540001e0     	b.eq	0x825860
  825828: f9400fe0     	ldr	x0, [sp, #0x18]
  82582c: 3900501f     	strb	wzr, [x0, #0x14]
  825830: f9400fe0     	ldr	x0, [sp, #0x18]
  825834: f9400403     	ldr	x3, [x0, #0x8]
  825838: f9400fe0     	ldr	x0, [sp, #0x18]
  82583c: f9400400     	ldr	x0, [x0, #0x8]
  825840: f9400000     	ldr	x0, [x0]
  825844: 9103a000     	add	x0, x0, #0xe8
  825848: f9400002     	ldr	x2, [x0]
  82584c: f9400fe1     	ldr	x1, [sp, #0x18]
  825850: aa0303e0     	mov	x0, x3
  825854: d63f0040     	blr	x2
  825858: 12001c00     	and	w0, w0, #0xff
  82585c: 14000002     	b	0x825864
  825860: 52800000     	mov	w0, #0x0                // =0
  825864: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  825868: d65f03c0     	ret
