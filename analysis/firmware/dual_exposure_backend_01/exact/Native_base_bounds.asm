
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  538684: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  538688: 910003fd     	mov	x29, sp
  53868c: f9000bf3     	str	x19, [sp, #0x10]
  538690: f90017e0     	str	x0, [sp, #0x28]
  538694: f94017e0     	ldr	x0, [sp, #0x28]
  538698: f9405800     	ldr	x0, [x0, #0xb0]
  53869c: 97fea4e4     	bl	0x4e1a2c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaba80>
  5386a0: f9401001     	ldr	x1, [x0, #0x20]
  5386a4: d284c800     	mov	x0, #0x2640             // =9792
  5386a8: 8b000020     	add	x0, x1, x0
  5386ac: 97fb711f     	bl	0x414b28 <.text+0x98f8>
  5386b0: b9004fe0     	str	w0, [sp, #0x4c]
  5386b4: b9404fe0     	ldr	w0, [sp, #0x4c]
  5386b8: 7100001f     	cmp	w0, #0x0
  5386bc: 54000101     	b.ne	0x5386dc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3f62c>
  5386c0: d0003340     	adrp	x0, 0xba2000
  5386c4: 91136002     	add	x2, x0, #0x4d8
  5386c8: 52805e21     	mov	w1, #0x2f1              // =753
  5386cc: d0003340     	adrp	x0, 0xba2000
  5386d0: 910d4000     	add	x0, x0, #0x350
  5386d4: 94083772     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  5386d8: 1400005c     	b	0x538848 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3f798>
  5386dc: b9404fe0     	ldr	w0, [sp, #0x4c]
  5386e0: 1e230000     	ucvtf	s0, w0
  5386e4: 52a88f40     	mov	w0, #0x447a0000         // =1148846080
  5386e8: 1e270001     	fmov	s1, w0
  5386ec: 1e211800     	fdiv	s0, s0, s1
  5386f0: bd004be0     	str	s0, [sp, #0x48]
  5386f4: bd404be0     	ldr	s0, [sp, #0x48]
  5386f8: 94078c43     	bl	0x71b804 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x1ad8>
  5386fc: b9003fe0     	str	w0, [sp, #0x3c]
  538700: b9403fe0     	ldr	w0, [sp, #0x3c]
  538704: 94078b8d     	bl	0x71b538 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x180c>
  538708: bd0047e0     	str	s0, [sp, #0x44]
  53870c: bd4047e1     	ldr	s1, [sp, #0x44]
  538710: bd404be0     	ldr	s0, [sp, #0x48]
  538714: 1e202030     	fcmpe	s1, s0
  538718: 54000149     	b.ls	0x538740 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3f690>
  53871c: b9403fe0     	ldr	w0, [sp, #0x3c]
  538720: 11000800     	add	w0, w0, #0x2
  538724: b9003fe0     	str	w0, [sp, #0x3c]
  538728: b9404fe0     	ldr	w0, [sp, #0x4c]
  53872c: 1e230000     	ucvtf	s0, w0
  538730: bd4047e1     	ldr	s1, [sp, #0x44]
  538734: 1e202030     	fcmpe	s1, s0
  538738: 5400006d     	b.le	0x538744 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3f694>
  53873c: 17fffff1     	b	0x538700 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x3f650>
  538740: d503201f     	nop
  538744: b9403fe1     	ldr	w1, [sp, #0x3c]
  538748: f94017e0     	ldr	x0, [sp, #0x28]
  53874c: b9041801     	str	w1, [x0, #0x418]
  538750: f94017e0     	ldr	x0, [sp, #0x28]
  538754: b9440801     	ldr	w1, [x0, #0x408]
  538758: f94017e0     	ldr	x0, [sp, #0x28]
  53875c: b9041c01     	str	w1, [x0, #0x41c]
  538760: f94017e0     	ldr	x0, [sp, #0x28]
  538764: 52800021     	mov	w1, #0x1                // =1
  538768: 39104001     	strb	w1, [x0, #0x410]
  53876c: f94017e0     	ldr	x0, [sp, #0x28]
  538770: f941ec04     	ldr	x4, [x0, #0x3d8]
  538774: f94017e0     	ldr	x0, [sp, #0x28]
  538778: f941ec00     	ldr	x0, [x0, #0x3d8]
  53877c: f9400000     	ldr	x0, [x0]
  538780: 9103c000     	add	x0, x0, #0xf0
  538784: f9400003     	ldr	x3, [x0]
  538788: f94017e0     	ldr	x0, [sp, #0x28]
  53878c: b9441801     	ldr	w1, [x0, #0x418]
  538790: f94017e0     	ldr	x0, [sp, #0x28]
  538794: b9441c00     	ldr	w0, [x0, #0x41c]
  538798: 2a0003e2     	mov	w2, w0
  53879c: aa0403e0     	mov	x0, x4
  5387a0: d63f0060     	blr	x3
  5387a4: f94017e0     	ldr	x0, [sp, #0x28]
  5387a8: 91105002     	add	x2, x0, #0x414
  5387ac: f94017e0     	ldr	x0, [sp, #0x28]
  5387b0: 91102000     	add	x0, x0, #0x408
  5387b4: aa0003e1     	mov	x1, x0
  5387b8: aa0203e0     	mov	x0, x2
  5387bc: 97fc9e49     	bl	0x4600e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2a134>
  5387c0: aa0003e1     	mov	x1, x0
  5387c4: 9100f3e0     	add	x0, sp, #0x3c
  5387c8: 97fd170c     	bl	0x47e3f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x4844c>
  5387cc: b9400000     	ldr	w0, [x0]
  5387d0: b90043e0     	str	w0, [sp, #0x40]
  5387d4: f94017e0     	ldr	x0, [sp, #0x28]
  5387d8: f941ec02     	ldr	x2, [x0, #0x3d8]
  5387dc: f94017e0     	ldr	x0, [sp, #0x28]
  5387e0: f941ec00     	ldr	x0, [x0, #0x3d8]
  5387e4: f9400000     	ldr	x0, [x0]
  5387e8: 91046000     	add	x0, x0, #0x118
  5387ec: f9400001     	ldr	x1, [x0]
  5387f0: aa0203e0     	mov	x0, x2
  5387f4: d63f0020     	blr	x1
  5387f8: aa0003e3     	mov	x3, x0
  5387fc: f9400060     	ldr	x0, [x3]
  538800: 91012000     	add	x0, x0, #0x48
  538804: f9400002     	ldr	x2, [x0]
  538808: b94043e1     	ldr	w1, [sp, #0x40]
  53880c: aa0303e0     	mov	x0, x3
  538810: d63f0040     	blr	x2
  538814: f94017e0     	ldr	x0, [sp, #0x28]
  538818: f9405800     	ldr	x0, [x0, #0xb0]
  53881c: 97fea484     	bl	0x4e1a2c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0xaba80>
  538820: f9401800     	ldr	x0, [x0, #0x30]
  538824: 9129c013     	add	x19, x0, #0xa70
  538828: f94017e0     	ldr	x0, [sp, #0x28]
  53882c: 91103001     	add	x1, x0, #0x40c
  538830: 9100f3e0     	add	x0, sp, #0x3c
  538834: 97fd16f1     	bl	0x47e3f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x4844c>
  538838: b9400000     	ldr	w0, [x0]
  53883c: 2a0003e1     	mov	w1, w0
  538840: aa1303e0     	mov	x0, x19
  538844: 97fb501c     	bl	0x40c8b4 <.text+0x1684>
  538848: f9400bf3     	ldr	x19, [sp, #0x10]
  53884c: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  538850: d65f03c0     	ret
