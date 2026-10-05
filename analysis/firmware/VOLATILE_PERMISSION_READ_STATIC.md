# Five native permission bool reads — finite static and host contract

This increment supplies only five original OsEvent read plans and strict typed reply/snapshot validation. It extends the frozen Locked route without changing that route's source or evidence. No SDK, transport, target execution, camera, network or actual PIN/key value access occurred. It does not generate event setters, property setters, packets, a directory dump or an arbitrary event reader.

Input User candidate: `analysis/firmware/extracted/P1Linux_6.03.21.bin`, 11,874,544 bytes, SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`, BuildID `1f451370d713ae1f341e9d5de5615717f9fb36ed`. All VAs below bind this ELF only; the current camera User hash and owner have not been verified by this offline increment. Exact windows, section-derived file offsets and bytes are in `volatile_permission_read_static/exact_bytes.json`.

## Finite names and positive native binding

PinGroup constructor `0x63db5c..0x63dbfc` explicitly constructs each following owner through bool constructor `0x415354` with default false and change mode1. That bool constructor registers its interior event (owner+8) in OsEvent directory through `0x70f12c→0x711aa0`. The same bool VT/formatter/RTTI contract is used by the frozen Locked route. Main's actual PinGroup creation is already captured at `0x41a100..0x41a118` in that freeze.

| Exact whitelist name | Name string VA | Bool owner in PinGroup | Interior event | Original plan body |
|---|---|---|---|---|
| `Unlocked` | `0xbe1c38` | `+0x768` | `+0x770` | `"OsEvent list Unlocked -f"` |
| `UnlockFirmwareUpdate` | `0xbe1c48` | `+0x840` | `+0x848` | `"OsEvent list UnlockFirmwareUpdate -f"` |
| `UnlockUI` | `0xbe1c60` | `+0x918` | `+0x920` | `"OsEvent list UnlockUI -f"` |
| `UnlockCapture` | `0xbe1c70` | `+0x9f0` | `+0x9f8` | `"OsEvent list UnlockCapture -f"` |
| `UnlockRestoreToDefault` | `0xbe1c80` | `+0xac8` | `+0xad0` | `"OsEvent list UnlockRestoreToDefault -f"` |

The exact names come from constructor arguments, not label translation or guessed property IDs. In particular `UnlockFirmwareUpdate` includes `Update`. The helper rejects `PinCode`, `SetPinCode`, `EncodedPinCode`, `PinCodeFails`, `Locked` (handled only by its separate frozen helper), `all`, an empty name, wildcards, injected flags and every name outside these five.

## Native listener and recompute chain

The input Locked event is positively subscribed by SecurityHandler constructor `0x6aac0c..0x6aac1c` (PinGroup+0x10→subscriber). Its callback `0x6aac4c..0x6aac70` invokes `0x6aac70`. The complete recompute is already frozen in `volatile_lock_command_static`. This increment captures its state reads and positive permission stores:

- `0x6aac90..0x6aacc4` reads Locked, computes `!Locked`, and calls the original bool setter on PinGroup+0x768 (`Unlocked`).
- With Locked=false, branch `0x6aad04..0x6aad0c` goes to `0x6ab140`. `0x6ab140..0x6ab190` sets all four `Unlock*` owners to true through `0x4149b0`. Its following four guard setters are virtual and remain an explicitly unclosed secondary-effect boundary.
- With Locked=true and Level0/NoLock, `0x6aad44..0x6aad94` also sets the four `Unlock*` owners true, but `Unlocked` remains false. Thus four permitted operations alone do not prove Locked=false.
- With Locked=true and Level1/Basic, `0x6aae38..0x6aae88` sets FirmwareUpdate=false, UI=true, Capture=true and RestoreToDefault=false. This is a static branch, not the camera's observed baseline. Do not substitute it for original typed readback.

The original bool setter `0x4149b0..0x414a30` protects its current value, writes owner+0xc0 on a required change, then notifies owner+8 through `0x70f2f8`. That notification visits listener VT+0x10; subscribed observer and scheduler completion must still be verified in a live trial. A completed command fragment or one true value does not prove the entire asynchronous UI/guard chain is settled.

## Prefix filter and strict host validation

Each plan is one complete quoted body for the first lexer, then four exact tokens for DevelopmentShell's second parse. It never passes through Sys rejoin and has no `=` or escaped quote. Use the original SDK development sender, owned bounded input and fully verified Common/payload contracts; this helper includes no sender or packet construction.

`OsEvent list` applies a case-insensitive prefix filter, even for these complete names. `-f` uses the original full-name copy limit (63 characters) rather than the default32; it is not a qualified group name. Each **completed** response must contain the exact two original heading lines and exactly one row whose name equals the requested whitelist name, type is bool `b`, value is canonical `true`/`false`, log is0/1, notify is blank/0/1/H, and waiting-thread count is a finite unsigned decimal. Additional prefix matches, duplicates, another whitelist name, truncated name, unexpected prompt/footer/error, wrong type, numeric bool value, missing final newline, binary data and oversized output fail validation. Strict original header and row formatting are reused from the source-locked Locked helper; unknown runtime formatting is a blocker, not text to trim silently.

Before text validation the executor must separately establish response correlation, exact declared/received span, fragment sequence/flags and final-fragment completion with the original receiver/FragmentAssembler contract. This parser itself cannot establish transport completion or native scheduling completion.

## Trial readback without a sleeping user's touch interaction

After native FF.0 support/Start/auth has passed, actual User identity matches the bound ELF, full original EEPROM double backup is preserved and a separate exact unique Locked=true read is obtained:

1. Obtain the five original typed permission values twice. The whitelist helper requires full name coverage with no duplicates and equality between two sequential passes. Retain this original baseline and read Locked again before any state-changing action. Sequential passes are not an atomic snapshot; quiescent native operations, stable Locked and a single executor remain necessary.
2. After an independently authorized original temporary Locked=false action, receive its terminal response, read Locked=false, then obtain two stable passes of the five permission reads. All five must be true. Read Locked=false again and require complete raw EEPROM equality. This supports native state/permission readback without touch input; it does not prove visually rendered UI or all permission consumers.
3. After the original Locked=true rollback, read true and require both stable permission passes equal the recorded original baseline, not an assumed Basic preset. Read Locked again, confirm raw EEPROM equality and original program/owner. Only a complete restore round trip supports a final temporary false decision by the sole executor.
4. Any state change between passes, extra name, type mismatch, incomplete reply, raw persistent mutation or failed restoration stops the dependent action. NoLock=0 remains a separate persistent configuration candidate and is not mislabeled Locked=false.

Host source: `tools/firmware/os_event_permissions_host.py`; tests: `tools/firmware/test_os_event_permissions_host.py`. Ten synthetic tests exercise all five plans/booleans, prefix/name collisions, forbidden credential names, duplicate/missing rows, wrong types, incomplete/binary output, exact snapshot coverage and two-pass inconsistency. They are host-only evidence, not actual camera values. Freeze reproduction: `python3 tools/firmware/volatile_permission_read_collect_static.py`. Previously frozen Locked source and manifests are required dependencies and are read/hash-checked, never changed.
