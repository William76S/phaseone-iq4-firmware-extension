# F1 production UI preparation and external text transaction 10

Offline source and pinned AArch64 compile/link only. Frozen 09 and earlier sources are unchanged. The compact production SO contains the fixed four-band renderer, native-return issuer, whole ABI bridge, actual admitted UI preparation caller, and persistent entry Binding ports. Nothing has been loaded or installed on the camera.

## Live UI preparation

`runtime_prepare_10.cpp` calls `prepare_once_at_live_ui` after the real admitted UI boundary has established the entry, renderer and provider observation. No input means no allocation/configuration attempt. The protected 472-byte `hook10.prepare` plus its 65-byte SHA sidecar is read only on the actual UI. Root must populate it from actual owner/provider/full-source/lease and independent recovery reviews; a digest is not authority.

The preparer checks original User entry bytes `ff0304d1fd7b05a9` at 0x47f910, default OFF, the actual UI TLS and owner, then attempts one non-MAP_FIXED 64 KiB near mapping. Its own veneer and displaced SUB/B-return trampoline are cache synchronized and sealed RX. Actual provider configuration succeeds before the original-call slot is published. Only then does the 192-byte publication report Prepared. No original text is modified by this SO. The normal ingress is 496 bytes, entry status 104 bytes. BoundaryObserved does not issue a write lease.

The new Binding accessor reuses its real TLS/current and listener inspection throughout its retained lifetime. Renderer, provider observation and provider configuration share that Native. The original Module 64-boundary observation cap remains unchanged; stopping observation no longer disables production selection/rendering ports.

## External transaction

`linux_controller.cpp` supplies real ptrace Ops to `transaction.cpp`. It is compiled into Loader10 entrytool with `IQ4_F1_HOOK10_NO_MAIN`: no extra target ELF is required. The only public operations are fixed install/restore paths, tied to the same protected `loaded.pid` PID/start ticks. Contracts are 960 bytes; journal records 36,944 bytes. Default standalone main is prep-only.

Each operation verifies the exact User and SO file hashes, their read-only loaded bytes and map relations, the source-issued preparation and own OFF renderer status, current PID/start ticks, kernel release and /proc/version digest, actual Root-owned receipts and the near RX instructions/slot. It enrolls at most 128 TIDs in four rounds, including the UI, requires two matching final TID/start-tick lists and actual GETREGSET for every TID, and excludes original entry, entire near page and own module RX PCs. No code/allocation/getter is called in the paused User.

The one POKETEXT is eight bytes with the upper original STP preserved. No four-byte atomicity is claimed. Durable WriteIntent precedes it; readback must be exact. A failed install can attempt the inverse original pair once while every TID remains stopped and the bytes are one of the two exact states. No overwrite of foreign/torn bytes. Other TIDs detach before UI. Once any detach occurs no restore/write retry is allowed.

Any acquisition/identity/PC/readback/journal/detach uncertainty with attached TIDs enters HOLD. This includes failures before a text write. The controller must remain alive; normal terminate signals are ignored. Partial detach is explicitly recorded, not claimed fully stopped. There is no automatic SDK Stop/kill/retry/cold boot or unknown-state resume. SIGKILL, crash and power loss remain outside this controller's recovery guarantee. Root must hold independently verified cold/original recovery before authorizing any text transaction.

## Exact cache evidence and boundary

`collect_exact.py` binds complete functions to the extracted actual Boot 7a3a3d6f62c61e7d627a9f55d844d74be9111b26eb7a7fa42f5bdd7be7dabe9e. The actual ptrace/access_remote/copy_to_user_page VM_EXEC path reaches the saved DC/IC/DSB/ISB windows and target-specific kick_all_cpus_sync. Upstream Linux v4.19 sources explain that path but do not identify the currently running kernel. Runtime release/version and Root's actual Boot/cold-boot review remain required; no full kernel-source hash equality is invented.

The linked SO's own Zig __clear_cache full body is saved separately. Its IC loop lacks a post-loop DSB, so the preparer explicitly executes DSB ISH then ISB before RX sealing. Original libgcc clear-cache is a static reference, not claimed to be the linked helper.

The original 0x70be10 object is a steady-clock timer, not a critical section. Complete timer windows and kernel bodies are in the build evidence. No broad lock or SDK safety claim is made.

## Host verification

Only eight new owned transaction fault groups and one persistent-cap regression run, normally and with ASan/UBSan. The detach fixture includes a real partial-success sequence; UI remains last. Frozen UI/geometry suites are not rerun. AArch64 source layouts and actual linked symbols/imports are inspected, never executed. Preparation, actual lease/full source/stock write, text installation, loaded module and mask all remain false until Root obtains actual receipts.
