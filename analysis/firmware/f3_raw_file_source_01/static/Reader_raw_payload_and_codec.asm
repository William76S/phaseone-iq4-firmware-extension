  7d9630: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7d9634: 910003fd     	mov	x29, sp
  7d9638: a90153f3     	stp	x19, x20, [sp, #0x10]
  7d963c: aa0003f3     	mov	x19, x0
  7d9640: 91418800     	add	x0, x0, #0x62, lsl #12  // =0x62000
  7d9644: 91304000     	add	x0, x0, #0xc10
  7d9648: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7d964c: aa0103f5     	mov	x21, x1
  7d9650: 2a0203f6     	mov	w22, w2
  7d9654: 940130d5     	bl	0x8259a8
  7d9658: 72001c1f     	tst	w0, #0xff
  7d965c: 540002c0     	b.eq	0x7d96b4
  7d9660: 9140e260     	add	x0, x19, #0x38, lsl #12 // =0x38000
  7d9664: b9656c14     	ldr	w20, [x0, #0x256c]
  7d9668: 6b16029f     	cmp	w20, w22
  7d966c: 540003e8     	b.hi	0x7d96e8
  7d9670: 9140e260     	add	x0, x19, #0x38, lsl #12 // =0x38000
  7d9674: 91410273     	add	x19, x19, #0x40, lsl #12 // =0x40000
  7d9678: 91028000     	add	x0, x0, #0xa0
  7d967c: 97ffcac1     	bl	0x7cc180
  7d9680: aa1503e1     	mov	x1, x21
  7d9684: 2a1403e2     	mov	w2, w20
  7d9688: f9686663     	ldr	x3, [x19, #0x50c8]
  7d968c: aa0303e0     	mov	x0, x3
  7d9690: f9400063     	ldr	x3, [x3]
  7d9694: f9400c63     	ldr	x3, [x3, #0x18]
  7d9698: d63f0060     	blr	x3
  7d969c: 6b00029f     	cmp	w20, w0
  7d96a0: 1a9f0000     	csel	w0, w0, wzr, eq
  7d96a4: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7d96a8: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7d96ac: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7d96b0: d65f03c0     	ret
  7d96b4: b0002d62     	adrp	x2, 0xd86000
  7d96b8: b0002d61     	adrp	x1, 0xd86000
  7d96bc: 911e4042     	add	x2, x2, #0x790
  7d96c0: 911f0021     	add	x1, x1, #0x7c0
  7d96c4: 52804943     	mov	w3, #0x24a              // =586
  7d96c8: d0001d00     	adrp	x0, 0xb7b000
  7d96cc: 91212000     	add	x0, x0, #0x848
  7d96d0: 97f0c3ac     	bl	0x40a580
  7d96d4: 97fe4c0d     	bl	0x76c708
  7d96d8: 9140e260     	add	x0, x19, #0x38, lsl #12 // =0x38000
  7d96dc: b9656c14     	ldr	w20, [x0, #0x256c]
  7d96e0: 6b16029f     	cmp	w20, w22
  7d96e4: 54fffc69     	b.ls	0x7d9670
  7d96e8: b0002d62     	adrp	x2, 0xd86000
  7d96ec: b0002d61     	adrp	x1, 0xd86000
  7d96f0: 911e4042     	add	x2, x2, #0x790
  7d96f4: 911f4021     	add	x1, x1, #0x7d0
  7d96f8: 528049c3     	mov	w3, #0x24e              // =590
  7d96fc: d0001d00     	adrp	x0, 0xb7b000
  7d9700: 91212000     	add	x0, x0, #0x848
  7d9704: 97f0c39f     	bl	0x40a580
  7d9708: 97fe4c00     	bl	0x76c708
  7d970c: 17ffffd9     	b	0x7d9670
  7d9710: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7d9714: 910003fd     	mov	x29, sp
  7d9718: f9000bf3     	str	x19, [sp, #0x10]
  7d971c: aa0003f3     	mov	x19, x0
  7d9720: 91418800     	add	x0, x0, #0x62, lsl #12  // =0x62000
  7d9724: 91304000     	add	x0, x0, #0xc10
  7d9728: 940130a0     	bl	0x8259a8
  7d972c: 72001c1f     	tst	w0, #0xff
  7d9730: 540001a0     	b.eq	0x7d9764
  7d9734: 9140e273     	add	x19, x19, #0x38, lsl #12 // =0x38000
  7d9738: 52800000     	mov	w0, #0x0                // =0
  7d973c: b940e261     	ldr	w1, [x19, #0xe0]
  7d9740: 51000c21     	sub	w1, w1, #0x3
  7d9744: 7100183f     	cmp	w1, #0x6
  7d9748: 54000088     	b.hi	0x7d9758
  7d974c: b0002d60     	adrp	x0, 0xd86000
  7d9750: 911c6000     	add	x0, x0, #0x718
  7d9754: b8615800     	ldr	w0, [x0, w1, uxtw #2]
  7d9758: f9400bf3     	ldr	x19, [sp, #0x10]
  7d975c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7d9760: d65f03c0     	ret
  7d9764: b0002d62     	adrp	x2, 0xd86000
  7d9768: b0002d61     	adrp	x1, 0xd86000
  7d976c: 911e4042     	add	x2, x2, #0x790
  7d9770: 911f0021     	add	x1, x1, #0x7c0
  7d9774: 52804be3     	mov	w3, #0x25f              // =607
  7d9778: d0001d00     	adrp	x0, 0xb7b000
  7d977c: 91212000     	add	x0, x0, #0x848
  7d9780: 97f0c380     	bl	0x40a580
  7d9784: 97fe4be1     	bl	0x76c708
  7d9788: 17ffffeb     	b	0x7d9734
  7d978c: d503201f     	nop
