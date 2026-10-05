  903f70: 1e270060     	fmov	s0, w3
  903f74: 51000488     	sub	w8, w4, #0x1
  903f78: 531f7863     	lsl	w3, w3, #1
  903f7c: 7100491f     	cmp	w8, #0x12
  903f80: 0b010069     	add	w9, w3, w1
  903f84: 0b020067     	add	w7, w3, w2
  903f88: 52800003     	mov	w3, #0x0                // =0
  903f8c: 540000a8     	b.hi	0x903fa0
  903f90: b0002603     	adrp	x3, 0xdc4000
  903f94: 9118a063     	add	x3, x3, #0x628
  903f98: b8685863     	ldr	w3, [x3, w8, uxtw #2]
  903f9c: 1b037d23     	mul	w3, w9, w3
  903fa0: 4e040400     	dup	v0.4s, v0.s[0]
  903fa4: 510004a8     	sub	w8, w5, #0x1
  903fa8: 0b030108     	add	w8, w8, w3
  903fac: 4b0503ea     	neg	w10, w5
  903fb0: 710000bf     	cmp	w5, #0x0
  903fb4: 0a0a0108     	and	w8, w8, w10
  903fb8: 1a831103     	csel	w3, w8, w3, ne
  903fbc: 29028801     	stp	w1, w2, [x0, #0x14]
  903fc0: 4e041d20     	mov	v0.s[0], w9
  903fc4: 52800029     	mov	w9, #0x1                // =1
  903fc8: 39000009     	strb	w9, [x0]
  903fcc: 1b037ce9     	mul	w9, w7, w3
  903fd0: 29039404     	stp	w4, w5, [x0, #0x1c]
  903fd4: b9002403     	str	w3, [x0, #0x24]
  903fd8: 4e0c1ce0     	mov	v0.s[1], w7
  903fdc: f9001406     	str	x6, [x0, #0x28]
  903fe0: b9003009     	str	w9, [x0, #0x30]
  903fe4: 3c804000     	stur	q0, [x0, #0x4]
  903fe8: d65f03c0     	ret
  903fec: d503201f     	nop
  903ff0: b9803002     	ldrsw	x2, [x0, #0x30]
  903ff4: 12001c21     	and	w1, w1, #0xff
  903ff8: f9401400     	ldr	x0, [x0, #0x28]
  903ffc: 17ec1869     	b	0x40a1a0
  904000: fc404000     	ldur	d0, [x0, #0x4]
  904004: f800c01f     	stur	xzr, [x0, #0xc]
  904008: fc014000     	stur	d0, [x0, #0x14]
  90400c: d65f03c0     	ret
