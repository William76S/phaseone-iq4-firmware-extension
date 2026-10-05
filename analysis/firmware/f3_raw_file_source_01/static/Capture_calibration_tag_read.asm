  7cd2d0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7cd2d4: 910003fd     	mov	x29, sp
  7cd2d8: f9000fe0     	str	x0, [sp, #0x18]
  7cd2dc: f9000be1     	str	x1, [sp, #0x10]
  7cd2e0: f9400fe0     	ldr	x0, [sp, #0x18]
  7cd2e4: b9427c00     	ldr	w0, [x0, #0x27c]
  7cd2e8: 7100001f     	cmp	w0, #0x0
  7cd2ec: 54000181     	b.ne	0x7cd31c
  7cd2f0: 52810da3     	mov	w3, #0x86d              // =2157
  7cd2f4: 90002dc0     	adrp	x0, 0xd85000
  7cd2f8: 912c0002     	add	x2, x0, #0xb00
  7cd2fc: 90002dc0     	adrp	x0, 0xd85000
  7cd300: 9134c001     	add	x1, x0, #0xd30
  7cd304: 90002dc0     	adrp	x0, 0xd85000
  7cd308: 9130a000     	add	x0, x0, #0xc28
  7cd30c: 97f0f49d     	bl	0x40a580
  7cd310: 97fe7cfe     	bl	0x76c708
  7cd314: 52800020     	mov	w0, #0x1                // =1
  7cd318: 14000002     	b	0x7cd320
  7cd31c: 52800000     	mov	w0, #0x0                // =0
  7cd320: 7100001f     	cmp	w0, #0x0
  7cd324: 54000060     	b.eq	0x7cd330
  7cd328: 52800000     	mov	w0, #0x0                // =0
  7cd32c: 14000025     	b	0x7cd3c0
  7cd330: f9400fe0     	ldr	x0, [sp, #0x18]
  7cd334: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7cd338: b9503000     	ldr	w0, [x0, #0x1030]
  7cd33c: 7100101f     	cmp	w0, #0x4
  7cd340: 540000c0     	b.eq	0x7cd358
  7cd344: f9400fe0     	ldr	x0, [sp, #0x18]
  7cd348: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7cd34c: b9503000     	ldr	w0, [x0, #0x1030]
  7cd350: 71000c1f     	cmp	w0, #0x3
  7cd354: 54000301     	b.ne	0x7cd3b4
  7cd358: f9400fe1     	ldr	x1, [sp, #0x18]
  7cd35c: d29a0b00     	mov	x0, #0xd058             // =53336
  7cd360: 8b000026     	add	x6, x1, x0
  7cd364: f9400fe0     	ldr	x0, [sp, #0x18]
  7cd368: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7cd36c: f9681401     	ldr	x1, [x0, #0x5028]
  7cd370: f9400fe0     	ldr	x0, [sp, #0x18]
  7cd374: b9427c00     	ldr	w0, [x0, #0x27c]
  7cd378: 52800005     	mov	w5, #0x0                // =0
  7cd37c: 2a0003e4     	mov	w4, w0
  7cd380: f9400be3     	ldr	x3, [sp, #0x10]
  7cd384: 52802202     	mov	w2, #0x110              // =272
  7cd388: aa0603e0     	mov	x0, x6
  7cd38c: 940036f1     	bl	0x7daf50
  7cd390: 12001c00     	and	w0, w0, #0xff
  7cd394: 52000000     	eor	w0, w0, #0x1
  7cd398: 12001c00     	and	w0, w0, #0xff
  7cd39c: 7100001f     	cmp	w0, #0x0
  7cd3a0: 540000e0     	b.eq	0x7cd3bc
  7cd3a4: f9400fe0     	ldr	x0, [sp, #0x18]
  7cd3a8: 97ffe789     	bl	0x7c71cc
  7cd3ac: 52800000     	mov	w0, #0x0                // =0
  7cd3b0: 14000004     	b	0x7cd3c0
  7cd3b4: 52800000     	mov	w0, #0x0                // =0
  7cd3b8: 14000002     	b	0x7cd3c0
  7cd3bc: 52800020     	mov	w0, #0x1                // =1
  7cd3c0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7cd3c4: d65f03c0     	ret
