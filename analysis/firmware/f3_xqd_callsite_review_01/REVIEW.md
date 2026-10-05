# XQD capture Store callsite: finite original-User review

Static only, original User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
`EXACT.json` retains every instruction byte, file offset and hash for five bounded
windows and the complete XQD primary table used below. No device/SDK/ELF execution.

The exact inner complete-RAW call is **0x8df038 → 0x8df19c**, old LE bytes
`59 00 00 94`. Input `x0=[sp+0x28]` is the actual XQD storage, `x1=[sp+0x20]`
the current node, and `x2=sp+0x40` the native concrete full filename. The outer
helper `0x8dec5c` built this filename from its actual directory/basename and checked
existing paths. At `0x8df03c..04c` it checks the inner bool. True updates the node
name at `0x8df05c → 0x8c3294`, then returns **outer status 0**. Failure returns
outer status 1. These return domains are not interchangeable.

Main resolves **registry id11**, flag1 at `0x4247b0..7bc → 0x74e454`. Its result
is passed in `x7` to the only discovered direct constructor call,
`0x424820 → 0x8de7dc`, for an actual 0x528-byte object. That constructor stores:

| Field | Actual constructor input / evidence |
| --- | --- |
| primary vptr `0xdbc280` | `0x8de81c..828` |
| `+0x1b8` PowerWrite owner | constructor x3, stored `0x8de834` |
| `+0x2c0` actual FS | constructor x7 = Main's registry id11, stored `0x8de860` |
| `+0x508 / +0x510 / +0x518` metadata | constructor x4/x5/x6, `0x8de890/89c/8a8` |
| inherited manager | base `0x8dcbc0`, constructor x2 from Main `[sp+0x1b00]+8` |

The primary vtable's `+0x40` is **0x8deb94**; `+0x48` is still **0x8dcf98**.
Thus a generic seven-argument Store pointer does not identify the XQD complete
writer. `0x8deb94` marks `storage+0x2b8` active around its direct call to
`0x8dec5c`, notifies `storage+0x1c8` afterwards, then on outer status0 runs the
original manager `+0xdc8` callback `0x4a7084`. The base dispatch window records
the original task status domain and original callbacks; it does not prove an
extra asynchronous node/source retain.

The peer's complete inner writer window separately shows first checked close
`0x8df5d0 → 0x7d8a38` **followed by** native reopen, full header writes and final
File destruction. The first close alone cannot authorize a saved-file receipt.
The producer must stay synchronous inside `0x8df19c`, establish the real final
file/FS/directory and last-close result, independently hash the closed full IIQ,
and retain its actual native/card ownership through the JPEG consumer ACK.
The final-close binding and dual-card group lifetime belong to the new producer;
they are not asserted by this limited callsite review.
