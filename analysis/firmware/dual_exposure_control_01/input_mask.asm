
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000435fac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_>:
  4acba0: 91220000     	add	x0, x0, #0x880
  4acba4: 97fd960a     	bl	0x4123cc <.text+0x719c>
  4acba8: 12800004     	mov	w4, #-0x1               // =-1
  4acbac: 12800003     	mov	w3, #-0x1               // =-1
  4acbb0: 12800002     	mov	w2, #-0x1               // =-1
  4acbb4: 12800fe1     	mov	w1, #-0x80              // =-128
  4acbb8: d001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4acbbc: 91222000     	add	x0, x0, #0x888
  4acbc0: 97fd9603     	bl	0x4123cc <.text+0x719c>
  4acbc4: 52800004     	mov	w4, #0x0                // =0
  4acbc8: 52800003     	mov	w3, #0x0                // =0
  4acbcc: 12800002     	mov	w2, #-0x1               // =-1
  4acbd0: 12800fe1     	mov	w1, #-0x80              // =-128
  4acbd4: d001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4acbd8: 91224000     	add	x0, x0, #0x890
  4acbdc: 97fd95fc     	bl	0x4123cc <.text+0x719c>
  4acbe0: 52800004     	mov	w4, #0x0                // =0
  4acbe4: 12800003     	mov	w3, #-0x1               // =-1
  4acbe8: 52800002     	mov	w2, #0x0                // =0
  4acbec: 12800fe1     	mov	w1, #-0x80              // =-128
  4acbf0: d001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4acbf4: 91226000     	add	x0, x0, #0x898
  4acbf8: 97fd95f5     	bl	0x4123cc <.text+0x719c>
  4acbfc: 12800004     	mov	w4, #-0x1               // =-1
  4acc00: 52800003     	mov	w3, #0x0                // =0
  4acc04: 52800002     	mov	w2, #0x0                // =0
  4acc08: 12800fe1     	mov	w1, #-0x80              // =-128
  4acc0c: d001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4acc10: 91228000     	add	x0, x0, #0x8a0
  4acc14: 97fd95ee     	bl	0x4123cc <.text+0x719c>
  4acc18: 12800fe4     	mov	w4, #-0x80              // =-128
  4acc1c: 12800fe3     	mov	w3, #-0x80              // =-128
  4acc20: 12800fe2     	mov	w2, #-0x80              // =-128
  4acc24: 12800fe1     	mov	w1, #-0x80              // =-128
  4acc28: d001cfa0     	adrp	x0, 0x3ea2000 <_ZNSt5ctypeIcE2idE+0x2f3eed8>
  4acc2c: 9122a000     	add	x0, x0, #0x8a8
  4acc30: 97fd95e7     	bl	0x4123cc <.text+0x719c>
  4acc34: d503201f     	nop
  4acc38: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4acc3c: d65f03c0     	ret
  4acc40: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
  4acc44: 910003fd     	mov	x29, sp
  4acc48: 529fffe1     	mov	w1, #0xffff             // =65535
  4acc4c: 52800020     	mov	w0, #0x1                // =1
  4acc50: 97ffff54     	bl	0x4ac9a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x769f4>
  4acc54: a8c17bfd     	ldp	x29, x30, [sp], #0x10
  4acc58: d65f03c0     	ret
  4acc5c: d10043ff     	sub	sp, sp, #0x10
  4acc60: f90007e0     	str	x0, [sp, #0x8]
  4acc64: f94007e0     	ldr	x0, [sp, #0x8]
  4acc68: b9400000     	ldr	w0, [x0]
  4acc6c: 910043ff     	add	sp, sp, #0x10
  4acc70: d65f03c0     	ret
  4acc74: d10043ff     	sub	sp, sp, #0x10
  4acc78: f90007e0     	str	x0, [sp, #0x8]
  4acc7c: f94007e0     	ldr	x0, [sp, #0x8]
  4acc80: 52800021     	mov	w1, #0x1                // =1
  4acc84: 39000001     	strb	w1, [x0]
  4acc88: d503201f     	nop
  4acc8c: 910043ff     	add	sp, sp, #0x10
  4acc90: d65f03c0     	ret
  4acc94: d10043ff     	sub	sp, sp, #0x10
  4acc98: f90007e0     	str	x0, [sp, #0x8]
  4acc9c: f94007e0     	ldr	x0, [sp, #0x8]
  4acca0: 39400000     	ldrb	w0, [x0]
  4acca4: 910043ff     	add	sp, sp, #0x10
  4acca8: d65f03c0     	ret
  4accac: d10043ff     	sub	sp, sp, #0x10
  4accb0: f90007e0     	str	x0, [sp, #0x8]
  4accb4: 39001fe1     	strb	w1, [sp, #0x7]
  4accb8: f94007e0     	ldr	x0, [sp, #0x8]
  4accbc: 39401fe1     	ldrb	w1, [sp, #0x7]
  4accc0: 39000001     	strb	w1, [x0]
  4accc4: d503201f     	nop
  4accc8: 910043ff     	add	sp, sp, #0x10
  4acccc: d65f03c0     	ret
  4accd0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4accd4: 910003fd     	mov	x29, sp
  4accd8: f9000bf3     	str	x19, [sp, #0x10]
  4accdc: f90017e0     	str	x0, [sp, #0x28]
  4acce0: f90013e1     	str	x1, [sp, #0x20]
  4acce4: f94017f3     	ldr	x19, [sp, #0x28]
  4acce8: f94017e0     	ldr	x0, [sp, #0x28]
  4accec: 97ffffea     	bl	0x4acc94 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76ce8>
  4accf0: 12001c00     	and	w0, w0, #0xff
  4accf4: 7100001f     	cmp	w0, #0x0
  4accf8: 540000c1     	b.ne	0x4acd10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76d64>
  4accfc: f94013e0     	ldr	x0, [sp, #0x20]
  4acd00: 97ffffe5     	bl	0x4acc94 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76ce8>
  4acd04: 12001c00     	and	w0, w0, #0xff
  4acd08: 7100001f     	cmp	w0, #0x0
  4acd0c: 54000060     	b.eq	0x4acd18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76d6c>
  4acd10: 52800020     	mov	w0, #0x1                // =1
  4acd14: 14000002     	b	0x4acd1c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76d70>
  4acd18: 52800000     	mov	w0, #0x0                // =0
  4acd1c: 2a0003e1     	mov	w1, w0
  4acd20: aa1303e0     	mov	x0, x19
  4acd24: 97ffffe2     	bl	0x4accac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76d00>
  4acd28: f94017e0     	ldr	x0, [sp, #0x28]
  4acd2c: 91000413     	add	x19, x0, #0x1
  4acd30: f94017e0     	ldr	x0, [sp, #0x28]
  4acd34: 91000400     	add	x0, x0, #0x1
  4acd38: 97ffffd7     	bl	0x4acc94 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76ce8>
  4acd3c: 12001c00     	and	w0, w0, #0xff
