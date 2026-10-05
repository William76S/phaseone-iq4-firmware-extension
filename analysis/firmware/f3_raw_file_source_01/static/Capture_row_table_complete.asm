  7c7a98: a9bb7bfd     	stp	x29, x30, [sp, #-0x50]!
  7c7a9c: 910003fd     	mov	x29, sp
  7c7aa0: f9000bf3     	str	x19, [sp, #0x10]
  7c7aa4: f90017e0     	str	x0, [sp, #0x28]
  7c7aa8: f94017e0     	ldr	x0, [sp, #0x28]
  7c7aac: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7ab0: f100041f     	cmp	x0, #0x1
  7c7ab4: 540000c9     	b.ls	0x7c7acc
  7c7ab8: f94017e0     	ldr	x0, [sp, #0x28]
  7c7abc: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7ac0: 528175a1     	mov	w1, #0xbad              // =2989
  7c7ac4: 72a175a1     	movk	w1, #0xbad, lsl #16
  7c7ac8: b9000001     	str	w1, [x0]
  7c7acc: f94017e0     	ldr	x0, [sp, #0x28]
  7c7ad0: b9429c00     	ldr	w0, [x0, #0x29c]
  7c7ad4: 7100001f     	cmp	w0, #0x0
  7c7ad8: 54000b40     	b.eq	0x7c7c40
  7c7adc: f94017e0     	ldr	x0, [sp, #0x28]
  7c7ae0: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7ae4: f100041f     	cmp	x0, #0x1
  7c7ae8: 54000061     	b.ne	0x7c7af4
  7c7aec: 52800020     	mov	w0, #0x1                // =1
  7c7af0: 1400019d     	b	0x7c8164
  7c7af4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7af8: b9429c00     	ldr	w0, [x0, #0x29c]
  7c7afc: 531f7801     	lsl	w1, w0, #1
  7c7b00: 528a8200     	mov	w0, #0x5410             // =21520
  7c7b04: 6b00003f     	cmp	w1, w0
  7c7b08: 54000069     	b.ls	0x7c7b14
  7c7b0c: 52800000     	mov	w0, #0x0                // =0
  7c7b10: 14000195     	b	0x7c8164
  7c7b14: f94017e1     	ldr	x1, [sp, #0x28]
  7c7b18: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7b1c: 8b000033     	add	x19, x1, x0
  7c7b20: f94017e1     	ldr	x1, [sp, #0x28]
  7c7b24: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7b28: 8b000020     	add	x0, x1, x0
  7c7b2c: 940041cb     	bl	0x7d8258
  7c7b30: 2a0003e2     	mov	w2, w0
  7c7b34: 52802881     	mov	w1, #0x144              // =324
  7c7b38: aa1303e0     	mov	x0, x19
  7c7b3c: 97fff048     	bl	0x7c3c5c
  7c7b40: f90023e0     	str	x0, [sp, #0x40]
  7c7b44: f94023e0     	ldr	x0, [sp, #0x40]
  7c7b48: f100001f     	cmp	x0, #0x0
  7c7b4c: 540001a0     	b.eq	0x7c7b80
  7c7b50: f94017e1     	ldr	x1, [sp, #0x28]
  7c7b54: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7b58: 8b000023     	add	x3, x1, x0
  7c7b5c: f94017e0     	ldr	x0, [sp, #0x28]
  7c7b60: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7b64: aa0003e2     	mov	x2, x0
  7c7b68: f94023e1     	ldr	x1, [sp, #0x40]
  7c7b6c: aa0303e0     	mov	x0, x3
  7c7b70: 97fffba8     	bl	0x7c6a10
  7c7b74: 12001c00     	and	w0, w0, #0xff
  7c7b78: 7100001f     	cmp	w0, #0x0
  7c7b7c: 54000061     	b.ne	0x7c7b88
  7c7b80: 52800020     	mov	w0, #0x1                // =1
  7c7b84: 14000002     	b	0x7c7b8c
  7c7b88: 52800000     	mov	w0, #0x0                // =0
  7c7b8c: 7100001f     	cmp	w0, #0x0
  7c7b90: 54000060     	b.eq	0x7c7b9c
  7c7b94: 52800000     	mov	w0, #0x0                // =0
  7c7b98: 14000173     	b	0x7c8164
  7c7b9c: f94017e1     	ldr	x1, [sp, #0x28]
  7c7ba0: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7ba4: 8b000033     	add	x19, x1, x0
  7c7ba8: f94017e1     	ldr	x1, [sp, #0x28]
  7c7bac: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7bb0: 8b000020     	add	x0, x1, x0
  7c7bb4: 940041a9     	bl	0x7d8258
  7c7bb8: 2a0003e2     	mov	w2, w0
  7c7bbc: 528028a1     	mov	w1, #0x145              // =325
  7c7bc0: aa1303e0     	mov	x0, x19
  7c7bc4: 97fff026     	bl	0x7c3c5c
  7c7bc8: f90023e0     	str	x0, [sp, #0x40]
  7c7bcc: f94023e0     	ldr	x0, [sp, #0x40]
  7c7bd0: f100001f     	cmp	x0, #0x0
  7c7bd4: 54000240     	b.eq	0x7c7c1c
  7c7bd8: f94017e1     	ldr	x1, [sp, #0x28]
  7c7bdc: d2849f00     	mov	x0, #0x24f8             // =9464
  7c7be0: 8b000023     	add	x3, x1, x0
  7c7be4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7be8: f9526c01     	ldr	x1, [x0, #0x24d8]
  7c7bec: f94017e0     	ldr	x0, [sp, #0x28]
  7c7bf0: b9429c00     	ldr	w0, [x0, #0x29c]
  7c7bf4: 2a0003e0     	mov	w0, w0
  7c7bf8: d37ef400     	lsl	x0, x0, #2
  7c7bfc: 8b000020     	add	x0, x1, x0
  7c7c00: aa0003e2     	mov	x2, x0
  7c7c04: f94023e1     	ldr	x1, [sp, #0x40]
  7c7c08: aa0303e0     	mov	x0, x3
  7c7c0c: 97fffb81     	bl	0x7c6a10
  7c7c10: 12001c00     	and	w0, w0, #0xff
  7c7c14: 7100001f     	cmp	w0, #0x0
  7c7c18: 54000061     	b.ne	0x7c7c24
  7c7c1c: 52800020     	mov	w0, #0x1                // =1
  7c7c20: 14000002     	b	0x7c7c28
  7c7c24: 52800000     	mov	w0, #0x0                // =0
  7c7c28: 7100001f     	cmp	w0, #0x0
  7c7c2c: 54000060     	b.eq	0x7c7c38
  7c7c30: 52800000     	mov	w0, #0x0                // =0
  7c7c34: 1400014c     	b	0x7c8164
  7c7c38: 52800020     	mov	w0, #0x1                // =1
  7c7c3c: 1400014a     	b	0x7c8164
  7c7c40: f94017e0     	ldr	x0, [sp, #0x28]
  7c7c44: b9400401     	ldr	w1, [x0, #0x4]
  7c7c48: 528a8200     	mov	w0, #0x5410             // =21520
  7c7c4c: 6b00003f     	cmp	w1, w0
  7c7c50: 54000189     	b.ls	0x7c7c80
  7c7c54: 528026a3     	mov	w3, #0x135              // =309
  7c7c58: d0002de0     	adrp	x0, 0xd85000
  7c7c5c: 912c0002     	add	x2, x0, #0xb00
  7c7c60: d0002de0     	adrp	x0, 0xd85000
  7c7c64: 912fc001     	add	x1, x0, #0xbf0
  7c7c68: d0002de0     	adrp	x0, 0xd85000
  7c7c6c: 9130a000     	add	x0, x0, #0xc28
  7c7c70: 97f10a44     	bl	0x40a580
  7c7c74: 97fe92a5     	bl	0x76c708
  7c7c78: 52800020     	mov	w0, #0x1                // =1
  7c7c7c: 14000002     	b	0x7c7c84
  7c7c80: 52800000     	mov	w0, #0x0                // =0
  7c7c84: 7100001f     	cmp	w0, #0x0
  7c7c88: 54000060     	b.eq	0x7c7c94
  7c7c8c: 52800000     	mov	w0, #0x0                // =0
  7c7c90: 14000135     	b	0x7c8164
  7c7c94: f94017e0     	ldr	x0, [sp, #0x28]
  7c7c98: b9404000     	ldr	w0, [x0, #0x40]
  7c7c9c: 71000c1f     	cmp	w0, #0x3
  7c7ca0: 54000320     	b.eq	0x7c7d04
  7c7ca4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7ca8: b9404000     	ldr	w0, [x0, #0x40]
  7c7cac: 7100141f     	cmp	w0, #0x5
  7c7cb0: 540002a0     	b.eq	0x7c7d04
  7c7cb4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7cb8: b9404000     	ldr	w0, [x0, #0x40]
  7c7cbc: 7100181f     	cmp	w0, #0x6
  7c7cc0: 54000220     	b.eq	0x7c7d04
  7c7cc4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7cc8: b9404000     	ldr	w0, [x0, #0x40]
  7c7ccc: 7100201f     	cmp	w0, #0x8
  7c7cd0: 540001a0     	b.eq	0x7c7d04
  7c7cd4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7cd8: b9404000     	ldr	w0, [x0, #0x40]
  7c7cdc: 7100241f     	cmp	w0, #0x9
  7c7ce0: 54000120     	b.eq	0x7c7d04
  7c7ce4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7ce8: b9404000     	ldr	w0, [x0, #0x40]
  7c7cec: 71002c1f     	cmp	w0, #0xb
  7c7cf0: 540000a0     	b.eq	0x7c7d04
  7c7cf4: f94017e0     	ldr	x0, [sp, #0x28]
  7c7cf8: b9404000     	ldr	w0, [x0, #0x40]
  7c7cfc: 7100301f     	cmp	w0, #0xc
  7c7d00: 54000061     	b.ne	0x7c7d0c
  7c7d04: 52800020     	mov	w0, #0x1                // =1
  7c7d08: 14000002     	b	0x7c7d10
  7c7d0c: 52800000     	mov	w0, #0x0                // =0
  7c7d10: 3900ffe0     	strb	w0, [sp, #0x3f]
  7c7d14: f94017e0     	ldr	x0, [sp, #0x28]
  7c7d18: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7d1c: b9503000     	ldr	w0, [x0, #0x1030]
  7c7d20: 7100101f     	cmp	w0, #0x4
  7c7d24: 540000c0     	b.eq	0x7c7d3c
  7c7d28: f94017e0     	ldr	x0, [sp, #0x28]
  7c7d2c: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7d30: b9503000     	ldr	w0, [x0, #0x1030]
  7c7d34: 71000c1f     	cmp	w0, #0x3
  7c7d38: 54000141     	b.ne	0x7c7d60
  7c7d3c: f94017e1     	ldr	x1, [sp, #0x28]
  7c7d40: d29a0b00     	mov	x0, #0xd058             // =53336
  7c7d44: 8b000020     	add	x0, x1, x0
  7c7d48: 52804381     	mov	w1, #0x21c              // =540
  7c7d4c: 94004c67     	bl	0x7daee8
  7c7d50: 7100001f     	cmp	w0, #0x0
  7c7d54: 54000060     	b.eq	0x7c7d60
  7c7d58: 52800020     	mov	w0, #0x1                // =1
  7c7d5c: 14000002     	b	0x7c7d64
  7c7d60: 52800000     	mov	w0, #0x0                // =0
  7c7d64: 7100001f     	cmp	w0, #0x0
  7c7d68: 54000421     	b.ne	0x7c7dec
  7c7d6c: 3940ffe0     	ldrb	w0, [sp, #0x3f]
  7c7d70: 52000000     	eor	w0, w0, #0x1
  7c7d74: 12001c00     	and	w0, w0, #0xff
  7c7d78: 7100001f     	cmp	w0, #0x0
  7c7d7c: 54000380     	b.eq	0x7c7dec
  7c7d80: f94017e0     	ldr	x0, [sp, #0x28]
  7c7d84: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7d88: f100001f     	cmp	x0, #0x0
  7c7d8c: 540002c0     	b.eq	0x7c7de4
  7c7d90: b9004fff     	str	wzr, [sp, #0x4c]
  7c7d94: f94017e0     	ldr	x0, [sp, #0x28]
  7c7d98: b9400400     	ldr	w0, [x0, #0x4]
  7c7d9c: b9404fe1     	ldr	w1, [sp, #0x4c]
  7c7da0: 6b00003f     	cmp	w1, w0
  7c7da4: 54000202     	b.hs	0x7c7de4
  7c7da8: f94017e0     	ldr	x0, [sp, #0x28]
  7c7dac: b9400002     	ldr	w2, [x0]
  7c7db0: b9404fe0     	ldr	w0, [sp, #0x4c]
  7c7db4: 531f7801     	lsl	w1, w0, #1
  7c7db8: f94017e0     	ldr	x0, [sp, #0x28]
  7c7dbc: f9526c03     	ldr	x3, [x0, #0x24d8]
  7c7dc0: b9404fe0     	ldr	w0, [sp, #0x4c]
  7c7dc4: d37ef400     	lsl	x0, x0, #2
  7c7dc8: 8b000060     	add	x0, x3, x0
  7c7dcc: 1b017c41     	mul	w1, w2, w1
  7c7dd0: b9000001     	str	w1, [x0]
  7c7dd4: b9404fe0     	ldr	w0, [sp, #0x4c]
  7c7dd8: 11000400     	add	w0, w0, #0x1
  7c7ddc: b9004fe0     	str	w0, [sp, #0x4c]
  7c7de0: 17ffffed     	b	0x7c7d94
  7c7de4: 52800020     	mov	w0, #0x1                // =1
  7c7de8: 140000df     	b	0x7c8164
  7c7dec: f94017e0     	ldr	x0, [sp, #0x28]
  7c7df0: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7df4: f100001f     	cmp	x0, #0x0
  7c7df8: 54000181     	b.ne	0x7c7e28
  7c7dfc: 52802aa3     	mov	w3, #0x155              // =341
  7c7e00: d0002de0     	adrp	x0, 0xd85000
  7c7e04: 912c0002     	add	x2, x0, #0xb00
  7c7e08: d0002de0     	adrp	x0, 0xd85000
  7c7e0c: 91314001     	add	x1, x0, #0xc50
  7c7e10: d0002de0     	adrp	x0, 0xd85000
  7c7e14: 9130a000     	add	x0, x0, #0xc28
  7c7e18: 97f109da     	bl	0x40a580
  7c7e1c: 97fe923b     	bl	0x76c708
  7c7e20: 52800020     	mov	w0, #0x1                // =1
  7c7e24: 14000002     	b	0x7c7e2c
  7c7e28: 52800000     	mov	w0, #0x0                // =0
  7c7e2c: 7100001f     	cmp	w0, #0x0
  7c7e30: 54000060     	b.eq	0x7c7e3c
  7c7e34: 52800000     	mov	w0, #0x0                // =0
  7c7e38: 140000cb     	b	0x7c8164
  7c7e3c: f94017e0     	ldr	x0, [sp, #0x28]
  7c7e40: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7e44: f100041f     	cmp	x0, #0x1
  7c7e48: 54000061     	b.ne	0x7c7e54
  7c7e4c: 52800020     	mov	w0, #0x1                // =1
  7c7e50: 140000c5     	b	0x7c8164
  7c7e54: f94017e0     	ldr	x0, [sp, #0x28]
  7c7e58: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7e5c: f9681400     	ldr	x0, [x0, #0x5028]
  7c7e60: f100001f     	cmp	x0, #0x0
  7c7e64: 54000181     	b.ne	0x7c7e94
  7c7e68: 52802be3     	mov	w3, #0x15f              // =351
  7c7e6c: d0002de0     	adrp	x0, 0xd85000
  7c7e70: 912c0002     	add	x2, x0, #0xb00
  7c7e74: d0002de0     	adrp	x0, 0xd85000
  7c7e78: 912d8001     	add	x1, x0, #0xb60
  7c7e7c: d0002de0     	adrp	x0, 0xd85000
  7c7e80: 9130a000     	add	x0, x0, #0xc28
  7c7e84: 97f109bf     	bl	0x40a580
  7c7e88: 97fe9220     	bl	0x76c708
  7c7e8c: 52800020     	mov	w0, #0x1                // =1
  7c7e90: 14000002     	b	0x7c7e98
  7c7e94: 52800000     	mov	w0, #0x0                // =0
  7c7e98: 7100001f     	cmp	w0, #0x0
  7c7e9c: 54000060     	b.eq	0x7c7ea8
  7c7ea0: 52800000     	mov	w0, #0x0                // =0
  7c7ea4: 140000b0     	b	0x7c8164
  7c7ea8: f94017e0     	ldr	x0, [sp, #0x28]
  7c7eac: b9400400     	ldr	w0, [x0, #0x4]
  7c7eb0: 531e7400     	lsl	w0, w0, #2
  7c7eb4: b9003be0     	str	w0, [sp, #0x38]
  7c7eb8: f94017e0     	ldr	x0, [sp, #0x28]
  7c7ebc: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7ec0: b9503000     	ldr	w0, [x0, #0x1030]
  7c7ec4: 7100041f     	cmp	w0, #0x1
  7c7ec8: 54000941     	b.ne	0x7c7ff0
  7c7ecc: f94017e0     	ldr	x0, [sp, #0x28]
  7c7ed0: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7ed4: f9681404     	ldr	x4, [x0, #0x5028]
  7c7ed8: f94017e0     	ldr	x0, [sp, #0x28]
  7c7edc: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7ee0: f9681400     	ldr	x0, [x0, #0x5028]
  7c7ee4: f9400000     	ldr	x0, [x0]
  7c7ee8: 91012000     	add	x0, x0, #0x48
  7c7eec: f9400003     	ldr	x3, [x0]
  7c7ef0: b9403be0     	ldr	w0, [sp, #0x38]
  7c7ef4: 4b0003e0     	neg	w0, w0
  7c7ef8: 52800042     	mov	w2, #0x2                // =2
  7c7efc: 2a0003e1     	mov	w1, w0
  7c7f00: aa0403e0     	mov	x0, x4
  7c7f04: d63f0060     	blr	x3
  7c7f08: 7100001f     	cmp	w0, #0x0
  7c7f0c: 5400018a     	b.ge	0x7c7f3c
  7c7f10: 52802d43     	mov	w3, #0x16a              // =362
  7c7f14: d0002de0     	adrp	x0, 0xd85000
  7c7f18: 912c0002     	add	x2, x0, #0xb00
  7c7f1c: d0002de0     	adrp	x0, 0xd85000
  7c7f20: 91320001     	add	x1, x0, #0xc80
  7c7f24: d0002de0     	adrp	x0, 0xd85000
  7c7f28: 9130a000     	add	x0, x0, #0xc28
  7c7f2c: 97f10995     	bl	0x40a580
  7c7f30: 97fe91f6     	bl	0x76c708
  7c7f34: 52800020     	mov	w0, #0x1                // =1
  7c7f38: 14000002     	b	0x7c7f40
  7c7f3c: 52800000     	mov	w0, #0x0                // =0
  7c7f40: 7100001f     	cmp	w0, #0x0
  7c7f44: 540000a0     	b.eq	0x7c7f58
  7c7f48: f94017e0     	ldr	x0, [sp, #0x28]
  7c7f4c: 97fffca0     	bl	0x7c71cc
  7c7f50: 52800000     	mov	w0, #0x0                // =0
  7c7f54: 14000084     	b	0x7c8164
  7c7f58: f94017e0     	ldr	x0, [sp, #0x28]
  7c7f5c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7f60: f9681404     	ldr	x4, [x0, #0x5028]
  7c7f64: f94017e0     	ldr	x0, [sp, #0x28]
  7c7f68: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c7f6c: f9681400     	ldr	x0, [x0, #0x5028]
  7c7f70: f9400000     	ldr	x0, [x0]
  7c7f74: 91006000     	add	x0, x0, #0x18
  7c7f78: f9400003     	ldr	x3, [x0]
  7c7f7c: f94017e0     	ldr	x0, [sp, #0x28]
  7c7f80: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c7f84: b9403be2     	ldr	w2, [sp, #0x38]
  7c7f88: aa0003e1     	mov	x1, x0
  7c7f8c: aa0403e0     	mov	x0, x4
  7c7f90: d63f0060     	blr	x3
  7c7f94: b90037e0     	str	w0, [sp, #0x34]
  7c7f98: b94037e1     	ldr	w1, [sp, #0x34]
  7c7f9c: b9403be0     	ldr	w0, [sp, #0x38]
  7c7fa0: 6b00003f     	cmp	w1, w0
  7c7fa4: 54000180     	b.eq	0x7c7fd4
  7c7fa8: 52802e23     	mov	w3, #0x171              // =369
  7c7fac: d0002de0     	adrp	x0, 0xd85000
  7c7fb0: 912c0002     	add	x2, x0, #0xb00
  7c7fb4: d0002de0     	adrp	x0, 0xd85000
  7c7fb8: 9132c001     	add	x1, x0, #0xcb0
  7c7fbc: d0002de0     	adrp	x0, 0xd85000
  7c7fc0: 9130a000     	add	x0, x0, #0xc28
  7c7fc4: 97f1096f     	bl	0x40a580
  7c7fc8: 97fe91d0     	bl	0x76c708
  7c7fcc: 52800020     	mov	w0, #0x1                // =1
  7c7fd0: 14000002     	b	0x7c7fd8
  7c7fd4: 52800000     	mov	w0, #0x0                // =0
  7c7fd8: 7100001f     	cmp	w0, #0x0
  7c7fdc: 540000a0     	b.eq	0x7c7ff0
  7c7fe0: f94017e0     	ldr	x0, [sp, #0x28]
  7c7fe4: 97fffc7a     	bl	0x7c71cc
  7c7fe8: 52800000     	mov	w0, #0x0                // =0
  7c7fec: 1400005e     	b	0x7c8164
  7c7ff0: f94017e0     	ldr	x0, [sp, #0x28]
  7c7ff4: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c7ff8: b9503000     	ldr	w0, [x0, #0x1030]
  7c7ffc: 7100101f     	cmp	w0, #0x4
  7c8000: 540000c0     	b.eq	0x7c8018
  7c8004: f94017e0     	ldr	x0, [sp, #0x28]
  7c8008: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c800c: b9503000     	ldr	w0, [x0, #0x1030]
  7c8010: 71000c1f     	cmp	w0, #0x3
  7c8014: 54000a61     	b.ne	0x7c8160
  7c8018: f94017e1     	ldr	x1, [sp, #0x28]
  7c801c: d29a0b00     	mov	x0, #0xd058             // =53336
  7c8020: 8b000020     	add	x0, x1, x0
  7c8024: 52804381     	mov	w1, #0x21c              // =540
  7c8028: 94004bb0     	bl	0x7daee8
  7c802c: 2a0003e1     	mov	w1, w0
  7c8030: b9403be0     	ldr	w0, [sp, #0x38]
  7c8034: 6b01001f     	cmp	w0, w1
  7c8038: 1a9f07e0     	cset	w0, ne
  7c803c: 12001c00     	and	w0, w0, #0xff
  7c8040: 7100001f     	cmp	w0, #0x0
  7c8044: 54000060     	b.eq	0x7c8050
  7c8048: 52800000     	mov	w0, #0x0                // =0
  7c804c: 14000046     	b	0x7c8164
  7c8050: f94017e1     	ldr	x1, [sp, #0x28]
  7c8054: d29a0b00     	mov	x0, #0xd058             // =53336
  7c8058: 8b000026     	add	x6, x1, x0
  7c805c: f94017e0     	ldr	x0, [sp, #0x28]
  7c8060: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c8064: f9681401     	ldr	x1, [x0, #0x5028]
  7c8068: f94017e0     	ldr	x0, [sp, #0x28]
  7c806c: f9526c00     	ldr	x0, [x0, #0x24d8]
  7c8070: b9403be2     	ldr	w2, [sp, #0x38]
  7c8074: 52800005     	mov	w5, #0x0                // =0
  7c8078: 2a0203e4     	mov	w4, w2
  7c807c: aa0003e3     	mov	x3, x0
  7c8080: 52804382     	mov	w2, #0x21c              // =540
  7c8084: aa0603e0     	mov	x0, x6
  7c8088: 94004bb2     	bl	0x7daf50
  7c808c: 12001c00     	and	w0, w0, #0xff
  7c8090: 52000000     	eor	w0, w0, #0x1
  7c8094: 12001c00     	and	w0, w0, #0xff
  7c8098: 7100001f     	cmp	w0, #0x0
  7c809c: 540000a0     	b.eq	0x7c80b0
  7c80a0: f94017e0     	ldr	x0, [sp, #0x28]
  7c80a4: 97fffc4a     	bl	0x7c71cc
  7c80a8: 52800000     	mov	w0, #0x0                // =0
  7c80ac: 1400002e     	b	0x7c8164
  7c80b0: f94017e0     	ldr	x0, [sp, #0x28]
  7c80b4: 9400002f     	bl	0x7c8170
  7c80b8: 12001c00     	and	w0, w0, #0xff
  7c80bc: 7100001f     	cmp	w0, #0x0
  7c80c0: 54000500     	b.eq	0x7c8160
  7c80c4: f94017e1     	ldr	x1, [sp, #0x28]
  7c80c8: d29bb400     	mov	x0, #0xdda0             // =56736
  7c80cc: 8b000020     	add	x0, x1, x0
  7c80d0: 52804381     	mov	w1, #0x21c              // =540
  7c80d4: 94004b85     	bl	0x7daee8
  7c80d8: 2a0003e1     	mov	w1, w0
  7c80dc: b9403be0     	ldr	w0, [sp, #0x38]
  7c80e0: 6b01001f     	cmp	w0, w1
  7c80e4: 1a9f07e0     	cset	w0, ne
  7c80e8: 12001c00     	and	w0, w0, #0xff
  7c80ec: 7100001f     	cmp	w0, #0x0
  7c80f0: 54000060     	b.eq	0x7c80fc
  7c80f4: 52800000     	mov	w0, #0x0                // =0
  7c80f8: 1400001b     	b	0x7c8164
  7c80fc: f94017e1     	ldr	x1, [sp, #0x28]
  7c8100: d29bb400     	mov	x0, #0xdda0             // =56736
  7c8104: 8b000026     	add	x6, x1, x0
  7c8108: f94017e0     	ldr	x0, [sp, #0x28]
  7c810c: 91402000     	add	x0, x0, #0x8, lsl #12   // =0x8000
  7c8110: f9681407     	ldr	x7, [x0, #0x5028]
  7c8114: f94017e0     	ldr	x0, [sp, #0x28]
  7c8118: f9526c01     	ldr	x1, [x0, #0x24d8]
  7c811c: b9403be0     	ldr	w0, [sp, #0x38]
  7c8120: 8b000020     	add	x0, x1, x0
  7c8124: b9403be1     	ldr	w1, [sp, #0x38]
  7c8128: 52800005     	mov	w5, #0x0                // =0
  7c812c: 2a0103e4     	mov	w4, w1
  7c8130: aa0003e3     	mov	x3, x0
  7c8134: 52804382     	mov	w2, #0x21c              // =540
  7c8138: aa0703e1     	mov	x1, x7
  7c813c: aa0603e0     	mov	x0, x6
  7c8140: 94004b84     	bl	0x7daf50
  7c8144: 12001c00     	and	w0, w0, #0xff
  7c8148: 52000000     	eor	w0, w0, #0x1
  7c814c: 12001c00     	and	w0, w0, #0xff
  7c8150: 7100001f     	cmp	w0, #0x0
  7c8154: 54000060     	b.eq	0x7c8160
  7c8158: 52800000     	mov	w0, #0x0                // =0
  7c815c: 14000002     	b	0x7c8164
  7c8160: 52800020     	mov	w0, #0x1                // =1
  7c8164: f9400bf3     	ldr	x19, [sp, #0x10]
  7c8168: a8c57bfd     	ldp	x29, x30, [sp], #0x50
  7c816c: d65f03c0     	ret
  7c8170: d10043ff     	sub	sp, sp, #0x10
  7c8174: f90007e0     	str	x0, [sp, #0x8]
  7c8178: f94007e0     	ldr	x0, [sp, #0x8]
  7c817c: 91403000     	add	x0, x0, #0xc, lsl #12   // =0xc000
  7c8180: b95d9800     	ldr	w0, [x0, #0x1d98]
  7c8184: 7100001f     	cmp	w0, #0x0
  7c8188: 1a9f07e0     	cset	w0, ne
  7c818c: 12001c00     	and	w0, w0, #0xff
  7c8190: 910043ff     	add	sp, sp, #0x10
  7c8194: d65f03c0     	ret
