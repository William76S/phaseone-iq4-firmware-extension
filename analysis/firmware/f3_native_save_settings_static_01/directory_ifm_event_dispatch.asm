  4924a0: a9be7bfd     	stp	x29, x30, [sp, #-0x20]!
  4924a4: 910003fd     	mov	x29, sp
  4924a8: f9000fe0     	str	x0, [sp, #0x18]
  4924ac: f9000be1     	str	x1, [sp, #0x10]
  4924b0: f9400fe0     	ldr	x0, [sp, #0x18]
  4924b4: f943cc00     	ldr	x0, [x0, #0x798]
  4924b8: 91002000     	add	x0, x0, #0x8
  4924bc: f9400be1     	ldr	x1, [sp, #0x10]
  4924c0: eb00003f     	cmp	x1, x0
  4924c4: 540001a0     	b.eq	0x4924f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c54c>
  4924c8: f9400fe0     	ldr	x0, [sp, #0x18]
  4924cc: f943e400     	ldr	x0, [x0, #0x7c8]
  4924d0: 91002000     	add	x0, x0, #0x8
  4924d4: f9400be1     	ldr	x1, [sp, #0x10]
  4924d8: eb00003f     	cmp	x1, x0
  4924dc: 540000e0     	b.eq	0x4924f8 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c54c>
  4924e0: f9400fe0     	ldr	x0, [sp, #0x18]
  4924e4: f943c000     	ldr	x0, [x0, #0x780]
  4924e8: 91078000     	add	x0, x0, #0x1e0
  4924ec: f9400be1     	ldr	x1, [sp, #0x10]
  4924f0: eb00003f     	cmp	x1, x0
  4924f4: 540000a1     	b.ne	0x492508 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c55c>
  4924f8: f9400be1     	ldr	x1, [sp, #0x10]
  4924fc: f9400fe0     	ldr	x0, [sp, #0x18]
  492500: 9400014e     	bl	0x492a38 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ca8c>
  492504: 1400000c     	b	0x492534 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c588>
  492508: f9400fe0     	ldr	x0, [sp, #0x18]
  49250c: f9419400     	ldr	x0, [x0, #0x328]
  492510: 9111a000     	add	x0, x0, #0x468
  492514: f9400be1     	ldr	x1, [sp, #0x10]
  492518: eb00003f     	cmp	x1, x0
  49251c: 54000081     	b.ne	0x49252c <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c580>
  492520: f9400fe0     	ldr	x0, [sp, #0x18]
  492524: 94000222     	bl	0x492dac <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5ce00>
  492528: 14000003     	b	0x492534 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c588>
  49252c: 52800000     	mov	w0, #0x0                // =0
  492530: 14000002     	b	0x492538 <_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcS5_S5_+0x5c58c>
  492534: 52800020     	mov	w0, #0x1                // =1
  492538: a8c27bfd     	ldp	x29, x30, [sp], #0x20
  49253c: d65f03c0     	ret
