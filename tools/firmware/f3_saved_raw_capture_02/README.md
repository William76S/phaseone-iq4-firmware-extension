# Saved RAW capture atomic-settings overlay 02

Link the new runtime.o instead of frozen Capture01 runtime.o. Keep its other four
objects, header, exact original bindings and hooks unchanged. This overlay reads
Menu04's actual packed `iq4_f3_settings_snapshot_04` once, snapshots mode/size/
quality into the original immutable producer ticket, and validates its bounds.
Three individual getters read twice could form a combination never committed by
UI; repeating them does not make that combination atomic.

Build normalizes only the policy body and two include paths and proves every
other byte equals frozen01. Eight meaningful direct actual-policy-body fixtures
pass normal/ASan/UBSan; one target object is compiled without execution. Host
fixture naming compile failure was corrected and preserved separately. The real
production settings getter is provided by frozen Menu04, not a host stub.

`python3 tools/firmware/f3_saved_raw_capture_02/build.py`

SD-only automatic saved-file completion and normal capture-owner cleanup remain
01. XQD automatic conversion is still not bound; original RAW remains. Existing
IIQ files are never adopted as newly captured RAW. JPEG-only removal is exclusively
coordinator06's second stage after normal render cleanup and checked publication.
