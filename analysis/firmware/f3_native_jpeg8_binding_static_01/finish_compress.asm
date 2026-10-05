INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a22f0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  9a22f4: 910003fd     	mov	x29, sp
  9a22f8: b9402401     	ldr	w1, [x0, #0x24]
  9a22fc: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a2300: aa0003f3     	mov	x19, x0
  9a2304: 51019422     	sub	w2, w1, #0x65
  9a2308: 7100045f     	cmp	w2, #0x1
  9a230c: 54000949     	b.ls	0x9a2434 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b394>
  9a2310: 71019c3f     	cmp	w1, #0x67
  9a2314: 540000c0     	b.eq	0x9a232c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b28c>
  9a2318: f9400002     	ldr	x2, [x0]
  9a231c: 528002a4     	mov	w4, #0x15               // =21
  9a2320: f9400043     	ldr	x3, [x2]
  9a2324: 29050444     	stp	w4, w1, [x2, #0x28]
  9a2328: d63f0060     	blr	x3
  9a232c: f940fa60     	ldr	x0, [x19, #0x1f0]
  9a2330: b9401c01     	ldr	w1, [x0, #0x1c]
  9a2334: 35000501     	cbnz	w1, 0x9a23d4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b334>
  9a2338: f90013f5     	str	x21, [sp, #0x20]
  9a233c: 52800335     	mov	w21, #0x19              // =25
  9a2340: f9400001     	ldr	x1, [x0]
  9a2344: aa1303e0     	mov	x0, x19
  9a2348: 52800014     	mov	w20, #0x0               // =0
  9a234c: d63f0020     	blr	x1
  9a2350: b9416e60     	ldr	w0, [x19, #0x16c]
  9a2354: 34000300     	cbz	w0, 0x9a23b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b314>
  9a2358: f9400a62     	ldr	x2, [x19, #0x10]
  9a235c: 2a0003e1     	mov	w1, w0
  9a2360: 2a1403e3     	mov	w3, w20
  9a2364: aa1303e0     	mov	x0, x19
  9a2368: b4000082     	cbz	x2, 0x9a2378 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b2d8>
  9a236c: f9400044     	ldr	x4, [x2]
  9a2370: a9008443     	stp	x3, x1, [x2, #0x8]
  9a2374: d63f0080     	blr	x4
  9a2378: f9410662     	ldr	x2, [x19, #0x208]
  9a237c: d2800001     	mov	x1, #0x0                // =0
  9a2380: aa1303e0     	mov	x0, x19
  9a2384: f9400442     	ldr	x2, [x2, #0x8]
  9a2388: d63f0040     	blr	x2
  9a238c: 350003c0     	cbnz	w0, 0x9a2404 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b364>
  9a2390: f9400261     	ldr	x1, [x19]
  9a2394: aa1303e0     	mov	x0, x19
  9a2398: 11000694     	add	w20, w20, #0x1
  9a239c: f9400022     	ldr	x2, [x1]
  9a23a0: b9002835     	str	w21, [x1, #0x28]
  9a23a4: d63f0040     	blr	x2
  9a23a8: b9416e60     	ldr	w0, [x19, #0x16c]
  9a23ac: 6b00029f     	cmp	w20, w0
  9a23b0: 54fffd43     	b.lo	0x9a2358 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b2b8>
  9a23b4: f940fa61     	ldr	x1, [x19, #0x1f0]
  9a23b8: aa1303e0     	mov	x0, x19
  9a23bc: f9400821     	ldr	x1, [x1, #0x10]
  9a23c0: d63f0020     	blr	x1
  9a23c4: f940fa60     	ldr	x0, [x19, #0x1f0]
  9a23c8: b9401c01     	ldr	w1, [x0, #0x1c]
  9a23cc: 34fffba1     	cbz	w1, 0x9a2340 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b2a0>
  9a23d0: f94013f5     	ldr	x21, [sp, #0x20]
  9a23d4: aa1303e0     	mov	x0, x19
  9a23d8: f9410a61     	ldr	x1, [x19, #0x210]
  9a23dc: f9400c21     	ldr	x1, [x1, #0x18]
  9a23e0: d63f0020     	blr	x1
  9a23e4: f9401661     	ldr	x1, [x19, #0x28]
  9a23e8: aa1303e0     	mov	x0, x19
  9a23ec: f9401021     	ldr	x1, [x1, #0x20]
  9a23f0: d63f0020     	blr	x1
  9a23f4: aa1303e0     	mov	x0, x19
  9a23f8: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a23fc: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  9a2400: 14000632     	b	0x9a3cc8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2cc28>
  9a2404: b9416e60     	ldr	w0, [x19, #0x16c]
  9a2408: 11000694     	add	w20, w20, #0x1
  9a240c: 6b14001f     	cmp	w0, w20
  9a2410: 54fffa48     	b.hi	0x9a2358 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b2b8>
  9a2414: f940fa61     	ldr	x1, [x19, #0x1f0]
  9a2418: aa1303e0     	mov	x0, x19
  9a241c: f9400821     	ldr	x1, [x1, #0x10]
  9a2420: d63f0020     	blr	x1
  9a2424: f940fa60     	ldr	x0, [x19, #0x1f0]
  9a2428: b9401c01     	ldr	w1, [x0, #0x1c]
  9a242c: 34fff8a1     	cbz	w1, 0x9a2340 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b2a0>
  9a2430: 17ffffe8     	b	0x9a23d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b330>
  9a2434: b9403401     	ldr	w1, [x0, #0x34]
  9a2438: b9415402     	ldr	w2, [x0, #0x154]
  9a243c: 6b01005f     	cmp	w2, w1
  9a2440: 540000c2     	b.hs	0x9a2458 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b3b8>
  9a2444: f9400001     	ldr	x1, [x0]
  9a2448: 528008a3     	mov	w3, #0x45               // =69
  9a244c: f9400022     	ldr	x2, [x1]
  9a2450: b9002823     	str	w3, [x1, #0x28]
  9a2454: d63f0040     	blr	x2
  9a2458: f940fa61     	ldr	x1, [x19, #0x1f0]
  9a245c: aa1303e0     	mov	x0, x19
  9a2460: f9400821     	ldr	x1, [x1, #0x10]
  9a2464: d63f0020     	blr	x1
  9a2468: 17ffffb1     	b	0x9a232c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b28c>
