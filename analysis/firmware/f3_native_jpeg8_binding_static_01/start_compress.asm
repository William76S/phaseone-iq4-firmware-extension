INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a39e0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  9a39e4: 910003fd     	mov	x29, sp
  9a39e8: b9402402     	ldr	w2, [x0, #0x24]
  9a39ec: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a39f0: aa0003f3     	mov	x19, x0
  9a39f4: 2a0103f4     	mov	w20, w1
  9a39f8: 7101905f     	cmp	w2, #0x64
  9a39fc: 540000c0     	b.eq	0x9a3a14 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c974>
  9a3a00: f9400003     	ldr	x3, [x0]
  9a3a04: 528002a4     	mov	w4, #0x15               // =21
  9a3a08: f9400061     	ldr	x1, [x3]
  9a3a0c: 29050864     	stp	w4, w2, [x3, #0x28]
  9a3a10: d63f0020     	blr	x1
  9a3a14: 35000314     	cbnz	w20, 0x9a3a74 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c9d4>
  9a3a18: f9400261     	ldr	x1, [x19]
  9a3a1c: aa1303e0     	mov	x0, x19
  9a3a20: f9401021     	ldr	x1, [x1, #0x20]
  9a3a24: d63f0020     	blr	x1
  9a3a28: f9401661     	ldr	x1, [x19, #0x28]
  9a3a2c: aa1303e0     	mov	x0, x19
  9a3a30: f9400821     	ldr	x1, [x1, #0x10]
  9a3a34: d63f0020     	blr	x1
  9a3a38: aa1303e0     	mov	x0, x19
  9a3a3c: 940010f7     	bl	0x9a7e18 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x30d78>
  9a3a40: f940fa61     	ldr	x1, [x19, #0x1f0]
  9a3a44: aa1303e0     	mov	x0, x19
  9a3a48: f9400021     	ldr	x1, [x1]
  9a3a4c: d63f0020     	blr	x1
  9a3a50: b901567f     	str	wzr, [x19, #0x154]
  9a3a54: b9412260     	ldr	w0, [x19, #0x120]
  9a3a58: 7100001f     	cmp	w0, #0x0
  9a3a5c: 1a9f07e0     	cset	w0, ne
  9a3a60: 11019400     	add	w0, w0, #0x65
  9a3a64: b9002660     	str	w0, [x19, #0x24]
  9a3a68: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a3a6c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  9a3a70: d65f03c0     	ret
  9a3a74: 52800001     	mov	w1, #0x0                // =0
  9a3a78: aa1303e0     	mov	x0, x19
  9a3a7c: 97fff9f7     	bl	0x9a2258 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b1b8>
  9a3a80: 17ffffe6     	b	0x9a3a18 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c978>
