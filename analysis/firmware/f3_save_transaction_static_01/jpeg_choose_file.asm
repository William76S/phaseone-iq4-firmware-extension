  8e1f7c: a9b97bfd     	stp	x29, x30, [sp, #-0x70]!
  8e1f80: 910003fd     	mov	x29, sp
  8e1f84: f9000fe0     	str	x0, [sp, #0x18]
  8e1f88: f9000be1     	str	x1, [sp, #0x10]
  8e1f8c: f9400fe0     	ldr	x0, [sp, #0x18]
  8e1f90: f940d803     	ldr	x3, [x0, #0x1b0]
  8e1f94: f9400fe0     	ldr	x0, [sp, #0x18]
  8e1f98: f940d800     	ldr	x0, [x0, #0x1b0]
  8e1f9c: f9400000     	ldr	x0, [x0]
  8e1fa0: 91020000     	add	x0, x0, #0x80
  8e1fa4: f9400002     	ldr	x2, [x0]
  8e1fa8: f00026c0     	adrp	x0, 0xdbc000
  8e1fac: 9134e001     	add	x1, x0, #0xd38
  8e1fb0: aa0303e0     	mov	x0, x3
  8e1fb4: d63f0040     	blr	x2
  8e1fb8: 12001c00     	and	w0, w0, #0xff
  8e1fbc: 52000000     	eor	w0, w0, #0x1
  8e1fc0: 12001c00     	and	w0, w0, #0xff
  8e1fc4: 7100001f     	cmp	w0, #0x0
  8e1fc8: 54000340     	b.eq	0x8e2030 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b804>
  8e1fcc: f9400fe0     	ldr	x0, [sp, #0x18]
  8e1fd0: f940d803     	ldr	x3, [x0, #0x1b0]
  8e1fd4: f9400fe0     	ldr	x0, [sp, #0x18]
  8e1fd8: f940d800     	ldr	x0, [x0, #0x1b0]
  8e1fdc: f9400000     	ldr	x0, [x0]
  8e1fe0: 9101a000     	add	x0, x0, #0x68
  8e1fe4: f9400002     	ldr	x2, [x0]
  8e1fe8: f00026c0     	adrp	x0, 0xdbc000
  8e1fec: 9134e001     	add	x1, x0, #0xd38
  8e1ff0: aa0303e0     	mov	x0, x3
  8e1ff4: d63f0040     	blr	x2
  8e1ff8: 12001c00     	and	w0, w0, #0xff
  8e1ffc: 52000000     	eor	w0, w0, #0x1
  8e2000: 12001c00     	and	w0, w0, #0xff
  8e2004: 7100001f     	cmp	w0, #0x0
  8e2008: 54000140     	b.eq	0x8e2030 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b804>
  8e200c: d00026c0     	adrp	x0, 0xdbc000
  8e2010: 91350003     	add	x3, x0, #0xd40
  8e2014: 528042c2     	mov	w2, #0x216              // =534
  8e2018: d00026c0     	adrp	x0, 0xdbc000
  8e201c: 9122c001     	add	x1, x0, #0x8b0
  8e2020: 52800080     	mov	w0, #0x4                // =4
  8e2024: 97f9914a     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8e2028: 52800000     	mov	w0, #0x0                // =0
  8e202c: 140000a8     	b	0x8e22cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3baa0>
  8e2030: b9006fff     	str	wzr, [sp, #0x6c]
  8e2034: 3901afff     	strb	wzr, [sp, #0x6b]
  8e2038: 3941afe0     	ldrb	w0, [sp, #0x6b]
  8e203c: 7100001f     	cmp	w0, #0x0
  8e2040: 54000d21     	b.ne	0x8e21e4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b9b8>
  8e2044: b9406fe0     	ldr	w0, [sp, #0x6c]
  8e2048: 11019000     	add	w0, w0, #0x64
  8e204c: 910083e3     	add	x3, sp, #0x20
  8e2050: 2a0003e2     	mov	w2, w0
  8e2054: d00026c0     	adrp	x0, 0xdbc000
  8e2058: 9135c001     	add	x1, x0, #0xd70
  8e205c: aa0303e0     	mov	x0, x3
  8e2060: 97eca1e8     	bl	0x40a800 <sprintf@plt>
  8e2064: f9400fe0     	ldr	x0, [sp, #0x18]
  8e2068: f940d803     	ldr	x3, [x0, #0x1b0]
  8e206c: f9400fe0     	ldr	x0, [sp, #0x18]
  8e2070: f940d800     	ldr	x0, [x0, #0x1b0]
  8e2074: f9400000     	ldr	x0, [x0]
  8e2078: 91020000     	add	x0, x0, #0x80
  8e207c: f9400002     	ldr	x2, [x0]
  8e2080: 910083e0     	add	x0, sp, #0x20
  8e2084: aa0003e1     	mov	x1, x0
  8e2088: aa0303e0     	mov	x0, x3
  8e208c: d63f0040     	blr	x2
  8e2090: 12001c00     	and	w0, w0, #0xff
  8e2094: 52000000     	eor	w0, w0, #0x1
  8e2098: 12001c00     	and	w0, w0, #0xff
  8e209c: 7100001f     	cmp	w0, #0x0
  8e20a0: 54000380     	b.eq	0x8e2110 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b8e4>
  8e20a4: f9400fe0     	ldr	x0, [sp, #0x18]
  8e20a8: f940d803     	ldr	x3, [x0, #0x1b0]
  8e20ac: f9400fe0     	ldr	x0, [sp, #0x18]
  8e20b0: f940d800     	ldr	x0, [x0, #0x1b0]
  8e20b4: f9400000     	ldr	x0, [x0]
  8e20b8: 9101a000     	add	x0, x0, #0x68
  8e20bc: f9400002     	ldr	x2, [x0]
  8e20c0: 910083e0     	add	x0, sp, #0x20
  8e20c4: aa0003e1     	mov	x1, x0
  8e20c8: aa0303e0     	mov	x0, x3
  8e20cc: d63f0040     	blr	x2
  8e20d0: 12001c00     	and	w0, w0, #0xff
  8e20d4: 52000000     	eor	w0, w0, #0x1
  8e20d8: 12001c00     	and	w0, w0, #0xff
  8e20dc: 7100001f     	cmp	w0, #0x0
  8e20e0: 54000180     	b.eq	0x8e2110 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b8e4>
  8e20e4: 910083e0     	add	x0, sp, #0x20
  8e20e8: aa0003e4     	mov	x4, x0
  8e20ec: d00026c0     	adrp	x0, 0xdbc000
  8e20f0: 91360003     	add	x3, x0, #0xd80
  8e20f4: 528044a2     	mov	w2, #0x225              // =549
  8e20f8: d00026c0     	adrp	x0, 0xdbc000
  8e20fc: 9122c001     	add	x1, x0, #0x8b0
  8e2100: 52800080     	mov	w0, #0x4                // =4
  8e2104: 97f99112     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8e2108: 52800000     	mov	w0, #0x0                // =0
  8e210c: 14000070     	b	0x8e22cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3baa0>
  8e2110: f9400fe0     	ldr	x0, [sp, #0x18]
  8e2114: f940d803     	ldr	x3, [x0, #0x1b0]
  8e2118: f9400fe0     	ldr	x0, [sp, #0x18]
  8e211c: f940d800     	ldr	x0, [x0, #0x1b0]
  8e2120: f9400000     	ldr	x0, [x0]
  8e2124: 91026000     	add	x0, x0, #0x98
  8e2128: f9400002     	ldr	x2, [x0]
  8e212c: 910083e0     	add	x0, sp, #0x20
  8e2130: aa0003e1     	mov	x1, x0
  8e2134: aa0303e0     	mov	x0, x3
  8e2138: d63f0040     	blr	x2
  8e213c: b90067e0     	str	w0, [sp, #0x64]
  8e2140: b94067e0     	ldr	w0, [sp, #0x64]
  8e2144: 3100041f     	cmn	w0, #0x1
  8e2148: 54000181     	b.ne	0x8e2178 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b94c>
  8e214c: 910083e0     	add	x0, sp, #0x20
  8e2150: aa0003e4     	mov	x4, x0
  8e2154: d00026c0     	adrp	x0, 0xdbc000
  8e2158: 9136c003     	add	x3, x0, #0xdb0
  8e215c: 528045a2     	mov	w2, #0x22d              // =557
  8e2160: d00026c0     	adrp	x0, 0xdbc000
  8e2164: 9122c001     	add	x1, x0, #0x8b0
  8e2168: 52800080     	mov	w0, #0x4                // =4
  8e216c: 97f990f8     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8e2170: 52800000     	mov	w0, #0x0                // =0
  8e2174: 14000056     	b	0x8e22cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3baa0>
  8e2178: b94067e1     	ldr	w1, [sp, #0x64]
  8e217c: 5284e200     	mov	w0, #0x2710             // =10000
  8e2180: 6b00003f     	cmp	w1, w0
  8e2184: 540002a9     	b.ls	0x8e21d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b9ac>
  8e2188: b9406fe0     	ldr	w0, [sp, #0x6c]
  8e218c: 11000400     	add	w0, w0, #0x1
  8e2190: 529678a1     	mov	w1, #0xb3c5             // =46021
  8e2194: 72b23441     	movk	w1, #0x91a2, lsl #16
  8e2198: 9ba17c01     	umull	x1, w0, w1
  8e219c: d360fc21     	lsr	x1, x1, #32
  8e21a0: 53097c22     	lsr	w2, w1, #9
  8e21a4: 52807081     	mov	w1, #0x384              // =900
  8e21a8: 1b017c41     	mul	w1, w2, w1
  8e21ac: 4b010000     	sub	w0, w0, w1
  8e21b0: b9006fe0     	str	w0, [sp, #0x6c]
  8e21b4: b9406fe0     	ldr	w0, [sp, #0x6c]
  8e21b8: 11019000     	add	w0, w0, #0x64
  8e21bc: 910083e3     	add	x3, sp, #0x20
  8e21c0: 2a0003e2     	mov	w2, w0
  8e21c4: d00026c0     	adrp	x0, 0xdbc000
  8e21c8: 9135c001     	add	x1, x0, #0xd70
  8e21cc: aa0303e0     	mov	x0, x3
  8e21d0: 97eca18c     	bl	0x40a800 <sprintf@plt>
  8e21d4: 17ffff99     	b	0x8e2038 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b80c>
  8e21d8: 52800020     	mov	w0, #0x1                // =1
  8e21dc: 3901afe0     	strb	w0, [sp, #0x6b]
  8e21e0: 17ffff96     	b	0x8e2038 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b80c>
  8e21e4: 7900d3ff     	strh	wzr, [sp, #0x68]
  8e21e8: f9400fe1     	ldr	x1, [sp, #0x18]
  8e21ec: d2803f00     	mov	x0, #0x1f8              // =504
  8e21f0: f2a0c800     	movk	x0, #0x640, lsl #16
  8e21f4: 8b000024     	add	x4, x1, x0
  8e21f8: 910083e0     	add	x0, sp, #0x20
  8e21fc: f9400be3     	ldr	x3, [sp, #0x10]
  8e2200: aa0003e2     	mov	x2, x0
  8e2204: d00026c0     	adrp	x0, 0xdbc000
  8e2208: 9137e001     	add	x1, x0, #0xdf8
  8e220c: aa0403e0     	mov	x0, x4
  8e2210: 97eca17c     	bl	0x40a800 <sprintf@plt>
  8e2214: f9400fe0     	ldr	x0, [sp, #0x18]
  8e2218: f940d803     	ldr	x3, [x0, #0x1b0]
  8e221c: f9400fe0     	ldr	x0, [sp, #0x18]
  8e2220: f940d800     	ldr	x0, [x0, #0x1b0]
  8e2224: f9400000     	ldr	x0, [x0]
  8e2228: 9102c000     	add	x0, x0, #0xb0
  8e222c: f9400002     	ldr	x2, [x0]
  8e2230: f9400fe1     	ldr	x1, [sp, #0x18]
  8e2234: d2803f00     	mov	x0, #0x1f8              // =504
  8e2238: f2a0c800     	movk	x0, #0x640, lsl #16
  8e223c: 8b000020     	add	x0, x1, x0
  8e2240: aa0003e1     	mov	x1, x0
  8e2244: aa0303e0     	mov	x0, x3
  8e2248: d63f0040     	blr	x2
  8e224c: 12001c00     	and	w0, w0, #0xff
  8e2250: 7100001f     	cmp	w0, #0x0
  8e2254: 54000240     	b.eq	0x8e229c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3ba70>
  8e2258: 7940d3e0     	ldrh	w0, [sp, #0x68]
  8e225c: 11000400     	add	w0, w0, #0x1
  8e2260: 7900d3e0     	strh	w0, [sp, #0x68]
  8e2264: f9400fe1     	ldr	x1, [sp, #0x18]
  8e2268: d2803f00     	mov	x0, #0x1f8              // =504
  8e226c: f2a0c800     	movk	x0, #0x640, lsl #16
  8e2270: 8b000025     	add	x5, x1, x0
  8e2274: 7940d3e1     	ldrh	w1, [sp, #0x68]
  8e2278: 910083e0     	add	x0, sp, #0x20
  8e227c: 2a0103e4     	mov	w4, w1
  8e2280: f9400be3     	ldr	x3, [sp, #0x10]
  8e2284: aa0003e2     	mov	x2, x0
  8e2288: d00026c0     	adrp	x0, 0xdbc000
  8e228c: 91382001     	add	x1, x0, #0xe08
  8e2290: aa0503e0     	mov	x0, x5
  8e2294: 97eca15b     	bl	0x40a800 <sprintf@plt>
  8e2298: 17ffffdf     	b	0x8e2214 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x3b9e8>
  8e229c: f9400fe1     	ldr	x1, [sp, #0x18]
  8e22a0: d2803f00     	mov	x0, #0x1f8              // =504
  8e22a4: f2a0c800     	movk	x0, #0x640, lsl #16
  8e22a8: 8b000020     	add	x0, x1, x0
  8e22ac: aa0003e3     	mov	x3, x0
  8e22b0: d00026c0     	adrp	x0, 0xdbc000
  8e22b4: 91386002     	add	x2, x0, #0xe18
  8e22b8: 528048a1     	mov	w1, #0x245              // =581
  8e22bc: d00026c0     	adrp	x0, 0xdbc000
  8e22c0: 9122c000     	add	x0, x0, #0x8b0
  8e22c4: 97f99076     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8e22c8: 52800020     	mov	w0, #0x1                // =1
  8e22cc: a8c77bfd     	ldp	x29, x30, [sp], #0x70
  8e22d0: d65f03c0     	ret
