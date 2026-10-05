# Native Shell quote/NUL ownership and finite input guard

The exact offline User ELF copies input into its own 256-byte Shell line buffer
and clears that buffer's remaining tail on every completed `Readline`. A closing
double quote immediately followed by the host command's appended NUL therefore
does **not**, by itself, establish a tokenizer out-of-allocation read. For the
finite printable wrapper considered here, host command text of at most **242
ASCII bytes, including both outer double quotes and excluding the appended NUL**,
leaves both the line terminator and one additional owned zero. An extra trailing
ASCII blank is unnecessary for this specific boundary; it consumes another byte
of the same limit. The separate 255-byte Sys rejoin limit is insufficient as an
input guard.

This is static analysis and a host synthetic model. No SDK was loaded, no camera
was accessed, no packet was generated or sent, and no EEPROM or credential was
read. Existing echo/Stage2/Stage3 source and frozen evidence were not modified.
Their actual command lengths still need host validation against this contract.
Authentication, request-pool lifetime, execution, response completeness, runtime
User identity and recovery remain separate requirements. ProtocolVersion does
not traverse this quoted Shell input path.

## Exact source and reproduction

- User: `analysis/firmware/extracted/P1Linux_6.03.21.bin`, 11,874,544 bytes,
  SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.
- Every address below is a linked AArch64 VA in that precise ELF. The collector
  records section-derived file offsets, exact bytes and range hashes; no address
  is asserted to match the currently running camera.
- Run `python3 -B tools/firmware/shell_input_guard_collect_static.py`.
- Evidence: `analysis/firmware/shell_input_guard_static/exact_bytes.json` and
  `manifest.json`; each disassembly line is whitespace-normalized.
- The host-only model and 26 tests are in
  `tools/firmware/sys_exact16_argv_01/`. Tests use synthetic printable operands
  and host printf sinks, never an EEPROM destination or actual device payload.

## Positive owner and reader chain

| Link | Exact instructions / data | Consequence |
|---|---|---|
| Main owner construction | `0x424688..0x4247b0`: `0x4246a8` constructs the FF character-device; `0x4246c8` passes that same pointer in x1 to Shell ctor `0x741628`; `0x424700` passes it in x3 to handler `0x872828` | The handler and this Shell share the same character-device; this is not an assumed console |
| Shell stores source | `0x7416cc..0x7416d4` stores incoming x1 at Shell+0x260 | Reader fetches this exact source |
| Thread callback | Main `0x424760/64` selects member pair `(0x58,1)`; `0x424770/78` passes Shell to callback ctor `0x415774`; ctor stores owner+8 and pair+0x10/+0x18; `0x424794..0x4247ac` constructs/starts the Thread | Actual startup binds this owner and virtual slot |
| Member dispatch | callback VT `0x9f12f0+0x10 = 0x4162d4`; `0x416300..0x416340` tests pair bit0 and loads owner VT+0x58; `0x416350` calls it | Shell VT `0xc33130+0x58 = 0x742dcc`, so this is the registered worker |
| Worker line allocation | `0x742dcc` allocates stack 0x450; line is sp+0x70, context is sp+0x170; `0x742e30..0x742e40` passes line and w2=256 to `0x743298` | Line buffer owns exactly offsets 0..255, independent of packet bytes |
| Worker parse extent | `0x742ebc..0x742ec8` passes the same line, length 256, to `0x73fb60` | Tokenizer receives capacity 256, not raw request text length |

Main registers the `IqpDevelRaw` forwarding handler on this new Shell's command
directory at `0x424718..0x424738`. The handler's target is the separately passed
global command-directory owner. Its private function names are inferred from
behavior; nearest exported objdump labels are not used as identities.

## Input bytes, terminator and tail on every command

`IqpDevelRaw\0` at VA `0x9f5c20` has 11 characters. Character-device ctor
`0x871e10..0x871e14` defaults append-newline to true. Input setup
`0x871edc..0x871f60` borrows the raw payload's offset/length and computes text
length with `strnlen`. Getc `0x8720ec..0x872314` returns the prefix, one ASCII
space (`0x872214..0x872228`), the nonempty text bytes, then LF
(`0x8722c4..0x8722d8`). The normal nonempty path changes state after the final
text byte; it does not copy the appended request NUL as a line character.

`Readline` receives that same character-device via Shell+0x260. At
`0x7433b0..0x7433dc` it calls Getc; `0x7433e0..0x7433f0` maps LF to CR.
Printable-byte storage `0x7441bc..0x7441fc` writes the byte, increments the line
index and writes a NUL at the new index. CR storage `0x743bf4..0x743c0c` writes
a terminator and increments the index. The completion path removes the CR
index contribution and finishes any comment-tail assembly at
`0x7442d4..0x744374`; then `0x744378..0x7443ac` writes zero from the resulting
index until the supplied capacity, exclusive. It executes on each completed
read, not only worker entry's initial memset at `0x742e00..0x742e14`.

The optional debug-output branch `0x742e44..0x742eb8` clamps temporary output to
254 characters, briefly appends LF/NUL, outputs it, then restores the original
NUL. It does not remove the following owned zero in the finite case.

For host text T and completed line length N:

```
N = 11-byte prefix + 1-byte separator + T
N <= 254  =>  T <= 242
line[N] = 0; line[N+1] = 0; N+1 <= 255
```

The finite profile excludes CR/LF, other controls, non-ASCII, empty input,
embedded NUL and `#` comment syntax. It requires the known outer-quote shape and
does not certify interactive editing, history, escape sequences or full-buffer
behavior. T>=243 is rejected before dispatch. In particular, at N=255 the
tokenizer's next load can reach line index 256, adjacent to the context on the
worker stack; this report does not label that observation as a demonstrated
device OOB fault, heap OOM or execution result.

## Tokenizer read-before-length and actual second-pass remaining extent

`0x73fb60` forwards to `0x7400ac`, which stores the borrowed pointer at context+8
and declared length at context+0x10. It does not allocate another padded string.
The tokenizer `0x740144` loads the current byte at `0x74016c` before testing the
declared length at `0x74017c..0x740188`. Its quote helper `0x740700` includes the
closing quote in consumed length; the caller replaces that closing quote with
NUL at `0x740284..0x7402a4`, then increments position again at
`0x740360..0x740368`. With a closing quote at N-1, the next load is index N+1,
which is owned and zero under the finite bound above.

The forwarding handler does not reparse a freshly allocated packet string:

1. `0x872934..0x87293c` calls `0x6f6b8c`, reading context+8: original line base.
2. `0x872940..0x87294c` obtains token 1 pointer via `0x4641fc`.
3. `0x872950..0x87295c` subtracts the pointers to compute the token offset.
4. `0x872960..0x872978` reads context+0x10 via `0x872a68`, then computes
   `remaining = 256 - token_offset`.
5. `0x8729ac..0x8729c8` invokes the context VT+0x10 parser with that pointer and
   remaining extent. Context VT `0xc329c8+0x10 = 0x73fb60`.
6. `0x8729cc..0x8729f0` dispatches the reparsed context to its global owner.

For the standard outer-quoted input, token1 begins at line index 13, leaving
243 owned bytes. The first pass's replaced closing quote is already a NUL; the
second pass retains access to the zeroed line tail within its declared extent.
This establishes the logical and physical line-buffer relationship; it does
not prove that the earlier borrowed request pool stays alive throughout Getc.

The quote scanner retains backslash bytes. Its precise increment-before-test
order means a backslash before a double quote does not implement a shell's
escaped-quote semantics. Plain scanning treats `=` as a destructive separator;
single quote is an ordinary native byte. None of these are made safe merely by
adding a trailing blank.

## Host evidence and compatibility conclusion

The pure model initializes a reused 256-byte line to nonzero stale data, models
the per-completion tail clear, runs both destructive parses and records the
maximum index read. The T=242 boundary reads at most index 255; T=243 is refused.
All 232 shorter synthetic payload counts also stay within 256. A separate
minimal fixture with only one allocated NUL intentionally raises the model's
bounds error; it is a counterexample to assuming general tokenizer padding,
**not** the real Shell allocation path.

26 host-only tests pass. The existing closing-quote-plus-NUL profiles need a
**host text length <=242 guard**, not a new blank solely for this quote read.
If a compatibility revision chooses a blank for other reasons, the blank must
be included in the same bound. No existing frozen profile has been certified as
executed or safe in its other protocol/owner/recovery dimensions by this study.
