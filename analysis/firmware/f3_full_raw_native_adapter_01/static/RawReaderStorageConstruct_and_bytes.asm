  922170: b9402be9     	ldr	w9, [sp, #0x28]
  922174: 90002528     	adrp	x8, 0xdc6000
  922178: 9135a108     	add	x8, x8, #0xd68
  92217c: a9007c08     	stp	x8, xzr, [x0]
  922180: 5100052a     	sub	w10, w9, #0x1
  922184: 7100115f     	cmp	w10, #0x4
  922188: 3940c3ec     	ldrb	w12, [sp, #0x30]
  92218c: 3940e3ea     	ldrb	w10, [sp, #0x38]
  922190: b94023e8     	ldr	w8, [sp, #0x20]
  922194: 540006a8     	b.hi	0x922268
  922198: 5100210b     	sub	w11, w8, #0x8
  92219c: 721c797f     	tst	w11, #0xfffffff7
  9221a0: 54000641     	b.ne	0x922268
  9221a4: 6b06005f     	cmp	w2, w6
  9221a8: 7a472060     	ccmp	w3, w7, #0x0, hs
  9221ac: 540005e3     	b.lo	0x922268
  9221b0: f9000401     	str	x1, [x0, #0x8]
  9221b4: b9404be1     	ldr	w1, [sp, #0x48]
  9221b8: 29092408     	stp	w8, w9, [x0, #0x48]
  9221bc: 3901600a     	strb	w10, [x0, #0x58]
  9221c0: 3901640c     	strb	w12, [x0, #0x59]
  9221c4: 34000541     	cbz	w1, 0x92226c
  9221c8: b9404be8     	ldr	w8, [sp, #0x48]
  9221cc: b9005408     	str	w8, [x0, #0x54]
  9221d0: 0b0600a9     	add	w9, w5, w6
  9221d4: 53037d08     	lsr	w8, w8, #3
  9221d8: 6b09005f     	cmp	w2, w9
  9221dc: 0b07008a     	add	w10, w4, w7
  9221e0: 1a824129     	csel	w9, w9, w2, mi
  9221e4: f9000c1f     	str	xzr, [x0, #0x18]
  9221e8: 6b0a007f     	cmp	w3, w10
  9221ec: 4e040c40     	dup	v0.4s, w2
  9221f0: 1a83414a     	csel	w10, w10, w3, mi
  9221f4: 1b097d01     	mul	w1, w8, w9
  9221f8: f240103f     	tst	x1, #0x1f
  9221fc: 54000420     	b.eq	0x922280
  922200: 4e040cc1     	dup	v1.4s, w6
  922204: 4e0c1c60     	mov	v0.s[1], w3
  922208: 121b6821     	and	w1, w1, #0xffffffe0
  92220c: b94013e2     	ldr	w2, [sp, #0x10]
  922210: 11008021     	add	w1, w1, #0x20
  922214: b9004002     	str	w2, [x0, #0x40]
  922218: b9401be2     	ldr	w2, [sp, #0x18]
  92221c: 4e0c1ce1     	mov	v1.s[1], w7
  922220: 4e141c80     	mov	v0.s[2], w4
  922224: 1ac80821     	udiv	w1, w1, w8
  922228: b9004402     	str	w2, [x0, #0x44]
  92222c: 910023e2     	add	x2, sp, #0x8
  922230: 4d4083e1     	ld1	{ v1.s }[2], [sp]
  922234: 4e1c1ca0     	mov	v0.s[3], w5
  922238: 29022801     	stp	w1, w10, [x0, #0x10]
  92223c: 4d409041     	ld1	{ v1.s }[3], [x2]
  922240: b94043e2     	ldr	w2, [sp, #0x40]
  922244: 3d800800     	str	q0, [x0, #0x20]
  922248: 3d800c01     	str	q1, [x0, #0x30]
  92224c: 350003c2     	cbnz	w2, 0x9222c4
  922250: 1b017d01     	mul	w1, w8, w1
  922254: f240103f     	tst	x1, #0x1f
  922258: 54000380     	b.eq	0x9222c8
  92225c: 121b6821     	and	w1, w1, #0xffffffe0
  922260: 11008021     	add	w1, w1, #0x20
  922264: b9005001     	str	w1, [x0, #0x50]
  922268: d65f03c0     	ret
  92226c: 1b097d09     	mul	w9, w8, w9
  922270: 7100015f     	cmp	w10, #0x0
  922274: 1a880128     	csel	w8, w9, w8, eq
  922278: b9005408     	str	w8, [x0, #0x54]
  92227c: 17ffffd5     	b	0x9221d0
  922280: 4e040cc1     	dup	v1.4s, w6
  922284: 4e0c1c60     	mov	v0.s[1], w3
  922288: b94013e2     	ldr	w2, [sp, #0x10]
  92228c: b9004002     	str	w2, [x0, #0x40]
  922290: b9401be2     	ldr	w2, [sp, #0x18]
  922294: 4e0c1ce1     	mov	v1.s[1], w7
  922298: 4e141c80     	mov	v0.s[2], w4
  92229c: b9004402     	str	w2, [x0, #0x44]
  9222a0: 910023e2     	add	x2, sp, #0x8
  9222a4: 29022809     	stp	w9, w10, [x0, #0x10]
  9222a8: 4d4083e1     	ld1	{ v1.s }[2], [sp]
  9222ac: 4e1c1ca0     	mov	v0.s[3], w5
  9222b0: 4d409041     	ld1	{ v1.s }[3], [x2]
  9222b4: b94043e2     	ldr	w2, [sp, #0x40]
  9222b8: 3d800800     	str	q0, [x0, #0x20]
  9222bc: 3d800c01     	str	q1, [x0, #0x30]
  9222c0: 34000042     	cbz	w2, 0x9222c8
  9222c4: b94043e1     	ldr	w1, [sp, #0x40]
  9222c8: b9005001     	str	w1, [x0, #0x50]
  9222cc: d65f03c0     	ret
  9222d0: b9401401     	ldr	w1, [x0, #0x14]
  9222d4: b9405000     	ldr	w0, [x0, #0x50]
  9222d8: 1b017c00     	mul	w0, w0, w1
  9222dc: d65f03c0     	ret
