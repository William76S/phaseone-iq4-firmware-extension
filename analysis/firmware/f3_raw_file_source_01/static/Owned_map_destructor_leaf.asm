  7bd21c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7bd220: 910003fd     	mov	x29, sp
  7bd224: f9000fe0     	str	x0, [sp, #0x18]
  7bd228: f9000be1     	str	x1, [sp, #0x10]
  7bd22c: f9400be0     	ldr	x0, [sp, #0x10]
  7bd230: f100001f     	cmp	x0, #0x0
  7bd234: 540001e0     	b.eq	0x7bd270
  7bd238: f9400be0     	ldr	x0, [sp, #0x10]
  7bd23c: 9400037e     	bl	0x7be034
  7bd240: aa0003e1     	mov	x1, x0
  7bd244: f9400fe0     	ldr	x0, [sp, #0x18]
  7bd248: 97fffff5     	bl	0x7bd21c
  7bd24c: f9400be0     	ldr	x0, [sp, #0x10]
  7bd250: 9400037f     	bl	0x7be04c
  7bd254: f90017e0     	str	x0, [sp, #0x28]
  7bd258: f9400be1     	ldr	x1, [sp, #0x10]
  7bd25c: f9400fe0     	ldr	x0, [sp, #0x18]
  7bd260: 94000381     	bl	0x7be064
  7bd264: f94017e0     	ldr	x0, [sp, #0x28]
  7bd268: f9000be0     	str	x0, [sp, #0x10]
  7bd26c: 17fffff0     	b	0x7bd22c
  7bd270: d503201f     	nop
  7bd274: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7bd278: d65f03c0     	ret
  7bd27c: d10043ff     	sub	sp, sp, #0x10
  7bd280: f90007e0     	str	x0, [sp, #0x8]
  7bd284: f94007e0     	ldr	x0, [sp, #0x8]
  7bd288: f9400800     	ldr	x0, [x0, #0x10]
  7bd28c: 910043ff     	add	sp, sp, #0x10
  7bd290: d65f03c0     	ret
