  922640: a9b47bfd     	stp	x29, x30, [sp, #-0xc0]!
  922644: 910003fd     	mov	x29, sp
  922648: a90153f3     	stp	x19, x20, [sp, #0x10]
  92264c: aa0003f3     	mov	x19, x0
  922650: 9101a3e0     	add	x0, sp, #0x68
  922654: a9025bf5     	stp	x21, x22, [sp, #0x20]
  922658: a90363f7     	stp	x23, x24, [sp, #0x30]
  92265c: a9046bf9     	stp	x25, x26, [sp, #0x40]
  922660: 97fffb30     	bl	0x921320
  922664: 9101a3e0     	add	x0, sp, #0x68
  922668: 29478a63     	ldp	w3, w2, [x19, #0x3c]
  92266c: d2800001     	mov	x1, #0x0                // =0
  922670: 97fffb3a     	bl	0x921358
  922674: f9402a7a     	ldr	x26, [x19, #0x50]
  922678: 910193e4     	add	x4, sp, #0x64
  92267c: 910183e3     	add	x3, sp, #0x60
  922680: 910173e2     	add	x2, sp, #0x5c
  922684: 910163e1     	add	x1, sp, #0x58
  922688: aa1a03e0     	mov	x0, x26
  92268c: 9400686d     	bl	0x93c840
  922690: b9403677     	ldr	w23, [x19, #0x34]
  922694: 91004261     	add	x1, x19, #0x10
  922698: 9101a3e0     	add	x0, sp, #0x68
  92269c: 53017ef7     	lsr	w23, w23, #1
  9226a0: 97fffb36     	bl	0x921378
  9226a4: a9400275     	ldp	x21, x0, [x19]
  9226a8: 531f7af7     	lsl	w23, w23, #1
  9226ac: eb0002bf     	cmp	x21, x0
  9226b0: 54000281     	b.ne	0x922700
  9226b4: 14000030     	b	0x922774
  9226b8: aa1403e2     	mov	x2, x20
  9226bc: 9101a3e0     	add	x0, sp, #0x68
  9226c0: 97fffe4a     	bl	0x921fe8
  9226c4: b9403a63     	ldr	w3, [x19, #0x38]
  9226c8: aa1903e2     	mov	x2, x25
  9226cc: f9400e61     	ldr	x1, [x19, #0x18]
  9226d0: 9101a3e0     	add	x0, sp, #0x68
  9226d4: 8b384021     	add	x1, x1, w24, uxtw
  9226d8: 97fffe44     	bl	0x921fe8
  9226dc: b9805be1     	ldrsw	x1, [sp, #0x58]
  9226e0: 2a1603e2     	mov	w2, w22
  9226e4: aa1a03e0     	mov	x0, x26
  9226e8: 8b010681     	add	x1, x20, x1, lsl #1
  9226ec: 94006e67     	bl	0x93e088
  9226f0: f9400660     	ldr	x0, [x19, #0x8]
  9226f4: 910012b5     	add	x21, x21, #0x4
  9226f8: eb15001f     	cmp	x0, x21
  9226fc: 540003c0     	b.eq	0x922774
  922700: b94002b6     	ldr	w22, [x21]
  922704: b9405fe0     	ldr	w0, [sp, #0x5c]
  922708: 29458e74     	ldp	w20, w3, [x19, #0x2c]
  92270c: 0b0002c0     	add	w0, w22, w0
  922710: b9403661     	ldr	w1, [x19, #0x34]
  922714: 93407c04     	sxtw	x4, w0
  922718: 0b030000     	add	w0, w0, w3
  92271c: b9403a63     	ldr	w3, [x19, #0x38]
  922720: f9401266     	ldr	x6, [x19, #0x20]
  922724: 1b017c00     	mul	w0, w0, w1
  922728: a9410662     	ldp	x2, x1, [x19, #0x10]
  92272c: 8b140400     	add	x0, x0, x20, lsl #1
  922730: 8b0000d4     	add	x20, x6, x0
  922734: 8b170299     	add	x25, x20, x23
  922738: f9400042     	ldr	x2, [x2]
  92273c: 8b040845     	add	x5, x2, x4, lsl #2
  922740: b8647842     	ldr	w2, [x2, x4, lsl #2]
  922744: 8b020021     	add	x1, x1, x2
  922748: b94004b8     	ldr	w24, [x5, #0x4]
  92274c: 35fffb63     	cbnz	w3, 0x9226b8
  922750: aa1703e2     	mov	x2, x23
  922754: aa1403e0     	mov	x0, x20
  922758: 97eb9f76     	bl	0x40a530
  92275c: f9400e61     	ldr	x1, [x19, #0x18]
  922760: aa1903e0     	mov	x0, x25
  922764: aa1703e2     	mov	x2, x23
  922768: 8b384021     	add	x1, x1, w24, uxtw
  92276c: 97eb9f71     	bl	0x40a530
  922770: 17ffffdb     	b	0x9226dc
  922774: 9101a3e0     	add	x0, sp, #0x68
  922778: 97fffaf4     	bl	0x921348
  92277c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  922780: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  922784: a94363f7     	ldp	x23, x24, [sp, #0x30]
  922788: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  92278c: a8cc7bfd     	ldp	x29, x30, [sp], #0xc0
  922790: d65f03c0     	ret
  922794: aa0003f3     	mov	x19, x0
  922798: 9101a3e0     	add	x0, sp, #0x68
  92279c: 97fffaeb     	bl	0x921348
  9227a0: aa1303e0     	mov	x0, x19
  9227a4: 97eb9feb     	bl	0x40a750
  9227a8: f9400000     	ldr	x0, [x0]
  9227ac: 17ffffa5     	b	0x922640
