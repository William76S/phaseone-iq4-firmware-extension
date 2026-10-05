  74e454: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  74e458: 910003fd     	mov	x29, sp
  74e45c: a90153f3     	stp	x19, x20, [sp, #0x10]
  74e460: f90017e0     	str	x0, [sp, #0x28]
  74e464: b90027e1     	str	w1, [sp, #0x24]
  74e468: 39008fe2     	strb	w2, [sp, #0x23]
  74e46c: f9001bff     	str	xzr, [sp, #0x30]
  74e470: b9003fff     	str	wzr, [sp, #0x3c]
  74e474: b9803fe0     	ldrsw	x0, [sp, #0x3c]
  74e478: f100481f     	cmp	x0, #0x12
  74e47c: 54000688     	b.hi	0x74e54c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34820>
  74e480: f0004020     	adrp	x0, 0xf55000
  74e484: 9132e001     	add	x1, x0, #0xcb8
  74e488: b9803fe0     	ldrsw	x0, [sp, #0x3c]
  74e48c: d37be800     	lsl	x0, x0, #5
  74e490: 8b000020     	add	x0, x1, x0
  74e494: b9400000     	ldr	w0, [x0]
  74e498: b94027e1     	ldr	w1, [sp, #0x24]
  74e49c: 6b00003f     	cmp	w1, w0
  74e4a0: 540004e1     	b.ne	0x74e53c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34810>
  74e4a4: 39408fe0     	ldrb	w0, [sp, #0x23]
  74e4a8: 7100001f     	cmp	w0, #0x0
  74e4ac: 54000180     	b.eq	0x74e4dc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x347b0>
  74e4b0: f0004020     	adrp	x0, 0xf55000
  74e4b4: 9132e001     	add	x1, x0, #0xcb8
  74e4b8: b9803fe0     	ldrsw	x0, [sp, #0x3c]
  74e4bc: d37be800     	lsl	x0, x0, #5
  74e4c0: 8b000020     	add	x0, x1, x0
  74e4c4: f9400800     	ldr	x0, [x0, #0x10]
  74e4c8: f9001be0     	str	x0, [sp, #0x30]
  74e4cc: f9401be0     	ldr	x0, [sp, #0x30]
  74e4d0: 52800021     	mov	w1, #0x1                // =1
  74e4d4: 940005fc     	bl	0x74fcc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x35f98>
  74e4d8: 1400001d     	b	0x74e54c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34820>
  74e4dc: f0004020     	adrp	x0, 0xf55000
  74e4e0: 9132e001     	add	x1, x0, #0xcb8
  74e4e4: b9803fe0     	ldrsw	x0, [sp, #0x3c]
  74e4e8: d37be800     	lsl	x0, x0, #5
  74e4ec: 8b000020     	add	x0, x1, x0
  74e4f0: b9401800     	ldr	w0, [x0, #0x18]
  74e4f4: 7100001f     	cmp	w0, #0x0
  74e4f8: 1a9f17e0     	cset	w0, eq
  74e4fc: 3900efe0     	strb	w0, [sp, #0x3b]
  74e500: d2804300     	mov	x0, #0x218              // =536
  74e504: 97f2ee57     	bl	0x409e60 <_Znwm@plt>
  74e508: aa0003f3     	mov	x19, x0
  74e50c: f0004020     	adrp	x0, 0xf55000
  74e510: 9132e001     	add	x1, x0, #0xcb8
  74e514: b9803fe0     	ldrsw	x0, [sp, #0x3c]
  74e518: d37be800     	lsl	x0, x0, #5
  74e51c: 8b000020     	add	x0, x1, x0
  74e520: f9400400     	ldr	x0, [x0, #0x8]
  74e524: 3940efe2     	ldrb	w2, [sp, #0x3b]
  74e528: aa0003e1     	mov	x1, x0
  74e52c: aa1303e0     	mov	x0, x19
  74e530: 94035db7     	bl	0x825c0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x69c44>
  74e534: f9001bf3     	str	x19, [sp, #0x30]
  74e538: 14000005     	b	0x74e54c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34820>
  74e53c: b9403fe0     	ldr	w0, [sp, #0x3c]
  74e540: 11000400     	add	w0, w0, #0x1
  74e544: b9003fe0     	str	w0, [sp, #0x3c]
  74e548: 17ffffcb     	b	0x74e474 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34748>
  74e54c: f9401be0     	ldr	x0, [sp, #0x30]
  74e550: f100001f     	cmp	x0, #0x0
  74e554: 54000141     	b.ne	0x74e57c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34850>
  74e558: 528036c3     	mov	w3, #0x1b6              // =438
  74e55c: 90002740     	adrp	x0, 0xc36000
  74e560: 910a8002     	add	x2, x0, #0x2a0
  74e564: 90002740     	adrp	x0, 0xc36000
  74e568: 910ec001     	add	x1, x0, #0x3b0
  74e56c: 90002740     	adrp	x0, 0xc36000
  74e570: 910f0000     	add	x0, x0, #0x3c0
  74e574: 97f2f003     	bl	0x40a580 <printf@plt>
  74e578: 94007864     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  74e57c: f9401be0     	ldr	x0, [sp, #0x30]
  74e580: 14000007     	b	0x74e59c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34870>
  74e584: aa0003f4     	mov	x20, x0
  74e588: d2804301     	mov	x1, #0x218              // =536
  74e58c: aa1303e0     	mov	x0, x19
  74e590: 97f2ee14     	bl	0x409de0 <_ZdlPvm@plt>
  74e594: aa1403e0     	mov	x0, x20
  74e598: 97f2f06e     	bl	0x40a750 <_Unwind_Resume@plt>
  74e59c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  74e5a0: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  74e5a4: d65f03c0     	ret
  74e5a8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  74e5ac: 910003fd     	mov	x29, sp
  74e5b0: f9000fe0     	str	x0, [sp, #0x18]
  74e5b4: b90017e1     	str	w1, [sp, #0x14]
  74e5b8: 39004fe2     	strb	w2, [sp, #0x13]
  74e5bc: b9002fff     	str	wzr, [sp, #0x2c]
  74e5c0: b9802fe0     	ldrsw	x0, [sp, #0x2c]
  74e5c4: f101541f     	cmp	x0, #0x55
  74e5c8: 540003e8     	b.hi	0x74e644 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34918>
  74e5cc: f0004020     	adrp	x0, 0xf55000
  74e5d0: 913c6002     	add	x2, x0, #0xf18
  74e5d4: b9802fe1     	ldrsw	x1, [sp, #0x2c]
  74e5d8: aa0103e0     	mov	x0, x1
  74e5dc: d37ef400     	lsl	x0, x0, #2
  74e5e0: 8b010000     	add	x0, x0, x1
  74e5e4: d37df000     	lsl	x0, x0, #3
  74e5e8: 8b000040     	add	x0, x2, x0
  74e5ec: b9400000     	ldr	w0, [x0]
  74e5f0: b94017e1     	ldr	w1, [sp, #0x14]
  74e5f4: 6b00003f     	cmp	w1, w0
  74e5f8: 540001e1     	b.ne	0x74e634 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34908>
  74e5fc: f0004020     	adrp	x0, 0xf55000
  74e600: 913c6002     	add	x2, x0, #0xf18
  74e604: b9802fe1     	ldrsw	x1, [sp, #0x2c]
  74e608: aa0103e0     	mov	x0, x1
  74e60c: d37ef400     	lsl	x0, x0, #2
  74e610: 8b010000     	add	x0, x0, x1
  74e614: d37df000     	lsl	x0, x0, #3
  74e618: 8b000040     	add	x0, x2, x0
  74e61c: b9401800     	ldr	w0, [x0, #0x18]
  74e620: 39404fe2     	ldrb	w2, [sp, #0x13]
  74e624: 2a0003e1     	mov	w1, w0
  74e628: f9400fe0     	ldr	x0, [sp, #0x18]
  74e62c: 97ffff8a     	bl	0x74e454 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34728>
  74e630: 14000014     	b	0x74e680 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34954>
  74e634: b9402fe0     	ldr	w0, [sp, #0x2c]
  74e638: 11000400     	add	w0, w0, #0x1
  74e63c: b9002fe0     	str	w0, [sp, #0x2c]
  74e640: 17ffffe0     	b	0x74e5c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34894>
  74e644: 52800180     	mov	w0, #0xc                // =12
  74e648: 97ffff06     	bl	0x74e260 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34534>
  74e64c: aa0003e5     	mov	x5, x0
  74e650: b94017e4     	ldr	w4, [sp, #0x14]
  74e654: 90002740     	adrp	x0, 0xc36000
  74e658: 910fa003     	add	x3, x0, #0x3e8
  74e65c: 528038e2     	mov	w2, #0x1c7              // =455
  74e660: 90002740     	adrp	x0, 0xc36000
  74e664: 910a8001     	add	x1, x0, #0x2a0
  74e668: 52800080     	mov	w0, #0x4                // =4
  74e66c: 97ffdfb8     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  74e670: 39404fe2     	ldrb	w2, [sp, #0x13]
  74e674: 52800181     	mov	w1, #0xc                // =12
  74e678: f9400fe0     	ldr	x0, [sp, #0x18]
  74e67c: 97ffff76     	bl	0x74e454 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x34728>
  74e680: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  74e684: d65f03c0     	ret
