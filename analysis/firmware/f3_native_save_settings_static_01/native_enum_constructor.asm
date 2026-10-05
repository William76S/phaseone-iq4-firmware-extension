  4e6504: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4e6508: 910003fd     	mov	x29, sp
  4e650c: f90017e0     	str	x0, [sp, #0x28]
  4e6510: f90013e1     	str	x1, [sp, #0x20]
  4e6514: b9001fe2     	str	w2, [sp, #0x1c]
  4e6518: f94017e0     	ldr	x0, [sp, #0x28]
  4e651c: 97fffc7f     	bl	0x4e5718 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf76c>
  4e6520: b0003540     	adrp	x0, 0xb8f000
  4e6524: 9137a001     	add	x1, x0, #0xde8
  4e6528: f94017e0     	ldr	x0, [sp, #0x28]
  4e652c: f9000001     	str	x1, [x0]
  4e6530: f94017e0     	ldr	x0, [sp, #0x28]
  4e6534: f94013e1     	ldr	x1, [sp, #0x20]
  4e6538: f9000c01     	str	x1, [x0, #0x18]
  4e653c: f94017e0     	ldr	x0, [sp, #0x28]
  4e6540: b9401fe1     	ldr	w1, [sp, #0x1c]
  4e6544: b9002001     	str	w1, [x0, #0x20]
  4e6548: f94017e0     	ldr	x0, [sp, #0x28]
  4e654c: 52800021     	mov	w1, #0x1                // =1
  4e6550: 39009001     	strb	w1, [x0, #0x24]
  4e6554: d503201f     	nop
  4e6558: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  4e655c: d65f03c0     	ret
  4e6560: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  4e6564: 910003fd     	mov	x29, sp
  4e6568: f9000bf3     	str	x19, [sp, #0x10]
  4e656c: f90017e0     	str	x0, [sp, #0x28]
  4e6570: f90013e1     	str	x1, [sp, #0x20]
  4e6574: f94017e0     	ldr	x0, [sp, #0x28]
  4e6578: f94013e1     	ldr	x1, [sp, #0x20]
  4e657c: 97fffaae     	bl	0x4e5034 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf088>
  4e6580: b0003540     	adrp	x0, 0xb8f000
  4e6584: 91350001     	add	x1, x0, #0xd40
  4e6588: f94017e0     	ldr	x0, [sp, #0x28]
  4e658c: f9000001     	str	x1, [x0]
  4e6590: f94017e0     	ldr	x0, [sp, #0x28]
  4e6594: 91008000     	add	x0, x0, #0x20
  4e6598: 97ffff21     	bl	0x4e621c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0270>
  4e659c: f94013e0     	ldr	x0, [sp, #0x20]
  4e65a0: f9400000     	ldr	x0, [x0]
  4e65a4: 91022000     	add	x0, x0, #0x88
  4e65a8: f9400001     	ldr	x1, [x0]
  4e65ac: f94013e0     	ldr	x0, [sp, #0x20]
  4e65b0: d63f0020     	blr	x1
  4e65b4: b9003be0     	str	w0, [sp, #0x38]
  4e65b8: b9003fff     	str	wzr, [sp, #0x3c]
  4e65bc: b9403fe1     	ldr	w1, [sp, #0x3c]
  4e65c0: b9403be0     	ldr	w0, [sp, #0x38]
  4e65c4: 6b00003f     	cmp	w1, w0
  4e65c8: 5400034a     	b.ge	0x4e6630 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0684>
  4e65cc: d2800500     	mov	x0, #0x28               // =40
  4e65d0: 97fc8e24     	bl	0x409e60 <_Znwm@plt>
  4e65d4: aa0003f3     	mov	x19, x0
  4e65d8: b9403fe2     	ldr	w2, [sp, #0x3c]
  4e65dc: f94013e1     	ldr	x1, [sp, #0x20]
  4e65e0: aa1303e0     	mov	x0, x19
  4e65e4: 97ffffc8     	bl	0x4e6504 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0558>
  4e65e8: aa1303e0     	mov	x0, x19
  4e65ec: aa0003e1     	mov	x1, x0
  4e65f0: f94017e0     	ldr	x0, [sp, #0x28]
  4e65f4: 94000122     	bl	0x4e6a7c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0ad0>
  4e65f8: b9403fe0     	ldr	w0, [sp, #0x3c]
  4e65fc: 11000400     	add	w0, w0, #0x1
  4e6600: b9003fe0     	str	w0, [sp, #0x3c]
  4e6604: 17ffffee     	b	0x4e65bc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0610>
  4e6608: aa0003f3     	mov	x19, x0
  4e660c: f94017e0     	ldr	x0, [sp, #0x28]
  4e6610: 91008000     	add	x0, x0, #0x20
  4e6614: 97ffff0f     	bl	0x4e6250 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb02a4>
  4e6618: 14000002     	b	0x4e6620 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0674>
  4e661c: aa0003f3     	mov	x19, x0
  4e6620: f94017e0     	ldr	x0, [sp, #0x28]
  4e6624: 97fffa97     	bl	0x4e5080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf0d4>
  4e6628: aa1303e0     	mov	x0, x19
  4e662c: 97fc9049     	bl	0x40a750 <_Unwind_Resume@plt>
  4e6630: d503201f     	nop
  4e6634: f9400bf3     	ldr	x19, [sp, #0x10]
  4e6638: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  4e663c: d65f03c0     	ret
  4e6640: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4e6644: 910003fd     	mov	x29, sp
  4e6648: f9000fe0     	str	x0, [sp, #0x18]
  4e664c: b0003540     	adrp	x0, 0xb8f000
  4e6650: 91350001     	add	x1, x0, #0xd40
  4e6654: f9400fe0     	ldr	x0, [sp, #0x18]
  4e6658: f9000001     	str	x1, [x0]
  4e665c: f9400fe0     	ldr	x0, [sp, #0x18]
  4e6660: 91008000     	add	x0, x0, #0x20
  4e6664: 97fffefb     	bl	0x4e6250 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb02a4>
  4e6668: f9400fe0     	ldr	x0, [sp, #0x18]
  4e666c: 97fffa85     	bl	0x4e5080 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaf0d4>
  4e6670: d503201f     	nop
  4e6674: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4e6678: d65f03c0     	ret
  4e667c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4e6680: 910003fd     	mov	x29, sp
  4e6684: f9000fe0     	str	x0, [sp, #0x18]
  4e6688: f9400fe0     	ldr	x0, [sp, #0x18]
  4e668c: 97ffffed     	bl	0x4e6640 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0694>
  4e6690: d2800901     	mov	x1, #0x48               // =72
  4e6694: f9400fe0     	ldr	x0, [sp, #0x18]
  4e6698: 97fc8dd2     	bl	0x409de0 <_ZdlPvm@plt>
  4e669c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  4e66a0: d65f03c0     	ret
  4e66a4: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  4e66a8: 910003fd     	mov	x29, sp
  4e66ac: f9000fe0     	str	x0, [sp, #0x18]
  4e66b0: f9400fe0     	ldr	x0, [sp, #0x18]
  4e66b4: 91008000     	add	x0, x0, #0x20
  4e66b8: 52800001     	mov	w1, #0x0                // =0
  4e66bc: 97ffff74     	bl	0x4e648c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb04e0>
  4e66c0: f90017e0     	str	x0, [sp, #0x28]
  4e66c4: f9400fe0     	ldr	x0, [sp, #0x18]
  4e66c8: 91008000     	add	x0, x0, #0x20
  4e66cc: f94017e1     	ldr	x1, [sp, #0x28]
  4e66d0: 97ffff53     	bl	0x4e641c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0470>
  4e66d4: 12001c00     	and	w0, w0, #0xff
  4e66d8: 52000000     	eor	w0, w0, #0x1
  4e66dc: 12001c00     	and	w0, w0, #0xff
  4e66e0: 7100001f     	cmp	w0, #0x0
  4e66e4: 540005c0     	b.eq	0x4e679c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb07f0>
  4e66e8: f94017e0     	ldr	x0, [sp, #0x28]
  4e66ec: 97fdfedc     	bl	0x46625c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x302b0>
  4e66f0: aa0003e4     	mov	x4, x0
  4e66f4: f100009f     	cmp	x4, #0x0
  4e66f8: 54000120     	b.eq	0x4e671c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0770>
  4e66fc: d2800003     	mov	x3, #0x0                // =0
  4e6700: b0003540     	adrp	x0, 0xb8f000
  4e6704: 9139e002     	add	x2, x0, #0xe78
  4e6708: b0003540     	adrp	x0, 0xb8f000
  4e670c: 91222001     	add	x1, x0, #0x888
  4e6710: aa0403e0     	mov	x0, x4
  4e6714: 97fc91af     	bl	0x40add0 <__dynamic_cast@plt>
  4e6718: 14000002     	b	0x4e6720 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0774>
  4e671c: d2800000     	mov	x0, #0x0                // =0
  4e6720: f90013e0     	str	x0, [sp, #0x20]
  4e6724: f94013e0     	ldr	x0, [sp, #0x20]
  4e6728: f100001f     	cmp	x0, #0x0
  4e672c: 54000141     	b.ne	0x4e6754 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb07a8>
  4e6730: 52800b03     	mov	w3, #0x58               // =88
  4e6734: b0003540     	adrp	x0, 0xb8f000
  4e6738: 91334002     	add	x2, x0, #0xcd0
  4e673c: b0003540     	adrp	x0, 0xb8f000
  4e6740: 91340001     	add	x1, x0, #0xd00
  4e6744: b0003540     	adrp	x0, 0xb8f000
  4e6748: 91342000     	add	x0, x0, #0xd08
  4e674c: 97fc8f8d     	bl	0x40a580 <printf@plt>
  4e6750: 940a17ee     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  4e6754: f94013e0     	ldr	x0, [sp, #0x20]
  4e6758: f100001f     	cmp	x0, #0x0
  4e675c: 54000100     	b.eq	0x4e677c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb07d0>
  4e6760: f94013e0     	ldr	x0, [sp, #0x20]
  4e6764: 940001bd     	bl	0x4e6e58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb0eac>
  4e6768: 12001c00     	and	w0, w0, #0xff
  4e676c: 7100001f     	cmp	w0, #0x0
  4e6770: 54000060     	b.eq	0x4e677c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb07d0>
  4e6774: f94013e0     	ldr	x0, [sp, #0x20]
  4e6778: 1400000a     	b	0x4e67a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xb07f4>
  4e677c: f94017e0     	ldr	x0, [sp, #0x28]
