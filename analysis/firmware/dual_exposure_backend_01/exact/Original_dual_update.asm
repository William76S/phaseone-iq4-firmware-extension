
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  5384cc: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  5384d0: 910003fd     	mov	x29, sp
  5384d4: f9000fe0     	str	x0, [sp, #0x18]
  5384d8: f9400fe0     	ldr	x0, [sp, #0x18]
  5384dc: f9405800     	ldr	x0, [x0, #0xb0]
  5384e0: 97fea553     	bl	0x4e1a2c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaba80>
  5384e4: f9401800     	ldr	x0, [x0, #0x30]
  5384e8: f9002be0     	str	x0, [sp, #0x50]
  5384ec: f9402be0     	ldr	x0, [sp, #0x50]
  5384f0: 9103a000     	add	x0, x0, #0xe8
  5384f4: 97fb50e3     	bl	0x40c880 <.text+0x1650>
  5384f8: b9004fe0     	str	w0, [sp, #0x4c]
  5384fc: b9404fe0     	ldr	w0, [sp, #0x4c]
  538500: 94078c0e     	bl	0x71b538 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x180c>
  538504: bd004be0     	str	s0, [sp, #0x48]
  538508: f9402be1     	ldr	x1, [sp, #0x50]
  53850c: d2822c00     	mov	x0, #0x1160             // =4448
  538510: 8b000020     	add	x0, x1, x0
  538514: 97fb50db     	bl	0x40c880 <.text+0x1650>
  538518: b9002fe0     	str	w0, [sp, #0x2c]
  53851c: f9402be1     	ldr	x1, [sp, #0x50]
  538520: d2821000     	mov	x0, #0x1080             // =4224
  538524: 8b000020     	add	x0, x1, x0
  538528: 97fbe77b     	bl	0x432314 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0xbcc>
  53852c: 1e204001     	fmov	s1, s0
  538530: bd404be0     	ldr	s0, [sp, #0x48]
  538534: 1e210800     	fmul	s0, s0, s1
  538538: bd0047e0     	str	s0, [sp, #0x44]
  53853c: bd4047e0     	ldr	s0, [sp, #0x44]
  538540: 94078cb1     	bl	0x71b804 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ad8>
  538544: b9002fe0     	str	w0, [sp, #0x2c]
  538548: f9400fe0     	ldr	x0, [sp, #0x18]
  53854c: f941f002     	ldr	x2, [x0, #0x3e0]
  538550: f9400fe0     	ldr	x0, [sp, #0x18]
  538554: f941f000     	ldr	x0, [x0, #0x3e0]
  538558: f9400000     	ldr	x0, [x0]
  53855c: 9103e000     	add	x0, x0, #0xf8
  538560: f9400001     	ldr	x1, [x0]
  538564: aa0203e0     	mov	x0, x2
  538568: d63f0020     	blr	x1
  53856c: b9002be0     	str	w0, [sp, #0x28]
  538570: f9400fe0     	ldr	x0, [sp, #0x18]
  538574: f941f002     	ldr	x2, [x0, #0x3e0]
  538578: f9400fe0     	ldr	x0, [sp, #0x18]
  53857c: f941f000     	ldr	x0, [x0, #0x3e0]
  538580: f9400000     	ldr	x0, [x0]
  538584: 91040000     	add	x0, x0, #0x100
  538588: f9400001     	ldr	x1, [x0]
  53858c: aa0203e0     	mov	x0, x2
  538590: d63f0020     	blr	x1
  538594: b90027e0     	str	w0, [sp, #0x24]
  538598: 9100b3e1     	add	x1, sp, #0x2c
  53859c: 9100a3e0     	add	x0, sp, #0x28
  5385a0: 97fd1796     	bl	0x47e3f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x4844c>
  5385a4: b9400000     	ldr	w0, [x0]
  5385a8: b9002fe0     	str	w0, [sp, #0x2c]
  5385ac: 910093e1     	add	x1, sp, #0x24
  5385b0: 9100b3e0     	add	x0, sp, #0x2c
  5385b4: 97fc9ecb     	bl	0x4600e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2a134>
  5385b8: b9400000     	ldr	w0, [x0]
  5385bc: b9002fe0     	str	w0, [sp, #0x2c]
  5385c0: f9402be1     	ldr	x1, [sp, #0x50]
  5385c4: d2822c00     	mov	x0, #0x1160             // =4448
  5385c8: 8b000020     	add	x0, x1, x0
  5385cc: b9402fe1     	ldr	w1, [sp, #0x2c]
  5385d0: 97fb50b9     	bl	0x40c8b4 <.text+0x1684>
  5385d4: b9402fe0     	ldr	w0, [sp, #0x2c]
  5385d8: b9404fe1     	ldr	w1, [sp, #0x4c]
  5385dc: 4b000020     	sub	w0, w1, w0
  5385e0: 1e220001     	scvtf	s1, w0
  5385e4: 1e251000     	fmov	s0, #12.00000000
  5385e8: 1e201820     	fdiv	s0, s1, s0
  5385ec: bd0043e0     	str	s0, [sp, #0x40]
  5385f0: f9400fe0     	ldr	x0, [sp, #0x18]
  5385f4: f9405800     	ldr	x0, [x0, #0xb0]
  5385f8: 97fef8d0     	bl	0x4f6938 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xc098c>
  5385fc: f9001fe0     	str	x0, [sp, #0x38]
  538600: f9401fe0     	ldr	x0, [sp, #0x38]
  538604: f9400800     	ldr	x0, [x0, #0x10]
  538608: f9001be0     	str	x0, [sp, #0x30]
  53860c: f9401be0     	ldr	x0, [sp, #0x30]
  538610: f9400000     	ldr	x0, [x0]
  538614: 91004000     	add	x0, x0, #0x10
  538618: f9400002     	ldr	x2, [x0]
  53861c: 52808c61     	mov	w1, #0x463              // =1123
  538620: f9401be0     	ldr	x0, [sp, #0x30]
  538624: d63f0040     	blr	x2
  538628: f9002fe0     	str	x0, [sp, #0x58]
  53862c: f9402fe0     	ldr	x0, [sp, #0x58]
  538630: f100001f     	cmp	x0, #0x0
  538634: 54000081     	b.ne	0x538644 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3f594>
  538638: d0003340     	adrp	x0, 0xba2000
  53863c: 91134000     	add	x0, x0, #0x4d0
  538640: f9002fe0     	str	x0, [sp, #0x58]
  538644: bd4043e0     	ldr	s0, [sp, #0x40]
  538648: 1e22c000     	fcvt	d0, s0
  53864c: f9402fe2     	ldr	x2, [sp, #0x58]
  538650: d2800401     	mov	x1, #0x20               // =32
  538654: 9001cb80     	adrp	x0, 0x3ea8000 <_ZNSt5ctypeIcE2idE+0x2f44ed8>
  538658: 9105a000     	add	x0, x0, #0x168
  53865c: 97fb4635     	bl	0x409f30 <snprintf@plt>
  538660: f9400fe0     	ldr	x0, [sp, #0x18]
  538664: f941e402     	ldr	x2, [x0, #0x3c8]
  538668: 9001cb80     	adrp	x0, 0x3ea8000 <_ZNSt5ctypeIcE2idE+0x2f44ed8>
  53866c: 9105a001     	add	x1, x0, #0x168
  538670: aa0203e0     	mov	x0, x2
  538674: 97fc7d27     	bl	0x457b10 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21b64>
  538678: d503201f     	nop
  53867c: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  538680: d65f03c0     	ret
