# Actual native fanout weights — static review only

Bound to stock User SHA `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`; all addresses and exact bytes are recorded by `collect.py` in `EXACT.json`.

Main builds three 0x1400-byte context objects at `0x41a73c..0x41a7cc`. It passes ctor `0x5e36f0` w2=4 for array+0x10, w2=2 for array+8, and w2=1 for array+0. Ctor `0x5e3704` stores w2 to sp+0x2f; `0x5e3b34/38` stores that byte to context+0x13f3. This is a real original ref-weight field, not a UI-generated storage flag.

Main XQD storage ctor at `0x424820` receives x2=[contextArray+8] (weight2). Main SD storage ctor `0x42488c` receives x2=[contextArray+0x10] (weight4). Thus the two actual native context identities distinguish XQD=2 and SD=4. The array[0] weight1 is another native consumer and must not be treated as either card. Main manager ctor `0x424920` passes the same array as its stack argument and count3. `0x8db01c` saves that array at manager+0x10; the inherited base receives count3 at `0x8daf10/14`.

At `0x8dc4ec` the original predicate is called with x0=manager, w1=current array index. Only a true result admits that context to the current node notification: writes context+0x13f0=1, +0x13f1=1, then `0x8dc570` notifies context+0x988 with manager+0x48 node. `0x8dc590` reads the actual admitted context+0x13f3 and adds it to the one-byte ref sum; `0x8dc634` passes the sum to `0x8c5cdc` with the real manager node. Original use is additive ref weights. Because the three initialized values are disjoint powers of two and the loop visits each actual context once, this particular initial fanout sum also preserves membership.

A new own JPEG group can observe real true predicate results, map only context identity+weight2/4, and close its pending selected-card mask before allowing either completed card to release the group. It must not derive an expected mask from the two UI modes, require a missing-card callback, overwrite original refs, or count array[0] as a card. A zero own-JPEG mask is a known no-JPEG path, not Hold.

The predicate includes native mode/config and availability gates at `0x8dc278..0x8dc3fc`; UI mode does not bypass them. This static result does not prove current card presence, current actual selected mask, callback completion, RAW close success, or device lifetime. Those remain actual producer receipts; no device was accessed or firmware code executed.
