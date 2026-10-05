    b0e8: b9401003     	ldr	w3, [x0, #0x10]
    b0ec: 52802fe4     	mov	w4, #0x17f              // =383
    b0f0: 721e1065     	ands	w5, w3, #0x7c
    b0f4: 0a040064     	and	w4, w3, w4
    b0f8: 54000241     	b.ne	0xb140 <pthread_mutex_timedlock+0xdc0>
    b0fc: aa0003e2     	mov	x2, x0
    b100: 2a0103e6     	mov	w6, w1
    b104: 35000204     	cbnz	w4, 0xb144 <pthread_mutex_timedlock+0xdc4>
    b108: b900085f     	str	wzr, [x2, #0x8]
    b10c: 35000126     	cbnz	w6, 0xb130 <pthread_mutex_timedlock+0xdb0>
    b110: 52800001     	mov	w1, #0x0                // =0
    b114: 885f7c40     	ldxr	w0, [x2]
    b118: 8804fc41     	stlxr	w4, w1, [x2]
    b11c: 35ffffc4     	cbnz	w4, 0xb114 <pthread_mutex_timedlock+0xd94>
    b120: 7100041f     	cmp	w0, #0x1
    b124: 5400030c     	b.gt	0xb184 <pthread_mutex_timedlock+0xe04>
    b128: 2a0503e0     	mov	w0, w5
    b12c: d65f03c0     	ret
    b130: b9400c40     	ldr	w0, [x2, #0xc]
    b134: 51000400     	sub	w0, w0, #0x1
    b138: b9000c40     	str	w0, [x2, #0xc]
    b13c: 17fffff5     	b	0xb110 <pthread_mutex_timedlock+0xd90>
    b140: 17fffede     	b	0xacb8 <pthread_mutex_timedlock+0x938>
    b144: 7104009f     	cmp	w4, #0x100
    b148: 54000321     	b.ne	0xb1ac <pthread_mutex_timedlock+0xe2c>
    b14c: 885f7c41     	ldxr	w1, [x2]
    b150: 8804fc45     	stlxr	w4, w5, [x2]
    b154: 35ffffc4     	cbnz	w4, 0xb14c <pthread_mutex_timedlock+0xdcc>
    b158: 7100043f     	cmp	w1, #0x1
    b15c: 54fffe6d     	b.le	0xb128 <pthread_mutex_timedlock+0xda8>
    b160: 12190061     	and	w1, w3, #0x80
    b164: 52801022     	mov	w2, #0x81               // =129
    b168: 4a020021     	eor	w1, w1, w2
    b16c: d2800003     	mov	x3, #0x0                // =0
    b170: d2800022     	mov	x2, #0x1                // =1
    b174: d2800c48     	mov	x8, #0x62               // =98
    b178: 93407c21     	sxtw	x1, w1
    b17c: d4000001     	svc	#0
    b180: 17ffffea     	b	0xb128 <pthread_mutex_timedlock+0xda8>
    b184: 12190063     	and	w3, w3, #0x80
    b188: 52801021     	mov	w1, #0x81               // =129
    b18c: 4a010061     	eor	w1, w3, w1
    b190: aa0203e0     	mov	x0, x2
    b194: d2800003     	mov	x3, #0x0                // =0
    b198: d2800022     	mov	x2, #0x1                // =1
    b19c: 93407c21     	sxtw	x1, w1
    b1a0: d2800c48     	mov	x8, #0x62               // =98
    b1a4: d4000001     	svc	#0
    b1a8: 17ffffe0     	b	0xb128 <pthread_mutex_timedlock+0xda8>
    b1ac: 12001861     	and	w1, w3, #0x7f
    b1b0: 7100043f     	cmp	w1, #0x1
    b1b4: 54000181     	b.ne	0xb1e4 <pthread_mutex_timedlock+0xe64>
    b1b8: d53bd040     	mrs	x0, TPIDR_EL0
    b1bc: b9400844     	ldr	w4, [x2, #0x8]
    b1c0: d11c0000     	sub	x0, x0, #0x700
    b1c4: b940d000     	ldr	w0, [x0, #0xd0]
    b1c8: 6b00009f     	cmp	w4, w0
    b1cc: 54000241     	b.ne	0xb214 <pthread_mutex_timedlock+0xe94>
    b1d0: b9400440     	ldr	w0, [x2, #0x4]
    b1d4: 51000400     	sub	w0, w0, #0x1
    b1d8: b9000440     	str	w0, [x2, #0x4]
    b1dc: 35fffa60     	cbnz	w0, 0xb128 <pthread_mutex_timedlock+0xda8>
    b1e0: 17ffffca     	b	0xb108 <pthread_mutex_timedlock+0xd88>
    b1e4: 71000c3f     	cmp	w1, #0x3
    b1e8: 54fff900     	b.eq	0xb108 <pthread_mutex_timedlock+0xd88>
    b1ec: 7100089f     	cmp	w4, #0x2
    b1f0: 54000161     	b.ne	0xb21c <pthread_mutex_timedlock+0xe9c>
    b1f4: d53bd040     	mrs	x0, TPIDR_EL0
    b1f8: b9400841     	ldr	w1, [x2, #0x8]
    b1fc: d11c0000     	sub	x0, x0, #0x700
    b200: b940d000     	ldr	w0, [x0, #0xd0]
    b204: 6b00003f     	cmp	w1, w0
    b208: 54000061     	b.ne	0xb214 <pthread_mutex_timedlock+0xe94>
    b20c: b9400040     	ldr	w0, [x2]
    b210: 35fff7c0     	cbnz	w0, 0xb108 <pthread_mutex_timedlock+0xd88>
    b214: 52800025     	mov	w5, #0x1                // =1
    b218: 17ffffc4     	b	0xb128 <pthread_mutex_timedlock+0xda8>
    b21c: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
    b220: b0000043     	adrp	x3, 0x14000
    b224: b0000041     	adrp	x1, 0x14000
    b228: 910003fd     	mov	x29, sp
    b22c: b0000040     	adrp	x0, 0x14000
    b230: 91044063     	add	x3, x3, #0x110
    b234: 91034021     	add	x1, x1, #0xd0
    b238: 52800a82     	mov	w2, #0x54               // =84
    b23c: 9103a000     	add	x0, x0, #0xe8
    b240: 97ffea94     	bl	0x5c90 <__assert_fail@plt>
    b244: d503201f     	nop
    b248: 52800021     	mov	w1, #0x1                // =1
    b24c: 17ffffa7     	b	0xb0e8 <pthread_mutex_timedlock+0xd68>
