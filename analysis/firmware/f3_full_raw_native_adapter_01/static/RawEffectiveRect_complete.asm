  487e98: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  487e9c: 910003fd     	mov	x29, sp
  487ea0: f9000bf3     	str	x19, [sp, #0x10]
  487ea4: aa0803f3     	mov	x19, x8
  487ea8: f9001fe0     	str	x0, [sp, #0x38]
  487eac: f9001be1     	str	x1, [sp, #0x30]
  487eb0: 3900bfe2     	strb	w2, [sp, #0x2f]
  487eb4: f9401be0     	ldr	x0, [sp, #0x30]
  487eb8: b9407001     	ldr	w1, [x0, #0x70]
  487ebc: b00026c0     	adrp	x0, 0x960000
  487ec0: 91102004     	add	x4, x0, #0x408
  487ec4: 3940bfe3     	ldrb	w3, [sp, #0x2f]
  487ec8: 2a0103e2     	mov	w2, w1
  487ecc: f9401be1     	ldr	x1, [sp, #0x30]
  487ed0: f9401fe0     	ldr	x0, [sp, #0x38]
  487ed4: 97ffff7e     	bl	0x487ccc
  487ed8: f9401fe1     	ldr	x1, [sp, #0x38]
  487edc: aa1303e0     	mov	x0, x19
  487ee0: 97ff3f9d     	bl	0x457d54
  487ee4: aa1303e0     	mov	x0, x19
  487ee8: f9400bf3     	ldr	x19, [sp, #0x10]
  487eec: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  487ef0: d65f03c0     	ret
