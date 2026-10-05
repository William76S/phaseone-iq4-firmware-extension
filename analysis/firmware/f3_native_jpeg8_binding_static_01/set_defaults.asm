INPUT_SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb
STATIC_ONLY_NEAREST_LABELS_NOT_AUTHORITATIVE

/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/extracted/P1Linux_6.03.21.bin:	file format elf64-littleaarch64

Disassembly of section .text:

00000000009770a0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm>:
  9a34b8: a9bd7bfd     	stp	x29, x30, [sp, #-0x30]!
  9a34bc: 910003fd     	mov	x29, sp
  9a34c0: b9402401     	ldr	w1, [x0, #0x24]
  9a34c4: a90153f3     	stp	x19, x20, [sp, #0x10]
  9a34c8: aa0003f3     	mov	x19, x0
  9a34cc: 7101903f     	cmp	w1, #0x64
  9a34d0: a9025bf5     	stp	x21, x22, [sp, #0x20]
  9a34d4: 540000c0     	b.eq	0x9a34ec <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c44c>
  9a34d8: f9400002     	ldr	x2, [x0]
  9a34dc: 528002a4     	mov	w4, #0x15               // =21
  9a34e0: f9400043     	ldr	x3, [x2]
  9a34e4: 29050444     	stp	w4, w1, [x2, #0x28]
  9a34e8: d63f0060     	blr	x3
  9a34ec: f9403660     	ldr	x0, [x19, #0x68]
  9a34f0: b40009c0     	cbz	x0, 0x9a3628 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c588>
  9a34f4: 0f000420     	movi	v0.2s, #0x1
  9a34f8: 52800100     	mov	w0, #0x8                // =8
  9a34fc: b9005a60     	str	w0, [x19, #0x58]
  9a3500: f0002174     	adrp	x20, 0xdd2000
  9a3504: 9104c294     	add	x20, x20, #0x130
  9a3508: 52800024     	mov	w4, #0x1                // =1
  9a350c: aa1403e2     	mov	x2, x20
  9a3510: 52800643     	mov	w3, #0x32               // =50
  9a3514: 52800001     	mov	w1, #0x0                // =0
  9a3518: aa1303e0     	mov	x0, x19
  9a351c: fd002660     	str	d0, [x19, #0x48]
  9a3520: 97fffd78     	bl	0x9a2b00 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ba60>
  9a3524: 52800024     	mov	w4, #0x1                // =1
  9a3528: aa1303e0     	mov	x0, x19
  9a352c: 91040282     	add	x2, x20, #0x100
  9a3530: 52800643     	mov	w3, #0x32               // =50
  9a3534: 2a0403e1     	mov	w1, w4
  9a3538: 97fffd72     	bl	0x9a2b00 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2ba60>
  9a353c: b9402260     	ldr	w0, [x19, #0x20]
  9a3540: 340006e0     	cbz	w0, 0x9a361c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c57c>
  9a3544: 9103a276     	add	x22, x19, #0xe8
  9a3548: 91042275     	add	x21, x19, #0x108
  9a354c: 91080283     	add	x3, x20, #0x200
  9a3550: 91084282     	add	x2, x20, #0x210
  9a3554: aa1603e1     	mov	x1, x22
  9a3558: aa1303e0     	mov	x0, x19
  9a355c: 97fffd2f     	bl	0x9a2a18 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b978>
  9a3560: 9108c283     	add	x3, x20, #0x230
  9a3564: 910b8282     	add	x2, x20, #0x2e0
  9a3568: aa1503e1     	mov	x1, x21
  9a356c: aa1303e0     	mov	x0, x19
  9a3570: 97fffd2a     	bl	0x9a2a18 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b978>
  9a3574: 910022c1     	add	x1, x22, #0x8
  9a3578: 910be283     	add	x3, x20, #0x2f8
  9a357c: 910c4282     	add	x2, x20, #0x310
  9a3580: aa1303e0     	mov	x0, x19
  9a3584: 97fffd25     	bl	0x9a2a18 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b978>
  9a3588: 910cc283     	add	x3, x20, #0x330
  9a358c: 910022a1     	add	x1, x21, #0x8
  9a3590: 910f8282     	add	x2, x20, #0x3e0
  9a3594: aa1303e0     	mov	x0, x19
  9a3598: 97fffd20     	bl	0x9a2a18 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2b978>
  9a359c: a90e7e7f     	stp	xzr, xzr, [x19, #0xe0]
  9a35a0: d2800202     	mov	x2, #0x10               // =16
  9a35a4: 52800021     	mov	w1, #0x1                // =1
  9a35a8: 9103c260     	add	x0, x19, #0xf0
  9a35ac: 97e99afd     	bl	0x40a1a0 <memset@plt>
  9a35b0: d2800202     	mov	x2, #0x10               // =16
  9a35b4: 528000a1     	mov	w1, #0x5                // =5
  9a35b8: 91040260     	add	x0, x19, #0x100
  9a35bc: 97e99af9     	bl	0x40a1a0 <memset@plt>
  9a35c0: b9405a60     	ldr	w0, [x19, #0x58]
  9a35c4: f0002162     	adrp	x2, 0xdd2000
  9a35c8: 91080261     	add	x1, x19, #0x200
  9a35cc: b901127f     	str	wzr, [x19, #0x110]
  9a35d0: fd42e040     	ldr	d0, [x2, #0x5c0]
  9a35d4: 7100201f     	cmp	w0, #0x8
  9a35d8: 1a9fd7e0     	cset	w0, gt
  9a35dc: f9008e7f     	str	xzr, [x19, #0x118]
  9a35e0: f900927f     	str	xzr, [x19, #0x120]
  9a35e4: 52802023     	mov	w3, #0x101              // =257
  9a35e8: b9012a60     	str	w0, [x19, #0x128]
  9a35ec: 320083e2     	mov	w2, #0x10001            // =65537
  9a35f0: f813403f     	stur	xzr, [x1, #-0xcc]
  9a35f4: aa1303e0     	mov	x0, x19
  9a35f8: fc12c020     	stur	d0, [x1, #-0xd4]
  9a35fc: f813c03f     	stur	xzr, [x1, #-0xc4]
  9a3600: 79029263     	strh	w3, [x19, #0x148]
  9a3604: 39052a7f     	strb	wzr, [x19, #0x14a]
  9a3608: a9425bf5     	ldp	x21, x22, [sp, #0x20]
  9a360c: b9014e62     	str	w2, [x19, #0x14c]
  9a3610: a94153f3     	ldp	x19, x20, [sp, #0x10]
  9a3614: a8c37bfd     	ldp	x29, x30, [sp], #0x30
  9a3618: 17ffff6e     	b	0x9a33d0 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c330>
  9a361c: 91028276     	add	x22, x19, #0xa0
  9a3620: 91030275     	add	x21, x19, #0xc0
  9a3624: 17ffffca     	b	0x9a354c <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c4ac>
  9a3628: f9400663     	ldr	x3, [x19, #0x8]
  9a362c: d2807802     	mov	x2, #0x3c0              // =960
  9a3630: 52800001     	mov	w1, #0x0                // =0
  9a3634: aa1303e0     	mov	x0, x19
  9a3638: f9400063     	ldr	x3, [x3]
  9a363c: d63f0060     	blr	x3
  9a3640: f9003660     	str	x0, [x19, #0x68]
  9a3644: 17ffffac     	b	0x9a34f4 <_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE4findEPKcmm+0x2c454>
