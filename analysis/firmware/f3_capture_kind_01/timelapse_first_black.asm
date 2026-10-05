
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7a19fc: f9000401     	str	x1, [x0, #0x8]
  7a1a00: d503201f     	nop
  7a1a04: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  7a1a08: d65f03c0     	ret
  7a1a0c: d10043ff     	sub	sp, sp, #0x10
  7a1a10: f90007e0     	str	x0, [sp, #0x8]
  7a1a14: f0002e80     	adrp	x0, 0xd74000
  7a1a18: 913f8001     	add	x1, x0, #0xfe0
  7a1a1c: f94007e0     	ldr	x0, [sp, #0x8]
  7a1a20: f9000001     	str	x1, [x0]
  7a1a24: d503201f     	nop
  7a1a28: 910043ff     	add	sp, sp, #0x10
  7a1a2c: d65f03c0     	ret
  7a1a30: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a1a34: 910003fd     	mov	x29, sp
  7a1a38: f9000fe0     	str	x0, [sp, #0x18]
  7a1a3c: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1a40: 97fffff3     	bl	0x7a1a0c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87ce0>
  7a1a44: d2801001     	mov	x1, #0x80               // =128
  7a1a48: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1a4c: 97f1a0e5     	bl	0x409de0 <_ZdlPvm@plt>
  7a1a50: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a1a54: d65f03c0     	ret
  7a1a58: d10043ff     	sub	sp, sp, #0x10
  7a1a5c: f90007e0     	str	x0, [sp, #0x8]
  7a1a60: f94007e0     	ldr	x0, [sp, #0x8]
  7a1a64: b9405800     	ldr	w0, [x0, #0x58]
  7a1a68: 910043ff     	add	sp, sp, #0x10
  7a1a6c: d65f03c0     	ret
  7a1a70: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  7a1a74: 910003fd     	mov	x29, sp
  7a1a78: f9000bf3     	str	x19, [sp, #0x10]
  7a1a7c: f90017e0     	str	x0, [sp, #0x28]
  7a1a80: f94017e0     	ldr	x0, [sp, #0x28]
  7a1a84: f9401802     	ldr	x2, [x0, #0x30]
  7a1a88: f94017e0     	ldr	x0, [sp, #0x28]
  7a1a8c: f9401800     	ldr	x0, [x0, #0x30]
  7a1a90: f9400000     	ldr	x0, [x0]
  7a1a94: 91010000     	add	x0, x0, #0x40
  7a1a98: f9400001     	ldr	x1, [x0]
  7a1a9c: aa0203e0     	mov	x0, x2
  7a1aa0: d63f0020     	blr	x1
  7a1aa4: 2a0003e1     	mov	w1, w0
  7a1aa8: f94017e0     	ldr	x0, [sp, #0x28]
  7a1aac: b9005801     	str	w1, [x0, #0x58]
  7a1ab0: f94017e0     	ldr	x0, [sp, #0x28]
  7a1ab4: b9005c1f     	str	wzr, [x0, #0x5c]
  7a1ab8: f94017e0     	ldr	x0, [sp, #0x28]
  7a1abc: f9400c13     	ldr	x19, [x0, #0x18]
  7a1ac0: f94017e0     	ldr	x0, [sp, #0x28]
  7a1ac4: f9400800     	ldr	x0, [x0, #0x10]
  7a1ac8: 97ffff7b     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a1acc: aa0003e1     	mov	x1, x0
  7a1ad0: aa1303e0     	mov	x0, x19
  7a1ad4: 94022008     	bl	0x829af4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6db2c>
  7a1ad8: f94017e0     	ldr	x0, [sp, #0x28]
  7a1adc: 52800081     	mov	w1, #0x4                // =4
  7a1ae0: b9007001     	str	w1, [x0, #0x70]
  7a1ae4: f94017e0     	ldr	x0, [sp, #0x28]
  7a1ae8: b9405801     	ldr	w1, [x0, #0x58]
  7a1aec: f94017e0     	ldr	x0, [sp, #0x28]
  7a1af0: b9007801     	str	w1, [x0, #0x78]
  7a1af4: f94017e0     	ldr	x0, [sp, #0x28]
  7a1af8: b900741f     	str	wzr, [x0, #0x74]
  7a1afc: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b00: b900601f     	str	wzr, [x0, #0x60]
  7a1b04: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b08: f9402002     	ldr	x2, [x0, #0x40]
  7a1b0c: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b10: f9402000     	ldr	x0, [x0, #0x40]
  7a1b14: f9400000     	ldr	x0, [x0]
  7a1b18: 91010000     	add	x0, x0, #0x40
  7a1b1c: f9400001     	ldr	x1, [x0]
  7a1b20: aa0203e0     	mov	x0, x2
  7a1b24: d63f0020     	blr	x1
  7a1b28: 2a0003e1     	mov	w1, w0
  7a1b2c: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b30: b9006401     	str	w1, [x0, #0x64]
  7a1b34: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b38: b9406400     	ldr	w0, [x0, #0x64]
  7a1b3c: 7100041f     	cmp	w0, #0x1
  7a1b40: 1a9f17e0     	cset	w0, eq
  7a1b44: 12001c01     	and	w1, w0, #0xff
  7a1b48: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b4c: 3901a001     	strb	w1, [x0, #0x68]
  7a1b50: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b54: f9402803     	ldr	x3, [x0, #0x50]
  7a1b58: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b5c: f9402800     	ldr	x0, [x0, #0x50]
  7a1b60: f9400000     	ldr	x0, [x0]
  7a1b64: 91012000     	add	x0, x0, #0x48
  7a1b68: f9400002     	ldr	x2, [x0]
  7a1b6c: 52800021     	mov	w1, #0x1                // =1
  7a1b70: aa0303e0     	mov	x0, x3
  7a1b74: d63f0040     	blr	x2
  7a1b78: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b7c: b9406400     	ldr	w0, [x0, #0x64]
  7a1b80: 7100081f     	cmp	w0, #0x2
  7a1b84: 540001a1     	b.ne	0x7a1bb8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87e8c>
  7a1b88: f94017e0     	ldr	x0, [sp, #0x28]
  7a1b8c: f9400800     	ldr	x0, [x0, #0x10]
  7a1b90: 97ffff49     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a1b94: aa0003e1     	mov	x1, x0
  7a1b98: 52800080     	mov	w0, #0x4                // =4
  7a1b9c: b9048420     	str	w0, [x1, #0x484]
  7a1ba0: f94017e0     	ldr	x0, [sp, #0x28]
  7a1ba4: f9400800     	ldr	x0, [x0, #0x10]
  7a1ba8: 97ffff43     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a1bac: aa0003e1     	mov	x1, x0
  7a1bb0: 52800040     	mov	w0, #0x2                // =2
  7a1bb4: b9048820     	str	w0, [x1, #0x488]
  7a1bb8: f0002e80     	adrp	x0, 0xd74000
  7a1bbc: 91386000     	add	x0, x0, #0xe18
  7a1bc0: 940001f8     	bl	0x7a23a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88674>
  7a1bc4: 2a0003e1     	mov	w1, w0
  7a1bc8: f94017e0     	ldr	x0, [sp, #0x28]
  7a1bcc: b9007c01     	str	w1, [x0, #0x7c]
  7a1bd0: 52800020     	mov	w0, #0x1                // =1
  7a1bd4: f9400bf3     	ldr	x19, [sp, #0x10]
  7a1bd8: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7a1bdc: d65f03c0     	ret
  7a1be0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a1be4: 910003fd     	mov	x29, sp
  7a1be8: f9000fe0     	str	x0, [sp, #0x18]
  7a1bec: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1bf0: f9402803     	ldr	x3, [x0, #0x50]
  7a1bf4: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1bf8: f9402800     	ldr	x0, [x0, #0x50]
  7a1bfc: f9400000     	ldr	x0, [x0]
  7a1c00: 91012000     	add	x0, x0, #0x48
  7a1c04: f9400002     	ldr	x2, [x0]
  7a1c08: 52800001     	mov	w1, #0x0                // =0
  7a1c0c: aa0303e0     	mov	x0, x3
  7a1c10: d63f0040     	blr	x2
  7a1c14: 52800020     	mov	w0, #0x1                // =1
  7a1c18: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a1c1c: d65f03c0     	ret
  7a1c20: d10043ff     	sub	sp, sp, #0x10
  7a1c24: f90007e0     	str	x0, [sp, #0x8]
  7a1c28: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c2c: 3941a000     	ldrb	w0, [x0, #0x68]
  7a1c30: 7100001f     	cmp	w0, #0x0
  7a1c34: 54000080     	b.eq	0x7a1c44 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87f18>
  7a1c38: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c3c: 3901a01f     	strb	wzr, [x0, #0x68]
  7a1c40: 1400000f     	b	0x7a1c7c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87f50>
  7a1c44: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c48: b9405800     	ldr	w0, [x0, #0x58]
  7a1c4c: 7100001f     	cmp	w0, #0x0
  7a1c50: 540000c0     	b.eq	0x7a1c68 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87f3c>
  7a1c54: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c58: b9405800     	ldr	w0, [x0, #0x58]
  7a1c5c: 51000401     	sub	w1, w0, #0x1
  7a1c60: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c64: b9005801     	str	w1, [x0, #0x58]
  7a1c68: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c6c: b9405c00     	ldr	w0, [x0, #0x5c]
  7a1c70: 11000401     	add	w1, w0, #0x1
  7a1c74: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c78: b9005c01     	str	w1, [x0, #0x5c]
  7a1c7c: 52800020     	mov	w0, #0x1                // =1
  7a1c80: 910043ff     	add	sp, sp, #0x10
  7a1c84: d65f03c0     	ret
  7a1c88: d10043ff     	sub	sp, sp, #0x10
  7a1c8c: f90007e0     	str	x0, [sp, #0x8]
  7a1c90: f94007e0     	ldr	x0, [sp, #0x8]
  7a1c94: 3941a000     	ldrb	w0, [x0, #0x68]
  7a1c98: 52000000     	eor	w0, w0, #0x1
  7a1c9c: 12001c00     	and	w0, w0, #0xff
  7a1ca0: 7100001f     	cmp	w0, #0x0
  7a1ca4: 540000e0     	b.eq	0x7a1cc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87f94>
  7a1ca8: f94007e0     	ldr	x0, [sp, #0x8]
  7a1cac: b9405800     	ldr	w0, [x0, #0x58]
  7a1cb0: 7100001f     	cmp	w0, #0x0
  7a1cb4: 54000061     	b.ne	0x7a1cc0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87f94>
  7a1cb8: 52800020     	mov	w0, #0x1                // =1
  7a1cbc: 14000002     	b	0x7a1cc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87f98>
  7a1cc0: 52800000     	mov	w0, #0x0                // =0
  7a1cc4: 910043ff     	add	sp, sp, #0x10
  7a1cc8: d65f03c0     	ret
  7a1ccc: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a1cd0: 910003fd     	mov	x29, sp
  7a1cd4: f9000fe0     	str	x0, [sp, #0x18]
  7a1cd8: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1cdc: f9402803     	ldr	x3, [x0, #0x50]
  7a1ce0: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1ce4: f9402800     	ldr	x0, [x0, #0x50]
  7a1ce8: f9400000     	ldr	x0, [x0]
  7a1cec: 91012000     	add	x0, x0, #0x48
  7a1cf0: f9400002     	ldr	x2, [x0]
  7a1cf4: 52800001     	mov	w1, #0x0                // =0
  7a1cf8: aa0303e0     	mov	x0, x3
  7a1cfc: d63f0040     	blr	x2
  7a1d00: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1d04: 3901a01f     	strb	wzr, [x0, #0x68]
  7a1d08: f9400fe0     	ldr	x0, [sp, #0x18]
  7a1d0c: b900581f     	str	wzr, [x0, #0x58]
  7a1d10: 52800020     	mov	w0, #0x1                // =1
  7a1d14: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a1d18: d65f03c0     	ret
  7a1d1c: d10043ff     	sub	sp, sp, #0x10
  7a1d20: f90007e0     	str	x0, [sp, #0x8]
  7a1d24: 52800000     	mov	w0, #0x0                // =0
  7a1d28: 910043ff     	add	sp, sp, #0x10
  7a1d2c: d65f03c0     	ret
  7a1d30: a9b37bfd     	stp	x29, x30, [sp, #-0xd0]!
  7a1d34: 910003fd     	mov	x29, sp
  7a1d38: f9000bf3     	str	x19, [sp, #0x10]
  7a1d3c: f90017e0     	str	x0, [sp, #0x28]
  7a1d40: f94017e0     	ldr	x0, [sp, #0x28]
  7a1d44: f9400800     	ldr	x0, [x0, #0x10]
  7a1d48: 97fffedb     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a1d4c: f90067e0     	str	x0, [sp, #0xc8]
  7a1d50: f94067e0     	ldr	x0, [sp, #0xc8]
  7a1d54: 3912401f     	strb	wzr, [x0, #0x490]
  7a1d58: f94017e0     	ldr	x0, [sp, #0x28]
  7a1d5c: 3941a000     	ldrb	w0, [x0, #0x68]
  7a1d60: 7100001f     	cmp	w0, #0x0
  7a1d64: 54000100     	b.eq	0x7a1d84 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88058>
  7a1d68: f94067e0     	ldr	x0, [sp, #0xc8]
  7a1d6c: 52800021     	mov	w1, #0x1                // =1
  7a1d70: b9048401     	str	w1, [x0, #0x484]
  7a1d74: f94067e0     	ldr	x0, [sp, #0xc8]
  7a1d78: 52800021     	mov	w1, #0x1                // =1
  7a1d7c: 39124001     	strb	w1, [x0, #0x490]
  7a1d80: 1400008f     	b	0x7a1fbc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88290>
  7a1d84: f94067e0     	ldr	x0, [sp, #0xc8]
  7a1d88: b9440401     	ldr	w1, [x0, #0x404]
  7a1d8c: f94017e0     	ldr	x0, [sp, #0x28]
  7a1d90: b9006c01     	str	w1, [x0, #0x6c]
  7a1d94: f94017e0     	ldr	x0, [sp, #0x28]
  7a1d98: f9402402     	ldr	x2, [x0, #0x48]
  7a1d9c: f94017e0     	ldr	x0, [sp, #0x28]
  7a1da0: f9402400     	ldr	x0, [x0, #0x48]
  7a1da4: f9400000     	ldr	x0, [x0]
  7a1da8: 91010000     	add	x0, x0, #0x40
  7a1dac: f9400001     	ldr	x1, [x0]
  7a1db0: aa0203e0     	mov	x0, x2
  7a1db4: d63f0020     	blr	x1
  7a1db8: 12001c00     	and	w0, w0, #0xff
  7a1dbc: 7100001f     	cmp	w0, #0x0
  7a1dc0: 54000120     	b.eq	0x7a1de4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x880b8>
  7a1dc4: f94017e0     	ldr	x0, [sp, #0x28]
  7a1dc8: f9400c13     	ldr	x19, [x0, #0x18]
  7a1dcc: f94017e0     	ldr	x0, [sp, #0x28]
  7a1dd0: f9400800     	ldr	x0, [x0, #0x10]
  7a1dd4: 97fffeb8     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a1dd8: aa0003e1     	mov	x1, x0
  7a1ddc: aa1303e0     	mov	x0, x19
  7a1de0: 94021f45     	bl	0x829af4 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2EPKcmRKS3_+0x6db2c>
  7a1de4: f94017e0     	ldr	x0, [sp, #0x28]
  7a1de8: b9406400     	ldr	w0, [x0, #0x64]
  7a1dec: 7100041f     	cmp	w0, #0x1
  7a1df0: 54000081     	b.ne	0x7a1e00 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x880d4>
  7a1df4: f94067e0     	ldr	x0, [sp, #0xc8]
  7a1df8: 52800041     	mov	w1, #0x2                // =2
  7a1dfc: b9048401     	str	w1, [x0, #0x484]
  7a1e00: f94017e0     	ldr	x0, [sp, #0x28]
  7a1e04: b9406400     	ldr	w0, [x0, #0x64]
  7a1e08: 7100081f     	cmp	w0, #0x2
  7a1e0c: 540001a1     	b.ne	0x7a1e40 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88114>
  7a1e10: f94017e0     	ldr	x0, [sp, #0x28]
  7a1e14: f9400800     	ldr	x0, [x0, #0x10]
  7a1e18: 97fffea7     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a1e1c: aa0003e1     	mov	x1, x0
  7a1e20: 52800080     	mov	w0, #0x4                // =4
  7a1e24: b9048420     	str	w0, [x1, #0x484]
  7a1e28: f94017e0     	ldr	x0, [sp, #0x28]
  7a1e2c: f9400800     	ldr	x0, [x0, #0x10]
  7a1e30: 97fffea1     	bl	0x7a18b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87b88>
  7a1e34: aa0003e1     	mov	x1, x0
  7a1e38: 52800040     	mov	w0, #0x2                // =2
  7a1e3c: b9048820     	str	w0, [x1, #0x488]
  7a1e40: f94017e0     	ldr	x0, [sp, #0x28]
  7a1e44: f9401c02     	ldr	x2, [x0, #0x38]
  7a1e48: f94017e0     	ldr	x0, [sp, #0x28]
  7a1e4c: f9401c00     	ldr	x0, [x0, #0x38]
  7a1e50: f9400000     	ldr	x0, [x0]
  7a1e54: 91010000     	add	x0, x0, #0x40
  7a1e58: f9400001     	ldr	x1, [x0]
  7a1e5c: aa0203e0     	mov	x0, x2
  7a1e60: d63f0020     	blr	x1
  7a1e64: b900c7e0     	str	w0, [sp, #0xc4]
  7a1e68: b940c7e0     	ldr	w0, [sp, #0xc4]
  7a1e6c: 7100001f     	cmp	w0, #0x0
  7a1e70: 54000620     	b.eq	0x7a1f34 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88208>
  7a1e74: f94017e0     	ldr	x0, [sp, #0x28]
  7a1e78: b9406000     	ldr	w0, [x0, #0x60]
  7a1e7c: 7100001f     	cmp	w0, #0x0
  7a1e80: 540005a0     	b.eq	0x7a1f34 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88208>
  7a1e84: 97fdd4f2     	bl	0x71724c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x291cc>
  7a1e88: b900c3e0     	str	w0, [sp, #0xc0]
  7a1e8c: f94017e0     	ldr	x0, [sp, #0x28]
  7a1e90: b9406000     	ldr	w0, [x0, #0x60]
  7a1e94: b940c3e1     	ldr	w1, [sp, #0xc0]
  7a1e98: 4b000020     	sub	w0, w1, w0
  7a1e9c: b940c7e1     	ldr	w1, [sp, #0xc4]
  7a1ea0: 6b00003f     	cmp	w1, w0
  7a1ea4: 54000489     	b.ls	0x7a1f34 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88208>
  7a1ea8: f94017e0     	ldr	x0, [sp, #0x28]
  7a1eac: f9401400     	ldr	x0, [x0, #0x28]
  7a1eb0: 91002013     	add	x19, x0, #0x8
  7a1eb4: 97fdbb16     	bl	0x710b0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22a8c>
  7a1eb8: aa0003e1     	mov	x1, x0
  7a1ebc: 9100c3e0     	add	x0, sp, #0x30
  7a1ec0: aa0103e2     	mov	x2, x1
  7a1ec4: aa1303e1     	mov	x1, x19
  7a1ec8: 97fdb997     	bl	0x710524 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x224a4>
  7a1ecc: 97fdbb10     	bl	0x710b0c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22a8c>
  7a1ed0: aa0003e3     	mov	x3, x0
  7a1ed4: f94017e0     	ldr	x0, [sp, #0x28]
  7a1ed8: b9406001     	ldr	w1, [x0, #0x60]
  7a1edc: b940c3e0     	ldr	w0, [sp, #0xc0]
  7a1ee0: 4b000021     	sub	w1, w1, w0
  7a1ee4: b940c7e0     	ldr	w0, [sp, #0xc4]
  7a1ee8: 0b000020     	add	w0, w1, w0
  7a1eec: 9100c3e1     	add	x1, sp, #0x30
  7a1ef0: aa0103e2     	mov	x2, x1
  7a1ef4: 2a0003e1     	mov	w1, w0
  7a1ef8: aa0303e0     	mov	x0, x3
  7a1efc: 97fdc6c7     	bl	0x713a18 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x25998>
  7a1f00: f100001f     	cmp	x0, #0x0
  7a1f04: 1a9f07e0     	cset	w0, ne
  7a1f08: 12001c00     	and	w0, w0, #0xff
  7a1f0c: 7100001f     	cmp	w0, #0x0
  7a1f10: 540000e0     	b.eq	0x7a1f2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88200>
  7a1f14: f0002e80     	adrp	x0, 0xd74000
  7a1f18: 913c6002     	add	x2, x0, #0xf18
  7a1f1c: 528014c1     	mov	w1, #0xa6               // =166
  7a1f20: f0002e80     	adrp	x0, 0xd74000
  7a1f24: 913ce000     	add	x0, x0, #0xf38
  7a1f28: 97fe915d     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  7a1f2c: 9100c3e0     	add	x0, sp, #0x30
  7a1f30: 97fdb9b9     	bl	0x710614 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22594>
  7a1f34: f94017e0     	ldr	x0, [sp, #0x28]
  7a1f38: b9406000     	ldr	w0, [x0, #0x60]
  7a1f3c: b900bfe0     	str	w0, [sp, #0xbc]
  7a1f40: 97fdd4c3     	bl	0x71724c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x291cc>
  7a1f44: 2a0003e1     	mov	w1, w0
  7a1f48: f94017e0     	ldr	x0, [sp, #0x28]
  7a1f4c: b9006001     	str	w1, [x0, #0x60]
  7a1f50: f94017e0     	ldr	x0, [sp, #0x28]
  7a1f54: b9406001     	ldr	w1, [x0, #0x60]
  7a1f58: b940bfe0     	ldr	w0, [sp, #0xbc]
  7a1f5c: 4b000021     	sub	w1, w1, w0
  7a1f60: f94017e0     	ldr	x0, [sp, #0x28]
  7a1f64: b9405c00     	ldr	w0, [x0, #0x5c]
  7a1f68: 2a0003e5     	mov	w5, w0
  7a1f6c: b940c7e4     	ldr	w4, [sp, #0xc4]
  7a1f70: 2a0103e3     	mov	w3, w1
  7a1f74: f0002e80     	adrp	x0, 0xd74000
  7a1f78: 913da002     	add	x2, x0, #0xf68
  7a1f7c: 528015c1     	mov	w1, #0xae               // =174
  7a1f80: f0002e80     	adrp	x0, 0xd74000
  7a1f84: 913ce000     	add	x0, x0, #0xf38
  7a1f88: 97fe9145     	bl	0x74649c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x2c770>
  7a1f8c: f94017e0     	ldr	x0, [sp, #0x28]
  7a1f90: b9405c00     	ldr	w0, [x0, #0x5c]
  7a1f94: 11000401     	add	w1, w0, #0x1
  7a1f98: f94017e0     	ldr	x0, [sp, #0x28]
  7a1f9c: b9007401     	str	w1, [x0, #0x74]
  7a1fa0: f94067e0     	ldr	x0, [sp, #0xc8]
  7a1fa4: 91100000     	add	x0, x0, #0x400
  7a1fa8: 91001002     	add	x2, x0, #0x4
  7a1fac: f94017e0     	ldr	x0, [sp, #0x28]
  7a1fb0: 9101b000     	add	x0, x0, #0x6c
  7a1fb4: a9400400     	ldp	x0, x1, [x0]
  7a1fb8: a9000440     	stp	x0, x1, [x2]
  7a1fbc: 52800020     	mov	w0, #0x1                // =1
  7a1fc0: 14000006     	b	0x7a1fd8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x882ac>
  7a1fc4: aa0003f3     	mov	x19, x0
  7a1fc8: 9100c3e0     	add	x0, sp, #0x30
  7a1fcc: 97fdb992     	bl	0x710614 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x22594>
  7a1fd0: aa1303e0     	mov	x0, x19
  7a1fd4: 97f1a1df     	bl	0x40a750 <_Unwind_Resume@plt>
  7a1fd8: f9400bf3     	ldr	x19, [sp, #0x10]
  7a1fdc: a8cd7bfd     	ldp	x29, x30, [sp], #0xd0
  7a1fe0: d65f03c0     	ret
