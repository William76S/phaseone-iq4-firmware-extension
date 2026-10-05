    9b08: b9401002     	ldr	w2, [x0, #0x10]
    9b0c: 52802fe1     	mov	w1, #0x17f              // =383
    9b10: 721e105f     	tst	w2, #0x7c
    9b14: 0a010041     	and	w1, w2, w1
    9b18: 540005a1     	b.ne	0x9bcc <pthread_mutex_lock+0xc4>
    9b1c: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
    9b20: 910003fd     	mov	x29, sp
    9b24: a90153f3     	stp	x19, x20, [sp, #0x10]
    9b28: aa0003f3     	mov	x19, x0
    9b2c: 35000281     	cbnz	w1, 0x9b7c <pthread_mutex_lock+0x74>
    9b30: 52800020     	mov	w0, #0x1                // =1
    9b34: 885ffe61     	ldaxr	w1, [x19]
    9b38: 35000061     	cbnz	w1, 0x9b44 <pthread_mutex_lock+0x3c>
    9b3c: 88027e60     	stxr	w2, w0, [x19]
    9b40: 35ffffa2     	cbnz	w2, 0x9b34 <pthread_mutex_lock+0x2c>
    9b44: 7100003f     	cmp	w1, #0x0
    9b48: 54000441     	b.ne	0x9bd0 <pthread_mutex_lock+0xc8>
    9b4c: b9400a60     	ldr	w0, [x19, #0x8]
    9b50: 35000d40     	cbnz	w0, 0x9cf8 <pthread_mutex_lock+0x1f0>
    9b54: d53bd054     	mrs	x20, TPIDR_EL0
    9b58: d1200294     	sub	x20, x20, #0x800
    9b5c: b9400e61     	ldr	w1, [x19, #0xc]
    9b60: 52800000     	mov	w0, #0x0                // =0
    9b64: b941d282     	ldr	w2, [x20, #0x1d0]
    9b68: 11000421     	add	w1, w1, #0x1
    9b6c: 29010662     	stp	w2, w1, [x19, #0x8]
    9b70: a94153f3     	ldp	x19, x20, [sp, #0x10]
    9b74: a8c27bfd     	ldp	x29, x30, [sp], #0x20
    9b78: d65f03c0     	ret
    9b7c: 12001842     	and	w2, w2, #0x7f
    9b80: 7100045f     	cmp	w2, #0x1
    9b84: 54000461     	b.ne	0x9c10 <pthread_mutex_lock+0x108>
    9b88: d53bd054     	mrs	x20, TPIDR_EL0
    9b8c: b9400803     	ldr	w3, [x0, #0x8]
    9b90: d1200294     	sub	x20, x20, #0x800
    9b94: b941d281     	ldr	w1, [x20, #0x1d0]
    9b98: 6b01007f     	cmp	w3, w1
    9b9c: 540002c0     	b.eq	0x9bf4 <pthread_mutex_lock+0xec>
    9ba0: 885ffe61     	ldaxr	w1, [x19]
    9ba4: 35000061     	cbnz	w1, 0x9bb0 <pthread_mutex_lock+0xa8>
    9ba8: 88037e62     	stxr	w3, w2, [x19]
    9bac: 35ffffa3     	cbnz	w3, 0x9ba0 <pthread_mutex_lock+0x98>
    9bb0: 7100003f     	cmp	w1, #0x0
    9bb4: 54000181     	b.ne	0x9be4 <pthread_mutex_lock+0xdc>
    9bb8: b9400a60     	ldr	w0, [x19, #0x8]
    9bbc: 35000ae0     	cbnz	w0, 0x9d18 <pthread_mutex_lock+0x210>
    9bc0: 52800020     	mov	w0, #0x1                // =1
    9bc4: b9000660     	str	w0, [x19, #0x4]
    9bc8: 17ffffe5     	b	0x9b5c <pthread_mutex_lock+0x54>
    9bcc: 17fffe51     	b	0x9510 <pthread_mutex_destroy+0x28>
    9bd0: b9401261     	ldr	w1, [x19, #0x10]
    9bd4: aa1303e0     	mov	x0, x19
    9bd8: 12190021     	and	w1, w1, #0x80
    9bdc: 94001aa9     	bl	0x10680 <siglongjmp+0x288>
    9be0: 17ffffdb     	b	0x9b4c <pthread_mutex_lock+0x44>
    9be4: b9401261     	ldr	w1, [x19, #0x10]
    9be8: 12190021     	and	w1, w1, #0x80
    9bec: 94001aa5     	bl	0x10680 <siglongjmp+0x288>
    9bf0: 17fffff2     	b	0x9bb8 <pthread_mutex_lock+0xb0>
    9bf4: b9400400     	ldr	w0, [x0, #0x4]
    9bf8: 3100041f     	cmn	w0, #0x1
    9bfc: 54000360     	b.eq	0x9c68 <pthread_mutex_lock+0x160>
    9c00: 11000401     	add	w1, w0, #0x1
    9c04: 52800000     	mov	w0, #0x0                // =0
    9c08: b9000661     	str	w1, [x19, #0x4]
    9c0c: 17ffffd9     	b	0x9b70 <pthread_mutex_lock+0x68>
    9c10: 71000c5f     	cmp	w2, #0x3
    9c14: 540002e1     	b.ne	0x9c70 <pthread_mutex_lock+0x168>
    9c18: 90000120     	adrp	x0, 0x2d000
    9c1c: b9439c00     	ldr	w0, [x0, #0x39c]
    9c20: 34fff880     	cbz	w0, 0x9b30 <pthread_mutex_lock+0x28>
    9c24: 52800020     	mov	w0, #0x1                // =1
    9c28: 885ffe61     	ldaxr	w1, [x19]
    9c2c: 35000061     	cbnz	w1, 0x9c38 <pthread_mutex_lock+0x130>
    9c30: 88027e60     	stxr	w2, w0, [x19]
    9c34: 35ffffa2     	cbnz	w2, 0x9c28 <pthread_mutex_lock+0x120>
    9c38: 7100003f     	cmp	w1, #0x0
    9c3c: 540002e1     	b.ne	0x9c98 <pthread_mutex_lock+0x190>
    9c40: b9400a60     	ldr	w0, [x19, #0x8]
    9c44: 34fff880     	cbz	w0, 0x9b54 <pthread_mutex_lock+0x4c>
    9c48: f0000043     	adrp	x3, 0x14000
    9c4c: f0000041     	adrp	x1, 0x14000
    9c50: d0000040     	adrp	x0, 0x13000 <pthread_getname_np+0xb8>
    9c54: 91010063     	add	x3, x3, #0x40
    9c58: 9104e021     	add	x1, x1, #0x138
    9c5c: 528011c2     	mov	w2, #0x8e               // =142
    9c60: 913f0000     	add	x0, x0, #0xfc0
    9c64: 97fff00b     	bl	0x5c90 <__assert_fail@plt>
    9c68: 52800160     	mov	w0, #0xb                // =11
    9c6c: 17ffffc1     	b	0x9b70 <pthread_mutex_lock+0x68>
    9c70: d53bd040     	mrs	x0, TPIDR_EL0
    9c74: 7100085f     	cmp	w2, #0x2
    9c78: d11c0000     	sub	x0, x0, #0x700
    9c7c: b940d000     	ldr	w0, [x0, #0xd0]
    9c80: 54000741     	b.ne	0x9d68 <pthread_mutex_lock+0x260>
    9c84: b9400a61     	ldr	w1, [x19, #0x8]
    9c88: 6b00003f     	cmp	w1, w0
    9c8c: 54fff521     	b.ne	0x9b30 <pthread_mutex_lock+0x28>
    9c90: 52800460     	mov	w0, #0x23               // =35
    9c94: 17ffffb7     	b	0x9b70 <pthread_mutex_lock+0x68>
    9c98: b9401661     	ldr	w1, [x19, #0x14]
    9c9c: 52800c83     	mov	w3, #0x64               // =100
    9ca0: 52800002     	mov	w2, #0x0                // =0
    9ca4: 11001421     	add	w1, w1, #0x5
    9ca8: 531f7821     	lsl	w1, w1, #1
    9cac: 6b03003f     	cmp	w1, w3
    9cb0: 1a83d021     	csel	w1, w1, w3, le
    9cb4: 6b01005f     	cmp	w2, w1
    9cb8: 11000454     	add	w20, w2, #0x1
    9cbc: 540003ea     	b.ge	0x9d38 <pthread_mutex_lock+0x230>
    9cc0: 885ffe62     	ldaxr	w2, [x19]
    9cc4: 35000062     	cbnz	w2, 0x9cd0 <pthread_mutex_lock+0x1c8>
    9cc8: 88037e60     	stxr	w3, w0, [x19]
    9ccc: 35ffffa3     	cbnz	w3, 0x9cc0 <pthread_mutex_lock+0x1b8>
    9cd0: 7100005f     	cmp	w2, #0x0
    9cd4: 2a1403e2     	mov	w2, w20
    9cd8: 54fffee1     	b.ne	0x9cb4 <pthread_mutex_lock+0x1ac>
    9cdc: b9401661     	ldr	w1, [x19, #0x14]
    9ce0: 52800102     	mov	w2, #0x8                // =8
    9ce4: 4b010280     	sub	w0, w20, w1
    9ce8: 1ac20c00     	sdiv	w0, w0, w2
    9cec: 0b010000     	add	w0, w0, w1
    9cf0: b9001660     	str	w0, [x19, #0x14]
    9cf4: 17ffffd3     	b	0x9c40 <pthread_mutex_lock+0x138>
    9cf8: f0000043     	adrp	x3, 0x14000
    9cfc: f0000041     	adrp	x1, 0x14000
    9d00: d0000040     	adrp	x0, 0x13000 <pthread_getname_np+0xb8>
    9d04: 91010063     	add	x3, x3, #0x40
    9d08: 9104e021     	add	x1, x1, #0x138
    9d0c: 528009e2     	mov	w2, #0x4f               // =79
    9d10: 913f0000     	add	x0, x0, #0xfc0
    9d14: 97ffefdf     	bl	0x5c90 <__assert_fail@plt>
    9d18: f0000043     	adrp	x3, 0x14000
    9d1c: f0000041     	adrp	x1, 0x14000
    9d20: d0000040     	adrp	x0, 0x13000 <pthread_getname_np+0xb8>
    9d24: 91010063     	add	x3, x3, #0x40
    9d28: 9104e021     	add	x1, x1, #0x138
    9d2c: 52800e62     	mov	w2, #0x73               // =115
    9d30: 913f0000     	add	x0, x0, #0xfc0
    9d34: 97ffefd7     	bl	0x5c90 <__assert_fail@plt>
    9d38: 52800020     	mov	w0, #0x1                // =1
    9d3c: 885ffe61     	ldaxr	w1, [x19]
    9d40: 35000061     	cbnz	w1, 0x9d4c <pthread_mutex_lock+0x244>
    9d44: 88027e60     	stxr	w2, w0, [x19]
    9d48: 35ffffa2     	cbnz	w2, 0x9d3c <pthread_mutex_lock+0x234>
    9d4c: 7100003f     	cmp	w1, #0x0
    9d50: 54fffc60     	b.eq	0x9cdc <pthread_mutex_lock+0x1d4>
    9d54: b9401261     	ldr	w1, [x19, #0x10]
    9d58: aa1303e0     	mov	x0, x19
    9d5c: 12190021     	and	w1, w1, #0x80
    9d60: 94001a48     	bl	0x10680 <siglongjmp+0x288>
    9d64: 17ffffde     	b	0x9cdc <pthread_mutex_lock+0x1d4>
    9d68: f0000043     	adrp	x3, 0x14000
    9d6c: f0000041     	adrp	x1, 0x14000
    9d70: d0000040     	adrp	x0, 0x13000 <pthread_getname_np+0xb8>
    9d74: 91010063     	add	x3, x3, #0x40
    9d78: 9104e021     	add	x1, x1, #0x138
    9d7c: 52801262     	mov	w2, #0x93               // =147
    9d80: 913f8000     	add	x0, x0, #0xfe0
    9d84: 97ffefc3     	bl	0x5c90 <__assert_fail@plt>
