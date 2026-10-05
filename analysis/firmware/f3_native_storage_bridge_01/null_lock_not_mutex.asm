  40c2a0: d10043ff     	sub	sp, sp, #0x10
  40c2a4: f90007e0     	str	x0, [sp, #0x8]
  40c2a8: f0002f00     	adrp	x0, 0x9ef000 <zError+0x13684>
  40c2ac: 911b6001     	add	x1, x0, #0x6d8
  40c2b0: f94007e0     	ldr	x0, [sp, #0x8]
  40c2b4: f9000001     	str	x1, [x0]
  40c2b8: d503201f     	nop
  40c2bc: 910043ff     	add	sp, sp, #0x10
  40c2c0: d65f03c0     	ret
  40c2c4: d10043ff     	sub	sp, sp, #0x10
  40c2c8: f90007e0     	str	x0, [sp, #0x8]
  40c2cc: f0002f00     	adrp	x0, 0x9ef000 <zError+0x13684>
  40c2d0: 911b6001     	add	x1, x0, #0x6d8
  40c2d4: f94007e0     	ldr	x0, [sp, #0x8]
  40c2d8: f9000001     	str	x1, [x0]
  40c2dc: d503201f     	nop
  40c2e0: 910043ff     	add	sp, sp, #0x10
  40c2e4: d65f03c0     	ret
  40c2e8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  40c2ec: 910003fd     	mov	x29, sp
  40c2f0: f9000fe0     	str	x0, [sp, #0x18]
  40c2f4: f9400fe0     	ldr	x0, [sp, #0x18]
  40c2f8: 97fffff3     	bl	0x40c2c4 <.text+0x1094>
  40c2fc: d2800101     	mov	x1, #0x8                // =8
  40c300: f9400fe0     	ldr	x0, [sp, #0x18]
  40c304: 97fff6b7     	bl	0x409de0 <_ZdlPvm@plt>
  40c308: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  40c30c: d65f03c0     	ret
  40c310: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  40c314: 910003fd     	mov	x29, sp
  40c318: f9000fe0     	str	x0, [sp, #0x18]
  40c31c: f9400fe0     	ldr	x0, [sp, #0x18]
  40c320: 97ffffe0     	bl	0x40c2a0 <.text+0x1070>
  40c324: b00040c0     	adrp	x0, 0xc25000
  40c328: 91036001     	add	x1, x0, #0xd8
  40c32c: f9400fe0     	ldr	x0, [sp, #0x18]
  40c330: f9000001     	str	x1, [x0]
  40c334: d503201f     	nop
  40c338: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  40c33c: d65f03c0     	ret
  40c340: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  40c344: 910003fd     	mov	x29, sp
  40c348: f9000fe0     	str	x0, [sp, #0x18]
  40c34c: b00040c0     	adrp	x0, 0xc25000
  40c350: 91036001     	add	x1, x0, #0xd8
  40c354: f9400fe0     	ldr	x0, [sp, #0x18]
  40c358: f9000001     	str	x1, [x0]
  40c35c: f9400fe0     	ldr	x0, [sp, #0x18]
  40c360: 97ffffd9     	bl	0x40c2c4 <.text+0x1094>
  40c364: d503201f     	nop
  40c368: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  40c36c: d65f03c0     	ret
