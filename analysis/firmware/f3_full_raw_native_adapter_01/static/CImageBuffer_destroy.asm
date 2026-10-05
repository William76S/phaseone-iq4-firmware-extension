  903ca8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  903cac: 910003fd     	mov	x29, sp
  903cb0: f9000bf3     	str	x19, [sp, #0x10]
  903cb4: aa0003f3     	mov	x19, x0
  903cb8: 39400000     	ldrb	w0, [x0]
  903cbc: 340001c0     	cbz	w0, 0x903cf4
  903cc0: f9401e60     	ldr	x0, [x19, #0x38]
  903cc4: 3900027f     	strb	wzr, [x19]
  903cc8: f900167f     	str	xzr, [x19, #0x28]
  903ccc: 91012261     	add	x1, x19, #0x48
  903cd0: b900327f     	str	wzr, [x19, #0x30]
  903cd4: eb01001f     	cmp	x0, x1
  903cd8: 54000080     	b.eq	0x903ce8
  903cdc: f9400bf3     	ldr	x19, [sp, #0x10]
  903ce0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  903ce4: 17ec1a33     	b	0x40a5b0
  903ce8: f9400bf3     	ldr	x19, [sp, #0x10]
  903cec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  903cf0: d65f03c0     	ret
  903cf4: f9401660     	ldr	x0, [x19, #0x28]
  903cf8: 97ec1d0a     	bl	0x40b120
  903cfc: 17fffff1     	b	0x903cc0
