  904010: 29028801     	stp	w1, w2, [x0, #0x14]
  904014: d65f03c0     	ret
  904018: 0e040c41     	dup	v1.2s, w2
  90401c: fc40c000     	ldur	d0, [x0, #0xc]
  904020: 4e0c1c21     	mov	v1.s[1], w1
  904024: 0ea18400     	add	v0.2s, v0.2s, v1.2s
  904028: fc00c000     	stur	d0, [x0, #0xc]
  90402c: d65f03c0     	ret
