  7b749c: d11983ff     	sub	sp, sp, #0x660
  7b74a0: a9007bfd     	stp	x29, x30, [sp]
  7b74a4: 910003fd     	mov	x29, sp
  7b74a8: a90153f3     	stp	x19, x20, [sp, #0x10]
  7b74ac: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7b74b0: a90363f7     	stp	x23, x24, [sp, #0x30]
  7b74b4: a9046bf9     	stp	x25, x26, [sp, #0x40]
  7b74b8: f9002fe0     	str	x0, [sp, #0x58]
  7b74bc: f9402fe1     	ldr	x1, [sp, #0x58]
  7b74c0: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b74c4: 8b000020     	add	x0, x1, x0
  7b74c8: f97c8c00     	ldr	x0, [x0, #0x7918]
  7b74cc: 91002000     	add	x0, x0, #0x8
  7b74d0: 911003e1     	add	x1, sp, #0x400
  7b74d4: aa0103e8     	mov	x8, x1
  7b74d8: 97f362f0     	bl	0x490098
  7b74dc: b9065fff     	str	wzr, [sp, #0x65c]
  7b74e0: f9032bff     	str	xzr, [sp, #0x650]
  7b74e4: f90327ff     	str	xzr, [sp, #0x648]
  7b74e8: 39191fff     	strb	wzr, [sp, #0x647]
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
  7b76b8: f9421fe0     	ldr	x0, [sp, #0x438]
  7b76bc: 94008815     	bl	0x7d9710
  7b76c0: 2a0003e1     	mov	w1, w0
  7b76c4: f9402fe0     	ldr	x0, [sp, #0x58]
  7b76c8: 97fffb13     	bl	0x7b6314
  7b76cc: 2a0003e2     	mov	w2, w0
  7b76d0: f9402fe1     	ldr	x1, [sp, #0x58]
  7b76d4: d2880000     	mov	x0, #0x4000             // =16384
  7b76d8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b76dc: 8b000020     	add	x0, x1, x0
  7b76e0: b9396802     	str	w2, [x0, #0x3968]
  7b76e4: f9421fe0     	ldr	x0, [sp, #0x438]
  7b76e8: 97f35af3     	bl	0x48e2b4
  7b76ec: 2a0003e1     	mov	w1, w0
  7b76f0: f9422fe0     	ldr	x0, [sp, #0x458]
  7b76f4: b9007001     	str	w1, [x0, #0x70]
  7b76f8: f9402fe1     	ldr	x1, [sp, #0x58]
  7b76fc: d28f2700     	mov	x0, #0x7938             // =31032
  7b7700: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7704: 8b000020     	add	x0, x1, x0
  7b7708: f9421fe1     	ldr	x1, [sp, #0x438]
  7b770c: aa0103e2     	mov	x2, x1
  7b7710: aa0003e1     	mov	x1, x0
  7b7714: f9402fe0     	ldr	x0, [sp, #0x58]
  7b7718: 94000b13     	bl	0x7ba364
  7b771c: f9421fe0     	ldr	x0, [sp, #0x438]
  7b7720: 9140e000     	add	x0, x0, #0x38, lsl #12  // =0x38000
  7b7724: b942f801     	ldr	w1, [x0, #0x2f8]
  7b7728: f9402fe2     	ldr	x2, [sp, #0x58]
  7b772c: d2880000     	mov	x0, #0x4000             // =16384
  7b7730: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7734: 8b000040     	add	x0, x2, x0
  7b7738: b9399c01     	str	w1, [x0, #0x399c]
  7b773c: f9421fe1     	ldr	x1, [sp, #0x438]
  7b7740: d2901400     	mov	x0, #0x80a0             // =32928
  7b7744: f2a00060     	movk	x0, #0x3, lsl #16
  7b7748: 8b000020     	add	x0, x1, x0
  7b774c: 940010d1     	bl	0x7bba90
  7b7750: f9031fe0     	str	x0, [sp, #0x638]
  7b7754: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7758: d28f2e00     	mov	x0, #0x7970             // =31088
  7b775c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7760: 8b000020     	add	x0, x1, x0
  7b7764: 94001415     	bl	0x7bc7b8
  7b7768: b90637ff     	str	wzr, [sp, #0x634]
  7b776c: f9421fe0     	ldr	x0, [sp, #0x438]
  7b7770: 9140e000     	add	x0, x0, #0x38, lsl #12  // =0x38000
  7b7774: b940a401     	ldr	w1, [x0, #0xa4]
  7b7778: b94637e0     	ldr	w0, [sp, #0x634]
  7b777c: 6b00003f     	cmp	w1, w0
  7b7780: 540001e9     	b.ls	0x7b77bc
  7b7784: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7788: d28f2e00     	mov	x0, #0x7970             // =31088
  7b778c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7790: 8b000022     	add	x2, x1, x0
  7b7794: f9431fe0     	ldr	x0, [sp, #0x638]
  7b7798: 91001001     	add	x1, x0, #0x4
  7b779c: f9031fe1     	str	x1, [sp, #0x638]
  7b77a0: aa0003e1     	mov	x1, x0
  7b77a4: aa0203e0     	mov	x0, x2
  7b77a8: 9400140f     	bl	0x7bc7e4
  7b77ac: b94637e0     	ldr	w0, [sp, #0x634]
  7b77b0: 11000400     	add	w0, w0, #0x1
  7b77b4: b90637e0     	str	w0, [sp, #0x634]
  7b77b8: 17ffffed     	b	0x7b776c
  7b77bc: b9442be1     	ldr	w1, [sp, #0x428]
  7b77c0: f9402fe2     	ldr	x2, [sp, #0x58]
  7b77c4: d2880000     	mov	x0, #0x4000             // =16384
  7b77c8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b77cc: 8b000040     	add	x0, x2, x0
  7b77d0: b9393001     	str	w1, [x0, #0x3930]
  7b77d4: f9421fe0     	ldr	x0, [sp, #0x438]
  7b77d8: 9140e000     	add	x0, x0, #0x38, lsl #12  // =0x38000
  7b77dc: b9414c00     	ldr	w0, [x0, #0x14c]
  7b77e0: b9065fe0     	str	w0, [sp, #0x65c]
  7b77e4: 39591fe0     	ldrb	w0, [sp, #0x647]
  7b77e8: 52000000     	eor	w0, w0, #0x1
  7b77ec: 12001c00     	and	w0, w0, #0xff
  7b77f0: 7100001f     	cmp	w0, #0x0
  7b77f4: 54001120     	b.eq	0x7b7a18
  7b77f8: f90317ff     	str	xzr, [sp, #0x628]
  7b77fc: f90313ff     	str	xzr, [sp, #0x620]
  7b7800: f94223e0     	ldr	x0, [sp, #0x440]
  7b7804: f100001f     	cmp	x0, #0x0
  7b7808: 540000e0     	b.eq	0x7b7824
  7b780c: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7810: 94042b6c     	bl	0x8c25c0
  7b7814: f90327e0     	str	x0, [sp, #0x648]
  7b7818: f94223e0     	ldr	x0, [sp, #0x440]
  7b781c: 97f3761e     	bl	0x495094
  7b7820: f90317e0     	str	x0, [sp, #0x628]
  7b7824: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7828: f100001f     	cmp	x0, #0x0
  7b782c: 54000140     	b.eq	0x7b7854
  7b7830: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7834: 94042bc7     	bl	0x8c2750
  7b7838: f9032be0     	str	x0, [sp, #0x650]
  7b783c: f9432be0     	ldr	x0, [sp, #0x650]
  7b7840: f100001f     	cmp	x0, #0x0
  7b7844: 54000080     	b.eq	0x7b7854
  7b7848: f9432be0     	ldr	x0, [sp, #0x650]
  7b784c: 97f37618     	bl	0x4950ac
  7b7850: f90313e0     	str	x0, [sp, #0x620]
  7b7854: f94313e0     	ldr	x0, [sp, #0x620]
  7b7858: f100001f     	cmp	x0, #0x0
  7b785c: 54000080     	b.eq	0x7b786c
  7b7860: f94317e0     	ldr	x0, [sp, #0x628]
  7b7864: f100001f     	cmp	x0, #0x0
  7b7868: 54000381     	b.ne	0x7b78d8
  7b786c: f94313e0     	ldr	x0, [sp, #0x620]
  7b7870: f100001f     	cmp	x0, #0x0
  7b7874: 54000060     	b.eq	0x7b7880
  7b7878: f9422fe0     	ldr	x0, [sp, #0x458]
  7b787c: 94042bd9     	bl	0x8c27e0
  7b7880: f94317e0     	ldr	x0, [sp, #0x628]
  7b7884: f100001f     	cmp	x0, #0x0
  7b7888: 54000060     	b.eq	0x7b7894
  7b788c: f9422fe0     	ldr	x0, [sp, #0x458]
  7b7890: 94042b76     	bl	0x8c2668
  7b7894: 391003ff     	strb	wzr, [sp, #0x400]
  7b7898: f9402fe1     	ldr	x1, [sp, #0x58]
  7b789c: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b78a0: 8b000020     	add	x0, x1, x0
  7b78a4: f97c8c00     	ldr	x0, [x0, #0x7918]
  7b78a8: 91078013     	add	x19, x0, #0x1e0
  7b78ac: 911003e1     	add	x1, sp, #0x400
  7b78b0: 9112a3e0     	add	x0, sp, #0x4a8
  7b78b4: 97f35d2f     	bl	0x48ed70
  7b78b8: 9112a3e0     	add	x0, sp, #0x4a8
  7b78bc: aa0003e1     	mov	x1, x0
  7b78c0: aa1303e0     	mov	x0, x19
  7b78c4: 97f361cd     	bl	0x48fff8
  7b78c8: 9112a3e0     	add	x0, sp, #0x4a8
  7b78cc: 97f35d20     	bl	0x48ed4c
  7b78d0: 52800013     	mov	w19, #0x0               // =0
  7b78d4: 14000297     	b	0x7b8330
  7b78d8: f9402fe1     	ldr	x1, [sp, #0x58]
  7b78dc: d28f2700     	mov	x0, #0x7938             // =31032
  7b78e0: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b78e4: 8b000020     	add	x0, x1, x0
  7b78e8: f94313e3     	ldr	x3, [sp, #0x620]
  7b78ec: f94317e2     	ldr	x2, [sp, #0x628]
  7b78f0: aa0003e1     	mov	x1, x0
  7b78f4: f9402fe0     	ldr	x0, [sp, #0x58]
  7b78f8: 94000c79     	bl	0x7baadc
  7b78fc: f94317e0     	ldr	x0, [sp, #0x628]
  7b7900: 9140b000     	add	x0, x0, #0x2c, lsl #12  // =0x2c000
  7b7904: b9588c00     	ldr	w0, [x0, #0x188c]
  7b7908: b9065fe0     	str	w0, [sp, #0x65c]
  7b790c: f9402fe0     	ldr	x0, [sp, #0x58]
  7b7910: 910b6013     	add	x19, x0, #0x2d8
  7b7914: f94317e1     	ldr	x1, [sp, #0x628]
  7b7918: d29b1200     	mov	x0, #0xd890             // =55440
  7b791c: f2a00040     	movk	x0, #0x2, lsl #16
  7b7920: 8b000021     	add	x1, x1, x0
  7b7924: 9114a3e0     	add	x0, sp, #0x528
  7b7928: 97f1ef80     	bl	0x433728
  7b792c: 9114a3e0     	add	x0, sp, #0x528
  7b7930: aa0003e1     	mov	x1, x0
  7b7934: aa1303e0     	mov	x0, x19
  7b7938: 9406a484     	bl	0x960b48
  7b793c: 2a0003e2     	mov	w2, w0
  7b7940: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7944: d2880000     	mov	x0, #0x4000             // =16384
  7b7948: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b794c: 8b000020     	add	x0, x1, x0
  7b7950: b9399802     	str	w2, [x0, #0x3998]
  7b7954: 9114a3e0     	add	x0, sp, #0x528
  7b7958: 97f1e772     	bl	0x431720
  7b795c: f94317e0     	ldr	x0, [sp, #0x628]
  7b7960: 91004002     	add	x2, x0, #0x10
  7b7964: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7968: d28f2e00     	mov	x0, #0x7970             // =31088
  7b796c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7970: 8b000020     	add	x0, x1, x0
  7b7974: aa0203e1     	mov	x1, x2
  7b7978: 940013bd     	bl	0x7bc86c
  7b797c: f94317e0     	ldr	x0, [sp, #0x628]
  7b7980: f9400001     	ldr	x1, [x0]
  7b7984: f9402fe2     	ldr	x2, [sp, #0x58]
  7b7988: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b798c: 8b000040     	add	x0, x2, x0
  7b7990: f93cc401     	str	x1, [x0, #0x7988]
  7b7994: f94317e0     	ldr	x0, [sp, #0x628]
  7b7998: 9140b000     	add	x0, x0, #0x2c, lsl #12  // =0x2c000
  7b799c: b9588801     	ldr	w1, [x0, #0x1888]
  7b79a0: f9402fe2     	ldr	x2, [sp, #0x58]
  7b79a4: d2880000     	mov	x0, #0x4000             // =16384
  7b79a8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b79ac: 8b000040     	add	x0, x2, x0
  7b79b0: b9399001     	str	w1, [x0, #0x3990]
  7b79b4: f94313e0     	ldr	x0, [sp, #0x620]
  7b79b8: b940c400     	ldr	w0, [x0, #0xc4]
  7b79bc: 2a0003e1     	mov	w1, w0
  7b79c0: f9402fe0     	ldr	x0, [sp, #0x58]
  7b79c4: 97fffa54     	bl	0x7b6314
  7b79c8: 2a0003e2     	mov	w2, w0
  7b79cc: f9402fe1     	ldr	x1, [sp, #0x58]
  7b79d0: d2880000     	mov	x0, #0x4000             // =16384
  7b79d4: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b79d8: 8b000020     	add	x0, x1, x0
  7b79dc: b9396802     	str	w2, [x0, #0x3968]
  7b79e0: b9442be1     	ldr	w1, [sp, #0x428]
  7b79e4: f9402fe2     	ldr	x2, [sp, #0x58]
  7b79e8: d2880000     	mov	x0, #0x4000             // =16384
  7b79ec: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b79f0: 8b000040     	add	x0, x2, x0
  7b79f4: b9393001     	str	w1, [x0, #0x3930]
  7b79f8: f94313e0     	ldr	x0, [sp, #0x620]
  7b79fc: b940b400     	ldr	w0, [x0, #0xb4]
  7b7a00: 2a0003e2     	mov	w2, w0
  7b7a04: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7a08: d2880000     	mov	x0, #0x4000             // =16384
  7b7a0c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7a10: 8b000020     	add	x0, x1, x0
  7b7a14: b9399c02     	str	w2, [x0, #0x399c]
  7b7a18: 9104e3e0     	add	x0, sp, #0x138
  7b7a1c: 9400108e     	bl	0x7bbc54
  7b7a20: 910383e0     	add	x0, sp, #0xe0
  7b7a24: 940532cb     	bl	0x904550
  7b7a28: 910223e0     	add	x0, sp, #0x88
  7b7a2c: 940532c9     	bl	0x904550
  7b7a30: f9402fe0     	ldr	x0, [sp, #0x58]
  7b7a34: 910b6003     	add	x3, x0, #0x2d8
  7b7a38: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7a3c: d28f2700     	mov	x0, #0x7938             // =31032
  7b7a40: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7a44: 8b000020     	add	x0, x1, x0
  7b7a48: aa0003e2     	mov	x2, x0
  7b7a4c: b9465fe1     	ldr	w1, [sp, #0x65c]
  7b7a50: aa0303e0     	mov	x0, x3
  7b7a54: 9406a289     	bl	0x960478
  7b7a58: f9402fe0     	ldr	x0, [sp, #0x58]
  7b7a5c: 910b6003     	add	x3, x0, #0x2d8
  7b7a60: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7a64: d2880000     	mov	x0, #0x4000             // =16384
  7b7a68: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7a6c: 8b000020     	add	x0, x1, x0
  7b7a70: b9799801     	ldr	w1, [x0, #0x3998]
  7b7a74: 9104e3e0     	add	x0, sp, #0x138
  7b7a78: 2a0103e2     	mov	w2, w1
  7b7a7c: aa0003e1     	mov	x1, x0
  7b7a80: aa0303e0     	mov	x0, x3
  7b7a84: 9406a5e1     	bl	0x961208
  7b7a88: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7a8c: d2880000     	mov	x0, #0x4000             // =16384
  7b7a90: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7a94: 8b000020     	add	x0, x1, x0
  7b7a98: b979a000     	ldr	w0, [x0, #0x39a0]
  7b7a9c: b9016fe0     	str	w0, [sp, #0x16c]
  7b7aa0: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7aa4: d2880000     	mov	x0, #0x4000             // =16384
  7b7aa8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7aac: 8b000020     	add	x0, x1, x0
  7b7ab0: b979a400     	ldr	w0, [x0, #0x39a4]
  7b7ab4: b90173e0     	str	w0, [sp, #0x170]
  7b7ab8: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7abc: d2880000     	mov	x0, #0x4000             // =16384
  7b7ac0: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7ac4: 8b000020     	add	x0, x1, x0
  7b7ac8: b979a800     	ldr	w0, [x0, #0x39a8]
  7b7acc: b90177e0     	str	w0, [sp, #0x174]
  7b7ad0: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7ad4: d28f2700     	mov	x0, #0x7938             // =31032
  7b7ad8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7adc: 8b000022     	add	x2, x1, x0
  7b7ae0: 52802180     	mov	w0, #0x10c              // =268
  7b7ae4: b9054be0     	str	w0, [sp, #0x548]
  7b7ae8: 911523e0     	add	x0, sp, #0x548
  7b7aec: aa0003e1     	mov	x1, x0
  7b7af0: aa0203e0     	mov	x0, x2
  7b7af4: 9400145c     	bl	0x7bcc64
  7b7af8: 94000fa2     	bl	0x7bb980
  7b7afc: 1e230000     	ucvtf	s0, w0
  7b7b00: bd013fe0     	str	s0, [sp, #0x13c]
  7b7b04: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7b08: d28f2700     	mov	x0, #0x7938             // =31032
  7b7b0c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7b10: 8b000022     	add	x2, x1, x0
  7b7b14: 528021a0     	mov	w0, #0x10d              // =269
  7b7b18: b9054fe0     	str	w0, [sp, #0x54c]
  7b7b1c: 911533e0     	add	x0, sp, #0x54c
  7b7b20: aa0003e1     	mov	x1, x0
  7b7b24: aa0203e0     	mov	x0, x2
  7b7b28: 9400144f     	bl	0x7bcc64
  7b7b2c: 94000f95     	bl	0x7bb980
  7b7b30: 1e230000     	ucvtf	s0, w0
  7b7b34: bd0143e0     	str	s0, [sp, #0x140]
  7b7b38: b94427e0     	ldr	w0, [sp, #0x424]
  7b7b3c: b90147e0     	str	w0, [sp, #0x144]
  7b7b40: 39187fff     	strb	wzr, [sp, #0x61f]
  7b7b44: 39187bff     	strb	wzr, [sp, #0x61e]
  7b7b48: 528000c0     	mov	w0, #0x6                // =6
  7b7b4c: b90603e0     	str	w0, [sp, #0x600]
  7b7b50: 528000c0     	mov	w0, #0x6                // =6
  7b7b54: b905ffe0     	str	w0, [sp, #0x5fc]
  7b7b58: b94417e0     	ldr	w0, [sp, #0x414]
  7b7b5c: b9061be0     	str	w0, [sp, #0x618]
  7b7b60: b94413e0     	ldr	w0, [sp, #0x410]
  7b7b64: b90617e0     	str	w0, [sp, #0x614]
  7b7b68: 3951c7e0     	ldrb	w0, [sp, #0x471]
  7b7b6c: 3917efe0     	strb	w0, [sp, #0x5fb]
  7b7b70: 3957efe0     	ldrb	w0, [sp, #0x5fb]
  7b7b74: 7100001f     	cmp	w0, #0x0
  7b7b78: 54000e80     	b.eq	0x7b7d48
  7b7b7c: bd4147e0     	ldr	s0, [sp, #0x144]
  7b7b80: 52a85680     	mov	w0, #0x42b40000         // =1119092736
  7b7b84: 1e270001     	fmov	s1, w0
  7b7b88: 1e212000     	fcmp	s0, s1
  7b7b8c: 54000160     	b.eq	0x7b7bb8
  7b7b90: bd4147e0     	ldr	s0, [sp, #0x144]
  7b7b94: 52a870e0     	mov	w0, #0x43870000         // =1132920832
  7b7b98: 1e270001     	fmov	s1, w0
  7b7b9c: 1e212000     	fcmp	s0, s1
  7b7ba0: 540000c0     	b.eq	0x7b7bb8
  7b7ba4: bd4147e0     	ldr	s0, [sp, #0x144]
  7b7ba8: 52b85680     	mov	w0, #-0x3d4c0000        // =-1028390912
  7b7bac: 1e270001     	fmov	s1, w0
  7b7bb0: 1e212000     	fcmp	s0, s1
  7b7bb4: 54000921     	b.ne	0x7b7cd8
  7b7bb8: bd4147e0     	ldr	s0, [sp, #0x144]
  7b7bbc: 52a870e0     	mov	w0, #0x43870000         // =1132920832
  7b7bc0: 1e270001     	fmov	s1, w0
  7b7bc4: 1e212000     	fcmp	s0, s1
  7b7bc8: 540000c0     	b.eq	0x7b7be0
  7b7bcc: bd4147e0     	ldr	s0, [sp, #0x144]
  7b7bd0: 52b85680     	mov	w0, #-0x3d4c0000        // =-1028390912
  7b7bd4: 1e270001     	fmov	s1, w0
  7b7bd8: 1e212000     	fcmp	s0, s1
  7b7bdc: 54000401     	b.ne	0x7b7c5c
  7b7be0: bd413fe1     	ldr	s1, [sp, #0x13c]
  7b7be4: 1e201000     	fmov	s0, #2.00000000
  7b7be8: 1e201821     	fdiv	s1, s1, s0
  7b7bec: b94417e0     	ldr	w0, [sp, #0x414]
  7b7bf0: 1e220002     	scvtf	s2, w0
  7b7bf4: bd413fe3     	ldr	s3, [sp, #0x13c]
  7b7bf8: 1e201000     	fmov	s0, #2.00000000
  7b7bfc: 1e201860     	fdiv	s0, s3, s0
  7b7c00: 1e203840     	fsub	s0, s2, s0
  7b7c04: 1e203821     	fsub	s1, s1, s0
  7b7c08: b9441fe0     	ldr	w0, [sp, #0x41c]
  7b7c0c: 1e220000     	scvtf	s0, w0
  7b7c10: 1e203820     	fsub	s0, s1, s0
  7b7c14: 1e380000     	fcvtzs	w0, s0
  7b7c18: b90617e0     	str	w0, [sp, #0x614]
  7b7c1c: bd4143e1     	ldr	s1, [sp, #0x140]
  7b7c20: 1e201000     	fmov	s0, #2.00000000
  7b7c24: 1e201821     	fdiv	s1, s1, s0
  7b7c28: b94413e0     	ldr	w0, [sp, #0x410]
  7b7c2c: 1e220002     	scvtf	s2, w0
  7b7c30: bd4143e3     	ldr	s3, [sp, #0x140]
  7b7c34: 1e201000     	fmov	s0, #2.00000000
  7b7c38: 1e201860     	fdiv	s0, s3, s0
  7b7c3c: 1e203840     	fsub	s0, s2, s0
  7b7c40: 1e202820     	fadd	s0, s1, s0
  7b7c44: 1e380000     	fcvtzs	w0, s0
  7b7c48: b9061be0     	str	w0, [sp, #0x618]
  7b7c4c: 39187fff     	strb	wzr, [sp, #0x61f]
  7b7c50: 52800020     	mov	w0, #0x1                // =1
  7b7c54: 39187be0     	strb	w0, [sp, #0x61e]
  7b7c58: 1400003c     	b	0x7b7d48
  7b7c5c: bd413fe1     	ldr	s1, [sp, #0x13c]
  7b7c60: 1e201000     	fmov	s0, #2.00000000
  7b7c64: 1e201821     	fdiv	s1, s1, s0
  7b7c68: b94417e0     	ldr	w0, [sp, #0x414]
  7b7c6c: 1e220002     	scvtf	s2, w0
  7b7c70: bd413fe3     	ldr	s3, [sp, #0x13c]
  7b7c74: 1e201000     	fmov	s0, #2.00000000
  7b7c78: 1e201860     	fdiv	s0, s3, s0
  7b7c7c: 1e203840     	fsub	s0, s2, s0
  7b7c80: 1e202820     	fadd	s0, s1, s0
  7b7c84: 1e380000     	fcvtzs	w0, s0
  7b7c88: b90617e0     	str	w0, [sp, #0x614]
  7b7c8c: bd4143e1     	ldr	s1, [sp, #0x140]
  7b7c90: 1e201000     	fmov	s0, #2.00000000
  7b7c94: 1e201821     	fdiv	s1, s1, s0
  7b7c98: b94413e0     	ldr	w0, [sp, #0x410]
  7b7c9c: 1e220002     	scvtf	s2, w0
  7b7ca0: bd4143e3     	ldr	s3, [sp, #0x140]
  7b7ca4: 1e201000     	fmov	s0, #2.00000000
  7b7ca8: 1e201860     	fdiv	s0, s3, s0
  7b7cac: 1e203840     	fsub	s0, s2, s0
  7b7cb0: 1e203821     	fsub	s1, s1, s0
  7b7cb4: b9441be0     	ldr	w0, [sp, #0x418]
  7b7cb8: 1e220000     	scvtf	s0, w0
  7b7cbc: 1e203820     	fsub	s0, s1, s0
  7b7cc0: 1e380000     	fcvtzs	w0, s0
  7b7cc4: b9061be0     	str	w0, [sp, #0x618]
  7b7cc8: 52800020     	mov	w0, #0x1                // =1
  7b7ccc: 39187fe0     	strb	w0, [sp, #0x61f]
  7b7cd0: 39187bff     	strb	wzr, [sp, #0x61e]
  7b7cd4: 1400001d     	b	0x7b7d48
  7b7cd8: bd4147e0     	ldr	s0, [sp, #0x144]
  7b7cdc: 52a86680     	mov	w0, #0x43340000         // =1127481344
  7b7ce0: 1e270001     	fmov	s1, w0
  7b7ce4: 1e212000     	fcmp	s0, s1
  7b7ce8: 540002c1     	b.ne	0x7b7d40
  7b7cec: bd4143e1     	ldr	s1, [sp, #0x140]
  7b7cf0: b9441fe1     	ldr	w1, [sp, #0x41c]
  7b7cf4: b9461be0     	ldr	w0, [sp, #0x618]
  7b7cf8: 0b000020     	add	w0, w1, w0
  7b7cfc: 1e220000     	scvtf	s0, w0
  7b7d00: 1e203820     	fsub	s0, s1, s0
  7b7d04: 1e380000     	fcvtzs	w0, s0
  7b7d08: b9061be0     	str	w0, [sp, #0x618]
  7b7d0c: bd413fe1     	ldr	s1, [sp, #0x13c]
  7b7d10: b9441be1     	ldr	w1, [sp, #0x418]
  7b7d14: b94617e0     	ldr	w0, [sp, #0x614]
  7b7d18: 0b000020     	add	w0, w1, w0
  7b7d1c: 1e220000     	scvtf	s0, w0
  7b7d20: 1e203820     	fsub	s0, s1, s0
  7b7d24: 1e380000     	fcvtzs	w0, s0
  7b7d28: b90617e0     	str	w0, [sp, #0x614]
  7b7d2c: 52800020     	mov	w0, #0x1                // =1
  7b7d30: 39187fe0     	strb	w0, [sp, #0x61f]
  7b7d34: 52800020     	mov	w0, #0x1                // =1
  7b7d38: 39187be0     	strb	w0, [sp, #0x61e]
  7b7d3c: 14000003     	b	0x7b7d48
  7b7d40: 39187fff     	strb	wzr, [sp, #0x61f]
  7b7d44: 39187bff     	strb	wzr, [sp, #0x61e]
  7b7d48: bd4423e0     	ldr	s0, [sp, #0x420]
  7b7d4c: 1e2e1001     	fmov	s1, #1.00000000
  7b7d50: 1e201820     	fdiv	s0, s1, s0
  7b7d54: 1e380001     	fcvtzs	w1, s0
  7b7d58: b94603e0     	ldr	w0, [sp, #0x600]
  7b7d5c: 1b007c20     	mul	w0, w1, w0
  7b7d60: 51000400     	sub	w0, w0, #0x1
  7b7d64: b905f7e0     	str	w0, [sp, #0x5f4]
  7b7d68: bd4423e0     	ldr	s0, [sp, #0x420]
  7b7d6c: 1e2e1001     	fmov	s1, #1.00000000
  7b7d70: 1e201820     	fdiv	s0, s1, s0
  7b7d74: 1e380001     	fcvtzs	w1, s0
  7b7d78: b945ffe0     	ldr	w0, [sp, #0x5fc]
  7b7d7c: 1b007c20     	mul	w0, w1, w0
  7b7d80: 51000400     	sub	w0, w0, #0x1
  7b7d84: b905f3e0     	str	w0, [sp, #0x5f0]
  7b7d88: 39587be0     	ldrb	w0, [sp, #0x61e]
  7b7d8c: 7100001f     	cmp	w0, #0x0
  7b7d90: 540000a0     	b.eq	0x7b7da4
  7b7d94: b9461be1     	ldr	w1, [sp, #0x618]
  7b7d98: b945f3e0     	ldr	w0, [sp, #0x5f0]
  7b7d9c: 4b000020     	sub	w0, w1, w0
  7b7da0: b9061be0     	str	w0, [sp, #0x618]
  7b7da4: 39587fe0     	ldrb	w0, [sp, #0x61f]
  7b7da8: 7100001f     	cmp	w0, #0x0
  7b7dac: 540000a0     	b.eq	0x7b7dc0
  7b7db0: b94617e1     	ldr	w1, [sp, #0x614]
  7b7db4: b945f7e0     	ldr	w0, [sp, #0x5f4]
  7b7db8: 4b000020     	sub	w0, w1, w0
  7b7dbc: b90617e0     	str	w0, [sp, #0x614]
  7b7dc0: b9461be5     	ldr	w5, [sp, #0x618]
  7b7dc4: b94617e2     	ldr	w2, [sp, #0x614]
  7b7dc8: b9441be1     	ldr	w1, [sp, #0x418]
  7b7dcc: b945f7e0     	ldr	w0, [sp, #0x5f4]
  7b7dd0: 0b000020     	add	w0, w1, w0
  7b7dd4: 2a0003e3     	mov	w3, w0
  7b7dd8: b9441fe1     	ldr	w1, [sp, #0x41c]
  7b7ddc: b945f3e0     	ldr	w0, [sp, #0x5f0]
  7b7de0: 0b000020     	add	w0, w1, w0
  7b7de4: 2a0003e1     	mov	w1, w0
  7b7de8: 911543e0     	add	x0, sp, #0x550
  7b7dec: 2a0103e4     	mov	w4, w1
  7b7df0: 2a0503e1     	mov	w1, w5
  7b7df4: 97f3569c     	bl	0x48d864
  7b7df8: 911803e0     	add	x0, sp, #0x600
  7b7dfc: a9750400     	ldp	x0, x1, [x0, #-0xb0]
  7b7e00: 910803e2     	add	x2, sp, #0x200
  7b7e04: a9348440     	stp	x0, x1, [x2, #-0xb8]
  7b7e08: b94423e0     	ldr	w0, [sp, #0x420]
  7b7e0c: b9013be0     	str	w0, [sp, #0x138]
  7b7e10: 528000a0     	mov	w0, #0x5                // =5
  7b7e14: b9015be0     	str	w0, [sp, #0x158]
  7b7e18: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7e1c: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b7e20: 8b000020     	add	x0, x1, x0
  7b7e24: f97c9001     	ldr	x1, [x0, #0x7920]
  7b7e28: d2834000     	mov	x0, #0x1a00             // =6656
  7b7e2c: 8b000020     	add	x0, x1, x0
  7b7e30: 97f27fe3     	bl	0x457dbc
  7b7e34: 12001c00     	and	w0, w0, #0xff
  7b7e38: b9015fe0     	str	w0, [sp, #0x15c]
  7b7e3c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7e40: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b7e44: 8b000020     	add	x0, x1, x0
  7b7e48: f97c9001     	ldr	x1, [x0, #0x7920]
  7b7e4c: d2835b00     	mov	x0, #0x1ad8             // =6872
  7b7e50: 8b000020     	add	x0, x1, x0
  7b7e54: 97f27fda     	bl	0x457dbc
  7b7e58: 12001c00     	and	w0, w0, #0xff
  7b7e5c: b90163e0     	str	w0, [sp, #0x160]
  7b7e60: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7e64: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b7e68: 8b000020     	add	x0, x1, x0
  7b7e6c: f97c9001     	ldr	x1, [x0, #0x7920]
  7b7e70: d2837600     	mov	x0, #0x1bb0             // =7088
  7b7e74: 8b000020     	add	x0, x1, x0
  7b7e78: 97f27fd1     	bl	0x457dbc
  7b7e7c: 12001c00     	and	w0, w0, #0xff
  7b7e80: b90167e0     	str	w0, [sp, #0x164]
  7b7e84: b9016bff     	str	wzr, [sp, #0x168]
  7b7e88: f9402fe0     	ldr	x0, [sp, #0x58]
  7b7e8c: 910b6007     	add	x7, x0, #0x2d8
  7b7e90: f9402fe1     	ldr	x1, [sp, #0x58]
  7b7e94: d28f2d00     	mov	x0, #0x7968             // =31080
  7b7e98: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b7e9c: 8b000021     	add	x1, x1, x0
  7b7ea0: f9402fe0     	ldr	x0, [sp, #0x58]
  7b7ea4: 910b0004     	add	x4, x0, #0x2c0
  7b7ea8: f94233e5     	ldr	x5, [sp, #0x460]
  7b7eac: 9104e3e3     	add	x3, sp, #0x138
  7b7eb0: 910223e2     	add	x2, sp, #0x88
  7b7eb4: 910383e0     	add	x0, sp, #0xe0
  7b7eb8: aa0503e6     	mov	x6, x5
  7b7ebc: aa0403e5     	mov	x5, x4
  7b7ec0: aa0303e4     	mov	x4, x3
  7b7ec4: aa0203e3     	mov	x3, x2
  7b7ec8: aa0003e2     	mov	x2, x0
  7b7ecc: aa0703e0     	mov	x0, x7
  7b7ed0: 9406aed6     	bl	0x963a28
  7b7ed4: b90613ff     	str	wzr, [sp, #0x610]
  7b7ed8: b9060fff     	str	wzr, [sp, #0x60c]
  7b7edc: 3957efe0     	ldrb	w0, [sp, #0x5fb]
  7b7ee0: 7100001f     	cmp	w0, #0x0
  7b7ee4: 54000360     	b.eq	0x7b7f50
  7b7ee8: 910383e0     	add	x0, sp, #0xe0
  7b7eec: 94053157     	bl	0x904448
  7b7ef0: 2a0003e1     	mov	w1, w0
  7b7ef4: bd413be1     	ldr	s1, [sp, #0x138]
  7b7ef8: b9441be0     	ldr	w0, [sp, #0x418]
  7b7efc: 1e220000     	scvtf	s0, w0
  7b7f00: 1e200820     	fmul	s0, s1, s0
  7b7f04: 1e22c001     	fcvt	d1, s0
  7b7f08: 1e6c1000     	fmov	d0, #0.50000000
  7b7f0c: 1e602820     	fadd	d0, d1, d0
  7b7f10: 1e780000     	fcvtzs	w0, d0
  7b7f14: 4b000020     	sub	w0, w1, w0
  7b7f18: b90613e0     	str	w0, [sp, #0x610]
  7b7f1c: 910383e0     	add	x0, sp, #0xe0
  7b7f20: 9405314c     	bl	0x904450
  7b7f24: 2a0003e1     	mov	w1, w0
  7b7f28: bd413be1     	ldr	s1, [sp, #0x138]
  7b7f2c: b9441fe0     	ldr	w0, [sp, #0x41c]
  7b7f30: 1e220000     	scvtf	s0, w0
  7b7f34: 1e200820     	fmul	s0, s1, s0
  7b7f38: 1e22c001     	fcvt	d1, s0
  7b7f3c: 1e6c1000     	fmov	d0, #0.50000000
  7b7f40: 1e602820     	fadd	d0, d1, d0
  7b7f44: 1e780000     	fcvtzs	w0, d0
  7b7f48: 4b000020     	sub	w0, w1, w0
  7b7f4c: b9060fe0     	str	w0, [sp, #0x60c]
  7b7f50: 910383e0     	add	x0, sp, #0xe0
  7b7f54: 9405313d     	bl	0x904448
  7b7f58: 2a0003e1     	mov	w1, w0
  7b7f5c: b94613e0     	ldr	w0, [sp, #0x610]
  7b7f60: 4b000020     	sub	w0, w1, w0
  7b7f64: b90563e0     	str	w0, [sp, #0x560]
  7b7f68: 911003e0     	add	x0, sp, #0x400
  7b7f6c: 9101a001     	add	x1, x0, #0x68
  7b7f70: 911583e0     	add	x0, sp, #0x560
  7b7f74: 97f2a05b     	bl	0x4600e0
  7b7f78: aa0003e1     	mov	x1, x0
  7b7f7c: f94227e0     	ldr	x0, [sp, #0x448]
  7b7f80: b9400021     	ldr	w1, [x1]
  7b7f84: b9000401     	str	w1, [x0, #0x4]
  7b7f88: 910383e0     	add	x0, sp, #0xe0
  7b7f8c: 94053131     	bl	0x904450
  7b7f90: 2a0003e1     	mov	w1, w0
  7b7f94: b9460fe0     	ldr	w0, [sp, #0x60c]
  7b7f98: 4b000020     	sub	w0, w1, w0
  7b7f9c: b90567e0     	str	w0, [sp, #0x564]
  7b7fa0: 911003e0     	add	x0, sp, #0x400
  7b7fa4: 9101b001     	add	x1, x0, #0x6c
  7b7fa8: 911593e0     	add	x0, sp, #0x564
  7b7fac: 97f2a04d     	bl	0x4600e0
  7b7fb0: aa0003e1     	mov	x1, x0
  7b7fb4: f94227e0     	ldr	x0, [sp, #0x448]
  7b7fb8: b9400021     	ldr	w1, [x1]
  7b7fbc: b9000801     	str	w1, [x0, #0x8]
  7b7fc0: f94227e0     	ldr	x0, [sp, #0x448]
  7b7fc4: b9400401     	ldr	w1, [x0, #0x4]
  7b7fc8: b94613e0     	ldr	w0, [sp, #0x610]
  7b7fcc: 0b000021     	add	w1, w1, w0
  7b7fd0: f94227e2     	ldr	x2, [sp, #0x448]
  7b7fd4: 2a0103e0     	mov	w0, w1
  7b7fd8: 531f7800     	lsl	w0, w0, #1
  7b7fdc: 0b010000     	add	w0, w0, w1
  7b7fe0: b9000c40     	str	w0, [x2, #0xc]
  7b7fe4: 910223e0     	add	x0, sp, #0x88
  7b7fe8: 94053118     	bl	0x904448
  7b7fec: 2a0003e1     	mov	w1, w0
  7b7ff0: b94613e0     	ldr	w0, [sp, #0x610]
  7b7ff4: 4b000020     	sub	w0, w1, w0
  7b7ff8: b9056be0     	str	w0, [sp, #0x568]
  7b7ffc: 911003e0     	add	x0, sp, #0x400
  7b8000: 9101a001     	add	x1, x0, #0x68
  7b8004: 9115a3e0     	add	x0, sp, #0x568
  7b8008: 97f2a036     	bl	0x4600e0
  7b800c: aa0003e1     	mov	x1, x0
  7b8010: f9422be0     	ldr	x0, [sp, #0x450]
  7b8014: b9400021     	ldr	w1, [x1]
  7b8018: b9000401     	str	w1, [x0, #0x4]
  7b801c: 910223e0     	add	x0, sp, #0x88
  7b8020: 9405310c     	bl	0x904450
  7b8024: 2a0003e1     	mov	w1, w0
  7b8028: b9460fe0     	ldr	w0, [sp, #0x60c]
  7b802c: 4b000020     	sub	w0, w1, w0
  7b8030: b9056fe0     	str	w0, [sp, #0x56c]
  7b8034: 911003e0     	add	x0, sp, #0x400
  7b8038: 9101b001     	add	x1, x0, #0x6c
  7b803c: 9115b3e0     	add	x0, sp, #0x56c
  7b8040: 97f2a028     	bl	0x4600e0
  7b8044: aa0003e1     	mov	x1, x0
  7b8048: f9422be0     	ldr	x0, [sp, #0x450]
  7b804c: b9400021     	ldr	w1, [x1]
  7b8050: b9000801     	str	w1, [x0, #0x8]
  7b8054: f9422be0     	ldr	x0, [sp, #0x450]
  7b8058: b9400402     	ldr	w2, [x0, #0x4]
  7b805c: f9422be0     	ldr	x0, [sp, #0x450]
  7b8060: b94613e1     	ldr	w1, [sp, #0x610]
  7b8064: 0b010041     	add	w1, w2, w1
  7b8068: b9000c01     	str	w1, [x0, #0xc]
  7b806c: f94227e0     	ldr	x0, [sp, #0x448]
  7b8070: b9400400     	ldr	w0, [x0, #0x4]
  7b8074: 1e220001     	scvtf	s1, w0
  7b8078: bd413be0     	ldr	s0, [sp, #0x138]
  7b807c: 1e201820     	fdiv	s0, s1, s0
  7b8080: 1e380000     	fcvtzs	w0, s0
  7b8084: b9041be0     	str	w0, [sp, #0x418]
  7b8088: f94227e0     	ldr	x0, [sp, #0x448]
  7b808c: b9400800     	ldr	w0, [x0, #0x8]
  7b8090: 1e220001     	scvtf	s1, w0
  7b8094: bd413be0     	ldr	s0, [sp, #0x138]
  7b8098: 1e201820     	fdiv	s0, s1, s0
  7b809c: 1e380000     	fcvtzs	w0, s0
  7b80a0: b9041fe0     	str	w0, [sp, #0x41c]
  7b80a4: f94233e0     	ldr	x0, [sp, #0x460]
  7b80a8: 39400000     	ldrb	w0, [x0]
  7b80ac: 52000000     	eor	w0, w0, #0x1
  7b80b0: 12001c00     	and	w0, w0, #0xff
  7b80b4: 7100001f     	cmp	w0, #0x0
  7b80b8: 54000f20     	b.eq	0x7b829c
  7b80bc: b9060bff     	str	wzr, [sp, #0x608]
  7b80c0: 3957efe0     	ldrb	w0, [sp, #0x5fb]
  7b80c4: 7100001f     	cmp	w0, #0x0
  7b80c8: 54000300     	b.eq	0x7b8128
  7b80cc: 39587fe0     	ldrb	w0, [sp, #0x61f]
  7b80d0: 7100001f     	cmp	w0, #0x0
  7b80d4: 54000080     	b.eq	0x7b80e4
  7b80d8: b94613e0     	ldr	w0, [sp, #0x610]
  7b80dc: 531e7400     	lsl	w0, w0, #2
  7b80e0: 14000002     	b	0x7b80e8
  7b80e4: 52800000     	mov	w0, #0x0                // =0
  7b80e8: b9460be1     	ldr	w1, [sp, #0x608]
  7b80ec: 0b000020     	add	w0, w1, w0
  7b80f0: b9060be0     	str	w0, [sp, #0x608]
  7b80f4: 39587be0     	ldrb	w0, [sp, #0x61e]
  7b80f8: 7100001f     	cmp	w0, #0x0
  7b80fc: 540000e0     	b.eq	0x7b8118
  7b8100: 910383e0     	add	x0, sp, #0xe0
  7b8104: 940530d9     	bl	0x904468
  7b8108: 2a0003e1     	mov	w1, w0
  7b810c: b9460fe0     	ldr	w0, [sp, #0x60c]
  7b8110: 1b007c20     	mul	w0, w1, w0
  7b8114: 14000002     	b	0x7b811c
  7b8118: 52800000     	mov	w0, #0x0                // =0
  7b811c: b9460be1     	ldr	w1, [sp, #0x608]
  7b8120: 0b000020     	add	w0, w1, w0
  7b8124: b9060be0     	str	w0, [sp, #0x608]
  7b8128: 3951c3e0     	ldrb	w0, [sp, #0x470]
  7b812c: 7100001f     	cmp	w0, #0x0
  7b8130: 54000660     	b.eq	0x7b81fc
  7b8134: 9101a3e0     	add	x0, sp, #0x68
  7b8138: 52800021     	mov	w1, #0x1                // =1
  7b813c: 97fd4f35     	bl	0x70be10
  7b8140: f94227e0     	ldr	x0, [sp, #0x448]
  7b8144: 52800141     	mov	w1, #0xa                // =10
  7b8148: b9000001     	str	w1, [x0]
  7b814c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b8150: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8154: 8b000020     	add	x0, x1, x0
  7b8158: f97c9414     	ldr	x20, [x0, #0x7928]
  7b815c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b8160: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8164: 8b000020     	add	x0, x1, x0
  7b8168: f97c9400     	ldr	x0, [x0, #0x7928]
  7b816c: f9400000     	ldr	x0, [x0]
  7b8170: 9100a000     	add	x0, x0, #0x28
  7b8174: f9400013     	ldr	x19, [x0]
  7b8178: 910383e0     	add	x0, sp, #0xe0
  7b817c: 94053093     	bl	0x9043c8
  7b8180: aa0003e1     	mov	x1, x0
  7b8184: b9860be0     	ldrsw	x0, [sp, #0x608]
  7b8188: 8b000035     	add	x21, x1, x0
  7b818c: f94227e0     	ldr	x0, [sp, #0x448]
  7b8190: b9400416     	ldr	w22, [x0, #0x4]
  7b8194: f94227e0     	ldr	x0, [sp, #0x448]
  7b8198: b9400817     	ldr	w23, [x0, #0x8]
  7b819c: b94477f8     	ldr	w24, [sp, #0x474]
  7b81a0: f94227e0     	ldr	x0, [sp, #0x448]
  7b81a4: f9400819     	ldr	x25, [x0, #0x10]
  7b81a8: b9442ffa     	ldr	w26, [sp, #0x42c]
  7b81ac: 910383e0     	add	x0, sp, #0xe0
  7b81b0: 940530ae     	bl	0x904468
  7b81b4: 2a0003e7     	mov	w7, w0
  7b81b8: 2a1a03e6     	mov	w6, w26
  7b81bc: aa1903e5     	mov	x5, x25
  7b81c0: 2a1803e4     	mov	w4, w24
  7b81c4: 2a1703e3     	mov	w3, w23
  7b81c8: 2a1603e2     	mov	w2, w22
  7b81cc: aa1503e1     	mov	x1, x21
  7b81d0: aa1403e0     	mov	x0, x20
  7b81d4: d63f0260     	blr	x19
  7b81d8: b90433e0     	str	w0, [sp, #0x430]
  7b81dc: 9101a3e0     	add	x0, sp, #0x68
  7b81e0: 97fd4f40     	bl	0x70bee0
  7b81e4: 9101a3e0     	add	x0, sp, #0x68
  7b81e8: 97fd4fd2     	bl	0x70c130
  7b81ec: b9047be0     	str	w0, [sp, #0x478]
  7b81f0: 9101a3e0     	add	x0, sp, #0x68
  7b81f4: 97fd4f1b     	bl	0x70be60
  7b81f8: 14000017     	b	0x7b8254
  7b81fc: f94227e0     	ldr	x0, [sp, #0x448]
  7b8200: b900001f     	str	wzr, [x0]
  7b8204: 910383e0     	add	x0, sp, #0xe0
  7b8208: 94053070     	bl	0x9043c8
  7b820c: aa0003e1     	mov	x1, x0
  7b8210: b9860be0     	ldrsw	x0, [sp, #0x608]
  7b8214: 8b000033     	add	x19, x1, x0
  7b8218: f94227e0     	ldr	x0, [sp, #0x448]
  7b821c: f9400814     	ldr	x20, [x0, #0x10]
  7b8220: f94227e0     	ldr	x0, [sp, #0x448]
  7b8224: b9400415     	ldr	w21, [x0, #0x4]
  7b8228: f94227e0     	ldr	x0, [sp, #0x448]
  7b822c: b9400816     	ldr	w22, [x0, #0x8]
  7b8230: 910383e0     	add	x0, sp, #0xe0
  7b8234: 9405308d     	bl	0x904468
  7b8238: 2a0003e5     	mov	w5, w0
  7b823c: 2a1603e4     	mov	w4, w22
  7b8240: 2a1503e3     	mov	w3, w21
  7b8244: aa1403e2     	mov	x2, x20
  7b8248: aa1303e1     	mov	x1, x19
  7b824c: f9402fe0     	ldr	x0, [sp, #0x58]
  7b8250: 94000577     	bl	0x7b982c
  7b8254: 910223e0     	add	x0, sp, #0x88
  7b8258: 9405305c     	bl	0x9043c8
  7b825c: aa0003f6     	mov	x22, x0
  7b8260: f9422be0     	ldr	x0, [sp, #0x450]
  7b8264: f9400813     	ldr	x19, [x0, #0x10]
  7b8268: f9422be0     	ldr	x0, [sp, #0x450]
  7b826c: b9400414     	ldr	w20, [x0, #0x4]
  7b8270: f9422be0     	ldr	x0, [sp, #0x450]
  7b8274: b9400815     	ldr	w21, [x0, #0x8]
  7b8278: 910223e0     	add	x0, sp, #0x88
  7b827c: 9405307b     	bl	0x904468
  7b8280: 2a0003e5     	mov	w5, w0
  7b8284: 2a1503e4     	mov	w4, w21
  7b8288: 2a1403e3     	mov	w3, w20
  7b828c: aa1303e2     	mov	x2, x19
  7b8290: aa1603e1     	mov	x1, x22
  7b8294: f9402fe0     	ldr	x0, [sp, #0x58]
  7b8298: 94000535     	bl	0x7b976c
  7b829c: f9432be0     	ldr	x0, [sp, #0x650]
  7b82a0: f100001f     	cmp	x0, #0x0
  7b82a4: 54000060     	b.eq	0x7b82b0
  7b82a8: f9422fe0     	ldr	x0, [sp, #0x458]
  7b82ac: 9404294d     	bl	0x8c27e0
  7b82b0: f94327e0     	ldr	x0, [sp, #0x648]
  7b82b4: f100001f     	cmp	x0, #0x0
  7b82b8: 54000060     	b.eq	0x7b82c4
  7b82bc: f9422fe0     	ldr	x0, [sp, #0x458]
  7b82c0: 940428ea     	bl	0x8c2668
  7b82c4: f94233e0     	ldr	x0, [sp, #0x460]
  7b82c8: 39400000     	ldrb	w0, [x0]
  7b82cc: 7100001f     	cmp	w0, #0x0
  7b82d0: 1a9f17e0     	cset	w0, eq
  7b82d4: 12001c00     	and	w0, w0, #0xff
  7b82d8: 391003e0     	strb	w0, [sp, #0x400]
  7b82dc: f9402fe1     	ldr	x1, [sp, #0x58]
  7b82e0: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b82e4: 8b000020     	add	x0, x1, x0
  7b82e8: f97c8c00     	ldr	x0, [x0, #0x7918]
  7b82ec: 91078013     	add	x19, x0, #0x1e0
  7b82f0: 911003e1     	add	x1, sp, #0x400
  7b82f4: 9115c3e0     	add	x0, sp, #0x570
  7b82f8: 97f35a9e     	bl	0x48ed70
  7b82fc: 9115c3e0     	add	x0, sp, #0x570
  7b8300: aa0003e1     	mov	x1, x0
  7b8304: aa1303e0     	mov	x0, x19
  7b8308: 97f35f3c     	bl	0x48fff8
  7b830c: 9115c3e0     	add	x0, sp, #0x570
  7b8310: 97f35a8f     	bl	0x48ed4c
  7b8314: 910223e0     	add	x0, sp, #0x88
  7b8318: 94052e64     	bl	0x903ca8
  7b831c: 910383e0     	add	x0, sp, #0xe0
  7b8320: 94052e62     	bl	0x903ca8
  7b8324: 9104e3e0     	add	x0, sp, #0x138
  7b8328: 94000f07     	bl	0x7bbf44
  7b832c: 52800033     	mov	w19, #0x1               // =1
  7b8330: 911003e0     	add	x0, sp, #0x400
  7b8334: 97f35a86     	bl	0x48ed4c
  7b8338: 7100067f     	cmp	w19, #0x1
  7b833c: 1400002e     	b	0x7b83f4
  7b8340: aa0003f3     	mov	x19, x0
  7b8344: 911203e0     	add	x0, sp, #0x480
  7b8348: 97f14bb6     	bl	0x40b220
  7b834c: 14000026     	b	0x7b83e4
  7b8350: aa0003f3     	mov	x19, x0
  7b8354: 911223e0     	add	x0, sp, #0x488
  7b8358: 97f1e4f2     	bl	0x431720
  7b835c: 14000002     	b	0x7b8364
  7b8360: aa0003f3     	mov	x19, x0
  7b8364: 9101a3e0     	add	x0, sp, #0x68
  7b8368: 97f1e4ee     	bl	0x431720
  7b836c: 1400001e     	b	0x7b83e4
  7b8370: aa0003f3     	mov	x19, x0
  7b8374: 9112a3e0     	add	x0, sp, #0x4a8
  7b8378: 97f35a75     	bl	0x48ed4c
  7b837c: 1400001a     	b	0x7b83e4
  7b8380: aa0003f3     	mov	x19, x0
  7b8384: 9114a3e0     	add	x0, sp, #0x528
  7b8388: 97f1e4e6     	bl	0x431720
  7b838c: 14000016     	b	0x7b83e4
  7b8390: aa0003f3     	mov	x19, x0
  7b8394: 9101a3e0     	add	x0, sp, #0x68
  7b8398: 97fd4eb2     	bl	0x70be60
  7b839c: 14000006     	b	0x7b83b4
  7b83a0: aa0003f3     	mov	x19, x0
  7b83a4: 9115c3e0     	add	x0, sp, #0x570
  7b83a8: 97f35a69     	bl	0x48ed4c
  7b83ac: 14000002     	b	0x7b83b4
  7b83b0: aa0003f3     	mov	x19, x0
  7b83b4: 910223e0     	add	x0, sp, #0x88
  7b83b8: 94052e3c     	bl	0x903ca8
  7b83bc: 14000002     	b	0x7b83c4
  7b83c0: aa0003f3     	mov	x19, x0
  7b83c4: 910383e0     	add	x0, sp, #0xe0
  7b83c8: 94052e38     	bl	0x903ca8
  7b83cc: 14000002     	b	0x7b83d4
  7b83d0: aa0003f3     	mov	x19, x0
  7b83d4: 9104e3e0     	add	x0, sp, #0x138
  7b83d8: 94000edb     	bl	0x7bbf44
  7b83dc: 14000002     	b	0x7b83e4
  7b83e0: aa0003f3     	mov	x19, x0
  7b83e4: 911003e0     	add	x0, sp, #0x400
  7b83e8: 97f35a59     	bl	0x48ed4c
  7b83ec: aa1303e0     	mov	x0, x19
  7b83f0: 97f148d8     	bl	0x40a750
  7b83f4: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7b83f8: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7b83fc: a94363f7     	ldp	x23, x24, [sp, #0x30]
  7b8400: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  7b8404: a9407bfd     	ldp	x29, x30, [sp]
  7b8408: 911983ff     	add	sp, sp, #0x660
  7b840c: d65f03c0     	ret
