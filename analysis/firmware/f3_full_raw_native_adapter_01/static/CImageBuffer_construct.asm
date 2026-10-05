  904550: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  904554: 90002603     	adrp	x3, 0xdc4000
  904558: d2800064     	mov	x4, #0x3                // =3
  90455c: 910003fd     	mov	x29, sp
  904560: a90153f3     	stp	x19, x20, [sp, #0x10]
  904564: aa0003f3     	mov	x19, x0
  904568: 91003261     	add	x1, x19, #0xc
  90456c: 91012014     	add	x20, x0, #0x48
  904570: 91208063     	add	x3, x3, #0x820
  904574: 9100e000     	add	x0, x0, #0x38
  904578: d2800002     	mov	x2, #0x0                // =0
  90457c: a9007c3f     	stp	xzr, xzr, [x1]
  904580: d2800001     	mov	x1, #0x0                // =0
  904584: f900167f     	str	xzr, [x19, #0x28]
  904588: a903fe74     	stp	x20, xzr, [x19, #0x38]
  90458c: 3901227f     	strb	wzr, [x19, #0x48]
  904590: 94000034     	bl	0x904660
  904594: 39400260     	ldrb	w0, [x19]
  904598: 34000160     	cbz	w0, 0x9045c4
  90459c: 91001260     	add	x0, x19, #0x4
  9045a0: 3900027f     	strb	wzr, [x19]
  9045a4: a9007c1f     	stp	xzr, xzr, [x0]
  9045a8: f801427f     	stur	xzr, [x19, #0x14]
  9045ac: f801c27f     	stur	xzr, [x19, #0x1c]
  9045b0: f802427f     	stur	xzr, [x19, #0x24]
  9045b4: f802c27f     	stur	xzr, [x19, #0x2c]
  9045b8: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9045bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9045c0: d65f03c0     	ret
  9045c4: f9401660     	ldr	x0, [x19, #0x28]
  9045c8: 97ec1ad6     	bl	0x40b120
  9045cc: 17fffff4     	b	0x90459c
