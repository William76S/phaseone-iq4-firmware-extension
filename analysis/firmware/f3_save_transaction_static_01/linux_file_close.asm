  826ca8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  826cac: 910003fd     	mov	x29, sp
  826cb0: f9000fe0     	str	x0, [sp, #0x18]
  826cb4: f9000be1     	str	x1, [sp, #0x10]
  826cb8: 52800020     	mov	w0, #0x1                // =1
  826cbc: 3900bfe0     	strb	w0, [sp, #0x2f]
  826cc0: f9400be0     	ldr	x0, [sp, #0x10]
  826cc4: f9400000     	ldr	x0, [x0]
  826cc8: 91010000     	add	x0, x0, #0x40
  826ccc: f9400001     	ldr	x1, [x0]
  826cd0: f9400be0     	ldr	x0, [sp, #0x10]
  826cd4: d63f0020     	blr	x1
  826cd8: 12001c00     	and	w0, w0, #0xff
  826cdc: 7100001f     	cmp	w0, #0x0
  826ce0: 54000140     	b.eq	0x826d08 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ad40>
  826ce4: f9400fe0     	ldr	x0, [sp, #0x18]
  826ce8: f9400000     	ldr	x0, [x0]
  826cec: 9104a000     	add	x0, x0, #0x128
  826cf0: f9400002     	ldr	x2, [x0]
  826cf4: f9400be1     	ldr	x1, [sp, #0x10]
  826cf8: f9400fe0     	ldr	x0, [sp, #0x18]
  826cfc: d63f0040     	blr	x2
  826d00: 12001c00     	and	w0, w0, #0xff
  826d04: 3900bfe0     	strb	w0, [sp, #0x2f]
  826d08: f9400be0     	ldr	x0, [sp, #0x10]
  826d0c: 97f11114     	bl	0x46b15c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x351b0>
  826d10: 97ef8f60     	bl	0x40aa90 <close@plt>
  826d14: 7100001f     	cmp	w0, #0x0
  826d18: 540000cb     	b.lt	0x826d30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ad68>
  826d1c: 3940bfe0     	ldrb	w0, [sp, #0x2f]
  826d20: 7100001f     	cmp	w0, #0x0
  826d24: 54000060     	b.eq	0x826d30 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ad68>
  826d28: 52800020     	mov	w0, #0x1                // =1
  826d2c: 14000002     	b	0x826d34 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ad6c>
  826d30: 52800000     	mov	w0, #0x0                // =0
  826d34: 7100001f     	cmp	w0, #0x0
  826d38: 54000060     	b.eq	0x826d44 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ad7c>
  826d3c: 52800020     	mov	w0, #0x1                // =1
  826d40: 14000009     	b	0x826d64 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6ad9c>
  826d44: d0002b40     	adrp	x0, 0xd90000
  826d48: 91378003     	add	x3, x0, #0xde0
  826d4c: 52803ea2     	mov	w2, #0x1f5              // =501
  826d50: d0002b40     	adrp	x0, 0xd90000
  826d54: 911ee001     	add	x1, x0, #0x7b8
  826d58: 52800080     	mov	w0, #0x4                // =4
  826d5c: 97fc7dfc     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  826d60: 52800000     	mov	w0, #0x0                // =0
  826d64: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  826d68: d65f03c0     	ret
