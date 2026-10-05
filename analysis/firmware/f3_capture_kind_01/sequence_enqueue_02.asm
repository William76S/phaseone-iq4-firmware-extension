
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  79cb08: a9b67bfd     	stp	x29, x30, [sp, #-0xa0]!
  79cb0c: d283fa0b     	mov	x11, #0x1fd0            // =8144
  79cb10: 910003fd     	mov	x29, sp
  79cb14: a90153f3     	stp	x19, x20, [sp, #0x10]
  79cb18: aa0003f3     	mov	x19, x0
  79cb1c: a9025bf5     	stp	x21, x22, [sp, #0x20]
  79cb20: aa0103f6     	mov	x22, x1
  79cb24: 8b0b0001     	add	x1, x0, x11
  79cb28: eb0102df     	cmp	x22, x1
  79cb2c: 54002100     	b.eq	0x79cf4c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83220>
  79cb30: d283280a     	mov	x10, #0x1940            // =6464
  79cb34: 8b0a0275     	add	x21, x19, x10
  79cb38: 91402274     	add	x20, x19, #0x8, lsl #12 // =0x8000
  79cb3c: eb1602bf     	cmp	x21, x22
  79cb40: 54001ee0     	b.eq	0x79cf1c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x831f0>
  79cb44: f9407680     	ldr	x0, [x20, #0xe8]
  79cb48: d2821109     	mov	x9, #0x1088             // =4232
  79cb4c: 8b090001     	add	x1, x0, x9
  79cb50: eb0102df     	cmp	x22, x1
  79cb54: 54000220     	b.eq	0x79cb98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e6c>
  79cb58: 394b0260     	ldrb	w0, [x19, #0x2c0]
  79cb5c: 340002e0     	cbz	w0, 0x79cbb8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e8c>
  79cb60: f9504e60     	ldr	x0, [x19, #0x2098]
  79cb64: b4000400     	cbz	x0, 0x79cbe4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82eb8>
  79cb68: 91230276     	add	x22, x19, #0x8c0
  79cb6c: 394302c0     	ldrb	w0, [x22, #0xc0]
  79cb70: 340000c0     	cbz	w0, 0x79cb88 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e5c>
  79cb74: a90363f7     	stp	x23, x24, [sp, #0x30]
  79cb78: 911fa277     	add	x23, x19, #0x7e8
  79cb7c: 394302e0     	ldrb	w0, [x23, #0xc0]
  79cb80: 350006c0     	cbnz	w0, 0x79cc58 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f2c>
  79cb84: a94363f7     	ldp	x23, x24, [sp, #0x30]
  79cb88: a94153f3     	ldp	x19, x20, [sp, #0x10]
  79cb8c: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  79cb90: a8ca7bfd     	ldp	x29, x30, [sp], #0xa0
  79cb94: d65f03c0     	ret
  79cb98: f9506661     	ldr	x1, [x19, #0x20c8]
  79cb9c: bd514000     	ldr	s0, [x0, #0x1140]
  79cba0: aa0103e0     	mov	x0, x1
  79cba4: f9400021     	ldr	x1, [x1]
  79cba8: f9404021     	ldr	x1, [x1, #0x80]
  79cbac: d63f0020     	blr	x1
  79cbb0: 394b0260     	ldrb	w0, [x19, #0x2c0]
  79cbb4: 35fffd60     	cbnz	w0, 0x79cb60 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e34>
  79cbb8: 52807a62     	mov	w2, #0x3d3              // =979
  79cbbc: 52800040     	mov	w0, #0x2                // =2
  79cbc0: 90002ec3     	adrp	x3, 0xd74000
  79cbc4: f0002ea1     	adrp	x1, 0xd73000
  79cbc8: 9115c063     	add	x3, x3, #0x570
  79cbcc: 9110a021     	add	x1, x1, #0x428
  79cbd0: 97fea65f     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  79cbd4: a94153f3     	ldp	x19, x20, [sp, #0x10]
  79cbd8: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  79cbdc: a8ca7bfd     	ldp	x29, x30, [sp], #0xa0
  79cbe0: d65f03c0     	ret
  79cbe4: f9504a60     	ldr	x0, [x19, #0x2090]
  79cbe8: f9413000     	ldr	x0, [x0, #0x260]
  79cbec: eb0002df     	cmp	x22, x0
  79cbf0: 54fffbc1     	b.ne	0x79cb68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e3c>
  79cbf4: aa1303e0     	mov	x0, x19
  79cbf8: 97ffed74     	bl	0x7981c8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7e49c>
  79cbfc: 72001c1f     	tst	w0, #0xff
  79cc00: 54fffb40     	b.eq	0x79cb68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e3c>
  79cc04: f9504a60     	ldr	x0, [x19, #0x2090]
  79cc08: 9404a2fa     	bl	0x8c57f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1efc4>
  79cc0c: f9104e60     	str	x0, [x19, #0x2098]
  79cc10: b4003920     	cbz	x0, 0x79d334 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83608>
  79cc14: a90363f7     	stp	x23, x24, [sp, #0x30]
  79cc18: 911fa277     	add	x23, x19, #0x7e8
  79cc1c: b940c6e0     	ldr	w0, [x23, #0xc4]
  79cc20: 7100041f     	cmp	w0, #0x1
  79cc24: 54000061     	b.ne	0x79cc30 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f04>
  79cc28: 394302e0     	ldrb	w0, [x23, #0xc0]
  79cc2c: 350000e0     	cbnz	w0, 0x79cc48 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f1c>
  79cc30: 52800020     	mov	w0, #0x1                // =1
  79cc34: 390302e0     	strb	w0, [x23, #0xc0]
  79cc38: 911fc260     	add	x0, x19, #0x7f0
  79cc3c: 97fdc9af     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cc40: a94363f7     	ldp	x23, x24, [sp, #0x30]
  79cc44: 17ffffc9     	b	0x79cb68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e3c>
  79cc48: 91230276     	add	x22, x19, #0x8c0
  79cc4c: 394302c0     	ldrb	w0, [x22, #0xc0]
  79cc50: 34fff9a0     	cbz	w0, 0x79cb84 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e58>
  79cc54: d503201f     	nop
  79cc58: a90573fb     	stp	x27, x28, [sp, #0x50]
  79cc5c: 9001b89c     	adrp	x28, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  79cc60: 912c4398     	add	x24, x28, #0xb10
  79cc64: a9046bf9     	stp	x25, x26, [sp, #0x40]
  79cc68: 9106a27a     	add	x26, x19, #0x1a8
  79cc6c: aa1a03e0     	mov	x0, x26
  79cc70: 97fdd530     	bl	0x712130 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x240b0>
  79cc74: 3940e700     	ldrb	w0, [x24, #0x39]
  79cc78: 35002820     	cbnz	w0, 0x79d17c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83450>
  79cc7c: b940c6e0     	ldr	w0, [x23, #0xc4]
  79cc80: 7100041f     	cmp	w0, #0x1
  79cc84: 54000061     	b.ne	0x79cc90 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f64>
  79cc88: 394302e0     	ldrb	w0, [x23, #0xc0]
  79cc8c: 34000080     	cbz	w0, 0x79cc9c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f70>
  79cc90: 390302ff     	strb	wzr, [x23, #0xc0]
  79cc94: 911fc260     	add	x0, x19, #0x7f0
  79cc98: 97fdc998     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cc9c: 91400a7b     	add	x27, x19, #0x2, lsl #12 // =0x2000
  79cca0: 39422360     	ldrb	w0, [x27, #0x88]
  79cca4: 34002660     	cbz	w0, 0x79d170 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83444>
  79cca8: 39444e80     	ldrb	w0, [x20, #0x113]
  79ccac: 340002a0     	cbz	w0, 0x79cd00 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82fd4>
  79ccb0: 91158260     	add	x0, x19, #0x560
  79ccb4: b940c401     	ldr	w1, [x0, #0xc4]
  79ccb8: 7100043f     	cmp	w1, #0x1
  79ccbc: 54000061     	b.ne	0x79ccc8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f9c>
  79ccc0: 39430001     	ldrb	w1, [x0, #0xc0]
  79ccc4: 350000a1     	cbnz	w1, 0x79ccd8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82fac>
  79ccc8: 52800021     	mov	w1, #0x1                // =1
  79cccc: 39030001     	strb	w1, [x0, #0xc0]
  79ccd0: 9115a260     	add	x0, x19, #0x568
  79ccd4: 97fdc989     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79ccd8: 52800001     	mov	w1, #0x0                // =0
  79ccdc: aa1303e0     	mov	x0, x19
  79cce0: 97ffd81e     	bl	0x792d58 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7902c>
  79cce4: f9506661     	ldr	x1, [x19, #0x20c8]
  79cce8: aa0103e0     	mov	x0, x1
  79ccec: f9400021     	ldr	x1, [x1]
  79ccf0: f9405c21     	ldr	x1, [x1, #0xb8]
  79ccf4: d63f0020     	blr	x1
  79ccf8: 52800020     	mov	w0, #0x1                // =1
  79ccfc: 39044a80     	strb	w0, [x20, #0x112]
  79cd00: 97fde961     	bl	0x717284 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29204>
  79cd04: f9505660     	ldr	x0, [x19, #0x20a8]
  79cd08: 97ff9536     	bl	0x7821e0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x684b4>
  79cd0c: aa1303e0     	mov	x0, x19
  79cd10: 97ffe138     	bl	0x7951f0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7b4c4>
  79cd14: aa1303e0     	mov	x0, x19
  79cd18: 97ffe2ea     	bl	0x7958c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7bb94>
  79cd1c: aa1503e0     	mov	x0, x21
  79cd20: 97fde315     	bl	0x715974 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x278f4>
  79cd24: 39445a80     	ldrb	w0, [x20, #0x116]
  79cd28: 34002920     	cbz	w0, 0x79d24c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83520>
  79cd2c: 912d2279     	add	x25, x19, #0xb48
  79cd30: b9413280     	ldr	w0, [x20, #0x130]
  79cd34: b90073e0     	str	w0, [sp, #0x70]
  79cd38: b9413680     	ldr	w0, [x20, #0x134]
  79cd3c: b9006fe0     	str	w0, [sp, #0x6c]
  79cd40: b940c720     	ldr	w0, [x25, #0xc4]
  79cd44: 7100041f     	cmp	w0, #0x1
  79cd48: 54000061     	b.ne	0x79cd54 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83028>
  79cd4c: 39430320     	ldrb	w0, [x25, #0xc0]
  79cd50: 34000080     	cbz	w0, 0x79cd60 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83034>
  79cd54: 3903033f     	strb	wzr, [x25, #0xc0]
  79cd58: 912d4260     	add	x0, x19, #0xb50
  79cd5c: 97fdc967     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cd60: 91400660     	add	x0, x19, #0x1, lsl #12  // =0x1000
  79cd64: b941ec02     	ldr	w2, [x0, #0x1ec]
  79cd68: 7100045f     	cmp	w2, #0x1
  79cd6c: 54000061     	b.ne	0x79cd78 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8304c>
  79cd70: 3947a001     	ldrb	w1, [x0, #0x1e8]
  79cd74: 340000a1     	cbz	w1, 0x79cd88 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8305c>
  79cd78: d2822608     	mov	x8, #0x1130             // =4400
  79cd7c: 3907a01f     	strb	wzr, [x0, #0x1e8]
  79cd80: 8b080260     	add	x0, x19, x8
  79cd84: 97fdc95d     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cd88: aa1303e0     	mov	x0, x19
  79cd8c: 97ffdd1b     	bl	0x7941f8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7a4cc>
  79cd90: aa1303e0     	mov	x0, x19
  79cd94: 97fffd8d     	bl	0x79c3c8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8269c>
  79cd98: f9407e81     	ldr	x1, [x20, #0xf8]
  79cd9c: 395c2360     	ldrb	w0, [x27, #0x708]
  79cda0: 39468022     	ldrb	w2, [x1, #0x1a0]
  79cda4: 52000000     	eor	w0, w0, #0x1
  79cda8: 34000f62     	cbz	w2, 0x79cf94 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83268>
  79cdac: 34000f60     	cbz	w0, 0x79cf98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8326c>
  79cdb0: 39430320     	ldrb	w0, [x25, #0xc0]
  79cdb4: 35000f20     	cbnz	w0, 0x79cf98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8326c>
  79cdb8: 3976c020     	ldrb	w0, [x1, #0xdb0]
  79cdbc: 35000ee0     	cbnz	w0, 0x79cf98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8326c>
  79cdc0: f947b260     	ldr	x0, [x19, #0xf60]
  79cdc4: 90ffe3c1     	adrp	x1, 0x414000 <.text+0x8dd0>
  79cdc8: 912ca021     	add	x1, x1, #0xb28
  79cdcc: f9400002     	ldr	x2, [x0]
  79cdd0: f9402043     	ldr	x3, [x2, #0x40]
  79cdd4: eb01007f     	cmp	x3, x1
  79cdd8: 54002a41     	b.ne	0x79d320 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x835f4>
  79cddc: b940c003     	ldr	w3, [x0, #0xc0]
  79cde0: f9402442     	ldr	x2, [x2, #0x48]
  79cde4: 11000463     	add	w3, w3, #0x1
  79cde8: b90077e3     	str	w3, [sp, #0x74]
  79cdec: f0ffe3c1     	adrp	x1, 0x417000 <.text+0xbdd0>
  79cdf0: 9116a021     	add	x1, x1, #0x5a8
  79cdf4: eb01005f     	cmp	x2, x1
  79cdf8: 540028e1     	b.ne	0x79d314 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x835e8>
  79cdfc: b940c801     	ldr	w1, [x0, #0xc8]
  79ce00: 7100043f     	cmp	w1, #0x1
  79ce04: 54000081     	b.ne	0x79ce14 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x830e8>
  79ce08: b940c001     	ldr	w1, [x0, #0xc0]
  79ce0c: 6b01007f     	cmp	w3, w1
  79ce10: 540000a0     	b.eq	0x79ce24 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x830f8>
  79ce14: b94077e1     	ldr	w1, [sp, #0x74]
  79ce18: 91002000     	add	x0, x0, #0x8
  79ce1c: b900b801     	str	w1, [x0, #0xb8]
  79ce20: 97fdc936     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79ce24: b94077e1     	ldr	w1, [sp, #0x74]
  79ce28: f9506e60     	ldr	x0, [x19, #0x20d8]
  79ce2c: b9233261     	str	w1, [x19, #0x2330]
  79ce30: 9400102b     	bl	0x7a0edc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x871b0>
  79ce34: f94fe660     	ldr	x0, [x19, #0x1fc8]
  79ce38: 97fdc139     	bl	0x70d31c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1f29c>
  79ce3c: f9504e61     	ldr	x1, [x19, #0x2098]
  79ce40: 910243e0     	add	x0, sp, #0x90
  79ce44: 97f3e0a9     	bl	0x4950e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f13c>
  79ce48: f9404fe0     	ldr	x0, [sp, #0x98]
  79ce4c: f9504e79     	ldr	x25, [x19, #0x2098]
  79ce50: f940201b     	ldr	x27, [x0, #0x40]
  79ce54: b40025d9     	cbz	x25, 0x79d30c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x835e0>
  79ce58: aa1903e0     	mov	x0, x25
  79ce5c: 940495b8     	bl	0x8c253c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd10>
  79ce60: aa1903e0     	mov	x0, x25
  79ce64: 9404963b     	bl	0x8c2750 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bf24>
  79ce68: f9402000     	ldr	x0, [x0, #0x40]
  79ce6c: d2844f07     	mov	x7, #0x2278             // =8824
  79ce70: d2849d02     	mov	x2, #0x24e8             // =9448
  79ce74: 8b070261     	add	x1, x19, x7
  79ce78: 97fdcf4e     	bl	0x710bb0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22b30>
  79ce7c: d2841c06     	mov	x6, #0x20e0             // =8416
  79ce80: 52800041     	mov	w1, #0x2                // =2
  79ce84: 8b060260     	add	x0, x19, x6
  79ce88: f9003fe0     	str	x0, [sp, #0x78]
  79ce8c: 97ff8dcd     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  79ce90: b9631662     	ldr	w2, [x19, #0x2314]
  79ce94: 52800061     	mov	w1, #0x3                // =3
  79ce98: 8b020000     	add	x0, x0, x2
  79ce9c: f9000360     	str	x0, [x27]
  79cea0: f9403fe0     	ldr	x0, [sp, #0x78]
  79cea4: 97ff8dc7     	bl	0x7805c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x66894>
  79cea8: b9631e62     	ldr	w2, [x19, #0x231c]
  79ceac: 9140b361     	add	x1, x27, #0x2c, lsl #12 // =0x2c000
  79ceb0: 8b020000     	add	x0, x0, x2
  79ceb4: f9000760     	str	x0, [x27, #0x8]
  79ceb8: aa0103e0     	mov	x0, x1
  79cebc: b94077e1     	ldr	w1, [sp, #0x74]
  79cec0: b9631a62     	ldr	w2, [x19, #0x2318]
  79cec4: b9188802     	str	w2, [x0, #0x1888]
  79cec8: b9188c01     	str	w1, [x0, #0x188c]
  79cecc: f9407e80     	ldr	x0, [x20, #0xf8]
  79ced0: b9548804     	ldr	w4, [x0, #0x1488]
  79ced4: 34001e64     	cbz	w4, 0x79d2a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83574>
  79ced8: 294d8fe2     	ldp	w2, w3, [sp, #0x6c]
  79cedc: aa1b03e1     	mov	x1, x27
  79cee0: aa1303e0     	mov	x0, x19
  79cee4: 97ffeabd     	bl	0x7979d8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7dcac>
  79cee8: b40000b9     	cbz	x25, 0x79cefc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x831d0>
  79ceec: aa1903e0     	mov	x0, x25
  79cef0: 9404963c     	bl	0x8c27e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bfb4>
  79cef4: aa1903e0     	mov	x0, x25
  79cef8: 9404959c     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  79cefc: f9404be0     	ldr	x0, [sp, #0x90]
  79cf00: b4000540     	cbz	x0, 0x79cfa8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8327c>
  79cf04: f9404fe1     	ldr	x1, [sp, #0x98]
  79cf08: b4000061     	cbz	x1, 0x79cf14 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x831e8>
  79cf0c: 940495d7     	bl	0x8c2668 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be3c>
  79cf10: f9404be0     	ldr	x0, [sp, #0x90]
  79cf14: 94049595     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  79cf18: 14000024     	b	0x79cfa8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8327c>
  79cf1c: 39445a80     	ldrb	w0, [x20, #0x116]
  79cf20: 34ffe340     	cbz	w0, 0x79cb88 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e5c>
  79cf24: aa1603e0     	mov	x0, x22
  79cf28: 97fde293     	bl	0x715974 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x278f4>
  79cf2c: f9505660     	ldr	x0, [x19, #0x20a8]
  79cf30: 52800021     	mov	w1, #0x1                // =1
  79cf34: 97ff94bd     	bl	0x782228 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x684fc>
  79cf38: aa1303e0     	mov	x0, x19
  79cf3c: 52800001     	mov	w1, #0x0                // =0
  79cf40: 97fffe02     	bl	0x79c748 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82a1c>
  79cf44: 39045a9f     	strb	wzr, [x20, #0x116]
  79cf48: 17ffff10     	b	0x79cb88 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e5c>
  79cf4c: 97ffda9d     	bl	0x7939c0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79c94>
  79cf50: aa1303e0     	mov	x0, x19
  79cf54: 97ffdb81     	bl	0x793d58 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7a02c>
  79cf58: 91080260     	add	x0, x19, #0x200
  79cf5c: b940c401     	ldr	w1, [x0, #0xc4]
  79cf60: 7100043f     	cmp	w1, #0x1
  79cf64: 54000061     	b.ne	0x79cf70 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83244>
  79cf68: 39430001     	ldrb	w1, [x0, #0xc0]
  79cf6c: 350000a1     	cbnz	w1, 0x79cf80 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83254>
  79cf70: 52800021     	mov	w1, #0x1                // =1
  79cf74: 39030001     	strb	w1, [x0, #0xc0]
  79cf78: 91082260     	add	x0, x19, #0x208
  79cf7c: 97fdc8df     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cf80: 910b8260     	add	x0, x19, #0x2e0
  79cf84: 97fdc8dd     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cf88: 91124260     	add	x0, x19, #0x490
  79cf8c: 97fdc8db     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cf90: 17fffee8     	b	0x79cb30 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e04>
  79cf94: 35000d40     	cbnz	w0, 0x79d13c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83410>
  79cf98: b94073e0     	ldr	w0, [sp, #0x70]
  79cf9c: b9013280     	str	w0, [x20, #0x130]
  79cfa0: b9406fe0     	ldr	w0, [sp, #0x6c]
  79cfa4: b9013680     	str	w0, [x20, #0x134]
  79cfa8: 39444a80     	ldrb	w0, [x20, #0x112]
  79cfac: 350000c0     	cbnz	w0, 0x79cfc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83298>
  79cfb0: f9506260     	ldr	x0, [x19, #0x20c0]
  79cfb4: 97f2c334     	bl	0x44dc84 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x17cd8>
  79cfb8: 39445a81     	ldrb	w1, [x20, #0x116]
  79cfbc: 12001c00     	and	w0, w0, #0xff
  79cfc0: 35000b41     	cbnz	w1, 0x79d128 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x833fc>
  79cfc4: 97fde8b0     	bl	0x717284 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29204>
  79cfc8: f9506e60     	ldr	x0, [x19, #0x20d8]
  79cfcc: 94000fe5     	bl	0x7a0f60 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87234>
  79cfd0: 9129c260     	add	x0, x19, #0xa70
  79cfd4: b940c401     	ldr	w1, [x0, #0xc4]
  79cfd8: 7100043f     	cmp	w1, #0x1
  79cfdc: 54000061     	b.ne	0x79cfe8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x832bc>
  79cfe0: 39430001     	ldrb	w1, [x0, #0xc0]
  79cfe4: 350000a1     	cbnz	w1, 0x79cff8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x832cc>
  79cfe8: 52800021     	mov	w1, #0x1                // =1
  79cfec: 39030001     	strb	w1, [x0, #0xc0]
  79cff0: 9129e260     	add	x0, x19, #0xa78
  79cff4: 97fdc8c1     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79cff8: 91266260     	add	x0, x19, #0x998
  79cffc: b940c401     	ldr	w1, [x0, #0xc4]
  79d000: 7100043f     	cmp	w1, #0x1
  79d004: 54000061     	b.ne	0x79d010 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x832e4>
  79d008: 39430001     	ldrb	w1, [x0, #0xc0]
  79d00c: 34000081     	cbz	w1, 0x79d01c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x832f0>
  79d010: 3903001f     	strb	wzr, [x0, #0xc0]
  79d014: 91268260     	add	x0, x19, #0x9a0
  79d018: 97fdc8b8     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79d01c: b940c6c0     	ldr	w0, [x22, #0xc4]
  79d020: 7100041f     	cmp	w0, #0x1
  79d024: 54000061     	b.ne	0x79d030 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83304>
  79d028: 394302c0     	ldrb	w0, [x22, #0xc0]
  79d02c: 34000080     	cbz	w0, 0x79d03c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83310>
  79d030: 390302df     	strb	wzr, [x22, #0xc0]
  79d034: 91232260     	add	x0, x19, #0x8c8
  79d038: 97fdc8b0     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79d03c: f9407a81     	ldr	x1, [x20, #0xf0]
  79d040: 0f000400     	movi	v0.2s, #0x0
  79d044: d2800000     	mov	x0, #0x0                // =0
  79d048: b96aa022     	ldr	w2, [x1, #0x2aa0]
  79d04c: 7100045f     	cmp	w2, #0x1
  79d050: 540000a1     	b.ne	0x79d064 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83338>
  79d054: b96a8023     	ldr	w3, [x1, #0x2a80]
  79d058: d2854004     	mov	x4, #0x2a00             // =10752
  79d05c: 8b040022     	add	x2, x1, x4
  79d060: 340007a3     	cbz	w3, 0x79d154 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83428>
  79d064: fd0043e0     	str	d0, [sp, #0x80]
  79d068: d2855002     	mov	x2, #0x2a80             // =10880
  79d06c: f90047e0     	str	x0, [sp, #0x88]
  79d070: 8b020022     	add	x2, x1, x2
  79d074: fd154020     	str	d0, [x1, #0x2a80]
  79d078: d2853903     	mov	x3, #0x29c8             // =10696
  79d07c: 8b030020     	add	x0, x1, x3
  79d080: f84853e1     	ldur	x1, [sp, #0x85]
  79d084: f8005041     	stur	x1, [x2, #0x5]
  79d088: 97fdc89c     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79d08c: aa1303e0     	mov	x0, x19
  79d090: 97ffec4e     	bl	0x7981c8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7e49c>
  79d094: 72001c1f     	tst	w0, #0xff
  79d098: f9504e60     	ldr	x0, [x19, #0x2098]
  79d09c: 54000320     	b.eq	0x79d100 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x833d4>
  79d0a0: b40002a0     	cbz	x0, 0x79d0f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x833c8>
  79d0a4: b940c6e0     	ldr	w0, [x23, #0xc4]
  79d0a8: 7100041f     	cmp	w0, #0x1
  79d0ac: 54000061     	b.ne	0x79d0b8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8338c>
  79d0b0: 394302e0     	ldrb	w0, [x23, #0xc0]
  79d0b4: 350000a0     	cbnz	w0, 0x79d0c8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8339c>
  79d0b8: 52800020     	mov	w0, #0x1                // =1
  79d0bc: 390302e0     	strb	w0, [x23, #0xc0]
  79d0c0: 911fc260     	add	x0, x19, #0x7f0
  79d0c4: 97fdc88d     	bl	0x70f2f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21278>
  79d0c8: 3940e700     	ldrb	w0, [x24, #0x39]
  79d0cc: 350008c0     	cbnz	w0, 0x79d1e4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x834b8>
  79d0d0: aa1a03e0     	mov	x0, x26
  79d0d4: 97fdd44c     	bl	0x712204 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24184>
  79d0d8: a94153f3     	ldp	x19, x20, [sp, #0x10]
  79d0dc: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  79d0e0: a94363f7     	ldp	x23, x24, [sp, #0x30]
  79d0e4: a9446bf9     	ldp	x25, x26, [sp, #0x40]
  79d0e8: a94573fb     	ldp	x27, x28, [sp, #0x50]
  79d0ec: a8ca7bfd     	ldp	x29, x30, [sp], #0xa0
  79d0f0: d65f03c0     	ret
  79d0f4: f9504a60     	ldr	x0, [x19, #0x2090]
  79d0f8: 9404a1be     	bl	0x8c57f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1efc4>
  79d0fc: f9104e60     	str	x0, [x19, #0x2098]
  79d100: b5fffd20     	cbnz	x0, 0x79d0a4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83378>
  79d104: 97fde852     	bl	0x71724c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x291cc>
  79d108: 2a0003e3     	mov	w3, w0
  79d10c: f0002ea2     	adrp	x2, 0xd74000
  79d110: d0002ea0     	adrp	x0, 0xd73000
  79d114: 9117e042     	add	x2, x2, #0x5f8
  79d118: 9110a000     	add	x0, x0, #0x428
  79d11c: 528091c1     	mov	w1, #0x48e              // =1166
  79d120: 97fea4df     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  79d124: 17ffffe9     	b	0x79d0c8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8339c>
  79d128: 34000a80     	cbz	w0, 0x79d278 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8354c>
  79d12c: aa1503e0     	mov	x0, x21
  79d130: 52807d01     	mov	w1, #0x3e8              // =1000
  79d134: 97fde205     	bl	0x715948 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x278c8>
  79d138: 17ffffa3     	b	0x79cfc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83298>
  79d13c: 39430320     	ldrb	w0, [x25, #0xc0]
  79d140: 35fff2c0     	cbnz	w0, 0x79cf98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8326c>
  79d144: b966fe60     	ldr	w0, [x19, #0x26fc]
  79d148: 7100141f     	cmp	w0, #0x5
  79d14c: 54ffe3a1     	b.ne	0x79cdc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83094>
  79d150: 17ffff92     	b	0x79cf98 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8326c>
  79d154: b96a8423     	ldr	w3, [x1, #0x2a84]
  79d158: 35fff863     	cbnz	w3, 0x79d064 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83338>
  79d15c: b96a8823     	ldr	w3, [x1, #0x2a88]
  79d160: 35fff823     	cbnz	w3, 0x79d064 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83338>
  79d164: 39423042     	ldrb	w2, [x2, #0x8c]
  79d168: 35fff7e2     	cbnz	w2, 0x79d064 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83338>
  79d16c: 17ffffc8     	b	0x79d08c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83360>
  79d170: aa1303e0     	mov	x0, x19
  79d174: 97ffdaf9     	bl	0x793d58 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x7a02c>
  79d178: 17fffecc     	b	0x79cca8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f7c>
  79d17c: f001b879     	adrp	x25, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  79d180: 912cd339     	add	x25, x25, #0xb34
  79d184: 885fff3b     	ldaxr	w27, [x25]
  79d188: 11000760     	add	w0, w27, #0x1
  79d18c: 8801ff20     	stlxr	w1, w0, [x25]
  79d190: 35ffffa1     	cbnz	w1, 0x79d184 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83458>
  79d194: b9402300     	ldr	w0, [x24, #0x20]
  79d198: 6b00037f     	cmp	w27, w0
  79d19c: 540005e2     	b.hs	0x79d258 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8352c>
  79d1a0: 97fde839     	bl	0x717284 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29204>
  79d1a4: f9458b85     	ldr	x5, [x28, #0xb10]
  79d1a8: 2a1b03fb     	mov	w27, w27
  79d1ac: a9408f04     	ldp	x4, x3, [x24, #0x8]
  79d1b0: 12185c01     	and	w1, w0, #0xffffff00
  79d1b4: b83b78a0     	str	w0, [x5, x27, lsl #2]
  79d1b8: f0002ea2     	adrp	x2, 0xd74000
  79d1bc: 52801340     	mov	w0, #0x9a               // =154
  79d1c0: 9117a042     	add	x2, x2, #0x5e8
  79d1c4: 2a000021     	orr	w1, w1, w0
  79d1c8: f83b7882     	str	x2, [x4, x27, lsl #3]
  79d1cc: b83b7861     	str	w1, [x3, x27, lsl #2]
  79d1d0: 97fdce89     	bl	0x710bf4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22b74>
  79d1d4: f9400f01     	ldr	x1, [x24, #0x18]
  79d1d8: 88dfff22     	ldar	w2, [x25]
  79d1dc: 38224820     	strb	w0, [x1, w2, uxtw]
  79d1e0: 17fffea7     	b	0x79cc7c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f50>
  79d1e4: f001b879     	adrp	x25, 0x3eac000 <_ZNSt5ctypeIcE2idE+0x2f48ed8>
  79d1e8: 912cd339     	add	x25, x25, #0xb34
  79d1ec: 885fff33     	ldaxr	w19, [x25]
  79d1f0: 11000660     	add	w0, w19, #0x1
  79d1f4: 8801ff20     	stlxr	w1, w0, [x25]
  79d1f8: 35ffffa1     	cbnz	w1, 0x79d1ec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x834c0>
  79d1fc: b9402300     	ldr	w0, [x24, #0x20]
  79d200: 6b00027f     	cmp	w19, w0
  79d204: 54000322     	b.hs	0x79d268 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8353c>
  79d208: 97fde81f     	bl	0x717284 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x29204>
  79d20c: f9458b85     	ldr	x5, [x28, #0xb10]
  79d210: 2a1303f3     	mov	w19, w19
  79d214: a9408f04     	ldp	x4, x3, [x24, #0x8]
  79d218: 12185c01     	and	w1, w0, #0xffffff00
  79d21c: b83378a0     	str	w0, [x5, x19, lsl #2]
  79d220: f0002ea2     	adrp	x2, 0xd74000
  79d224: 52800340     	mov	w0, #0x1a               // =26
  79d228: 9117a042     	add	x2, x2, #0x5e8
  79d22c: 2a000021     	orr	w1, w1, w0
  79d230: f8337882     	str	x2, [x4, x19, lsl #3]
  79d234: b8337861     	str	w1, [x3, x19, lsl #2]
  79d238: 97fdce6f     	bl	0x710bf4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22b74>
  79d23c: f9400f01     	ldr	x1, [x24, #0x18]
  79d240: 88dfff22     	ldar	w2, [x25]
  79d244: 38224820     	strb	w0, [x1, w2, uxtw]
  79d248: 17ffffa2     	b	0x79d0d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x833a4>
  79d24c: aa1303e0     	mov	x0, x19
  79d250: 97fffdc0     	bl	0x79c950 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82c24>
  79d254: 17fffeb6     	b	0x79cd2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83000>
  79d258: 52800021     	mov	w1, #0x1                // =1
  79d25c: 3900e301     	strb	w1, [x24, #0x38]
  79d260: 889fff20     	stlr	w0, [x25]
  79d264: 17fffe86     	b	0x79cc7c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82f50>
  79d268: 52800021     	mov	w1, #0x1                // =1
  79d26c: 3900e301     	strb	w1, [x24, #0x38]
  79d270: 889fff20     	stlr	w0, [x25]
  79d274: 17ffff97     	b	0x79d0d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x833a4>
  79d278: aa1503e0     	mov	x0, x21
  79d27c: 97fde1be     	bl	0x715974 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x278f4>
  79d280: f9505660     	ldr	x0, [x19, #0x20a8]
  79d284: 52800021     	mov	w1, #0x1                // =1
  79d288: 97ff93e8     	bl	0x782228 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x684fc>
  79d28c: 52800001     	mov	w1, #0x0                // =0
  79d290: aa1303e0     	mov	x0, x19
  79d294: 97fffd2d     	bl	0x79c748 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82a1c>
  79d298: 39045a9f     	strb	wzr, [x20, #0x116]
  79d29c: 17ffff4a     	b	0x79cfc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83298>
  79d2a0: b9631661     	ldr	w1, [x19, #0x2314]
  79d2a4: 52800024     	mov	w4, #0x1                // =1
  79d2a8: b9631a62     	ldr	w2, [x19, #0x2318]
  79d2ac: 2a0403e3     	mov	w3, w4
  79d2b0: aa1303e0     	mov	x0, x19
  79d2b4: 97ffd827     	bl	0x793350 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x79624>
  79d2b8: 91404262     	add	x2, x19, #0x10, lsl #12 // =0x10000
  79d2bc: d2848005     	mov	x5, #0x2400             // =9216
  79d2c0: 8b050261     	add	x1, x19, x5
  79d2c4: f9504e63     	ldr	x3, [x19, #0x2098]
  79d2c8: b9496840     	ldr	w0, [x2, #0x968]
  79d2cc: f8514024     	ldur	x4, [x1, #-0xec]
  79d2d0: 11000405     	add	w5, w0, #0x1
  79d2d4: 7101dc1f     	cmp	w0, #0x77
  79d2d8: 54000069     	b.ls	0x79d2e4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x835b8>
  79d2dc: 52800025     	mov	w5, #0x1                // =1
  79d2e0: 52800000     	mov	w0, #0x0                // =0
  79d2e4: d37c7c00     	ubfiz	x0, x0, #4, #32
  79d2e8: aa0303e1     	mov	x1, x3
  79d2ec: 8b000260     	add	x0, x19, x0
  79d2f0: 91404000     	add	x0, x0, #0x10, lsl #12  // =0x10000
  79d2f4: a91e9003     	stp	x3, x4, [x0, #0x1e8]
  79d2f8: b9096845     	str	w5, [x2, #0x968]
  79d2fc: f9504a60     	ldr	x0, [x19, #0x2090]
  79d300: 9404a17a     	bl	0x8c58e8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f0bc>
  79d304: f9104e7f     	str	xzr, [x19, #0x2098]
  79d308: 17fffef8     	b	0x79cee8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x831bc>
  79d30c: d2800000     	mov	x0, #0x0                // =0
  79d310: 17fffed6     	b	0x79ce68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8313c>
  79d314: b94077e1     	ldr	w1, [sp, #0x74]
  79d318: d63f0040     	blr	x2
  79d31c: 17fffec2     	b	0x79ce24 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x830f8>
  79d320: d63f0060     	blr	x3
  79d324: 2a0003e3     	mov	w3, w0
  79d328: f947b260     	ldr	x0, [x19, #0xf60]
  79d32c: f9400002     	ldr	x2, [x0]
  79d330: 17fffeac     	b	0x79cde0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x830b4>
  79d334: f0002ea3     	adrp	x3, 0xd74000
  79d338: d0002ea1     	adrp	x1, 0xd73000
  79d33c: 91166063     	add	x3, x3, #0x598
  79d340: 9110a021     	add	x1, x1, #0x428
  79d344: 52807ce2     	mov	w2, #0x3e7              // =999
  79d348: 52800080     	mov	w0, #0x4                // =4
  79d34c: 97fea480     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  79d350: 17fffe06     	b	0x79cb68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x82e3c>
  79d354: aa0003f3     	mov	x19, x0
  79d358: b40000b9     	cbz	x25, 0x79d36c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83640>
  79d35c: aa1903e0     	mov	x0, x25
  79d360: 94049520     	bl	0x8c27e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bfb4>
  79d364: aa1903e0     	mov	x0, x25
  79d368: 94049480     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  79d36c: f9404be0     	ldr	x0, [sp, #0x90]
  79d370: b40000c0     	cbz	x0, 0x79d388 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8365c>
  79d374: f9404fe1     	ldr	x1, [sp, #0x98]
  79d378: b4000041     	cbz	x1, 0x79d380 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83654>
  79d37c: 940494bb     	bl	0x8c2668 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be3c>
  79d380: f9404be0     	ldr	x0, [sp, #0x90]
  79d384: 94049479     	bl	0x8c2568 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd3c>
  79d388: aa1a03e0     	mov	x0, x26
  79d38c: 97fdd39e     	bl	0x712204 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24184>
  79d390: aa1303e0     	mov	x0, x19
  79d394: 97f1b4ef     	bl	0x40a750 <_Unwind_Resume@plt>
  79d398: aa0003f3     	mov	x19, x0
  79d39c: 17fffff4     	b	0x79d36c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83640>
  79d3a0: aa0003f3     	mov	x19, x0
  79d3a4: 17fffff9     	b	0x79d388 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x8365c>
  79d3a8: a9b27bfd     	stp	x29, x30, [sp, #-0xe0]!
  79d3ac: 52800023     	mov	w3, #0x1                // =1
  79d3b0: 52800182     	mov	w2, #0xc                // =12
  79d3b4: 910003fd     	mov	x29, sp
  79d3b8: f90013f5     	str	x21, [sp, #0x20]
  79d3bc: 91402015     	add	x21, x0, #0x8, lsl #12  // =0x8000
  79d3c0: a90153f3     	stp	x19, x20, [sp, #0x10]
  79d3c4: 91401014     	add	x20, x0, #0x4, lsl #12  // =0x4000
  79d3c8: aa0003f3     	mov	x19, x0
  79d3cc: 39044abf     	strb	wzr, [x21, #0x112]
  79d3d0: 52800081     	mov	w1, #0x4                // =4
  79d3d4: b9476e84     	ldr	w4, [x20, #0x76c]
  79d3d8: f9506400     	ldr	x0, [x0, #0x20c8]
  79d3dc: 9401be39     	bl	0x80ccc0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x50cf8>
  79d3e0: 3dd1e660     	ldr	q0, [x19, #0x4790]
  79d3e4: d2890008     	mov	x8, #0x4800             // =18432
  79d3e8: 8b080260     	add	x0, x19, x8
  79d3ec: 9100c3e2     	add	x2, sp, #0x30
  79d3f0: 3c9a8000     	stur	q0, [x0, #-0x58]
  79d3f4: b9476e81     	ldr	w1, [x20, #0x76c]
  79d3f8: f9506260     	ldr	x0, [x19, #0x20c0]
  79d3fc: 97f2c56d     	bl	0x44e9b0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x18a04>
  79d400: b9476e80     	ldr	w0, [x20, #0x76c]
  79d404: 71000c1f     	cmp	w0, #0x3
  79d408: 54000260     	b.eq	0x79d454 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83728>
  79d40c: f9506661     	ldr	x1, [x19, #0x20c8]
  79d410: b94043e4     	ldr	w4, [sp, #0x40]
  79d414: b9479683     	ldr	w3, [x20, #0x794]
  79d418: aa0103e0     	mov	x0, x1
  79d41c: f9400022     	ldr	x2, [x1]
  79d420: 4b040063     	sub	w3, w3, w4
  79d424: b9403be4     	ldr	w4, [sp, #0x38]
  79d428: b9477a81     	ldr	w1, [x20, #0x778]
  79d42c: f9401845     	ldr	x5, [x2, #0x30]
  79d430: b9479a82     	ldr	w2, [x20, #0x798]
  79d434: 1b047c63     	mul	w3, w3, w4
  79d438: b9479e84     	ldr	w4, [x20, #0x79c]
  79d43c: 121f3863     	and	w3, w3, #0xfffe
  79d440: 11001084     	add	w4, w4, #0x4
  79d444: 121f3884     	and	w4, w4, #0xfffe
  79d448: d63f00a0     	blr	x5
  79d44c: b94043e0     	ldr	w0, [sp, #0x40]
  79d450: b907ae80     	str	w0, [x20, #0x7ac]
  79d454: f9506663     	ldr	x3, [x19, #0x20c8]
  79d458: 52800002     	mov	w2, #0x0                // =0
  79d45c: b9485e81     	ldr	w1, [x20, #0x85c]
  79d460: aa0303e0     	mov	x0, x3
  79d464: f9400063     	ldr	x3, [x3]
  79d468: f9400863     	ldr	x3, [x3, #0x10]
  79d46c: d63f0060     	blr	x3
  79d470: f9407aa0     	ldr	x0, [x21, #0xf0]
  79d474: b95ca261     	ldr	w1, [x19, #0x1ca0]
  79d478: b9662000     	ldr	w0, [x0, #0x2620]
  79d47c: 2a0103e2     	mov	w2, w1
  79d480: 34000480     	cbz	w0, 0x79d510 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x837e4>
  79d484: 7100c81f     	cmp	w0, #0x32
  79d488: 54001120     	b.eq	0x79d6ac <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x83980>
  79d48c: 8b020440     	add	x0, x2, x2, lsl #1
  79d490: d28c3504     	mov	x4, #0x61a8             // =25000
  79d494: d292d005     	mov	x5, #0x9680             // =38528
  79d498: 2a0403e3     	mov	w3, w4
  79d49c: f2a01305     	movk	x5, #0x98, lsl #16
