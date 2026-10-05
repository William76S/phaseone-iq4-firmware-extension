    9328: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
    932c: 910003fd     	mov	x29, sp
    9330: a90153f3     	stp	x19, x20, [sp, #0x10]
    9334: aa0003f3     	mov	x19, x0
    9338: b4000761     	cbz	x1, 0x9424 <pthread_mutex_init+0xfc>
    933c: b9400020     	ldr	w0, [x1]
    9340: aa0103f4     	mov	x20, x1
    9344: 72040402     	ands	w2, w0, #0x30000000
    9348: 54000120     	b.eq	0x936c <pthread_mutex_init+0x44>
    934c: 52a20001     	mov	w1, #0x10000000         // =268435456
    9350: 6b01005f     	cmp	w2, w1
    9354: 54000501     	b.ne	0x93f4 <pthread_mutex_init+0xcc>
    9358: 90000124     	adrp	x4, 0x2d000
    935c: b9432c80     	ldr	w0, [x4, #0x32c]
    9360: 7100001f     	cmp	w0, #0x0
    9364: 54000840     	b.eq	0x946c <pthread_mutex_init+0x144>
    9368: 5400048b     	b.lt	0x93f8 <pthread_mutex_init+0xd0>
    936c: a9007e7f     	stp	xzr, xzr, [x19]
    9370: a9017e7f     	stp	xzr, xzr, [x19, #0x10]
    9374: a9027e7f     	stp	xzr, xzr, [x19, #0x20]
    9378: b9400280     	ldr	w0, [x20]
    937c: 12006c01     	and	w1, w0, #0xfffffff
    9380: 12040402     	and	w2, w0, #0x30000000
    9384: 12084c21     	and	w1, w1, #0xff000fff
    9388: 36f00040     	tbz	w0, #0x1e, 0x9390 <pthread_mutex_init+0x68>
    938c: 321c0021     	orr	w1, w1, #0x10
    9390: b9001261     	str	w1, [x19, #0x10]
    9394: 52a20001     	mov	w1, #0x10000000         // =268435456
    9398: 6b01005f     	cmp	w2, w1
    939c: 54000360     	b.eq	0x9408 <pthread_mutex_init+0xe0>
    93a0: 52a40001     	mov	w1, #0x20000000         // =536870912
    93a4: 6b01005f     	cmp	w2, w1
    93a8: 54000141     	b.ne	0x93d0 <pthread_mutex_init+0xa8>
    93ac: b9401261     	ldr	w1, [x19, #0x10]
    93b0: a9025bf5     	stp	x21, x22, [sp, #0x20]
    93b4: d34c5c15     	ubfx	x21, x0, #12, #12
    93b8: 321a0021     	orr	w1, w1, #0x40
    93bc: b9001261     	str	w1, [x19, #0x10]
    93c0: 34000415     	cbz	w21, 0x9440 <pthread_mutex_init+0x118>
    93c4: 530d32b5     	lsl	w21, w21, #19
    93c8: b9000275     	str	w21, [x19]
    93cc: a9425bf5     	ldp	x21, x22, [sp, #0x20]
    93d0: 7202041f     	tst	w0, #0xc0000000
    93d4: 52800000     	mov	w0, #0x0                // =0
    93d8: 54000080     	b.eq	0x93e8 <pthread_mutex_init+0xc0>
    93dc: b9401261     	ldr	w1, [x19, #0x10]
    93e0: 32190021     	orr	w1, w1, #0x80
    93e4: b9001261     	str	w1, [x19, #0x10]
    93e8: a94153f3     	ldp	x19, x20, [sp, #0x10]
    93ec: a8c47bfd     	ldp	x29, x30, [sp], #0x40
    93f0: d65f03c0     	ret
    93f4: 36f7fbc0     	tbz	w0, #0x1e, 0x936c <pthread_mutex_init+0x44>
    93f8: 52800be0     	mov	w0, #0x5f               // =95
    93fc: a94153f3     	ldp	x19, x20, [sp, #0x10]
    9400: a8c47bfd     	ldp	x29, x30, [sp], #0x40
    9404: d65f03c0     	ret
    9408: b9401261     	ldr	w1, [x19, #0x10]
    940c: 7202041f     	tst	w0, #0xc0000000
    9410: 52800000     	mov	w0, #0x0                // =0
    9414: 321b0021     	orr	w1, w1, #0x20
    9418: b9001261     	str	w1, [x19, #0x10]
    941c: 54fffe01     	b.ne	0x93dc <pthread_mutex_init+0xb4>
    9420: 17fffff2     	b	0x93e8 <pthread_mutex_init+0xc0>
    9424: a9007e7f     	stp	xzr, xzr, [x19]
    9428: 52800000     	mov	w0, #0x0                // =0
    942c: a9017e7f     	stp	xzr, xzr, [x19, #0x10]
    9430: a9027e7f     	stp	xzr, xzr, [x19, #0x20]
    9434: a94153f3     	ldp	x19, x20, [sp, #0x10]
    9438: a8c47bfd     	ldp	x29, x30, [sp], #0x40
    943c: d65f03c0     	ret
    9440: 90000116     	adrp	x22, 0x29000
    9444: 910b72c1     	add	x1, x22, #0x2dc
    9448: b9400021     	ldr	w1, [x1]
    944c: 3100043f     	cmn	w1, #0x1
    9450: 540002a0     	b.eq	0x94a4 <pthread_mutex_init+0x17c>
    9454: 910b72d6     	add	x22, x22, #0x2dc
    9458: b94002c1     	ldr	w1, [x22]
    945c: 7100003f     	cmp	w1, #0x0
    9460: 54fffb4d     	b.le	0x93c8 <pthread_mutex_init+0xa0>
    9464: b94002d5     	ldr	w21, [x22]
    9468: 17ffffd7     	b	0x93c4 <pthread_mutex_init+0x9c>
    946c: 9100f3e0     	add	x0, sp, #0x3c
    9470: d28000e1     	mov	x1, #0x7                // =7
    9474: d2800002     	mov	x2, #0x0                // =0
    9478: d2800003     	mov	x3, #0x0                // =0
    947c: d2800c48     	mov	x8, #0x62               // =98
    9480: b9003fff     	str	wzr, [sp, #0x3c]
    9484: d4000001     	svc	#0
    9488: 3140041f     	cmn	w0, #0x1, lsl #12       // =0x1000
    948c: 540001a9     	b.ls	0x94c0 <pthread_mutex_init+0x198>
    9490: 3100981f     	cmn	w0, #0x26
    9494: 540000e0     	b.eq	0x94b0 <pthread_mutex_init+0x188>
    9498: 52800020     	mov	w0, #0x1                // =1
    949c: b9032c80     	str	w0, [x4, #0x32c]
    94a0: 17ffffb3     	b	0x936c <pthread_mutex_init+0x44>
    94a4: 94002485     	bl	0x126b8 <pthread_mutexattr_setprioceiling+0xb8>
    94a8: b9400280     	ldr	w0, [x20]
    94ac: 17ffffea     	b	0x9454 <pthread_mutex_init+0x12c>
    94b0: 12800000     	mov	w0, #-0x1               // =-1
    94b4: b9032c80     	str	w0, [x4, #0x32c]
    94b8: 52800be0     	mov	w0, #0x5f               // =95
    94bc: 17ffffd0     	b	0x93fc <pthread_mutex_init+0xd4>
    94c0: d0000043     	adrp	x3, 0x13000 <pthread_getname_np+0xb8>
    94c4: d0000041     	adrp	x1, 0x13000 <pthread_getname_np+0xb8>
    94c8: d0000040     	adrp	x0, 0x13000 <pthread_getname_np+0xb8>
    94cc: 913b0063     	add	x3, x3, #0xec0
    94d0: 913a0021     	add	x1, x1, #0xe80
    94d4: 528005e2     	mov	w2, #0x2f               // =47
    94d8: 913a6000     	add	x0, x0, #0xe98
    94dc: a9025bf5     	stp	x21, x22, [sp, #0x20]
    94e0: 97fff1ec     	bl	0x5c90 <__assert_fail@plt>
