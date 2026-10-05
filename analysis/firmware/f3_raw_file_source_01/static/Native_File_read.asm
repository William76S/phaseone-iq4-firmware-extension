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
