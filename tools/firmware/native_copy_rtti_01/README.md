# Actual loader COPY RTTI contract 01

Original User _ZTIi (f42a70/16,index522) and __class_type_info vtable
(f429c8/88,index377) have zero file bytes populated by R_AARCH64_COPY.
Hashing those file zeros at runtime would always reject normal loader output.
This module never treats them as an accepted excluded mutable span.

The exact official libstdc++ analyzed locally is1,538,432 bytes, SHA256
5876c5861ffae1b3f6a5fc091be8f1d601edf602ebeed6a4aa3bf5c3cfbe11aa.
Its class destructor D1 resides at8ee38. Reading the actual copied class table's
slot+16 derives the shared-library bias without proc/dlsym/loader/SDK calls.
Bias must obey the actual64KiB ELF LOAD alignment; exact ELF/program headers,
all31 finite RTTI/name/table/function spans and their pointer relocations are
then compared twice. All18 member-function bodies are compared completely, not
only a named symbol or unchecked function pointer. Largest selfread is448 bytes.

Dynamic relocation targets prefer the executable's actual defined COPY address,
not blindly library bias+symbol. The class RTTI graph additionally requires the
original __si_class_type_info COPY table f42ae0/88,index493. All three original
COPY version indices8 resolve to libstdc++.so.6/CXXABI_1.3, flags0. Fundamental
int RTTI's vptr/name, class/SI RTTI inheritance and all table slots are closed.
No virtual function or type-info constructor is called. No files/threads/TLS,
new exceptions or libc loader APIs are added. Only the existing memcpy/memcmp
standard ABI imports are required; Root's final linker supplies verified originals.

C ABI: iq4_native_copy_rtti_current_01(context, bounded_self_read). It returns1
only for the exact derived graph. Missing/changed/overflow/unstable data returns0.
No library base or object pointer can be provided by a caller. Anchor is checked
again after the graph. Root combines this function with its actual linked-ELF
immutable code/FDE/LSDA/CFI seal on every resource admission/Ready/worker call.

The original metadata rows included here are original baseline identity windows.
They do not replace the final ELF's *active* relocated dynsym/versions/COPY metadata
seal: Root's Unwind02 verifies that final active metadata and matches ABI_PROOF's
bindings. Root must not accept a proof belonging to another object/source/library.
This is a finite runtime ABI graph check sourced from a hashed original library,
not a claim to have runtime-hashed the whole1.5MiB library or every transitive GOT.
Target throw/catch and target runtime execution remain unverified.

python3 tools/firmware/native_copy_rtti_01/build.py

Sixteen normal and sixteen ASan/UBSan synthetic loaded-memory cases cover all
three missing COPYs, pointer/slot/name/body/ELF mismatches, malformed bias and
unstable selfread. One AArch64 object is actually compiled but never executed.
Original User/libstdc++ binaries are external exact inputs and absent from ZIP.
ABI_PROOF references the final SOURCE hash; it is emitted after SOURCE and is
explicitly excluded from SOURCE members to avoid a circular checksum.
