INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a3a88: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  9a3a8c: 910003fd     	mov	x29, sp
  9a3a90: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a3a94: aa0003f3     	mov	x19, x0
  9a3a98: 2a0203f4     	mov	w20, w2
  9a3a9c: f90013f5     	str	x21, [sp, #0x20]
  9a3aa0: aa0103f5     	mov	x21, x1
  9a3aa4: b9402401     	ldr	w1, [x0, #0x24]
  9a3aa8: 7101943f     	cmp	w1, #0x65
  9a3aac: 540000c0     	b.eq	0x9a3ac4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ca24>
  9a3ab0: f9400002     	ldr	x2, [x0]
  9a3ab4: 528002a4     	mov	w4, #0x15               // =21
  9a3ab8: f9400043     	ldr	x3, [x2]
  9a3abc: 29050444     	stp	w4, w1, [x2, #0x28]
  9a3ac0: d63f0060     	blr	x3
  9a3ac4: b9403660     	ldr	w0, [x19, #0x34]
  9a3ac8: b9415661     	ldr	w1, [x19, #0x154]
  9a3acc: 6b00003f     	cmp	w1, w0
  9a3ad0: 54000103     	b.lo	0x9a3af0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ca50>
  9a3ad4: f9400262     	ldr	x2, [x19]
  9a3ad8: 52800fc4     	mov	w4, #0x7e               // =126
  9a3adc: 12800001     	mov	w1, #-0x1               // =-1
  9a3ae0: aa1303e0     	mov	x0, x19
  9a3ae4: f9400443     	ldr	x3, [x2, #0x8]
  9a3ae8: b9002844     	str	w4, [x2, #0x28]
  9a3aec: d63f0060     	blr	x3
  9a3af0: f9400a61     	ldr	x1, [x19, #0x10]
  9a3af4: b40000e1     	cbz	x1, 0x9a3b10 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ca70>
  9a3af8: b9403663     	ldr	w3, [x19, #0x34]
  9a3afc: aa1303e0     	mov	x0, x19
  9a3b00: b9415664     	ldr	w4, [x19, #0x154]
  9a3b04: f9400022     	ldr	x2, [x1]
  9a3b08: a9008c24     	stp	x4, x3, [x1, #0x8]
  9a3b0c: d63f0040     	blr	x2
  9a3b10: f940fa60     	ldr	x0, [x19, #0x1f0]
  9a3b14: b9401801     	ldr	w1, [x0, #0x18]
  9a3b18: 34000081     	cbz	w1, 0x9a3b28 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ca88>
  9a3b1c: f9400401     	ldr	x1, [x0, #0x8]
  9a3b20: aa1303e0     	mov	x0, x19
  9a3b24: d63f0020     	blr	x1
  9a3b28: f940fe64     	ldr	x4, [x19, #0x1f8]
  9a3b2c: b9003fff     	str	wzr, [sp, #0x3c]
  9a3b30: b9415660     	ldr	w0, [x19, #0x154]
  9a3b34: aa1503e1     	mov	x1, x21
  9a3b38: b9403663     	ldr	w3, [x19, #0x34]
  9a3b3c: 9100f3e2     	add	x2, sp, #0x3c
  9a3b40: f9400484     	ldr	x4, [x4, #0x8]
  9a3b44: 4b000063     	sub	w3, w3, w0
  9a3b48: 6b14007f     	cmp	w3, w20
  9a3b4c: aa1303e0     	mov	x0, x19
  9a3b50: 1a949063     	csel	w3, w3, w20, ls
  9a3b54: d63f0080     	blr	x4
  9a3b58: b9415661     	ldr	w1, [x19, #0x154]
  9a3b5c: b9403fe2     	ldr	w2, [sp, #0x3c]
  9a3b60: f94013f5     	ldr	x21, [sp, #0x20]
  9a3b64: 0b020021     	add	w1, w1, w2
  9a3b68: b9015661     	str	w1, [x19, #0x154]
  9a3b6c: 2a0203e0     	mov	w0, w2
  9a3b70: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a3b74: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  9a3b78: d65f03c0     	ret
