  7b74ec: f9421fe0     	ldr	x0, [sp, #0x438]
  7b74f0: f100001f     	cmp	x0, #0x0
  7b74f4: 54001780     	b.eq	0x7b77e4
  7b74f8: 52800020     	mov	w0, #0x1                // =1
  7b74fc: 39191fe0     	strb	w0, [sp, #0x647]
  7b7500: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7504: d2880000     	mov	x0, #0x4000             // =16384
  7b7508: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b750c: 8b000020     	add	x0, x1, x0
  7b7510: b9793001     	ldr	w1, [x0, #0x3930]
  7b7514: b9442be0     	ldr	w0, [sp, #0x428]
  7b7518: 6b00003f     	cmp	w1, w0
  7b751c: 540015c0     	b.eq	0x7b77d4
  7b7520: f9421fe0     	ldr	x0, [sp, #0x438]
  7b7524: f100001f     	cmp	x0, #0x0
  7b7528: 54000141     	b.ne	0x7b7550
  7b752c: 52805ac3     	mov	w3, #0x2d6              // =726
  7b7530: b0002e60     	adrp	x0, 0xd84000
  7b7534: 91372002     	add	x2, x0, #0xdc8
  7b7538: b0002e60     	adrp	x0, 0xd84000
  7b753c: 913e8001     	add	x1, x0, #0xfa0
  7b7540: b0002e60     	adrp	x0, 0xd84000
  7b7544: 9126e000     	add	x0, x0, #0x9b8
  7b7548: 97f14c0e     	bl	0x40a580
  7b754c: 97fed46f     	bl	0x76c708
  7b7550: f9421fe3     	ldr	x3, [sp, #0x438]
  7b7554: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7558: d280b900     	mov	x0, #0x5c8              // =1480
  7b755c: f2a7f800     	movk	x0, #0x3fc0, lsl #16
  7b7560: 8b000020     	add	x0, x1, x0
  7b7564: 528e6002     	mov	w2, #0x7300             // =29440
  7b7568: 72a49e82     	movk	w2, #0x24f4, lsl #16
  7b756c: aa0003e1     	mov	x1, x0
  7b7570: aa0303e0     	mov	x0, x3
  7b7574: 94008741     	bl	0x7d9278
  7b7578: b90607e0     	str	w0, [sp, #0x604]
  7b757c: b94607e0     	ldr	w0, [sp, #0x604]
  7b7580: 7100001f     	cmp	w0, #0x0
  7b7584: 54000600     	b.eq	0x7b7644
  7b7588: f9402fe1     	ldr	x1, [sp, #0x58]
  7b758c: d2a7f800     	mov	x0, #0x3fc00000         // =1069547520
  7b7590: 8b000020     	add	x0, x1, x0
  7b7594: 39572000     	ldrb	w0, [x0, #0x5c8]
  7b7598: 7100001f     	cmp	w0, #0x0
  7b759c: 540000e1     	b.ne	0x7b75b8
  7b75a0: f9402fe1     	ldr	x1, [sp, #0x58]
  7b75a4: d2880000     	mov	x0, #0x4000             // =16384
  7b75a8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b75ac: 8b000020     	add	x0, x1, x0
  7b75b0: b939981f     	str	wzr, [x0, #0x3998]
  7b75b4: 14000029     	b	0x7b7658
  7b75b8: f9402fe1     	ldr	x1, [sp, #0x58]
  7b75bc: d280b900     	mov	x0, #0x5c8              // =1480
  7b75c0: f2a7f800     	movk	x0, #0x3fc0, lsl #16
  7b75c4: 8b000033     	add	x19, x1, x0
  7b75c8: b94607f4     	ldr	w20, [sp, #0x604]
  7b75cc: 911203e0     	add	x0, sp, #0x480
  7b75d0: 97f14e0c     	bl	0x40ae00
  7b75d4: 911203e1     	add	x1, sp, #0x480
  7b75d8: 9101a3e0     	add	x0, sp, #0x68
  7b75dc: aa0103e3     	mov	x3, x1
  7b75e0: aa1403e2     	mov	x2, x20
  7b75e4: aa1303e1     	mov	x1, x19
  7b75e8: 94001278     	bl	0x7bbfc8
  7b75ec: 911203e0     	add	x0, sp, #0x480
  7b75f0: 97f14f0c     	bl	0x40b220
  7b75f4: f9402fe0     	ldr	x0, [sp, #0x58]
  7b75f8: 910b6013     	add	x19, x0, #0x2d8
  7b75fc: 9101a3e1     	add	x1, sp, #0x68
  7b7600: 911223e0     	add	x0, sp, #0x488
  7b7604: 97f1f049     	bl	0x433728
  7b7608: 911223e0     	add	x0, sp, #0x488
  7b760c: aa0003e1     	mov	x1, x0
  7b7610: aa1303e0     	mov	x0, x19
  7b7614: 9406a54d     	bl	0x960b48
  7b7618: 2a0003e2     	mov	w2, w0
  7b761c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7620: d2880000     	mov	x0, #0x4000             // =16384
  7b7624: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7628: 8b000020     	add	x0, x1, x0
  7b762c: b9399802     	str	w2, [x0, #0x3998]
  7b7630: 911223e0     	add	x0, sp, #0x488
  7b7634: 97f1e83b     	bl	0x431720
  7b7638: 9101a3e0     	add	x0, sp, #0x68
  7b763c: 97f1e839     	bl	0x431720
  7b7640: 14000006     	b	0x7b7658
  7b7644: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7648: d2880000     	mov	x0, #0x4000             // =16384
  7b764c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7650: 8b000020     	add	x0, x1, x0
  7b7654: b939981f     	str	wzr, [x0, #0x3998]
  7b7658: f9402fe1     	ldr	x1, [sp, #0x58]
  7b765c: d280b900     	mov	x0, #0x5c8              // =1480
  7b7660: f2a7f800     	movk	x0, #0x3fc0, lsl #16
  7b7664: 8b000021     	add	x1, x1, x0
  7b7668: f9402fe2     	ldr	x2, [sp, #0x58]
  7b766c: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b7670: 8b000040     	add	x0, x2, x0
  7b7674: f93cc401     	str	x1, [x0, #0x7988]
  7b7678: f9421fe3     	ldr	x3, [sp, #0x438]
  7b767c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7680: d280b900     	mov	x0, #0x5c8              // =1480
  7b7684: f2a7f800     	movk	x0, #0x3fc0, lsl #16
  7b7688: 8b000020     	add	x0, x1, x0
  7b768c: 528e6002     	mov	w2, #0x7300             // =29440
  7b7690: 72a49e82     	movk	w2, #0x24f4, lsl #16
  7b7694: aa0003e1     	mov	x1, x0
  7b7698: aa0303e0     	mov	x0, x3
  7b769c: 940087e5     	bl	0x7d9630
  7b76a0: 2a0003e2     	mov	w2, w0
  7b76a4: f9402fe1     	ldr	x1, [sp, #0x58]
  7b76a8: d2880000     	mov	x0, #0x4000             // =16384
  7b76ac: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b76b0: 8b000020     	add	x0, x1, x0
  7b76b4: b9399002     	str	w2, [x0, #0x3990]
