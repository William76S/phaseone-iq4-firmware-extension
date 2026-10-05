  7b53c4: f9402fe0     	ldr	x0, [sp, #0x58]
  7b53c8: 910b6003     	add	x3, x0, #0x2d8
  7b53cc: f9402fe0     	ldr	x0, [sp, #0x58]
  7b53d0: 91172000     	add	x0, x0, #0x5c8
  7b53d4: d2a76c02     	mov	x2, #0x3b600000         // =996147200
  7b53d8: aa0003e1     	mov	x1, x0
  7b53dc: aa0303e0     	mov	x0, x3
  7b53e0: 9406b31e     	bl	0x962058
  7b53e4: f9402fe0     	ldr	x0, [sp, #0x58]
  7b53e8: 91132003     	add	x3, x0, #0x4c8
  7b53ec: f9402fe1     	ldr	x1, [sp, #0x58]
  7b53f0: d280b900     	mov	x0, #0x5c8              // =1480
  7b53f4: f2a76c00     	movk	x0, #0x3b60, lsl #16
  7b53f8: 8b000020     	add	x0, x1, x0
  7b53fc: d2a08c02     	mov	x2, #0x4600000          // =73400320
  7b5400: aa0003e1     	mov	x1, x0
  7b5404: aa0303e0     	mov	x0, x3
  7b5408: 9406c3a4     	bl	0x966298
