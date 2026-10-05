  825770: d10043ff     	sub	sp, sp, #0x10
  825774: f90007e0     	str	x0, [sp, #0x8]
  825778: f0002b40     	adrp	x0, 0xd90000
  82577c: 91104001     	add	x1, x0, #0x410
  825780: f94007e0     	ldr	x0, [sp, #0x8]
  825784: f9000001     	str	x1, [x0]
  825788: f94007e0     	ldr	x0, [sp, #0x8]
  82578c: f900041f     	str	xzr, [x0, #0x8]
  825790: f94007e0     	ldr	x0, [sp, #0x8]
  825794: b900101f     	str	wzr, [x0, #0x10]
  825798: f94007e0     	ldr	x0, [sp, #0x8]
  82579c: 3900501f     	strb	wzr, [x0, #0x14]
  8257a0: f94007e0     	ldr	x0, [sp, #0x8]
  8257a4: 3900541f     	strb	wzr, [x0, #0x15]
  8257a8: d503201f     	nop
  8257ac: 910043ff     	add	sp, sp, #0x10
  8257b0: d65f03c0     	ret
  8257b4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8257b8: 910003fd     	mov	x29, sp
  8257bc: f9000fe0     	str	x0, [sp, #0x18]
  8257c0: f0002b40     	adrp	x0, 0xd90000
  8257c4: 91104001     	add	x1, x0, #0x410
  8257c8: f9400fe0     	ldr	x0, [sp, #0x18]
  8257cc: f9000001     	str	x1, [x0]
  8257d0: f9400fe0     	ldr	x0, [sp, #0x18]
  8257d4: 9400000e     	bl	0x82580c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x69844>
  8257d8: d503201f     	nop
  8257dc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8257e0: d65f03c0     	ret
  8257e4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8257e8: 910003fd     	mov	x29, sp
  8257ec: f9000fe0     	str	x0, [sp, #0x18]
  8257f0: f9400fe0     	ldr	x0, [sp, #0x18]
  8257f4: 97fffff0     	bl	0x8257b4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x697ec>
  8257f8: d2800301     	mov	x1, #0x18               // =24
  8257fc: f9400fe0     	ldr	x0, [sp, #0x18]
  825800: 97ef9178     	bl	0x409de0 <_ZdlPvm@plt>
  825804: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  825808: d65f03c0     	ret
  82580c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  825810: 910003fd     	mov	x29, sp
  825814: f9000fe0     	str	x0, [sp, #0x18]
  825818: f9400fe0     	ldr	x0, [sp, #0x18]
  82581c: 39405000     	ldrb	w0, [x0, #0x14]
  825820: 7100001f     	cmp	w0, #0x0
  825824: 540001e0     	b.eq	0x825860 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x69898>
  825828: f9400fe0     	ldr	x0, [sp, #0x18]
  82582c: 3900501f     	strb	wzr, [x0, #0x14]
  825830: f9400fe0     	ldr	x0, [sp, #0x18]
  825834: f9400403     	ldr	x3, [x0, #0x8]
  825838: f9400fe0     	ldr	x0, [sp, #0x18]
  82583c: f9400400     	ldr	x0, [x0, #0x8]
  825840: f9400000     	ldr	x0, [x0]
  825844: 9103a000     	add	x0, x0, #0xe8
  825848: f9400002     	ldr	x2, [x0]
  82584c: f9400fe1     	ldr	x1, [sp, #0x18]
  825850: aa0303e0     	mov	x0, x3
  825854: d63f0040     	blr	x2
  825858: 12001c00     	and	w0, w0, #0xff
  82585c: 14000002     	b	0x825864 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6989c>
  825860: 52800000     	mov	w0, #0x0                // =0
  825864: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  825868: d65f03c0     	ret
  82586c: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  825870: 910003fd     	mov	x29, sp
  825874: f90017e0     	str	x0, [sp, #0x28]
  825878: f90013e1     	str	x1, [sp, #0x20]
  82587c: b9001fe2     	str	w2, [sp, #0x1c]
  825880: f94017e0     	ldr	x0, [sp, #0x28]
  825884: f9400405     	ldr	x5, [x0, #0x8]
  825888: f94017e0     	ldr	x0, [sp, #0x28]
  82588c: f9400400     	ldr	x0, [x0, #0x8]
  825890: f9400000     	ldr	x0, [x0]
  825894: 9103c000     	add	x0, x0, #0xf0
  825898: f9400004     	ldr	x4, [x0]
  82589c: f94017e3     	ldr	x3, [sp, #0x28]
  8258a0: b9401fe2     	ldr	w2, [sp, #0x1c]
  8258a4: f94013e1     	ldr	x1, [sp, #0x20]
  8258a8: aa0503e0     	mov	x0, x5
  8258ac: d63f0080     	blr	x4
  8258b0: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8258b4: d65f03c0     	ret
  8258b8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8258bc: 910003fd     	mov	x29, sp
  8258c0: f90017e0     	str	x0, [sp, #0x28]
  8258c4: f90013e1     	str	x1, [sp, #0x20]
  8258c8: b9001fe2     	str	w2, [sp, #0x1c]
  8258cc: f94017e0     	ldr	x0, [sp, #0x28]
  8258d0: 52800021     	mov	w1, #0x1                // =1
  8258d4: 39005401     	strb	w1, [x0, #0x15]
  8258d8: f94017e0     	ldr	x0, [sp, #0x28]
  8258dc: f9400405     	ldr	x5, [x0, #0x8]
  8258e0: f94017e0     	ldr	x0, [sp, #0x28]
  8258e4: f9400400     	ldr	x0, [x0, #0x8]
  8258e8: f9400000     	ldr	x0, [x0]
  8258ec: 9103e000     	add	x0, x0, #0xf8
  8258f0: f9400004     	ldr	x4, [x0]
  8258f4: f94017e3     	ldr	x3, [sp, #0x28]
  8258f8: b9401fe2     	ldr	w2, [sp, #0x1c]
  8258fc: f94013e1     	ldr	x1, [sp, #0x20]
  825900: aa0503e0     	mov	x0, x5
  825904: d63f0080     	blr	x4
  825908: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  82590c: d65f03c0     	ret
  825910: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  825914: 910003fd     	mov	x29, sp
  825918: f90017e0     	str	x0, [sp, #0x28]
  82591c: f90013e1     	str	x1, [sp, #0x20]
  825920: b9001fe2     	str	w2, [sp, #0x1c]
  825924: f94017e0     	ldr	x0, [sp, #0x28]
  825928: f9400405     	ldr	x5, [x0, #0x8]
  82592c: f94017e0     	ldr	x0, [sp, #0x28]
  825930: f9400400     	ldr	x0, [x0, #0x8]
  825934: f9400000     	ldr	x0, [x0]
  825938: 91040000     	add	x0, x0, #0x100
  82593c: f9400004     	ldr	x4, [x0]
