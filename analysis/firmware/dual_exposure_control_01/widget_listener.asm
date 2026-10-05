
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000435fac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_>:
  4ac590: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4ac594: 910003fd     	mov	x29, sp
  4ac598: f9000fe0     	str	x0, [sp, #0x18]
  4ac59c: f9000be1     	str	x1, [sp, #0x10]
  4ac5a0: f9400be0     	ldr	x0, [sp, #0x10]
  4ac5a4: 940001ae     	bl	0x4acc5c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76cb0>
  4ac5a8: 7100201f     	cmp	w0, #0x8
  4ac5ac: 540000e1     	b.ne	0x4ac5c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x7661c>
  4ac5b0: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac5b4: 3941c000     	ldrb	w0, [x0, #0x70]
  4ac5b8: 7100001f     	cmp	w0, #0x0
  4ac5bc: 54000060     	b.eq	0x4ac5c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x7661c>
  4ac5c0: 52800020     	mov	w0, #0x1                // =1
  4ac5c4: 14000002     	b	0x4ac5cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76620>
  4ac5c8: 52800000     	mov	w0, #0x0                // =0
  4ac5cc: 7100001f     	cmp	w0, #0x0
  4ac5d0: 540001e0     	b.eq	0x4ac60c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76660>
  4ac5d4: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac5d8: 94000289     	bl	0x4acffc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x77050>
  4ac5dc: f90017e0     	str	x0, [sp, #0x28]
  4ac5e0: f94017e0     	ldr	x0, [sp, #0x28]
  4ac5e4: f100001f     	cmp	x0, #0x0
  4ac5e8: 54000120     	b.eq	0x4ac60c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76660>
  4ac5ec: f94017e0     	ldr	x0, [sp, #0x28]
  4ac5f0: f9400000     	ldr	x0, [x0]
  4ac5f4: 9104e000     	add	x0, x0, #0x138
  4ac5f8: f9400003     	ldr	x3, [x0]
  4ac5fc: f9400be2     	ldr	x2, [sp, #0x10]
  4ac600: f9400fe1     	ldr	x1, [sp, #0x18]
  4ac604: f94017e0     	ldr	x0, [sp, #0x28]
  4ac608: d63f0060     	blr	x3
  4ac60c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac610: f9403000     	ldr	x0, [x0, #0x60]
  4ac614: f100001f     	cmp	x0, #0x0
  4ac618: 540001e0     	b.eq	0x4ac654 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x766a8>
  4ac61c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac620: f9403005     	ldr	x5, [x0, #0x60]
  4ac624: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac628: f9403000     	ldr	x0, [x0, #0x60]
  4ac62c: f9400000     	ldr	x0, [x0]
  4ac630: 91004000     	add	x0, x0, #0x10
  4ac634: f9400004     	ldr	x4, [x0]
  4ac638: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac63c: b9406800     	ldr	w0, [x0, #0x68]
  4ac640: 2a0003e3     	mov	w3, w0
  4ac644: f9400be2     	ldr	x2, [sp, #0x10]
  4ac648: f9400fe1     	ldr	x1, [sp, #0x18]
  4ac64c: aa0503e0     	mov	x0, x5
  4ac650: d63f0080     	blr	x4
  4ac654: d503201f     	nop
  4ac658: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  4ac65c: d65f03c0     	ret
  4ac660: d10083ff     	sub	sp, sp, #0x20
  4ac664: f9000fe0     	str	x0, [sp, #0x18]
  4ac668: f9000be1     	str	x1, [sp, #0x10]
  4ac66c: b9000fe2     	str	w2, [sp, #0xc]
  4ac670: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac674: f9400be1     	ldr	x1, [sp, #0x10]
  4ac678: f9003001     	str	x1, [x0, #0x60]
  4ac67c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac680: b9400fe1     	ldr	w1, [sp, #0xc]
  4ac684: b9006801     	str	w1, [x0, #0x68]
  4ac688: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac68c: 52800021     	mov	w1, #0x1                // =1
  4ac690: 39010801     	strb	w1, [x0, #0x42]
  4ac694: d503201f     	nop
  4ac698: 910083ff     	add	sp, sp, #0x20
  4ac69c: d65f03c0     	ret
  4ac6a0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4ac6a4: 910003fd     	mov	x29, sp
  4ac6a8: f90017e0     	str	x0, [sp, #0x28]
  4ac6ac: f90013e1     	str	x1, [sp, #0x20]
  4ac6b0: f9000fe2     	str	x2, [sp, #0x18]
  4ac6b4: b90017e3     	str	w3, [sp, #0x14]
  4ac6b8: f94017e0     	ldr	x0, [sp, #0x28]
  4ac6bc: f9400000     	ldr	x0, [x0]
  4ac6c0: 91048000     	add	x0, x0, #0x120
  4ac6c4: f9400002     	ldr	x2, [x0]
  4ac6c8: f9400fe1     	ldr	x1, [sp, #0x18]
  4ac6cc: f94017e0     	ldr	x0, [sp, #0x28]
  4ac6d0: d63f0040     	blr	x2
  4ac6d4: f94017e0     	ldr	x0, [sp, #0x28]
  4ac6d8: f9400000     	ldr	x0, [x0]
  4ac6dc: 91044000     	add	x0, x0, #0x110
  4ac6e0: f9400003     	ldr	x3, [x0]
  4ac6e4: b94017e2     	ldr	w2, [sp, #0x14]
  4ac6e8: f94013e1     	ldr	x1, [sp, #0x20]
  4ac6ec: f94017e0     	ldr	x0, [sp, #0x28]
  4ac6f0: d63f0060     	blr	x3
  4ac6f4: d503201f     	nop
  4ac6f8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  4ac6fc: d65f03c0     	ret
  4ac700: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4ac704: 910003fd     	mov	x29, sp
  4ac708: f9000fe0     	str	x0, [sp, #0x18]
  4ac70c: f9000be1     	str	x1, [sp, #0x10]
  4ac710: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac714: 3941c000     	ldrb	w0, [x0, #0x70]
  4ac718: 7100001f     	cmp	w0, #0x0
  4ac71c: 54000060     	b.eq	0x4ac728 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x7677c>
  4ac720: 910043e0     	add	x0, sp, #0x10
  4ac724: 94000154     	bl	0x4acc74 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76cc8>
  4ac728: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac72c: f9400be1     	ldr	x1, [sp, #0x10]
  4ac730: f8072001     	stur	x1, [x0, #0x72]
  4ac734: d503201f     	nop
  4ac738: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4ac73c: d65f03c0     	ret
  4ac740: d10083ff     	sub	sp, sp, #0x20
  4ac744: f9000fe0     	str	x0, [sp, #0x18]
  4ac748: f9000be1     	str	x1, [sp, #0x10]
  4ac74c: b9000fe2     	str	w2, [sp, #0xc]
  4ac750: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac754: f9400be1     	ldr	x1, [sp, #0x10]
  4ac758: f9002801     	str	x1, [x0, #0x50]
  4ac75c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac760: b9400fe1     	ldr	w1, [sp, #0xc]
  4ac764: b9005801     	str	w1, [x0, #0x58]
  4ac768: d503201f     	nop
  4ac76c: 910083ff     	add	sp, sp, #0x20
  4ac770: d65f03c0     	ret
  4ac774: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4ac778: 910003fd     	mov	x29, sp
  4ac77c: f9000fe0     	str	x0, [sp, #0x18]
  4ac780: f9000be1     	str	x1, [sp, #0x10]
  4ac784: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac788: 52800021     	mov	w1, #0x1                // =1
  4ac78c: 3901b801     	strb	w1, [x0, #0x6e]
  4ac790: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac794: f9402800     	ldr	x0, [x0, #0x50]
  4ac798: f100001f     	cmp	x0, #0x0
  4ac79c: 540002e0     	b.eq	0x4ac7f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x7684c>
  4ac7a0: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac7a4: f9402807     	ldr	x7, [x0, #0x50]
  4ac7a8: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac7ac: f9402800     	ldr	x0, [x0, #0x50]
  4ac7b0: f9400000     	ldr	x0, [x0]
  4ac7b4: 91004000     	add	x0, x0, #0x10
  4ac7b8: f9400006     	ldr	x6, [x0]
  4ac7bc: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac7c0: b9405800     	ldr	w0, [x0, #0x58]
  4ac7c4: d2800005     	mov	x5, #0x0                // =0
  4ac7c8: 2a0003e4     	mov	w4, w0
  4ac7cc: f9400be3     	ldr	x3, [sp, #0x10]
  4ac7d0: 52800002     	mov	w2, #0x0                // =0
  4ac7d4: f9400fe1     	ldr	x1, [sp, #0x18]
  4ac7d8: aa0703e0     	mov	x0, x7
  4ac7dc: d63f00c0     	blr	x6
  4ac7e0: f90017e0     	str	x0, [sp, #0x28]
  4ac7e4: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac7e8: 9101c801     	add	x1, x0, #0x72
  4ac7ec: 9100a3e0     	add	x0, sp, #0x28
  4ac7f0: 94000138     	bl	0x4accd0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76d24>
  4ac7f4: 1400000a     	b	0x4ac81c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x76870>
  4ac7f8: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac7fc: f9400000     	ldr	x0, [x0]
  4ac800: 9102a000     	add	x0, x0, #0xa8
  4ac804: f9400002     	ldr	x2, [x0]
  4ac808: 52800001     	mov	w1, #0x0                // =0
  4ac80c: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac810: d63f0040     	blr	x2
  4ac814: f9400fe0     	ldr	x0, [sp, #0x18]
  4ac818: f8472000     	ldur	x0, [x0, #0x72]
  4ac81c: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  4ac820: d65f03c0     	ret
