# Source constructor dependencies 02

This is the production overlay for frozen SourceDeps01. It keeps that public C++
ABI and owner/dependency inspection. Link **this dependencies.o instead of 01**.

The 01 stock window [0x8dc494,0x8dc4c4) included the exact instruction replaced by
Capture01's acquired hook. Its stock comparison would reject a linked capture
producer. This revision preserves the first44 bytes, then requires the actual
instruction at0x8dc4c0 to be AArch64 B (not BL), with its sign-extended target equal
to the actual linked `iq4_f3_raw_acquired_wrapper_01` symbol. It does not present
patched memory as original bytes or accept a caller-filled hook address.

`python3 tools/firmware/f3_source_dependencies_02/build.py` runs17 owned fixtures
in normal and ASan/UBSan configurations and cross-compiles one AArch64 object.
Only the host fixture macro substitutes a finite synthetic target. The target
object retains a real relocation to the acquired-wrapper symbol. Tests cover the
actual positive branch, wrong B target, BL, original STR, unreadable word and a
changed byte in the remaining original prefix. The original12 owner/dependency
cases are retained. Native functions, SDK and the target are never executed.

The process-lifetime constructor dependencies remain borrowed and immutable.
This is not a native file/source/card lease. bcmp is a compiler-produced alias;
final linking must bind it to the verified original memcmp PLT as Root specified.
