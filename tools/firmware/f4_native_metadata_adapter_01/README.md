# Native Access metadata adapter 01

This additive C++ component binds the exact original User image and the existing original LV owner. It does not register/acquire/release an owner, create a second LV, install an observer/hook/page, encode, record, write a card, copy native pixels or deploy. `prepare_native` has no automatic caller or constructor. Root must integrate it with the independently established original UI dispatch boundary and lifetime/recovery gate before a target run.

The target-only preparation reads `/proc/self/exe`, verifies all 11,874,544 original bytes by SHA, ET_EXEC/AArch64 identity, actual nonwritable mapped PT_LOAD bytes and readonly map coverage. Only then does it internally bind exact original CurrentThread/Access Lock/Unlock/Size/ID methods. There is no public boolean image-ready or hardware-ready API in production. The metadata sampler derives the owner from original CurrentThread and Bootstrap02's double-linked queue/manager/UiData/LV/Access/engine chain, original VTs, running LV, actual registered client ID/name and current Access owner.

LV `+0x188 != 0`, retained flag `+0x1c0 != 0`, or existing VideoBuffer locked index `!=4` is rejected without calling Lock or Unlock. After its own original Lock, it compares returned CPU pointer, exact same locked slot, packed actual W/H and software ID with original getters. Every known-owned completion or rejection uses original Access Unlock exactly once; a successful bool return must also leave the original slot unlocked. A thrown Lock, changed owner, incomplete/unknown release or malformed post-lock state preserves a Hold and never retries/unlocks an uncertain owner. No destructor releases a native slot.

`observed_completion_ns` is this module's 64-bit monotonic observation after the completed slot is consumed. It is neither a sensor exposure time nor a new-frame proof. IDs are the original software completion sequence. Duplicate/stale IDs are rejected, gaps/wrap remain software properties, and no 60fps result is claimed.

Production mode is explicitly Unbound: active pipeline mode, RGB semantic/range, actual row layout, mapping range and original allocation capacity are not yet receipts. `request_pixel_copy()` always returns NeedsHardwareReceipts. No production receipt issuer or enable flag exists. The compile-time synthetic-only bridge exercises the frozen preallocated CopyPool's original paired-release/no-publish-on-release-failure behavior; synthetic layout/color/span values cannot enter the production target object.

Metadata also records observed original VideoBuffer fields: component map `+0..+0xc`, configured W/H `+0xd0/+0xd4`, calculated byte budget `+0xd8`, and channel count `+0xfc`. These raw values are not inferred stride, color, sensor/pipeline mode or proof of actual mapping/allocation capacity; the native copy gate stays closed even if they match the static defaults.

Reproduce offline:

```
python3 tools/firmware/f4_native_metadata_adapter_01/collect_static.py --output <fresh-static-directory>
python3 tools/firmware/f4_native_metadata_adapter_01/build_validate.py --out <fresh-build-directory>
```

The second command runs only project-owned synthetic host binaries and compiles three production AArch64 relocatable objects. It does not link/install/load/execute a target module or vendor function. Runtime C++ ABI, original UI lifetime/integration, source mode/color/mapping/capacity receipts and a real target metadata/unlock result remain unverified. Existing frozen files are unchanged.
