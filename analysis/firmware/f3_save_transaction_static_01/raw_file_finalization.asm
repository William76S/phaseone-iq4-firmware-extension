  7d8a38: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7d8a3c: 910003fd     	mov	x29, sp
  7d8a40: f9000bf3     	str	x19, [sp, #0x10]
  7d8a44: aa0003f3     	mov	x19, x0
  7d8a48: 9140a273     	add	x19, x19, #0x28, lsl #12 // =0x28000
  7d8a4c: 91006000     	add	x0, x0, #0x18
  7d8a50: 97ffb9df     	bl	0x7c71cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0xb204>
  7d8a54: f955d261     	ldr	x1, [x19, #0x2ba0]
  7d8a58: f9400bf3     	ldr	x19, [sp, #0x10]
  7d8a5c: aa0103e0     	mov	x0, x1
  7d8a60: f9400021     	ldr	x1, [x1]
  7d8a64: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7d8a68: f9400821     	ldr	x1, [x1, #0x10]
  7d8a6c: d61f0020     	br	x1
  7d8a70: 91006000     	add	x0, x0, #0x18
  7d8a74: 17ffd436     	b	0x7cdb4c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x11b84>
