  916e38: a9408803     	ldp	x3, x2, [x0, #0x8]
  916e3c: cb030042     	sub	x2, x2, x3
  916e40: f100405f     	cmp	x2, #0x10
  916e44: 54000160     	b.eq	0x916e70
  916e48: 9344fc42     	asr	x2, x2, #4
  916e4c: 51000442     	sub	w2, w2, #0x1
  916e50: 6b01005f     	cmp	w2, w1
  916e54: 1a81d041     	csel	w1, w2, w1, le
  916e58: f9401000     	ldr	x0, [x0, #0x20]
  916e5c: 7100003f     	cmp	w1, #0x0
  916e60: 1a9fa021     	csel	w1, w1, wzr, ge
  916e64: 8b21d001     	add	x1, x0, w1, sxtw #4
  916e68: a9400420     	ldp	x0, x1, [x1]
  916e6c: d65f03c0     	ret
  916e70: a9468400     	ldp	x0, x1, [x0, #0x68]
  916e74: d65f03c0     	ret
