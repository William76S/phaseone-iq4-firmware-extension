
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8c2000: f9001fe0     	str	x0, [sp, #0x38]
  8c2004: 17ffffe5     	b	0x8c1f98 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1b76c>
  8c2008: d503201f     	nop
  8c200c: f9400bf3     	ldr	x19, [sp, #0x10]
  8c2010: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8c2014: d65f03c0     	ret
  8c2018: d10083ff     	sub	sp, sp, #0x20
  8c201c: f90007e0     	str	x0, [sp, #0x8]
  8c2020: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2024: 91098000     	add	x0, x0, #0x260
  8c2028: f9400000     	ldr	x0, [x0]
  8c202c: f9000fe0     	str	x0, [sp, #0x18]
  8c2030: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2034: f100001f     	cmp	x0, #0x0
  8c2038: 54000120     	b.eq	0x8c205c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1b830>
  8c203c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2040: b901181f     	str	wzr, [x0, #0x118]
  8c2044: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2048: 3900601f     	strb	wzr, [x0, #0x18]
  8c204c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2050: f9400800     	ldr	x0, [x0, #0x10]
  8c2054: f9000fe0     	str	x0, [sp, #0x18]
  8c2058: 17fffff6     	b	0x8c2030 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1b804>
  8c205c: d503201f     	nop
  8c2060: 910083ff     	add	sp, sp, #0x20
  8c2064: d65f03c0     	ret
  8c2068: d10043ff     	sub	sp, sp, #0x10
  8c206c: f90007e0     	str	x0, [sp, #0x8]
  8c2070: f94007e0     	ldr	x0, [sp, #0x8]
  8c2074: f9400400     	ldr	x0, [x0, #0x8]
  8c2078: 910043ff     	add	sp, sp, #0x10
  8c207c: d65f03c0     	ret
  8c2080: d10043ff     	sub	sp, sp, #0x10
  8c2084: f90007e0     	str	x0, [sp, #0x8]
  8c2088: f90003e1     	str	x1, [sp]
  8c208c: b0002780     	adrp	x0, 0xdb3000
  8c2090: 91390001     	add	x1, x0, #0xe40
  8c2094: f94007e0     	ldr	x0, [sp, #0x8]
  8c2098: f9000001     	str	x1, [x0]
  8c209c: f94007e0     	ldr	x0, [sp, #0x8]
  8c20a0: f94003e1     	ldr	x1, [sp]
  8c20a4: f9000401     	str	x1, [x0, #0x8]
  8c20a8: f94007e0     	ldr	x0, [sp, #0x8]
  8c20ac: f900081f     	str	xzr, [x0, #0x10]
  8c20b0: f94007e0     	ldr	x0, [sp, #0x8]
  8c20b4: b901181f     	str	wzr, [x0, #0x118]
  8c20b8: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c20bc: 91098000     	add	x0, x0, #0x260
  8c20c0: f9400001     	ldr	x1, [x0]
  8c20c4: f94007e0     	ldr	x0, [sp, #0x8]
  8c20c8: f9000801     	str	x1, [x0, #0x10]
  8c20cc: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c20d0: 91098000     	add	x0, x0, #0x260
  8c20d4: f94007e1     	ldr	x1, [sp, #0x8]
  8c20d8: f9000001     	str	x1, [x0]
  8c20dc: f94007e0     	ldr	x0, [sp, #0x8]
  8c20e0: 3900601f     	strb	wzr, [x0, #0x18]
  8c20e4: d503201f     	nop
  8c20e8: 910043ff     	add	sp, sp, #0x10
  8c20ec: d65f03c0     	ret
  8c20f0: d10043ff     	sub	sp, sp, #0x10
  8c20f4: f90007e0     	str	x0, [sp, #0x8]
  8c20f8: b0002780     	adrp	x0, 0xdb3000
  8c20fc: 91390001     	add	x1, x0, #0xe40
  8c2100: f94007e0     	ldr	x0, [sp, #0x8]
  8c2104: f9000001     	str	x1, [x0]
  8c2108: d503201f     	nop
  8c210c: 910043ff     	add	sp, sp, #0x10
  8c2110: d65f03c0     	ret
  8c2114: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2118: 910003fd     	mov	x29, sp
  8c211c: f9000fe0     	str	x0, [sp, #0x18]
  8c2120: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2124: 97fffff3     	bl	0x8c20f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1b8c4>
  8c2128: d2802401     	mov	x1, #0x120              // =288
  8c212c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2130: 97ed1f2c     	bl	0x409de0 <_ZdlPvm@plt>
  8c2134: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2138: d65f03c0     	ret
  8c213c: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  8c2140: 910003fd     	mov	x29, sp
  8c2144: f9000bf3     	str	x19, [sp, #0x10]
  8c2148: f9001fe0     	str	x0, [sp, #0x38]
  8c214c: f9001be1     	str	x1, [sp, #0x30]
  8c2150: b9002fe2     	str	w2, [sp, #0x2c]
  8c2154: 52800020     	mov	w0, #0x1                // =1
  8c2158: 39013fe0     	strb	w0, [sp, #0x4f]
  8c215c: b0002780     	adrp	x0, 0xdb3000
  8c2160: 91388000     	add	x0, x0, #0xe20
  8c2164: f90023e0     	str	x0, [sp, #0x40]
  8c2168: f9401be0     	ldr	x0, [sp, #0x30]
  8c216c: f100001f     	cmp	x0, #0x0
  8c2170: 54000160     	b.eq	0x8c219c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1b970>
  8c2174: b9402ff3     	ldr	w19, [sp, #0x2c]
  8c2178: f9401fe0     	ldr	x0, [sp, #0x38]
  8c217c: 97ffffbb     	bl	0x8c2068 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1b83c>
  8c2180: f94023e4     	ldr	x4, [sp, #0x40]
  8c2184: aa0003e3     	mov	x3, x0
  8c2188: b0002780     	adrp	x0, 0xdb3000
  8c218c: 9138a002     	add	x2, x0, #0xe28
  8c2190: aa1303e1     	mov	x1, x19
  8c2194: f9401be0     	ldr	x0, [sp, #0x30]
  8c2198: 97ed1f66     	bl	0x409f30 <snprintf@plt>
  8c219c: 39413fe0     	ldrb	w0, [sp, #0x4f]
  8c21a0: f9400bf3     	ldr	x19, [sp, #0x10]
  8c21a4: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  8c21a8: d65f03c0     	ret
  8c21ac: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8c21b0: 910003fd     	mov	x29, sp
  8c21b4: a90153f3     	stp	x19, x20, [sp, #0x10]
  8c21b8: f90017e0     	str	x0, [sp, #0x28]
  8c21bc: f94017e0     	ldr	x0, [sp, #0x28]
  8c21c0: 94000513     	bl	0x8c360c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cde0>
  8c21c4: d0002780     	adrp	x0, 0xdb4000
  8c21c8: 9104a001     	add	x1, x0, #0x128
  8c21cc: f94017e0     	ldr	x0, [sp, #0x28]
  8c21d0: f9000001     	str	x1, [x0]
  8c21d4: f94017e0     	ldr	x0, [sp, #0x28]
  8c21d8: b900201f     	str	wzr, [x0, #0x20]
  8c21dc: f94017e0     	ldr	x0, [sp, #0x28]
  8c21e0: 3900901f     	strb	wzr, [x0, #0x24]
  8c21e4: f94017e0     	ldr	x0, [sp, #0x28]
  8c21e8: 9101e000     	add	x0, x0, #0x78
  8c21ec: f94017e1     	ldr	x1, [sp, #0x28]
  8c21f0: 940004f4     	bl	0x8c35c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1cd94>
  8c21f4: f94017e0     	ldr	x0, [sp, #0x28]
  8c21f8: f900441f     	str	xzr, [x0, #0x88]
  8c21fc: f94017e0     	ldr	x0, [sp, #0x28]
  8c2200: f900481f     	str	xzr, [x0, #0x90]
  8c2204: f94017e0     	ldr	x0, [sp, #0x28]
  8c2208: f9004c1f     	str	xzr, [x0, #0x98]
  8c220c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2210: f900501f     	str	xzr, [x0, #0xa0]
  8c2214: f94017e0     	ldr	x0, [sp, #0x28]
  8c2218: f900541f     	str	xzr, [x0, #0xa8]
  8c221c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2220: f900581f     	str	xzr, [x0, #0xb0]
  8c2224: f94017e0     	ldr	x0, [sp, #0x28]
  8c2228: f9005c1f     	str	xzr, [x0, #0xb8]
  8c222c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2230: f900601f     	str	xzr, [x0, #0xc0]
  8c2234: f94017e0     	ldr	x0, [sp, #0x28]
  8c2238: f900641f     	str	xzr, [x0, #0xc8]
  8c223c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2240: f900681f     	str	xzr, [x0, #0xd0]
  8c2244: f94017e0     	ldr	x0, [sp, #0x28]
  8c2248: 12800001     	mov	w1, #-0x1               // =-1
  8c224c: b900d801     	str	w1, [x0, #0xd8]
  8c2250: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2254: 9109a000     	add	x0, x0, #0x268
  8c2258: f9400000     	ldr	x0, [x0]
  8c225c: f100001f     	cmp	x0, #0x0
  8c2260: 54000141     	b.ne	0x8c2288 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ba5c>
  8c2264: 52800203     	mov	w3, #0x10               // =16
  8c2268: b0002780     	adrp	x0, 0xdb3000
  8c226c: 913aa002     	add	x2, x0, #0xea8
  8c2270: b0002780     	adrp	x0, 0xdb3000
  8c2274: 913b4001     	add	x1, x0, #0xed0
  8c2278: b0002780     	adrp	x0, 0xdb3000
  8c227c: 913b8000     	add	x0, x0, #0xee0
  8c2280: 97ed20c0     	bl	0x40a580 <printf@plt>
  8c2284: 97faa921     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2288: f94017e0     	ldr	x0, [sp, #0x28]
  8c228c: f94017e1     	ldr	x1, [sp, #0x28]
  8c2290: 94000503     	bl	0x8c369c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ce70>
  8c2294: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2298: 9109c000     	add	x0, x0, #0x270
  8c229c: b9400000     	ldr	w0, [x0]
  8c22a0: 11000402     	add	w2, w0, #0x1
  8c22a4: d001c9c1     	adrp	x1, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c22a8: 9109c021     	add	x1, x1, #0x270
  8c22ac: b9000022     	str	w2, [x1]
  8c22b0: f94017e1     	ldr	x1, [sp, #0x28]
  8c22b4: b900dc20     	str	w0, [x1, #0xdc]
  8c22b8: d2800a00     	mov	x0, #0x50               // =80
  8c22bc: 97ed1ee9     	bl	0x409e60 <_Znwm@plt>
  8c22c0: aa0003f3     	mov	x19, x0
  8c22c4: aa1303e0     	mov	x0, x19
  8c22c8: 94001a08     	bl	0x8c8ae8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x222bc>
  8c22cc: f94017e0     	ldr	x0, [sp, #0x28]
  8c22d0: f9006813     	str	x19, [x0, #0xd0]
  8c22d4: f94017e0     	ldr	x0, [sp, #0x28]
  8c22d8: f9406800     	ldr	x0, [x0, #0xd0]
  8c22dc: f94017e1     	ldr	x1, [sp, #0x28]
  8c22e0: f9000801     	str	x1, [x0, #0x10]
  8c22e4: 1400000c     	b	0x8c2314 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bae8>
  8c22e8: aa0003f4     	mov	x20, x0
  8c22ec: d2800a01     	mov	x1, #0x50               // =80
  8c22f0: aa1303e0     	mov	x0, x19
  8c22f4: 97ed1ebb     	bl	0x409de0 <_ZdlPvm@plt>
  8c22f8: aa1403f3     	mov	x19, x20
  8c22fc: 14000002     	b	0x8c2304 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bad8>
  8c2300: aa0003f3     	mov	x19, x0
  8c2304: f94017e0     	ldr	x0, [sp, #0x28]
  8c2308: 940004cf     	bl	0x8c3644 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ce18>
  8c230c: aa1303e0     	mov	x0, x19
  8c2310: 97ed2110     	bl	0x40a750 <_Unwind_Resume@plt>
  8c2314: a94153f3     	ldp	x19, x20, [sp, #0x10]
  8c2318: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8c231c: d65f03c0     	ret
  8c2320: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2324: 910003fd     	mov	x29, sp
  8c2328: f9000fe0     	str	x0, [sp, #0x18]
  8c232c: d0002780     	adrp	x0, 0xdb4000
  8c2330: 9104a001     	add	x1, x0, #0x128
  8c2334: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2338: f9000001     	str	x1, [x0]
  8c233c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2340: 940004c1     	bl	0x8c3644 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ce18>
  8c2344: d503201f     	nop
  8c2348: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c234c: d65f03c0     	ret
  8c2350: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2354: 910003fd     	mov	x29, sp
  8c2358: f9000fe0     	str	x0, [sp, #0x18]
  8c235c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2360: 97fffff0     	bl	0x8c2320 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1baf4>
  8c2364: d2801c01     	mov	x1, #0xe0               // =224
  8c2368: f9400fe0     	ldr	x0, [sp, #0x18]
  8c236c: 97ed1e9d     	bl	0x409de0 <_ZdlPvm@plt>
  8c2370: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2374: d65f03c0     	ret
  8c2378: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8c237c: 910003fd     	mov	x29, sp
  8c2380: f9000bf3     	str	x19, [sp, #0x10]
  8c2384: f90017e0     	str	x0, [sp, #0x28]
  8c2388: 9100e3e0     	add	x0, sp, #0x38
  8c238c: 97f94101     	bl	0x712790 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24710>
  8c2390: f94017e0     	ldr	x0, [sp, #0x28]
  8c2394: b9402000     	ldr	w0, [x0, #0x20]
  8c2398: 7100001f     	cmp	w0, #0x0
  8c239c: 54000140     	b.eq	0x8c23c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bb98>
  8c23a0: 528004c3     	mov	w3, #0x26               // =38
  8c23a4: b0002780     	adrp	x0, 0xdb3000
  8c23a8: 913aa002     	add	x2, x0, #0xea8
  8c23ac: b0002780     	adrp	x0, 0xdb3000
  8c23b0: 913c2001     	add	x1, x0, #0xf08
  8c23b4: b0002780     	adrp	x0, 0xdb3000
  8c23b8: 913b8000     	add	x0, x0, #0xee0
  8c23bc: 97ed2071     	bl	0x40a580 <printf@plt>
  8c23c0: 97faa8d2     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c23c4: f94017e0     	ldr	x0, [sp, #0x28]
  8c23c8: 3900901f     	strb	wzr, [x0, #0x24]
  8c23cc: f94017e0     	ldr	x0, [sp, #0x28]
  8c23d0: f9404400     	ldr	x0, [x0, #0x88]
  8c23d4: f100001f     	cmp	x0, #0x0
  8c23d8: 54000260     	b.eq	0x8c2424 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bbf8>
  8c23dc: f94017e0     	ldr	x0, [sp, #0x28]
  8c23e0: f9404400     	ldr	x0, [x0, #0x88]
  8c23e4: b9401800     	ldr	w0, [x0, #0x18]
  8c23e8: 7100001f     	cmp	w0, #0x0
  8c23ec: 54000140     	b.eq	0x8c2414 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bbe8>
  8c23f0: 52800583     	mov	w3, #0x2c               // =44
  8c23f4: b0002780     	adrp	x0, 0xdb3000
  8c23f8: 913aa002     	add	x2, x0, #0xea8
  8c23fc: b0002780     	adrp	x0, 0xdb3000
  8c2400: 913c8001     	add	x1, x0, #0xf20
  8c2404: b0002780     	adrp	x0, 0xdb3000
  8c2408: 913b8000     	add	x0, x0, #0xee0
  8c240c: 97ed205d     	bl	0x40a580 <printf@plt>
  8c2410: 97faa8be     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2414: f94017e0     	ldr	x0, [sp, #0x28]
  8c2418: 940000b0     	bl	0x8c26d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1beac>
  8c241c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2420: f900441f     	str	xzr, [x0, #0x88]
  8c2424: f94017e0     	ldr	x0, [sp, #0x28]
  8c2428: f9405000     	ldr	x0, [x0, #0xa0]
  8c242c: f100001f     	cmp	x0, #0x0
  8c2430: 54000260     	b.eq	0x8c247c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bc50>
  8c2434: f94017e0     	ldr	x0, [sp, #0x28]
  8c2438: f9405000     	ldr	x0, [x0, #0xa0]
  8c243c: b9401800     	ldr	w0, [x0, #0x18]
  8c2440: 7100001f     	cmp	w0, #0x0
  8c2444: 54000140     	b.eq	0x8c246c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bc40>
  8c2448: 52800663     	mov	w3, #0x33               // =51
  8c244c: b0002780     	adrp	x0, 0xdb3000
  8c2450: 913aa002     	add	x2, x0, #0xea8
  8c2454: b0002780     	adrp	x0, 0xdb3000
  8c2458: 913d2001     	add	x1, x0, #0xf48
  8c245c: b0002780     	adrp	x0, 0xdb3000
  8c2460: 913b8000     	add	x0, x0, #0xee0
  8c2464: 97ed2047     	bl	0x40a580 <printf@plt>
  8c2468: 97faa8a8     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c246c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2470: 94000156     	bl	0x8c29c8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c19c>
  8c2474: f94017e0     	ldr	x0, [sp, #0x28]
  8c2478: f900501f     	str	xzr, [x0, #0xa0]
  8c247c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2480: f9405400     	ldr	x0, [x0, #0xa8]
  8c2484: f100001f     	cmp	x0, #0x0
  8c2488: 54000260     	b.eq	0x8c24d4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bca8>
  8c248c: f94017e0     	ldr	x0, [sp, #0x28]
  8c2490: f9405400     	ldr	x0, [x0, #0xa8]
  8c2494: b9401800     	ldr	w0, [x0, #0x18]
  8c2498: 7100001f     	cmp	w0, #0x0
  8c249c: 54000140     	b.eq	0x8c24c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bc98>
  8c24a0: 52800743     	mov	w3, #0x3a               // =58
  8c24a4: b0002780     	adrp	x0, 0xdb3000
  8c24a8: 913aa002     	add	x2, x0, #0xea8
  8c24ac: b0002780     	adrp	x0, 0xdb3000
  8c24b0: 913dc001     	add	x1, x0, #0xf70
  8c24b4: b0002780     	adrp	x0, 0xdb3000
  8c24b8: 913b8000     	add	x0, x0, #0xee0
  8c24bc: 97ed2031     	bl	0x40a580 <printf@plt>
  8c24c0: 97faa892     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c24c4: f94017e0     	ldr	x0, [sp, #0x28]
  8c24c8: 9400019e     	bl	0x8c2b40 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1c314>
  8c24cc: f94017e0     	ldr	x0, [sp, #0x28]
  8c24d0: f900541f     	str	xzr, [x0, #0xa8]
  8c24d4: 9100e3e0     	add	x0, sp, #0x38
  8c24d8: 97f940bb     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c24dc: 14000006     	b	0x8c24f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bcc8>
  8c24e0: aa0003f3     	mov	x19, x0
  8c24e4: 9100e3e0     	add	x0, sp, #0x38
  8c24e8: 97f940b7     	bl	0x7127c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x24744>
  8c24ec: aa1303e0     	mov	x0, x19
  8c24f0: 97ed2098     	bl	0x40a750 <_Unwind_Resume@plt>
  8c24f4: f9400bf3     	ldr	x19, [sp, #0x10]
  8c24f8: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8c24fc: d65f03c0     	ret
  8c2500: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2504: 910003fd     	mov	x29, sp
  8c2508: f9000fe0     	str	x0, [sp, #0x18]
  8c250c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2510: b940d800     	ldr	w0, [x0, #0xd8]
  8c2514: 3100041f     	cmn	w0, #0x1
  8c2518: 540000c0     	b.eq	0x8c2530 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bd04>
  8c251c: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2520: 9109a000     	add	x0, x0, #0x268
  8c2524: f9400000     	ldr	x0, [x0]
  8c2528: f9400fe1     	ldr	x1, [sp, #0x18]
  8c252c: 94000e2f     	bl	0x8c5de8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f5bc>
  8c2530: d503201f     	nop
  8c2534: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2538: d65f03c0     	ret
  8c253c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2540: 910003fd     	mov	x29, sp
  8c2544: f9000fe0     	str	x0, [sp, #0x18]
  8c2548: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c254c: 9109a000     	add	x0, x0, #0x268
  8c2550: f9400000     	ldr	x0, [x0]
  8c2554: f9400fe1     	ldr	x1, [sp, #0x18]
  8c2558: 94000c86     	bl	0x8c5770 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ef44>
  8c255c: d503201f     	nop
  8c2560: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2564: d65f03c0     	ret
  8c2568: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c256c: 910003fd     	mov	x29, sp
  8c2570: f9000fe0     	str	x0, [sp, #0x18]
  8c2574: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2578: 9109a000     	add	x0, x0, #0x268
  8c257c: f9400000     	ldr	x0, [x0]
  8c2580: f9400fe1     	ldr	x1, [sp, #0x18]
  8c2584: 94000c85     	bl	0x8c5798 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ef6c>
  8c2588: d503201f     	nop
  8c258c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2590: d65f03c0     	ret
  8c2594: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2598: 910003fd     	mov	x29, sp
  8c259c: f9000fe0     	str	x0, [sp, #0x18]
  8c25a0: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c25a4: 9109a000     	add	x0, x0, #0x268
  8c25a8: f9400000     	ldr	x0, [x0]
  8c25ac: f9400fe1     	ldr	x1, [sp, #0x18]
  8c25b0: 94000c85     	bl	0x8c57c4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ef98>
  8c25b4: d503201f     	nop
  8c25b8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c25bc: d65f03c0     	ret
  8c25c0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c25c4: 910003fd     	mov	x29, sp
  8c25c8: f9000fe0     	str	x0, [sp, #0x18]
  8c25cc: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c25d0: 9109a000     	add	x0, x0, #0x268
  8c25d4: f9400000     	ldr	x0, [x0]
  8c25d8: f9416c02     	ldr	x2, [x0, #0x2d8]
  8c25dc: f9400fe0     	ldr	x0, [sp, #0x18]
  8c25e0: f9404400     	ldr	x0, [x0, #0x88]
  8c25e4: aa0003e1     	mov	x1, x0
  8c25e8: aa0203e0     	mov	x0, x2
  8c25ec: 97f8b878     	bl	0x6f07cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x274c>
  8c25f0: aa0003e1     	mov	x1, x0
  8c25f4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c25f8: f9004401     	str	x1, [x0, #0x88]
  8c25fc: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2600: f9404400     	ldr	x0, [x0, #0x88]
  8c2604: f100001f     	cmp	x0, #0x0
  8c2608: 54000061     	b.ne	0x8c2614 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bde8>
  8c260c: d2800000     	mov	x0, #0x0                // =0
  8c2610: 14000014     	b	0x8c2660 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be34>
  8c2614: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2618: f9404400     	ldr	x0, [x0, #0x88]
  8c261c: f100001f     	cmp	x0, #0x0
  8c2620: 54000141     	b.ne	0x8c2648 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be1c>
  8c2624: 52800e43     	mov	w3, #0x72               // =114
  8c2628: b0002780     	adrp	x0, 0xdb3000
  8c262c: 913aa002     	add	x2, x0, #0xea8
  8c2630: b0002780     	adrp	x0, 0xdb3000
  8c2634: 913e6001     	add	x1, x0, #0xf98
  8c2638: b0002780     	adrp	x0, 0xdb3000
  8c263c: 913b8000     	add	x0, x0, #0xee0
  8c2640: 97ed1fd0     	bl	0x40a580 <printf@plt>
  8c2644: 97faa831     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2648: f9400fe0     	ldr	x0, [sp, #0x18]
  8c264c: f9404400     	ldr	x0, [x0, #0x88]
  8c2650: f9400fe1     	ldr	x1, [sp, #0x18]
  8c2654: f9000801     	str	x1, [x0, #0x10]
  8c2658: f9400fe0     	ldr	x0, [sp, #0x18]
  8c265c: f9404400     	ldr	x0, [x0, #0x88]
  8c2660: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c2664: d65f03c0     	ret
  8c2668: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c266c: 910003fd     	mov	x29, sp
  8c2670: f9000fe0     	str	x0, [sp, #0x18]
  8c2674: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2678: f9404400     	ldr	x0, [x0, #0x88]
  8c267c: f100001f     	cmp	x0, #0x0
  8c2680: 54000141     	b.ne	0x8c26a8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1be7c>
  8c2684: 52800f83     	mov	w3, #0x7c               // =124
  8c2688: b0002780     	adrp	x0, 0xdb3000
  8c268c: 913aa002     	add	x2, x0, #0xea8
  8c2690: b0002780     	adrp	x0, 0xdb3000
  8c2694: 913e6001     	add	x1, x0, #0xf98
  8c2698: b0002780     	adrp	x0, 0xdb3000
  8c269c: 913b8000     	add	x0, x0, #0xee0
  8c26a0: 97ed1fb8     	bl	0x40a580 <printf@plt>
  8c26a4: 97faa819     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c26a8: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c26ac: 9109a000     	add	x0, x0, #0x268
  8c26b0: f9400000     	ldr	x0, [x0]
  8c26b4: f9416c02     	ldr	x2, [x0, #0x2d8]
  8c26b8: f9400fe0     	ldr	x0, [sp, #0x18]
  8c26bc: f9404400     	ldr	x0, [x0, #0x88]
  8c26c0: aa0003e1     	mov	x1, x0
  8c26c4: aa0203e0     	mov	x0, x2
  8c26c8: 97f8b8b0     	bl	0x6f0988 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2908>
  8c26cc: d503201f     	nop
  8c26d0: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c26d4: d65f03c0     	ret
  8c26d8: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c26dc: 910003fd     	mov	x29, sp
  8c26e0: f9000fe0     	str	x0, [sp, #0x18]
  8c26e4: f9400fe0     	ldr	x0, [sp, #0x18]
  8c26e8: f9404400     	ldr	x0, [x0, #0x88]
  8c26ec: f100001f     	cmp	x0, #0x0
  8c26f0: 54000141     	b.ne	0x8c2718 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1beec>
  8c26f4: 52801083     	mov	w3, #0x84               // =132
  8c26f8: b0002780     	adrp	x0, 0xdb3000
  8c26fc: 913aa002     	add	x2, x0, #0xea8
  8c2700: b0002780     	adrp	x0, 0xdb3000
  8c2704: 913e6001     	add	x1, x0, #0xf98
  8c2708: b0002780     	adrp	x0, 0xdb3000
  8c270c: 913b8000     	add	x0, x0, #0xee0
  8c2710: 97ed1f9c     	bl	0x40a580 <printf@plt>
  8c2714: 97faa7fd     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2718: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c271c: 9109a000     	add	x0, x0, #0x268
  8c2720: f9400000     	ldr	x0, [x0]
  8c2724: f9416c02     	ldr	x2, [x0, #0x2d8]
  8c2728: f9400fe0     	ldr	x0, [sp, #0x18]
  8c272c: f9404400     	ldr	x0, [x0, #0x88]
  8c2730: aa0003e1     	mov	x1, x0
  8c2734: aa0203e0     	mov	x0, x2
  8c2738: 97f8b8d9     	bl	0x6f0a9c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x2a1c>
  8c273c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2740: f900441f     	str	xzr, [x0, #0x88]
  8c2744: d503201f     	nop
  8c2748: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c274c: d65f03c0     	ret
  8c2750: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2754: 910003fd     	mov	x29, sp
  8c2758: f9000fe0     	str	x0, [sp, #0x18]
  8c275c: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2760: 9109a000     	add	x0, x0, #0x268
  8c2764: f9400000     	ldr	x0, [x0]
  8c2768: f9417002     	ldr	x2, [x0, #0x2e0]
  8c276c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2770: f9404800     	ldr	x0, [x0, #0x90]
  8c2774: aa0003e1     	mov	x1, x0
  8c2778: aa0203e0     	mov	x0, x2
  8c277c: 940003d1     	bl	0x8c36c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1ce94>
  8c2780: aa0003e1     	mov	x1, x0
  8c2784: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2788: f9004801     	str	x1, [x0, #0x90]
  8c278c: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2790: f9404800     	ldr	x0, [x0, #0x90]
  8c2794: f100001f     	cmp	x0, #0x0
  8c2798: 54000141     	b.ne	0x8c27c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bf94>
  8c279c: 52801203     	mov	w3, #0x90               // =144
  8c27a0: b0002780     	adrp	x0, 0xdb3000
  8c27a4: 913aa002     	add	x2, x0, #0xea8
  8c27a8: b0002780     	adrp	x0, 0xdb3000
  8c27ac: 913ea001     	add	x1, x0, #0xfa8
  8c27b0: b0002780     	adrp	x0, 0xdb3000
  8c27b4: 913b8000     	add	x0, x0, #0xee0
  8c27b8: 97ed1f72     	bl	0x40a580 <printf@plt>
  8c27bc: 97faa7d3     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c27c0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c27c4: f9404800     	ldr	x0, [x0, #0x90]
  8c27c8: f9400fe1     	ldr	x1, [sp, #0x18]
  8c27cc: f9000801     	str	x1, [x0, #0x10]
  8c27d0: f9400fe0     	ldr	x0, [sp, #0x18]
  8c27d4: f9404800     	ldr	x0, [x0, #0x90]
  8c27d8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c27dc: d65f03c0     	ret
  8c27e0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c27e4: 910003fd     	mov	x29, sp
  8c27e8: f9000fe0     	str	x0, [sp, #0x18]
  8c27ec: f9400fe0     	ldr	x0, [sp, #0x18]
  8c27f0: f9404800     	ldr	x0, [x0, #0x90]
  8c27f4: f100001f     	cmp	x0, #0x0
  8c27f8: 54000141     	b.ne	0x8c2820 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1bff4>
  8c27fc: 52801323     	mov	w3, #0x99               // =153
  8c2800: b0002780     	adrp	x0, 0xdb3000
  8c2804: 913aa002     	add	x2, x0, #0xea8
  8c2808: b0002780     	adrp	x0, 0xdb3000
  8c280c: 913ea001     	add	x1, x0, #0xfa8
  8c2810: b0002780     	adrp	x0, 0xdb3000
  8c2814: 913b8000     	add	x0, x0, #0xee0
  8c2818: 97ed1f5a     	bl	0x40a580 <printf@plt>
  8c281c: 97faa7bb     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8c2820: d001c9c0     	adrp	x0, 0x41fc000 <_ZNSt5ctypeIcE2idE+0x3298ed8>
  8c2824: 9109a000     	add	x0, x0, #0x268
  8c2828: f9400000     	ldr	x0, [x0]
  8c282c: f9417002     	ldr	x2, [x0, #0x2e0]
  8c2830: f9400fe0     	ldr	x0, [sp, #0x18]
  8c2834: f9404800     	ldr	x0, [x0, #0x90]
  8c2838: aa0003e1     	mov	x1, x0
  8c283c: aa0203e0     	mov	x0, x2
  8c2840: 9400040f     	bl	0x8c387c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1d050>
  8c2844: d503201f     	nop
  8c2848: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  8c284c: d65f03c0     	ret
  8c2850: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  8c2854: 910003fd     	mov	x29, sp
  8c2858: f9000fe0     	str	x0, [sp, #0x18]
  8c285c: f9400fe0     	ldr	x0, [sp, #0x18]
