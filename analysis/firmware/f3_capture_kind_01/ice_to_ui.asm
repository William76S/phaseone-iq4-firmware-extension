
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7b8410: d11843ff     	sub	sp, sp, #0x610
  7b8414: a9017bfd     	stp	x29, x30, [sp, #0x10]
  7b8418: 910043fd     	add	x29, sp, #0x10
  7b841c: a90253f3     	stp	x19, x20, [sp, #0x20]
  7b8420: a9035bf5     	stp	x21, x22, [sp, #0x30]
  7b8424: f90023f7     	str	x23, [sp, #0x40]
  7b8428: f9008fe0     	str	x0, [sp, #0x118]
  7b842c: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8430: f940d400     	ldr	x0, [x0, #0x1a8]
  7b8434: 91026000     	add	x0, x0, #0x98
  7b8438: 97f373bb     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  7b843c: f90307e0     	str	x0, [sp, #0x608]
  7b8440: f94307e0     	ldr	x0, [sp, #0x608]
  7b8444: f100001f     	cmp	x0, #0x0
  7b8448: 54009120     	b.eq	0x7b966c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f940>
  7b844c: f94307e0     	ldr	x0, [sp, #0x608]
  7b8450: f9400400     	ldr	x0, [x0, #0x8]
  7b8454: f902fbe0     	str	x0, [sp, #0x5f0]
  7b8458: 911543e0     	add	x0, sp, #0x550
  7b845c: f942fbe1     	ldr	x1, [sp, #0x5f0]
  7b8460: 97f37369     	bl	0x495204 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f258>
  7b8464: 911543e0     	add	x0, sp, #0x550
  7b8468: 97f37394     	bl	0x4952b8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f30c>
  7b846c: 97f37310     	bl	0x4950ac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f100>
  7b8470: f902f7e0     	str	x0, [sp, #0x5e8]
  7b8474: b90607ff     	str	wzr, [sp, #0x604]
  7b8478: f9408fe0     	ldr	x0, [sp, #0x118]
  7b847c: f940ec01     	ldr	x1, [x0, #0x1d8]
  7b8480: d282cd00     	mov	x0, #0x1668             // =5736
  7b8484: 8b000020     	add	x0, x1, x0
  7b8488: 97f171a8     	bl	0x414b28 <.text+0x98f8>
  7b848c: 2a0003e1     	mov	w1, w0
  7b8490: b94607e0     	ldr	w0, [sp, #0x604]
  7b8494: 6b00003f     	cmp	w1, w0
  7b8498: 1a9f97e0     	cset	w0, hi
  7b849c: 12001c00     	and	w0, w0, #0xff
  7b84a0: 7100001f     	cmp	w0, #0x0
  7b84a4: 540087e0     	b.eq	0x7b95a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f874>
  7b84a8: f9408fe0     	ldr	x0, [sp, #0x118]
  7b84ac: f940ec01     	ldr	x1, [x0, #0x1d8]
  7b84b0: d282cd00     	mov	x0, #0x1668             // =5736
  7b84b4: 8b000020     	add	x0, x1, x0
  7b84b8: 97f1719c     	bl	0x414b28 <.text+0x98f8>
  7b84bc: 7100041f     	cmp	w0, #0x1
  7b84c0: 1a9f97e0     	cset	w0, hi
  7b84c4: 12001c00     	and	w0, w0, #0xff
  7b84c8: 7100001f     	cmp	w0, #0x0
  7b84cc: 54000200     	b.eq	0x7b850c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e7e0>
  7b84d0: b94607e0     	ldr	w0, [sp, #0x604]
  7b84d4: 11000413     	add	w19, w0, #0x1
  7b84d8: f9408fe0     	ldr	x0, [sp, #0x118]
  7b84dc: f940ec01     	ldr	x1, [x0, #0x1d8]
  7b84e0: d282cd00     	mov	x0, #0x1668             // =5736
  7b84e4: 8b000020     	add	x0, x1, x0
  7b84e8: 97f17190     	bl	0x414b28 <.text+0x98f8>
  7b84ec: 2a0003e4     	mov	w4, w0
  7b84f0: 2a1303e3     	mov	w3, w19
  7b84f4: b0002e60     	adrp	x0, 0xd85000
  7b84f8: 91002002     	add	x2, x0, #0x8
  7b84fc: 52808881     	mov	w1, #0x444              // =1092
  7b8500: 90002e60     	adrp	x0, 0xd84000
  7b8504: 91372000     	add	x0, x0, #0xdc8
  7b8508: 97fe37e5     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  7b850c: 52800022     	mov	w2, #0x1                // =1
  7b8510: b0002e60     	adrp	x0, 0xd85000
  7b8514: 91008001     	add	x1, x0, #0x20
  7b8518: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b851c: 912c4000     	add	x0, x0, #0xb10
  7b8520: 97fbefca     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8524: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8528: 3952e400     	ldrb	w0, [x0, #0x4b9]
  7b852c: 7100001f     	cmp	w0, #0x0
  7b8530: 54000121     	b.ne	0x7b8554 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e828>
  7b8534: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8538: b940d400     	ldr	w0, [x0, #0xd4]
  7b853c: 7100001f     	cmp	w0, #0x0
  7b8540: 540000a1     	b.ne	0x7b8554 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e828>
  7b8544: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8548: b940cc00     	ldr	w0, [x0, #0xcc]
  7b854c: 71000c1f     	cmp	w0, #0x3
  7b8550: 54001781     	b.ne	0x7b8840 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9eb14>
  7b8554: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8558: f940e400     	ldr	x0, [x0, #0x1c8]
  7b855c: 97f255e1     	bl	0x44dce0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x17d34>
  7b8560: 12001c00     	and	w0, w0, #0xff
  7b8564: 7100001f     	cmp	w0, #0x0
  7b8568: 540001a0     	b.eq	0x7b859c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e870>
  7b856c: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8570: 1e2e1000     	fmov	s0, #1.00000000
  7b8574: bd027000     	str	s0, [x0, #0x270]
  7b8578: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b857c: b9427001     	ldr	w1, [x0, #0x270]
  7b8580: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8584: b9026c01     	str	w1, [x0, #0x26c]
  7b8588: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b858c: b9426c01     	ldr	w1, [x0, #0x26c]
  7b8590: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8594: b9026801     	str	w1, [x0, #0x268]
  7b8598: 140000bf     	b	0x7b8894 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9eb68>
  7b859c: 52800100     	mov	w0, #0x8                // =8
  7b85a0: b905e7e0     	str	w0, [sp, #0x5e4]
  7b85a4: 911403e0     	add	x0, sp, #0x500
  7b85a8: f942fbe1     	ldr	x1, [sp, #0x5f0]
  7b85ac: 94000c8f     	bl	0x7bb7e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1abc>
  7b85b0: 52800022     	mov	w2, #0x1                // =1
  7b85b4: b0002e60     	adrp	x0, 0xd85000
  7b85b8: 9100c001     	add	x1, x0, #0x30
  7b85bc: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b85c0: 912c4000     	add	x0, x0, #0xb10
  7b85c4: 97fbefa1     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b85c8: 911403e0     	add	x0, sp, #0x500
  7b85cc: d2800001     	mov	x1, #0x0                // =0
  7b85d0: 94000cb3     	bl	0x7bb89c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1b70>
  7b85d4: 12001c00     	and	w0, w0, #0xff
  7b85d8: 7100001f     	cmp	w0, #0x0
  7b85dc: 54000120     	b.eq	0x7b8600 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e8d4>
  7b85e0: b0002e60     	adrp	x0, 0xd85000
  7b85e4: 91012003     	add	x3, x0, #0x48
  7b85e8: 52808c22     	mov	w2, #0x461              // =1121
  7b85ec: 90002e60     	adrp	x0, 0xd84000
  7b85f0: 91372001     	add	x1, x0, #0xdc8
  7b85f4: 52800040     	mov	w0, #0x2                // =2
  7b85f8: 97fe37d5     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b85fc: 1400002d     	b	0x7b86b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e984>
  7b8600: 911403e0     	add	x0, sp, #0x500
  7b8604: 94000cb1     	bl	0x7bb8c8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1b9c>
  7b8608: 9101a000     	add	x0, x0, #0x68
  7b860c: f902efe0     	str	x0, [sp, #0x5d8]
  7b8610: f942efe0     	ldr	x0, [sp, #0x5d8]
  7b8614: f9400003     	ldr	x3, [x0]
  7b8618: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b861c: 9112f000     	add	x0, x0, #0x4bc
  7b8620: d2810002     	mov	x2, #0x800              // =2048
  7b8624: aa0003e1     	mov	x1, x0
  7b8628: aa0303e0     	mov	x0, x3
  7b862c: 97f147c1     	bl	0x40a530 <memcpy@plt>
  7b8630: f942efe0     	ldr	x0, [sp, #0x5d8]
  7b8634: f9400403     	ldr	x3, [x0, #0x8]
  7b8638: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b863c: 9132f000     	add	x0, x0, #0xcbc
  7b8640: d2810002     	mov	x2, #0x800              // =2048
  7b8644: aa0003e1     	mov	x1, x0
  7b8648: aa0303e0     	mov	x0, x3
  7b864c: 97f147b9     	bl	0x40a530 <memcpy@plt>
  7b8650: f942efe0     	ldr	x0, [sp, #0x5d8]
  7b8654: f9400c03     	ldr	x3, [x0, #0x18]
  7b8658: f942f7e1     	ldr	x1, [sp, #0x5e8]
  7b865c: d2829780     	mov	x0, #0x14bc             // =5308
  7b8660: 8b000020     	add	x0, x1, x0
  7b8664: d2810002     	mov	x2, #0x800              // =2048
  7b8668: aa0003e1     	mov	x1, x0
  7b866c: aa0303e0     	mov	x0, x3
  7b8670: 97f147b0     	bl	0x40a530 <memcpy@plt>
  7b8674: f942efe0     	ldr	x0, [sp, #0x5d8]
  7b8678: f9400803     	ldr	x3, [x0, #0x10]
  7b867c: f942f7e1     	ldr	x1, [sp, #0x5e8]
  7b8680: d2839780     	mov	x0, #0x1cbc             // =7356
  7b8684: 8b000020     	add	x0, x1, x0
  7b8688: d2810002     	mov	x2, #0x800              // =2048
  7b868c: aa0003e1     	mov	x1, x0
  7b8690: aa0303e0     	mov	x0, x3
  7b8694: 97f147a7     	bl	0x40a530 <memcpy@plt>
  7b8698: f942efe0     	ldr	x0, [sp, #0x5d8]
  7b869c: 52803f01     	mov	w1, #0x1f8              // =504
  7b86a0: b9006001     	str	w1, [x0, #0x60]
  7b86a4: f942efe0     	ldr	x0, [sp, #0x5d8]
  7b86a8: 52800021     	mov	w1, #0x1                // =1
  7b86ac: 39017001     	strb	w1, [x0, #0x5c]
  7b86b0: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b86b4: b940cc00     	ldr	w0, [x0, #0xcc]
  7b86b8: 71000c1f     	cmp	w0, #0x3
  7b86bc: 54000161     	b.ne	0x7b86e8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e9bc>
  7b86c0: b0002e60     	adrp	x0, 0xd85000
  7b86c4: 91018003     	add	x3, x0, #0x60
  7b86c8: 52808ea2     	mov	w2, #0x475              // =1141
  7b86cc: 90002e60     	adrp	x0, 0xd84000
  7b86d0: 91372001     	add	x1, x0, #0xdc8
  7b86d4: 52800080     	mov	w0, #0x4                // =4
  7b86d8: 97fe379d     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b86dc: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b86e0: 52800021     	mov	w1, #0x1                // =1
  7b86e4: b900d401     	str	w1, [x0, #0xd4]
  7b86e8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b86ec: 9112f000     	add	x0, x0, #0x4bc
  7b86f0: d2810002     	mov	x2, #0x800              // =2048
  7b86f4: aa0003e1     	mov	x1, x0
  7b86f8: d001cfa0     	adrp	x0, 0x41ae000 <_ZNSt5ctypeIcE2idE+0x324aed8>
  7b86fc: 9110a000     	add	x0, x0, #0x428
  7b8700: 97f1478c     	bl	0x40a530 <memcpy@plt>
  7b8704: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8708: 9132f000     	add	x0, x0, #0xcbc
  7b870c: d2810002     	mov	x2, #0x800              // =2048
  7b8710: aa0003e1     	mov	x1, x0
  7b8714: d001cfa0     	adrp	x0, 0x41ae000 <_ZNSt5ctypeIcE2idE+0x324aed8>
  7b8718: 9130a000     	add	x0, x0, #0xc28
  7b871c: 97f14785     	bl	0x40a530 <memcpy@plt>
  7b8720: f942f7e1     	ldr	x1, [sp, #0x5e8]
  7b8724: d2829780     	mov	x0, #0x14bc             // =5308
  7b8728: 8b000020     	add	x0, x1, x0
  7b872c: d2810002     	mov	x2, #0x800              // =2048
  7b8730: aa0003e1     	mov	x1, x0
  7b8734: f001cfa0     	adrp	x0, 0x41af000 <_ZNSt5ctypeIcE2idE+0x324bed8>
  7b8738: 9110a000     	add	x0, x0, #0x428
  7b873c: 97f1477d     	bl	0x40a530 <memcpy@plt>
  7b8740: f942f7e1     	ldr	x1, [sp, #0x5e8]
  7b8744: d2839780     	mov	x0, #0x1cbc             // =7356
  7b8748: 8b000020     	add	x0, x1, x0
  7b874c: d2810002     	mov	x2, #0x800              // =2048
  7b8750: aa0003e1     	mov	x1, x0
  7b8754: f001cfa0     	adrp	x0, 0x41af000 <_ZNSt5ctypeIcE2idE+0x324bed8>
  7b8758: 9130a000     	add	x0, x0, #0xc28
  7b875c: 97f14775     	bl	0x40a530 <memcpy@plt>
  7b8760: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8764: f940d815     	ldr	x21, [x0, #0x1b0]
  7b8768: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b876c: b940d416     	ldr	w22, [x0, #0xd4]
  7b8770: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8774: 9109a017     	add	x23, x0, #0x268
  7b8778: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b877c: b940c013     	ldr	w19, [x0, #0xc0]
  7b8780: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8784: bd40e400     	ldr	s0, [x0, #0xe4]
  7b8788: 97fd869b     	bl	0x71a1f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x4c8>
  7b878c: 1e204001     	fmov	s1, s0
  7b8790: 52a88f40     	mov	w0, #0x447a0000         // =1148846080
  7b8794: 1e270000     	fmov	s0, w0
  7b8798: 1e200820     	fmul	s0, s1, s0
  7b879c: 1e390014     	fcvtzu	w20, s0
  7b87a0: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b87a4: bd40e800     	ldr	s0, [x0, #0xe8]
  7b87a8: 97fd870d     	bl	0x71a3dc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6b0>
  7b87ac: b9000bf4     	str	w20, [sp, #0x8]
  7b87b0: b90003f3     	str	w19, [sp]
  7b87b4: 52803f07     	mov	w7, #0x1f8              // =504
  7b87b8: f001cfa0     	adrp	x0, 0x41af000 <_ZNSt5ctypeIcE2idE+0x324bed8>
  7b87bc: 9110a006     	add	x6, x0, #0x428
  7b87c0: f001cfa0     	adrp	x0, 0x41af000 <_ZNSt5ctypeIcE2idE+0x324bed8>
  7b87c4: 9130a005     	add	x5, x0, #0xc28
  7b87c8: d001cfa0     	adrp	x0, 0x41ae000 <_ZNSt5ctypeIcE2idE+0x324aed8>
  7b87cc: 9130a004     	add	x4, x0, #0xc28
  7b87d0: d001cfa0     	adrp	x0, 0x41ae000 <_ZNSt5ctypeIcE2idE+0x324aed8>
  7b87d4: 9110a003     	add	x3, x0, #0x428
  7b87d8: aa1703e2     	mov	x2, x23
  7b87dc: 2a1603e1     	mov	w1, w22
  7b87e0: aa1503e0     	mov	x0, x21
  7b87e4: 9400b0d8     	bl	0x7e4b44 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x28b7c>
  7b87e8: f9408fe0     	ldr	x0, [sp, #0x118]
  7b87ec: f940d805     	ldr	x5, [x0, #0x1b0]
  7b87f0: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b87f4: b940d401     	ldr	w1, [x0, #0xd4]
  7b87f8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b87fc: 9109a002     	add	x2, x0, #0x268
  7b8800: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8804: b9417c03     	ldr	w3, [x0, #0x17c]
  7b8808: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b880c: b941a400     	ldr	w0, [x0, #0x1a4]
  7b8810: 2a0003e4     	mov	w4, w0
  7b8814: aa0503e0     	mov	x0, x5
  7b8818: 9400bbff     	bl	0x7e7814 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x2b84c>
  7b881c: 52800002     	mov	w2, #0x0                // =0
  7b8820: b0002e60     	adrp	x0, 0xd85000
  7b8824: 9100c001     	add	x1, x0, #0x30
  7b8828: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b882c: 912c4000     	add	x0, x0, #0xb10
  7b8830: 97fbef06     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8834: 911403e0     	add	x0, sp, #0x500
  7b8838: 94000c05     	bl	0x7bb84c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1b20>
  7b883c: 14000016     	b	0x7b8894 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9eb68>
  7b8840: b0002e60     	adrp	x0, 0xd85000
  7b8844: 91020003     	add	x3, x0, #0x80
  7b8848: 528091c2     	mov	w2, #0x48e              // =1166
  7b884c: 90002e60     	adrp	x0, 0xd84000
  7b8850: 91372001     	add	x1, x0, #0xdc8
  7b8854: 52800080     	mov	w0, #0x4                // =4
  7b8858: 97fe373d     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b885c: b0002e60     	adrp	x0, 0xd85000
  7b8860: 9102c003     	add	x3, x0, #0xb0
  7b8864: 528091e2     	mov	w2, #0x48f              // =1167
  7b8868: 90002e60     	adrp	x0, 0xd84000
  7b886c: 91372001     	add	x1, x0, #0xdc8
  7b8870: 52800080     	mov	w0, #0x4                // =4
  7b8874: 97fe3736     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b8878: b0002e60     	adrp	x0, 0xd85000
  7b887c: 91020003     	add	x3, x0, #0x80
  7b8880: 52809202     	mov	w2, #0x490              // =1168
  7b8884: 90002e60     	adrp	x0, 0xd84000
  7b8888: 91372001     	add	x1, x0, #0xdc8
  7b888c: 52800080     	mov	w0, #0x4                // =4
  7b8890: 97fe372f     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b8894: 911503e0     	add	x0, sp, #0x540
  7b8898: f942fbe1     	ldr	x1, [sp, #0x5f0]
  7b889c: 97f37213     	bl	0x4950e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f13c>
  7b88a0: 911503e0     	add	x0, sp, #0x540
  7b88a4: 97f37252     	bl	0x4951ec <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f240>
  7b88a8: 97f371fb     	bl	0x495094 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f0e8>
  7b88ac: f902ebe0     	str	x0, [sp, #0x5d0]
  7b88b0: 9114c3e0     	add	x0, sp, #0x530
  7b88b4: f942fbe1     	ldr	x1, [sp, #0x5f0]
  7b88b8: 97f3547e     	bl	0x48dab0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57b04>
  7b88bc: 9114c3e0     	add	x0, sp, #0x530
  7b88c0: 97f354c5     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b88c4: 3900201f     	strb	wzr, [x0, #0x8]
  7b88c8: 52800022     	mov	w2, #0x1                // =1
  7b88cc: b0002e60     	adrp	x0, 0xd85000
  7b88d0: 91038001     	add	x1, x0, #0xe0
  7b88d4: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b88d8: 912c4000     	add	x0, x0, #0xb10
  7b88dc: 97fbeedb     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b88e0: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b88e4: f9400001     	ldr	x1, [x0]
  7b88e8: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b88ec: 9140b000     	add	x0, x0, #0x2c, lsl #12  // =0x2c000
  7b88f0: b9588802     	ldr	w2, [x0, #0x1888]
  7b88f4: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b88f8: 91004003     	add	x3, x0, #0x10
  7b88fc: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8900: b9405804     	ldr	w4, [x0, #0x58]
  7b8904: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8908: b9405c00     	ldr	w0, [x0, #0x5c]
  7b890c: 2a0003e6     	mov	w6, w0
  7b8910: 2a0403e5     	mov	w5, w4
  7b8914: aa0303e4     	mov	x4, x3
  7b8918: 2a0203e3     	mov	w3, w2
  7b891c: aa0103e2     	mov	x2, x1
  7b8920: f942f7e1     	ldr	x1, [sp, #0x5e8]
  7b8924: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8928: 97fff51e     	bl	0x7b5da0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9c074>
  7b892c: 12001c00     	and	w0, w0, #0xff
  7b8930: 52000000     	eor	w0, w0, #0x1
  7b8934: 12001c00     	and	w0, w0, #0xff
  7b8938: 7100001f     	cmp	w0, #0x0
  7b893c: 54000100     	b.eq	0x7b895c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9ec30>
  7b8940: b0002e60     	adrp	x0, 0xd85000
  7b8944: 9103e003     	add	x3, x0, #0xf8
  7b8948: 528094a2     	mov	w2, #0x4a5              // =1189
  7b894c: 90002e60     	adrp	x0, 0xd84000
  7b8950: 91372001     	add	x1, x0, #0xdc8
  7b8954: 52800080     	mov	w0, #0x4                // =4
  7b8958: 97fe36fd     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b895c: 52800002     	mov	w2, #0x0                // =0
  7b8960: b0002e60     	adrp	x0, 0xd85000
  7b8964: 91038001     	add	x1, x0, #0xe0
  7b8968: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b896c: 912c4000     	add	x0, x0, #0xb10
  7b8970: 97fbeeb6     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8974: 52800022     	mov	w2, #0x1                // =1
  7b8978: b0002e60     	adrp	x0, 0xd85000
  7b897c: 91046001     	add	x1, x0, #0x118
  7b8980: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8984: 912c4000     	add	x0, x0, #0xb10
  7b8988: 97fbeeb0     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b898c: f942ebe1     	ldr	x1, [sp, #0x5d0]
  7b8990: d2860d00     	mov	x0, #0x3068             // =12392
  7b8994: f2a00040     	movk	x0, #0x2, lsl #16
  7b8998: 8b000023     	add	x3, x1, x0
  7b899c: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b89a0: b9405c01     	ldr	w1, [x0, #0x5c]
  7b89a4: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b89a8: bd410400     	ldr	s0, [x0, #0x104]
  7b89ac: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b89b0: b9445800     	ldr	w0, [x0, #0x458]
  7b89b4: 2a0003e2     	mov	w2, w0
  7b89b8: aa0303e0     	mov	x0, x3
  7b89bc: 9400bbf2     	bl	0x7e7984 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x2b9bc>
  7b89c0: 52800002     	mov	w2, #0x0                // =0
  7b89c4: b0002e60     	adrp	x0, 0xd85000
  7b89c8: 91046001     	add	x1, x0, #0x118
  7b89cc: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b89d0: 912c4000     	add	x0, x0, #0xb10
  7b89d4: 97fbee9d     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b89d8: 52800022     	mov	w2, #0x1                // =1
  7b89dc: b0002e60     	adrp	x0, 0xd85000
  7b89e0: 9104c001     	add	x1, x0, #0x130
  7b89e4: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b89e8: 912c4000     	add	x0, x0, #0xb10
  7b89ec: 97fbee97     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b89f0: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b89f4: f9400013     	ldr	x19, [x0]
  7b89f8: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b89fc: 91004000     	add	x0, x0, #0x10
  7b8a00: d2800001     	mov	x1, #0x0                // =0
  7b8a04: 97fb9db2     	bl	0x6a00cc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x1a701c>
  7b8a08: aa0003e1     	mov	x1, x0
  7b8a0c: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b8a10: 9100a000     	add	x0, x0, #0x28
  7b8a14: f942f7e4     	ldr	x4, [sp, #0x5e8]
  7b8a18: aa0003e3     	mov	x3, x0
  7b8a1c: aa0103e2     	mov	x2, x1
  7b8a20: aa1303e1     	mov	x1, x19
  7b8a24: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8a28: 97fff591     	bl	0x7b606c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9c340>
  7b8a2c: 52800002     	mov	w2, #0x0                // =0
  7b8a30: b0002e60     	adrp	x0, 0xd85000
  7b8a34: 9104c001     	add	x1, x0, #0x130
  7b8a38: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8a3c: 912c4000     	add	x0, x0, #0xb10
  7b8a40: 97fbee82     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8a44: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8a48: b944b400     	ldr	w0, [x0, #0x4b4]
  7b8a4c: 7100001f     	cmp	w0, #0x0
  7b8a50: 54000501     	b.ne	0x7b8af0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9edc4>
  7b8a54: 52800022     	mov	w2, #0x1                // =1
  7b8a58: b0002e60     	adrp	x0, 0xd85000
  7b8a5c: 91052001     	add	x1, x0, #0x148
  7b8a60: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8a64: 912c4000     	add	x0, x0, #0xb10
  7b8a68: 97fbee78     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8a6c: 9114c3e0     	add	x0, sp, #0x530
  7b8a70: d2800001     	mov	x1, #0x0                // =0
  7b8a74: 97f3544d     	bl	0x48dba8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57bfc>
  7b8a78: 12001c00     	and	w0, w0, #0xff
  7b8a7c: 7100001f     	cmp	w0, #0x0
  7b8a80: 540002a0     	b.eq	0x7b8ad4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9eda8>
  7b8a84: 9114c3e0     	add	x0, sp, #0x530
  7b8a88: 97f35453     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8a8c: 91008000     	add	x0, x0, #0x20
  7b8a90: 52800005     	mov	w5, #0x0                // =0
  7b8a94: d2800004     	mov	x4, #0x0                // =0
  7b8a98: 52800083     	mov	w3, #0x4                // =4
  7b8a9c: 52800082     	mov	w2, #0x4                // =4
  7b8aa0: 52800001     	mov	w1, #0x0                // =0
  7b8aa4: 97f29cfa     	bl	0x45fe8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x29ee0>
  7b8aa8: 9114c3e0     	add	x0, sp, #0x530
  7b8aac: 97f3544a     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8ab0: f9401800     	ldr	x0, [x0, #0x30]
  7b8ab4: d2800602     	mov	x2, #0x30               // =48
  7b8ab8: 52800001     	mov	w1, #0x0                // =0
  7b8abc: 97f145b9     	bl	0x40a1a0 <memset@plt>
  7b8ac0: 9114c3e0     	add	x0, sp, #0x530
  7b8ac4: 97f35444     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8ac8: aa0003e1     	mov	x1, x0
  7b8acc: 52800020     	mov	w0, #0x1                // =1
  7b8ad0: 39002020     	strb	w0, [x1, #0x8]
  7b8ad4: 52800002     	mov	w2, #0x0                // =0
  7b8ad8: b0002e60     	adrp	x0, 0xd85000
  7b8adc: 91052001     	add	x1, x0, #0x148
  7b8ae0: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8ae4: 912c4000     	add	x0, x0, #0xb10
  7b8ae8: 97fbee58     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8aec: 140001ce     	b	0x7b9224 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f4f8>
  7b8af0: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8af4: b944b400     	ldr	w0, [x0, #0x4b4]
  7b8af8: 7100081f     	cmp	w0, #0x2
  7b8afc: 54002f21     	b.ne	0x7b90e0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f3b4>
  7b8b00: 52800022     	mov	w2, #0x1                // =1
  7b8b04: b0002e60     	adrp	x0, 0xd85000
  7b8b08: 91058001     	add	x1, x0, #0x160
  7b8b0c: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8b10: 912c4000     	add	x0, x0, #0xb10
  7b8b14: 97fbee4d     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8b18: 52800022     	mov	w2, #0x1                // =1
  7b8b1c: b0002e60     	adrp	x0, 0xd85000
  7b8b20: 9105e001     	add	x1, x0, #0x178
  7b8b24: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8b28: 912c4000     	add	x0, x0, #0xb10
  7b8b2c: 97fbee47     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8b30: 910603e0     	add	x0, sp, #0x180
  7b8b34: 94052e87     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  7b8b38: 910763e0     	add	x0, sp, #0x1d8
  7b8b3c: 94052e85     	bl	0x904550 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dd24>
  7b8b40: 910483e0     	add	x0, sp, #0x120
  7b8b44: 94000bb2     	bl	0x7bba0c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1ce0>
  7b8b48: 910483e0     	add	x0, sp, #0x120
  7b8b4c: f942f7e3     	ldr	x3, [sp, #0x5e8]
  7b8b50: f942ebe2     	ldr	x2, [sp, #0x5d0]
  7b8b54: aa0003e1     	mov	x1, x0
  7b8b58: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8b5c: 940007e0     	bl	0x7baadc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa0db0>
  7b8b60: 52800002     	mov	w2, #0x0                // =0
  7b8b64: b0002e60     	adrp	x0, 0xd85000
  7b8b68: 9105e001     	add	x1, x0, #0x178
  7b8b6c: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8b70: 912c4000     	add	x0, x0, #0xb10
  7b8b74: 97fbee35     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8b78: 52800022     	mov	w2, #0x1                // =1
  7b8b7c: b0002e60     	adrp	x0, 0xd85000
  7b8b80: 91062001     	add	x1, x0, #0x188
  7b8b84: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8b88: 912c4000     	add	x0, x0, #0xb10
  7b8b8c: 97fbee2f     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8b90: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8b94: b940b000     	ldr	w0, [x0, #0xb0]
  7b8b98: b905cfe0     	str	w0, [sp, #0x5cc]
  7b8b9c: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8ba0: b940b400     	ldr	w0, [x0, #0xb4]
  7b8ba4: b905cbe0     	str	w0, [sp, #0x5c8]
  7b8ba8: 9108c3e0     	add	x0, sp, #0x230
  7b8bac: 94000c2a     	bl	0x7bbc54 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1f28>
  7b8bb0: f9408fe1     	ldr	x1, [sp, #0x118]
  7b8bb4: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8bb8: 8b000020     	add	x0, x1, x0
  7b8bbc: f97c8c00     	ldr	x0, [x0, #0x7918]
  7b8bc0: 9121c000     	add	x0, x0, #0x870
  7b8bc4: 97f16fd9     	bl	0x414b28 <.text+0x98f8>
  7b8bc8: b905c7e0     	str	w0, [sp, #0x5c4]
  7b8bcc: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8bd0: 910b6003     	add	x3, x0, #0x2d8
  7b8bd4: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8bd8: b940b800     	ldr	w0, [x0, #0xb8]
  7b8bdc: 910483e1     	add	x1, sp, #0x120
  7b8be0: aa0103e2     	mov	x2, x1
  7b8be4: 2a0003e1     	mov	w1, w0
  7b8be8: aa0303e0     	mov	x0, x3
  7b8bec: 94069e23     	bl	0x960478 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5be18>
  7b8bf0: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8bf4: 910b6000     	add	x0, x0, #0x2d8
  7b8bf8: 9108c3e1     	add	x1, sp, #0x230
  7b8bfc: b945c7e2     	ldr	w2, [sp, #0x5c4]
  7b8c00: 9406a182     	bl	0x961208 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5cba8>
  7b8c04: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8c08: 910b6000     	add	x0, x0, #0x2d8
  7b8c0c: 911583e1     	add	x1, sp, #0x560
  7b8c10: aa0103e8     	mov	x8, x1
  7b8c14: b945c7e1     	ldr	w1, [sp, #0x5c4]
  7b8c18: 9406a008     	bl	0x960c38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5c5d8>
  7b8c1c: f942ebe1     	ldr	x1, [sp, #0x5d0]
  7b8c20: d29b1200     	mov	x0, #0xd890             // =55440
  7b8c24: f2a00040     	movk	x0, #0x2, lsl #16
  7b8c28: 8b000020     	add	x0, x1, x0
  7b8c2c: 911583e1     	add	x1, sp, #0x560
  7b8c30: 97fcbaa5     	bl	0x6e76c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEaSEOS4_>
  7b8c34: 911583e0     	add	x0, sp, #0x560
  7b8c38: 97f1e2ba     	bl	0x431720 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED2Ev>
  7b8c3c: b90253ff     	str	wzr, [sp, #0x250]
  7b8c40: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8c44: b9406800     	ldr	w0, [x0, #0x68]
  7b8c48: 1e230000     	ucvtf	s0, w0
  7b8c4c: bd0237e0     	str	s0, [sp, #0x234]
  7b8c50: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8c54: b9406c00     	ldr	w0, [x0, #0x6c]
  7b8c58: 1e230000     	ucvtf	s0, w0
  7b8c5c: bd023be0     	str	s0, [sp, #0x238]
  7b8c60: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8c64: b9401800     	ldr	w0, [x0, #0x18]
  7b8c68: 1e230000     	ucvtf	s0, w0
  7b8c6c: bd023fe0     	str	s0, [sp, #0x23c]
  7b8c70: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8c74: b9401800     	ldr	w0, [x0, #0x18]
  7b8c78: 7101681f     	cmp	w0, #0x5a
  7b8c7c: 540000a0     	b.eq	0x7b8c90 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9ef64>
  7b8c80: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8c84: b9401800     	ldr	w0, [x0, #0x18]
  7b8c88: 7104381f     	cmp	w0, #0x10e
  7b8c8c: 54000201     	b.ne	0x7b8ccc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9efa0>
  7b8c90: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8c94: b9406c01     	ldr	w1, [x0, #0x6c]
  7b8c98: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8c9c: b9406802     	ldr	w2, [x0, #0x68]
  7b8ca0: 911603e0     	add	x0, sp, #0x580
  7b8ca4: 2a0203e4     	mov	w4, w2
  7b8ca8: 2a0103e3     	mov	w3, w1
  7b8cac: 52800002     	mov	w2, #0x0                // =0
  7b8cb0: 52800001     	mov	w1, #0x0                // =0
  7b8cb4: 97f352ec     	bl	0x48d864 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x578b8>
  7b8cb8: 911803e0     	add	x0, sp, #0x600
  7b8cbc: a9780400     	ldp	x0, x1, [x0, #-0x80]
  7b8cc0: 910803e2     	add	x2, sp, #0x200
  7b8cc4: a9040440     	stp	x0, x1, [x2, #0x40]
  7b8cc8: 1400000f     	b	0x7b8d04 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9efd8>
  7b8ccc: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8cd0: b9406801     	ldr	w1, [x0, #0x68]
  7b8cd4: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8cd8: b9406c02     	ldr	w2, [x0, #0x6c]
  7b8cdc: 911643e0     	add	x0, sp, #0x590
  7b8ce0: 2a0203e4     	mov	w4, w2
  7b8ce4: 2a0103e3     	mov	w3, w1
  7b8ce8: 52800002     	mov	w2, #0x0                // =0
  7b8cec: 52800001     	mov	w1, #0x0                // =0
  7b8cf0: 97f352dd     	bl	0x48d864 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x578b8>
  7b8cf4: 911803e0     	add	x0, sp, #0x600
  7b8cf8: a9790400     	ldp	x0, x1, [x0, #-0x70]
  7b8cfc: 910803e2     	add	x2, sp, #0x200
  7b8d00: a9040440     	stp	x0, x1, [x2, #0x40]
  7b8d04: b945cbe0     	ldr	w0, [sp, #0x5c8]
  7b8d08: 1e230001     	ucvtf	s1, w0
  7b8d0c: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8d10: b9406c00     	ldr	w0, [x0, #0x6c]
  7b8d14: 1e230000     	ucvtf	s0, w0
  7b8d18: 1e201820     	fdiv	s0, s1, s0
  7b8d1c: bd05a7e0     	str	s0, [sp, #0x5a4]
  7b8d20: b945cfe0     	ldr	w0, [sp, #0x5cc]
  7b8d24: 1e230001     	ucvtf	s1, w0
  7b8d28: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8d2c: b9406800     	ldr	w0, [x0, #0x68]
  7b8d30: 1e230000     	ucvtf	s0, w0
  7b8d34: 1e201820     	fdiv	s0, s1, s0
  7b8d38: bd05abe0     	str	s0, [sp, #0x5a8]
  7b8d3c: 9116a3e1     	add	x1, sp, #0x5a8
  7b8d40: 911693e0     	add	x0, sp, #0x5a4
  7b8d44: 97f315c3     	bl	0x47e450 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x484a4>
  7b8d48: b9400000     	ldr	w0, [x0]
  7b8d4c: b90233e0     	str	w0, [sp, #0x230]
  7b8d50: f9408fe1     	ldr	x1, [sp, #0x118]
  7b8d54: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8d58: 8b000020     	add	x0, x1, x0
  7b8d5c: f97c9001     	ldr	x1, [x0, #0x7920]
  7b8d60: d2834000     	mov	x0, #0x1a00             // =6656
  7b8d64: 8b000020     	add	x0, x1, x0
  7b8d68: 97f27c15     	bl	0x457dbc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21e10>
  7b8d6c: 12001c00     	and	w0, w0, #0xff
  7b8d70: b90257e0     	str	w0, [sp, #0x254]
  7b8d74: f9408fe1     	ldr	x1, [sp, #0x118]
  7b8d78: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8d7c: 8b000020     	add	x0, x1, x0
  7b8d80: f97c9001     	ldr	x1, [x0, #0x7920]
  7b8d84: d2835b00     	mov	x0, #0x1ad8             // =6872
  7b8d88: 8b000020     	add	x0, x1, x0
  7b8d8c: 97f27c0c     	bl	0x457dbc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21e10>
  7b8d90: 12001c00     	and	w0, w0, #0xff
  7b8d94: b9025be0     	str	w0, [sp, #0x258]
  7b8d98: f9408fe1     	ldr	x1, [sp, #0x118]
  7b8d9c: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b8da0: 8b000020     	add	x0, x1, x0
  7b8da4: f97c9001     	ldr	x1, [x0, #0x7920]
  7b8da8: d2837600     	mov	x0, #0x1bb0             // =7088
  7b8dac: 8b000020     	add	x0, x1, x0
  7b8db0: 97f27c03     	bl	0x457dbc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x21e10>
  7b8db4: 12001c00     	and	w0, w0, #0xff
  7b8db8: b9025fe0     	str	w0, [sp, #0x25c]
  7b8dbc: b90263ff     	str	wzr, [sp, #0x260]
  7b8dc0: 910543e0     	add	x0, sp, #0x150
  7b8dc4: 94000b3f     	bl	0x7bbac0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1d94>
  7b8dc8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b8dcc: b940c400     	ldr	w0, [x0, #0xc4]
  7b8dd0: 2a0003e1     	mov	w1, w0
  7b8dd4: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8dd8: 97fff54f     	bl	0x7b6314 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9c5e8>
  7b8ddc: b90153e0     	str	w0, [sp, #0x150]
  7b8de0: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b8de4: 91004001     	add	x1, x0, #0x10
  7b8de8: 910543e0     	add	x0, sp, #0x150
  7b8dec: 91002000     	add	x0, x0, #0x8
  7b8df0: 94000e9f     	bl	0x7bc86c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x8a4>
  7b8df4: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b8df8: f9400000     	ldr	x0, [x0]
  7b8dfc: f900bbe0     	str	x0, [sp, #0x170]
  7b8e00: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b8e04: 9140b000     	add	x0, x0, #0x2c, lsl #12  // =0x2c000
  7b8e08: b9588800     	ldr	w0, [x0, #0x1888]
  7b8e0c: b9017be0     	str	w0, [sp, #0x178]
  7b8e10: 52800002     	mov	w2, #0x0                // =0
  7b8e14: b0002e60     	adrp	x0, 0xd85000
  7b8e18: 91062001     	add	x1, x0, #0x188
  7b8e1c: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8e20: 912c4000     	add	x0, x0, #0xb10
  7b8e24: 97fbed89     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8e28: 52800022     	mov	w2, #0x1                // =1
  7b8e2c: b0002e60     	adrp	x0, 0xd85000
  7b8e30: 91066001     	add	x1, x0, #0x198
  7b8e34: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8e38: 912c4000     	add	x0, x0, #0xb10
  7b8e3c: 97fbed83     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8e40: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8e44: 910b6007     	add	x7, x0, #0x2d8
  7b8e48: f9408fe0     	ldr	x0, [sp, #0x118]
  7b8e4c: 910b0004     	add	x4, x0, #0x2c0
  7b8e50: f9408fe1     	ldr	x1, [sp, #0x118]
  7b8e54: d28f1c00     	mov	x0, #0x78e0             // =30944
  7b8e58: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b8e5c: 8b000025     	add	x5, x1, x0
  7b8e60: 9108c3e3     	add	x3, sp, #0x230
  7b8e64: 910763e2     	add	x2, sp, #0x1d8
  7b8e68: 910603e1     	add	x1, sp, #0x180
  7b8e6c: 910543e0     	add	x0, sp, #0x150
  7b8e70: aa0503e6     	mov	x6, x5
  7b8e74: aa0403e5     	mov	x5, x4
  7b8e78: aa0303e4     	mov	x4, x3
  7b8e7c: aa0203e3     	mov	x3, x2
  7b8e80: aa0103e2     	mov	x2, x1
  7b8e84: aa0003e1     	mov	x1, x0
  7b8e88: aa0703e0     	mov	x0, x7
  7b8e8c: 9406aae7     	bl	0x963a28 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_replaceEmmPKcm+0x5f3c8>
  7b8e90: 52800002     	mov	w2, #0x0                // =0
  7b8e94: b0002e60     	adrp	x0, 0xd85000
  7b8e98: 91066001     	add	x1, x0, #0x198
  7b8e9c: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8ea0: 912c4000     	add	x0, x0, #0xb10
  7b8ea4: 97fbed69     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8ea8: 9114c3e0     	add	x0, sp, #0x530
  7b8eac: d2800001     	mov	x1, #0x0                // =0
  7b8eb0: 97f35333     	bl	0x48db7c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57bd0>
  7b8eb4: 12001c00     	and	w0, w0, #0xff
  7b8eb8: 7100001f     	cmp	w0, #0x0
  7b8ebc: 54000120     	b.eq	0x7b8ee0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f1b4>
  7b8ec0: b0002e60     	adrp	x0, 0xd85000
  7b8ec4: 9106a003     	add	x3, x0, #0x1a8
  7b8ec8: 5280a122     	mov	w2, #0x509              // =1289
  7b8ecc: 90002e60     	adrp	x0, 0xd84000
  7b8ed0: 91372001     	add	x1, x0, #0xdc8
  7b8ed4: 52800040     	mov	w0, #0x2                // =2
  7b8ed8: 97fe359d     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b8edc: 14000070     	b	0x7b909c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f370>
  7b8ee0: 9114c3e0     	add	x0, sp, #0x530
  7b8ee4: 97f3533c     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8ee8: b945cfe1     	ldr	w1, [sp, #0x5cc]
  7b8eec: b945cbe0     	ldr	w0, [sp, #0x5c8]
  7b8ef0: 1b007c21     	mul	w1, w1, w0
  7b8ef4: 2a0103e0     	mov	w0, w1
  7b8ef8: 531f7800     	lsl	w0, w0, #1
  7b8efc: 0b010001     	add	w1, w0, w1
  7b8f00: d0003d40     	adrp	x0, 0xf62000
  7b8f04: 91081000     	add	x0, x0, #0x204
  7b8f08: b9400000     	ldr	w0, [x0]
  7b8f0c: 6b00003f     	cmp	w1, w0
  7b8f10: 1a9f97e0     	cset	w0, hi
  7b8f14: 12001c00     	and	w0, w0, #0xff
  7b8f18: 7100001f     	cmp	w0, #0x0
  7b8f1c: 54000180     	b.eq	0x7b8f4c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f220>
  7b8f20: b0002e60     	adrp	x0, 0xd85000
  7b8f24: 91070003     	add	x3, x0, #0x1c0
  7b8f28: 5280a1e2     	mov	w2, #0x50f              // =1295
  7b8f2c: 90002e60     	adrp	x0, 0xd84000
  7b8f30: 91372001     	add	x1, x0, #0xdc8
  7b8f34: 52800040     	mov	w0, #0x2                // =2
  7b8f38: 97fe3585     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b8f3c: 9114c3e0     	add	x0, sp, #0x530
  7b8f40: 97f35325     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8f44: 3900201f     	strb	wzr, [x0, #0x8]
  7b8f48: 14000055     	b	0x7b909c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f370>
  7b8f4c: 52800022     	mov	w2, #0x1                // =1
  7b8f50: b0002e60     	adrp	x0, 0xd85000
  7b8f54: 91078001     	add	x1, x0, #0x1e0
  7b8f58: 9001b7a0     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b8f5c: 912c4000     	add	x0, x0, #0xb10
  7b8f60: 97fbed3a     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b8f64: 910603e0     	add	x0, sp, #0x180
  7b8f68: 94052d44     	bl	0x904478 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc4c>
  7b8f6c: b905cfe0     	str	w0, [sp, #0x5cc]
  7b8f70: 910603e0     	add	x0, sp, #0x180
  7b8f74: 94052d43     	bl	0x904480 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc54>
  7b8f78: b905cbe0     	str	w0, [sp, #0x5c8]
  7b8f7c: 9114c3e0     	add	x0, sp, #0x530
  7b8f80: 97f35315     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8f84: 91008000     	add	x0, x0, #0x20
  7b8f88: b945cfe1     	ldr	w1, [sp, #0x5cc]
  7b8f8c: b945cbe2     	ldr	w2, [sp, #0x5c8]
  7b8f90: 52800005     	mov	w5, #0x0                // =0
  7b8f94: d2800004     	mov	x4, #0x0                // =0
  7b8f98: 2a0203e3     	mov	w3, w2
  7b8f9c: 2a0103e2     	mov	w2, w1
  7b8fa0: 52800001     	mov	w1, #0x0                // =0
  7b8fa4: 97f29bba     	bl	0x45fe8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x29ee0>
  7b8fa8: 9114c3e0     	add	x0, sp, #0x530
  7b8fac: 97f3530a     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8fb0: 9101c000     	add	x0, x0, #0x70
  7b8fb4: b945cfe1     	ldr	w1, [sp, #0x5cc]
  7b8fb8: b945cbe2     	ldr	w2, [sp, #0x5c8]
  7b8fbc: 52800005     	mov	w5, #0x0                // =0
  7b8fc0: d2800004     	mov	x4, #0x0                // =0
  7b8fc4: 2a0203e3     	mov	w3, w2
  7b8fc8: 2a0103e2     	mov	w2, w1
  7b8fcc: 52800121     	mov	w1, #0x9                // =9
  7b8fd0: 97f29baf     	bl	0x45fe8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x29ee0>
  7b8fd4: 910603e0     	add	x0, sp, #0x180
  7b8fd8: 94052cfc     	bl	0x9043c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db9c>
  7b8fdc: aa0003f6     	mov	x22, x0
  7b8fe0: 9114c3e0     	add	x0, sp, #0x530
  7b8fe4: 97f352fc     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b8fe8: f9401813     	ldr	x19, [x0, #0x30]
  7b8fec: b945cff4     	ldr	w20, [sp, #0x5cc]
  7b8ff0: b945cbf5     	ldr	w21, [sp, #0x5c8]
  7b8ff4: 910603e0     	add	x0, sp, #0x180
  7b8ff8: 94052d1c     	bl	0x904468 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc3c>
  7b8ffc: 2a0003e5     	mov	w5, w0
  7b9000: 2a1503e4     	mov	w4, w21
  7b9004: 2a1403e3     	mov	w3, w20
  7b9008: aa1303e2     	mov	x2, x19
  7b900c: aa1603e1     	mov	x1, x22
  7b9010: f9408fe0     	ldr	x0, [sp, #0x118]
  7b9014: 94000206     	bl	0x7b982c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fb00>
  7b9018: 910763e0     	add	x0, sp, #0x1d8
  7b901c: 94052ceb     	bl	0x9043c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5db9c>
  7b9020: aa0003f6     	mov	x22, x0
  7b9024: 9114c3e0     	add	x0, sp, #0x530
  7b9028: 97f352eb     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b902c: f9404013     	ldr	x19, [x0, #0x80]
  7b9030: b945cff4     	ldr	w20, [sp, #0x5cc]
  7b9034: b945cbf5     	ldr	w21, [sp, #0x5c8]
  7b9038: 910763e0     	add	x0, sp, #0x1d8
  7b903c: 94052d0b     	bl	0x904468 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5dc3c>
  7b9040: 2a0003e5     	mov	w5, w0
  7b9044: 2a1503e4     	mov	w4, w21
  7b9048: 2a1403e3     	mov	w3, w20
  7b904c: aa1303e2     	mov	x2, x19
  7b9050: aa1603e1     	mov	x1, x22
  7b9054: f9408fe0     	ldr	x0, [sp, #0x118]
  7b9058: 940001c5     	bl	0x7b976c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fa40>
  7b905c: 9114c3e0     	add	x0, sp, #0x530
  7b9060: 97f352dd     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b9064: aa0003e1     	mov	x1, x0
  7b9068: 52800020     	mov	w0, #0x1                // =1
  7b906c: 3901b020     	strb	w0, [x1, #0x6c]
  7b9070: 9114c3e0     	add	x0, sp, #0x530
  7b9074: 97f352d8     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b9078: aa0003e1     	mov	x1, x0
  7b907c: 52800020     	mov	w0, #0x1                // =1
  7b9080: 39002020     	strb	w0, [x1, #0x8]
  7b9084: 52800002     	mov	w2, #0x0                // =0
  7b9088: 90002e60     	adrp	x0, 0xd85000
  7b908c: 91078001     	add	x1, x0, #0x1e0
  7b9090: f001b780     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b9094: 912c4000     	add	x0, x0, #0xb10
  7b9098: 97fbecec     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b909c: 52800002     	mov	w2, #0x0                // =0
  7b90a0: 90002e60     	adrp	x0, 0xd85000
  7b90a4: 91058001     	add	x1, x0, #0x160
  7b90a8: f001b780     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b90ac: 912c4000     	add	x0, x0, #0xb10
  7b90b0: 97fbece6     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b90b4: 910543e0     	add	x0, sp, #0x150
  7b90b8: 94000a91     	bl	0x7bbafc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1dd0>
  7b90bc: 9108c3e0     	add	x0, sp, #0x230
  7b90c0: 94000ba1     	bl	0x7bbf44 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa2218>
  7b90c4: 910483e0     	add	x0, sp, #0x120
  7b90c8: 94000a59     	bl	0x7bba2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1d00>
  7b90cc: 910763e0     	add	x0, sp, #0x1d8
  7b90d0: 94052af6     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  7b90d4: 910603e0     	add	x0, sp, #0x180
  7b90d8: 94052af4     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  7b90dc: 14000052     	b	0x7b9224 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f4f8>
  7b90e0: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b90e4: b944b400     	ldr	w0, [x0, #0x4b4]
  7b90e8: 7100041f     	cmp	w0, #0x1
  7b90ec: 540009c1     	b.ne	0x7b9224 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f4f8>
  7b90f0: 52800022     	mov	w2, #0x1                // =1
  7b90f4: 90002e60     	adrp	x0, 0xd85000
  7b90f8: 91080001     	add	x1, x0, #0x200
  7b90fc: f001b780     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b9100: 912c4000     	add	x0, x0, #0xb10
  7b9104: 97fbecd1     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b9108: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b910c: b940b000     	ldr	w0, [x0, #0xb0]
  7b9110: b905c3e0     	str	w0, [sp, #0x5c0]
  7b9114: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b9118: b940b400     	ldr	w0, [x0, #0xb4]
  7b911c: b905bfe0     	str	w0, [sp, #0x5bc]
  7b9120: b945c3e1     	ldr	w1, [sp, #0x5c0]
  7b9124: 2a0103e0     	mov	w0, w1
  7b9128: 531f7800     	lsl	w0, w0, #1
  7b912c: 0b010000     	add	w0, w0, w1
  7b9130: b905bbe0     	str	w0, [sp, #0x5b8]
  7b9134: 9114c3e0     	add	x0, sp, #0x530
  7b9138: 97f352a7     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b913c: b945c3e1     	ldr	w1, [sp, #0x5c0]
  7b9140: b945bfe0     	ldr	w0, [sp, #0x5bc]
  7b9144: 1b007c21     	mul	w1, w1, w0
  7b9148: 2a0103e0     	mov	w0, w1
  7b914c: 531f7800     	lsl	w0, w0, #1
  7b9150: 0b010001     	add	w1, w0, w1
  7b9154: b0003d40     	adrp	x0, 0xf62000
  7b9158: 91081000     	add	x0, x0, #0x204
  7b915c: b9400000     	ldr	w0, [x0]
  7b9160: 6b00003f     	cmp	w1, w0
  7b9164: 1a9f97e0     	cset	w0, hi
  7b9168: 12001c00     	and	w0, w0, #0xff
  7b916c: 7100001f     	cmp	w0, #0x0
  7b9170: 54000120     	b.eq	0x7b9194 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f468>
  7b9174: 90002e60     	adrp	x0, 0xd85000
  7b9178: 91070003     	add	x3, x0, #0x1c0
  7b917c: 5280a6c2     	mov	w2, #0x536              // =1334
  7b9180: f0002e40     	adrp	x0, 0xd84000
  7b9184: 91372001     	add	x1, x0, #0xdc8
  7b9188: 52800040     	mov	w0, #0x2                // =2
  7b918c: 97fe34f0     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7b9190: 1400001a     	b	0x7b91f8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f4cc>
  7b9194: 9114c3e0     	add	x0, sp, #0x530
  7b9198: 97f3528f     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b919c: 91008000     	add	x0, x0, #0x20
  7b91a0: b945c3e1     	ldr	w1, [sp, #0x5c0]
  7b91a4: b945bfe2     	ldr	w2, [sp, #0x5bc]
  7b91a8: 52800005     	mov	w5, #0x0                // =0
  7b91ac: d2800004     	mov	x4, #0x0                // =0
  7b91b0: 2a0203e3     	mov	w3, w2
  7b91b4: 2a0103e2     	mov	w2, w1
  7b91b8: 52800001     	mov	w1, #0x0                // =0
  7b91bc: 97f29b34     	bl	0x45fe8c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x29ee0>
  7b91c0: f942ebe0     	ldr	x0, [sp, #0x5d0]
  7b91c4: f9400413     	ldr	x19, [x0, #0x8]
  7b91c8: 9114c3e0     	add	x0, sp, #0x530
  7b91cc: 97f35282     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b91d0: f9401800     	ldr	x0, [x0, #0x30]
  7b91d4: b945c3e1     	ldr	w1, [sp, #0x5c0]
  7b91d8: b945bfe2     	ldr	w2, [sp, #0x5bc]
  7b91dc: b945bbe5     	ldr	w5, [sp, #0x5b8]
  7b91e0: 2a0203e4     	mov	w4, w2
  7b91e4: 2a0103e3     	mov	w3, w1
  7b91e8: aa0003e2     	mov	x2, x0
  7b91ec: aa1303e1     	mov	x1, x19
  7b91f0: f9408fe0     	ldr	x0, [sp, #0x118]
  7b91f4: 94000418     	bl	0x7ba254 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa0528>
  7b91f8: 9114c3e0     	add	x0, sp, #0x530
  7b91fc: 97f35276     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b9200: aa0003e1     	mov	x1, x0
  7b9204: 52800020     	mov	w0, #0x1                // =1
  7b9208: 39002020     	strb	w0, [x1, #0x8]
  7b920c: 52800002     	mov	w2, #0x0                // =0
  7b9210: 90002e60     	adrp	x0, 0xd85000
  7b9214: 91080001     	add	x1, x0, #0x200
  7b9218: f001b780     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b921c: 912c4000     	add	x0, x0, #0xb10
  7b9220: 97fbec8a     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b9224: 52800022     	mov	w2, #0x1                // =1
  7b9228: 90002e60     	adrp	x0, 0xd85000
  7b922c: 91086001     	add	x1, x0, #0x218
  7b9230: f001b780     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b9234: 912c4000     	add	x0, x0, #0xb10
  7b9238: 97fbec84     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b923c: 911483e0     	add	x0, sp, #0x520
  7b9240: f942fbe1     	ldr	x1, [sp, #0x5f0]
  7b9244: 97f28ca8     	bl	0x45c4e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x26538>
  7b9248: 911483e0     	add	x0, sp, #0x520
  7b924c: 97f28cd3     	bl	0x45c598 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x265ec>
  7b9250: 9101a000     	add	x0, x0, #0x68
  7b9254: f902dbe0     	str	x0, [sp, #0x5b0]
  7b9258: f9408fe1     	ldr	x1, [sp, #0x118]
  7b925c: d2880000     	mov	x0, #0x4000             // =16384
  7b9260: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b9264: 8b000020     	add	x0, x1, x0
  7b9268: b978d001     	ldr	w1, [x0, #0x38d0]
  7b926c: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9270: b9006001     	str	w1, [x0, #0x60]
  7b9274: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b9278: b944b400     	ldr	w0, [x0, #0x4b4]
  7b927c: 7100001f     	cmp	w0, #0x0
  7b9280: 54000101     	b.ne	0x7b92a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f574>
  7b9284: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9288: 94010ac9     	bl	0x7fbdac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x3fde4>
  7b928c: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9290: f9400c00     	ldr	x0, [x0, #0x18]
  7b9294: 52800021     	mov	w1, #0x1                // =1
  7b9298: b9000001     	str	w1, [x0]
  7b929c: 14000007     	b	0x7b92b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f58c>
  7b92a0: 9114c3e0     	add	x0, sp, #0x530
  7b92a4: 97f3524c     	bl	0x48dbd4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57c28>
  7b92a8: 91008000     	add	x0, x0, #0x20
  7b92ac: 52802002     	mov	w2, #0x100              // =256
  7b92b0: f942dbe1     	ldr	x1, [sp, #0x5b0]
  7b92b4: 94010b10     	bl	0x7fbef4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x3ff2c>
  7b92b8: f9408fe0     	ldr	x0, [sp, #0x118]
  7b92bc: f940f000     	ldr	x0, [x0, #0x1e0]
  7b92c0: f100001f     	cmp	x0, #0x0
  7b92c4: 54000aa0     	b.eq	0x7b9418 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f6ec>
  7b92c8: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b92cc: f9400c00     	ldr	x0, [x0, #0x18]
  7b92d0: f100001f     	cmp	x0, #0x0
  7b92d4: 54000a20     	b.eq	0x7b9418 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f6ec>
  7b92d8: b904ffff     	str	wzr, [sp, #0x4fc]
  7b92dc: b90603ff     	str	wzr, [sp, #0x600]
  7b92e0: f9408fe1     	ldr	x1, [sp, #0x118]
  7b92e4: d2880000     	mov	x0, #0x4000             // =16384
  7b92e8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b92ec: 8b000020     	add	x0, x1, x0
  7b92f0: b978d000     	ldr	w0, [x0, #0x38d0]
  7b92f4: b94603e1     	ldr	w1, [sp, #0x600]
  7b92f8: 6b00003f     	cmp	w1, w0
  7b92fc: 540001c2     	b.hs	0x7b9334 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f608>
  7b9300: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9304: f9400c01     	ldr	x1, [x0, #0x18]
  7b9308: b94603e0     	ldr	w0, [sp, #0x600]
  7b930c: d37ef400     	lsl	x0, x0, #2
  7b9310: 8b000021     	add	x1, x1, x0
  7b9314: 9113f3e0     	add	x0, sp, #0x4fc
  7b9318: 97f2b06a     	bl	0x4654c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2f514>
  7b931c: b9400000     	ldr	w0, [x0]
  7b9320: b904ffe0     	str	w0, [sp, #0x4fc]
  7b9324: b94603e0     	ldr	w0, [sp, #0x600]
  7b9328: 11000400     	add	w0, w0, #0x1
  7b932c: b90603e0     	str	w0, [sp, #0x600]
  7b9330: 17ffffec     	b	0x7b92e0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f5b4>
  7b9334: b944ffe0     	ldr	w0, [sp, #0x4fc]
  7b9338: 7100001f     	cmp	w0, #0x0
  7b933c: 540006e0     	b.eq	0x7b9418 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f6ec>
  7b9340: b905ffff     	str	wzr, [sp, #0x5fc]
  7b9344: f9408fe1     	ldr	x1, [sp, #0x118]
  7b9348: d2880000     	mov	x0, #0x4000             // =16384
  7b934c: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b9350: 8b000020     	add	x0, x1, x0
  7b9354: b978d000     	ldr	w0, [x0, #0x38d0]
  7b9358: b945ffe1     	ldr	w1, [sp, #0x5fc]
  7b935c: 6b00003f     	cmp	w1, w0
  7b9360: 54000302     	b.hs	0x7b93c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f694>
  7b9364: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9368: f9400c01     	ldr	x1, [x0, #0x18]
  7b936c: b945ffe0     	ldr	w0, [sp, #0x5fc]
  7b9370: d37ef400     	lsl	x0, x0, #2
  7b9374: 8b000020     	add	x0, x1, x0
  7b9378: b9400000     	ldr	w0, [x0]
  7b937c: 53185c01     	lsl	w1, w0, #8
  7b9380: b944ffe0     	ldr	w0, [sp, #0x4fc]
  7b9384: 1ac00820     	udiv	w0, w1, w0
  7b9388: b905afe0     	str	w0, [sp, #0x5ac]
  7b938c: b945afe2     	ldr	w2, [sp, #0x5ac]
  7b9390: b945afe1     	ldr	w1, [sp, #0x5ac]
  7b9394: 52801fe0     	mov	w0, #0xff               // =255
  7b9398: 7103fc5f     	cmp	w2, #0xff
  7b939c: 1a809020     	csel	w0, w1, w0, ls
  7b93a0: 12001c02     	and	w2, w0, #0xff
  7b93a4: b945ffe0     	ldr	w0, [sp, #0x5fc]
  7b93a8: 9108c7e1     	add	x1, sp, #0x231
  7b93ac: 38206822     	strb	w2, [x1, x0]
  7b93b0: b945ffe0     	ldr	w0, [sp, #0x5fc]
  7b93b4: 11000400     	add	w0, w0, #0x1
  7b93b8: b905ffe0     	str	w0, [sp, #0x5fc]
  7b93bc: 17ffffe2     	b	0x7b9344 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f618>
  7b93c0: f9408fe1     	ldr	x1, [sp, #0x118]
  7b93c4: d2880000     	mov	x0, #0x4000             // =16384
  7b93c8: f2acaa80     	movk	x0, #0x6554, lsl #16
  7b93cc: 8b000020     	add	x0, x1, x0
  7b93d0: b978d000     	ldr	w0, [x0, #0x38d0]
  7b93d4: 12001c00     	and	w0, w0, #0xff
  7b93d8: 3908c3e0     	strb	w0, [sp, #0x230]
  7b93dc: f9408fe0     	ldr	x0, [sp, #0x118]
  7b93e0: f940f014     	ldr	x20, [x0, #0x1e0]
  7b93e4: f9408fe0     	ldr	x0, [sp, #0x118]
  7b93e8: f940f000     	ldr	x0, [x0, #0x1e0]
  7b93ec: f9400000     	ldr	x0, [x0]
  7b93f0: 91012000     	add	x0, x0, #0x48
  7b93f4: f9400013     	ldr	x19, [x0]
  7b93f8: 910143e0     	add	x0, sp, #0x50
  7b93fc: 9108c3e1     	add	x1, sp, #0x230
  7b9400: d2801742     	mov	x2, #0xba               // =186
  7b9404: 97f1444b     	bl	0x40a530 <memcpy@plt>
  7b9408: 910143e0     	add	x0, sp, #0x50
  7b940c: aa0003e1     	mov	x1, x0
  7b9410: aa1403e0     	mov	x0, x20
  7b9414: d63f0260     	blr	x19
  7b9418: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b941c: b940c000     	ldr	w0, [x0, #0xc0]
  7b9420: b9051fe0     	str	w0, [sp, #0x51c]
  7b9424: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b9428: b940e800     	ldr	w0, [x0, #0xe8]
  7b942c: b90517e0     	str	w0, [sp, #0x514]
  7b9430: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b9434: b940e400     	ldr	w0, [x0, #0xe4]
  7b9438: b9051be0     	str	w0, [sp, #0x518]
  7b943c: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9440: f9400c02     	ldr	x2, [x0, #0x18]
  7b9444: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9448: b9406000     	ldr	w0, [x0, #0x60]
  7b944c: 2a0003e1     	mov	w1, w0
  7b9450: aa0203e0     	mov	x0, x2
  7b9454: 94010d05     	bl	0x7fc868 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x408a0>
  7b9458: bd0513e0     	str	s0, [sp, #0x510]
  7b945c: f9408fe1     	ldr	x1, [sp, #0x118]
  7b9460: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b9464: 8b000020     	add	x0, x1, x0
  7b9468: f97c6404     	ldr	x4, [x0, #0x78c8]
  7b946c: f9408fe1     	ldr	x1, [sp, #0x118]
  7b9470: d2acaa80     	mov	x0, #0x65540000         // =1700003840
  7b9474: 8b000020     	add	x0, x1, x0
  7b9478: f97c6400     	ldr	x0, [x0, #0x78c8]
  7b947c: f9400000     	ldr	x0, [x0]
  7b9480: 91012000     	add	x0, x0, #0x48
  7b9484: f9400003     	ldr	x3, [x0]
  7b9488: 911803e0     	add	x0, sp, #0x600
  7b948c: a9710801     	ldp	x1, x2, [x0, #-0xf0]
  7b9490: aa0403e0     	mov	x0, x4
  7b9494: d63f0060     	blr	x3
  7b9498: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b949c: b9426801     	ldr	w1, [x0, #0x268]
  7b94a0: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b94a4: b9004c01     	str	w1, [x0, #0x4c]
  7b94a8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b94ac: b9426c01     	ldr	w1, [x0, #0x26c]
  7b94b0: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b94b4: b9005001     	str	w1, [x0, #0x50]
  7b94b8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b94bc: b9427001     	ldr	w1, [x0, #0x270]
  7b94c0: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b94c4: b9005401     	str	w1, [x0, #0x54]
  7b94c8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b94cc: f9400401     	ldr	x1, [x0, #0x8]
  7b94d0: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b94d4: f9001801     	str	x1, [x0, #0x30]
  7b94d8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b94dc: b940c001     	ldr	w1, [x0, #0xc0]
  7b94e0: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b94e4: b9003801     	str	w1, [x0, #0x38]
  7b94e8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b94ec: b9425401     	ldr	w1, [x0, #0x254]
  7b94f0: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b94f4: b9004001     	str	w1, [x0, #0x40]
  7b94f8: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b94fc: b9425800     	ldr	w0, [x0, #0x258]
  7b9500: 1e230001     	ucvtf	s1, w0
  7b9504: f942f7e0     	ldr	x0, [sp, #0x5e8]
  7b9508: bd425c00     	ldr	s0, [x0, #0x25c]
  7b950c: 1e200820     	fmul	s0, s1, s0
  7b9510: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9514: bd004400     	str	s0, [x0, #0x44]
  7b9518: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b951c: b900201f     	str	wzr, [x0, #0x20]
  7b9520: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9524: b900241f     	str	wzr, [x0, #0x24]
  7b9528: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b952c: b900281f     	str	wzr, [x0, #0x28]
  7b9530: b94513e1     	ldr	w1, [sp, #0x510]
  7b9534: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9538: b9006401     	str	w1, [x0, #0x64]
  7b953c: f942dbe0     	ldr	x0, [sp, #0x5b0]
  7b9540: 52800021     	mov	w1, #0x1                // =1
  7b9544: 39017001     	strb	w1, [x0, #0x5c]
  7b9548: 52800002     	mov	w2, #0x0                // =0
  7b954c: 90002e60     	adrp	x0, 0xd85000
  7b9550: 9108c001     	add	x1, x0, #0x230
  7b9554: f001b780     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b9558: 912c4000     	add	x0, x0, #0xb10
  7b955c: 97fbebbb     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b9560: 52800002     	mov	w2, #0x0                // =0
  7b9564: 90002e60     	adrp	x0, 0xd85000
  7b9568: 91008001     	add	x1, x0, #0x20
  7b956c: f001b780     	adrp	x0, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  7b9570: 912c4000     	add	x0, x0, #0xb10
  7b9574: 97fbebb5     	bl	0x6b4448 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_mutateEmmPKcm+0x14088>
  7b9578: 911483e0     	add	x0, sp, #0x520
  7b957c: 97f28bf3     	bl	0x45c548 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2659c>
  7b9580: 9114c3e0     	add	x0, sp, #0x530
  7b9584: 97f35164     	bl	0x48db14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57b68>
  7b9588: 911503e0     	add	x0, sp, #0x540
  7b958c: 97f36f04     	bl	0x49519c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1f0>
  7b9590: b94607e0     	ldr	w0, [sp, #0x604]
  7b9594: 11000400     	add	w0, w0, #0x1
  7b9598: b90607e0     	str	w0, [sp, #0x604]
  7b959c: 17fffbb7     	b	0x7b8478 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e74c>
  7b95a0: f9408fe0     	ldr	x0, [sp, #0x118]
  7b95a4: f940d400     	ldr	x0, [x0, #0x1a8]
  7b95a8: f942fbe1     	ldr	x1, [sp, #0x5f0]
  7b95ac: 940430dd     	bl	0x8c5920 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f0f4>
  7b95b0: f9408fe0     	ldr	x0, [sp, #0x118]
  7b95b4: f940d400     	ldr	x0, [x0, #0x1a8]
  7b95b8: 91026000     	add	x0, x0, #0x98
  7b95bc: 97f36f5a     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  7b95c0: f90307e0     	str	x0, [sp, #0x608]
  7b95c4: 911543e0     	add	x0, sp, #0x550
  7b95c8: 97f36f28     	bl	0x495268 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2bc>
  7b95cc: 17fffb9d     	b	0x7b8440 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9e714>
  7b95d0: aa0003f3     	mov	x19, x0
  7b95d4: 911403e0     	add	x0, sp, #0x500
  7b95d8: 9400089d     	bl	0x7bb84c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1b20>
  7b95dc: 14000020     	b	0x7b965c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f930>
  7b95e0: aa0003f3     	mov	x19, x0
  7b95e4: 910543e0     	add	x0, sp, #0x150
  7b95e8: 94000945     	bl	0x7bbafc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1dd0>
  7b95ec: 14000002     	b	0x7b95f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f8c8>
  7b95f0: aa0003f3     	mov	x19, x0
  7b95f4: 9108c3e0     	add	x0, sp, #0x230
  7b95f8: 94000a53     	bl	0x7bbf44 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa2218>
  7b95fc: 14000002     	b	0x7b9604 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f8d8>
  7b9600: aa0003f3     	mov	x19, x0
  7b9604: 910483e0     	add	x0, sp, #0x120
  7b9608: 94000909     	bl	0x7bba2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa1d00>
  7b960c: 910763e0     	add	x0, sp, #0x1d8
  7b9610: 940529a6     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  7b9614: 14000002     	b	0x7b961c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f8f0>
  7b9618: aa0003f3     	mov	x19, x0
  7b961c: 910603e0     	add	x0, sp, #0x180
  7b9620: 940529a2     	bl	0x903ca8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x5d47c>
  7b9624: 14000006     	b	0x7b963c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f910>
  7b9628: aa0003f3     	mov	x19, x0
  7b962c: 911483e0     	add	x0, sp, #0x520
  7b9630: 97f28bc6     	bl	0x45c548 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x2659c>
  7b9634: 14000002     	b	0x7b963c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f910>
  7b9638: aa0003f3     	mov	x19, x0
  7b963c: 9114c3e0     	add	x0, sp, #0x530
  7b9640: 97f35135     	bl	0x48db14 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x57b68>
  7b9644: 14000002     	b	0x7b964c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f920>
  7b9648: aa0003f3     	mov	x19, x0
  7b964c: 911503e0     	add	x0, sp, #0x540
  7b9650: 97f36ed3     	bl	0x49519c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f1f0>
  7b9654: 14000002     	b	0x7b965c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f930>
  7b9658: aa0003f3     	mov	x19, x0
  7b965c: 911543e0     	add	x0, sp, #0x550
  7b9660: 97f36f02     	bl	0x495268 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f2bc>
  7b9664: aa1303e0     	mov	x0, x19
  7b9668: 97f1443a     	bl	0x40a750 <_Unwind_Resume@plt>
  7b966c: d503201f     	nop
  7b9670: a94253f3     	ldp	x19, x20, [sp, #0x20]
  7b9674: a9435bf5     	ldp	x21, x22, [sp, #0x30]
  7b9678: f94023f7     	ldr	x23, [sp, #0x40]
  7b967c: a9417bfd     	ldp	x29, x30, [sp, #0x10]
  7b9680: 911843ff     	add	sp, sp, #0x610
  7b9684: d65f03c0     	ret
  7b9688: d10143ff     	sub	sp, sp, #0x50
  7b968c: f90017e0     	str	x0, [sp, #0x28]
  7b9690: f90013e1     	str	x1, [sp, #0x20]
  7b9694: f9000fe2     	str	x2, [sp, #0x18]
  7b9698: b90017e3     	str	w3, [sp, #0x14]
  7b969c: b90013e4     	str	w4, [sp, #0x10]
  7b96a0: b9000fe5     	str	w5, [sp, #0xc]
  7b96a4: f9400fe0     	ldr	x0, [sp, #0x18]
  7b96a8: f90027e0     	str	x0, [sp, #0x48]
  7b96ac: f94013e0     	ldr	x0, [sp, #0x20]
  7b96b0: f90023e0     	str	x0, [sp, #0x40]
  7b96b4: b9003fff     	str	wzr, [sp, #0x3c]
  7b96b8: b9403fe1     	ldr	w1, [sp, #0x3c]
  7b96bc: b94013e0     	ldr	w0, [sp, #0x10]
  7b96c0: 6b00003f     	cmp	w1, w0
  7b96c4: 540004ea     	b.ge	0x7b9760 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fa34>
  7b96c8: f94023e0     	ldr	x0, [sp, #0x40]
  7b96cc: f9001be0     	str	x0, [sp, #0x30]
  7b96d0: b9003bff     	str	wzr, [sp, #0x38]
  7b96d4: b9403be1     	ldr	w1, [sp, #0x38]
  7b96d8: b94017e0     	ldr	w0, [sp, #0x14]
  7b96dc: 6b00003f     	cmp	w1, w0
  7b96e0: 5400030a     	b.ge	0x7b9740 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fa14>
  7b96e4: f94023e0     	ldr	x0, [sp, #0x40]
  7b96e8: 39400000     	ldrb	w0, [x0]
  7b96ec: 12001c02     	and	w2, w0, #0xff
  7b96f0: f94027e0     	ldr	x0, [sp, #0x48]
  7b96f4: 91000401     	add	x1, x0, #0x1
  7b96f8: f90027e1     	str	x1, [sp, #0x48]
  7b96fc: 2a0203e1     	mov	w1, w2
  7b9700: 39000001     	strb	w1, [x0]
  7b9704: f94027e0     	ldr	x0, [sp, #0x48]
  7b9708: 91000401     	add	x1, x0, #0x1
  7b970c: f90027e1     	str	x1, [sp, #0x48]
  7b9710: 3900001f     	strb	wzr, [x0]
  7b9714: f94027e0     	ldr	x0, [sp, #0x48]
  7b9718: 91000401     	add	x1, x0, #0x1
  7b971c: f90027e1     	str	x1, [sp, #0x48]
  7b9720: 3900001f     	strb	wzr, [x0]
  7b9724: f94023e0     	ldr	x0, [sp, #0x40]
  7b9728: 91000400     	add	x0, x0, #0x1
  7b972c: f90023e0     	str	x0, [sp, #0x40]
  7b9730: b9403be0     	ldr	w0, [sp, #0x38]
  7b9734: 11000400     	add	w0, w0, #0x1
  7b9738: b9003be0     	str	w0, [sp, #0x38]
  7b973c: 17ffffe6     	b	0x7b96d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f9a8>
  7b9740: b9800fe0     	ldrsw	x0, [sp, #0xc]
  7b9744: f9401be1     	ldr	x1, [sp, #0x30]
  7b9748: 8b000020     	add	x0, x1, x0
  7b974c: f90023e0     	str	x0, [sp, #0x40]
  7b9750: b9403fe0     	ldr	w0, [sp, #0x3c]
  7b9754: 11000400     	add	w0, w0, #0x1
  7b9758: b9003fe0     	str	w0, [sp, #0x3c]
  7b975c: 17ffffd7     	b	0x7b96b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9f98c>
  7b9760: d503201f     	nop
  7b9764: 910143ff     	add	sp, sp, #0x50
  7b9768: d65f03c0     	ret
  7b976c: d10143ff     	sub	sp, sp, #0x50
  7b9770: f90017e0     	str	x0, [sp, #0x28]
  7b9774: f90013e1     	str	x1, [sp, #0x20]
  7b9778: f9000fe2     	str	x2, [sp, #0x18]
  7b977c: b90017e3     	str	w3, [sp, #0x14]
  7b9780: b90013e4     	str	w4, [sp, #0x10]
  7b9784: b9000fe5     	str	w5, [sp, #0xc]
  7b9788: f9400fe0     	ldr	x0, [sp, #0x18]
  7b978c: f90027e0     	str	x0, [sp, #0x48]
  7b9790: f94013e0     	ldr	x0, [sp, #0x20]
  7b9794: f90023e0     	str	x0, [sp, #0x40]
  7b9798: b9003fff     	str	wzr, [sp, #0x3c]
  7b979c: b9403fe1     	ldr	w1, [sp, #0x3c]
  7b97a0: b94013e0     	ldr	w0, [sp, #0x10]
  7b97a4: 6b00003f     	cmp	w1, w0
  7b97a8: 540003ca     	b.ge	0x7b9820 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9faf4>
  7b97ac: f94023e0     	ldr	x0, [sp, #0x40]
  7b97b0: f9001be0     	str	x0, [sp, #0x30]
  7b97b4: b9003bff     	str	wzr, [sp, #0x38]
  7b97b8: b9403be1     	ldr	w1, [sp, #0x38]
  7b97bc: b94017e0     	ldr	w0, [sp, #0x14]
  7b97c0: 6b00003f     	cmp	w1, w0
  7b97c4: 540001ea     	b.ge	0x7b9800 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fad4>
  7b97c8: f94023e0     	ldr	x0, [sp, #0x40]
  7b97cc: 91000401     	add	x1, x0, #0x1
  7b97d0: f90023e1     	str	x1, [sp, #0x40]
  7b97d4: 39400000     	ldrb	w0, [x0]
  7b97d8: 12001c02     	and	w2, w0, #0xff
  7b97dc: f94027e0     	ldr	x0, [sp, #0x48]
  7b97e0: 91000401     	add	x1, x0, #0x1
  7b97e4: f90027e1     	str	x1, [sp, #0x48]
  7b97e8: 2a0203e1     	mov	w1, w2
  7b97ec: 39000001     	strb	w1, [x0]
  7b97f0: b9403be0     	ldr	w0, [sp, #0x38]
  7b97f4: 11000400     	add	w0, w0, #0x1
  7b97f8: b9003be0     	str	w0, [sp, #0x38]
  7b97fc: 17ffffef     	b	0x7b97b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fa8c>
  7b9800: b9800fe0     	ldrsw	x0, [sp, #0xc]
  7b9804: f9401be1     	ldr	x1, [sp, #0x30]
  7b9808: 8b000020     	add	x0, x1, x0
  7b980c: f90023e0     	str	x0, [sp, #0x40]
  7b9810: b9403fe0     	ldr	w0, [sp, #0x3c]
  7b9814: 11000400     	add	w0, w0, #0x1
  7b9818: b9003fe0     	str	w0, [sp, #0x3c]
  7b981c: 17ffffe0     	b	0x7b979c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fa70>
  7b9820: d503201f     	nop
  7b9824: 910143ff     	add	sp, sp, #0x50
  7b9828: d65f03c0     	ret
  7b982c: d10143ff     	sub	sp, sp, #0x50
  7b9830: f90017e0     	str	x0, [sp, #0x28]
  7b9834: f90013e1     	str	x1, [sp, #0x20]
  7b9838: f9000fe2     	str	x2, [sp, #0x18]
  7b983c: b90017e3     	str	w3, [sp, #0x14]
  7b9840: b90013e4     	str	w4, [sp, #0x10]
  7b9844: b9000fe5     	str	w5, [sp, #0xc]
  7b9848: f9400fe0     	ldr	x0, [sp, #0x18]
  7b984c: f90027e0     	str	x0, [sp, #0x48]
  7b9850: f94013e0     	ldr	x0, [sp, #0x20]
  7b9854: f90023e0     	str	x0, [sp, #0x40]
  7b9858: b9003fff     	str	wzr, [sp, #0x3c]
  7b985c: b9403fe1     	ldr	w1, [sp, #0x3c]
  7b9860: b94013e0     	ldr	w0, [sp, #0x10]
  7b9864: 6b00003f     	cmp	w1, w0
  7b9868: 540006aa     	b.ge	0x7b993c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fc10>
  7b986c: f94023e0     	ldr	x0, [sp, #0x40]
  7b9870: f9001be0     	str	x0, [sp, #0x30]
  7b9874: b9003bff     	str	wzr, [sp, #0x38]
  7b9878: b9403be1     	ldr	w1, [sp, #0x38]
  7b987c: b94017e0     	ldr	w0, [sp, #0x14]
  7b9880: 6b00003f     	cmp	w1, w0
  7b9884: 540004ca     	b.ge	0x7b991c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fbf0>
  7b9888: f94023e0     	ldr	x0, [sp, #0x40]
  7b988c: 91000400     	add	x0, x0, #0x1
  7b9890: f90023e0     	str	x0, [sp, #0x40]
  7b9894: f94023e0     	ldr	x0, [sp, #0x40]
  7b9898: 91000401     	add	x1, x0, #0x1
  7b989c: f90023e1     	str	x1, [sp, #0x40]
  7b98a0: 39400000     	ldrb	w0, [x0]
  7b98a4: 12001c02     	and	w2, w0, #0xff
  7b98a8: f94027e0     	ldr	x0, [sp, #0x48]
  7b98ac: 91000401     	add	x1, x0, #0x1
  7b98b0: f90027e1     	str	x1, [sp, #0x48]
  7b98b4: 2a0203e1     	mov	w1, w2
  7b98b8: 39000001     	strb	w1, [x0]
  7b98bc: f94023e0     	ldr	x0, [sp, #0x40]
  7b98c0: 91000401     	add	x1, x0, #0x1
  7b98c4: f90023e1     	str	x1, [sp, #0x40]
  7b98c8: 39400000     	ldrb	w0, [x0]
  7b98cc: 12001c02     	and	w2, w0, #0xff
  7b98d0: f94027e0     	ldr	x0, [sp, #0x48]
  7b98d4: 91000401     	add	x1, x0, #0x1
  7b98d8: f90027e1     	str	x1, [sp, #0x48]
  7b98dc: 2a0203e1     	mov	w1, w2
  7b98e0: 39000001     	strb	w1, [x0]
  7b98e4: f94023e0     	ldr	x0, [sp, #0x40]
  7b98e8: 91000401     	add	x1, x0, #0x1
  7b98ec: f90023e1     	str	x1, [sp, #0x40]
  7b98f0: 39400000     	ldrb	w0, [x0]
  7b98f4: 12001c02     	and	w2, w0, #0xff
  7b98f8: f94027e0     	ldr	x0, [sp, #0x48]
  7b98fc: 91000401     	add	x1, x0, #0x1
  7b9900: f90027e1     	str	x1, [sp, #0x48]
  7b9904: 2a0203e1     	mov	w1, w2
  7b9908: 39000001     	strb	w1, [x0]
  7b990c: b9403be0     	ldr	w0, [sp, #0x38]
  7b9910: 11000400     	add	w0, w0, #0x1
  7b9914: b9003be0     	str	w0, [sp, #0x38]
  7b9918: 17ffffd8     	b	0x7b9878 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fb4c>
  7b991c: b9800fe0     	ldrsw	x0, [sp, #0xc]
  7b9920: f9401be1     	ldr	x1, [sp, #0x30]
  7b9924: 8b000020     	add	x0, x1, x0
  7b9928: f90023e0     	str	x0, [sp, #0x40]
  7b992c: b9403fe0     	ldr	w0, [sp, #0x3c]
  7b9930: 11000400     	add	w0, w0, #0x1
  7b9934: b9003fe0     	str	w0, [sp, #0x3c]
  7b9938: 17ffffc9     	b	0x7b985c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fb30>
  7b993c: d503201f     	nop
  7b9940: 910143ff     	add	sp, sp, #0x50
  7b9944: d65f03c0     	ret
  7b9948: d10283ff     	sub	sp, sp, #0xa0
  7b994c: f90017e0     	str	x0, [sp, #0x28]
  7b9950: f90013e1     	str	x1, [sp, #0x20]
  7b9954: f9000fe2     	str	x2, [sp, #0x18]
  7b9958: b90017e3     	str	w3, [sp, #0x14]
  7b995c: b90013e4     	str	w4, [sp, #0x10]
  7b9960: b9000fe5     	str	w5, [sp, #0xc]
  7b9964: b9000be6     	str	w6, [sp, #0x8]
  7b9968: f9400fe0     	ldr	x0, [sp, #0x18]
  7b996c: f9004fe0     	str	x0, [sp, #0x98]
  7b9970: f94013e0     	ldr	x0, [sp, #0x20]
  7b9974: f9004be0     	str	x0, [sp, #0x90]
  7b9978: b9400be0     	ldr	w0, [sp, #0x8]
  7b997c: 7102d01f     	cmp	w0, #0xb4
  7b9980: 54001380     	b.eq	0x7b9bf0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fec4>
  7b9984: b9400be0     	ldr	w0, [sp, #0x8]
  7b9988: 7104381f     	cmp	w0, #0x10e
  7b998c: 540000a0     	b.eq	0x7b99a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fc74>
  7b9990: b9400be0     	ldr	w0, [sp, #0x8]
  7b9994: 7101681f     	cmp	w0, #0x5a
  7b9998: 540009c0     	b.eq	0x7b9ad0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fda4>
  7b999c: 140000dc     	b	0x7b9d0c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9ffe0>
  7b99a0: b9008fff     	str	wzr, [sp, #0x8c]
  7b99a4: b9408fe1     	ldr	w1, [sp, #0x8c]
  7b99a8: b94013e0     	ldr	w0, [sp, #0x10]
  7b99ac: 6b00003f     	cmp	w1, w0
  7b99b0: 5400220a     	b.ge	0x7b9df0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa00c4>
  7b99b4: f9404be0     	ldr	x0, [sp, #0x90]
  7b99b8: f90037e0     	str	x0, [sp, #0x68]
  7b99bc: b9008bff     	str	wzr, [sp, #0x88]
  7b99c0: b9408be1     	ldr	w1, [sp, #0x88]
  7b99c4: b94017e0     	ldr	w0, [sp, #0x14]
  7b99c8: 6b00003f     	cmp	w1, w0
  7b99cc: 5400072a     	b.ge	0x7b9ab0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fd84>
  7b99d0: b94017e1     	ldr	w1, [sp, #0x14]
  7b99d4: b9408be0     	ldr	w0, [sp, #0x88]
  7b99d8: 4b000020     	sub	w0, w1, w0
  7b99dc: 51000401     	sub	w1, w0, #0x1
  7b99e0: b94013e0     	ldr	w0, [sp, #0x10]
  7b99e4: 1b007c21     	mul	w1, w1, w0
  7b99e8: b9408fe0     	ldr	w0, [sp, #0x8c]
  7b99ec: 0b000021     	add	w1, w1, w0
  7b99f0: 2a0103e0     	mov	w0, w1
  7b99f4: 531f7800     	lsl	w0, w0, #1
  7b99f8: 0b010000     	add	w0, w0, w1
  7b99fc: 93407c00     	sxtw	x0, w0
  7b9a00: d1000400     	sub	x0, x0, #0x1
  7b9a04: f9404fe1     	ldr	x1, [sp, #0x98]
  7b9a08: 8b000020     	add	x0, x1, x0
  7b9a0c: f90033e0     	str	x0, [sp, #0x60]
  7b9a10: f9404be0     	ldr	x0, [sp, #0x90]
  7b9a14: 91000400     	add	x0, x0, #0x1
  7b9a18: f9004be0     	str	x0, [sp, #0x90]
  7b9a1c: f9404be0     	ldr	x0, [sp, #0x90]
  7b9a20: 91000401     	add	x1, x0, #0x1
  7b9a24: f9004be1     	str	x1, [sp, #0x90]
  7b9a28: 39400000     	ldrb	w0, [x0]
  7b9a2c: 39017fe0     	strb	w0, [sp, #0x5f]
  7b9a30: f9404be0     	ldr	x0, [sp, #0x90]
  7b9a34: 91000401     	add	x1, x0, #0x1
  7b9a38: f9004be1     	str	x1, [sp, #0x90]
  7b9a3c: 39400000     	ldrb	w0, [x0]
  7b9a40: 39017be0     	strb	w0, [sp, #0x5e]
  7b9a44: f9404be0     	ldr	x0, [sp, #0x90]
  7b9a48: 91000401     	add	x1, x0, #0x1
  7b9a4c: f9004be1     	str	x1, [sp, #0x90]
  7b9a50: 39400000     	ldrb	w0, [x0]
  7b9a54: 390177e0     	strb	w0, [sp, #0x5d]
  7b9a58: 394177e2     	ldrb	w2, [sp, #0x5d]
  7b9a5c: f94033e0     	ldr	x0, [sp, #0x60]
  7b9a60: d1000401     	sub	x1, x0, #0x1
  7b9a64: f90033e1     	str	x1, [sp, #0x60]
  7b9a68: 2a0203e1     	mov	w1, w2
  7b9a6c: 39000001     	strb	w1, [x0]
  7b9a70: 39417be2     	ldrb	w2, [sp, #0x5e]
  7b9a74: f94033e0     	ldr	x0, [sp, #0x60]
  7b9a78: d1000401     	sub	x1, x0, #0x1
  7b9a7c: f90033e1     	str	x1, [sp, #0x60]
  7b9a80: 2a0203e1     	mov	w1, w2
  7b9a84: 39000001     	strb	w1, [x0]
  7b9a88: 39417fe2     	ldrb	w2, [sp, #0x5f]
  7b9a8c: f94033e0     	ldr	x0, [sp, #0x60]
  7b9a90: d1000401     	sub	x1, x0, #0x1
  7b9a94: f90033e1     	str	x1, [sp, #0x60]
  7b9a98: 2a0203e1     	mov	w1, w2
  7b9a9c: 39000001     	strb	w1, [x0]
  7b9aa0: b9408be0     	ldr	w0, [sp, #0x88]
  7b9aa4: 11000400     	add	w0, w0, #0x1
  7b9aa8: b9008be0     	str	w0, [sp, #0x88]
  7b9aac: 17ffffc5     	b	0x7b99c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fc94>
  7b9ab0: b9800fe0     	ldrsw	x0, [sp, #0xc]
  7b9ab4: f94037e1     	ldr	x1, [sp, #0x68]
  7b9ab8: 8b000020     	add	x0, x1, x0
  7b9abc: f9004be0     	str	x0, [sp, #0x90]
  7b9ac0: b9408fe0     	ldr	w0, [sp, #0x8c]
  7b9ac4: 11000400     	add	w0, w0, #0x1
  7b9ac8: b9008fe0     	str	w0, [sp, #0x8c]
  7b9acc: 17ffffb6     	b	0x7b99a4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fc78>
  7b9ad0: b90087ff     	str	wzr, [sp, #0x84]
  7b9ad4: b94087e1     	ldr	w1, [sp, #0x84]
  7b9ad8: b94013e0     	ldr	w0, [sp, #0x10]
  7b9adc: 6b00003f     	cmp	w1, w0
  7b9ae0: 540018ca     	b.ge	0x7b9df8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0xa00cc>
  7b9ae4: f9404be0     	ldr	x0, [sp, #0x90]
  7b9ae8: f9002be0     	str	x0, [sp, #0x50]
  7b9aec: b90083ff     	str	wzr, [sp, #0x80]
  7b9af0: b94083e1     	ldr	w1, [sp, #0x80]
  7b9af4: b94017e0     	ldr	w0, [sp, #0x14]
  7b9af8: 6b00003f     	cmp	w1, w0
  7b9afc: 540006aa     	b.ge	0x7b9bd0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x9fea4>
