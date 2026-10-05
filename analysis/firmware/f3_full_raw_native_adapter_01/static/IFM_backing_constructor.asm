  4959ec: a9b57bfd     	stp	x29, x30, [sp, #-0xb0]!
  4959f0: 910003fd     	mov	x29, sp
  4959f4: f9000bf3     	str	x19, [sp, #0x10]
  4959f8: f90017e0     	str	x0, [sp, #0x28]
  4959fc: f90013e1     	str	x1, [sp, #0x20]
  495a00: d0003740     	adrp	x0, 0xb7f000
  495a04: 91258001     	add	x1, x0, #0x960
  495a08: f94017e0     	ldr	x0, [sp, #0x28]
  495a0c: f9000001     	str	x1, [x0]
  495a10: f94017e0     	ldr	x0, [sp, #0x28]
  495a14: 91002004     	add	x4, x0, #0x8
  495a18: 52800003     	mov	w3, #0x0                // =0
  495a1c: 12800002     	mov	w2, #-0x1               // =-1
  495a20: d0003740     	adrp	x0, 0xb7f000
  495a24: 910ea001     	add	x1, x0, #0x3a8
  495a28: aa0403e0     	mov	x0, x4
  495a2c: 97fddabc     	bl	0x40c51c
  495a30: f94017e0     	ldr	x0, [sp, #0x28]
  495a34: 9103a004     	add	x4, x0, #0xe8
  495a38: 52800023     	mov	w3, #0x1                // =1
  495a3c: 12800002     	mov	w2, #-0x1               // =-1
  495a40: d0003740     	adrp	x0, 0xb7f000
  495a44: 910f0001     	add	x1, x0, #0x3c0
  495a48: aa0403e0     	mov	x0, x4
  495a4c: 97fddab4     	bl	0x40c51c
  495a50: f94017e0     	ldr	x0, [sp, #0x28]
  495a54: 91072004     	add	x4, x0, #0x1c8
  495a58: 52800023     	mov	w3, #0x1                // =1
  495a5c: 52800002     	mov	w2, #0x0                // =0
  495a60: d0003740     	adrp	x0, 0xb7f000
  495a64: 910f8001     	add	x1, x0, #0x3e0
  495a68: aa0403e0     	mov	x0, x4
  495a6c: 97fdfbfd     	bl	0x414a60
  495a70: f94017e0     	ldr	x0, [sp, #0x28]
  495a74: 910aa004     	add	x4, x0, #0x2a8
  495a78: 52800003     	mov	w3, #0x0                // =0
  495a7c: 52800002     	mov	w2, #0x0                // =0
  495a80: d0003740     	adrp	x0, 0xb7f000
  495a84: 910fc001     	add	x1, x0, #0x3f0
  495a88: aa0403e0     	mov	x0, x4
  495a8c: 97fddaa4     	bl	0x40c51c
  495a90: f94017e0     	ldr	x0, [sp, #0x28]
  495a94: 910e2004     	add	x4, x0, #0x388
  495a98: 52800003     	mov	w3, #0x0                // =0
  495a9c: 52800002     	mov	w2, #0x0                // =0
  495aa0: d0003740     	adrp	x0, 0xb7f000
  495aa4: 91100001     	add	x1, x0, #0x400
  495aa8: aa0403e0     	mov	x0, x4
  495aac: 97fdfbed     	bl	0x414a60
  495ab0: f94017e0     	ldr	x0, [sp, #0x28]
  495ab4: 9111a002     	add	x2, x0, #0x468
  495ab8: d0003740     	adrp	x0, 0xb7f000
  495abc: 91106001     	add	x1, x0, #0x418
  495ac0: aa0203e0     	mov	x0, x2
  495ac4: 9409e59a     	bl	0x70f12c
  495ac8: f94017e0     	ldr	x0, [sp, #0x28]
  495acc: 91148013     	add	x19, x0, #0x520
  495ad0: 9100e3e0     	add	x0, sp, #0x38
  495ad4: 52800002     	mov	w2, #0x0                // =0
  495ad8: 52800001     	mov	w1, #0x0                // =0
  495adc: 97fffd4d     	bl	0x495010
  495ae0: 52800023     	mov	w3, #0x1                // =1
  495ae4: f9401fe2     	ldr	x2, [sp, #0x38]
  495ae8: d0003740     	adrp	x0, 0xb7f000
  495aec: 9110c001     	add	x1, x0, #0x430
  495af0: aa1303e0     	mov	x0, x19
  495af4: 94000c22     	bl	0x498b7c
  495af8: f94017e0     	ldr	x0, [sp, #0x28]
  495afc: 91182002     	add	x2, x0, #0x608
  495b00: d0003740     	adrp	x0, 0xb7f000
  495b04: 91110001     	add	x1, x0, #0x440
  495b08: aa0203e0     	mov	x0, x2
  495b0c: 9409e588     	bl	0x70f12c
  495b10: f94017e0     	ldr	x0, [sp, #0x28]
  495b14: 911b0002     	add	x2, x0, #0x6c0
  495b18: d0003740     	adrp	x0, 0xb7f000
  495b1c: 91114001     	add	x1, x0, #0x450
  495b20: aa0203e0     	mov	x0, x2
  495b24: 9409e582     	bl	0x70f12c
  495b28: f94017e0     	ldr	x0, [sp, #0x28]
  495b2c: 911de004     	add	x4, x0, #0x778
  495b30: 52800003     	mov	w3, #0x0                // =0
  495b34: 52800002     	mov	w2, #0x0                // =0
  495b38: d0003740     	adrp	x0, 0xb7f000
  495b3c: 9111a001     	add	x1, x0, #0x468
  495b40: aa0403e0     	mov	x0, x4
  495b44: 97fdda76     	bl	0x40c51c
  495b48: f94017e0     	ldr	x0, [sp, #0x28]
  495b4c: 91216013     	add	x19, x0, #0x858
  495b50: 910103e0     	add	x0, sp, #0x40
  495b54: 12800001     	mov	w1, #-0x1               // =-1
  495b58: 94000b00     	bl	0x498758
  495b5c: 910103e0     	add	x0, sp, #0x40
  495b60: 52800003     	mov	w3, #0x0                // =0
  495b64: aa0003e2     	mov	x2, x0
  495b68: d0003740     	adrp	x0, 0xb7f000
  495b6c: 91120001     	add	x1, x0, #0x480
  495b70: aa1303e0     	mov	x0, x19
  495b74: 94000c88     	bl	0x498d94
  495b78: 910103e0     	add	x0, sp, #0x40
  495b7c: 94000b9c     	bl	0x4989ec
  495b80: f94017e0     	ldr	x0, [sp, #0x28]
  495b84: 91270002     	add	x2, x0, #0x9c0
  495b88: d0003740     	adrp	x0, 0xb7f000
  495b8c: 91126001     	add	x1, x0, #0x498
  495b90: aa0203e0     	mov	x0, x2
  495b94: 9409e566     	bl	0x70f12c
  495b98: f94017e0     	ldr	x0, [sp, #0x28]
  495b9c: 9129e004     	add	x4, x0, #0xa78
  495ba0: 52800003     	mov	w3, #0x0                // =0
  495ba4: 12800002     	mov	w2, #-0x1               // =-1
  495ba8: d0003740     	adrp	x0, 0xb7f000
  495bac: 9112a001     	add	x1, x0, #0x4a8
  495bb0: aa0403e0     	mov	x0, x4
  495bb4: 97fdda5a     	bl	0x40c51c
  495bb8: f94017e0     	ldr	x0, [sp, #0x28]
  495bbc: 912d6004     	add	x4, x0, #0xb58
  495bc0: 52800003     	mov	w3, #0x0                // =0
  495bc4: 12800002     	mov	w2, #-0x1               // =-1
  495bc8: d0003740     	adrp	x0, 0xb7f000
  495bcc: 91132001     	add	x1, x0, #0x4c8
  495bd0: aa0403e0     	mov	x0, x4
  495bd4: 97fdda52     	bl	0x40c51c
  495bd8: f94017e0     	ldr	x0, [sp, #0x28]
  495bdc: 9130e013     	add	x19, x0, #0xc38
  495be0: 910223e2     	add	x2, sp, #0x88
  495be4: b001d060     	adrp	x0, 0x3ea2000
  495be8: 9116a001     	add	x1, x0, #0x5a8
  495bec: aa0203e0     	mov	x0, x2
  495bf0: 94000b88     	bl	0x498a10
  495bf4: 910223e0     	add	x0, sp, #0x88
  495bf8: 52800023     	mov	w3, #0x1                // =1
  495bfc: aa0003e2     	mov	x2, x0
  495c00: d0003740     	adrp	x0, 0xb7f000
  495c04: 91138001     	add	x1, x0, #0x4e0
  495c08: aa1303e0     	mov	x0, x19
  495c0c: 94000cb8     	bl	0x498eec
  495c10: 910223e0     	add	x0, sp, #0x88
  495c14: 94000b95     	bl	0x498a68
  495c18: f94017e0     	ldr	x0, [sp, #0x28]
  495c1c: 91358002     	add	x2, x0, #0xd60
  495c20: d0003740     	adrp	x0, 0xb7f000
  495c24: 9113c001     	add	x1, x0, #0x4f0
  495c28: aa0203e0     	mov	x0, x2
  495c2c: 9409e540     	bl	0x70f12c
  495c30: f94017e0     	ldr	x0, [sp, #0x28]
  495c34: 91386002     	add	x2, x0, #0xe18
  495c38: d0003740     	adrp	x0, 0xb7f000
  495c3c: 91140001     	add	x1, x0, #0x500
  495c40: aa0203e0     	mov	x0, x2
  495c44: 9409e53a     	bl	0x70f12c
  495c48: f94017e0     	ldr	x0, [sp, #0x28]
  495c4c: 913b4004     	add	x4, x0, #0xed0
  495c50: 52800003     	mov	w3, #0x0                // =0
  495c54: 52800002     	mov	w2, #0x0                // =0
  495c58: d0003740     	adrp	x0, 0xb7f000
  495c5c: 91144001     	add	x1, x0, #0x510
  495c60: aa0403e0     	mov	x0, x4
  495c64: 97fdfdbc     	bl	0x415354
  495c68: f94017e0     	ldr	x0, [sp, #0x28]
  495c6c: f94013e1     	ldr	x1, [sp, #0x20]
  495c70: f907d401     	str	x1, [x0, #0xfa8]
  495c74: f94017e0     	ldr	x0, [sp, #0x28]
  495c78: b90fb01f     	str	wzr, [x0, #0xfb0]
  495c7c: f94017e0     	ldr	x0, [sp, #0x28]
  495c80: 393ed01f     	strb	wzr, [x0, #0xfb4]
  495c84: f94017e0     	ldr	x0, [sp, #0x28]
  495c88: 393ed41f     	strb	wzr, [x0, #0xfb5]
  495c8c: f94017e0     	ldr	x0, [sp, #0x28]
  495c90: 913ee003     	add	x3, x0, #0xfb8
  495c94: 52800002     	mov	w2, #0x0                // =0
  495c98: d0003740     	adrp	x0, 0xb7f000
  495c9c: 91148001     	add	x1, x0, #0x520
  495ca0: aa0303e0     	mov	x0, x3
  495ca4: 9409f0de     	bl	0x71201c
  495ca8: f94017e1     	ldr	x1, [sp, #0x28]
  495cac: d2980000     	mov	x0, #0xc000             // =49152
  495cb0: f2a0fe80     	movk	x0, #0x7f4, lsl #16
  495cb4: 8b000020     	add	x0, x1, x0
  495cb8: b90c401f     	str	wzr, [x0, #0xc40]
  495cbc: f94017e1     	ldr	x1, [sp, #0x28]
  495cc0: d2900000     	mov	x0, #0x8000             // =32768
  495cc4: f2a0fe80     	movk	x0, #0x7f4, lsl #16
  495cc8: 8b000020     	add	x0, x1, x0
  495ccc: d2800081     	mov	x1, #0x4                // =4
  495cd0: f9262401     	str	x1, [x0, #0x4c48]
  495cd4: f94017e1     	ldr	x1, [sp, #0x28]
  495cd8: d2998a00     	mov	x0, #0xcc50             // =52304
  495cdc: f2a0fe80     	movk	x0, #0x7f4, lsl #16
