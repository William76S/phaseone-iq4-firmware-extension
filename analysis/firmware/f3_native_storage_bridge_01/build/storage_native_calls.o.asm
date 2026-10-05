
/Users/william76/Desktop/research_on_p1/IQ4_Codex_Handoff_v2/analysis/firmware/f3_native_storage_bridge_01/build/storage_native_calls.o:	file format elf64-littleaarch64

Disassembly of section .text:

0000000000000000 <iq4_f3_legacy_jpeg_disabled_01>:
       0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
       4: f9000bf3     	str	x19, [sp, #0x10]
       8: 910003fd     	mov	x29, sp
       c: aa0003f3     	mov	x19, x0
      10: 94000000     	bl	0x10 <iq4_f3_legacy_jpeg_disabled_01+0x10>
		0000000000000010:  R_AARCH64_CALL26	iq4_extensions_installation_stage_02
      14: 7101901f     	cmp	w0, #0x64
      18: 540000a1     	b.ne	0x2c <iq4_f3_legacy_jpeg_disabled_01+0x2c>
      1c: f9400bf3     	ldr	x19, [sp, #0x10]
      20: 2a1f03e0     	mov	w0, wzr
      24: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      28: d65f03c0     	ret
      2c: 52918401     	mov	w1, #0x8c20             // =35872
      30: aa1303e0     	mov	x0, x19
      34: f9400bf3     	ldr	x19, [sp, #0x10]
      38: 72a00bc1     	movk	w1, #0x5e, lsl #16
      3c: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      40: d61f0020     	br	x1

0000000000000044 <iq4_f3_native_storage_write_read_01>:
      44: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
      48: a9014ff4     	stp	x20, x19, [sp, #0x10]
      4c: 910003fd     	mov	x29, sp
      50: aa0003e8     	mov	x8, x0
      54: 7100083f     	cmp	w1, #0x2
      58: 2a1f03e0     	mov	w0, wzr
      5c: 540001a8     	b.hi	0x90 <iq4_f3_native_storage_write_read_01+0x4c>
      60: b4000188     	cbz	x8, 0x90 <iq4_f3_native_storage_write_read_01+0x4c>
      64: aa0203f3     	mov	x19, x2
      68: b4000142     	cbz	x2, 0x90 <iq4_f3_native_storage_write_read_01+0x4c>
      6c: aa0803e0     	mov	x0, x8
      70: aa0803f4     	mov	x20, x8
      74: 94000000     	bl	0x74 <iq4_f3_native_storage_write_read_01+0x30>
		0000000000000074:  R_AARCH64_CALL26	iq4_f3_storage_ui_set_call_01
      78: 5296a008     	mov	w8, #0xb500             // =46336
      7c: aa1403e0     	mov	x0, x20
      80: 72a00aa8     	movk	w8, #0x55, lsl #16
      84: d63f0100     	blr	x8
      88: b9000260     	str	w0, [x19]
      8c: 52800020     	mov	w0, #0x1                // =1
      90: a9414ff4     	ldp	x20, x19, [sp, #0x10]
      94: a8c27bfd     	ldp	x29, x30, [sp], #0x20
      98: d65f03c0     	ret
      9c: 94000000     	bl	0x9c <iq4_f3_native_storage_write_read_01+0x58>
		000000000000009c:  R_AARCH64_CALL26	__cxa_begin_catch
      a0: 94000000     	bl	0xa0 <iq4_f3_native_storage_write_read_01+0x5c>
		00000000000000a0:  R_AARCH64_CALL26	__cxa_end_catch
      a4: 2a1f03e0     	mov	w0, wzr
      a8: 17fffffa     	b	0x90 <iq4_f3_native_storage_write_read_01+0x4c>
      ac: 94000000     	bl	0xac <iq4_f3_native_storage_write_read_01+0x68>
		00000000000000ac:  R_AARCH64_CALL26	__clang_call_terminate

Disassembly of section .text.__clang_call_terminate:

0000000000000000 <__clang_call_terminate>:
       0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
       4: 910003fd     	mov	x29, sp
       8: 94000000     	bl	0x8 <__clang_call_terminate+0x8>
		0000000000000008:  R_AARCH64_CALL26	__cxa_begin_catch
       c: 94000000     	bl	0xc <__clang_call_terminate+0xc>
		000000000000000c:  R_AARCH64_CALL26	_ZSt9terminatev
