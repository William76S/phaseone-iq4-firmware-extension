  7d92b8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7d92bc: aa0303e7     	mov	x7, x3
  7d92c0: aa0503e3     	mov	x3, x5
  7d92c4: 910003fd     	mov	x29, sp
  7d92c8: a90153f3     	stp	x19, x20, [sp, #0x10]
  7d92cc: aa0003f3     	mov	x19, x0
  7d92d0: 9140e274     	add	x20, x19, #0x38, lsl #12 // =0x38000
  7d92d4: f90013f5     	str	x21, [sp, #0x20]
  7d92d8: b0002d60     	adrp	x0, 0xd86000
  7d92dc: 911c2000     	add	x0, x0, #0x708
  7d92e0: a9001a60     	stp	x0, x6, [x19]
  7d92e4: 91028294     	add	x20, x20, #0xa0
  7d92e8: a9010a61     	stp	x1, x2, [x19, #0x10]
  7d92ec: aa0703e1     	mov	x1, x7
  7d92f0: aa0403e2     	mov	x2, x4
  7d92f4: 91418a75     	add	x21, x19, #0x62, lsl #12 // =0x62000
  7d92f8: aa1403e0     	mov	x0, x20
  7d92fc: 913042b5     	add	x21, x21, #0xc10
  7d9300: 97ffb70f     	bl	0x7c6f3c
  7d9304: aa1503e0     	mov	x0, x21
  7d9308: 9401311a     	bl	0x825770
  7d930c: 91418a60     	add	x0, x19, #0x62, lsl #12 // =0x62000
  7d9310: b0002d61     	adrp	x1, 0xd86000
  7d9314: 52800002     	mov	w2, #0x0                // =0
  7d9318: 911ce021     	add	x1, x1, #0x738
  7d931c: 9130a000     	add	x0, x0, #0xc28
  7d9320: 97fce33f     	bl	0x71201c
  7d9324: 9140e261     	add	x1, x19, #0x38, lsl #12 // =0x38000
  7d9328: 91418265     	add	x5, x19, #0x60, lsl #12 // =0x60000
  7d932c: 91028020     	add	x0, x1, #0xa0
  7d9330: 91008262     	add	x2, x19, #0x20
  7d9334: 9140a004     	add	x4, x0, #0x28, lsl #12  // =0x28000
  7d9338: 91403003     	add	x3, x0, #0xc, lsl #12   // =0xc000
  7d933c: f915eca2     	str	x2, [x5, #0x2bd8]
  7d9340: 91405673     	add	x19, x19, #0x15, lsl #12 // =0x15000
  7d9344: f912bc22     	str	x2, [x1, #0x2578]
  7d9348: 91018273     	add	x19, x19, #0x60
  7d934c: f9159493     	str	x19, [x4, #0x2b28]
  7d9350: b92aec7f     	str	wzr, [x3, #0x2aec]
  7d9354: f912c033     	str	x19, [x1, #0x2580]
  7d9358: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7d935c: f94013f5     	ldr	x21, [sp, #0x20]
  7d9360: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7d9364: d65f03c0     	ret
  7d9368: aa0003f3     	mov	x19, x0
  7d936c: 14000004     	b	0x7d937c
  7d9370: aa0003f3     	mov	x19, x0
  7d9374: aa1503e0     	mov	x0, x21
  7d9378: 9401310f     	bl	0x8257b4
  7d937c: aa1403e0     	mov	x0, x20
  7d9380: 97ffff58     	bl	0x7d90e0
  7d9384: aa1303e0     	mov	x0, x19
  7d9388: 97f0c4f2     	bl	0x40a750
  7d938c: d503201f     	nop
  7d9390: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7d9394: 900010c1     	adrp	x1, 0x9f1000
  7d9398: 9137c021     	add	x1, x1, #0xdf0
  7d939c: 910003fd     	mov	x29, sp
  7d93a0: a90153f3     	stp	x19, x20, [sp, #0x10]
  7d93a4: aa0003f3     	mov	x19, x0
  7d93a8: 91418a62     	add	x2, x19, #0x62, lsl #12 // =0x62000
  7d93ac: 91300042     	add	x2, x2, #0xc00
  7d93b0: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7d93b4: b0002d60     	adrp	x0, 0xd86000
  7d93b8: 911c2000     	add	x0, x0, #0x708
  7d93bc: f9000260     	str	x0, [x19]
  7d93c0: f9001441     	str	x1, [x2, #0x28]
  7d93c4: 91418a60     	add	x0, x19, #0x62, lsl #12 // =0x62000
  7d93c8: 9130a000     	add	x0, x0, #0xc28
  7d93cc: 9140e275     	add	x21, x19, #0x38, lsl #12 // =0x38000
  7d93d0: 97fce09b     	bl	0x71163c
  7d93d4: 910282b5     	add	x21, x21, #0xa0
  7d93d8: 91418a60     	add	x0, x19, #0x62, lsl #12 // =0x62000
  7d93dc: 91411274     	add	x20, x19, #0x44, lsl #12 // =0x44000
  7d93e0: 91304000     	add	x0, x0, #0xc10
  7d93e4: 940130f4     	bl	0x8257b4
  7d93e8: d29bb401     	mov	x1, #0xdda0             // =56736
  7d93ec: 8b0102a0     	add	x0, x21, x1
  7d93f0: 91410a76     	add	x22, x19, #0x42, lsl #12 // =0x42000
  7d93f4: 91398294     	add	x20, x20, #0xe60
  7d93f8: 940001c6     	bl	0x7d9b10
  7d93fc: 911982d6     	add	x22, x22, #0x660
  7d9400: d29a0b02     	mov	x2, #0xd058             // =53336
  7d9404: 8b0202a0     	add	x0, x21, x2
  7d9408: 940001c2     	bl	0x7d9b10
  7d940c: d503201f     	nop
  7d9410: f9400281     	ldr	x1, [x20]
  7d9414: aa1403e0     	mov	x0, x20
  7d9418: d100a294     	sub	x20, x20, #0x28
  7d941c: f9400021     	ldr	x1, [x1]
  7d9420: d63f0020     	blr	x1
  7d9424: eb16029f     	cmp	x20, x22
  7d9428: 54ffff41     	b.ne	0x7d9410
  7d942c: 91410a74     	add	x20, x19, #0x42, lsl #12 // =0x42000
  7d9430: 9140fe76     	add	x22, x19, #0x3f, lsl #12 // =0x3f000
  7d9434: 911a0294     	add	x20, x20, #0x680
  7d9438: 913a02d6     	add	x22, x22, #0xe80
  7d943c: d503201f     	nop
  7d9440: f85d8e81     	ldr	x1, [x20, #-0x28]!
  7d9444: aa1403e0     	mov	x0, x20
  7d9448: f9400021     	ldr	x1, [x1]
  7d944c: d63f0020     	blr	x1
  7d9450: eb1402df     	cmp	x22, x20
  7d9454: 54ffff61     	b.ne	0x7d9440
  7d9458: 9140fe74     	add	x20, x19, #0x3f, lsl #12 // =0x3f000
  7d945c: 9140f673     	add	x19, x19, #0x3d, lsl #12 // =0x3d000
  7d9460: 91394294     	add	x20, x20, #0xe50
  7d9464: 91194273     	add	x19, x19, #0x650
  7d9468: f9400281     	ldr	x1, [x20]
  7d946c: aa1403e0     	mov	x0, x20
  7d9470: d100a294     	sub	x20, x20, #0x28
  7d9474: f9400021     	ldr	x1, [x1]
  7d9478: d63f0020     	blr	x1
  7d947c: eb13029f     	cmp	x20, x19
  7d9480: 54ffff41     	b.ne	0x7d9468
  7d9484: d2849f00     	mov	x0, #0x24f8             // =9464
  7d9488: 8b0002a0     	add	x0, x21, x0
  7d948c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7d9490: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7d9494: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7d9498: 17ff9c26     	b	0x7c0530
  7d949c: d503201f     	nop
