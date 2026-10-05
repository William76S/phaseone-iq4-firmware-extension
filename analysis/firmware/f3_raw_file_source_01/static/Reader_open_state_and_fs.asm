  7d95c0: 91418800     	add	x0, x0, #0x62, lsl #12  // =0x62000
  7d95c4: 91304000     	add	x0, x0, #0xc10
  7d95c8: 140130f8     	b	0x8259a8
  7d95cc: d503201f     	nop
  7d95d0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7d95d4: 910003fd     	mov	x29, sp
  7d95d8: f9000bf3     	str	x19, [sp, #0x10]
  7d95dc: aa0003f3     	mov	x19, x0
  7d95e0: 91418800     	add	x0, x0, #0x62, lsl #12  // =0x62000
  7d95e4: f90017e1     	str	x1, [sp, #0x28]
  7d95e8: 91304000     	add	x0, x0, #0xc10
  7d95ec: 940130ef     	bl	0x8259a8
  7d95f0: 72001c1f     	tst	w0, #0xff
  7d95f4: f94017e1     	ldr	x1, [sp, #0x28]
  7d95f8: 540000a1     	b.ne	0x7d960c
  7d95fc: f9000e61     	str	x1, [x19, #0x18]
  7d9600: f9400bf3     	ldr	x19, [sp, #0x10]
  7d9604: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7d9608: d65f03c0     	ret
  7d960c: f9400bf3     	ldr	x19, [sp, #0x10]
  7d9610: b0002d63     	adrp	x3, 0xd86000
  7d9614: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7d9618: b0002d61     	adrp	x1, 0xd86000
  7d961c: 911d4063     	add	x3, x3, #0x750
  7d9620: 911e4021     	add	x1, x1, #0x790
  7d9624: 52800422     	mov	w2, #0x21               // =33
  7d9628: 52800040     	mov	w0, #0x2                // =2
  7d962c: 17fdb3c8     	b	0x74654c
