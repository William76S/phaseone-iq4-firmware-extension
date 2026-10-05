
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_storage_bridge_01/build/storage_mutex.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_native_storage_mutex_initialize_01>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: a9014ff4     	stp	x20, x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: 90000013     	adrp	x19, 0x0 <iq4_f3_native_storage_mutex_initialize_01>
		000000000000000c:  R_AARCH64_ADR_PREL_PG_HI21	.bss
      10: 91000273     	add	x19, x19, #0x0
		0000000000000010:  R_AARCH64_ADD_ABS_LO12_NC	.bss
      14: 885ffe68     	ldaxr	w8, [x19]
      18: 350000a8     	cbnz	w8, 0x2c <iq4_f3_native_storage_mutex_initialize_01+0x2c>
      1c: 52800029     	mov	w9, #0x1                // =1
      20: 880afe69     	stlxr	w10, w9, [x19]
      24: 35ffff8a     	cbnz	w10, 0x14 <iq4_f3_native_storage_mutex_initialize_01+0x14>
      28: 14000003     	b	0x34 <iq4_f3_native_storage_mutex_initialize_01+0x34>
      2c: 2a1f03e9     	mov	w9, wzr
      30: d5033f5f     	clrex
      34: 7100091f     	cmp	w8, #0x2
      38: 1a9f17e0     	cset	w0, eq
      3c: 34000269     	cbz	w9, 0x88 <iq4_f3_native_storage_mutex_initialize_01+0x88>
      40: aa1f03e8     	mov	x8, xzr
      44: 90000009     	adrp	x9, 0x0 <iq4_f3_native_storage_mutex_initialize_01>
		0000000000000044:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
      48: 91000129     	add	x9, x9, #0x0
		0000000000000048:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
      4c: 3868692a     	ldrb	w10, [x9, x8]
      50: 3500016a     	cbnz	w10, 0x7c <iq4_f3_native_storage_mutex_initialize_01+0x7c>
      54: 91000508     	add	x8, x8, #0x1
      58: f100c11f     	cmp	x8, #0x30
      5c: 54ffff81     	b.ne	0x4c <iq4_f3_native_storage_mutex_initialize_01+0x4c>
      60: 5294e614     	mov	w20, #0xa730            // =42800
      64: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_mutex_initialize_01>
		0000000000000064:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
      68: 91000000     	add	x0, x0, #0x0
		0000000000000068:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
      6c: 72a00814     	movk	w20, #0x40, lsl #16
      70: 910ec288     	add	x8, x20, #0x3b0
      74: d63f0100     	blr	x8
      78: 340000e0     	cbz	w0, 0x94 <iq4_f3_native_storage_mutex_initialize_01+0x94>
      7c: 2a1f03e0     	mov	w0, wzr
      80: 52800068     	mov	w8, #0x3                // =3
      84: 889ffe68     	stlr	w8, [x19]
      88: a9414ff4     	ldp	x20, x19, [sp, #0x10]
      8c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      90: d65f03c0     	ret
      94: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_mutex_initialize_01>
		0000000000000094:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
      98: 91000000     	add	x0, x0, #0x0
		0000000000000098:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
      9c: d63f0280     	blr	x20
      a0: 52800048     	mov	w8, #0x2                // =2
      a4: 7100001f     	cmp	w0, #0x0
      a8: 1a9f17e0     	cset	w0, eq
      ac: 1a880508     	cinc	w8, w8, ne
      b0: 17fffff5     	b	0x84 <iq4_f3_native_storage_mutex_initialize_01+0x84>

00000000000000b4 <iq4_f3_storage_mutex_ready_01>:
      b4: 90000008     	adrp	x8, 0x0 <iq4_f3_native_storage_mutex_initialize_01>
		00000000000000b4:  R_AARCH64_ADR_PREL_PG_HI21	.bss
      b8: 91000108     	add	x8, x8, #0x0
		00000000000000b8:  R_AARCH64_ADD_ABS_LO12_NC	.bss
      bc: 88dffd08     	ldar	w8, [x8]
      c0: 7100091f     	cmp	w8, #0x2
      c4: 1a9f17e0     	cset	w0, eq
      c8: d65f03c0     	ret

00000000000000cc <iq4_f3_storage_mutex_lock_01>:
      cc: 52955c01     	mov	w1, #0xaae0             // =43744
      d0: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_mutex_initialize_01>
		00000000000000d0:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
      d4: 91000000     	add	x0, x0, #0x0
		00000000000000d4:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
      d8: 72a00801     	movk	w1, #0x40, lsl #16
      dc: d61f0020     	br	x1

00000000000000e0 <iq4_f3_storage_mutex_unlock_01>:
      e0: 5294e601     	mov	w1, #0xa730             // =42800
      e4: 90000000     	adrp	x0, 0x0 <iq4_f3_native_storage_mutex_initialize_01>
		00000000000000e4:  R_AARCH64_ADR_PREL_PG_HI21	.bss+0x8
      e8: 91000000     	add	x0, x0, #0x0
		00000000000000e8:  R_AARCH64_ADD_ABS_LO12_NC	.bss+0x8
      ec: 72a00801     	movk	w1, #0x40, lsl #16
      f0: d61f0020     	br	x1
