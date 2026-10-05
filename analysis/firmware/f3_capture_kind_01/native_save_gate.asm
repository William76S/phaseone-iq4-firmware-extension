
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
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
