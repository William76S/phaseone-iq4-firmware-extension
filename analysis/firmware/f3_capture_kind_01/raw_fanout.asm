
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000008a682c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_>:
  8dc278: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8dc27c: 910003fd     	mov	x29, sp
  8dc280: f9000fe0     	str	x0, [sp, #0x18]
  8dc284: b90017e1     	str	w1, [sp, #0x14]
  8dc288: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc28c: b9400800     	ldr	w0, [x0, #0x8]
  8dc290: b94017e1     	ldr	w1, [sp, #0x14]
  8dc294: 6b00003f     	cmp	w1, w0
  8dc298: 54000143     	b.lo	0x8dc2c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35a94>
  8dc29c: 52804323     	mov	w3, #0x219              // =537
  8dc2a0: d00026e0     	adrp	x0, 0xdba000
  8dc2a4: 911e0002     	add	x2, x0, #0x780
  8dc2a8: d00026e0     	adrp	x0, 0xdba000
  8dc2ac: 911fe001     	add	x1, x0, #0x7f8
  8dc2b0: d00026e0     	adrp	x0, 0xdba000
  8dc2b4: 911f4000     	add	x0, x0, #0x7d0
  8dc2b8: 97ecb8b2     	bl	0x40a580 <printf@plt>
  8dc2bc: 97fa4113     	bl	0x76c708 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x529dc>
  8dc2c0: b94017e1     	ldr	w1, [sp, #0x14]
  8dc2c4: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc2c8: 97fffde3     	bl	0x8dba54 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35228>
  8dc2cc: b9002fe0     	str	w0, [sp, #0x2c]
  8dc2d0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc2d4: f9400801     	ldr	x1, [x0, #0x10]
  8dc2d8: b94017e0     	ldr	w0, [sp, #0x14]
  8dc2dc: d37df000     	lsl	x0, x0, #3
  8dc2e0: 8b000020     	add	x0, x1, x0
  8dc2e4: f9400000     	ldr	x0, [x0]
  8dc2e8: 91002000     	add	x0, x0, #0x8
  8dc2ec: 97f1fc85     	bl	0x55b500 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x62450>
  8dc2f0: 7100041f     	cmp	w0, #0x1
  8dc2f4: 540000e0     	b.eq	0x8dc310 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ae4>
  8dc2f8: 7100081f     	cmp	w0, #0x2
  8dc2fc: 54000520     	b.eq	0x8dc3a0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35b74>
  8dc300: 7100001f     	cmp	w0, #0x0
  8dc304: 54000761     	b.ne	0x8dc3f0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bc4>
  8dc308: 52800000     	mov	w0, #0x0                // =0
  8dc30c: 1400003a     	b	0x8dc3f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bc8>
  8dc310: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc314: f9400801     	ldr	x1, [x0, #0x10]
  8dc318: b94017e0     	ldr	w0, [sp, #0x14]
  8dc31c: d37df000     	lsl	x0, x0, #3
  8dc320: 8b000020     	add	x0, x1, x0
  8dc324: f9400000     	ldr	x0, [x0]
  8dc328: 9111a000     	add	x0, x0, #0x468
  8dc32c: 97ece194     	bl	0x41497c <.text+0x974c>
  8dc330: 12001c00     	and	w0, w0, #0xff
  8dc334: 52000000     	eor	w0, w0, #0x1
  8dc338: 12001c00     	and	w0, w0, #0xff
  8dc33c: 7100001f     	cmp	w0, #0x0
  8dc340: 54000140     	b.eq	0x8dc368 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35b3c>
  8dc344: d00026e0     	adrp	x0, 0xdba000
  8dc348: 91226003     	add	x3, x0, #0x898
  8dc34c: 528044c2     	mov	w2, #0x226              // =550
  8dc350: d00026e0     	adrp	x0, 0xdba000
  8dc354: 911e0001     	add	x1, x0, #0x780
  8dc358: 52800040     	mov	w0, #0x2                // =2
  8dc35c: 97f9a87c     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8dc360: 52800000     	mov	w0, #0x0                // =0
  8dc364: 14000024     	b	0x8dc3f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bc8>
  8dc368: b9402fe0     	ldr	w0, [sp, #0x2c]
  8dc36c: 7100001f     	cmp	w0, #0x0
  8dc370: 54000141     	b.ne	0x8dc398 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35b6c>
  8dc374: d00026e0     	adrp	x0, 0xdba000
  8dc378: 91236003     	add	x3, x0, #0x8d8
  8dc37c: 52804562     	mov	w2, #0x22b              // =555
  8dc380: d00026e0     	adrp	x0, 0xdba000
  8dc384: 911e0001     	add	x1, x0, #0x780
  8dc388: 52800040     	mov	w0, #0x2                // =2
  8dc38c: 97f9a870     	bl	0x74654c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c820>
  8dc390: 52800000     	mov	w0, #0x0                // =0
  8dc394: 14000018     	b	0x8dc3f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bc8>
  8dc398: 52800020     	mov	w0, #0x1                // =1
  8dc39c: 14000016     	b	0x8dc3f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bc8>
  8dc3a0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc3a4: f9400801     	ldr	x1, [x0, #0x10]
  8dc3a8: b94017e0     	ldr	w0, [sp, #0x14]
  8dc3ac: d37df000     	lsl	x0, x0, #3
  8dc3b0: 8b000020     	add	x0, x1, x0
  8dc3b4: f9400000     	ldr	x0, [x0]
  8dc3b8: 9111a000     	add	x0, x0, #0x468
  8dc3bc: 97ece170     	bl	0x41497c <.text+0x974c>
  8dc3c0: 12001c00     	and	w0, w0, #0xff
  8dc3c4: 52000000     	eor	w0, w0, #0x1
  8dc3c8: 12001c00     	and	w0, w0, #0xff
  8dc3cc: 7100001f     	cmp	w0, #0x0
  8dc3d0: 54000060     	b.eq	0x8dc3dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bb0>
  8dc3d4: 52800000     	mov	w0, #0x0                // =0
  8dc3d8: 14000007     	b	0x8dc3f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bc8>
  8dc3dc: b9402fe0     	ldr	w0, [sp, #0x2c]
  8dc3e0: 7100001f     	cmp	w0, #0x0
  8dc3e4: 1a9f07e0     	cset	w0, ne
  8dc3e8: 12001c00     	and	w0, w0, #0xff
  8dc3ec: 14000002     	b	0x8dc3f4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bc8>
  8dc3f0: 52800000     	mov	w0, #0x0                // =0
  8dc3f4: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8dc3f8: d65f03c0     	ret
  8dc3fc: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  8dc400: 910003fd     	mov	x29, sp
  8dc404: f9000fe0     	str	x0, [sp, #0x18]
  8dc408: b9002fff     	str	wzr, [sp, #0x2c]
  8dc40c: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc410: b9400801     	ldr	w1, [x0, #0x8]
  8dc414: b9402fe0     	ldr	w0, [sp, #0x2c]
  8dc418: 6b00003f     	cmp	w1, w0
  8dc41c: 54000289     	b.ls	0x8dc46c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35c40>
  8dc420: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc424: f9400801     	ldr	x1, [x0, #0x10]
  8dc428: b9802fe0     	ldrsw	x0, [sp, #0x2c]
  8dc42c: d37df000     	lsl	x0, x0, #3
  8dc430: 8b000020     	add	x0, x1, x0
  8dc434: f9400000     	ldr	x0, [x0]
  8dc438: 91002000     	add	x0, x0, #0x8
  8dc43c: 97f1fc31     	bl	0x55b500 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x62450>
  8dc440: 7100001f     	cmp	w0, #0x0
  8dc444: 1a9f07e0     	cset	w0, ne
  8dc448: 12001c00     	and	w0, w0, #0xff
  8dc44c: 7100001f     	cmp	w0, #0x0
  8dc450: 54000060     	b.eq	0x8dc45c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35c30>
  8dc454: 52800000     	mov	w0, #0x0                // =0
  8dc458: 14000006     	b	0x8dc470 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35c44>
  8dc45c: b9402fe0     	ldr	w0, [sp, #0x2c]
  8dc460: 11000400     	add	w0, w0, #0x1
  8dc464: b9002fe0     	str	w0, [sp, #0x2c]
  8dc468: 17ffffe9     	b	0x8dc40c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35be0>
  8dc46c: 52800020     	mov	w0, #0x1                // =1
  8dc470: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  8dc474: d65f03c0     	ret
  8dc478: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8dc47c: 910003fd     	mov	x29, sp
  8dc480: f9000fe0     	str	x0, [sp, #0x18]
  8dc484: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc488: f9402400     	ldr	x0, [x0, #0x48]
  8dc48c: f100001f     	cmp	x0, #0x0
  8dc490: 54001341     	b.ne	0x8dc6f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ecc>
  8dc494: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc498: f9401c00     	ldr	x0, [x0, #0x38]
  8dc49c: 9106e000     	add	x0, x0, #0x1b8
  8dc4a0: 97ffaf88     	bl	0x8c82c0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x21a94>
  8dc4a4: f9001be0     	str	x0, [sp, #0x30]
  8dc4a8: f9401be0     	ldr	x0, [sp, #0x30]
  8dc4ac: f100001f     	cmp	x0, #0x0
  8dc4b0: 54001280     	b.eq	0x8dc700 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ed4>
  8dc4b4: f9401be0     	ldr	x0, [sp, #0x30]
  8dc4b8: f9400401     	ldr	x1, [x0, #0x8]
  8dc4bc: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc4c0: f9002401     	str	x1, [x0, #0x48]
  8dc4c4: 3900ffff     	strb	wzr, [sp, #0x3f]
  8dc4c8: b9003bff     	str	wzr, [sp, #0x38]
  8dc4cc: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc4d0: b9400801     	ldr	w1, [x0, #0x8]
  8dc4d4: b9403be0     	ldr	w0, [sp, #0x38]
  8dc4d8: 6b00003f     	cmp	w1, w0
  8dc4dc: 540009e9     	b.ls	0x8dc618 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35dec>
  8dc4e0: b9403be0     	ldr	w0, [sp, #0x38]
  8dc4e4: 2a0003e1     	mov	w1, w0
  8dc4e8: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc4ec: 97ffff63     	bl	0x8dc278 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35a4c>
  8dc4f0: 12001c00     	and	w0, w0, #0xff
  8dc4f4: 7100001f     	cmp	w0, #0x0
  8dc4f8: 54000560     	b.eq	0x8dc5a4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35d78>
  8dc4fc: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc500: f9400801     	ldr	x1, [x0, #0x10]
  8dc504: b9803be0     	ldrsw	x0, [sp, #0x38]
  8dc508: d37df000     	lsl	x0, x0, #3
  8dc50c: 8b000020     	add	x0, x1, x0
  8dc510: f9400000     	ldr	x0, [x0]
  8dc514: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc518: 52800021     	mov	w1, #0x1                // =1
  8dc51c: 390fc001     	strb	w1, [x0, #0x3f0]
  8dc520: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc524: f9400801     	ldr	x1, [x0, #0x10]
  8dc528: b9803be0     	ldrsw	x0, [sp, #0x38]
  8dc52c: d37df000     	lsl	x0, x0, #3
  8dc530: 8b000020     	add	x0, x1, x0
  8dc534: f9400000     	ldr	x0, [x0]
  8dc538: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc53c: 52800021     	mov	w1, #0x1                // =1
  8dc540: 390fc401     	strb	w1, [x0, #0x3f1]
  8dc544: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc548: f9400801     	ldr	x1, [x0, #0x10]
  8dc54c: b9803be0     	ldrsw	x0, [sp, #0x38]
  8dc550: d37df000     	lsl	x0, x0, #3
  8dc554: 8b000020     	add	x0, x1, x0
  8dc558: f9400000     	ldr	x0, [x0]
  8dc55c: 91262002     	add	x2, x0, #0x988
  8dc560: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc564: f9402400     	ldr	x0, [x0, #0x48]
  8dc568: aa0003e1     	mov	x1, x0
  8dc56c: aa0203e0     	mov	x0, x2
  8dc570: 97ed8a1d     	bl	0x43ede4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x8e38>
  8dc574: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc578: f9400801     	ldr	x1, [x0, #0x10]
  8dc57c: b9803be0     	ldrsw	x0, [sp, #0x38]
  8dc580: d37df000     	lsl	x0, x0, #3
  8dc584: 8b000020     	add	x0, x1, x0
  8dc588: f9400000     	ldr	x0, [x0]
  8dc58c: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc590: 394fcc00     	ldrb	w0, [x0, #0x3f3]
  8dc594: 3940ffe1     	ldrb	w1, [sp, #0x3f]
  8dc598: 0b010000     	add	w0, w0, w1
  8dc59c: 3900ffe0     	strb	w0, [sp, #0x3f]
  8dc5a0: 1400001a     	b	0x8dc608 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ddc>
  8dc5a4: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc5a8: f9400801     	ldr	x1, [x0, #0x10]
  8dc5ac: b9803be0     	ldrsw	x0, [sp, #0x38]
  8dc5b0: d37df000     	lsl	x0, x0, #3
  8dc5b4: 8b000020     	add	x0, x1, x0
  8dc5b8: f9400000     	ldr	x0, [x0]
  8dc5bc: 91002000     	add	x0, x0, #0x8
  8dc5c0: 97f1fbd0     	bl	0x55b500 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0x62450>
  8dc5c4: 7100041f     	cmp	w0, #0x1
  8dc5c8: 540000a0     	b.eq	0x8dc5dc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35db0>
  8dc5cc: 7100081f     	cmp	w0, #0x2
  8dc5d0: 540001a0     	b.eq	0x8dc604 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35dd8>
  8dc5d4: 7100001f     	cmp	w0, #0x0
  8dc5d8: 1400000c     	b	0x8dc608 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ddc>
  8dc5dc: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc5e0: f9400801     	ldr	x1, [x0, #0x10]
  8dc5e4: b9803be0     	ldrsw	x0, [sp, #0x38]
  8dc5e8: d37df000     	lsl	x0, x0, #3
  8dc5ec: 8b000020     	add	x0, x1, x0
  8dc5f0: f9400000     	ldr	x0, [x0]
  8dc5f4: 91400400     	add	x0, x0, #0x1, lsl #12   // =0x1000
  8dc5f8: 52800021     	mov	w1, #0x1                // =1
  8dc5fc: 390fc001     	strb	w1, [x0, #0x3f0]
  8dc600: 14000002     	b	0x8dc608 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ddc>
  8dc604: d503201f     	nop
  8dc608: b9403be0     	ldr	w0, [sp, #0x38]
  8dc60c: 11000400     	add	w0, w0, #0x1
  8dc610: b9003be0     	str	w0, [sp, #0x38]
  8dc614: 17ffffae     	b	0x8dc4cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ca0>
  8dc618: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc61c: f9401c03     	ldr	x3, [x0, #0x38]
  8dc620: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc624: f9402400     	ldr	x0, [x0, #0x48]
  8dc628: 3940ffe2     	ldrb	w2, [sp, #0x3f]
  8dc62c: aa0003e1     	mov	x1, x0
  8dc630: aa0303e0     	mov	x0, x3
  8dc634: 97ffa5aa     	bl	0x8c5cdc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f4b0>
  8dc638: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc63c: 97fffce9     	bl	0x8db9e0 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x351b4>
  8dc640: b9002fe0     	str	w0, [sp, #0x2c]
  8dc644: b9402fe0     	ldr	w0, [sp, #0x2c]
  8dc648: 7100001f     	cmp	w0, #0x0
  8dc64c: 54000461     	b.ne	0x8dc6d8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35eac>
  8dc650: d00026e0     	adrp	x0, 0xdba000
  8dc654: 91246002     	add	x2, x0, #0x918
  8dc658: 528050a1     	mov	w1, #0x285              // =645
  8dc65c: d00026e0     	adrp	x0, 0xdba000
  8dc660: 911e0000     	add	x0, x0, #0x780
  8dc664: 97f9a78e     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8dc668: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc66c: 97ffff64     	bl	0x8dc3fc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35bd0>
  8dc670: 12001c00     	and	w0, w0, #0xff
  8dc674: 7100001f     	cmp	w0, #0x0
  8dc678: 540002a0     	b.eq	0x8dc6cc <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ea0>
  8dc67c: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc680: f9401c00     	ldr	x0, [x0, #0x38]
  8dc684: 9106e000     	add	x0, x0, #0x1b8
  8dc688: 97eee327     	bl	0x495324 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5f378>
  8dc68c: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc690: f9401c02     	ldr	x2, [x0, #0x38]
  8dc694: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc698: f9402400     	ldr	x0, [x0, #0x48]
  8dc69c: aa0003e1     	mov	x1, x0
  8dc6a0: aa0203e0     	mov	x0, x2
  8dc6a4: 97ffa4bb     	bl	0x8c5990 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x1f164>
  8dc6a8: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc6ac: f900241f     	str	xzr, [x0, #0x48]
  8dc6b0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc6b4: f9400c00     	ldr	x0, [x0, #0x18]
  8dc6b8: 91038000     	add	x0, x0, #0xe0
  8dc6bc: 97f8c32a     	bl	0x70d364 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x1f2e4>
  8dc6c0: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc6c4: 97ffff6d     	bl	0x8dc478 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35c4c>
  8dc6c8: 1400000f     	b	0x8dc704 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ed8>
  8dc6cc: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc6d0: f900241f     	str	xzr, [x0, #0x48]
  8dc6d4: 1400000c     	b	0x8dc704 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ed8>
  8dc6d8: b9402fe3     	ldr	w3, [sp, #0x2c]
  8dc6dc: d00026e0     	adrp	x0, 0xdba000
  8dc6e0: 9124c002     	add	x2, x0, #0x930
  8dc6e4: 52805381     	mov	w1, #0x29c              // =668
  8dc6e8: d00026e0     	adrp	x0, 0xdba000
  8dc6ec: 911e0000     	add	x0, x0, #0x780
  8dc6f0: 97f9a76b     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  8dc6f4: 14000004     	b	0x8dc704 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ed8>
  8dc6f8: d503201f     	nop
  8dc6fc: 14000002     	b	0x8dc704 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIPKcS4_EESA_+0x35ed8>
  8dc700: d503201f     	nop
  8dc704: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  8dc708: d65f03c0     	ret
  8dc70c: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  8dc710: 910003fd     	mov	x29, sp
  8dc714: f9000fe0     	str	x0, [sp, #0x18]
  8dc718: 12800000     	mov	w0, #-0x1               // =-1
  8dc71c: b9002be0     	str	w0, [sp, #0x28]
  8dc720: b90027ff     	str	wzr, [sp, #0x24]
  8dc724: b9003fff     	str	wzr, [sp, #0x3c]
  8dc728: f9400fe0     	ldr	x0, [sp, #0x18]
  8dc72c: b9400801     	ldr	w1, [x0, #0x8]
  8dc730: b9403fe0     	ldr	w0, [sp, #0x3c]
