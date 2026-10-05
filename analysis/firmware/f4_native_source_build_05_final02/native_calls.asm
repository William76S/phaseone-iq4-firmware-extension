
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f4_native_source_build_05_final02/native_calls.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f4_native_current_02>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: f9000bf3     	str	x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: aa0003f3     	mov	x19, x0
      10: 52816188     	mov	w8, #0xb0c              // =2828
      14: 72a00e28     	movk	w8, #0x71, lsl #16
      18: d63f0100     	blr	x8
      1c: f9000260     	str	x0, [x19]
      20: 52800020     	mov	w0, #0x1                // =1
      24: f9400bf3     	ldr	x19, [sp, #0x10]
      28: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      2c: d65f03c0     	ret
      30: 94000000     	bl	0x30 <iq4_f4_native_current_02+0x30>
		0000000000000030:  R_AARCH64_CALL26	__cxa_begin_catch
      34: 94000000     	bl	0x34 <iq4_f4_native_current_02+0x34>
		0000000000000034:  R_AARCH64_CALL26	__cxa_end_catch
      38: 2a1f03e0     	mov	w0, wzr
      3c: 17fffffa     	b	0x24 <iq4_f4_native_current_02+0x24>

0000000000000040 <iq4_f4_native_lock_02>:
      40: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
      44: f9000bf3     	str	x19, [sp, #0x10]
      48: 910003fd     	mov	x29, sp
      4c: aa0203f3     	mov	x19, x2
      50: 528c3188     	mov	w8, #0x618c             // =24972
      54: 72a00d68     	movk	w8, #0x6b, lsl #16
      58: d63f0100     	blr	x8
      5c: f9000260     	str	x0, [x19]
      60: 52800020     	mov	w0, #0x1                // =1
      64: f9400bf3     	ldr	x19, [sp, #0x10]
      68: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      6c: d65f03c0     	ret
      70: 94000000     	bl	0x70 <iq4_f4_native_lock_02+0x30>
		0000000000000070:  R_AARCH64_CALL26	__cxa_begin_catch
      74: 94000000     	bl	0x74 <iq4_f4_native_lock_02+0x34>
		0000000000000074:  R_AARCH64_CALL26	__cxa_end_catch
      78: 2a1f03e0     	mov	w0, wzr
      7c: 17fffffa     	b	0x64 <iq4_f4_native_lock_02+0x24>

0000000000000080 <iq4_f4_native_unlock_02>:
      80: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
      84: f9000bf3     	str	x19, [sp, #0x10]
      88: 910003fd     	mov	x29, sp
      8c: aa0203f3     	mov	x19, x2
      90: 528c4a08     	mov	w8, #0x6250             // =25168
      94: 72a00d68     	movk	w8, #0x6b, lsl #16
      98: d63f0100     	blr	x8
      9c: 12000008     	and	w8, w0, #0x1
      a0: 52800020     	mov	w0, #0x1                // =1
      a4: b9000268     	str	w8, [x19]
      a8: f9400bf3     	ldr	x19, [sp, #0x10]
      ac: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      b0: d65f03c0     	ret
      b4: 94000000     	bl	0xb4 <iq4_f4_native_unlock_02+0x34>
		00000000000000b4:  R_AARCH64_CALL26	__cxa_begin_catch
      b8: 94000000     	bl	0xb8 <iq4_f4_native_unlock_02+0x38>
		00000000000000b8:  R_AARCH64_CALL26	__cxa_end_catch
      bc: 2a1f03e0     	mov	w0, wzr
      c0: 17fffffa     	b	0xa8 <iq4_f4_native_unlock_02+0x28>

00000000000000c4 <iq4_f4_native_size_02>:
      c4: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
      c8: f9000bf3     	str	x19, [sp, #0x10]
      cc: 910003fd     	mov	x29, sp
      d0: aa0103f3     	mov	x19, x1
      d4: 528c3f88     	mov	w8, #0x61fc             // =25084
      d8: 72a00d68     	movk	w8, #0x6b, lsl #16
      dc: d63f0100     	blr	x8
      e0: f9000260     	str	x0, [x19]
      e4: 52800020     	mov	w0, #0x1                // =1
      e8: f9400bf3     	ldr	x19, [sp, #0x10]
      ec: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      f0: d65f03c0     	ret
      f4: 94000000     	bl	0xf4 <iq4_f4_native_size_02+0x30>
		00000000000000f4:  R_AARCH64_CALL26	__cxa_begin_catch
      f8: 94000000     	bl	0xf8 <iq4_f4_native_size_02+0x34>
		00000000000000f8:  R_AARCH64_CALL26	__cxa_end_catch
      fc: 2a1f03e0     	mov	w0, wzr
     100: 17fffffa     	b	0xe8 <iq4_f4_native_size_02+0x24>

0000000000000104 <iq4_f4_native_id_02>:
     104: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     108: f9000bf3     	str	x19, [sp, #0x10]
     10c: 910003fd     	mov	x29, sp
     110: aa0103f3     	mov	x19, x1
     114: 528c5808     	mov	w8, #0x62c0             // =25280
     118: 72a00d68     	movk	w8, #0x6b, lsl #16
     11c: d63f0100     	blr	x8
     120: b9000260     	str	w0, [x19]
     124: 52800020     	mov	w0, #0x1                // =1
     128: f9400bf3     	ldr	x19, [sp, #0x10]
     12c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     130: d65f03c0     	ret
     134: 94000000     	bl	0x134 <iq4_f4_native_id_02+0x30>
		0000000000000134:  R_AARCH64_CALL26	__cxa_begin_catch
     138: 94000000     	bl	0x138 <iq4_f4_native_id_02+0x34>
		0000000000000138:  R_AARCH64_CALL26	__cxa_end_catch
     13c: 2a1f03e0     	mov	w0, wzr
     140: 17fffffa     	b	0x128 <iq4_f4_native_id_02+0x24>

0000000000000144 <iq4_f4_native_construct_observer_02>:
     144: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     148: 910003fd     	mov	x29, sp
     14c: 529fc788     	mov	w8, #0xfe3c             // =65084
     150: 72a00e08     	movk	w8, #0x70, lsl #16
     154: d63f0100     	blr	x8
     158: 52800020     	mov	w0, #0x1                // =1
     15c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     160: d65f03c0     	ret
     164: 94000000     	bl	0x164 <iq4_f4_native_construct_observer_02+0x20>
		0000000000000164:  R_AARCH64_CALL26	__cxa_begin_catch
     168: 94000000     	bl	0x168 <iq4_f4_native_construct_observer_02+0x24>
		0000000000000168:  R_AARCH64_CALL26	__cxa_end_catch
     16c: 2a1f03e0     	mov	w0, wzr
     170: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     174: d65f03c0     	ret

0000000000000178 <iq4_f4_native_subscribe_02>:
     178: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     17c: 910003fd     	mov	x29, sp
     180: 529fdb08     	mov	w8, #0xfed8             // =65240
     184: 72a00e08     	movk	w8, #0x70, lsl #16
     188: d63f0100     	blr	x8
     18c: 52800020     	mov	w0, #0x1                // =1
     190: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     194: d65f03c0     	ret
     198: 94000000     	bl	0x198 <iq4_f4_native_subscribe_02+0x20>
		0000000000000198:  R_AARCH64_CALL26	__cxa_begin_catch
     19c: 94000000     	bl	0x19c <iq4_f4_native_subscribe_02+0x24>
		000000000000019c:  R_AARCH64_CALL26	__cxa_end_catch
     1a0: 2a1f03e0     	mov	w0, wzr
     1a4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     1a8: d65f03c0     	ret

00000000000001ac <iq4_f4_native_unsubscribe_02>:
     1ac: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     1b0: 910003fd     	mov	x29, sp
     1b4: 529fe108     	mov	w8, #0xff08             // =65288
     1b8: 72a00e08     	movk	w8, #0x70, lsl #16
     1bc: d63f0100     	blr	x8
     1c0: 52800020     	mov	w0, #0x1                // =1
     1c4: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     1c8: d65f03c0     	ret
     1cc: 94000000     	bl	0x1cc <iq4_f4_native_unsubscribe_02+0x20>
		00000000000001cc:  R_AARCH64_CALL26	__cxa_begin_catch
     1d0: 94000000     	bl	0x1d0 <iq4_f4_native_unsubscribe_02+0x24>
		00000000000001d0:  R_AARCH64_CALL26	__cxa_end_catch
     1d4: 2a1f03e0     	mov	w0, wzr
     1d8: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     1dc: d65f03c0     	ret

00000000000001e0 <iq4_f4_native_trylock_02>:
     1e0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     1e4: f9000bf3     	str	x19, [sp, #0x10]
     1e8: 910003fd     	mov	x29, sp
     1ec: aa0103f3     	mov	x19, x1
     1f0: 5295d008     	mov	w8, #0xae80             // =44672
     1f4: 72a00808     	movk	w8, #0x40, lsl #16
     1f8: d63f0100     	blr	x8
     1fc: b9000260     	str	w0, [x19]
     200: 52800020     	mov	w0, #0x1                // =1
     204: f9400bf3     	ldr	x19, [sp, #0x10]
     208: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     20c: d65f03c0     	ret
     210: 94000000     	bl	0x210 <iq4_f4_native_trylock_02+0x30>
		0000000000000210:  R_AARCH64_CALL26	__cxa_begin_catch
     214: 94000000     	bl	0x214 <iq4_f4_native_trylock_02+0x34>
		0000000000000214:  R_AARCH64_CALL26	__cxa_end_catch
     218: 2a1f03e0     	mov	w0, wzr
     21c: 17fffffa     	b	0x204 <iq4_f4_native_trylock_02+0x24>

0000000000000220 <iq4_f4_native_mutex_unlock_02>:
     220: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
     224: f9000bf3     	str	x19, [sp, #0x10]
     228: 910003fd     	mov	x29, sp
     22c: aa0103f3     	mov	x19, x1
     230: 5294e608     	mov	w8, #0xa730             // =42800
     234: 72a00808     	movk	w8, #0x40, lsl #16
     238: d63f0100     	blr	x8
     23c: b9000260     	str	w0, [x19]
     240: 52800020     	mov	w0, #0x1                // =1
     244: f9400bf3     	ldr	x19, [sp, #0x10]
     248: a8c27bfd     	ldp	x29, x30, [sp], #0x20
     24c: d65f03c0     	ret
     250: 94000000     	bl	0x250 <iq4_f4_native_mutex_unlock_02+0x30>
		0000000000000250:  R_AARCH64_CALL26	__cxa_begin_catch
     254: 94000000     	bl	0x254 <iq4_f4_native_mutex_unlock_02+0x34>
		0000000000000254:  R_AARCH64_CALL26	__cxa_end_catch
     258: 2a1f03e0     	mov	w0, wzr
     25c: 17fffffa     	b	0x244 <iq4_f4_native_mutex_unlock_02+0x24>

0000000000000260 <iq4_f4_native_event_construct_02>:
     260: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     264: 910003fd     	mov	x29, sp
     268: 529e2588     	mov	w8, #0xf12c             // =61740
     26c: 72a00e08     	movk	w8, #0x70, lsl #16
     270: d63f0100     	blr	x8
     274: 52800020     	mov	w0, #0x1                // =1
     278: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     27c: d65f03c0     	ret
     280: 94000000     	bl	0x280 <iq4_f4_native_event_construct_02+0x20>
		0000000000000280:  R_AARCH64_CALL26	__cxa_begin_catch
     284: 94000000     	bl	0x284 <iq4_f4_native_event_construct_02+0x24>
		0000000000000284:  R_AARCH64_CALL26	__cxa_end_catch
     288: 2a1f03e0     	mov	w0, wzr
     28c: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     290: d65f03c0     	ret

0000000000000294 <iq4_f4_native_event_notify_02>:
     294: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     298: 910003fd     	mov	x29, sp
     29c: 529e5f08     	mov	w8, #0xf2f8             // =62200
     2a0: 72a00e08     	movk	w8, #0x70, lsl #16
     2a4: d63f0100     	blr	x8
     2a8: 52800020     	mov	w0, #0x1                // =1
     2ac: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     2b0: d65f03c0     	ret
     2b4: 94000000     	bl	0x2b4 <iq4_f4_native_event_notify_02+0x20>
		00000000000002b4:  R_AARCH64_CALL26	__cxa_begin_catch
     2b8: 94000000     	bl	0x2b8 <iq4_f4_native_event_notify_02+0x24>
		00000000000002b8:  R_AARCH64_CALL26	__cxa_end_catch
     2bc: 2a1f03e0     	mov	w0, wzr
     2c0: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     2c4: d65f03c0     	ret

00000000000002c8 <iq4_f4_native_clock_02>:
     2c8: d10043ff     	sub	sp, sp, #0x10
     2cc: 52800020     	mov	w0, #0x1                // =1
     2d0: 910003e1     	mov	x1, sp
     2d4: 52800e28     	mov	w8, #0x71               // =113
     2d8: d4000001     	svc	#0
     2dc: a8c12be8     	ldp	x8, x10, [sp], #0x10
     2e0: 52993fe9     	mov	w9, #0xc9ff             // =51711
     2e4: d28fa08c     	mov	x12, #0x7d04            // =32004
     2e8: 72a77349     	movk	w9, #0x3b9a, lsl #16
     2ec: f2a4b82c     	movk	x12, #0x25c1, lsl #16
     2f0: 9b09210b     	madd	x11, x8, x9, x8
     2f4: f2c0004c     	movk	x12, #0x2, lsl #32
     2f8: eb0c011f     	cmp	x8, x12
     2fc: fa49d142     	ccmp	x10, x9, #0x2, le
     300: fa409908     	ccmp	x8, #0x0, #0x8, ls
     304: fa40a800     	ccmp	x0, #0x0, #0x0, ge
     308: 8b0a0168     	add	x8, x11, x10
     30c: 9a8813e0     	csel	x0, xzr, x8, ne
     310: d65f03c0     	ret

0000000000000314 <iq4_f4_native_tid_02>:
     314: aa1f03e0     	mov	x0, xzr
     318: 52801648     	mov	w8, #0xb2               // =178
     31c: aa1f03e1     	mov	x1, xzr
     320: d4000001     	svc	#0
     324: 8aa0fc00     	bic	x0, x0, x0, asr #63
     328: d65f03c0     	ret

000000000000032c <iq4_f4_native_queue_lock_05>:
     32c: d17d5408     	sub	x8, x0, #0xf55, lsl #12 // =0xf55000
     330: f10f011f     	cmp	x8, #0x3c0
     334: 54000161     	b.ne	0x360 <iq4_f4_native_queue_lock_05+0x34>
     338: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
     33c: 910003fd     	mov	x29, sp
     340: 52848588     	mov	w8, #0x242c             // =9260
     344: 528a7800     	mov	w0, #0x53c0             // =21440
     348: 72a00e28     	movk	w8, #0x71, lsl #16
     34c: 72a01ea0     	movk	w0, #0xf5, lsl #16
     350: d63f0100     	blr	x8
     354: 52800020     	mov	w0, #0x1                // =1
     358: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     35c: d65f03c0     	ret
     360: 2a1f03e0     	mov	w0, wzr
     364: d65f03c0     	ret
     368: 94000000     	bl	0x368 <iq4_f4_native_queue_lock_05+0x3c>
		0000000000000368:  R_AARCH64_CALL26	__cxa_begin_catch
     36c: 94000000     	bl	0x36c <iq4_f4_native_queue_lock_05+0x40>
		000000000000036c:  R_AARCH64_CALL26	__cxa_end_catch
     370: 2a1f03e0     	mov	w0, wzr
     374: a8c17bfd     	ldp	x29, x30, [sp], #0x10
     378: d65f03c0     	ret
