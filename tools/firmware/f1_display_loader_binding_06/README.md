This independent version binds frozen Display06 to the finite RAM recovery
launcher. Default generation emits no device commands. It never opens SDK,
Windows, network or a device, and target ELF objects are compiled/inspected only.

The authenticated candidate is 74,904 bytes, SHA256
e8636541a1b81be6cdfe4e1f2832a372f17a3f62d5b0536f033534e708cab306.
It preserves prepare -> authenticated role_constructor and seven exports.
Its new identity is not Role02's old module or a rewritten old proof. The SO is
not yet loaded. Both normal and authenticated variants remain mask OFF; neither
installs a paint table or UI entry. The default-off frozen SO is unchanged.

The strip-only serializer keeps each ALLOC section's original index, header,
address and payload, all program headers, dynamic symbols, relocations,
versions, TLS, initializer and exception/unwind bytes. It removes the debug/
nonload tail. The sole explicit LOAD0 exception is ELF section-directory
e_shoff/e_shnum/e_shstrndx at offsets 40..47 and 60..63. Whole LOAD0 equality is
false. The saved strip proofs enumerate actual byte differences. Zig 0.15.2
objcopy --strip-all returned `error: unimplemented`; no unknown strip tool was
used. The finite serializer keeps a valid minimal SHT for local inspection.

Preparation uses:

    python3 -B tools/firmware/f1_display_loader_binding_06/build_prepare.py
    python3 -B tools/firmware/f1_display_loader_binding_06/test_local.py
    python3 -B tools/firmware/f1_display_loader_binding_06/freeze.py

After freezing, default and actual-proof package generation use:

    python3 -B tools/firmware/f1_display_loader_binding_06/generate.py
    python3 -B tools/firmware/f1_display_loader_binding_06/generate.py --emit-enabled --proof <new-private-proof> --runner-a <first-complete-actual> --runner-b <second-complete-actual>

Actual schema iq4_f1_display_loader_gate_v6/profile RAM_F1_display_observe_once
requires the inherited 18 recovery receipts plus current Baseline03 syscall
identity, actual scratch restore/cleanup, stager/cleanup review, Display06 and
exception-provider review, current sole controller/private backup handles, and
an actual base64 decoder roundtrip. Proof pins the new loader SOURCE, Display06
SOURCE, frozen default SO and this exact authenticated stripped SO. See
contract.py/recovery_contract.py for exact names and fields. Baseline rc=-1/
errno=13 never proves absence. Scratch only proves its own inode restoration;
actual stock respawn, cold boot and runner restore remain separate inherited
gates. Receipt hashes validate bytes; Root must authenticate actual source,
held handles, current identity/lease and meanings before each live step.

The public stager has five fixed filenames and no accepted caller shell/path.
It uses no LAN: unpadded base64 full triples and a one/two-byte octal tail.
Commands are <=242 bytes and contain no '='. Each append returns actual file
size through wc after successful decoding; complete ACK+EOF and exact expected
size are required before proceeding. Never retry an uncertain append without
rechecking exact size/identity. Each entire file hash is accepted before chmod
or the next mutation. This SO needs 735 append commands. base64 -d, printf,
wc -c, sha256sum, chmod, mkdir and pipe/redirection options require actual finite
tool/help/hash and scratch byte evidence. Source presence is not that evidence.
No enabled stage package was generated during preparation. Root's native finite
Sys executor must bind this new fixed command plan; old read-only profiles are
not authority to send new setter/loader commands.

The same four paths already observed by Baseline03 are retained:
/run/f1launch, /run/iq4_f1_observe02, and the original/candidate RAM runner names
in /p1/scripts. Internal F4_* identifiers are preserved mechanical recovery
code names; this contains no frame-rate feature. Inherited launcher restores
the original inode before exec, preserves original argv/env/umask, sends no
signal and retains an independent deadline restoration supervisor. Actual
separately authorized native User exit and cold stock recovery are still gates.
Disable restores the runner but does not hot-unload a mapped module.

The new fixed launcher mode --observe-read opens no arbitrary PID/address/path.
It binds protected loaded.pid -> exact PID/start ticks -> stock User exe/hash,
staged module inode/device/hash -> actual offset-zero module mapping and its
original RW LOAD page relation. It reads only the 1440-byte own publication
twice with equal even sequence and rechecks identities/maps/hash afterwards.
No firmware getter, pixel read, target-memory write or SDK call is performed.
Permission denial or partial/changed reads return failure, not a zero record.
The reply is <6 KiB. The own publication is initialized file-backed data; this
reader does not accept anonymous BSS as its mapping. Kernel page size must be
4096, the module's proof uses 4096 pages; future actual maps must establish that
before approving the fixed offsets. Parent paths are protected by the sole
controller, not an atomic comparison against a foreign root actor.

Saved replies decode with independently held new PID/start ticks:

    python3 -B tools/firmware/f1_display_loader_binding_06/decode_read.py <actual-saved-read.json> <actual-new-pid> <actual-new-start-ticks>

Decoder matches this exact module SHA and uses frozen Display06 scalar decoder.
It does not authenticate a JSON file's hardware origin. Mask/full-source/fresh
paint/surface lease remain false. Loading this observation module supplies
boundary geometry/provider observations; actual paint records still require a
separately reviewed reversible paint-table installation. UI entry and paint
mutation are explicitly false in this loader proof and cannot be enabled here.
