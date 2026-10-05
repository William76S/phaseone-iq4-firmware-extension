  916e78: a9408804     	ldp	x4, x2, [x0, #0x8]
  916e7c: f9401003     	ldr	x3, [x0, #0x20]
  916e80: cb040042     	sub	x2, x2, x4
  916e84: f100405f     	cmp	x2, #0x10
  916e88: 540002e0     	b.eq	0x916ee4
  916e8c: f9402805     	ldr	x5, [x0, #0x50]
  916e90: 93407c24     	sxtw	x4, w1
  916e94: 9344fc42     	asr	x2, x2, #4
  916e98: 71000442     	subs	w2, w2, #0x1
  916e9c: bc6478a0     	ldr	s0, [x5, x4, lsl #2]
  916ea0: 1a9f5042     	csel	w2, w2, wzr, pl
  916ea4: 7100003f     	cmp	w1, #0x0
  916ea8: f9401c00     	ldr	x0, [x0, #0x38]
  916eac: 1a9fc421     	csinc	w1, w1, wzr, gt
  916eb0: 4e040400     	dup	v0.4s, v0.s[0]
  916eb4: 6b01005f     	cmp	w2, w1
  916eb8: 1a81d042     	csel	w2, w2, w1, le
  916ebc: b8647800     	ldr	w0, [x0, x4, lsl #2]
  916ec0: 8b22d062     	add	x2, x3, w2, sxtw #4
  916ec4: 4e0c1c00     	mov	v0.s[1], w0
  916ec8: b9400841     	ldr	w1, [x2, #0x8]
  916ecc: b9400c40     	ldr	w0, [x2, #0xc]
  916ed0: 4e141c20     	mov	v0.s[2], w1
  916ed4: 4e1c1c00     	mov	v0.s[3], w0
  916ed8: 9e660000     	fmov	x0, d0
  916edc: 9eae0001     	fmov	x1, v0.d[1]
  916ee0: d65f03c0     	ret
  916ee4: 3dc00060     	ldr	q0, [x3]
  916ee8: 9e660000     	fmov	x0, d0
  916eec: 9eae0001     	fmov	x1, v0.d[1]
  916ef0: d65f03c0     	ret
  916ef4: d503201f     	nop
