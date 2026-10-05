  7b54f8: d28f2700     	mov	x0, #0x7938             // =31032
  7b54fc: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5500: 8b000020     	add	x0, x1, x0
  7b5504: 94001942     	bl	0x7bba0c
  7b5508: f9402fe1     	ldr	x1, [sp, #0x58]
  7b550c: d28f2d00     	mov	x0, #0x7968             // =31080
  7b5510: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5514: 8b000020     	add	x0, x1, x0
  7b5518: 9400196a     	bl	0x7bbac0
  7b551c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b5520: d2880000     	mov	x0, #0x4000             // =16384
  7b5524: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5528: 8b000020     	add	x0, x1, x0
  7b552c: b9399c1f     	str	wzr, [x0, #0x399c]
  7b5530: f9402fe1     	ldr	x1, [sp, #0x58]
  7b5534: d28f3400     	mov	x0, #0x79a0             // =31136
  7b5538: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b553c: 8b000020     	add	x0, x1, x0
  7b5540: 0f000402     	movi	v2.2s, #0x0
  7b5544: 0f000401     	movi	v1.2s, #0x0
  7b5548: 0f000400     	movi	v0.2s, #0x0
  7b554c: 97f360e4     	bl	0x48d8dc
  7b5550: f9402fe0     	ldr	x0, [sp, #0x58]
  7b5554: 910b6000     	add	x0, x0, #0x2d8
  7b5558: 9101a3e1     	add	x1, sp, #0x68
  7b555c: aa0103e8     	mov	x8, x1
  7b5560: 9406b158     	bl	0x961ac0
  7b5564: f9402fe1     	ldr	x1, [sp, #0x58]
  7b5568: d28f1d00     	mov	x0, #0x78e8             // =30952
  7b556c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5570: 8b000020     	add	x0, x1, x0
  7b5574: 9101a3e1     	add	x1, sp, #0x68
  7b5578: 94001bc2     	bl	0x7bc480
  7b557c: 9101a3e0     	add	x0, sp, #0x68
  7b5580: 97f1f095     	bl	0x4317d4
  7b5584: f9402fe0     	ldr	x0, [sp, #0x58]
  7b5588: 910b6000     	add	x0, x0, #0x2d8
  7b558c: 910203e1     	add	x1, sp, #0x80
  7b5590: aa0103e8     	mov	x8, x1
  7b5594: 9406b421     	bl	0x962618
  7b5598: f9402fe1     	ldr	x1, [sp, #0x58]
  7b559c: d28f2000     	mov	x0, #0x7900             // =30976
  7b55a0: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b55a4: 8b000020     	add	x0, x1, x0
  7b55a8: 910203e1     	add	x1, sp, #0x80
  7b55ac: 94001bc6     	bl	0x7bc4c4
  7b55b0: 910203e0     	add	x0, sp, #0x80
  7b55b4: 97f1f1c8     	bl	0x431cd4
  7b55b8: 94075e64     	bl	0x98cf48
  7b55bc: aa0003e2     	mov	x2, x0
  7b55c0: f9402fe1     	ldr	x1, [sp, #0x58]
  7b55c4: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b55c8: 8b000020     	add	x0, x1, x0
  7b55cc: f93c9402     	str	x2, [x0, #0x7928]
  7b55d0: 52800060     	mov	w0, #0x3                // =3
  7b55d4: b9009fe0     	str	w0, [sp, #0x9c]
  7b55d8: f9402fe1     	ldr	x1, [sp, #0x58]
  7b55dc: d28f1d00     	mov	x0, #0x78e8             // =30952
  7b55e0: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b55e4: 8b000033     	add	x19, x1, x0
  7b55e8: f9402fe1     	ldr	x1, [sp, #0x58]
  7b55ec: d28f1d00     	mov	x0, #0x78e8             // =30952
  7b55f0: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b55f4: 8b000020     	add	x0, x1, x0
  7b55f8: 97f1f1cb     	bl	0x431d24
  7b55fc: 91000c00     	add	x0, x0, #0x3
  7b5600: aa0003e1     	mov	x1, x0
  7b5604: aa1303e0     	mov	x0, x19
  7b5608: 94001bc0     	bl	0x7bc508
  7b560c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b5610: d28f2000     	mov	x0, #0x7900             // =30976
  7b5614: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5618: 8b000033     	add	x19, x1, x0
  7b561c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b5620: d28f2000     	mov	x0, #0x7900             // =30976
  7b5624: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5628: 8b000020     	add	x0, x1, x0
  7b562c: 97f1f94b     	bl	0x433b58
  7b5630: 91000c00     	add	x0, x0, #0x3
  7b5634: aa0003e1     	mov	x1, x0
  7b5638: aa1303e0     	mov	x0, x19
  7b563c: 94001c09     	bl	0x7bc660
  7b5640: 14000029     	b	0x7b56e4
  7b5644: aa0003f3     	mov	x19, x0
  7b5648: f9402fe1     	ldr	x1, [sp, #0x58]
  7b564c: d28f2d00     	mov	x0, #0x7968             // =31080
  7b5650: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5654: 8b000020     	add	x0, x1, x0
  7b5658: 94001929     	bl	0x7bbafc
  7b565c: f9402fe1     	ldr	x1, [sp, #0x58]
  7b5660: d28f2700     	mov	x0, #0x7938             // =31032
  7b5664: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b5668: 8b000020     	add	x0, x1, x0
  7b566c: 940018f0     	bl	0x7bba2c
