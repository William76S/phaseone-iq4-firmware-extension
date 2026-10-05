  960478: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  96047c: 910003fd     	mov	x29, sp
  960480: a90153f3     	stp	x19, x20, [sp, #0x10]
  960484: aa0003f3     	mov	x19, x0
  960488: 910143e8     	add	x8, sp, #0x50
  96048c: aa0203e0     	mov	x0, x2
  960490: a9025bf5     	stp	x21, x22, [sp, #0x20]
  960494: 2a0103f5     	mov	w21, w1
  960498: f9001bf7     	str	x23, [sp, #0x30]
  96049c: 97ff927b     	bl	0x944e88
  9604a0: 3dc017e0     	ldr	q0, [sp, #0x50]
  9604a4: 91080260     	add	x0, x19, #0x200
  9604a8: f940da74     	ldr	x20, [x19, #0x1b0]
  9604ac: f9402be1     	ldr	x1, [sp, #0x50]
  9604b0: a9057fff     	stp	xzr, xzr, [sp, #0x50]
  9604b4: 3c9a8000     	stur	q0, [x0, #-0x58]
  9604b8: b40002d4     	cbz	x20, 0x960510
  9604bc: f0002340     	adrp	x0, 0xdcb000
  9604c0: f9427817     	ldr	x23, [x0, #0x4f0]
  9604c4: b4000ad7     	cbz	x23, 0x96061c
  9604c8: 91002281     	add	x1, x20, #0x8
  9604cc: 885ffc20     	ldaxr	w0, [x1]
  9604d0: 51000402     	sub	w2, w0, #0x1
  9604d4: 8803fc22     	stlxr	w3, w2, [x1]
  9604d8: 35ffffa3     	cbnz	w3, 0x9604cc
  9604dc: 7100041f     	cmp	w0, #0x1
  9604e0: 54000a80     	b.eq	0x960630
  9604e4: f9402ff4     	ldr	x20, [sp, #0x58]
  9604e8: b4000134     	cbz	x20, 0x96050c
  9604ec: b4000f17     	cbz	x23, 0x9606cc
  9604f0: 91002281     	add	x1, x20, #0x8
  9604f4: 885ffc20     	ldaxr	w0, [x1]
  9604f8: 51000402     	sub	w2, w0, #0x1
  9604fc: 8803fc22     	stlxr	w3, w2, [x1]
  960500: 35ffffa3     	cbnz	w3, 0x9604f4
  960504: 7100041f     	cmp	w0, #0x1
  960508: 54000ec0     	b.eq	0x9606e0
  96050c: f940d661     	ldr	x1, [x19, #0x1a8]
  960510: aa0103e0     	mov	x0, x1
  960514: f9400021     	ldr	x1, [x1]
  960518: f9401821     	ldr	x1, [x1, #0x30]
  96051c: d63f0020     	blr	x1
  960520: f9401261     	ldr	x1, [x19, #0x20]
  960524: 91006264     	add	x4, x19, #0x18
  960528: b40006a1     	cbz	x1, 0x9605fc
  96052c: aa0403e3     	mov	x3, x4
  960530: b9402022     	ldr	w2, [x1, #0x20]
  960534: 6b02001f     	cmp	w0, w2
  960538: 540005c8     	b.hi	0x9605f0
  96053c: aa0103e3     	mov	x3, x1
  960540: f9400821     	ldr	x1, [x1, #0x10]
  960544: b5ffff61     	cbnz	x1, 0x960530
  960548: eb03009f     	cmp	x4, x3
  96054c: 54000580     	b.eq	0x9605fc
  960550: b9402061     	ldr	w1, [x3, #0x20]
  960554: 6b01001f     	cmp	w0, w1
  960558: 54000523     	b.lo	0x9605fc
  96055c: f940d661     	ldr	x1, [x19, #0x1a8]
  960560: d2801700     	mov	x0, #0xb8               // =184
  960564: f90027e1     	str	x1, [sp, #0x48]
  960568: 97eaa63e     	bl	0x409e60
  96056c: aa0003f4     	mov	x20, x0
  960570: 0f000420     	movi	v0.2s, #0x1
  960574: f0002342     	adrp	x2, 0xdcb000
  960578: f94027e1     	ldr	x1, [sp, #0x48]
  96057c: 9110a042     	add	x2, x2, #0x428
  960580: fd000400     	str	d0, [x0, #0x8]
  960584: f8010402     	str	x2, [x0], #0x10
  960588: 97ff76d6     	bl	0x93e0e0
  96058c: f9400282     	ldr	x2, [x20]
  960590: 900015c1     	adrp	x1, 0xc18000
  960594: aa1403e0     	mov	x0, x20
  960598: 91154021     	add	x1, x1, #0x550
  96059c: f9401042     	ldr	x2, [x2, #0x20]
  9605a0: d63f0040     	blr	x2
  9605a4: f940e676     	ldr	x22, [x19, #0x1c8]
  9605a8: a91c5260     	stp	x0, x20, [x19, #0x1c0]
  9605ac: b4000176     	cbz	x22, 0x9605d8
  9605b0: f0002340     	adrp	x0, 0xdcb000
  9605b4: f9427817     	ldr	x23, [x0, #0x4f0]
  9605b8: b40005f7     	cbz	x23, 0x960674
  9605bc: 910022c1     	add	x1, x22, #0x8
  9605c0: 885ffc20     	ldaxr	w0, [x1]
  9605c4: 51000402     	sub	w2, w0, #0x1
  9605c8: 8803fc22     	stlxr	w3, w2, [x1]
  9605cc: 35ffffa3     	cbnz	w3, 0x9605c0
  9605d0: 7100041f     	cmp	w0, #0x1
  9605d4: 540005a0     	b.eq	0x960688
  9605d8: f9401bf7     	ldr	x23, [sp, #0x30]
  9605dc: b901ba75     	str	w21, [x19, #0x1b8]
  9605e0: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9605e4: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  9605e8: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  9605ec: d65f03c0     	ret
  9605f0: f9400c21     	ldr	x1, [x1, #0x18]
  9605f4: b5fff9e1     	cbnz	x1, 0x960530
  9605f8: 17ffffd4     	b	0x960548
  9605fc: f0002343     	adrp	x3, 0xdcb000
  960600: f0002341     	adrp	x1, 0xdcb000
  960604: 9115e063     	add	x3, x3, #0x578
  960608: 91166021     	add	x1, x1, #0x598
  96060c: 528010a2     	mov	w2, #0x85               // =133
  960610: 52800080     	mov	w0, #0x4                // =4
  960614: 97f797ce     	bl	0x74654c
  960618: 17ffffd1     	b	0x96055c
  96061c: b9400a80     	ldr	w0, [x20, #0x8]
  960620: 51000401     	sub	w1, w0, #0x1
  960624: b9000a81     	str	w1, [x20, #0x8]
  960628: 7100041f     	cmp	w0, #0x1
  96062c: 54fff5c1     	b.ne	0x9604e4
  960630: f9400281     	ldr	x1, [x20]
  960634: aa1403e0     	mov	x0, x20
  960638: f9400821     	ldr	x1, [x1, #0x10]
  96063c: d63f0020     	blr	x1
  960640: b40007d7     	cbz	x23, 0x960738
  960644: 91003281     	add	x1, x20, #0xc
  960648: 885ffc20     	ldaxr	w0, [x1]
  96064c: 51000402     	sub	w2, w0, #0x1
  960650: 8803fc22     	stlxr	w3, w2, [x1]
  960654: 35ffffa3     	cbnz	w3, 0x960648
  960658: 7100041f     	cmp	w0, #0x1
  96065c: 54fff441     	b.ne	0x9604e4
  960660: f9400281     	ldr	x1, [x20]
  960664: aa1403e0     	mov	x0, x20
  960668: f9400c21     	ldr	x1, [x1, #0x18]
  96066c: d63f0020     	blr	x1
  960670: 17ffff9d     	b	0x9604e4
  960674: b9400ac0     	ldr	w0, [x22, #0x8]
  960678: 51000401     	sub	w1, w0, #0x1
  96067c: b9000ac1     	str	w1, [x22, #0x8]
  960680: 7100041f     	cmp	w0, #0x1
  960684: 54fffaa1     	b.ne	0x9605d8
  960688: f94002c1     	ldr	x1, [x22]
  96068c: aa1603e0     	mov	x0, x22
  960690: f9400821     	ldr	x1, [x1, #0x10]
  960694: d63f0020     	blr	x1
  960698: b4000497     	cbz	x23, 0x960728
  96069c: 910032c1     	add	x1, x22, #0xc
  9606a0: 885ffc20     	ldaxr	w0, [x1]
  9606a4: 51000402     	sub	w2, w0, #0x1
  9606a8: 8803fc22     	stlxr	w3, w2, [x1]
  9606ac: 35ffffa3     	cbnz	w3, 0x9606a0
  9606b0: 7100041f     	cmp	w0, #0x1
  9606b4: 54fff921     	b.ne	0x9605d8
  9606b8: f94002c1     	ldr	x1, [x22]
  9606bc: aa1603e0     	mov	x0, x22
  9606c0: f9400c21     	ldr	x1, [x1, #0x18]
  9606c4: d63f0020     	blr	x1
  9606c8: 17ffffc4     	b	0x9605d8
  9606cc: b9400a80     	ldr	w0, [x20, #0x8]
  9606d0: 51000401     	sub	w1, w0, #0x1
  9606d4: b9000a81     	str	w1, [x20, #0x8]
  9606d8: 7100041f     	cmp	w0, #0x1
  9606dc: 54fff181     	b.ne	0x96050c
  9606e0: f9400281     	ldr	x1, [x20]
  9606e4: aa1403e0     	mov	x0, x20
  9606e8: f9400821     	ldr	x1, [x1, #0x10]
  9606ec: d63f0020     	blr	x1
  9606f0: b40002d7     	cbz	x23, 0x960748
  9606f4: 91003281     	add	x1, x20, #0xc
  9606f8: 885ffc20     	ldaxr	w0, [x1]
  9606fc: 51000402     	sub	w2, w0, #0x1
  960700: 8803fc22     	stlxr	w3, w2, [x1]
  960704: 35ffffa3     	cbnz	w3, 0x9606f8
  960708: 7100041f     	cmp	w0, #0x1
  96070c: 54fff001     	b.ne	0x96050c
  960710: f9400281     	ldr	x1, [x20]
  960714: aa1403e0     	mov	x0, x20
  960718: f9400c21     	ldr	x1, [x1, #0x18]
  96071c: d63f0020     	blr	x1
  960720: f940d661     	ldr	x1, [x19, #0x1a8]
  960724: 17ffff7b     	b	0x960510
  960728: b9400ec0     	ldr	w0, [x22, #0xc]
  96072c: 51000401     	sub	w1, w0, #0x1
  960730: b9000ec1     	str	w1, [x22, #0xc]
  960734: 17ffffdf     	b	0x9606b0
  960738: b9400e80     	ldr	w0, [x20, #0xc]
  96073c: 51000401     	sub	w1, w0, #0x1
  960740: b9000e81     	str	w1, [x20, #0xc]
  960744: 17ffffc5     	b	0x960658
  960748: b9400e80     	ldr	w0, [x20, #0xc]
  96074c: 51000401     	sub	w1, w0, #0x1
  960750: b9000e81     	str	w1, [x20, #0xc]
  960754: 17ffffed     	b	0x960708
  960758: aa0003f3     	mov	x19, x0
  96075c: aa1403e0     	mov	x0, x20
  960760: 97eaa794     	bl	0x40a5b0
  960764: aa1303e0     	mov	x0, x19
  960768: 97eaa7fa     	bl	0x40a750
  96076c: d503201f     	nop
