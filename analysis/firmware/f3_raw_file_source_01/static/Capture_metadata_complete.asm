  7c9000: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  7c9004: 910003fd     	mov	x29, sp
  7c9008: f9000bf3     	str	x19, [sp, #0x10]
  7c900c: f90017e0     	str	x0, [sp, #0x28]
  7c9010: f94017e0     	ldr	x0, [sp, #0x28]
  7c9014: 94001365     	bl	0x7cdda8
  7c9018: 90002de0     	adrp	x0, 0xd85000
  7c901c: 91210000     	add	x0, x0, #0x840
  7c9020: 97ff64e0     	bl	0x7a23a0
  7c9024: 2a0003e1     	mov	w1, w0
  7c9028: f94017e0     	ldr	x0, [sp, #0x28]
  7c902c: b9008001     	str	w1, [x0, #0x80]
  7c9030: 90002de0     	adrp	x0, 0xd85000
  7c9034: 91210000     	add	x0, x0, #0x840
  7c9038: 97ff64da     	bl	0x7a23a0
  7c903c: 2a0003e1     	mov	w1, w0
  7c9040: f94017e0     	ldr	x0, [sp, #0x28]
  7c9044: b900a401     	str	w1, [x0, #0xa4]
  7c9048: 90002de0     	adrp	x0, 0xd85000
  7c904c: 91210000     	add	x0, x0, #0x840
  7c9050: 97ff64d4     	bl	0x7a23a0
  7c9054: 2a0003e1     	mov	w1, w0
  7c9058: f94017e0     	ldr	x0, [sp, #0x28]
  7c905c: b900a801     	str	w1, [x0, #0xa8]
  7c9060: 7900afff     	strh	wzr, [sp, #0x56]
  7c9064: f94017e0     	ldr	x0, [sp, #0x28]
  7c9068: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c906c: b9503000     	ldr	w0, [x0, #0x1030]
  7c9070: 71000c1f     	cmp	w0, #0x3
  7c9074: 54004200     	b.eq	0x7c98b4
  7c9078: 71000c1f     	cmp	w0, #0x3
  7c907c: 540000cc     	b.gt	0x7c9094
  7c9080: 7100041f     	cmp	w0, #0x1
  7c9084: 5400b040     	b.eq	0x7ca68c
  7c9088: 7100081f     	cmp	w0, #0x2
  7c908c: 540000e0     	b.eq	0x7c90a8
  7c9090: 14000582     	b	0x7ca698
  7c9094: 7100101f     	cmp	w0, #0x4
  7c9098: 540035e0     	b.eq	0x7c9754
  7c909c: 7100181f     	cmp	w0, #0x6
  7c90a0: 54000f00     	b.eq	0x7c9280
  7c90a4: 1400057d     	b	0x7ca698
  7c90a8: f94017e1     	ldr	x1, [sp, #0x28]
  7c90ac: d2849f00     	mov	x0, #0x24f8             // =9464
  7c90b0: 8b000022     	add	x2, x1, x0
  7c90b4: f94017e1     	ldr	x1, [sp, #0x28]
  7c90b8: d29a0680     	mov	x0, #0xd034             // =53300
  7c90bc: 8b000020     	add	x0, x1, x0
  7c90c0: aa0003e1     	mov	x1, x0
  7c90c4: aa0203e0     	mov	x0, x2
  7c90c8: 97ffde2f     	bl	0x7c0984
  7c90cc: f94017e1     	ldr	x1, [sp, #0x28]
  7c90d0: d2849f00     	mov	x0, #0x24f8             // =9464
  7c90d4: 8b000022     	add	x2, x1, x0
  7c90d8: f94017e1     	ldr	x1, [sp, #0x28]
  7c90dc: d29a0680     	mov	x0, #0xd034             // =53300
  7c90e0: 8b000020     	add	x0, x1, x0
  7c90e4: aa0003e1     	mov	x1, x0
  7c90e8: aa0203e0     	mov	x0, x2
  7c90ec: 97fff640     	bl	0x7c69ec
  7c90f0: f94017e1     	ldr	x1, [sp, #0x28]
  7c90f4: d2849f00     	mov	x0, #0x24f8             // =9464
  7c90f8: 8b000020     	add	x0, x1, x0
  7c90fc: 97ffdee4     	bl	0x7c0c8c
  7c9100: 12001c00     	and	w0, w0, #0xff
  7c9104: 7100001f     	cmp	w0, #0x0
  7c9108: 540003c0     	b.eq	0x7c9180
  7c910c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9110: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9114: 8b000020     	add	x0, x1, x0
  7c9118: 91015be1     	add	x1, sp, #0x56
  7c911c: 97ffebca     	bl	0x7c4044
  7c9120: 12001c00     	and	w0, w0, #0xff
  7c9124: 7100001f     	cmp	w0, #0x0
  7c9128: 54000080     	b.eq	0x7c9138
  7c912c: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9130: 2a0003e1     	mov	w1, w0
  7c9134: 14000002     	b	0x7c913c
  7c9138: 52800001     	mov	w1, #0x0                // =0
  7c913c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9140: b9025c01     	str	w1, [x0, #0x25c]
  7c9144: f94017e1     	ldr	x1, [sp, #0x28]
  7c9148: d2849f00     	mov	x0, #0x24f8             // =9464
  7c914c: 8b000020     	add	x0, x1, x0
  7c9150: 91015be1     	add	x1, sp, #0x56
  7c9154: 97ffebd9     	bl	0x7c40b8
  7c9158: 12001c00     	and	w0, w0, #0xff
  7c915c: 7100001f     	cmp	w0, #0x0
  7c9160: 54000080     	b.eq	0x7c9170
  7c9164: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9168: 2a0003e1     	mov	w1, w0
  7c916c: 14000002     	b	0x7c9174
  7c9170: 52800001     	mov	w1, #0x0                // =0
  7c9174: f94017e0     	ldr	x0, [sp, #0x28]
  7c9178: b9026001     	str	w1, [x0, #0x260]
  7c917c: 14000005     	b	0x7c9190
  7c9180: f94017e0     	ldr	x0, [sp, #0x28]
  7c9184: b9025c1f     	str	wzr, [x0, #0x25c]
  7c9188: f94017e0     	ldr	x0, [sp, #0x28]
  7c918c: b902601f     	str	wzr, [x0, #0x260]
  7c9190: f94017e0     	ldr	x0, [sp, #0x28]
  7c9194: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c9198: 79606800     	ldrh	w0, [x0, #0x1034]
  7c919c: 2a0003e1     	mov	w1, w0
  7c91a0: f94017e0     	ldr	x0, [sp, #0x28]
  7c91a4: b9000001     	str	w1, [x0]
  7c91a8: f94017e0     	ldr	x0, [sp, #0x28]
  7c91ac: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c91b0: 79606c00     	ldrh	w0, [x0, #0x1036]
  7c91b4: 2a0003e1     	mov	w1, w0
  7c91b8: f94017e0     	ldr	x0, [sp, #0x28]
  7c91bc: b9000401     	str	w1, [x0, #0x4]
  7c91c0: f94017e0     	ldr	x0, [sp, #0x28]
  7c91c4: b900401f     	str	wzr, [x0, #0x40]
  7c91c8: f94017e1     	ldr	x1, [sp, #0x28]
  7c91cc: d2849f00     	mov	x0, #0x24f8             // =9464
  7c91d0: 8b000020     	add	x0, x1, x0
  7c91d4: 91015be1     	add	x1, sp, #0x56
  7c91d8: 97ffeb61     	bl	0x7c3f5c
  7c91dc: 12001c00     	and	w0, w0, #0xff
  7c91e0: 7100001f     	cmp	w0, #0x0
  7c91e4: 54000080     	b.eq	0x7c91f4
  7c91e8: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c91ec: 2a0003e1     	mov	w1, w0
  7c91f0: 14000002     	b	0x7c91f8
  7c91f4: 52800001     	mov	w1, #0x0                // =0
  7c91f8: f94017e0     	ldr	x0, [sp, #0x28]
  7c91fc: b9025401     	str	w1, [x0, #0x254]
  7c9200: f94017e1     	ldr	x1, [sp, #0x28]
  7c9204: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9208: 8b000020     	add	x0, x1, x0
  7c920c: 91015be1     	add	x1, sp, #0x56
  7c9210: 97ffeb70     	bl	0x7c3fd0
  7c9214: 12001c00     	and	w0, w0, #0xff
  7c9218: 7100001f     	cmp	w0, #0x0
  7c921c: 54000080     	b.eq	0x7c922c
  7c9220: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9224: 2a0003e1     	mov	w1, w0
  7c9228: 14000002     	b	0x7c9230
  7c922c: 52800001     	mov	w1, #0x0                // =0
  7c9230: f94017e0     	ldr	x0, [sp, #0x28]
  7c9234: b9025801     	str	w1, [x0, #0x258]
  7c9238: f94017e0     	ldr	x0, [sp, #0x28]
  7c923c: b900101f     	str	wzr, [x0, #0x10]
  7c9240: f94017e0     	ldr	x0, [sp, #0x28]
  7c9244: b900141f     	str	wzr, [x0, #0x14]
  7c9248: f94017e0     	ldr	x0, [sp, #0x28]
  7c924c: 91403400     	add	x0, x0, #0xd, lsl #12   // =0xd000
  7c9250: 39414000     	ldrb	w0, [x0, #0x50]
  7c9254: 7100001f     	cmp	w0, #0x0
  7c9258: 540000a0     	b.eq	0x7c926c
  7c925c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9260: 52800021     	mov	w1, #0x1                // =1
  7c9264: b9004801     	str	w1, [x0, #0x48]
  7c9268: 14000003     	b	0x7c9274
  7c926c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9270: b900481f     	str	wzr, [x0, #0x48]
  7c9274: f94017e0     	ldr	x0, [sp, #0x28]
  7c9278: 94000531     	bl	0x7ca73c
  7c927c: 14000507     	b	0x7ca698
  7c9280: f94017e1     	ldr	x1, [sp, #0x28]
  7c9284: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9288: 8b000022     	add	x2, x1, x0
  7c928c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9290: d29a0680     	mov	x0, #0xd034             // =53300
  7c9294: 8b000020     	add	x0, x1, x0
  7c9298: aa0003e1     	mov	x1, x0
  7c929c: aa0203e0     	mov	x0, x2
  7c92a0: 97ffddb9     	bl	0x7c0984
  7c92a4: f94017e1     	ldr	x1, [sp, #0x28]
  7c92a8: d2849f00     	mov	x0, #0x24f8             // =9464
  7c92ac: 8b000022     	add	x2, x1, x0
  7c92b0: f94017e1     	ldr	x1, [sp, #0x28]
  7c92b4: d29a0680     	mov	x0, #0xd034             // =53300
  7c92b8: 8b000020     	add	x0, x1, x0
  7c92bc: aa0003e1     	mov	x1, x0
  7c92c0: aa0203e0     	mov	x0, x2
  7c92c4: 97fff5ca     	bl	0x7c69ec
  7c92c8: f94017e1     	ldr	x1, [sp, #0x28]
  7c92cc: d2849f00     	mov	x0, #0x24f8             // =9464
  7c92d0: 8b000020     	add	x0, x1, x0
  7c92d4: 97ffde6e     	bl	0x7c0c8c
  7c92d8: 12001c00     	and	w0, w0, #0xff
  7c92dc: 7100001f     	cmp	w0, #0x0
  7c92e0: 540003c0     	b.eq	0x7c9358
  7c92e4: f94017e1     	ldr	x1, [sp, #0x28]
  7c92e8: d2849f00     	mov	x0, #0x24f8             // =9464
  7c92ec: 8b000020     	add	x0, x1, x0
  7c92f0: 91015be1     	add	x1, sp, #0x56
  7c92f4: 97ffeb54     	bl	0x7c4044
  7c92f8: 12001c00     	and	w0, w0, #0xff
  7c92fc: 7100001f     	cmp	w0, #0x0
  7c9300: 54000080     	b.eq	0x7c9310
  7c9304: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9308: 2a0003e1     	mov	w1, w0
  7c930c: 14000002     	b	0x7c9314
  7c9310: 52800001     	mov	w1, #0x0                // =0
  7c9314: f94017e0     	ldr	x0, [sp, #0x28]
  7c9318: b9025c01     	str	w1, [x0, #0x25c]
  7c931c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9320: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9324: 8b000020     	add	x0, x1, x0
  7c9328: 91015be1     	add	x1, sp, #0x56
  7c932c: 97ffeb63     	bl	0x7c40b8
  7c9330: 12001c00     	and	w0, w0, #0xff
  7c9334: 7100001f     	cmp	w0, #0x0
  7c9338: 54000080     	b.eq	0x7c9348
  7c933c: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9340: 2a0003e1     	mov	w1, w0
  7c9344: 14000002     	b	0x7c934c
  7c9348: 52800001     	mov	w1, #0x0                // =0
  7c934c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9350: b9026001     	str	w1, [x0, #0x260]
  7c9354: 14000005     	b	0x7c9368
  7c9358: f94017e0     	ldr	x0, [sp, #0x28]
  7c935c: b9025c1f     	str	wzr, [x0, #0x25c]
  7c9360: f94017e0     	ldr	x0, [sp, #0x28]
  7c9364: b902601f     	str	wzr, [x0, #0x260]
  7c9368: f94017e1     	ldr	x1, [sp, #0x28]
  7c936c: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9370: 8b000020     	add	x0, x1, x0
  7c9374: 91015be1     	add	x1, sp, #0x56
  7c9378: 97ffeaf9     	bl	0x7c3f5c
  7c937c: 12001c00     	and	w0, w0, #0xff
  7c9380: 7100001f     	cmp	w0, #0x0
  7c9384: 54000080     	b.eq	0x7c9394
  7c9388: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c938c: 2a0003e1     	mov	w1, w0
  7c9390: 14000002     	b	0x7c9398
  7c9394: 52800001     	mov	w1, #0x0                // =0
  7c9398: f94017e0     	ldr	x0, [sp, #0x28]
  7c939c: b9025401     	str	w1, [x0, #0x254]
  7c93a0: f94017e1     	ldr	x1, [sp, #0x28]
  7c93a4: d2849f00     	mov	x0, #0x24f8             // =9464
  7c93a8: 8b000020     	add	x0, x1, x0
  7c93ac: 91015be1     	add	x1, sp, #0x56
  7c93b0: 97ffeb08     	bl	0x7c3fd0
  7c93b4: 12001c00     	and	w0, w0, #0xff
  7c93b8: 7100001f     	cmp	w0, #0x0
  7c93bc: 54000080     	b.eq	0x7c93cc
  7c93c0: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c93c4: 2a0003e1     	mov	w1, w0
  7c93c8: 14000002     	b	0x7c93d0
  7c93cc: 52800001     	mov	w1, #0x0                // =0
  7c93d0: f94017e0     	ldr	x0, [sp, #0x28]
  7c93d4: b9025801     	str	w1, [x0, #0x258]
  7c93d8: f94017e1     	ldr	x1, [sp, #0x28]
  7c93dc: d2849f00     	mov	x0, #0x24f8             // =9464
  7c93e0: 8b000020     	add	x0, x1, x0
  7c93e4: 91015be1     	add	x1, sp, #0x56
  7c93e8: 97ffea40     	bl	0x7c3ce8
  7c93ec: 12001c00     	and	w0, w0, #0xff
  7c93f0: 7100001f     	cmp	w0, #0x0
  7c93f4: 54000080     	b.eq	0x7c9404
  7c93f8: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c93fc: 2a0003e1     	mov	w1, w0
  7c9400: 14000005     	b	0x7c9414
  7c9404: f94017e0     	ldr	x0, [sp, #0x28]
  7c9408: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c940c: 79606800     	ldrh	w0, [x0, #0x1034]
  7c9410: 2a0003e1     	mov	w1, w0
  7c9414: f94017e0     	ldr	x0, [sp, #0x28]
  7c9418: b9000001     	str	w1, [x0]
  7c941c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9420: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9424: 8b000020     	add	x0, x1, x0
  7c9428: 91015be1     	add	x1, sp, #0x56
  7c942c: 97ffea4c     	bl	0x7c3d5c
  7c9430: 12001c00     	and	w0, w0, #0xff
  7c9434: 7100001f     	cmp	w0, #0x0
  7c9438: 54000080     	b.eq	0x7c9448
  7c943c: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9440: 2a0003e1     	mov	w1, w0
  7c9444: 14000005     	b	0x7c9458
  7c9448: f94017e0     	ldr	x0, [sp, #0x28]
  7c944c: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c9450: 79606c00     	ldrh	w0, [x0, #0x1036]
  7c9454: 2a0003e1     	mov	w1, w0
  7c9458: f94017e0     	ldr	x0, [sp, #0x28]
  7c945c: b9000401     	str	w1, [x0, #0x4]
  7c9460: f94017e0     	ldr	x0, [sp, #0x28]
  7c9464: b900401f     	str	wzr, [x0, #0x40]
  7c9468: f94017e0     	ldr	x0, [sp, #0x28]
  7c946c: b9400001     	ldr	w1, [x0]
  7c9470: f94017e0     	ldr	x0, [sp, #0x28]
  7c9474: b9400400     	ldr	w0, [x0, #0x4]
  7c9478: 1b007c20     	mul	w0, w1, w0
  7c947c: 531f7801     	lsl	w1, w0, #1
  7c9480: f94017e0     	ldr	x0, [sp, #0x28]
  7c9484: b924cc01     	str	w1, [x0, #0x24cc]
  7c9488: f94017e0     	ldr	x0, [sp, #0x28]
  7c948c: b9400001     	ldr	w1, [x0]
  7c9490: f94017e0     	ldr	x0, [sp, #0x28]
  7c9494: b9400800     	ldr	w0, [x0, #0x8]
  7c9498: 4b000021     	sub	w1, w1, w0
  7c949c: f94017e0     	ldr	x0, [sp, #0x28]
  7c94a0: b9001001     	str	w1, [x0, #0x10]
  7c94a4: f94017e0     	ldr	x0, [sp, #0x28]
  7c94a8: b9400401     	ldr	w1, [x0, #0x4]
  7c94ac: f94017e0     	ldr	x0, [sp, #0x28]
  7c94b0: b9400c00     	ldr	w0, [x0, #0xc]
  7c94b4: 4b000021     	sub	w1, w1, w0
  7c94b8: f94017e0     	ldr	x0, [sp, #0x28]
  7c94bc: b9001401     	str	w1, [x0, #0x14]
  7c94c0: f94017e1     	ldr	x1, [sp, #0x28]
  7c94c4: d2849f00     	mov	x0, #0x24f8             // =9464
  7c94c8: 8b000025     	add	x5, x1, x0
  7c94cc: f94017e0     	ldr	x0, [sp, #0x28]
  7c94d0: 91002001     	add	x1, x0, #0x8
  7c94d4: f94017e0     	ldr	x0, [sp, #0x28]
  7c94d8: 91003002     	add	x2, x0, #0xc
  7c94dc: f94017e0     	ldr	x0, [sp, #0x28]
  7c94e0: 91004003     	add	x3, x0, #0x10
  7c94e4: f94017e0     	ldr	x0, [sp, #0x28]
  7c94e8: 91005000     	add	x0, x0, #0x14
  7c94ec: aa0003e4     	mov	x4, x0
  7c94f0: aa0503e0     	mov	x0, x5
  7c94f4: 97ffea37     	bl	0x7c3dd0
  7c94f8: f94017e0     	ldr	x0, [sp, #0x28]
  7c94fc: 91403400     	add	x0, x0, #0xd, lsl #12   // =0xd000
  7c9500: 39414000     	ldrb	w0, [x0, #0x50]
  7c9504: 7100001f     	cmp	w0, #0x0
  7c9508: 540000a0     	b.eq	0x7c951c
  7c950c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9510: 52800021     	mov	w1, #0x1                // =1
  7c9514: b9004801     	str	w1, [x0, #0x48]
  7c9518: 14000003     	b	0x7c9524
  7c951c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9520: b900481f     	str	wzr, [x0, #0x48]
  7c9524: f94017e1     	ldr	x1, [sp, #0x28]
  7c9528: d2849f00     	mov	x0, #0x24f8             // =9464
  7c952c: 8b000033     	add	x19, x1, x0
  7c9530: f94017e1     	ldr	x1, [sp, #0x28]
  7c9534: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9538: 8b000020     	add	x0, x1, x0
  7c953c: 94003b47     	bl	0x7d8258
  7c9540: 2a0003e2     	mov	w2, w0
  7c9544: 52802061     	mov	w1, #0x103              // =259
  7c9548: aa1303e0     	mov	x0, x19
  7c954c: 97ffe9c4     	bl	0x7c3c5c
  7c9550: f9002fe0     	str	x0, [sp, #0x58]
  7c9554: f9402fe0     	ldr	x0, [sp, #0x58]
  7c9558: f100001f     	cmp	x0, #0x0
  7c955c: 54000100     	b.eq	0x7c957c
  7c9560: f9402fe0     	ldr	x0, [sp, #0x58]
  7c9564: b9401800     	ldr	w0, [x0, #0x18]
  7c9568: 71001c1f     	cmp	w0, #0x7
  7c956c: 54000081     	b.ne	0x7c957c
  7c9570: f94017e0     	ldr	x0, [sp, #0x28]
  7c9574: 52800281     	mov	w1, #0x14               // =20
  7c9578: b9004001     	str	w1, [x0, #0x40]
  7c957c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9580: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9584: 8b000033     	add	x19, x1, x0
  7c9588: f94017e1     	ldr	x1, [sp, #0x28]
  7c958c: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9590: 8b000020     	add	x0, x1, x0
  7c9594: 94003b31     	bl	0x7d8258
  7c9598: 2a0003e2     	mov	w2, w0
  7c959c: 52802881     	mov	w1, #0x144              // =324
  7c95a0: aa1303e0     	mov	x0, x19
  7c95a4: 97ffe9ae     	bl	0x7c3c5c
  7c95a8: f9002fe0     	str	x0, [sp, #0x58]
  7c95ac: f9402fe0     	ldr	x0, [sp, #0x58]
  7c95b0: f100001f     	cmp	x0, #0x0
  7c95b4: 540000a0     	b.eq	0x7c95c8
  7c95b8: f9402fe0     	ldr	x0, [sp, #0x58]
  7c95bc: b9401401     	ldr	w1, [x0, #0x14]
  7c95c0: f94017e0     	ldr	x0, [sp, #0x28]
  7c95c4: b9029c01     	str	w1, [x0, #0x29c]
  7c95c8: f94017e1     	ldr	x1, [sp, #0x28]
  7c95cc: d2849f00     	mov	x0, #0x24f8             // =9464
  7c95d0: 8b000033     	add	x19, x1, x0
  7c95d4: f94017e1     	ldr	x1, [sp, #0x28]
  7c95d8: d2849f00     	mov	x0, #0x24f8             // =9464
  7c95dc: 8b000020     	add	x0, x1, x0
  7c95e0: 94003b1e     	bl	0x7d8258
  7c95e4: 2a0003e2     	mov	w2, w0
  7c95e8: 52802841     	mov	w1, #0x142              // =322
  7c95ec: aa1303e0     	mov	x0, x19
  7c95f0: 97ffe99b     	bl	0x7c3c5c
  7c95f4: f9002fe0     	str	x0, [sp, #0x58]
  7c95f8: f9402fe0     	ldr	x0, [sp, #0x58]
  7c95fc: f100001f     	cmp	x0, #0x0
  7c9600: 540000a0     	b.eq	0x7c9614
  7c9604: f9402fe0     	ldr	x0, [sp, #0x58]
  7c9608: b9401801     	ldr	w1, [x0, #0x18]
  7c960c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9610: b902a001     	str	w1, [x0, #0x2a0]
  7c9614: f94017e1     	ldr	x1, [sp, #0x28]
  7c9618: d2849f00     	mov	x0, #0x24f8             // =9464
  7c961c: 8b000033     	add	x19, x1, x0
  7c9620: f94017e1     	ldr	x1, [sp, #0x28]
  7c9624: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9628: 8b000020     	add	x0, x1, x0
  7c962c: 94003b0b     	bl	0x7d8258
  7c9630: 2a0003e2     	mov	w2, w0
  7c9634: 52802861     	mov	w1, #0x143              // =323
  7c9638: aa1303e0     	mov	x0, x19
  7c963c: 97ffe988     	bl	0x7c3c5c
  7c9640: f9002fe0     	str	x0, [sp, #0x58]
  7c9644: f9402fe0     	ldr	x0, [sp, #0x58]
  7c9648: f100001f     	cmp	x0, #0x0
  7c964c: 540000a0     	b.eq	0x7c9660
  7c9650: f9402fe0     	ldr	x0, [sp, #0x58]
  7c9654: b9401801     	ldr	w1, [x0, #0x18]
  7c9658: f94017e0     	ldr	x0, [sp, #0x28]
  7c965c: b902a401     	str	w1, [x0, #0x2a4]
  7c9660: f94017e1     	ldr	x1, [sp, #0x28]
  7c9664: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9668: 8b000020     	add	x0, x1, x0
  7c966c: 12873ae1     	mov	w1, #-0x39d8            // =-14808
  7c9670: 97ffe92f     	bl	0x7c3b2c
  7c9674: f9002fe0     	str	x0, [sp, #0x58]
  7c9678: f9402fe0     	ldr	x0, [sp, #0x58]
  7c967c: f100001f     	cmp	x0, #0x0
  7c9680: 54000640     	b.eq	0x7c9748
  7c9684: f9402fe0     	ldr	x0, [sp, #0x58]
  7c9688: b9401400     	ldr	w0, [x0, #0x14]
  7c968c: 71000c1f     	cmp	w0, #0x3
  7c9690: 540005c1     	b.ne	0x7c9748
  7c9694: f9402fe0     	ldr	x0, [sp, #0x58]
  7c9698: 79402400     	ldrh	w0, [x0, #0x12]
  7c969c: 7100141f     	cmp	w0, #0x5
  7c96a0: 54000541     	b.ne	0x7c9748
  7c96a4: f94017e1     	ldr	x1, [sp, #0x28]
  7c96a8: d2849f00     	mov	x0, #0x24f8             // =9464
  7c96ac: 8b000020     	add	x0, x1, x0
  7c96b0: 9100e3e1     	add	x1, sp, #0x38
  7c96b4: aa0103e2     	mov	x2, x1
  7c96b8: f9402fe1     	ldr	x1, [sp, #0x58]
  7c96bc: 97fff4d5     	bl	0x7c6a10
  7c96c0: 12001c00     	and	w0, w0, #0xff
  7c96c4: 7100001f     	cmp	w0, #0x0
  7c96c8: 540002e0     	b.eq	0x7c9724
  7c96cc: b9403fe0     	ldr	w0, [sp, #0x3c]
  7c96d0: 1e230001     	ucvtf	s1, w0
  7c96d4: b9403be0     	ldr	w0, [sp, #0x38]
  7c96d8: 1e230000     	ucvtf	s0, w0
  7c96dc: 1e201820     	fdiv	s0, s1, s0
  7c96e0: f94017e0     	ldr	x0, [sp, #0x28]
  7c96e4: bd004c00     	str	s0, [x0, #0x4c]
  7c96e8: b94047e0     	ldr	w0, [sp, #0x44]
  7c96ec: 1e230001     	ucvtf	s1, w0
  7c96f0: b94043e0     	ldr	w0, [sp, #0x40]
  7c96f4: 1e230000     	ucvtf	s0, w0
  7c96f8: 1e201820     	fdiv	s0, s1, s0
  7c96fc: f94017e0     	ldr	x0, [sp, #0x28]
  7c9700: bd005000     	str	s0, [x0, #0x50]
  7c9704: b9404fe0     	ldr	w0, [sp, #0x4c]
  7c9708: 1e230001     	ucvtf	s1, w0
  7c970c: b9404be0     	ldr	w0, [sp, #0x48]
  7c9710: 1e230000     	ucvtf	s0, w0
  7c9714: 1e201820     	fdiv	s0, s1, s0
  7c9718: f94017e0     	ldr	x0, [sp, #0x28]
  7c971c: bd005400     	str	s0, [x0, #0x54]
  7c9720: 1400000a     	b	0x7c9748
  7c9724: f94017e0     	ldr	x0, [sp, #0x28]
  7c9728: 1e2e1000     	fmov	s0, #1.00000000
  7c972c: bd004c00     	str	s0, [x0, #0x4c]
  7c9730: f94017e0     	ldr	x0, [sp, #0x28]
  7c9734: 1e2e1000     	fmov	s0, #1.00000000
  7c9738: bd005000     	str	s0, [x0, #0x50]
  7c973c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9740: 1e2e1000     	fmov	s0, #1.00000000
  7c9744: bd005400     	str	s0, [x0, #0x54]
  7c9748: f94017e0     	ldr	x0, [sp, #0x28]
  7c974c: 940003fc     	bl	0x7ca73c
  7c9750: 140003d2     	b	0x7ca698
  7c9754: f94017e1     	ldr	x1, [sp, #0x28]
  7c9758: d2849f00     	mov	x0, #0x24f8             // =9464
  7c975c: 8b000022     	add	x2, x1, x0
  7c9760: f94017e1     	ldr	x1, [sp, #0x28]
  7c9764: d29a0680     	mov	x0, #0xd034             // =53300
  7c9768: 8b000020     	add	x0, x1, x0
  7c976c: aa0003e1     	mov	x1, x0
  7c9770: aa0203e0     	mov	x0, x2
  7c9774: 97ffdc84     	bl	0x7c0984
  7c9778: f94017e1     	ldr	x1, [sp, #0x28]
  7c977c: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9780: 8b000022     	add	x2, x1, x0
  7c9784: f94017e1     	ldr	x1, [sp, #0x28]
  7c9788: d29a0680     	mov	x0, #0xd034             // =53300
  7c978c: 8b000020     	add	x0, x1, x0
  7c9790: aa0003e1     	mov	x1, x0
  7c9794: aa0203e0     	mov	x0, x2
  7c9798: 97fff495     	bl	0x7c69ec
  7c979c: f94017e1     	ldr	x1, [sp, #0x28]
  7c97a0: d2849f00     	mov	x0, #0x24f8             // =9464
  7c97a4: 8b000020     	add	x0, x1, x0
  7c97a8: 97ffdd39     	bl	0x7c0c8c
  7c97ac: 12001c00     	and	w0, w0, #0xff
  7c97b0: 7100001f     	cmp	w0, #0x0
  7c97b4: 540003c0     	b.eq	0x7c982c
  7c97b8: f94017e1     	ldr	x1, [sp, #0x28]
  7c97bc: d2849f00     	mov	x0, #0x24f8             // =9464
  7c97c0: 8b000020     	add	x0, x1, x0
  7c97c4: 91015be1     	add	x1, sp, #0x56
  7c97c8: 97ffea1f     	bl	0x7c4044
  7c97cc: 12001c00     	and	w0, w0, #0xff
  7c97d0: 7100001f     	cmp	w0, #0x0
  7c97d4: 54000080     	b.eq	0x7c97e4
  7c97d8: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c97dc: 2a0003e1     	mov	w1, w0
  7c97e0: 14000002     	b	0x7c97e8
  7c97e4: 52800001     	mov	w1, #0x0                // =0
  7c97e8: f94017e0     	ldr	x0, [sp, #0x28]
  7c97ec: b9025c01     	str	w1, [x0, #0x25c]
  7c97f0: f94017e1     	ldr	x1, [sp, #0x28]
  7c97f4: d2849f00     	mov	x0, #0x24f8             // =9464
  7c97f8: 8b000020     	add	x0, x1, x0
  7c97fc: 91015be1     	add	x1, sp, #0x56
  7c9800: 97ffea2e     	bl	0x7c40b8
  7c9804: 12001c00     	and	w0, w0, #0xff
  7c9808: 7100001f     	cmp	w0, #0x0
  7c980c: 54000080     	b.eq	0x7c981c
  7c9810: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9814: 2a0003e1     	mov	w1, w0
  7c9818: 14000002     	b	0x7c9820
  7c981c: 52800001     	mov	w1, #0x0                // =0
  7c9820: f94017e0     	ldr	x0, [sp, #0x28]
  7c9824: b9026001     	str	w1, [x0, #0x260]
  7c9828: 14000005     	b	0x7c983c
  7c982c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9830: b9025c1f     	str	wzr, [x0, #0x25c]
  7c9834: f94017e0     	ldr	x0, [sp, #0x28]
  7c9838: b902601f     	str	wzr, [x0, #0x260]
  7c983c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9840: d2849f00     	mov	x0, #0x24f8             // =9464
  7c9844: 8b000020     	add	x0, x1, x0
  7c9848: 91015be1     	add	x1, sp, #0x56
  7c984c: 97ffe9c4     	bl	0x7c3f5c
  7c9850: 12001c00     	and	w0, w0, #0xff
  7c9854: 7100001f     	cmp	w0, #0x0
  7c9858: 54000080     	b.eq	0x7c9868
  7c985c: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9860: 2a0003e1     	mov	w1, w0
  7c9864: 14000002     	b	0x7c986c
  7c9868: 52800001     	mov	w1, #0x0                // =0
  7c986c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9870: b9025401     	str	w1, [x0, #0x254]
  7c9874: f94017e1     	ldr	x1, [sp, #0x28]
  7c9878: d2849f00     	mov	x0, #0x24f8             // =9464
  7c987c: 8b000020     	add	x0, x1, x0
  7c9880: 91015be1     	add	x1, sp, #0x56
  7c9884: 97ffe9d3     	bl	0x7c3fd0
  7c9888: 12001c00     	and	w0, w0, #0xff
  7c988c: 7100001f     	cmp	w0, #0x0
  7c9890: 54000080     	b.eq	0x7c98a0
  7c9894: 7940afe0     	ldrh	w0, [sp, #0x56]
  7c9898: 2a0003e1     	mov	w1, w0
  7c989c: 14000002     	b	0x7c98a4
  7c98a0: 52800001     	mov	w1, #0x0                // =0
  7c98a4: f94017e0     	ldr	x0, [sp, #0x28]
  7c98a8: b9025801     	str	w1, [x0, #0x258]
  7c98ac: f94017e0     	ldr	x0, [sp, #0x28]
  7c98b0: 940003a3     	bl	0x7ca73c
  7c98b4: f94017e1     	ldr	x1, [sp, #0x28]
  7c98b8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c98bc: 8b000020     	add	x0, x1, x0
  7c98c0: 528021e1     	mov	w1, #0x10f              // =271
  7c98c4: 94004589     	bl	0x7daee8
  7c98c8: 2a0003e1     	mov	w1, w0
  7c98cc: f94017e0     	ldr	x0, [sp, #0x28]
  7c98d0: b924cc01     	str	w1, [x0, #0x24cc]
  7c98d4: f94017e1     	ldr	x1, [sp, #0x28]
  7c98d8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c98dc: 8b000020     	add	x0, x1, x0
  7c98e0: f94017e1     	ldr	x1, [sp, #0x28]
  7c98e4: aa0103e2     	mov	x2, x1
  7c98e8: 52802101     	mov	w1, #0x108              // =264
  7c98ec: 9400454b     	bl	0x7dae18
  7c98f0: f94017e1     	ldr	x1, [sp, #0x28]
  7c98f4: d29a0b00     	mov	x0, #0xd058             // =53336
  7c98f8: 8b000023     	add	x3, x1, x0
  7c98fc: f94017e0     	ldr	x0, [sp, #0x28]
  7c9900: 91001000     	add	x0, x0, #0x4
  7c9904: aa0003e2     	mov	x2, x0
  7c9908: 52802121     	mov	w1, #0x109              // =265
  7c990c: aa0303e0     	mov	x0, x3
  7c9910: 94004542     	bl	0x7dae18
  7c9914: f94017e1     	ldr	x1, [sp, #0x28]
  7c9918: d29a0b00     	mov	x0, #0xd058             // =53336
  7c991c: 8b000023     	add	x3, x1, x0
  7c9920: f94017e0     	ldr	x0, [sp, #0x28]
  7c9924: 91002000     	add	x0, x0, #0x8
  7c9928: aa0003e2     	mov	x2, x0
  7c992c: 52802141     	mov	w1, #0x10a              // =266
  7c9930: aa0303e0     	mov	x0, x3
  7c9934: 94004539     	bl	0x7dae18
  7c9938: f94017e1     	ldr	x1, [sp, #0x28]
  7c993c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9940: 8b000023     	add	x3, x1, x0
  7c9944: f94017e0     	ldr	x0, [sp, #0x28]
  7c9948: 91003000     	add	x0, x0, #0xc
  7c994c: aa0003e2     	mov	x2, x0
  7c9950: 52802161     	mov	w1, #0x10b              // =267
  7c9954: aa0303e0     	mov	x0, x3
  7c9958: 94004530     	bl	0x7dae18
  7c995c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9960: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9964: 8b000023     	add	x3, x1, x0
  7c9968: f94017e0     	ldr	x0, [sp, #0x28]
  7c996c: 91004000     	add	x0, x0, #0x10
  7c9970: aa0003e2     	mov	x2, x0
  7c9974: 52802181     	mov	w1, #0x10c              // =268
  7c9978: aa0303e0     	mov	x0, x3
  7c997c: 94004527     	bl	0x7dae18
  7c9980: f94017e1     	ldr	x1, [sp, #0x28]
  7c9984: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9988: 8b000023     	add	x3, x1, x0
  7c998c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9990: 91005000     	add	x0, x0, #0x14
  7c9994: aa0003e2     	mov	x2, x0
  7c9998: 528021a1     	mov	w1, #0x10d              // =269
  7c999c: aa0303e0     	mov	x0, x3
  7c99a0: 9400451e     	bl	0x7dae18
  7c99a4: f94017e1     	ldr	x1, [sp, #0x28]
  7c99a8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c99ac: 8b000023     	add	x3, x1, x0
  7c99b0: f94017e0     	ldr	x0, [sp, #0x28]
  7c99b4: 91011000     	add	x0, x0, #0x44
  7c99b8: aa0003e2     	mov	x2, x0
  7c99bc: 52802241     	mov	w1, #0x112              // =274
  7c99c0: aa0303e0     	mov	x0, x3
  7c99c4: 94004515     	bl	0x7dae18
  7c99c8: f94017e1     	ldr	x1, [sp, #0x28]
  7c99cc: d29a0b00     	mov	x0, #0xd058             // =53336
  7c99d0: 8b000023     	add	x3, x1, x0
  7c99d4: f94017e0     	ldr	x0, [sp, #0x28]
  7c99d8: 91010000     	add	x0, x0, #0x40
  7c99dc: aa0003e2     	mov	x2, x0
  7c99e0: 528021c1     	mov	w1, #0x10e              // =270
  7c99e4: aa0303e0     	mov	x0, x3
  7c99e8: 9400450c     	bl	0x7dae18
  7c99ec: f94017e1     	ldr	x1, [sp, #0x28]
  7c99f0: d29a0b00     	mov	x0, #0xd058             // =53336
  7c99f4: 8b000023     	add	x3, x1, x0
  7c99f8: f94017e0     	ldr	x0, [sp, #0x28]
  7c99fc: 9101f000     	add	x0, x0, #0x7c
  7c9a00: aa0003e2     	mov	x2, x0
  7c9a04: 52802061     	mov	w1, #0x103              // =259
  7c9a08: aa0303e0     	mov	x0, x3
  7c9a0c: 94004503     	bl	0x7dae18
  7c9a10: f94017e1     	ldr	x1, [sp, #0x28]
  7c9a14: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9a18: 8b000023     	add	x3, x1, x0
  7c9a1c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9a20: 91020000     	add	x0, x0, #0x80
  7c9a24: aa0003e2     	mov	x2, x0
  7c9a28: 52806001     	mov	w1, #0x300              // =768
  7c9a2c: aa0303e0     	mov	x0, x3
  7c9a30: 940044fa     	bl	0x7dae18
  7c9a34: f94017e1     	ldr	x1, [sp, #0x28]
  7c9a38: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9a3c: 8b000023     	add	x3, x1, x0
  7c9a40: f94017e0     	ldr	x0, [sp, #0x28]
  7c9a44: 91029000     	add	x0, x0, #0xa4
  7c9a48: aa0003e2     	mov	x2, x0
  7c9a4c: 528060c1     	mov	w1, #0x306              // =774
  7c9a50: aa0303e0     	mov	x0, x3
  7c9a54: 940044f1     	bl	0x7dae18
  7c9a58: f94017e1     	ldr	x1, [sp, #0x28]
  7c9a5c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9a60: 8b000023     	add	x3, x1, x0
  7c9a64: f94017e0     	ldr	x0, [sp, #0x28]
  7c9a68: 9102a000     	add	x0, x0, #0xa8
  7c9a6c: aa0003e2     	mov	x2, x0
  7c9a70: 528060e1     	mov	w1, #0x307              // =775
  7c9a74: aa0303e0     	mov	x0, x3
  7c9a78: 940044e8     	bl	0x7dae18
  7c9a7c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9a80: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9a84: 8b000023     	add	x3, x1, x0
  7c9a88: f94017e0     	ldr	x0, [sp, #0x28]
  7c9a8c: 9102b000     	add	x0, x0, #0xac
  7c9a90: aa0003e2     	mov	x2, x0
  7c9a94: 52802261     	mov	w1, #0x113              // =275
  7c9a98: aa0303e0     	mov	x0, x3
  7c9a9c: 940044df     	bl	0x7dae18
  7c9aa0: f94017e1     	ldr	x1, [sp, #0x28]
  7c9aa4: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9aa8: 8b000023     	add	x3, x1, x0
  7c9aac: f94017e0     	ldr	x0, [sp, #0x28]
  7c9ab0: 9102c000     	add	x0, x0, #0xb0
  7c9ab4: aa0003e2     	mov	x2, x0
  7c9ab8: 52802021     	mov	w1, #0x101              // =257
  7c9abc: aa0303e0     	mov	x0, x3
  7c9ac0: 940044d6     	bl	0x7dae18
  7c9ac4: f94017e1     	ldr	x1, [sp, #0x28]
  7c9ac8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9acc: 8b000023     	add	x3, x1, x0
  7c9ad0: f94017e0     	ldr	x0, [sp, #0x28]
  7c9ad4: 9102d000     	add	x0, x0, #0xb4
  7c9ad8: aa0003e2     	mov	x2, x0
  7c9adc: 52804d81     	mov	w1, #0x26c              // =620
  7c9ae0: aa0303e0     	mov	x0, x3
  7c9ae4: 940044cd     	bl	0x7dae18
  7c9ae8: f94017e1     	ldr	x1, [sp, #0x28]
  7c9aec: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9af0: 8b000023     	add	x3, x1, x0
  7c9af4: f94017e0     	ldr	x0, [sp, #0x28]
  7c9af8: 91084000     	add	x0, x0, #0x210
  7c9afc: aa0003e2     	mov	x2, x0
  7c9b00: 52802081     	mov	w1, #0x104              // =260
  7c9b04: aa0303e0     	mov	x0, x3
  7c9b08: 940044c4     	bl	0x7dae18
  7c9b0c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9b10: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9b14: 8b000023     	add	x3, x1, x0
  7c9b18: f94017e0     	ldr	x0, [sp, #0x28]
  7c9b1c: 91085000     	add	x0, x0, #0x214
  7c9b20: aa0003e2     	mov	x2, x0
  7c9b24: 528020a1     	mov	w1, #0x105              // =261
  7c9b28: aa0303e0     	mov	x0, x3
  7c9b2c: 940044bb     	bl	0x7dae18
  7c9b30: f94017e1     	ldr	x1, [sp, #0x28]
  7c9b34: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9b38: 8b000023     	add	x3, x1, x0
  7c9b3c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9b40: 91081000     	add	x0, x0, #0x204
  7c9b44: aa0003e2     	mov	x2, x0
  7c9b48: 52804161     	mov	w1, #0x20b              // =523
  7c9b4c: aa0303e0     	mov	x0, x3
  7c9b50: 940044b2     	bl	0x7dae18
  7c9b54: f94017e1     	ldr	x1, [sp, #0x28]
  7c9b58: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9b5c: 8b000023     	add	x3, x1, x0
  7c9b60: f94017e0     	ldr	x0, [sp, #0x28]
  7c9b64: 91082000     	add	x0, x0, #0x208
  7c9b68: aa0003e2     	mov	x2, x0
  7c9b6c: 52804181     	mov	w1, #0x20c              // =524
  7c9b70: aa0303e0     	mov	x0, x3
  7c9b74: 940044a9     	bl	0x7dae18
  7c9b78: f94017e1     	ldr	x1, [sp, #0x28]
  7c9b7c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9b80: 8b000023     	add	x3, x1, x0
  7c9b84: f94017e0     	ldr	x0, [sp, #0x28]
  7c9b88: 9108b000     	add	x0, x0, #0x22c
  7c9b8c: aa0003e2     	mov	x2, x0
  7c9b90: 528043c1     	mov	w1, #0x21e              // =542
  7c9b94: aa0303e0     	mov	x0, x3
  7c9b98: 940044a0     	bl	0x7dae18
  7c9b9c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9ba0: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9ba4: 8b000023     	add	x3, x1, x0
  7c9ba8: f94017e0     	ldr	x0, [sp, #0x28]
  7c9bac: 9108c000     	add	x0, x0, #0x230
  7c9bb0: aa0003e2     	mov	x2, x0
  7c9bb4: 52804401     	mov	w1, #0x220              // =544
  7c9bb8: aa0303e0     	mov	x0, x3
  7c9bbc: 94004497     	bl	0x7dae18
  7c9bc0: f94017e1     	ldr	x1, [sp, #0x28]
  7c9bc4: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9bc8: 8b000023     	add	x3, x1, x0
  7c9bcc: f94017e0     	ldr	x0, [sp, #0x28]
  7c9bd0: 91099000     	add	x0, x0, #0x264
  7c9bd4: aa0003e2     	mov	x2, x0
  7c9bd8: 52804421     	mov	w1, #0x221              // =545
  7c9bdc: aa0303e0     	mov	x0, x3
  7c9be0: 940044a8     	bl	0x7dae80
  7c9be4: f94017e1     	ldr	x1, [sp, #0x28]
  7c9be8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9bec: 8b000023     	add	x3, x1, x0
  7c9bf0: f94017e0     	ldr	x0, [sp, #0x28]
  7c9bf4: 9109a000     	add	x0, x0, #0x268
  7c9bf8: aa0003e2     	mov	x2, x0
  7c9bfc: 52804881     	mov	w1, #0x244              // =580
  7c9c00: aa0303e0     	mov	x0, x3
  7c9c04: 9400449f     	bl	0x7dae80
  7c9c08: f94017e1     	ldr	x1, [sp, #0x28]
  7c9c0c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9c10: 8b000023     	add	x3, x1, x0
  7c9c14: f94017e0     	ldr	x0, [sp, #0x28]
  7c9c18: 9109b000     	add	x0, x0, #0x26c
  7c9c1c: aa0003e2     	mov	x2, x0
  7c9c20: 52804541     	mov	w1, #0x22a              // =554
  7c9c24: aa0303e0     	mov	x0, x3
  7c9c28: 94004496     	bl	0x7dae80
  7c9c2c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9c30: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9c34: 8b000023     	add	x3, x1, x0
  7c9c38: f94017e0     	ldr	x0, [sp, #0x28]
  7c9c3c: 9109c000     	add	x0, x0, #0x270
  7c9c40: aa0003e2     	mov	x2, x0
  7c9c44: 52804561     	mov	w1, #0x22b              // =555
  7c9c48: aa0303e0     	mov	x0, x3
  7c9c4c: 9400448d     	bl	0x7dae80
  7c9c50: f94017e1     	ldr	x1, [sp, #0x28]
  7c9c54: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9c58: 8b000023     	add	x3, x1, x0
  7c9c5c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9c60: 9109d000     	add	x0, x0, #0x274
  7c9c64: aa0003e2     	mov	x2, x0
  7c9c68: 52804581     	mov	w1, #0x22c              // =556
  7c9c6c: aa0303e0     	mov	x0, x3
  7c9c70: 94004484     	bl	0x7dae80
  7c9c74: f94017e1     	ldr	x1, [sp, #0x28]
  7c9c78: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9c7c: 8b000023     	add	x3, x1, x0
  7c9c80: f94017e0     	ldr	x0, [sp, #0x28]
  7c9c84: 91080000     	add	x0, x0, #0x200
  7c9c88: aa0003e2     	mov	x2, x0
  7c9c8c: 528043a1     	mov	w1, #0x21d              // =541
  7c9c90: aa0303e0     	mov	x0, x3
  7c9c94: 94004461     	bl	0x7dae18
  7c9c98: f94017e1     	ldr	x1, [sp, #0x28]
  7c9c9c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9ca0: 8b000023     	add	x3, x1, x0
  7c9ca4: f94017e0     	ldr	x0, [sp, #0x28]
  7c9ca8: 9108d000     	add	x0, x0, #0x234
  7c9cac: aa0003e2     	mov	x2, x0
  7c9cb0: 52804441     	mov	w1, #0x222              // =546
  7c9cb4: aa0303e0     	mov	x0, x3
  7c9cb8: 94004458     	bl	0x7dae18
  7c9cbc: f94017e1     	ldr	x1, [sp, #0x28]
  7c9cc0: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9cc4: 8b000023     	add	x3, x1, x0
  7c9cc8: f94017e0     	ldr	x0, [sp, #0x28]
  7c9ccc: 9108e000     	add	x0, x0, #0x238
  7c9cd0: aa0003e2     	mov	x2, x0
  7c9cd4: 52804481     	mov	w1, #0x224              // =548
  7c9cd8: aa0303e0     	mov	x0, x3
  7c9cdc: 9400444f     	bl	0x7dae18
  7c9ce0: f94017e1     	ldr	x1, [sp, #0x28]
  7c9ce4: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9ce8: 8b000023     	add	x3, x1, x0
  7c9cec: f94017e0     	ldr	x0, [sp, #0x28]
  7c9cf0: 910a3000     	add	x0, x0, #0x28c
  7c9cf4: aa0003e2     	mov	x2, x0
  7c9cf8: 52804841     	mov	w1, #0x242              // =578
  7c9cfc: aa0303e0     	mov	x0, x3
  7c9d00: 94004446     	bl	0x7dae18
  7c9d04: f94017e1     	ldr	x1, [sp, #0x28]
  7c9d08: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9d0c: 8b000023     	add	x3, x1, x0
  7c9d10: f94017e0     	ldr	x0, [sp, #0x28]
  7c9d14: 910a4000     	add	x0, x0, #0x290
  7c9d18: aa0003e2     	mov	x2, x0
  7c9d1c: 52804861     	mov	w1, #0x243              // =579
  7c9d20: aa0303e0     	mov	x0, x3
  7c9d24: 9400443d     	bl	0x7dae18
  7c9d28: f94017e0     	ldr	x0, [sp, #0x28]
  7c9d2c: b9428c01     	ldr	w1, [x0, #0x28c]
  7c9d30: f94017e0     	ldr	x0, [sp, #0x28]
  7c9d34: b9029401     	str	w1, [x0, #0x294]
  7c9d38: f94017e0     	ldr	x0, [sp, #0x28]
  7c9d3c: b9429001     	ldr	w1, [x0, #0x290]
  7c9d40: f94017e0     	ldr	x0, [sp, #0x28]
  7c9d44: b9029801     	str	w1, [x0, #0x298]
  7c9d48: f94017e1     	ldr	x1, [sp, #0x28]
  7c9d4c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9d50: 8b000023     	add	x3, x1, x0
  7c9d54: f94017e0     	ldr	x0, [sp, #0x28]
  7c9d58: 910a5000     	add	x0, x0, #0x294
  7c9d5c: aa0003e2     	mov	x2, x0
  7c9d60: 52804aa1     	mov	w1, #0x255              // =597
  7c9d64: aa0303e0     	mov	x0, x3
  7c9d68: 9400442c     	bl	0x7dae18
  7c9d6c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9d70: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9d74: 8b000023     	add	x3, x1, x0
  7c9d78: f94017e0     	ldr	x0, [sp, #0x28]
  7c9d7c: 910a6000     	add	x0, x0, #0x298
  7c9d80: aa0003e2     	mov	x2, x0
  7c9d84: 52804ac1     	mov	w1, #0x256              // =598
  7c9d88: aa0303e0     	mov	x0, x3
  7c9d8c: 94004423     	bl	0x7dae18
  7c9d90: f94017e1     	ldr	x1, [sp, #0x28]
  7c9d94: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9d98: 8b000023     	add	x3, x1, x0
  7c9d9c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9da0: 910aa000     	add	x0, x0, #0x2a8
  7c9da4: aa0003e2     	mov	x2, x0
  7c9da8: 528049c1     	mov	w1, #0x24e              // =590
  7c9dac: aa0303e0     	mov	x0, x3
  7c9db0: 9400441a     	bl	0x7dae18
  7c9db4: f94017e1     	ldr	x1, [sp, #0x28]
  7c9db8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9dbc: 8b000023     	add	x3, x1, x0
  7c9dc0: f94017e0     	ldr	x0, [sp, #0x28]
  7c9dc4: 910ac000     	add	x0, x0, #0x2b0
  7c9dc8: aa0003e2     	mov	x2, x0
  7c9dcc: 52804d21     	mov	w1, #0x269              // =617
  7c9dd0: aa0303e0     	mov	x0, x3
  7c9dd4: 9400442b     	bl	0x7dae80
  7c9dd8: f94017e1     	ldr	x1, [sp, #0x28]
  7c9ddc: d29bb400     	mov	x0, #0xdda0             // =56736
  7c9de0: 8b000023     	add	x3, x1, x0
  7c9de4: f94017e0     	ldr	x0, [sp, #0x28]
  7c9de8: 910ac000     	add	x0, x0, #0x2b0
  7c9dec: aa0003e2     	mov	x2, x0
  7c9df0: 52804d21     	mov	w1, #0x269              // =617
  7c9df4: aa0303e0     	mov	x0, x3
  7c9df8: 94004422     	bl	0x7dae80
  7c9dfc: f94017e1     	ldr	x1, [sp, #0x28]
  7c9e00: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9e04: 8b000023     	add	x3, x1, x0
  7c9e08: f94017e0     	ldr	x0, [sp, #0x28]
  7c9e0c: 910ad000     	add	x0, x0, #0x2b4
  7c9e10: aa0003e2     	mov	x2, x0
  7c9e14: 52804d61     	mov	w1, #0x26b              // =619
  7c9e18: aa0303e0     	mov	x0, x3
  7c9e1c: 940043ff     	bl	0x7dae18
  7c9e20: f94017e1     	ldr	x1, [sp, #0x28]
  7c9e24: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9e28: 8b000023     	add	x3, x1, x0
  7c9e2c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9e30: 910ae000     	add	x0, x0, #0x2b8
  7c9e34: aa0003e2     	mov	x2, x0
  7c9e38: 528049e1     	mov	w1, #0x24f              // =591
  7c9e3c: aa0303e0     	mov	x0, x3
  7c9e40: 940043f6     	bl	0x7dae18
  7c9e44: f94017e1     	ldr	x1, [sp, #0x28]
  7c9e48: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9e4c: 8b000023     	add	x3, x1, x0
  7c9e50: f94017e0     	ldr	x0, [sp, #0x28]
  7c9e54: 910af000     	add	x0, x0, #0x2bc
  7c9e58: aa0003e2     	mov	x2, x0
  7c9e5c: 52804a21     	mov	w1, #0x251              // =593
  7c9e60: aa0303e0     	mov	x0, x3
  7c9e64: 940043ed     	bl	0x7dae18
  7c9e68: f94017e1     	ldr	x1, [sp, #0x28]
  7c9e6c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9e70: 8b000023     	add	x3, x1, x0
  7c9e74: f94017e0     	ldr	x0, [sp, #0x28]
  7c9e78: 910b0000     	add	x0, x0, #0x2c0
  7c9e7c: aa0003e2     	mov	x2, x0
  7c9e80: 5280a8e1     	mov	w1, #0x547              // =1351
  7c9e84: aa0303e0     	mov	x0, x3
  7c9e88: 940043e4     	bl	0x7dae18
  7c9e8c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9e90: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9e94: 8b000023     	add	x3, x1, x0
  7c9e98: f94017e0     	ldr	x0, [sp, #0x28]
  7c9e9c: 910b1000     	add	x0, x0, #0x2c4
  7c9ea0: aa0003e2     	mov	x2, x0
  7c9ea4: 52804a41     	mov	w1, #0x252              // =594
  7c9ea8: aa0303e0     	mov	x0, x3
  7c9eac: 940043f5     	bl	0x7dae80
  7c9eb0: f94017e1     	ldr	x1, [sp, #0x28]
  7c9eb4: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9eb8: 8b000023     	add	x3, x1, x0
  7c9ebc: f94017e0     	ldr	x0, [sp, #0x28]
  7c9ec0: 91087000     	add	x0, x0, #0x21c
  7c9ec4: aa0003e2     	mov	x2, x0
  7c9ec8: 528044e1     	mov	w1, #0x227              // =551
  7c9ecc: aa0303e0     	mov	x0, x3
  7c9ed0: 940043d2     	bl	0x7dae18
  7c9ed4: f94017e1     	ldr	x1, [sp, #0x28]
  7c9ed8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9edc: 8b000023     	add	x3, x1, x0
  7c9ee0: f94017e0     	ldr	x0, [sp, #0x28]
  7c9ee4: 91088000     	add	x0, x0, #0x220
  7c9ee8: aa0003e2     	mov	x2, x0
  7c9eec: 52804cc1     	mov	w1, #0x266              // =614
  7c9ef0: aa0303e0     	mov	x0, x3
  7c9ef4: 940043c9     	bl	0x7dae18
  7c9ef8: f94017e1     	ldr	x1, [sp, #0x28]
  7c9efc: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9f00: 8b000023     	add	x3, x1, x0
  7c9f04: f94017e0     	ldr	x0, [sp, #0x28]
  7c9f08: 91089000     	add	x0, x0, #0x224
  7c9f0c: aa0003e2     	mov	x2, x0
  7c9f10: 52808a01     	mov	w1, #0x450              // =1104
  7c9f14: aa0303e0     	mov	x0, x3
  7c9f18: 940043c0     	bl	0x7dae18
  7c9f1c: f94017e1     	ldr	x1, [sp, #0x28]
  7c9f20: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9f24: 8b000023     	add	x3, x1, x0
  7c9f28: f94017e0     	ldr	x0, [sp, #0x28]
  7c9f2c: 91009000     	add	x0, x0, #0x24
  7c9f30: aa0003e2     	mov	x2, x0
  7c9f34: 528048c1     	mov	w1, #0x246              // =582
  7c9f38: aa0303e0     	mov	x0, x3
  7c9f3c: 940043b7     	bl	0x7dae18
  7c9f40: f94017e1     	ldr	x1, [sp, #0x28]
  7c9f44: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9f48: 8b000023     	add	x3, x1, x0
  7c9f4c: f94017e0     	ldr	x0, [sp, #0x28]
  7c9f50: 9100a000     	add	x0, x0, #0x28
  7c9f54: aa0003e2     	mov	x2, x0
  7c9f58: 52804901     	mov	w1, #0x248              // =584
  7c9f5c: aa0303e0     	mov	x0, x3
  7c9f60: 940043ae     	bl	0x7dae18
  7c9f64: f94017e1     	ldr	x1, [sp, #0x28]
  7c9f68: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9f6c: 8b000023     	add	x3, x1, x0
  7c9f70: f94017e0     	ldr	x0, [sp, #0x28]
  7c9f74: 9100b000     	add	x0, x0, #0x2c
  7c9f78: aa0003e2     	mov	x2, x0
  7c9f7c: 528048e1     	mov	w1, #0x247              // =583
  7c9f80: aa0303e0     	mov	x0, x3
  7c9f84: 940043a5     	bl	0x7dae18
  7c9f88: f94017e1     	ldr	x1, [sp, #0x28]
  7c9f8c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9f90: 8b000023     	add	x3, x1, x0
  7c9f94: f94017e0     	ldr	x0, [sp, #0x28]
  7c9f98: 9100c000     	add	x0, x0, #0x30
  7c9f9c: aa0003e2     	mov	x2, x0
  7c9fa0: 52804921     	mov	w1, #0x249              // =585
  7c9fa4: aa0303e0     	mov	x0, x3
  7c9fa8: 9400439c     	bl	0x7dae18
  7c9fac: f94017e1     	ldr	x1, [sp, #0x28]
  7c9fb0: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9fb4: 8b000023     	add	x3, x1, x0
  7c9fb8: f94017e0     	ldr	x0, [sp, #0x28]
  7c9fbc: 9102f000     	add	x0, x0, #0xbc
  7c9fc0: aa0003e2     	mov	x2, x0
  7c9fc4: 52808021     	mov	w1, #0x401              // =1025
  7c9fc8: aa0303e0     	mov	x0, x3
  7c9fcc: 940043ad     	bl	0x7dae80
  7c9fd0: f94017e1     	ldr	x1, [sp, #0x28]
  7c9fd4: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9fd8: 8b000023     	add	x3, x1, x0
  7c9fdc: f94017e0     	ldr	x0, [sp, #0x28]
  7c9fe0: 9107a000     	add	x0, x0, #0x1e8
  7c9fe4: aa0003e2     	mov	x2, x0
  7c9fe8: 52808281     	mov	w1, #0x414              // =1044
  7c9fec: aa0303e0     	mov	x0, x3
  7c9ff0: 940043a4     	bl	0x7dae80
  7c9ff4: f94017e1     	ldr	x1, [sp, #0x28]
  7c9ff8: d29a0b00     	mov	x0, #0xd058             // =53336
  7c9ffc: 8b000023     	add	x3, x1, x0
  7ca000: f94017e0     	ldr	x0, [sp, #0x28]
  7ca004: 9107b000     	add	x0, x0, #0x1ec
  7ca008: aa0003e2     	mov	x2, x0
  7ca00c: 528082a1     	mov	w1, #0x415              // =1045
  7ca010: aa0303e0     	mov	x0, x3
  7ca014: 9400439b     	bl	0x7dae80
  7ca018: f94017e1     	ldr	x1, [sp, #0x28]
  7ca01c: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca020: 8b000023     	add	x3, x1, x0
  7ca024: f94017e0     	ldr	x0, [sp, #0x28]
  7ca028: 91030000     	add	x0, x0, #0xc0
  7ca02c: aa0003e2     	mov	x2, x0
  7ca030: 52808061     	mov	w1, #0x403              // =1027
  7ca034: aa0303e0     	mov	x0, x3
  7ca038: 94004392     	bl	0x7dae80
  7ca03c: f94017e1     	ldr	x1, [sp, #0x28]
  7ca040: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca044: 8b000023     	add	x3, x1, x0
  7ca048: f94017e0     	ldr	x0, [sp, #0x28]
  7ca04c: 9107c000     	add	x0, x0, #0x1f0
  7ca050: aa0003e2     	mov	x2, x0
  7ca054: 528082c1     	mov	w1, #0x416              // =1046
  7ca058: aa0303e0     	mov	x0, x3
  7ca05c: 94004389     	bl	0x7dae80
  7ca060: f94017e1     	ldr	x1, [sp, #0x28]
  7ca064: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca068: 8b000023     	add	x3, x1, x0
  7ca06c: f94017e0     	ldr	x0, [sp, #0x28]
  7ca070: 9107d000     	add	x0, x0, #0x1f4
  7ca074: aa0003e2     	mov	x2, x0
  7ca078: 528082e1     	mov	w1, #0x417              // =1047
  7ca07c: aa0303e0     	mov	x0, x3
  7ca080: 94004380     	bl	0x7dae80
  7ca084: f94017e1     	ldr	x1, [sp, #0x28]
  7ca088: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca08c: 8b000023     	add	x3, x1, x0
  7ca090: f94017e0     	ldr	x0, [sp, #0x28]
  7ca094: 91032000     	add	x0, x0, #0xc8
  7ca098: aa0003e2     	mov	x2, x0
  7ca09c: 52804bc1     	mov	w1, #0x25e              // =606
  7ca0a0: aa0303e0     	mov	x0, x3
  7ca0a4: 94004377     	bl	0x7dae80
  7ca0a8: f94017e1     	ldr	x1, [sp, #0x28]
  7ca0ac: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca0b0: 8b000023     	add	x3, x1, x0
  7ca0b4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca0b8: 91033000     	add	x0, x0, #0xcc
  7ca0bc: aa0003e2     	mov	x2, x0
  7ca0c0: 5280a701     	mov	w1, #0x538              // =1336
  7ca0c4: aa0303e0     	mov	x0, x3
  7ca0c8: 9400436e     	bl	0x7dae80
  7ca0cc: f94017e1     	ldr	x1, [sp, #0x28]
  7ca0d0: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca0d4: 8b000023     	add	x3, x1, x0
  7ca0d8: f94017e0     	ldr	x0, [sp, #0x28]
  7ca0dc: 91034000     	add	x0, x0, #0xd0
  7ca0e0: aa0003e2     	mov	x2, x0
  7ca0e4: 5280a721     	mov	w1, #0x539              // =1337
  7ca0e8: aa0303e0     	mov	x0, x3
  7ca0ec: 94004365     	bl	0x7dae80
  7ca0f0: f94017e1     	ldr	x1, [sp, #0x28]
  7ca0f4: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca0f8: 8b000023     	add	x3, x1, x0
  7ca0fc: f94017e0     	ldr	x0, [sp, #0x28]
  7ca100: 91035000     	add	x0, x0, #0xd4
  7ca104: aa0003e2     	mov	x2, x0
  7ca108: 5280a741     	mov	w1, #0x53a              // =1338
  7ca10c: aa0303e0     	mov	x0, x3
  7ca110: 9400435c     	bl	0x7dae80
  7ca114: f94017e1     	ldr	x1, [sp, #0x28]
  7ca118: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca11c: 8b000023     	add	x3, x1, x0
  7ca120: f94017e0     	ldr	x0, [sp, #0x28]
  7ca124: 91044000     	add	x0, x0, #0x110
  7ca128: aa0003e2     	mov	x2, x0
  7ca12c: 52808221     	mov	w1, #0x411              // =1041
  7ca130: aa0303e0     	mov	x0, x3
  7ca134: 94004339     	bl	0x7dae18
  7ca138: f94017e1     	ldr	x1, [sp, #0x28]
  7ca13c: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca140: 8b000023     	add	x3, x1, x0
  7ca144: f94017e0     	ldr	x0, [sp, #0x28]
  7ca148: 9104f000     	add	x0, x0, #0x13c
  7ca14c: aa0003e2     	mov	x2, x0
  7ca150: 52808261     	mov	w1, #0x413              // =1043
  7ca154: aa0303e0     	mov	x0, x3
  7ca158: 94004330     	bl	0x7dae18
  7ca15c: f94017e1     	ldr	x1, [sp, #0x28]
  7ca160: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca164: 8b000023     	add	x3, x1, x0
  7ca168: f94017e0     	ldr	x0, [sp, #0x28]
  7ca16c: 91068000     	add	x0, x0, #0x1a0
  7ca170: aa0003e2     	mov	x2, x0
  7ca174: 52808a81     	mov	w1, #0x454              // =1108
  7ca178: aa0303e0     	mov	x0, x3
  7ca17c: 94004327     	bl	0x7dae18
  7ca180: f94017e1     	ldr	x1, [sp, #0x28]
  7ca184: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca188: 8b000023     	add	x3, x1, x0
  7ca18c: f94017e0     	ldr	x0, [sp, #0x28]
  7ca190: 91067000     	add	x0, x0, #0x19c
  7ca194: aa0003e2     	mov	x2, x0
  7ca198: 52808a61     	mov	w1, #0x453              // =1107
  7ca19c: aa0303e0     	mov	x0, x3
  7ca1a0: 9400431e     	bl	0x7dae18
  7ca1a4: f94017e1     	ldr	x1, [sp, #0x28]
  7ca1a8: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca1ac: 8b000023     	add	x3, x1, x0
  7ca1b0: f94017e0     	ldr	x0, [sp, #0x28]
  7ca1b4: 910b2000     	add	x0, x0, #0x2c8
  7ca1b8: aa0003e2     	mov	x2, x0
  7ca1bc: 52806401     	mov	w1, #0x320              // =800
  7ca1c0: aa0303e0     	mov	x0, x3
  7ca1c4: 9400432f     	bl	0x7dae80
  7ca1c8: f94017e1     	ldr	x1, [sp, #0x28]
  7ca1cc: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca1d0: 8b000023     	add	x3, x1, x0
  7ca1d4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca1d8: 910b3000     	add	x0, x0, #0x2cc
  7ca1dc: aa0003e2     	mov	x2, x0
  7ca1e0: 52806421     	mov	w1, #0x321              // =801
  7ca1e4: aa0303e0     	mov	x0, x3
  7ca1e8: 94004326     	bl	0x7dae80
  7ca1ec: f94017e1     	ldr	x1, [sp, #0x28]
  7ca1f0: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca1f4: 8b000023     	add	x3, x1, x0
  7ca1f8: f94017e0     	ldr	x0, [sp, #0x28]
  7ca1fc: 910b4000     	add	x0, x0, #0x2d0
  7ca200: aa0003e2     	mov	x2, x0
  7ca204: 52806441     	mov	w1, #0x322              // =802
  7ca208: aa0303e0     	mov	x0, x3
  7ca20c: 9400431d     	bl	0x7dae80
  7ca210: f94017e1     	ldr	x1, [sp, #0x28]
  7ca214: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca218: 8b000026     	add	x6, x1, x0
  7ca21c: f94017e0     	ldr	x0, [sp, #0x28]
  7ca220: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca224: f9681401     	ldr	x1, [x0, #0x5028]
  7ca228: f94017e0     	ldr	x0, [sp, #0x28]
  7ca22c: 910df000     	add	x0, x0, #0x37c
  7ca230: 52800005     	mov	w5, #0x0                // =0
  7ca234: 52800104     	mov	w4, #0x8                // =8
  7ca238: aa0003e3     	mov	x3, x0
  7ca23c: 52804d02     	mov	w2, #0x268              // =616
  7ca240: aa0603e0     	mov	x0, x6
  7ca244: 94004343     	bl	0x7daf50
  7ca248: f94017e1     	ldr	x1, [sp, #0x28]
  7ca24c: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca250: 8b000026     	add	x6, x1, x0
  7ca254: f94017e0     	ldr	x0, [sp, #0x28]
  7ca258: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca25c: f9681401     	ldr	x1, [x0, #0x5028]
  7ca260: f94017e0     	ldr	x0, [sp, #0x28]
  7ca264: 910c7000     	add	x0, x0, #0x31c
  7ca268: 52800005     	mov	w5, #0x0                // =0
  7ca26c: 52800104     	mov	w4, #0x8                // =8
  7ca270: aa0003e3     	mov	x3, x0
  7ca274: 5280a7a2     	mov	w2, #0x53d              // =1341
  7ca278: aa0603e0     	mov	x0, x6
  7ca27c: 94004335     	bl	0x7daf50
  7ca280: f94017e0     	ldr	x0, [sp, #0x28]
  7ca284: b9407c00     	ldr	w0, [x0, #0x7c]
  7ca288: 71004c1f     	cmp	w0, #0x13
  7ca28c: 540000a0     	b.eq	0x7ca2a0
  7ca290: f94017e0     	ldr	x0, [sp, #0x28]
  7ca294: b9407c00     	ldr	w0, [x0, #0x7c]
  7ca298: 7100501f     	cmp	w0, #0x14
  7ca29c: 540000a1     	b.ne	0x7ca2b0
  7ca2a0: f94017e0     	ldr	x0, [sp, #0x28]
  7ca2a4: 52933341     	mov	w1, #0x999a             // =39322
  7ca2a8: 72a7f321     	movk	w1, #0x3f99, lsl #16
  7ca2ac: b9020c01     	str	w1, [x0, #0x20c]
  7ca2b0: f94017e1     	ldr	x1, [sp, #0x28]
  7ca2b4: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca2b8: 8b000023     	add	x3, x1, x0
  7ca2bc: f94017e0     	ldr	x0, [sp, #0x28]
  7ca2c0: 91083000     	add	x0, x0, #0x20c
  7ca2c4: aa0003e2     	mov	x2, x0
  7ca2c8: 528048a1     	mov	w1, #0x245              // =581
  7ca2cc: aa0303e0     	mov	x0, x3
  7ca2d0: 940042ec     	bl	0x7dae80
  7ca2d4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca2d8: b9421c00     	ldr	w0, [x0, #0x21c]
  7ca2dc: 7100041f     	cmp	w0, #0x1
  7ca2e0: 54000081     	b.ne	0x7ca2f0
  7ca2e4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca2e8: 52800041     	mov	w1, #0x2                // =2
  7ca2ec: b9028401     	str	w1, [x0, #0x284]
  7ca2f0: f94017e1     	ldr	x1, [sp, #0x28]
  7ca2f4: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca2f8: 8b000023     	add	x3, x1, x0
  7ca2fc: f94017e0     	ldr	x0, [sp, #0x28]
  7ca300: 910a1000     	add	x0, x0, #0x284
  7ca304: aa0003e2     	mov	x2, x0
  7ca308: 52804501     	mov	w1, #0x228              // =552
  7ca30c: aa0303e0     	mov	x0, x3
  7ca310: 940042c2     	bl	0x7dae18
  7ca314: f94017e1     	ldr	x1, [sp, #0x28]
  7ca318: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca31c: 8b000023     	add	x3, x1, x0
  7ca320: f94017e0     	ldr	x0, [sp, #0x28]
  7ca324: 9109e000     	add	x0, x0, #0x278
  7ca328: aa0003e2     	mov	x2, x0
  7ca32c: 52804521     	mov	w1, #0x229              // =553
  7ca330: aa0303e0     	mov	x0, x3
  7ca334: 940042b9     	bl	0x7dae18
  7ca338: f94017e1     	ldr	x1, [sp, #0x28]
  7ca33c: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca340: 8b000020     	add	x0, x1, x0
  7ca344: 52802201     	mov	w1, #0x110              // =272
  7ca348: 940042e8     	bl	0x7daee8
  7ca34c: 2a0003e1     	mov	w1, w0
  7ca350: f94017e0     	ldr	x0, [sp, #0x28]
  7ca354: b9027c01     	str	w1, [x0, #0x27c]
  7ca358: 528175a0     	mov	w0, #0xbad              // =2989
  7ca35c: b90037e0     	str	w0, [sp, #0x34]
  7ca360: f94017e1     	ldr	x1, [sp, #0x28]
  7ca364: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca368: 8b000020     	add	x0, x1, x0
  7ca36c: 9100d3e1     	add	x1, sp, #0x34
  7ca370: aa0103e2     	mov	x2, x1
  7ca374: 528042a1     	mov	w1, #0x215              // =533
  7ca378: 940042a8     	bl	0x7dae18
  7ca37c: b94037e0     	ldr	w0, [sp, #0x34]
  7ca380: 712eb41f     	cmp	w0, #0xbad
  7ca384: 54000760     	b.eq	0x7ca470
  7ca388: b94037e0     	ldr	w0, [sp, #0x34]
  7ca38c: 7100101f     	cmp	w0, #0x4
  7ca390: 54000520     	b.eq	0x7ca434
  7ca394: 7100101f     	cmp	w0, #0x4
  7ca398: 54000148     	b.hi	0x7ca3c0
  7ca39c: 7100041f     	cmp	w0, #0x1
  7ca3a0: 54000320     	b.eq	0x7ca404
  7ca3a4: 7100001f     	cmp	w0, #0x0
  7ca3a8: 540001e0     	b.eq	0x7ca3e4
  7ca3ac: 7100081f     	cmp	w0, #0x2
  7ca3b0: 54000220     	b.eq	0x7ca3f4
  7ca3b4: 71000c1f     	cmp	w0, #0x3
  7ca3b8: 540002e0     	b.eq	0x7ca414
  7ca3bc: 1400002d     	b	0x7ca470
  7ca3c0: 7100181f     	cmp	w0, #0x6
  7ca3c4: 54000400     	b.eq	0x7ca444
  7ca3c8: 7100181f     	cmp	w0, #0x6
  7ca3cc: 540004c3     	b.lo	0x7ca464
  7ca3d0: 71001c1f     	cmp	w0, #0x7
  7ca3d4: 54000400     	b.eq	0x7ca454
  7ca3d8: 7100201f     	cmp	w0, #0x8
  7ca3dc: 54000240     	b.eq	0x7ca424
  7ca3e0: 14000024     	b	0x7ca470
  7ca3e4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca3e8: 52800081     	mov	w1, #0x4                // =4
  7ca3ec: b9021801     	str	w1, [x0, #0x218]
  7ca3f0: 14000020     	b	0x7ca470
  7ca3f4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca3f8: 52800021     	mov	w1, #0x1                // =1
  7ca3fc: b9021801     	str	w1, [x0, #0x218]
  7ca400: 1400001c     	b	0x7ca470
  7ca404: f94017e0     	ldr	x0, [sp, #0x28]
  7ca408: 52800061     	mov	w1, #0x3                // =3
  7ca40c: b9021801     	str	w1, [x0, #0x218]
  7ca410: 14000018     	b	0x7ca470
  7ca414: f94017e0     	ldr	x0, [sp, #0x28]
  7ca418: 52800041     	mov	w1, #0x2                // =2
  7ca41c: b9021801     	str	w1, [x0, #0x218]
  7ca420: 14000014     	b	0x7ca470
  7ca424: f94017e0     	ldr	x0, [sp, #0x28]
  7ca428: 52800101     	mov	w1, #0x8                // =8
  7ca42c: b9021801     	str	w1, [x0, #0x218]
  7ca430: 14000010     	b	0x7ca470
  7ca434: f94017e0     	ldr	x0, [sp, #0x28]
  7ca438: 528000a1     	mov	w1, #0x5                // =5
  7ca43c: b9021801     	str	w1, [x0, #0x218]
  7ca440: 1400000c     	b	0x7ca470
  7ca444: f94017e0     	ldr	x0, [sp, #0x28]
  7ca448: 528000c1     	mov	w1, #0x6                // =6
  7ca44c: b9021801     	str	w1, [x0, #0x218]
  7ca450: 14000008     	b	0x7ca470
  7ca454: f94017e0     	ldr	x0, [sp, #0x28]
  7ca458: 528000e1     	mov	w1, #0x7                // =7
  7ca45c: b9021801     	str	w1, [x0, #0x218]
  7ca460: 14000004     	b	0x7ca470
  7ca464: f94017e0     	ldr	x0, [sp, #0x28]
  7ca468: b902181f     	str	wzr, [x0, #0x218]
  7ca46c: d503201f     	nop
  7ca470: 528175a0     	mov	w0, #0xbad              // =2989
  7ca474: b90033e0     	str	w0, [sp, #0x30]
  7ca478: f94017e1     	ldr	x1, [sp, #0x28]
  7ca47c: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca480: 8b000020     	add	x0, x1, x0
  7ca484: 9100c3e1     	add	x1, sp, #0x30
  7ca488: aa0103e2     	mov	x2, x1
  7ca48c: 52802001     	mov	w1, #0x100              // =256
  7ca490: 94004262     	bl	0x7dae18
  7ca494: b94033e0     	ldr	w0, [sp, #0x30]
  7ca498: 712eb41f     	cmp	w0, #0xbad
  7ca49c: 54000340     	b.eq	0x7ca504
  7ca4a0: b94033e0     	ldr	w0, [sp, #0x30]
  7ca4a4: 7100041f     	cmp	w0, #0x1
  7ca4a8: 54000160     	b.eq	0x7ca4d4
  7ca4ac: 7100001f     	cmp	w0, #0x0
  7ca4b0: 540000c0     	b.eq	0x7ca4c8
  7ca4b4: 7100081f     	cmp	w0, #0x2
  7ca4b8: 54000160     	b.eq	0x7ca4e4
  7ca4bc: 71000c1f     	cmp	w0, #0x3
  7ca4c0: 540001a0     	b.eq	0x7ca4f4
  7ca4c4: 14000010     	b	0x7ca504
  7ca4c8: f94017e0     	ldr	x0, [sp, #0x28]
  7ca4cc: b9003c1f     	str	wzr, [x0, #0x3c]
  7ca4d0: 1400000d     	b	0x7ca504
  7ca4d4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca4d8: 52800b41     	mov	w1, #0x5a               // =90
  7ca4dc: b9003c01     	str	w1, [x0, #0x3c]
  7ca4e0: 14000009     	b	0x7ca504
  7ca4e4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca4e8: 12800b21     	mov	w1, #-0x5a              // =-90
  7ca4ec: b9003c01     	str	w1, [x0, #0x3c]
  7ca4f0: 14000005     	b	0x7ca504
  7ca4f4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca4f8: 52801681     	mov	w1, #0xb4               // =180
  7ca4fc: b9003c01     	str	w1, [x0, #0x3c]
  7ca500: d503201f     	nop
  7ca504: f94017e1     	ldr	x1, [sp, #0x28]
  7ca508: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca50c: 8b000020     	add	x0, x1, x0
  7ca510: 940037cf     	bl	0x7d844c
  7ca514: 12001c00     	and	w0, w0, #0xff
  7ca518: 7100001f     	cmp	w0, #0x0
  7ca51c: 540000a0     	b.eq	0x7ca530
  7ca520: f94017e0     	ldr	x0, [sp, #0x28]
  7ca524: 52800021     	mov	w1, #0x1                // =1
  7ca528: b9004801     	str	w1, [x0, #0x48]
  7ca52c: 14000003     	b	0x7ca538
  7ca530: f94017e0     	ldr	x0, [sp, #0x28]
  7ca534: b900481f     	str	wzr, [x0, #0x48]
  7ca538: f94017e1     	ldr	x1, [sp, #0x28]
  7ca53c: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca540: 8b000026     	add	x6, x1, x0
  7ca544: f94017e0     	ldr	x0, [sp, #0x28]
  7ca548: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca54c: f9681401     	ldr	x1, [x0, #0x5028]
  7ca550: f94017e0     	ldr	x0, [sp, #0x28]
  7ca554: 91006000     	add	x0, x0, #0x18
  7ca558: 52800005     	mov	w5, #0x0                // =0
  7ca55c: 52800104     	mov	w4, #0x8                // =8
  7ca560: aa0003e3     	mov	x3, x0
  7ca564: 528045e2     	mov	w2, #0x22f              // =559
  7ca568: aa0603e0     	mov	x0, x6
  7ca56c: 94004279     	bl	0x7daf50
  7ca570: f94017e1     	ldr	x1, [sp, #0x28]
  7ca574: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca578: 8b000026     	add	x6, x1, x0
  7ca57c: f94017e0     	ldr	x0, [sp, #0x28]
  7ca580: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca584: f9681401     	ldr	x1, [x0, #0x5028]
  7ca588: f94017e0     	ldr	x0, [sp, #0x28]
  7ca58c: 91013000     	add	x0, x0, #0x4c
  7ca590: 52800005     	mov	w5, #0x0                // =0
  7ca594: 52800184     	mov	w4, #0xc                // =12
  7ca598: aa0003e3     	mov	x3, x0
  7ca59c: 528020e2     	mov	w2, #0x107              // =263
  7ca5a0: aa0603e0     	mov	x0, x6
  7ca5a4: 9400426b     	bl	0x7daf50
  7ca5a8: f94017e1     	ldr	x1, [sp, #0x28]
  7ca5ac: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca5b0: 8b000026     	add	x6, x1, x0
  7ca5b4: f94017e0     	ldr	x0, [sp, #0x28]
  7ca5b8: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca5bc: f9681401     	ldr	x1, [x0, #0x5028]
  7ca5c0: f94017e0     	ldr	x0, [sp, #0x28]
  7ca5c4: 91016000     	add	x0, x0, #0x58
  7ca5c8: 52800005     	mov	w5, #0x0                // =0
  7ca5cc: 52800484     	mov	w4, #0x24               // =36
  7ca5d0: aa0003e3     	mov	x3, x0
  7ca5d4: 528020c2     	mov	w2, #0x106              // =262
  7ca5d8: aa0603e0     	mov	x0, x6
  7ca5dc: 9400425d     	bl	0x7daf50
  7ca5e0: f94017e1     	ldr	x1, [sp, #0x28]
  7ca5e4: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca5e8: 8b000026     	add	x6, x1, x0
  7ca5ec: f94017e0     	ldr	x0, [sp, #0x28]
  7ca5f0: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca5f4: f9681401     	ldr	x1, [x0, #0x5028]
  7ca5f8: f94017e0     	ldr	x0, [sp, #0x28]
  7ca5fc: 91045000     	add	x0, x0, #0x114
  7ca600: 52800005     	mov	w5, #0x0                // =0
  7ca604: 52800504     	mov	w4, #0x28               // =40
  7ca608: aa0003e3     	mov	x3, x0
  7ca60c: 52808242     	mov	w2, #0x412              // =1042
  7ca610: aa0603e0     	mov	x0, x6
  7ca614: 9400424f     	bl	0x7daf50
  7ca618: f94017e1     	ldr	x1, [sp, #0x28]
  7ca61c: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca620: 8b000026     	add	x6, x1, x0
  7ca624: f94017e0     	ldr	x0, [sp, #0x28]
  7ca628: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca62c: f9681401     	ldr	x1, [x0, #0x5028]
  7ca630: f94017e0     	ldr	x0, [sp, #0x28]
  7ca634: 9103b000     	add	x0, x0, #0xec
  7ca638: 52800005     	mov	w5, #0x0                // =0
  7ca63c: 52800484     	mov	w4, #0x24               // =36
  7ca640: aa0003e3     	mov	x3, x0
  7ca644: 52808202     	mov	w2, #0x410              // =1040
  7ca648: aa0603e0     	mov	x0, x6
  7ca64c: 94004241     	bl	0x7daf50
  7ca650: f94017e1     	ldr	x1, [sp, #0x28]
  7ca654: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca658: 8b000026     	add	x6, x1, x0
  7ca65c: f94017e0     	ldr	x0, [sp, #0x28]
  7ca660: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca664: f9681401     	ldr	x1, [x0, #0x5028]
  7ca668: f94017e0     	ldr	x0, [sp, #0x28]
  7ca66c: 91021000     	add	x0, x0, #0x84
  7ca670: 52800005     	mov	w5, #0x0                // =0
  7ca674: 52800404     	mov	w4, #0x20               // =32
  7ca678: aa0003e3     	mov	x3, x0
  7ca67c: 528060a2     	mov	w2, #0x305              // =773
  7ca680: aa0603e0     	mov	x0, x6
  7ca684: 94004233     	bl	0x7daf50
  7ca688: 14000004     	b	0x7ca698
  7ca68c: f94017e0     	ldr	x0, [sp, #0x28]
  7ca690: b900401f     	str	wzr, [x0, #0x40]
  7ca694: d503201f     	nop
  7ca698: d503201f     	nop
  7ca69c: f9400bf3     	ldr	x19, [sp, #0x10]
  7ca6a0: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  7ca6a4: d65f03c0     	ret
