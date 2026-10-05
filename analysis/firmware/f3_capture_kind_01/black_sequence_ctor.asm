
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000719d2c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm>:
  7a2b00: f9400fe0     	ldr	x0, [sp, #0x18]
  7a2b04: b9405801     	ldr	w1, [x0, #0x58]
  7a2b08: f94017e0     	ldr	x0, [sp, #0x28]
  7a2b0c: b9040401     	str	w1, [x0, #0x404]
  7a2b10: 52800020     	mov	w0, #0x1                // =1
  7a2b14: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  7a2b18: d65f03c0     	ret
  7a2b1c: d10043ff     	sub	sp, sp, #0x10
  7a2b20: f90007e0     	str	x0, [sp, #0x8]
  7a2b24: 52800020     	mov	w0, #0x1                // =1
  7a2b28: 910043ff     	add	sp, sp, #0x10
  7a2b2c: d65f03c0     	ret
  7a2b30: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  7a2b34: 910003fd     	mov	x29, sp
  7a2b38: b9001fe0     	str	w0, [sp, #0x1c]
  7a2b3c: b9001be1     	str	w1, [sp, #0x18]
  7a2b40: b9401fe0     	ldr	w0, [sp, #0x1c]
  7a2b44: 7100041f     	cmp	w0, #0x1
  7a2b48: 540013e1     	b.ne	0x7a2dc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89098>
  7a2b4c: b9401be1     	ldr	w1, [sp, #0x18]
  7a2b50: 529fffe0     	mov	w0, #0xffff             // =65535
  7a2b54: 6b00003f     	cmp	w1, w0
  7a2b58: 54001361     	b.ne	0x7a2dc4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x89098>
  7a2b5c: 52800004     	mov	w4, #0x0                // =0
  7a2b60: 52800003     	mov	w3, #0x0                // =0
  7a2b64: 52800002     	mov	w2, #0x0                // =0
  7a2b68: 12800001     	mov	w1, #-0x1               // =-1
  7a2b6c: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2b70: 91386000     	add	x0, x0, #0xe18
  7a2b74: 97f1be16     	bl	0x4123cc <.text+0x719c>
  7a2b78: 12800004     	mov	w4, #-0x1               // =-1
  7a2b7c: 12800003     	mov	w3, #-0x1               // =-1
  7a2b80: 12800002     	mov	w2, #-0x1               // =-1
  7a2b84: 12800001     	mov	w1, #-0x1               // =-1
  7a2b88: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2b8c: 91388000     	add	x0, x0, #0xe20
  7a2b90: 97f1be0f     	bl	0x4123cc <.text+0x719c>
  7a2b94: 52800004     	mov	w4, #0x0                // =0
  7a2b98: 52800003     	mov	w3, #0x0                // =0
  7a2b9c: 12800002     	mov	w2, #-0x1               // =-1
  7a2ba0: 12800001     	mov	w1, #-0x1               // =-1
  7a2ba4: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2ba8: 9138a000     	add	x0, x0, #0xe28
  7a2bac: 97f1be08     	bl	0x4123cc <.text+0x719c>
  7a2bb0: 12800004     	mov	w4, #-0x1               // =-1
  7a2bb4: 52800003     	mov	w3, #0x0                // =0
  7a2bb8: 12800002     	mov	w2, #-0x1               // =-1
  7a2bbc: 12800001     	mov	w1, #-0x1               // =-1
  7a2bc0: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2bc4: 9138c000     	add	x0, x0, #0xe30
  7a2bc8: 97f1be01     	bl	0x4123cc <.text+0x719c>
  7a2bcc: 12800fe4     	mov	w4, #-0x80              // =-128
  7a2bd0: 52800003     	mov	w3, #0x0                // =0
  7a2bd4: 12800fe2     	mov	w2, #-0x80              // =-128
  7a2bd8: 12800001     	mov	w1, #-0x1               // =-1
  7a2bdc: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2be0: 9138e000     	add	x0, x0, #0xe38
  7a2be4: 97f1bdfa     	bl	0x4123cc <.text+0x719c>
  7a2be8: 52800004     	mov	w4, #0x0                // =0
  7a2bec: 12800003     	mov	w3, #-0x1               // =-1
  7a2bf0: 52800002     	mov	w2, #0x0                // =0
  7a2bf4: 12800001     	mov	w1, #-0x1               // =-1
  7a2bf8: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2bfc: 91390000     	add	x0, x0, #0xe40
  7a2c00: 97f1bdf3     	bl	0x4123cc <.text+0x719c>
  7a2c04: 12800004     	mov	w4, #-0x1               // =-1
  7a2c08: 52800003     	mov	w3, #0x0                // =0
  7a2c0c: 52800002     	mov	w2, #0x0                // =0
  7a2c10: 12800001     	mov	w1, #-0x1               // =-1
  7a2c14: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2c18: 91392000     	add	x0, x0, #0xe48
  7a2c1c: 97f1bdec     	bl	0x4123cc <.text+0x719c>
  7a2c20: 12800004     	mov	w4, #-0x1               // =-1
  7a2c24: 12800003     	mov	w3, #-0x1               // =-1
  7a2c28: 52800002     	mov	w2, #0x0                // =0
  7a2c2c: 12800001     	mov	w1, #-0x1               // =-1
  7a2c30: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2c34: 91394000     	add	x0, x0, #0xe50
  7a2c38: 97f1bde5     	bl	0x4123cc <.text+0x719c>
  7a2c3c: 12800be4     	mov	w4, #-0x60              // =-96
  7a2c40: 12800be3     	mov	w3, #-0x60              // =-96
  7a2c44: 52800002     	mov	w2, #0x0                // =0
  7a2c48: 12800001     	mov	w1, #-0x1               // =-1
  7a2c4c: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2c50: 91396000     	add	x0, x0, #0xe58
  7a2c54: 97f1bdde     	bl	0x4123cc <.text+0x719c>
  7a2c58: 52800004     	mov	w4, #0x0                // =0
  7a2c5c: 12800003     	mov	w3, #-0x1               // =-1
  7a2c60: 12800002     	mov	w2, #-0x1               // =-1
  7a2c64: 12800001     	mov	w1, #-0x1               // =-1
  7a2c68: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2c6c: 91398000     	add	x0, x0, #0xe60
  7a2c70: 97f1bdd7     	bl	0x4123cc <.text+0x719c>
  7a2c74: 12800fe4     	mov	w4, #-0x80              // =-128
  7a2c78: 12800fe3     	mov	w3, #-0x80              // =-128
  7a2c7c: 12800fe2     	mov	w2, #-0x80              // =-128
  7a2c80: 12800001     	mov	w1, #-0x1               // =-1
  7a2c84: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2c88: 9139a000     	add	x0, x0, #0xe68
  7a2c8c: 97f1bdd0     	bl	0x4123cc <.text+0x719c>
  7a2c90: 52800804     	mov	w4, #0x40               // =64
  7a2c94: 52800803     	mov	w3, #0x40               // =64
  7a2c98: 52800802     	mov	w2, #0x40               // =64
  7a2c9c: 12800001     	mov	w1, #-0x1               // =-1
  7a2ca0: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2ca4: 9139c000     	add	x0, x0, #0xe70
  7a2ca8: 97f1bdc9     	bl	0x4123cc <.text+0x719c>
  7a2cac: 128009e4     	mov	w4, #-0x50              // =-80
  7a2cb0: 12800a43     	mov	w3, #-0x53              // =-83
  7a2cb4: 12800a82     	mov	w2, #-0x55              // =-85
  7a2cb8: 12800001     	mov	w1, #-0x1               // =-1
  7a2cbc: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2cc0: 9139e000     	add	x0, x0, #0xe78
  7a2cc4: 97f1bdc2     	bl	0x4123cc <.text+0x719c>
  7a2cc8: 12800204     	mov	w4, #-0x11              // =-17
  7a2ccc: 12800a23     	mov	w3, #-0x52              // =-82
  7a2cd0: 52800002     	mov	w2, #0x0                // =0
  7a2cd4: 12800001     	mov	w1, #-0x1               // =-1
  7a2cd8: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2cdc: 913a0000     	add	x0, x0, #0xe80
  7a2ce0: 97f1bdbb     	bl	0x4123cc <.text+0x719c>
  7a2ce4: 52800004     	mov	w4, #0x0                // =0
  7a2ce8: 12800f03     	mov	w3, #-0x79              // =-121
  7a2cec: 12800002     	mov	w2, #-0x1               // =-1
  7a2cf0: 12800001     	mov	w1, #-0x1               // =-1
  7a2cf4: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2cf8: 913a2000     	add	x0, x0, #0xe88
  7a2cfc: 97f1bdb4     	bl	0x4123cc <.text+0x719c>
  7a2d00: 52800004     	mov	w4, #0x0                // =0
  7a2d04: 52800003     	mov	w3, #0x0                // =0
  7a2d08: 52800002     	mov	w2, #0x0                // =0
  7a2d0c: 52800001     	mov	w1, #0x0                // =0
  7a2d10: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2d14: 913a4000     	add	x0, x0, #0xe90
  7a2d18: 97f1bdad     	bl	0x4123cc <.text+0x719c>
  7a2d1c: 52800004     	mov	w4, #0x0                // =0
  7a2d20: 52800003     	mov	w3, #0x0                // =0
  7a2d24: 52800002     	mov	w2, #0x0                // =0
  7a2d28: 12800fe1     	mov	w1, #-0x80              // =-128
  7a2d2c: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2d30: 913a6000     	add	x0, x0, #0xe98
  7a2d34: 97f1bda6     	bl	0x4123cc <.text+0x719c>
  7a2d38: 12800004     	mov	w4, #-0x1               // =-1
  7a2d3c: 12800003     	mov	w3, #-0x1               // =-1
  7a2d40: 12800002     	mov	w2, #-0x1               // =-1
  7a2d44: 12800fe1     	mov	w1, #-0x80              // =-128
  7a2d48: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2d4c: 913a8000     	add	x0, x0, #0xea0
  7a2d50: 97f1bd9f     	bl	0x4123cc <.text+0x719c>
  7a2d54: 52800004     	mov	w4, #0x0                // =0
  7a2d58: 52800003     	mov	w3, #0x0                // =0
  7a2d5c: 12800002     	mov	w2, #-0x1               // =-1
  7a2d60: 12800fe1     	mov	w1, #-0x80              // =-128
  7a2d64: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2d68: 913aa000     	add	x0, x0, #0xea8
  7a2d6c: 97f1bd98     	bl	0x4123cc <.text+0x719c>
  7a2d70: 52800004     	mov	w4, #0x0                // =0
  7a2d74: 12800003     	mov	w3, #-0x1               // =-1
  7a2d78: 52800002     	mov	w2, #0x0                // =0
  7a2d7c: 12800fe1     	mov	w1, #-0x80              // =-128
  7a2d80: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2d84: 913ac000     	add	x0, x0, #0xeb0
  7a2d88: 97f1bd91     	bl	0x4123cc <.text+0x719c>
  7a2d8c: 12800004     	mov	w4, #-0x1               // =-1
  7a2d90: 52800003     	mov	w3, #0x0                // =0
  7a2d94: 52800002     	mov	w2, #0x0                // =0
  7a2d98: 12800fe1     	mov	w1, #-0x80              // =-128
  7a2d9c: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2da0: 913ae000     	add	x0, x0, #0xeb8
  7a2da4: 97f1bd8a     	bl	0x4123cc <.text+0x719c>
  7a2da8: 12800fe4     	mov	w4, #-0x80              // =-128
  7a2dac: 12800fe3     	mov	w3, #-0x80              // =-128
  7a2db0: 12800fe2     	mov	w2, #-0x80              // =-128
  7a2db4: 12800fe1     	mov	w1, #-0x80              // =-128
  7a2db8: b001c0e0     	adrp	x0, 0x3fbf000 <_ZNSt5ctypeIcE2idE+0x305bed8>
  7a2dbc: 913b0000     	add	x0, x0, #0xec0
  7a2dc0: 97f1bd83     	bl	0x4123cc <.text+0x719c>
  7a2dc4: d503201f     	nop
  7a2dc8: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  7a2dcc: d65f03c0     	ret
  7a2dd0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
  7a2dd4: 910003fd     	mov	x29, sp
  7a2dd8: 529fffe1     	mov	w1, #0xffff             // =65535
  7a2ddc: 52800020     	mov	w0, #0x1                // =1
  7a2de0: 97ffff54     	bl	0x7a2b30 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x88e04>
  7a2de4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
  7a2de8: d65f03c0     	ret
  7a2dec: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  7a2df0: 910003fd     	mov	x29, sp
  7a2df4: f90027e0     	str	x0, [sp, #0x48]
  7a2df8: f90023e1     	str	x1, [sp, #0x40]
  7a2dfc: f9001fe2     	str	x2, [sp, #0x38]
  7a2e00: f9001be3     	str	x3, [sp, #0x30]
  7a2e04: f90017e4     	str	x4, [sp, #0x28]
  7a2e08: f90013e5     	str	x5, [sp, #0x20]
  7a2e0c: f9000fe6     	str	x6, [sp, #0x18]
  7a2e10: f9000be7     	str	x7, [sp, #0x10]
  7a2e14: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e18: 97fffaae     	bl	0x7a18d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4copyEPcmm+0x87ba4>
  7a2e1c: f0002e80     	adrp	x0, 0xd75000
  7a2e20: 91168001     	add	x1, x0, #0x5a0
  7a2e24: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e28: f9000001     	str	x1, [x0]
  7a2e2c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e30: f94023e1     	ldr	x1, [sp, #0x40]
  7a2e34: f9000801     	str	x1, [x0, #0x10]
  7a2e38: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e3c: f9401be1     	ldr	x1, [sp, #0x30]
  7a2e40: f9000c01     	str	x1, [x0, #0x18]
  7a2e44: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e48: f94017e1     	ldr	x1, [sp, #0x28]
  7a2e4c: f9001001     	str	x1, [x0, #0x20]
  7a2e50: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e54: f9400be1     	ldr	x1, [sp, #0x10]
  7a2e58: f9001401     	str	x1, [x0, #0x28]
  7a2e5c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e60: f9400fe1     	ldr	x1, [sp, #0x18]
  7a2e64: f9001801     	str	x1, [x0, #0x30]
  7a2e68: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e6c: f9401fe1     	ldr	x1, [sp, #0x38]
  7a2e70: f9001c01     	str	x1, [x0, #0x38]
  7a2e74: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e78: f94013e1     	ldr	x1, [sp, #0x20]
  7a2e7c: f9002001     	str	x1, [x0, #0x40]
  7a2e80: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e84: b900481f     	str	wzr, [x0, #0x48]
  7a2e88: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e8c: b9004c1f     	str	wzr, [x0, #0x4c]
  7a2e90: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e94: b900501f     	str	wzr, [x0, #0x50]
  7a2e98: f94027e0     	ldr	x0, [sp, #0x48]
  7a2e9c: b900541f     	str	wzr, [x0, #0x54]
  7a2ea0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ea4: b900581f     	str	wzr, [x0, #0x58]
  7a2ea8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2eac: b9005c1f     	str	wzr, [x0, #0x5c]
  7a2eb0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2eb4: b900601f     	str	wzr, [x0, #0x60]
  7a2eb8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ebc: b900641f     	str	wzr, [x0, #0x64]
  7a2ec0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ec4: 9101a001     	add	x1, x0, #0x68
  7a2ec8: f0002e80     	adrp	x0, 0xd75000
  7a2ecc: 910ca000     	add	x0, x0, #0x328
  7a2ed0: aa0103e2     	mov	x2, x1
  7a2ed4: aa0003e3     	mov	x3, x0
  7a2ed8: a9400460     	ldp	x0, x1, [x3]
  7a2edc: a9000440     	stp	x0, x1, [x2]
  7a2ee0: b9401060     	ldr	w0, [x3, #0x10]
  7a2ee4: b9001040     	str	w0, [x2, #0x10]
  7a2ee8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2eec: b9007c1f     	str	wzr, [x0, #0x7c]
  7a2ef0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ef4: b900801f     	str	wzr, [x0, #0x80]
  7a2ef8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2efc: b900841f     	str	wzr, [x0, #0x84]
  7a2f00: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f04: b900881f     	str	wzr, [x0, #0x88]
  7a2f08: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f0c: b9008c1f     	str	wzr, [x0, #0x8c]
  7a2f10: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f14: b900901f     	str	wzr, [x0, #0x90]
  7a2f18: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f1c: b900941f     	str	wzr, [x0, #0x94]
  7a2f20: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f24: f0002e81     	adrp	x1, 0xd75000
  7a2f28: 910c2021     	add	x1, x1, #0x308
  7a2f2c: f9000401     	str	x1, [x0, #0x8]
  7a2f30: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f34: f9402000     	ldr	x0, [x0, #0x40]
  7a2f38: 910a4000     	add	x0, x0, #0x290
  7a2f3c: 97f1c690     	bl	0x41497c <.text+0x974c>
  7a2f40: 12001c01     	and	w1, w0, #0xff
  7a2f44: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f48: 39029001     	strb	w1, [x0, #0xa4]
  7a2f4c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f50: f9402000     	ldr	x0, [x0, #0x40]
  7a2f54: 91226000     	add	x0, x0, #0x898
  7a2f58: 97f8e368     	bl	0x5dbcf8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xe2c48>
  7a2f5c: 2a0003e1     	mov	w1, w0
  7a2f60: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f64: b900a001     	str	w1, [x0, #0xa0]
  7a2f68: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f6c: f9402000     	ldr	x0, [x0, #0x40]
  7a2f70: 911f0000     	add	x0, x0, #0x7c0
  7a2f74: 97f1c682     	bl	0x41497c <.text+0x974c>
  7a2f78: 12001c01     	and	w1, w0, #0xff
  7a2f7c: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f80: 39027c01     	strb	w1, [x0, #0x9f]
  7a2f84: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f88: f9402000     	ldr	x0, [x0, #0x40]
  7a2f8c: 91372000     	add	x0, x0, #0xdc8
  7a2f90: 97f1c67b     	bl	0x41497c <.text+0x974c>
  7a2f94: 12001c01     	and	w1, w0, #0xff
  7a2f98: f94027e0     	ldr	x0, [sp, #0x48]
  7a2f9c: 39027801     	strb	w1, [x0, #0x9e]
  7a2fa0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fa4: f9402000     	ldr	x0, [x0, #0x40]
  7a2fa8: 9125e000     	add	x0, x0, #0x978
  7a2fac: 97f1c674     	bl	0x41497c <.text+0x974c>
  7a2fb0: 12001c01     	and	w1, w0, #0xff
  7a2fb4: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fb8: 39027401     	strb	w1, [x0, #0x9d]
  7a2fbc: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fc0: f9402000     	ldr	x0, [x0, #0x40]
  7a2fc4: 9106e000     	add	x0, x0, #0x1b8
  7a2fc8: 97f1c66d     	bl	0x41497c <.text+0x974c>
  7a2fcc: 12001c01     	and	w1, w0, #0xff
  7a2fd0: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fd4: 39027001     	strb	w1, [x0, #0x9c]
  7a2fd8: f94027e0     	ldr	x0, [sp, #0x48]
  7a2fdc: f9402000     	ldr	x0, [x0, #0x40]
  7a2fe0: 91304000     	add	x0, x0, #0xc10
  7a2fe4: 97f1c6d1     	bl	0x414b28 <.text+0x98f8>
  7a2fe8: 2a0003e1     	mov	w1, w0
  7a2fec: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ff0: b9009801     	str	w1, [x0, #0x98]
  7a2ff4: f94027e0     	ldr	x0, [sp, #0x48]
  7a2ff8: f9402000     	ldr	x0, [x0, #0x40]
  7a2ffc: 91294000     	add	x0, x0, #0xa50
