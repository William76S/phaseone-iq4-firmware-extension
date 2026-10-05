
analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000004f90b0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv>:
  5c1ba0: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  5c1ba4: 910003fd     	mov	x29, sp
  5c1ba8: f9000bf3     	str	x19, [sp, #0x10]
  5c1bac: f90017e0     	str	x0, [sp, #0x28]
  5c1bb0: f0002fe0     	adrp	x0, 0xbc0000
  5c1bb4: 910b4001     	add	x1, x0, #0x2d0
  5c1bb8: f94017e0     	ldr	x0, [sp, #0x28]
  5c1bbc: f9000001     	str	x1, [x0]
  5c1bc0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1bc4: 91002004     	add	x4, x0, #0x8
  5c1bc8: 52800023     	mov	w3, #0x1                // =1
  5c1bcc: 52800782     	mov	w2, #0x3c               // =60
  5c1bd0: f0002fe0     	adrp	x0, 0xbc0000
  5c1bd4: 91014001     	add	x1, x0, #0x50
  5c1bd8: aa0403e0     	mov	x0, x4
  5c1bdc: 97f92a50     	bl	0x40c51c <.text+0x12ec>
  5c1be0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1be4: 9103a004     	add	x4, x0, #0xe8
  5c1be8: 52800023     	mov	w3, #0x1                // =1
  5c1bec: 52800a02     	mov	w2, #0x50               // =80
  5c1bf0: f0002fe0     	adrp	x0, 0xbc0000
  5c1bf4: 91016001     	add	x1, x0, #0x58
  5c1bf8: aa0403e0     	mov	x0, x4
  5c1bfc: 97f92a48     	bl	0x40c51c <.text+0x12ec>
  5c1c00: f94017e0     	ldr	x0, [sp, #0x28]
  5c1c04: 91072004     	add	x4, x0, #0x1c8
  5c1c08: 52800023     	mov	w3, #0x1                // =1
  5c1c0c: 52800002     	mov	w2, #0x0                // =0
  5c1c10: f0002fe0     	adrp	x0, 0xbc0000
  5c1c14: 9101a001     	add	x1, x0, #0x68
  5c1c18: aa0403e0     	mov	x0, x4
  5c1c1c: 97f94b91     	bl	0x414a60 <.text+0x9830>
  5c1c20: f94017e0     	ldr	x0, [sp, #0x28]
  5c1c24: 910aa004     	add	x4, x0, #0x2a8
  5c1c28: 52800023     	mov	w3, #0x1                // =1
  5c1c2c: 52800002     	mov	w2, #0x0                // =0
  5c1c30: f0002fe0     	adrp	x0, 0xbc0000
  5c1c34: 9101e001     	add	x1, x0, #0x78
  5c1c38: aa0403e0     	mov	x0, x4
  5c1c3c: 97f94dc6     	bl	0x415354 <.text+0xa124>
  5c1c40: f94017e0     	ldr	x0, [sp, #0x28]
  5c1c44: 910e0004     	add	x4, x0, #0x380
  5c1c48: 52800023     	mov	w3, #0x1                // =1
  5c1c4c: 52800482     	mov	w2, #0x24               // =36
  5c1c50: f0002fe0     	adrp	x0, 0xbc0000
  5c1c54: 91024001     	add	x1, x0, #0x90
  5c1c58: aa0403e0     	mov	x0, x4
  5c1c5c: 97f92a30     	bl	0x40c51c <.text+0x12ec>
  5c1c60: f94017e0     	ldr	x0, [sp, #0x28]
  5c1c64: 91118004     	add	x4, x0, #0x460
  5c1c68: 52800023     	mov	w3, #0x1                // =1
  5c1c6c: 52800002     	mov	w2, #0x0                // =0
  5c1c70: f0002fe0     	adrp	x0, 0xbc0000
  5c1c74: 91028001     	add	x1, x0, #0xa0
  5c1c78: aa0403e0     	mov	x0, x4
  5c1c7c: 97f92a28     	bl	0x40c51c <.text+0x12ec>
  5c1c80: f94017e0     	ldr	x0, [sp, #0x28]
  5c1c84: 91150004     	add	x4, x0, #0x540
  5c1c88: 52800023     	mov	w3, #0x1                // =1
  5c1c8c: 52800002     	mov	w2, #0x0                // =0
  5c1c90: f0002fe0     	adrp	x0, 0xbc0000
  5c1c94: 9102c001     	add	x1, x0, #0xb0
  5c1c98: aa0403e0     	mov	x0, x4
  5c1c9c: 97f92a20     	bl	0x40c51c <.text+0x12ec>
  5c1ca0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1ca4: 91188004     	add	x4, x0, #0x620
  5c1ca8: 52800023     	mov	w3, #0x1                // =1
  5c1cac: 52800042     	mov	w2, #0x2                // =2
  5c1cb0: f0002fe0     	adrp	x0, 0xbc0000
  5c1cb4: 91030001     	add	x1, x0, #0xc0
  5c1cb8: aa0403e0     	mov	x0, x4
  5c1cbc: 9400014c     	bl	0x5c21ec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc913c>
  5c1cc0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1cc4: 911c0004     	add	x4, x0, #0x700
  5c1cc8: 52800023     	mov	w3, #0x1                // =1
  5c1ccc: 52800002     	mov	w2, #0x0                // =0
  5c1cd0: f0002fe0     	adrp	x0, 0xbc0000
  5c1cd4: 91034001     	add	x1, x0, #0xd0
  5c1cd8: aa0403e0     	mov	x0, x4
  5c1cdc: 97f94d9e     	bl	0x415354 <.text+0xa124>
  5c1ce0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1ce4: 911f6004     	add	x4, x0, #0x7d8
  5c1ce8: 52800023     	mov	w3, #0x1                // =1
  5c1cec: 52800182     	mov	w2, #0xc                // =12
  5c1cf0: f0002fe0     	adrp	x0, 0xbc0000
  5c1cf4: 91038001     	add	x1, x0, #0xe0
  5c1cf8: aa0403e0     	mov	x0, x4
  5c1cfc: 97f92a08     	bl	0x40c51c <.text+0x12ec>
  5c1d00: f94017e0     	ldr	x0, [sp, #0x28]
  5c1d04: 9122e004     	add	x4, x0, #0x8b8
  5c1d08: 52800023     	mov	w3, #0x1                // =1
  5c1d0c: 52801082     	mov	w2, #0x84               // =132
  5c1d10: f0002fe0     	adrp	x0, 0xbc0000
  5c1d14: 9103c001     	add	x1, x0, #0xf0
  5c1d18: aa0403e0     	mov	x0, x4
  5c1d1c: 97f92a00     	bl	0x40c51c <.text+0x12ec>
  5c1d20: f94017e0     	ldr	x0, [sp, #0x28]
  5c1d24: 91266004     	add	x4, x0, #0x998
  5c1d28: 52800023     	mov	w3, #0x1                // =1
  5c1d2c: 52800002     	mov	w2, #0x0                // =0
  5c1d30: f0002fe0     	adrp	x0, 0xbc0000
  5c1d34: 91040001     	add	x1, x0, #0x100
  5c1d38: aa0403e0     	mov	x0, x4
  5c1d3c: 97f94d86     	bl	0x415354 <.text+0xa124>
  5c1d40: f94017e0     	ldr	x0, [sp, #0x28]
  5c1d44: 9129c004     	add	x4, x0, #0xa70
  5c1d48: 52800023     	mov	w3, #0x1                // =1
  5c1d4c: 128011e2     	mov	w2, #-0x90              // =-144
  5c1d50: f0002fe0     	adrp	x0, 0xbc0000
  5c1d54: 91044001     	add	x1, x0, #0x110
  5c1d58: aa0403e0     	mov	x0, x4
  5c1d5c: 97f929f0     	bl	0x40c51c <.text+0x12ec>
  5c1d60: f94017e0     	ldr	x0, [sp, #0x28]
  5c1d64: 912d4004     	add	x4, x0, #0xb50
  5c1d68: 52800023     	mov	w3, #0x1                // =1
  5c1d6c: 52801202     	mov	w2, #0x90               // =144
  5c1d70: f0002fe0     	adrp	x0, 0xbc0000
  5c1d74: 9104c001     	add	x1, x0, #0x130
  5c1d78: aa0403e0     	mov	x0, x4
  5c1d7c: 97f929e8     	bl	0x40c51c <.text+0x12ec>
  5c1d80: f94017e0     	ldr	x0, [sp, #0x28]
  5c1d84: 9130c004     	add	x4, x0, #0xc30
  5c1d88: 52800023     	mov	w3, #0x1                // =1
  5c1d8c: 52800002     	mov	w2, #0x0                // =0
  5c1d90: f0002fe0     	adrp	x0, 0xbc0000
  5c1d94: 91054001     	add	x1, x0, #0x150
  5c1d98: aa0403e0     	mov	x0, x4
  5c1d9c: 97f94d6e     	bl	0x415354 <.text+0xa124>
  5c1da0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1da4: 91342004     	add	x4, x0, #0xd08
  5c1da8: 52800023     	mov	w3, #0x1                // =1
  5c1dac: 52800302     	mov	w2, #0x18               // =24
  5c1db0: f0002fe0     	adrp	x0, 0xbc0000
  5c1db4: 91056001     	add	x1, x0, #0x158
  5c1db8: aa0403e0     	mov	x0, x4
  5c1dbc: 97f929d8     	bl	0x40c51c <.text+0x12ec>
  5c1dc0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1dc4: 9137a004     	add	x4, x0, #0xde8
  5c1dc8: 52800023     	mov	w3, #0x1                // =1
  5c1dcc: 52801202     	mov	w2, #0x90               // =144
  5c1dd0: f0002fe0     	adrp	x0, 0xbc0000
  5c1dd4: 9105a001     	add	x1, x0, #0x168
  5c1dd8: aa0403e0     	mov	x0, x4
  5c1ddc: 97f929d0     	bl	0x40c51c <.text+0x12ec>
  5c1de0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1de4: 913b2004     	add	x4, x0, #0xec8
  5c1de8: 52800023     	mov	w3, #0x1                // =1
  5c1dec: 52800002     	mov	w2, #0x0                // =0
  5c1df0: f0002fe0     	adrp	x0, 0xbc0000
  5c1df4: 9105e001     	add	x1, x0, #0x178
  5c1df8: aa0403e0     	mov	x0, x4
  5c1dfc: 97f94d56     	bl	0x415354 <.text+0xa124>
  5c1e00: f94017e0     	ldr	x0, [sp, #0x28]
  5c1e04: 913e8004     	add	x4, x0, #0xfa0
  5c1e08: 52800023     	mov	w3, #0x1                // =1
  5c1e0c: 52800302     	mov	w2, #0x18               // =24
  5c1e10: f0002fe0     	adrp	x0, 0xbc0000
  5c1e14: 91064001     	add	x1, x0, #0x190
  5c1e18: aa0403e0     	mov	x0, x4
  5c1e1c: 97f929c0     	bl	0x40c51c <.text+0x12ec>
  5c1e20: f94017e1     	ldr	x1, [sp, #0x28]
  5c1e24: d2821000     	mov	x0, #0x1080             // =4224
  5c1e28: 8b000023     	add	x3, x1, x0
  5c1e2c: 52800022     	mov	w2, #0x1                // =1
  5c1e30: 1e241000     	fmov	s0, #8.00000000
  5c1e34: f0002fe0     	adrp	x0, 0xbc0000
  5c1e38: 91068001     	add	x1, x0, #0x1a0
  5c1e3c: aa0303e0     	mov	x0, x3
  5c1e40: 97f9c1e3     	bl	0x4325cc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE6lengthEv+0xe84>
  5c1e44: f94017e1     	ldr	x1, [sp, #0x28]
  5c1e48: d2822c00     	mov	x0, #0x1160             // =4448
  5c1e4c: 8b000024     	add	x4, x1, x0
  5c1e50: 52800023     	mov	w3, #0x1                // =1
  5c1e54: 52800a02     	mov	w2, #0x50               // =80
  5c1e58: f0002fe0     	adrp	x0, 0xbc0000
  5c1e5c: 9106e001     	add	x1, x0, #0x1b8
  5c1e60: aa0403e0     	mov	x0, x4
  5c1e64: 97f929ae     	bl	0x40c51c <.text+0x12ec>
  5c1e68: 14000067     	b	0x5c2004 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8f54>
  5c1e6c: aa0003f3     	mov	x19, x0
  5c1e70: f94017e1     	ldr	x1, [sp, #0x28]
  5c1e74: d2821000     	mov	x0, #0x1080             // =4224
  5c1e78: 8b000020     	add	x0, x1, x0
  5c1e7c: 97f9d480     	bl	0x43707c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x10d0>
  5c1e80: 14000002     	b	0x5c1e88 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8dd8>
  5c1e84: aa0003f3     	mov	x19, x0
  5c1e88: f94017e0     	ldr	x0, [sp, #0x28]
  5c1e8c: 913e8000     	add	x0, x0, #0xfa0
  5c1e90: 97f929d5     	bl	0x40c5e4 <.text+0x13b4>
  5c1e94: 14000002     	b	0x5c1e9c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8dec>
  5c1e98: aa0003f3     	mov	x19, x0
  5c1e9c: f94017e0     	ldr	x0, [sp, #0x28]
  5c1ea0: 913b2000     	add	x0, x0, #0xec8
  5c1ea4: 97f950a1     	bl	0x416128 <.text+0xaef8>
  5c1ea8: 14000002     	b	0x5c1eb0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e00>
  5c1eac: aa0003f3     	mov	x19, x0
  5c1eb0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1eb4: 9137a000     	add	x0, x0, #0xde8
  5c1eb8: 97f929cb     	bl	0x40c5e4 <.text+0x13b4>
  5c1ebc: 14000002     	b	0x5c1ec4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e14>
  5c1ec0: aa0003f3     	mov	x19, x0
  5c1ec4: f94017e0     	ldr	x0, [sp, #0x28]
  5c1ec8: 91342000     	add	x0, x0, #0xd08
  5c1ecc: 97f929c6     	bl	0x40c5e4 <.text+0x13b4>
  5c1ed0: 14000002     	b	0x5c1ed8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e28>
  5c1ed4: aa0003f3     	mov	x19, x0
  5c1ed8: f94017e0     	ldr	x0, [sp, #0x28]
  5c1edc: 9130c000     	add	x0, x0, #0xc30
  5c1ee0: 97f95092     	bl	0x416128 <.text+0xaef8>
  5c1ee4: 14000002     	b	0x5c1eec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e3c>
  5c1ee8: aa0003f3     	mov	x19, x0
  5c1eec: f94017e0     	ldr	x0, [sp, #0x28]
  5c1ef0: 912d4000     	add	x0, x0, #0xb50
  5c1ef4: 97f929bc     	bl	0x40c5e4 <.text+0x13b4>
  5c1ef8: 14000002     	b	0x5c1f00 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e50>
  5c1efc: aa0003f3     	mov	x19, x0
  5c1f00: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f04: 9129c000     	add	x0, x0, #0xa70
  5c1f08: 97f929b7     	bl	0x40c5e4 <.text+0x13b4>
  5c1f0c: 14000002     	b	0x5c1f14 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e64>
  5c1f10: aa0003f3     	mov	x19, x0
  5c1f14: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f18: 91266000     	add	x0, x0, #0x998
  5c1f1c: 97f95083     	bl	0x416128 <.text+0xaef8>
  5c1f20: 14000002     	b	0x5c1f28 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e78>
  5c1f24: aa0003f3     	mov	x19, x0
  5c1f28: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f2c: 9122e000     	add	x0, x0, #0x8b8
  5c1f30: 97f929ad     	bl	0x40c5e4 <.text+0x13b4>
  5c1f34: 14000002     	b	0x5c1f3c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8e8c>
  5c1f38: aa0003f3     	mov	x19, x0
  5c1f3c: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f40: 911f6000     	add	x0, x0, #0x7d8
  5c1f44: 97f929a8     	bl	0x40c5e4 <.text+0x13b4>
  5c1f48: 14000002     	b	0x5c1f50 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8ea0>
  5c1f4c: aa0003f3     	mov	x19, x0
  5c1f50: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f54: 911c0000     	add	x0, x0, #0x700
  5c1f58: 97f95074     	bl	0x416128 <.text+0xaef8>
  5c1f5c: 14000002     	b	0x5c1f64 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8eb4>
  5c1f60: aa0003f3     	mov	x19, x0
  5c1f64: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f68: 91188000     	add	x0, x0, #0x620
  5c1f6c: 940000d2     	bl	0x5c22b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc9204>
  5c1f70: 14000002     	b	0x5c1f78 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8ec8>
  5c1f74: aa0003f3     	mov	x19, x0
  5c1f78: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f7c: 91150000     	add	x0, x0, #0x540
  5c1f80: 97f92999     	bl	0x40c5e4 <.text+0x13b4>
  5c1f84: 14000002     	b	0x5c1f8c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8edc>
  5c1f88: aa0003f3     	mov	x19, x0
  5c1f8c: f94017e0     	ldr	x0, [sp, #0x28]
  5c1f90: 91118000     	add	x0, x0, #0x460
  5c1f94: 97f92994     	bl	0x40c5e4 <.text+0x13b4>
  5c1f98: 14000002     	b	0x5c1fa0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8ef0>
  5c1f9c: aa0003f3     	mov	x19, x0
  5c1fa0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1fa4: 910e0000     	add	x0, x0, #0x380
  5c1fa8: 97f9298f     	bl	0x40c5e4 <.text+0x13b4>
  5c1fac: 14000002     	b	0x5c1fb4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8f04>
  5c1fb0: aa0003f3     	mov	x19, x0
  5c1fb4: f94017e0     	ldr	x0, [sp, #0x28]
  5c1fb8: 910aa000     	add	x0, x0, #0x2a8
  5c1fbc: 97f9505b     	bl	0x416128 <.text+0xaef8>
  5c1fc0: 14000002     	b	0x5c1fc8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8f18>
  5c1fc4: aa0003f3     	mov	x19, x0
  5c1fc8: f94017e0     	ldr	x0, [sp, #0x28]
  5c1fcc: 91072000     	add	x0, x0, #0x1c8
  5c1fd0: 97f94173     	bl	0x41259c <.text+0x736c>
  5c1fd4: 14000002     	b	0x5c1fdc <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8f2c>
  5c1fd8: aa0003f3     	mov	x19, x0
  5c1fdc: f94017e0     	ldr	x0, [sp, #0x28]
  5c1fe0: 9103a000     	add	x0, x0, #0xe8
  5c1fe4: 97f92980     	bl	0x40c5e4 <.text+0x13b4>
  5c1fe8: 14000002     	b	0x5c1ff0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8f40>
  5c1fec: aa0003f3     	mov	x19, x0
  5c1ff0: f94017e0     	ldr	x0, [sp, #0x28]
  5c1ff4: 91002000     	add	x0, x0, #0x8
  5c1ff8: 97f9297b     	bl	0x40c5e4 <.text+0x13b4>
  5c1ffc: aa1303e0     	mov	x0, x19
  5c2000: 97f921d4     	bl	0x40a750 <_Unwind_Resume@plt>
  5c2004: f9400bf3     	ldr	x19, [sp, #0x10]
  5c2008: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  5c200c: d65f03c0     	ret
  5c2010: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5c2014: 910003fd     	mov	x29, sp
  5c2018: f9000fe0     	str	x0, [sp, #0x18]
  5c201c: d0002fe0     	adrp	x0, 0xbc0000
  5c2020: 910b4001     	add	x1, x0, #0x2d0
  5c2024: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2028: f9000001     	str	x1, [x0]
  5c202c: f9400fe1     	ldr	x1, [sp, #0x18]
  5c2030: d2822c00     	mov	x0, #0x1160             // =4448
  5c2034: 8b000020     	add	x0, x1, x0
  5c2038: 97f9296b     	bl	0x40c5e4 <.text+0x13b4>
  5c203c: f9400fe1     	ldr	x1, [sp, #0x18]
  5c2040: d2821000     	mov	x0, #0x1080             // =4224
  5c2044: 8b000020     	add	x0, x1, x0
  5c2048: 97f9d40d     	bl	0x43707c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x10d0>
  5c204c: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2050: 913e8000     	add	x0, x0, #0xfa0
  5c2054: 97f92964     	bl	0x40c5e4 <.text+0x13b4>
  5c2058: f9400fe0     	ldr	x0, [sp, #0x18]
  5c205c: 913b2000     	add	x0, x0, #0xec8
  5c2060: 97f95032     	bl	0x416128 <.text+0xaef8>
  5c2064: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2068: 9137a000     	add	x0, x0, #0xde8
  5c206c: 97f9295e     	bl	0x40c5e4 <.text+0x13b4>
  5c2070: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2074: 91342000     	add	x0, x0, #0xd08
  5c2078: 97f9295b     	bl	0x40c5e4 <.text+0x13b4>
  5c207c: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2080: 9130c000     	add	x0, x0, #0xc30
  5c2084: 97f95029     	bl	0x416128 <.text+0xaef8>
  5c2088: f9400fe0     	ldr	x0, [sp, #0x18]
  5c208c: 912d4000     	add	x0, x0, #0xb50
  5c2090: 97f92955     	bl	0x40c5e4 <.text+0x13b4>
  5c2094: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2098: 9129c000     	add	x0, x0, #0xa70
  5c209c: 97f92952     	bl	0x40c5e4 <.text+0x13b4>
  5c20a0: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20a4: 91266000     	add	x0, x0, #0x998
  5c20a8: 97f95020     	bl	0x416128 <.text+0xaef8>
  5c20ac: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20b0: 9122e000     	add	x0, x0, #0x8b8
  5c20b4: 97f9294c     	bl	0x40c5e4 <.text+0x13b4>
  5c20b8: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20bc: 911f6000     	add	x0, x0, #0x7d8
  5c20c0: 97f92949     	bl	0x40c5e4 <.text+0x13b4>
  5c20c4: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20c8: 911c0000     	add	x0, x0, #0x700
  5c20cc: 97f95017     	bl	0x416128 <.text+0xaef8>
  5c20d0: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20d4: 91188000     	add	x0, x0, #0x620
  5c20d8: 94000077     	bl	0x5c22b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc9204>
  5c20dc: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20e0: 91150000     	add	x0, x0, #0x540
  5c20e4: 97f92940     	bl	0x40c5e4 <.text+0x13b4>
  5c20e8: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20ec: 91118000     	add	x0, x0, #0x460
  5c20f0: 97f9293d     	bl	0x40c5e4 <.text+0x13b4>
  5c20f4: f9400fe0     	ldr	x0, [sp, #0x18]
  5c20f8: 910e0000     	add	x0, x0, #0x380
  5c20fc: 97f9293a     	bl	0x40c5e4 <.text+0x13b4>
  5c2100: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2104: 910aa000     	add	x0, x0, #0x2a8
  5c2108: 97f95008     	bl	0x416128 <.text+0xaef8>
  5c210c: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2110: 91072000     	add	x0, x0, #0x1c8
  5c2114: 97f94122     	bl	0x41259c <.text+0x736c>
  5c2118: f9400fe0     	ldr	x0, [sp, #0x18]
  5c211c: 9103a000     	add	x0, x0, #0xe8
  5c2120: 97f92931     	bl	0x40c5e4 <.text+0x13b4>
  5c2124: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2128: 91002000     	add	x0, x0, #0x8
  5c212c: 97f9292e     	bl	0x40c5e4 <.text+0x13b4>
  5c2130: d503201f     	nop
  5c2134: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  5c2138: d65f03c0     	ret
  5c213c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5c2140: 910003fd     	mov	x29, sp
  5c2144: f9000fe0     	str	x0, [sp, #0x18]
  5c2148: f9400fe0     	ldr	x0, [sp, #0x18]
  5c214c: 97ffffb1     	bl	0x5c2010 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc8f60>
  5c2150: d2824801     	mov	x1, #0x1240             // =4672
  5c2154: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2158: 97f91f22     	bl	0x409de0 <_ZdlPvm@plt>
  5c215c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  5c2160: d65f03c0     	ret
  5c2164: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5c2168: 910003fd     	mov	x29, sp
  5c216c: f9000fe0     	str	x0, [sp, #0x18]
  5c2170: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2174: 97f928ac     	bl	0x40c424 <.text+0x11f4>
  5c2178: d0002fe0     	adrp	x0, 0xbc0000
  5c217c: 910fe001     	add	x1, x0, #0x3f8
  5c2180: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2184: f9000001     	str	x1, [x0]
  5c2188: d503201f     	nop
  5c218c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  5c2190: d65f03c0     	ret
  5c2194: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5c2198: 910003fd     	mov	x29, sp
  5c219c: f9000fe0     	str	x0, [sp, #0x18]
  5c21a0: d0002fe0     	adrp	x0, 0xbc0000
  5c21a4: 910fe001     	add	x1, x0, #0x3f8
  5c21a8: f9400fe0     	ldr	x0, [sp, #0x18]
  5c21ac: f9000001     	str	x1, [x0]
  5c21b0: f9400fe0     	ldr	x0, [sp, #0x18]
  5c21b4: 97f928a5     	bl	0x40c448 <.text+0x1218>
  5c21b8: d503201f     	nop
  5c21bc: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  5c21c0: d65f03c0     	ret
  5c21c4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5c21c8: 910003fd     	mov	x29, sp
  5c21cc: f9000fe0     	str	x0, [sp, #0x18]
  5c21d0: f9400fe0     	ldr	x0, [sp, #0x18]
  5c21d4: 97fffff0     	bl	0x5c2194 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc90e4>
  5c21d8: d2800101     	mov	x1, #0x8                // =8
  5c21dc: f9400fe0     	ldr	x0, [sp, #0x18]
  5c21e0: 97f91f00     	bl	0x409de0 <_ZdlPvm@plt>
  5c21e4: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  5c21e8: d65f03c0     	ret
  5c21ec: a9bc7bfd     	stp	x29, x30, [sp, #-0x40]!
  5c21f0: 910003fd     	mov	x29, sp
  5c21f4: f9000bf3     	str	x19, [sp, #0x10]
  5c21f8: f9001fe0     	str	x0, [sp, #0x38]
  5c21fc: f9001be1     	str	x1, [sp, #0x30]
  5c2200: b9002fe2     	str	w2, [sp, #0x2c]
  5c2204: b9002be3     	str	w3, [sp, #0x28]
  5c2208: f9401fe0     	ldr	x0, [sp, #0x38]
  5c220c: 97ffffd6     	bl	0x5c2164 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc90b4>
  5c2210: f9401fe0     	ldr	x0, [sp, #0x38]
  5c2214: 91002000     	add	x0, x0, #0x8
  5c2218: f9401be1     	ldr	x1, [sp, #0x30]
  5c221c: 940533c4     	bl	0x70f12c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x210ac>
  5c2220: d0002fe0     	adrp	x0, 0xbc0000
  5c2224: 910bc001     	add	x1, x0, #0x2f0
  5c2228: f9401fe0     	ldr	x0, [sp, #0x38]
  5c222c: f9000001     	str	x1, [x0]
  5c2230: d0002fe0     	adrp	x0, 0xbc0000
  5c2234: 910e6001     	add	x1, x0, #0x398
  5c2238: f9401fe0     	ldr	x0, [sp, #0x38]
  5c223c: f9000401     	str	x1, [x0, #0x8]
  5c2240: d0002fe0     	adrp	x0, 0xbc0000
  5c2244: 910f6001     	add	x1, x0, #0x3d8
  5c2248: f9401fe0     	ldr	x0, [sp, #0x38]
  5c224c: f9001001     	str	x1, [x0, #0x20]
  5c2250: f9401fe0     	ldr	x0, [sp, #0x38]
  5c2254: b9402fe1     	ldr	w1, [sp, #0x2c]
  5c2258: b900c001     	str	w1, [x0, #0xc0]
  5c225c: f9401fe0     	ldr	x0, [sp, #0x38]
  5c2260: b9402fe1     	ldr	w1, [sp, #0x2c]
  5c2264: b900c401     	str	w1, [x0, #0xc4]
  5c2268: f9401fe0     	ldr	x0, [sp, #0x38]
  5c226c: b9402be1     	ldr	w1, [sp, #0x28]
  5c2270: b900c801     	str	w1, [x0, #0xc8]
  5c2274: f9401fe0     	ldr	x0, [sp, #0x38]
  5c2278: f900681f     	str	xzr, [x0, #0xd0]
  5c227c: f9401fe0     	ldr	x0, [sp, #0x38]
  5c2280: f9006c1f     	str	xzr, [x0, #0xd8]
  5c2284: f9401fe0     	ldr	x0, [sp, #0x38]
  5c2288: 52800061     	mov	w1, #0x3                // =3
  5c228c: b9001801     	str	w1, [x0, #0x18]
  5c2290: 14000006     	b	0x5c22a8 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc91f8>
  5c2294: aa0003f3     	mov	x19, x0
  5c2298: f9401fe0     	ldr	x0, [sp, #0x38]
  5c229c: 97ffffbe     	bl	0x5c2194 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc90e4>
  5c22a0: aa1303e0     	mov	x0, x19
  5c22a4: 97f9212b     	bl	0x40a750 <_Unwind_Resume@plt>
  5c22a8: f9400bf3     	ldr	x19, [sp, #0x10]
  5c22ac: a8c47bfd     	ldp	x29, x30, [sp], #0x40
  5c22b0: d65f03c0     	ret
  5c22b4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5c22b8: 910003fd     	mov	x29, sp
  5c22bc: f9000fe0     	str	x0, [sp, #0x18]
  5c22c0: d0002fe0     	adrp	x0, 0xbc0000
  5c22c4: 910bc001     	add	x1, x0, #0x2f0
  5c22c8: f9400fe0     	ldr	x0, [sp, #0x18]
  5c22cc: f9000001     	str	x1, [x0]
  5c22d0: d0002fe0     	adrp	x0, 0xbc0000
  5c22d4: 910e6001     	add	x1, x0, #0x398
  5c22d8: f9400fe0     	ldr	x0, [sp, #0x18]
  5c22dc: f9000401     	str	x1, [x0, #0x8]
  5c22e0: d0002fe0     	adrp	x0, 0xbc0000
  5c22e4: 910f6001     	add	x1, x0, #0x3d8
  5c22e8: f9400fe0     	ldr	x0, [sp, #0x18]
  5c22ec: f9001001     	str	x1, [x0, #0x20]
  5c22f0: f9400fe0     	ldr	x0, [sp, #0x18]
  5c22f4: 91002000     	add	x0, x0, #0x8
  5c22f8: 940533c4     	bl	0x70f208 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcN9__gnu_cxx17__normal_iteratorIS5_S4_EES8_+0x21188>
  5c22fc: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2300: 97ffffa5     	bl	0x5c2194 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc90e4>
  5c2304: d503201f     	nop
  5c2308: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  5c230c: d65f03c0     	ret
  5c2310: d1002000     	sub	x0, x0, #0x8
  5c2314: 17ffffe8     	b	0x5c22b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc9204>
  5c2318: d1008000     	sub	x0, x0, #0x20
  5c231c: 17ffffe6     	b	0x5c22b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc9204>
  5c2320: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  5c2324: 910003fd     	mov	x29, sp
  5c2328: f9000fe0     	str	x0, [sp, #0x18]
  5c232c: f9400fe0     	ldr	x0, [sp, #0x18]
  5c2330: 97ffffe1     	bl	0x5c22b4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE5c_strEv+0xc9204>
  5c2334: d2801c01     	mov	x1, #0xe0               // =224
  5c2338: f9400fe0     	ldr	x0, [sp, #0x18]
  5c233c: 97f91ea9     	bl	0x409de0 <_ZdlPvm@plt>
