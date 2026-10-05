
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
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
