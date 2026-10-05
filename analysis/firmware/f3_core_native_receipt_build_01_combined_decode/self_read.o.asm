
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_core_native_receipt_build_01_combined_decode/self_read.o:	file format elf64-littleaarch64

Disassembly of section .text.iq4_native_self_read_01:

0000000000000000 <iq4_native_self_read_01>:
       0: f140043f     	cmp	x1, #0x1, lsl #12       // =0x1000
       4: 2a1f03e0     	mov	w0, wzr
       8: 54000563     	b.lo	0xb4 <iq4_native_self_read_01+0xb4>
       c: b4000542     	cbz	x2, 0xb4 <iq4_native_self_read_01+0xb4>
      10: 92820008     	mov	x8, #-0x1001            // =-4097
      14: 8b080068     	add	x8, x3, x8
      18: b140051f     	cmn	x8, #0x1, lsl #12       // =0x1000
      1c: 540004c3     	b.lo	0xb4 <iq4_native_self_read_01+0xb4>
      20: aa2303e8     	mvn	x8, x3
      24: 2a1f03e0     	mov	w0, wzr
      28: eb08003f     	cmp	x1, x8
      2c: 54000448     	b.hi	0xb4 <iq4_native_self_read_01+0xb4>
      30: eb08005f     	cmp	x2, x8
      34: 54000408     	b.hi	0xb4 <iq4_native_self_read_01+0xb4>
      38: d10143ff     	sub	sp, sp, #0x50
      3c: a9027bfd     	stp	x29, x30, [sp, #0x20]
      40: f9001bf5     	str	x21, [sp, #0x30]
      44: a9044ff4     	stp	x20, x19, [sp, #0x40]
      48: 910083fd     	add	x29, sp, #0x20
      4c: 52801580     	mov	w0, #0xac               // =172
      50: aa0203f5     	mov	x21, x2
      54: aa0103f3     	mov	x19, x1
      58: aa0303f4     	mov	x20, x3
      5c: 94000000     	bl	0x5c <iq4_native_self_read_01+0x5c>
		000000000000005c:  R_AARCH64_CALL26	iq4_native_original_syscall_01
      60: f100041f     	cmp	x0, #0x1
      64: 540001eb     	b.lt	0xa0 <iq4_native_self_read_01+0xa0>
      68: aa0003e1     	mov	x1, x0
      6c: 910043e2     	add	x2, sp, #0x10
      70: 910003e4     	mov	x4, sp
      74: 528021c0     	mov	w0, #0x10e              // =270
      78: 52800023     	mov	w3, #0x1                // =1
      7c: 52800025     	mov	w5, #0x1                // =1
      80: aa1f03e6     	mov	x6, xzr
      84: a90153f5     	stp	x21, x20, [sp, #0x10]
      88: a90053f3     	stp	x19, x20, [sp]
      8c: 94000000     	bl	0x8c <iq4_native_self_read_01+0x8c>
		000000000000008c:  R_AARCH64_CALL26	iq4_native_original_syscall_01
      90: f100001f     	cmp	x0, #0x0
      94: fa54a000     	ccmp	x0, x20, #0x0, ge
      98: 1a9f17e0     	cset	w0, eq
      9c: 14000002     	b	0xa4 <iq4_native_self_read_01+0xa4>
      a0: 2a1f03e0     	mov	w0, wzr
      a4: a9444ff4     	ldp	x20, x19, [sp, #0x40]
      a8: f9401bf5     	ldr	x21, [sp, #0x30]
      ac: a9427bfd     	ldp	x29, x30, [sp, #0x20]
      b0: 910143ff     	add	sp, sp, #0x50
      b4: d65f03c0     	ret

Disassembly of section .text.iq4_native_current_tid_01:

0000000000000000 <iq4_native_current_tid_01>:
       0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
       4: 910003fd     	mov	x29, sp
       8: 52801640     	mov	w0, #0xb2               // =178
       c: 94000000     	bl	0xc <iq4_native_current_tid_01+0xc>
		000000000000000c:  R_AARCH64_CALL26	iq4_native_original_syscall_01
      10: 8aa0fc00     	bic	x0, x0, x0, asr #63
      14: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      18: d65f03c0     	ret
