# Native own-process reads 01

`iq4_native_self_read_01` uses the fixed original syscall PLT at0x40ae40 through an explicit linker alias. It gets our own PID and performs one bounded process_vm_readv (1–4096 bytes). Only an exact kernel byte count succeeds; it never opens a camera session or writes memory. Failure has no direct-memory fallback. `iq4_native_current_tid_01` returns the actual positive Linux gettid value or zero.

Target headers statically verify the AArch64 syscall numbers172/178/270 and LP64 iovec layout. The extracted stock kernel config has CONFIG_CROSS_MEMORY_ATTACH=y; this is static evidence, not a runtime permission test. The ELF integration must retain the pinned original PLT bytes and corresponding relocation. No dynamic symbol lookup or new import is required.

Host tests simulate syscall replies and cover exact reads, bounds, short/error reads, bad PID and unavailable TID. They do not prove the target kernel permits self reads. The AArch64 object is compiled, never run on the host.
