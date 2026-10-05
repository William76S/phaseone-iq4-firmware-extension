  7ba364: a9b37bfd     	stp	x29, x30, [sp, #-0xd0]!
  7ba368: 910003fd     	mov	x29, sp
  7ba36c: f9000bf3     	str	x19, [sp, #0x10]
  7ba370: f9001fe0     	str	x0, [sp, #0x38]
  7ba374: f9001be1     	str	x1, [sp, #0x30]
  7ba378: f90017e2     	str	x2, [sp, #0x28]
  7ba37c: f94017e1     	ldr	x1, [sp, #0x28]
  7ba380: d2901400     	mov	x0, #0x80a0             // =32928
  7ba384: f2a00060     	movk	x0, #0x3, lsl #16
  7ba388: 8b000020     	add	x0, x1, x0
  7ba38c: f90067e0     	str	x0, [sp, #0xc8]
  7ba390: 52802060     	mov	w0, #0x103              // =259
  7ba394: b9004fe0     	str	w0, [sp, #0x4c]
  7ba398: 910133e0     	add	x0, sp, #0x4c
  7ba39c: aa0003e1     	mov	x1, x0
  7ba3a0: f9401be0     	ldr	x0, [sp, #0x30]
  7ba3a4: 94000a30     	bl	0x7bcc64
  7ba3a8: aa0003e2     	mov	x2, x0
  7ba3ac: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba3b0: b9407c00     	ldr	w0, [x0, #0x7c]
  7ba3b4: 2a0003e1     	mov	w1, w0
  7ba3b8: aa0203e0     	mov	x0, x2
  7ba3bc: 94000549     	bl	0x7bb8e0
  7ba3c0: 528020a0     	mov	w0, #0x105              // =261
  7ba3c4: b90053e0     	str	w0, [sp, #0x50]
  7ba3c8: 910143e0     	add	x0, sp, #0x50
  7ba3cc: aa0003e1     	mov	x1, x0
  7ba3d0: f9401be0     	ldr	x0, [sp, #0x30]
  7ba3d4: 94000a24     	bl	0x7bcc64
  7ba3d8: aa0003e2     	mov	x2, x0
  7ba3dc: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba3e0: b9421400     	ldr	w0, [x0, #0x214]
  7ba3e4: 2a0003e1     	mov	w1, w0
  7ba3e8: aa0203e0     	mov	x0, x2
  7ba3ec: 9400053d     	bl	0x7bb8e0
  7ba3f0: 52808020     	mov	w0, #0x401              // =1025
  7ba3f4: b90057e0     	str	w0, [sp, #0x54]
  7ba3f8: 910153e0     	add	x0, sp, #0x54
  7ba3fc: aa0003e1     	mov	x1, x0
  7ba400: f9401be0     	ldr	x0, [sp, #0x30]
  7ba404: 94000a18     	bl	0x7bcc64
  7ba408: aa0003e1     	mov	x1, x0
  7ba40c: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba410: bd40bc00     	ldr	s0, [x0, #0xbc]
  7ba414: aa0103e0     	mov	x0, x1
  7ba418: 9400053e     	bl	0x7bb910
  7ba41c: 52804160     	mov	w0, #0x20b              // =523
  7ba420: b9005be0     	str	w0, [sp, #0x58]
  7ba424: 910163e0     	add	x0, sp, #0x58
  7ba428: aa0003e1     	mov	x1, x0
  7ba42c: f9401be0     	ldr	x0, [sp, #0x30]
  7ba430: 94000a0d     	bl	0x7bcc64
  7ba434: aa0003e2     	mov	x2, x0
  7ba438: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba43c: b9420400     	ldr	w0, [x0, #0x204]
  7ba440: 2a0003e1     	mov	w1, w0
  7ba444: aa0203e0     	mov	x0, x2
  7ba448: 94000526     	bl	0x7bb8e0
  7ba44c: 52804180     	mov	w0, #0x20c              // =524
  7ba450: b9005fe0     	str	w0, [sp, #0x5c]
  7ba454: 910173e0     	add	x0, sp, #0x5c
  7ba458: aa0003e1     	mov	x1, x0
  7ba45c: f9401be0     	ldr	x0, [sp, #0x30]
  7ba460: 94000a01     	bl	0x7bcc64
  7ba464: aa0003e2     	mov	x2, x0
  7ba468: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba46c: b9420800     	ldr	w0, [x0, #0x208]
  7ba470: 2a0003e1     	mov	w1, w0
  7ba474: aa0203e0     	mov	x0, x2
  7ba478: 9400051a     	bl	0x7bb8e0
  7ba47c: 528048a0     	mov	w0, #0x245              // =581
  7ba480: b90063e0     	str	w0, [sp, #0x60]
  7ba484: 910183e0     	add	x0, sp, #0x60
  7ba488: aa0003e1     	mov	x1, x0
  7ba48c: f9401be0     	ldr	x0, [sp, #0x30]
  7ba490: 940009f5     	bl	0x7bcc64
  7ba494: aa0003e1     	mov	x1, x0
  7ba498: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba49c: bd420c00     	ldr	s0, [x0, #0x20c]
  7ba4a0: aa0103e0     	mov	x0, x1
  7ba4a4: 9400051b     	bl	0x7bb910
  7ba4a8: 528043c0     	mov	w0, #0x21e              // =542
  7ba4ac: b90067e0     	str	w0, [sp, #0x64]
  7ba4b0: 910193e0     	add	x0, sp, #0x64
  7ba4b4: aa0003e1     	mov	x1, x0
  7ba4b8: f9401be0     	ldr	x0, [sp, #0x30]
  7ba4bc: 940009ea     	bl	0x7bcc64
  7ba4c0: aa0003e2     	mov	x2, x0
  7ba4c4: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba4c8: b9422c00     	ldr	w0, [x0, #0x22c]
  7ba4cc: 2a0003e1     	mov	w1, w0
  7ba4d0: aa0203e0     	mov	x0, x2
  7ba4d4: 94000503     	bl	0x7bb8e0
  7ba4d8: 52802000     	mov	w0, #0x100              // =256
  7ba4dc: b9006be0     	str	w0, [sp, #0x68]
  7ba4e0: 9101a3e0     	add	x0, sp, #0x68
  7ba4e4: aa0003e1     	mov	x1, x0
  7ba4e8: f9401be0     	ldr	x0, [sp, #0x30]
  7ba4ec: 940009de     	bl	0x7bcc64
  7ba4f0: 52800001     	mov	w1, #0x0                // =0
  7ba4f4: 940004fb     	bl	0x7bb8e0
  7ba4f8: 52804520     	mov	w0, #0x229              // =553
  7ba4fc: b9006fe0     	str	w0, [sp, #0x6c]
  7ba500: 9101b3e0     	add	x0, sp, #0x6c
  7ba504: aa0003e1     	mov	x1, x0
  7ba508: f9401be0     	ldr	x0, [sp, #0x30]
  7ba50c: 940009d6     	bl	0x7bcc64
  7ba510: 52800001     	mov	w1, #0x0                // =0
  7ba514: 940004f3     	bl	0x7bb8e0
  7ba518: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba51c: b9404c01     	ldr	w1, [x0, #0x4c]
  7ba520: f9401fe2     	ldr	x2, [sp, #0x38]
  7ba524: d2880000     	mov	x0, #0x4000             // =16384
  7ba528: f2acaa80     	movk	x0, #0x6554, lsl #16
  7ba52c: 8b000040     	add	x0, x2, x0
  7ba530: b939a001     	str	w1, [x0, #0x39a0]
  7ba534: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba538: b9405001     	ldr	w1, [x0, #0x50]
  7ba53c: f9401fe2     	ldr	x2, [sp, #0x38]
  7ba540: d2880000     	mov	x0, #0x4000             // =16384
  7ba544: f2acaa80     	movk	x0, #0x6554, lsl #16
  7ba548: 8b000040     	add	x0, x2, x0
  7ba54c: b939a401     	str	w1, [x0, #0x39a4]
  7ba550: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba554: b9405401     	ldr	w1, [x0, #0x54]
  7ba558: f9401fe2     	ldr	x2, [sp, #0x38]
  7ba55c: d2880000     	mov	x0, #0x4000             // =16384
  7ba560: f2acaa80     	movk	x0, #0x6554, lsl #16
  7ba564: 8b000040     	add	x0, x2, x0
  7ba568: b939a801     	str	w1, [x0, #0x39a8]
  7ba56c: 528020e0     	mov	w0, #0x107              // =263
  7ba570: b90073e0     	str	w0, [sp, #0x70]
  7ba574: 9101c3e0     	add	x0, sp, #0x70
  7ba578: aa0003e1     	mov	x1, x0
  7ba57c: f9401be0     	ldr	x0, [sp, #0x30]
  7ba580: 940009b9     	bl	0x7bcc64
  7ba584: aa0003e3     	mov	x3, x0
  7ba588: f9401fe1     	ldr	x1, [sp, #0x38]
  7ba58c: d28f3400     	mov	x0, #0x79a0             // =31136
  7ba590: f2acaa80     	movk	x0, #0x6554, lsl #16
  7ba594: 8b000020     	add	x0, x1, x0
  7ba598: 52800182     	mov	w2, #0xc                // =12
  7ba59c: aa0003e1     	mov	x1, x0
  7ba5a0: aa0303e0     	mov	x0, x3
  7ba5a4: 940004e7     	bl	0x7bb940
  7ba5a8: 52804440     	mov	w0, #0x222              // =546
  7ba5ac: b90077e0     	str	w0, [sp, #0x74]
  7ba5b0: 9101d3e0     	add	x0, sp, #0x74
  7ba5b4: aa0003e1     	mov	x1, x0
  7ba5b8: f9401be0     	ldr	x0, [sp, #0x30]
  7ba5bc: 940009aa     	bl	0x7bcc64
  7ba5c0: aa0003e2     	mov	x2, x0
  7ba5c4: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba5c8: b9423400     	ldr	w0, [x0, #0x234]
  7ba5cc: 2a0003e1     	mov	w1, w0
  7ba5d0: aa0203e0     	mov	x0, x2
  7ba5d4: 940004c3     	bl	0x7bb8e0
  7ba5d8: 528043a0     	mov	w0, #0x21d              // =541
  7ba5dc: b9007be0     	str	w0, [sp, #0x78]
  7ba5e0: 9101e3e0     	add	x0, sp, #0x78
  7ba5e4: aa0003e1     	mov	x1, x0
  7ba5e8: f9401be0     	ldr	x0, [sp, #0x30]
  7ba5ec: 9400099e     	bl	0x7bcc64
  7ba5f0: aa0003e2     	mov	x2, x0
  7ba5f4: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba5f8: b9420000     	ldr	w0, [x0, #0x200]
  7ba5fc: 2a0003e1     	mov	w1, w0
  7ba600: aa0203e0     	mov	x0, x2
  7ba604: 940004b7     	bl	0x7bb8e0
  7ba608: 52802100     	mov	w0, #0x108              // =264
  7ba60c: b9007fe0     	str	w0, [sp, #0x7c]
  7ba610: 9101f3e0     	add	x0, sp, #0x7c
  7ba614: aa0003e1     	mov	x1, x0
  7ba618: f9401be0     	ldr	x0, [sp, #0x30]
  7ba61c: 94000992     	bl	0x7bcc64
  7ba620: aa0003e2     	mov	x2, x0
  7ba624: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba628: b9400000     	ldr	w0, [x0]
  7ba62c: 2a0003e1     	mov	w1, w0
  7ba630: aa0203e0     	mov	x0, x2
  7ba634: 940004ab     	bl	0x7bb8e0
  7ba638: 52802120     	mov	w0, #0x109              // =265
  7ba63c: b90083e0     	str	w0, [sp, #0x80]
  7ba640: 910203e0     	add	x0, sp, #0x80
  7ba644: aa0003e1     	mov	x1, x0
  7ba648: f9401be0     	ldr	x0, [sp, #0x30]
  7ba64c: 94000986     	bl	0x7bcc64
  7ba650: aa0003e2     	mov	x2, x0
  7ba654: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba658: b9400400     	ldr	w0, [x0, #0x4]
  7ba65c: 2a0003e1     	mov	w1, w0
  7ba660: aa0203e0     	mov	x0, x2
  7ba664: 9400049f     	bl	0x7bb8e0
  7ba668: 52802180     	mov	w0, #0x10c              // =268
  7ba66c: b90087e0     	str	w0, [sp, #0x84]
  7ba670: 910213e0     	add	x0, sp, #0x84
  7ba674: aa0003e1     	mov	x1, x0
  7ba678: f9401be0     	ldr	x0, [sp, #0x30]
  7ba67c: 9400097a     	bl	0x7bcc64
  7ba680: aa0003e2     	mov	x2, x0
  7ba684: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba688: b9401000     	ldr	w0, [x0, #0x10]
  7ba68c: 2a0003e1     	mov	w1, w0
  7ba690: aa0203e0     	mov	x0, x2
  7ba694: 94000493     	bl	0x7bb8e0
  7ba698: 528021a0     	mov	w0, #0x10d              // =269
  7ba69c: b9008be0     	str	w0, [sp, #0x88]
  7ba6a0: 910223e0     	add	x0, sp, #0x88
  7ba6a4: aa0003e1     	mov	x1, x0
  7ba6a8: f9401be0     	ldr	x0, [sp, #0x30]
  7ba6ac: 9400096e     	bl	0x7bcc64
  7ba6b0: aa0003e2     	mov	x2, x0
  7ba6b4: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba6b8: b9401400     	ldr	w0, [x0, #0x14]
  7ba6bc: 2a0003e1     	mov	w1, w0
  7ba6c0: aa0203e0     	mov	x0, x2
  7ba6c4: 94000487     	bl	0x7bb8e0
  7ba6c8: 52802140     	mov	w0, #0x10a              // =266
  7ba6cc: b9008fe0     	str	w0, [sp, #0x8c]
  7ba6d0: 910233e0     	add	x0, sp, #0x8c
  7ba6d4: aa0003e1     	mov	x1, x0
  7ba6d8: f9401be0     	ldr	x0, [sp, #0x30]
  7ba6dc: 94000962     	bl	0x7bcc64
  7ba6e0: aa0003e2     	mov	x2, x0
  7ba6e4: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba6e8: b9400800     	ldr	w0, [x0, #0x8]
  7ba6ec: 2a0003e1     	mov	w1, w0
  7ba6f0: aa0203e0     	mov	x0, x2
  7ba6f4: 9400047b     	bl	0x7bb8e0
  7ba6f8: 52802160     	mov	w0, #0x10b              // =267
  7ba6fc: b90093e0     	str	w0, [sp, #0x90]
  7ba700: 910243e0     	add	x0, sp, #0x90
  7ba704: aa0003e1     	mov	x1, x0
  7ba708: f9401be0     	ldr	x0, [sp, #0x30]
  7ba70c: 94000956     	bl	0x7bcc64
  7ba710: aa0003e2     	mov	x2, x0
  7ba714: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba718: b9400c00     	ldr	w0, [x0, #0xc]
  7ba71c: 2a0003e1     	mov	w1, w0
  7ba720: aa0203e0     	mov	x0, x2
  7ba724: 9400046f     	bl	0x7bb8e0
  7ba728: f94017e0     	ldr	x0, [sp, #0x28]
  7ba72c: 91411000     	add	x0, x0, #0x44, lsl #12  // =0x44000
  7ba730: b96b8c00     	ldr	w0, [x0, #0x2b8c]
  7ba734: 7100101f     	cmp	w0, #0x4
  7ba738: 540001a0     	b.eq	0x7ba76c
  7ba73c: 7100101f     	cmp	w0, #0x4
  7ba740: 540000c8     	b.hi	0x7ba758
  7ba744: 7100081f     	cmp	w0, #0x2
  7ba748: 54000120     	b.eq	0x7ba76c
  7ba74c: 71000c1f     	cmp	w0, #0x3
  7ba750: 54000360     	b.eq	0x7ba7bc
  7ba754: 14000042     	b	0x7ba85c
  7ba758: 7100141f     	cmp	w0, #0x5
  7ba75c: 54000580     	b.eq	0x7ba80c
  7ba760: 71001c1f     	cmp	w0, #0x7
  7ba764: 540007c8     	b.hi	0x7ba85c
  7ba768: 14000015     	b	0x7ba7bc
  7ba76c: 52804460     	mov	w0, #0x223              // =547
  7ba770: b90097e0     	str	w0, [sp, #0x94]
  7ba774: 910253e0     	add	x0, sp, #0x94
  7ba778: aa0003e1     	mov	x1, x0
  7ba77c: f9401be0     	ldr	x0, [sp, #0x30]
  7ba780: 94000939     	bl	0x7bcc64
  7ba784: aa0003f3     	mov	x19, x0
  7ba788: f94017e1     	ldr	x1, [sp, #0x28]
  7ba78c: d2901400     	mov	x0, #0x80a0             // =32928
  7ba790: f2a00060     	movk	x0, #0x3, lsl #16
  7ba794: 8b000020     	add	x0, x1, x0
  7ba798: 940004c4     	bl	0x7bbaa8
  7ba79c: aa0003e1     	mov	x1, x0
  7ba7a0: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba7a4: b9400400     	ldr	w0, [x0, #0x4]
  7ba7a8: 531e7400     	lsl	w0, w0, #2
  7ba7ac: 2a0003e2     	mov	w2, w0
  7ba7b0: aa1303e0     	mov	x0, x19
  7ba7b4: 94000463     	bl	0x7bb940
  7ba7b8: 14000034     	b	0x7ba888
  7ba7bc: 52804b40     	mov	w0, #0x25a              // =602
  7ba7c0: b9009be0     	str	w0, [sp, #0x98]
  7ba7c4: 910263e0     	add	x0, sp, #0x98
  7ba7c8: aa0003e1     	mov	x1, x0
  7ba7cc: f9401be0     	ldr	x0, [sp, #0x30]
  7ba7d0: 94000925     	bl	0x7bcc64
  7ba7d4: aa0003f3     	mov	x19, x0
  7ba7d8: f94017e1     	ldr	x1, [sp, #0x28]
  7ba7dc: d2901400     	mov	x0, #0x80a0             // =32928
  7ba7e0: f2a00060     	movk	x0, #0x3, lsl #16
  7ba7e4: 8b000020     	add	x0, x1, x0
  7ba7e8: 940004b0     	bl	0x7bbaa8
  7ba7ec: aa0003e1     	mov	x1, x0
  7ba7f0: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba7f4: b9400400     	ldr	w0, [x0, #0x4]
  7ba7f8: 531e7400     	lsl	w0, w0, #2
  7ba7fc: 2a0003e2     	mov	w2, w0
  7ba800: aa1303e0     	mov	x0, x19
  7ba804: 9400044f     	bl	0x7bb940
  7ba808: 14000020     	b	0x7ba888
  7ba80c: 52804b20     	mov	w0, #0x259              // =601
  7ba810: b9009fe0     	str	w0, [sp, #0x9c]
  7ba814: 910273e0     	add	x0, sp, #0x9c
  7ba818: aa0003e1     	mov	x1, x0
  7ba81c: f9401be0     	ldr	x0, [sp, #0x30]
  7ba820: 94000911     	bl	0x7bcc64
  7ba824: aa0003f3     	mov	x19, x0
  7ba828: f94017e1     	ldr	x1, [sp, #0x28]
  7ba82c: d2901400     	mov	x0, #0x80a0             // =32928
  7ba830: f2a00060     	movk	x0, #0x3, lsl #16
  7ba834: 8b000020     	add	x0, x1, x0
  7ba838: 9400049c     	bl	0x7bbaa8
  7ba83c: aa0003e1     	mov	x1, x0
  7ba840: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba844: b9400400     	ldr	w0, [x0, #0x4]
  7ba848: 531e7400     	lsl	w0, w0, #2
  7ba84c: 2a0003e2     	mov	w2, w0
  7ba850: aa1303e0     	mov	x0, x19
  7ba854: 9400043b     	bl	0x7bb940
  7ba858: 1400000c     	b	0x7ba888
  7ba85c: f94017e0     	ldr	x0, [sp, #0x28]
  7ba860: 91411000     	add	x0, x0, #0x44, lsl #12  // =0x44000
  7ba864: b96b8c00     	ldr	w0, [x0, #0x2b8c]
  7ba868: 2a0003e4     	mov	w4, w0
  7ba86c: f0002e40     	adrp	x0, 0xd85000
  7ba870: 91092003     	add	x3, x0, #0x248
  7ba874: 5280dea2     	mov	w2, #0x6f5              // =1781
  7ba878: d0002e40     	adrp	x0, 0xd84000
  7ba87c: 91372001     	add	x1, x0, #0xdc8
  7ba880: 52800040     	mov	w0, #0x2                // =2
  7ba884: 97fe2f32     	bl	0x74654c
  7ba888: f94017e0     	ldr	x0, [sp, #0x28]
  7ba88c: 91411000     	add	x0, x0, #0x44, lsl #12  // =0x44000
  7ba890: b96b8c00     	ldr	w0, [x0, #0x2b8c]
  7ba894: 7100101f     	cmp	w0, #0x4
  7ba898: 54000160     	b.eq	0x7ba8c4
  7ba89c: 7100101f     	cmp	w0, #0x4
  7ba8a0: 54000088     	b.hi	0x7ba8b0
  7ba8a4: 7100081f     	cmp	w0, #0x2
  7ba8a8: 54000b03     	b.lo	0x7baa08
  7ba8ac: 14000062     	b	0x7baa34
  7ba8b0: 7100181f     	cmp	w0, #0x6
  7ba8b4: 540003e9     	b.ls	0x7ba930
  7ba8b8: 71001c1f     	cmp	w0, #0x7
  7ba8bc: 54000700     	b.eq	0x7ba99c
  7ba8c0: 14000052     	b	0x7baa08
  7ba8c4: f94017e1     	ldr	x1, [sp, #0x28]
  7ba8c8: d2901400     	mov	x0, #0x80a0             // =32928
  7ba8cc: f2a00060     	movk	x0, #0x3, lsl #16
  7ba8d0: 8b000020     	add	x0, x1, x0
  7ba8d4: 94000475     	bl	0x7bbaa8
  7ba8d8: aa0003e1     	mov	x1, x0
  7ba8dc: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba8e0: b9400400     	ldr	w0, [x0, #0x4]
  7ba8e4: 531e7400     	lsl	w0, w0, #2
  7ba8e8: 2a0003e0     	mov	w0, w0
  7ba8ec: 8b000020     	add	x0, x1, x0
  7ba8f0: f90063e0     	str	x0, [sp, #0xc0]
  7ba8f4: 528044a0     	mov	w0, #0x225              // =549
  7ba8f8: b900a3e0     	str	w0, [sp, #0xa0]
  7ba8fc: 910283e0     	add	x0, sp, #0xa0
  7ba900: aa0003e1     	mov	x1, x0
  7ba904: f9401be0     	ldr	x0, [sp, #0x30]
  7ba908: 940008d7     	bl	0x7bcc64
  7ba90c: aa0003e3     	mov	x3, x0
  7ba910: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba914: b9400000     	ldr	w0, [x0]
  7ba918: 531e7400     	lsl	w0, w0, #2
  7ba91c: 2a0003e2     	mov	w2, w0
  7ba920: f94063e1     	ldr	x1, [sp, #0xc0]
  7ba924: aa0303e0     	mov	x0, x3
  7ba928: 94000406     	bl	0x7bb940
  7ba92c: 14000042     	b	0x7baa34
  7ba930: f94017e1     	ldr	x1, [sp, #0x28]
  7ba934: d2901400     	mov	x0, #0x80a0             // =32928
  7ba938: f2a00060     	movk	x0, #0x3, lsl #16
  7ba93c: 8b000020     	add	x0, x1, x0
  7ba940: 9400045a     	bl	0x7bbaa8
  7ba944: aa0003e1     	mov	x1, x0
  7ba948: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba94c: b9400400     	ldr	w0, [x0, #0x4]
  7ba950: 531e7400     	lsl	w0, w0, #2
  7ba954: 2a0003e0     	mov	w0, w0
  7ba958: 8b000020     	add	x0, x1, x0
  7ba95c: f9005fe0     	str	x0, [sp, #0xb8]
  7ba960: 52804b00     	mov	w0, #0x258              // =600
  7ba964: b900a7e0     	str	w0, [sp, #0xa4]
  7ba968: 910293e0     	add	x0, sp, #0xa4
  7ba96c: aa0003e1     	mov	x1, x0
  7ba970: f9401be0     	ldr	x0, [sp, #0x30]
  7ba974: 940008bc     	bl	0x7bcc64
  7ba978: aa0003e3     	mov	x3, x0
  7ba97c: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba980: b9400000     	ldr	w0, [x0]
  7ba984: 531e7400     	lsl	w0, w0, #2
  7ba988: 2a0003e2     	mov	w2, w0
  7ba98c: f9405fe1     	ldr	x1, [sp, #0xb8]
  7ba990: aa0303e0     	mov	x0, x3
  7ba994: 940003eb     	bl	0x7bb940
  7ba998: 14000027     	b	0x7baa34
  7ba99c: f94017e1     	ldr	x1, [sp, #0x28]
  7ba9a0: d2901400     	mov	x0, #0x80a0             // =32928
  7ba9a4: f2a00060     	movk	x0, #0x3, lsl #16
  7ba9a8: 8b000020     	add	x0, x1, x0
  7ba9ac: 9400043f     	bl	0x7bbaa8
  7ba9b0: aa0003e1     	mov	x1, x0
  7ba9b4: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba9b8: b9400400     	ldr	w0, [x0, #0x4]
  7ba9bc: 531e7400     	lsl	w0, w0, #2
  7ba9c0: 2a0003e0     	mov	w0, w0
  7ba9c4: 8b000020     	add	x0, x1, x0
  7ba9c8: f9005be0     	str	x0, [sp, #0xb0]
  7ba9cc: 52804d40     	mov	w0, #0x26a              // =618
  7ba9d0: b900abe0     	str	w0, [sp, #0xa8]
  7ba9d4: 9102a3e0     	add	x0, sp, #0xa8
  7ba9d8: aa0003e1     	mov	x1, x0
  7ba9dc: f9401be0     	ldr	x0, [sp, #0x30]
  7ba9e0: 940008a1     	bl	0x7bcc64
  7ba9e4: aa0003e3     	mov	x3, x0
  7ba9e8: f94067e0     	ldr	x0, [sp, #0xc8]
  7ba9ec: b9400000     	ldr	w0, [x0]
  7ba9f0: 531e7400     	lsl	w0, w0, #2
  7ba9f4: 2a0003e2     	mov	w2, w0
  7ba9f8: f9405be1     	ldr	x1, [sp, #0xb0]
  7ba9fc: aa0303e0     	mov	x0, x3
  7baa00: 940003d0     	bl	0x7bb940
  7baa04: 1400000c     	b	0x7baa34
  7baa08: f94017e0     	ldr	x0, [sp, #0x28]
  7baa0c: 91411000     	add	x0, x0, #0x44, lsl #12  // =0x44000
  7baa10: b96b8c00     	ldr	w0, [x0, #0x2b8c]
  7baa14: 2a0003e4     	mov	w4, w0
  7baa18: f0002e40     	adrp	x0, 0xd85000
  7baa1c: 9109c003     	add	x3, x0, #0x270
  7baa20: 5280e242     	mov	w2, #0x712              // =1810
  7baa24: d0002e40     	adrp	x0, 0xd84000
  7baa28: 91372001     	add	x1, x0, #0xdc8
  7baa2c: 52800040     	mov	w0, #0x2                // =2
  7baa30: 97fe2ec7     	bl	0x74654c
  7baa34: f94017e1     	ldr	x1, [sp, #0x28]
  7baa38: d2901400     	mov	x0, #0x80a0             // =32928
  7baa3c: f2a00060     	movk	x0, #0x3, lsl #16
  7baa40: 8b000022     	add	x2, x1, x0
  7baa44: f9401fe1     	ldr	x1, [sp, #0x38]
  7baa48: d28f1900     	mov	x0, #0x78c8             // =30920
  7baa4c: f2ac9680     	movk	x0, #0x64b4, lsl #16
  7baa50: 8b000020     	add	x0, x1, x0
  7baa54: aa0003e1     	mov	x1, x0
  7baa58: aa0203e0     	mov	x0, x2
  7baa5c: 94004a1d     	bl	0x7cd2d0
  7baa60: 12001c00     	and	w0, w0, #0xff
  7baa64: 7100001f     	cmp	w0, #0x0
  7baa68: 54000240     	b.eq	0x7baab0
  7baa6c: 52802200     	mov	w0, #0x110              // =272
  7baa70: b900afe0     	str	w0, [sp, #0xac]
  7baa74: 9102b3e0     	add	x0, sp, #0xac
  7baa78: aa0003e1     	mov	x1, x0
  7baa7c: f9401be0     	ldr	x0, [sp, #0x30]
  7baa80: 94000879     	bl	0x7bcc64
  7baa84: aa0003e3     	mov	x3, x0
  7baa88: f9401fe1     	ldr	x1, [sp, #0x38]
  7baa8c: d28f1900     	mov	x0, #0x78c8             // =30920
  7baa90: f2ac9680     	movk	x0, #0x64b4, lsl #16
  7baa94: 8b000021     	add	x1, x1, x0
  7baa98: f94067e0     	ldr	x0, [sp, #0xc8]
  7baa9c: b9427c00     	ldr	w0, [x0, #0x27c]
  7baaa0: 2a0003e2     	mov	w2, w0
  7baaa4: aa0303e0     	mov	x0, x3
  7baaa8: 940003a6     	bl	0x7bb940
  7baaac: 14000008     	b	0x7baacc
  7baab0: f0002e40     	adrp	x0, 0xd85000
  7baab4: 910a6003     	add	x3, x0, #0x298
  7baab8: 5280e362     	mov	w2, #0x71b              // =1819
  7baabc: d0002e40     	adrp	x0, 0xd84000
  7baac0: 91372001     	add	x1, x0, #0xdc8
  7baac4: 52800040     	mov	w0, #0x2                // =2
  7baac8: 97fe2ea1     	bl	0x74654c
  7baacc: d503201f     	nop
  7baad0: f9400bf3     	ldr	x19, [sp, #0x10]
  7baad4: a8cd7bfd     	ldp	x29, x30, [sp], #0xd0
  7baad8: d65f03c0     	ret
