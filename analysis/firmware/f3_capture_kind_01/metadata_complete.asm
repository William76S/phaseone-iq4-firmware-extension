
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  793350: a9ba7bfd     	stp	x29, x30, [sp, #-0x60]!
  793354: 12001c63     	and	w3, w3, #0xff
  793358: 910003fd     	mov	x29, sp
  79335c: a90153f3     	stp	x19, x20, [sp, #0x10]
  793360: 91402014     	add	x20, x0, #0x8, lsl #12  // =0x8000
  793364: a9025bf5     	stp	x21, x22, [sp, #0x20]
  793368: aa0003f6     	mov	x22, x0
  79336c: f9002bfb     	str	x27, [sp, #0x50]
  793370: 2a0103fb     	mov	w27, w1
  793374: b941da81     	ldr	w1, [x20, #0x1d8]
  793378: b941ce80     	ldr	w0, [x20, #0x1cc]
  79337c: 11000421     	add	w1, w1, #0x1
  793380: b901da81     	str	w1, [x20, #0x1d8]
  793384: 6b00005f     	cmp	w2, w0
  793388: 54000d43     	b.lo	0x793530 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79804>
  79338c: a90363f7     	stp	x23, x24, [sp, #0x30]
  793390: 12001c84     	and	w4, w4, #0xff
  793394: 6a030097     	ands	w23, w4, w3
  793398: a9046bf9     	stp	x25, x26, [sp, #0x40]
  79339c: 2a0203fa     	mov	w26, w2
  7933a0: 54000780     	b.eq	0x793490 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79764>
  7933a4: 90002f19     	adrp	x25, 0xd73000
  7933a8: 90002f18     	adrp	x24, 0xd73000
  7933ac: 91162339     	add	x25, x25, #0x588
  7933b0: 9110a318     	add	x24, x24, #0x428
  7933b4: 52800015     	mov	w21, #0x0               // =0
  7933b8: 52800003     	mov	w3, #0x0                // =0
  7933bc: 14000017     	b	0x793418 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x796ec>
  7933c0: b941d680     	ldr	w0, [x20, #0x1d4]
  7933c4: 39477281     	ldrb	w1, [x20, #0x1dc]
  7933c8: 11000400     	add	w0, w0, #0x1
  7933cc: b901d680     	str	w0, [x20, #0x1d4]
  7933d0: 35000aa1     	cbnz	w1, 0x793524 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x797f8>
  7933d4: b941ce84     	ldr	w4, [x20, #0x1cc]
  7933d8: aa1903e3     	mov	x3, x25
  7933dc: aa1803e1     	mov	x1, x24
  7933e0: 52800080     	mov	w0, #0x4                // =4
  7933e4: 2a1303e5     	mov	w5, w19
  7933e8: 52802942     	mov	w2, #0x14a              // =330
  7933ec: 110006b5     	add	w21, w21, #0x1
  7933f0: 1b047e64     	mul	w4, w19, w4
  7933f4: 97fecc56     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  7933f8: f940e280     	ldr	x0, [x20, #0x1c0]
  7933fc: 52800421     	mov	w1, #0x21               // =33
  793400: 2a1703e3     	mov	w3, w23
  793404: 38334801     	strb	w1, [x0, w19, uxtw]
  793408: b941ce80     	ldr	w0, [x20, #0x1cc]
  79340c: 1ac00b41     	udiv	w1, w26, w0
  793410: 6b15003f     	cmp	w1, w21
  793414: 540001c9     	b.ls	0x79344c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79720>
  793418: 1ac00b60     	udiv	w0, w27, w0
  79341c: f940e281     	ldr	x1, [x20, #0x1c0]
  793420: 0b150013     	add	w19, w0, w21
  793424: 38734820     	ldrb	w0, [x1, w19, uxtw]
  793428: 7100c01f     	cmp	w0, #0x30
  79342c: 54fffca1     	b.ne	0x7933c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79694>
  793430: 39474280     	ldrb	w0, [x20, #0x1d0]
  793434: 110006b5     	add	w21, w21, #0x1
  793438: 38334820     	strb	w0, [x1, w19, uxtw]
  79343c: b941ce80     	ldr	w0, [x20, #0x1cc]
  793440: 1ac00b41     	udiv	w1, w26, w0
  793444: 6b15003f     	cmp	w1, w21
  793448: 54fffe88     	b.hi	0x793418 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x796ec>
  79344c: a94363f7     	ldp	x23, x24, [sp, #0x30]
  793450: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  793454: 52800821     	mov	w1, #0x41               // =65
  793458: 39474280     	ldrb	w0, [x20, #0x1d0]
  79345c: 11000400     	add	w0, w0, #0x1
  793460: 12001c00     	and	w0, w0, #0xff
  793464: 71016c1f     	cmp	w0, #0x5b
  793468: 1a813000     	csel	w0, w0, w1, lo
  79346c: 39074280     	strb	w0, [x20, #0x1d0]
  793470: 39474680     	ldrb	w0, [x20, #0x1d1]
  793474: 34000300     	cbz	w0, 0x7934d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x797a8>
  793478: aa1603e0     	mov	x0, x22
  79347c: a94153f3     	ldp	x19, x20, [sp, #0x10]
  793480: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  793484: f9402bfb     	ldr	x27, [sp, #0x50]
  793488: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  79348c: 17fffe91     	b	0x792ed0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x791a4>
  793490: 52800001     	mov	w1, #0x0                // =0
  793494: 35000303     	cbnz	w3, 0x7934f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x797c8>
  793498: 52800604     	mov	w4, #0x30               // =48
  79349c: d503201f     	nop
  7934a0: 1ac00b60     	udiv	w0, w27, w0
  7934a4: f940e282     	ldr	x2, [x20, #0x1c0]
  7934a8: 0b010000     	add	w0, w0, w1
  7934ac: 11000421     	add	w1, w1, #0x1
  7934b0: 38204844     	strb	w4, [x2, w0, uxtw]
  7934b4: b941ce80     	ldr	w0, [x20, #0x1cc]
  7934b8: 1ac00b42     	udiv	w2, w26, w0
  7934bc: 6b02003f     	cmp	w1, w2
  7934c0: 54ffff03     	b.lo	0x7934a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79774>
  7934c4: a94363f7     	ldp	x23, x24, [sp, #0x30]
  7934c8: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  7934cc: 39474680     	ldrb	w0, [x20, #0x1d1]
  7934d0: 35fffd40     	cbnz	w0, 0x793478 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7974c>
  7934d4: 39477280     	ldrb	w0, [x20, #0x1dc]
  7934d8: 6a00007f     	tst	w3, w0
  7934dc: 54fffce1     	b.ne	0x793478 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7974c>
  7934e0: a94153f3     	ldp	x19, x20, [sp, #0x10]
  7934e4: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  7934e8: f9402bfb     	ldr	x27, [sp, #0x50]
  7934ec: a8c67bfd     	ldp	x29, x30, [sp], #0x60
  7934f0: d65f03c0     	ret
  7934f4: 1ac00b60     	udiv	w0, w27, w0
  7934f8: 39474283     	ldrb	w3, [x20, #0x1d0]
  7934fc: f940e282     	ldr	x2, [x20, #0x1c0]
  793500: 0b010000     	add	w0, w0, w1
  793504: 11000421     	add	w1, w1, #0x1
  793508: 38204843     	strb	w3, [x2, w0, uxtw]
  79350c: b941ce80     	ldr	w0, [x20, #0x1cc]
  793510: 1ac00b42     	udiv	w2, w26, w0
  793514: 6b01005f     	cmp	w2, w1
  793518: 54fffee8     	b.hi	0x7934f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x797c8>
  79351c: 52800003     	mov	w3, #0x0                // =0
  793520: 17ffffcb     	b	0x79344c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79720>
  793524: aa1603e0     	mov	x0, x22
  793528: 97fffe6a     	bl	0x792ed0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x791a4>
  79352c: 17ffffaa     	b	0x7933d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x796a8>
  793530: 34fffce3     	cbz	w3, 0x7934cc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x797a0>
  793534: 52800003     	mov	w3, #0x0                // =0
  793538: 17ffffc7     	b	0x793454 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79728>
  79353c: d503201f     	nop
  793540: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  793544: 52802d01     	mov	w1, #0x168              // =360
  793548: 90002f02     	adrp	x2, 0xd73000
  79354c: 910003fd     	mov	x29, sp
  793550: a9046bf9     	stp	x25, x26, [sp, #0x40]
  793554: aa0003f9     	mov	x25, x0
  793558: 9116c042     	add	x2, x2, #0x5b0
  79355c: a90363f7     	stp	x23, x24, [sp, #0x30]
  793560: 90002f17     	adrp	x23, 0xd73000
  793564: 9110a2f7     	add	x23, x23, #0x428
  793568: aa1703e0     	mov	x0, x23
  79356c: a90153f3     	stp	x19, x20, [sp, #0x10]
  793570: 9140233a     	add	x26, x25, #0x8, lsl #12 // =0x8000
  793574: a9025bf5     	stp	x21, x22, [sp, #0x20]
  793578: 97fecbc9     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  79357c: d2841c04     	mov	x4, #0x20e0             // =8416
  793580: f9506321     	ldr	x1, [x25, #0x20c0]
  793584: 8b040334     	add	x20, x25, x4
  793588: 529e0015     	mov	w21, #0xf000            // =61440
  79358c: aa0103e0     	mov	x0, x1
  793590: 72a07fb5     	movk	w21, #0x3fd, lsl #16
  793594: 29488433     	ldp	w19, w1, [x1, #0x44]
  793598: 11005273     	add	w19, w19, #0x14
  79359c: 1b017e73     	mul	w19, w19, w1
  7935a0: 97f2e9ee     	bl	0x44dd58 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x17dac>
  7935a4: 72001c1f     	tst	w0, #0xff
  7935a8: d2c00100     	mov	x0, #0x800000000        // =34359738368
  7935ac: f9505f22     	ldr	x2, [x25, #0x20b8]
  7935b0: 531f7a61     	lsl	w1, w19, #1
  7935b4: 531e7673     	lsl	w19, w19, #2
  7935b8: f9109b22     	str	x2, [x25, #0x2130]
  7935bc: 1a811273     	csel	w19, w19, w1, ne
  7935c0: f9109f20     	str	x0, [x25, #0x2138]
  7935c4: 11400673     	add	w19, w19, #0x1, lsl #12 // =0x1000
  7935c8: 52800001     	mov	w1, #0x0                // =0
  7935cc: 12144e73     	and	w19, w19, #0xfffff000
  7935d0: aa1403e0     	mov	x0, x20
  7935d4: 2a1303e3     	mov	w3, w19
  7935d8: 52800002     	mov	w2, #0x0                // =0
  7935dc: 97ffb4b5     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  7935e0: 2a1303e3     	mov	w3, w19
  7935e4: aa1403e0     	mov	x0, x20
  7935e8: 52800002     	mov	w2, #0x0                // =0
  7935ec: 52800021     	mov	w1, #0x1                // =1
  7935f0: 97ffb4b0     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  7935f4: 2a1503e3     	mov	w3, w21
  7935f8: 2a1303e2     	mov	w2, w19
  7935fc: aa1403e0     	mov	x0, x20
  793600: 52800081     	mov	w1, #0x4                // =4
  793604: 97ffb4ab     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  793608: 2a1503e3     	mov	w3, w21
  79360c: 0b150262     	add	w2, w19, w21
  793610: aa1403e0     	mov	x0, x20
  793614: 528000a1     	mov	w1, #0x5                // =5
  793618: 97ffb4a6     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  79361c: 529c0002     	mov	w2, #0xe000             // =57344
  793620: 2a1503e3     	mov	w3, w21
  793624: aa1403e0     	mov	x0, x20
  793628: 528000c1     	mov	w1, #0x6                // =6
  79362c: 72a0ff62     	movk	w2, #0x7fb, lsl #16
  793630: 0b020262     	add	w2, w19, w2
  793634: 97ffb49f     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  793638: 529a0002     	mov	w2, #0xd000             // =53248
  79363c: 2a1503e3     	mov	w3, w21
  793640: aa1403e0     	mov	x0, x20
  793644: 528000e1     	mov	w1, #0x7                // =7
  793648: 72a17f22     	movk	w2, #0xbf9, lsl #16
  79364c: 0b020262     	add	w2, w19, w2
  793650: 97ffb498     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  793654: 52980002     	mov	w2, #0xc000             // =49152
  793658: 2a1503e3     	mov	w3, w21
  79365c: aa1403e0     	mov	x0, x20
  793660: 52800101     	mov	w1, #0x8                // =8
  793664: 72a1fee2     	movk	w2, #0xff7, lsl #16
  793668: 0b020262     	add	w2, w19, w2
  79366c: 97ffb491     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  793670: 52960002     	mov	w2, #0xb000             // =45056
  793674: 2a1503e3     	mov	w3, w21
  793678: aa1403e0     	mov	x0, x20
  79367c: 52800121     	mov	w1, #0x9                // =9
  793680: 72a27ea2     	movk	w2, #0x13f5, lsl #16
  793684: 0b020262     	add	w2, w19, w2
  793688: 97ffb48a     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  79368c: f9506323     	ldr	x3, [x25, #0x20c0]
  793690: 52800002     	mov	w2, #0x0                // =0
  793694: 528000a1     	mov	w1, #0x5                // =5
  793698: aa0303e0     	mov	x0, x3
  79369c: 295d0c75     	ldp	w21, w3, [x3, #0xe8]
  7936a0: 1b037eb5     	mul	w21, w21, w3
  7936a4: 97f2e9c2     	bl	0x44ddac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x17e00>
  7936a8: 52940002     	mov	w2, #0xa000             // =40960
  7936ac: 52b80004     	mov	w4, #-0x40000000        // =-1073741824
  7936b0: 72a2fe62     	movk	w2, #0x17f3, lsl #16
  7936b4: 0b020262     	add	w2, w19, w2
  7936b8: 531e76b5     	lsl	w21, w21, #2
  7936bc: 4b020084     	sub	w4, w4, w2
  7936c0: 0b0002a5     	add	w5, w21, w0
  7936c4: 2a0003f6     	mov	w22, w0
  7936c8: 52800041     	mov	w1, #0x2                // =2
  7936cc: aa1403e0     	mov	x0, x20
  7936d0: 1ac50884     	udiv	w4, w4, w5
  7936d4: 1b047ed6     	mul	w22, w22, w4
  7936d8: 1b047eb5     	mul	w21, w21, w4
  7936dc: 114006d6     	add	w22, w22, #0x1, lsl #12 // =0x1000
  7936e0: 12144ed6     	and	w22, w22, #0xfffff000
  7936e4: 114006b5     	add	w21, w21, #0x1, lsl #12 // =0x1000
  7936e8: 2a1603e3     	mov	w3, w22
  7936ec: 0b160058     	add	w24, w2, w22
  7936f0: 12144eb5     	and	w21, w21, #0xfffff000
  7936f4: 97ffb46f     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  7936f8: 52800061     	mov	w1, #0x3                // =3
  7936fc: 2a1803e2     	mov	w2, w24
  793700: 2a1503e3     	mov	w3, w21
  793704: aa1403e0     	mov	x0, x20
  793708: 97ffb46a     	bl	0x7808b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66b84>
  79370c: b941cf40     	ldr	w0, [x26, #0x1cc]
  793710: 1ac00ac0     	udiv	w0, w22, w0
  793714: 11000400     	add	w0, w0, #0x1
  793718: b901cb40     	str	w0, [x26, #0x1c8]
  79371c: 97f1db49     	bl	0x40a440 <_Znam@plt>
  793720: f900e340     	str	x0, [x26, #0x1c0]
  793724: b941cb41     	ldr	w1, [x26, #0x1c8]
  793728: 34000181     	cbz	w1, 0x793758 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79a2c>
  79372c: 52800602     	mov	w2, #0x30               // =48
  793730: 39000002     	strb	w2, [x0]
  793734: 7100043f     	cmp	w1, #0x1
  793738: 54000109     	b.ls	0x793758 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79a2c>
  79373c: d2800020     	mov	x0, #0x1                // =1
  793740: f940e341     	ldr	x1, [x26, #0x1c0]
  793744: 38206822     	strb	w2, [x1, x0]
  793748: 91000400     	add	x0, x0, #0x1
  79374c: b941cb41     	ldr	w1, [x26, #0x1c8]
  793750: 6b00003f     	cmp	w1, w0
  793754: 54ffff68     	b.hi	0x793740 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79a14>
  793758: 52800001     	mov	w1, #0x0                // =0
  79375c: aa1403e0     	mov	x0, x20
  793760: 53017e73     	lsr	w19, w19, #1
  793764: 97ffb397     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  793768: 34000133     	cbz	w19, 0x79378c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79a60>
  79376c: 51000673     	sub	w19, w19, #0x1
  793770: 52808002     	mov	w2, #0x400              // =1024
  793774: 91000673     	add	x19, x19, #0x1
  793778: 8b130401     	add	x1, x0, x19, lsl #1
  79377c: d503201f     	nop
  793780: 78002402     	strh	w2, [x0], #0x2
  793784: eb01001f     	cmp	x0, x1
  793788: 54ffffc1     	b.ne	0x793780 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79a54>
  79378c: 90002f02     	adrp	x2, 0xd73000
  793790: 91174042     	add	x2, x2, #0x5d0
  793794: 52803481     	mov	w1, #0x1a4              // =420
  793798: aa1703e0     	mov	x0, x23
  79379c: 97fecb40     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  7937a0: 0b150315     	add	w21, w24, w21
  7937a4: 52800041     	mov	w1, #0x2                // =2
  7937a8: aa1403e0     	mov	x0, x20
  7937ac: 97ffb385     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  7937b0: 2a1603e2     	mov	w2, w22
  7937b4: 52800541     	mov	w1, #0x2a               // =42
  7937b8: 97f1da7a     	bl	0x40a1a0 <memset@plt>
  7937bc: 12a80000     	mov	w0, #-0x40000001        // =-1073741825
  7937c0: 6b0002bf     	cmp	w21, w0
  7937c4: 54000ea8     	b.hi	0x793998 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79c6c>
  7937c8: b0002580     	adrp	x0, 0xc44000
  7937cc: 91400b33     	add	x19, x25, #0x2, lsl #12 // =0x2000
  7937d0: 52920002     	mov	w2, #0x9000             // =36864
  7937d4: 52800101     	mov	w1, #0x8                // =8
  7937d8: fd467000     	ldr	d0, [x0, #0xce0]
  7937dc: 72a00fc2     	movk	w2, #0x7e, lsl #16
  7937e0: aa1403e0     	mov	x0, x20
  7937e4: fd10b320     	str	d0, [x25, #0x2160]
  7937e8: b9016a62     	str	w2, [x19, #0x168]
  7937ec: 97ffb375     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  7937f0: f910a320     	str	x0, [x25, #0x2140]
  7937f4: 52800121     	mov	w1, #0x9                // =9
  7937f8: aa1403e0     	mov	x0, x20
  7937fc: 97ffb371     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  793800: f900a660     	str	x0, [x19, #0x148]
  793804: 52800101     	mov	w1, #0x8                // =8
  793808: aa1403e0     	mov	x0, x20
  79380c: 97ffb317     	bl	0x780468 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6673c>
  793810: f900aa60     	str	x0, [x19, #0x150]
  793814: 52800121     	mov	w1, #0x9                // =9
  793818: aa1403e0     	mov	x0, x20
  79381c: 97ffb313     	bl	0x780468 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6673c>
  793820: f900ae60     	str	x0, [x19, #0x158]
  793824: b9416a63     	ldr	w3, [x19, #0x168]
  793828: 52800002     	mov	w2, #0x0                // =0
  79382c: f940a661     	ldr	x1, [x19, #0x148]
  793830: 6b430bff     	cmp	wzr, w3, lsr #2
  793834: f950a320     	ldr	x0, [x25, #0x2140]
  793838: 54000100     	b.eq	0x793858 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79b2c>
  79383c: d503201f     	nop
  793840: b800441f     	str	wzr, [x0], #0x4
  793844: 11000442     	add	w2, w2, #0x1
  793848: b800443f     	str	wzr, [x1], #0x4
  79384c: b9416a63     	ldr	w3, [x19, #0x168]
  793850: 6b43085f     	cmp	w2, w3, lsr #2
  793854: 54ffff63     	b.lo	0x793840 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79b14>
  793858: d280f002     	mov	x2, #0x780              // =1920
  79385c: 90002f00     	adrp	x0, 0xd73000
  793860: f2c08702     	movk	x2, #0x438, lsl #32
  793864: f9112322     	str	x2, [x25, #0x2240]
  793868: 3909a27f     	strb	wzr, [x19, #0x268]
  79386c: d2c00023     	mov	x3, #0x100000000        // =4294967296
  793870: f9417c00     	ldr	x0, [x0, #0x2f8]
  793874: f910bb23     	str	x3, [x25, #0x2170]
  793878: 52800042     	mov	w2, #0x2                // =2
  79387c: f900be60     	str	x0, [x19, #0x178]
  793880: b9026e62     	str	w2, [x19, #0x26c]
  793884: 7103fc1f     	cmp	w0, #0xff
  793888: 54000060     	b.eq	0x793894 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79b68>
  79388c: 52800062     	mov	w2, #0x3                // =3
  793890: b9026e62     	str	w2, [x19, #0x26c]
  793894: d360fc00     	lsr	x0, x0, #32
  793898: 7103fc1f     	cmp	w0, #0xff
  79389c: 54000060     	b.eq	0x7938a8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79b7c>
  7938a0: 11000442     	add	w2, w2, #0x1
  7938a4: b9026e62     	str	w2, [x19, #0x26c]
  7938a8: 52948003     	mov	w3, #0xa400             // =41984
  7938ac: 52800081     	mov	w1, #0x4                // =4
  7938b0: 72a003e3     	movk	w3, #0x1f, lsl #16
  7938b4: aa1403e0     	mov	x0, x20
  7938b8: 1b037c42     	mul	w2, w2, w3
  7938bc: b9024a62     	str	w2, [x19, #0x248]
  7938c0: 97ffb340     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  7938c4: f900c260     	str	x0, [x19, #0x180]
  7938c8: 528000a1     	mov	w1, #0x5                // =5
  7938cc: aa1403e0     	mov	x0, x20
  7938d0: 97ffb33c     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  7938d4: f900c660     	str	x0, [x19, #0x188]
  7938d8: 528000c1     	mov	w1, #0x6                // =6
  7938dc: aa1403e0     	mov	x0, x20
  7938e0: 97ffb338     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  7938e4: f900ca60     	str	x0, [x19, #0x190]
  7938e8: 528000e1     	mov	w1, #0x7                // =7
  7938ec: aa1403e0     	mov	x0, x20
  7938f0: 97ffb334     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  7938f4: f900ce60     	str	x0, [x19, #0x198]
  7938f8: 52800081     	mov	w1, #0x4                // =4
  7938fc: aa1403e0     	mov	x0, x20
  793900: 97ffb2da     	bl	0x780468 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6673c>
  793904: f900d260     	str	x0, [x19, #0x1a0]
  793908: 528000a1     	mov	w1, #0x5                // =5
  79390c: aa1403e0     	mov	x0, x20
  793910: 97ffb2d6     	bl	0x780468 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6673c>
  793914: f900d660     	str	x0, [x19, #0x1a8]
  793918: 528000c1     	mov	w1, #0x6                // =6
  79391c: aa1403e0     	mov	x0, x20
  793920: 97ffb2d2     	bl	0x780468 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6673c>
  793924: f900da60     	str	x0, [x19, #0x1b0]
  793928: 528000e1     	mov	w1, #0x7                // =7
  79392c: aa1403e0     	mov	x0, x20
  793930: 97ffb2ce     	bl	0x780468 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x6673c>
  793934: f900de60     	str	x0, [x19, #0x1b8]
  793938: b9424a61     	ldr	w1, [x19, #0x248]
  79393c: 53017c20     	lsr	w0, w1, #1
  793940: 34000200     	cbz	w0, 0x793980 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79c54>
  793944: 51000402     	sub	w2, w0, #0x1
  793948: d2843403     	mov	x3, #0x21a0             // =8608
  79394c: 91000442     	add	x2, x2, #0x1
  793950: d2843000     	mov	x0, #0x2180             // =8576
  793954: 8b000321     	add	x1, x25, x0
  793958: 8b030339     	add	x25, x25, x3
  79395c: d37ff842     	lsl	x2, x2, #1
  793960: f9400020     	ldr	x0, [x1]
  793964: 8b020003     	add	x3, x0, x2
  793968: 7800241f     	strh	wzr, [x0], #0x2
  79396c: eb03001f     	cmp	x0, x3
  793970: 54ffffc1     	b.ne	0x793968 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79c3c>
  793974: 91002021     	add	x1, x1, #0x8
  793978: eb01033f     	cmp	x25, x1
  79397c: 54ffff21     	b.ne	0x793960 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79c34>
  793980: a94153f3     	ldp	x19, x20, [sp, #0x10]
  793984: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  793988: a94363f7     	ldp	x23, x24, [sp, #0x30]
  79398c: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  793990: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  793994: d65f03c0     	ret
  793998: aa1703e2     	mov	x2, x23
  79399c: 90002f01     	adrp	x1, 0xd73000
  7939a0: 91178021     	add	x1, x1, #0x5e0
  7939a4: 52803623     	mov	w3, #0x1b1              // =433
  7939a8: 90001f40     	adrp	x0, 0xb7b000
  7939ac: 91212000     	add	x0, x0, #0x848
  7939b0: 97f1daf4     	bl	0x40a580 <printf@plt>
  7939b4: 97ff6355     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  7939b8: 17ffff84     	b	0x7937c8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79a9c>
  7939bc: d503201f     	nop
  7939c0: a9b47bfd     	stp	x29, x30, [sp, #-0xc0]!
  7939c4: 910003fd     	mov	x29, sp
  7939c8: a90153f3     	stp	x19, x20, [sp, #0x10]
  7939cc: aa0003f3     	mov	x19, x0
  7939d0: 90002f14     	adrp	x20, 0xd73000
  7939d4: a9025bf5     	stp	x21, x22, [sp, #0x20]
  7939d8: 9101e294     	add	x20, x20, #0x78
  7939dc: f9505400     	ldr	x0, [x0, #0x20a8]
  7939e0: 97ffb934     	bl	0x781eb0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x68184>
  7939e4: f9505a61     	ldr	x1, [x19, #0x20b0]
  7939e8: d2800004     	mov	x4, #0x0                // =0
  7939ec: a9401e86     	ldp	x6, x7, [x20]
  7939f0: aa0103e0     	mov	x0, x1
  7939f4: f9400025     	ldr	x5, [x1]
  7939f8: a9099fe6     	stp	x6, x7, [sp, #0x98]
  7939fc: 52800023     	mov	w3, #0x1                // =1
  793a00: a9411e86     	ldp	x6, x7, [x20, #0x10]
  793a04: a90a9fe6     	stp	x6, x7, [sp, #0xa8]
  793a08: 52808742     	mov	w2, #0x43a              // =1082
  793a0c: f9401286     	ldr	x6, [x20, #0x20]
  793a10: f9005fe6     	str	x6, [sp, #0xb8]
  793a14: f94024a5     	ldr	x5, [x5, #0x48]
  793a18: 52800001     	mov	w1, #0x0                // =0
  793a1c: d63f00a0     	blr	x5
  793a20: f9505a63     	ldr	x3, [x19, #0x20b0]
  793a24: 910263e2     	add	x2, sp, #0x98
  793a28: 52800001     	mov	w1, #0x0                // =0
  793a2c: aa0303e0     	mov	x0, x3
  793a30: f9400063     	ldr	x3, [x3]
  793a34: f9401063     	ldr	x3, [x3, #0x20]
  793a38: d63f0060     	blr	x3
  793a3c: 52800140     	mov	w0, #0xa                // =10
  793a40: 97fdf3fe     	bl	0x710a38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x229b8>
  793a44: f9505a64     	ldr	x4, [x19, #0x20b0]
  793a48: 52800023     	mov	w3, #0x1                // =1
  793a4c: 52808382     	mov	w2, #0x41c              // =1052
  793a50: 52800001     	mov	w1, #0x0                // =0
  793a54: aa0403e0     	mov	x0, x4
  793a58: f9400084     	ldr	x4, [x4]
  793a5c: f9400884     	ldr	x4, [x4, #0x10]
  793a60: d63f0080     	blr	x4
  793a64: f9505a60     	ldr	x0, [x19, #0x20b0]
  793a68: 9100a281     	add	x1, x20, #0x28
  793a6c: 910143e3     	add	x3, sp, #0x50
  793a70: aa0303e2     	mov	x2, x3
  793a74: f9400004     	ldr	x4, [x0]
  793a78: 4c40a020     	ld1	{ v0.16b, v1.16b }, [x1]
  793a7c: 52800001     	mov	w1, #0x0                // =0
  793a80: 4c00a060     	st1	{ v0.16b, v1.16b }, [x3]
  793a84: f9401083     	ldr	x3, [x4, #0x20]
  793a88: d63f0060     	blr	x3
  793a8c: f9505660     	ldr	x0, [x19, #0x20a8]
  793a90: 52802c21     	mov	w1, #0x161              // =353
  793a94: 97ffa62f     	bl	0x77d350 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x63624>
  793a98: 35000f60     	cbnz	w0, 0x793c84 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79f58>
  793a9c: f9504a60     	ldr	x0, [x19, #0x2090]
  793aa0: 9404c754     	bl	0x8c57f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1efc4>
  793aa4: f9104e60     	str	x0, [x19, #0x2098]
  793aa8: b4001100     	cbz	x0, 0x793cc8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79f9c>
  793aac: 911fa260     	add	x0, x19, #0x7e8
  793ab0: b940c401     	ldr	w1, [x0, #0xc4]
  793ab4: 7100043f     	cmp	w1, #0x1
  793ab8: 54000061     	b.ne	0x793ac4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79d98>
  793abc: 39430001     	ldrb	w1, [x0, #0xc0]
  793ac0: 350000a1     	cbnz	w1, 0x793ad4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79da8>
  793ac4: 52800021     	mov	w1, #0x1                // =1
  793ac8: 39030001     	strb	w1, [x0, #0xc0]
  793acc: 911fc260     	add	x0, x19, #0x7f0
  793ad0: 97fdee0a     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  793ad4: 90002f16     	adrp	x22, 0xd73000
  793ad8: 9110a2d6     	add	x22, x22, #0x428
  793adc: d290320a     	mov	x10, #0x8190            // =33168
  793ae0: 8b0a0260     	add	x0, x19, x10
  793ae4: b9406a81     	ldr	w1, [x20, #0x68]
  793ae8: 91401275     	add	x21, x19, #0x4, lsl #12 // =0x4000
  793aec: a9449684     	ldp	x4, x5, [x20, #0x48]
  793af0: a90717e4     	stp	x4, x5, [sp, #0x70]
  793af4: a9458e82     	ldp	x2, x3, [x20, #0x58]
  793af8: a9080fe2     	stp	x2, x3, [sp, #0x80]
  793afc: b90093e1     	str	w1, [sp, #0x90]
  793b00: a9001404     	stp	x4, x5, [x0]
  793b04: a9010c02     	stp	x2, x3, [x0, #0x10]
  793b08: b9002001     	str	w1, [x0, #0x20]
  793b0c: b947e2a0     	ldr	w0, [x21, #0x7e0]
  793b10: 7100081f     	cmp	w0, #0x2
  793b14: 54000061     	b.ne	0x793b20 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79df4>
  793b18: 52800020     	mov	w0, #0x1                // =1
  793b1c: 391f92a0     	strb	w0, [x21, #0x7e4]
  793b20: 91402274     	add	x20, x19, #0x8, lsl #12 // =0x8000
  793b24: 3946d280     	ldrb	w0, [x20, #0x1b4]
  793b28: 350008e0     	cbnz	w0, 0x793c44 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79f18>
  793b2c: f9001bf7     	str	x23, [sp, #0x30]
  793b30: 52800037     	mov	w23, #0x1               // =1
  793b34: b907e2b7     	str	w23, [x21, #0x7e0]
  793b38: aa1603e0     	mov	x0, x22
  793b3c: 52824841     	mov	w1, #0x1242             // =4674
  793b40: 90002f02     	adrp	x2, 0xd73000
  793b44: 911a4042     	add	x2, x2, #0x690
  793b48: 97feca55     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  793b4c: f9506260     	ldr	x0, [x19, #0x20c0]
  793b50: 2a1703e1     	mov	w1, w23
  793b54: 97f2e7f9     	bl	0x44db38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x17b8c>
  793b58: 91004001     	add	x1, x0, #0x10
  793b5c: d2902d87     	mov	x7, #0x816c             // =33132
  793b60: 8b070262     	add	x2, x19, x7
  793b64: eb01005f     	cmp	x2, x1
  793b68: d2902f88     	mov	x8, #0x817c             // =33148
  793b6c: 8b080261     	add	x1, x19, x8
  793b70: fa413002     	ccmp	x0, x1, #0x2, lo
  793b74: 54000ca3     	b.lo	0x793d08 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79fdc>
  793b78: 3dc00000     	ldr	q0, [x0]
  793b7c: d2904006     	mov	x6, #0x8200             // =33280
  793b80: 8b060261     	add	x1, x19, x6
  793b84: 3c96c020     	stur	q0, [x1, #-0x94]
  793b88: 3dc00400     	ldr	q0, [x0, #0x10]
  793b8c: 3c97c020     	stur	q0, [x1, #-0x84]
  793b90: b9402000     	ldr	w0, [x0, #0x20]
  793b94: b9018e80     	str	w0, [x20, #0x18c]
  793b98: f9401bf7     	ldr	x23, [sp, #0x30]
  793b9c: 52800020     	mov	w0, #0x1                // =1
  793ba0: 391f92a0     	strb	w0, [x21, #0x7e4]
  793ba4: 0f000400     	movi	v0.2s, #0x0
  793ba8: 39045680     	strb	w0, [x20, #0x115]
  793bac: d2800002     	mov	x2, #0x0                // =0
  793bb0: f9407a81     	ldr	x1, [x20, #0xf0]
  793bb4: b96aa020     	ldr	w0, [x1, #0x2aa0]
  793bb8: 7100041f     	cmp	w0, #0x1
  793bbc: 540000a1     	b.ne	0x793bd0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79ea4>
  793bc0: b96a8023     	ldr	w3, [x1, #0x2a80]
  793bc4: d2854005     	mov	x5, #0x2a00             // =10752
  793bc8: 8b050020     	add	x0, x1, x5
  793bcc: 34000903     	cbz	w3, 0x793cec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79fc0>
  793bd0: fd0023e0     	str	d0, [sp, #0x40]
  793bd4: d2855000     	mov	x0, #0x2a80             // =10880
  793bd8: f90027e2     	str	x2, [sp, #0x48]
  793bdc: 8b000023     	add	x3, x1, x0
  793be0: fd154020     	str	d0, [x1, #0x2a80]
  793be4: d2853904     	mov	x4, #0x29c8             // =10696
  793be8: 8b040020     	add	x0, x1, x4
  793bec: f84453e1     	ldur	x1, [sp, #0x45]
  793bf0: f8005061     	stur	x1, [x3, #0x5]
  793bf4: 97fdedc1     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  793bf8: f9506661     	ldr	x1, [x19, #0x20c8]
  793bfc: f9407682     	ldr	x2, [x20, #0xe8]
  793c00: aa0103e0     	mov	x0, x1
  793c04: f9400021     	ldr	x1, [x1]
  793c08: bd514040     	ldr	s0, [x2, #0x1140]
  793c0c: f9404021     	ldr	x1, [x1, #0x80]
  793c10: d63f0020     	blr	x1
  793c14: f9505a64     	ldr	x4, [x19, #0x20b0]
  793c18: 52800003     	mov	w3, #0x0                // =0
  793c1c: 52808f22     	mov	w2, #0x479              // =1145
