# F1 actual module entry 01 — Observe only

This is an actually linked AArch64 SO with a concrete runtime bootstrap, not an installation or a mask acceptance result. It discovers the UI owner from original TLS/FP/queue dispatch, verifies the full User executable and mapped RO segments, and records bounded metadata. It never accepts a caller-supplied owner or substitutes old bytes for actual process memory. Constructor opt-in is exactly `IQ4_F1_MODULE_ENTRY_01=OBSERVE`; mask drawing, subscription, button/menu construction and vptr writes are absent from this executable stage.

```
python3 tools/firmware/f1_module_entry_01/build_validate.py
python3 -m unittest discover -s tools/firmware/f1_module_entry_01 -p 'test_decode.py' -v
python3 tools/firmware/f1_module_entry_01/validate.py
```

The builder runs only our SDK-free host tests, and compiles/links/inspects target objects. It does not load the SO, SDK or any vendor executable. Local target artifact and exact command/import/wrapper evidence are under `analysis/sdk_reference/f1_module_entry_build_01`. The pinned original User is 11874544 bytes / SHA256 `9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`; a public firmware string alone does not satisfy this gate.

The original mutex unlock is called exactly once before diagnostic work, preserving errno/result. Other callers take only the forwarding path. If the exact provider cannot be resolved, it preserves the unsupported scope; it cannot return fake success/error or unload. **Even with Observe disabled, a loaded interposer still forwards unlocks:** safe loading requires the actual original libpthread gate before launch. This revision has no process signal, retry, thread, camera API or constructor FD198 handling.

The 440-byte own publication has sequence/startup fields and a 424-byte metadata payload. Startup 0/1/2/3/4/5/6/7 = not selected/selected/provider verified/User verified/observation ready/provider rejected/User rejected/module rejected. Read metadata only from the exact loaded ELF symbol + actual module mapping/inode, with two bounded stable copies. `decode_observation.py` is a file-bytes-only decoder. The C exports describe our same-thread integration ABI; they do not authorize remote arbitrary-address calls.

The probe waits for an original ordinary list whose last dialog is the real LV, then records at most 64 qualified UI boundaries. A bounded list graph with an unknown original prefix below LV is recorded explicitly; it does not extend frozen UI02's strict page predicate. Counters are UI dispatch/getter attempts, never source frames/FPS. +110 is the pan object; +118 is its cache. The local +28 rectangle, cache, scale/rotation/visibility remain candidates, not viewport/source/lease/fresh-blit proof.

Concrete UI02/overlay ports and 19 typed button/own-selector ports are resolved against the actual fixed User. They are not invoked for UI construction. The daily user-entry candidate is a module-owned original text button and original selector/private five items, with distinct ControlObserver and queued Observer ABIs. It preserves stock toolbar tag1/tag8, LV+588 popup/root and RAW crop. Its placement, real input kind/resource/capture and safe detach still need actual receipts; no enabled daily menu is claimed.

`loader_role_env.diff.txt` is a reviewed-sized **source candidate**, not an installer. Frozen RAM Entry02 accepts only a fixed marker module and does not set Observe env. This SO deliberately does not send/close FD198, so it cannot simply replace marker.so. A new fixed role must bind the exact module/source, add the opt-in env with collision/capacity handling, compose a separately reviewed authenticated constructor marker/status path, and use role-specific actual proof. Existing restore-before-exec, runner originals, mount, stock respawn, independent supervisor and cold-boot gates remain. The sidecar enumerates the outstanding source contract precisely.

Until those gates pass there is no installation plan. Once root admits a finite temporary role, disabling must restore and read back the original runner through the existing loader route; the already loaded module stays resident, forwarding only, until original User exit/cold boot. No hot deletion/dlclose is proven. Persistent modification additionally needs complete actual originals and a verified bypass/recovery route. See the minimal actual checklist in `analysis/sdk_reference/F1_MODULE_ENTRY_IMPLEMENTATION_01.md`.
