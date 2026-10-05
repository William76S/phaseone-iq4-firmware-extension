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
