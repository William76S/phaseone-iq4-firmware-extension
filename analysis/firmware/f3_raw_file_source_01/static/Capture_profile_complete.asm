  7ca6a8: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  7ca6ac: 910003fd     	mov	x29, sp
  7ca6b0: f90017e0     	str	x0, [sp, #0x28]
  7ca6b4: f90013e1     	str	x1, [sp, #0x20]
  7ca6b8: b9001fe2     	str	w2, [sp, #0x1c]
  7ca6bc: f94017e1     	ldr	x1, [sp, #0x28]
  7ca6c0: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca6c4: 8b000020     	add	x0, x1, x0
  7ca6c8: 5280a901     	mov	w1, #0x548              // =1352
  7ca6cc: 94004207     	bl	0x7daee8
  7ca6d0: b9003fe0     	str	w0, [sp, #0x3c]
  7ca6d4: b9403fe0     	ldr	w0, [sp, #0x3c]
  7ca6d8: 7100001f     	cmp	w0, #0x0
  7ca6dc: 540002a0     	b.eq	0x7ca730
  7ca6e0: b9403fe1     	ldr	w1, [sp, #0x3c]
  7ca6e4: b9401fe0     	ldr	w0, [sp, #0x1c]
  7ca6e8: 6b00003f     	cmp	w1, w0
  7ca6ec: 54000222     	b.hs	0x7ca730
  7ca6f0: f94017e1     	ldr	x1, [sp, #0x28]
  7ca6f4: d29a0b00     	mov	x0, #0xd058             // =53336
  7ca6f8: 8b000026     	add	x6, x1, x0
  7ca6fc: f94017e0     	ldr	x0, [sp, #0x28]
  7ca700: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7ca704: f9681400     	ldr	x0, [x0, #0x5028]
  7ca708: b9403fe1     	ldr	w1, [sp, #0x3c]
  7ca70c: 52800005     	mov	w5, #0x0                // =0
  7ca710: 2a0103e4     	mov	w4, w1
  7ca714: f94013e3     	ldr	x3, [sp, #0x20]
  7ca718: 5280a902     	mov	w2, #0x548              // =1352
  7ca71c: aa0003e1     	mov	x1, x0
  7ca720: aa0603e0     	mov	x0, x6
  7ca724: 9400420b     	bl	0x7daf50
  7ca728: b9403fe0     	ldr	w0, [sp, #0x3c]
  7ca72c: 14000002     	b	0x7ca734
  7ca730: 52800000     	mov	w0, #0x0                // =0
  7ca734: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  7ca738: d65f03c0     	ret
