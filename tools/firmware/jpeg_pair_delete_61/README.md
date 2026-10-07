# JPEG pair deletion 61

Only original in-camera human DeleteFile sites are extended; automatic JPEG-only
RAW retirement is untouched. The two RAW File.delete calls retain the selected
card's original native client and exact native directory. An existing regular
same-basename JPEG is removed by the original LinuxFilesystem PathDelete before
the original RAW File.delete. Missing JPEG is allowed; errors preserve the RAW
at that call and set native popup/return failure. Successful SD pair cleanup
suppresses its later duplicate stock SD JPEG branch.

A third native SDStorage getter-call wrapper preserves the getter result and
handles genuine JPEG-only `.JPG` records from the independent gallery registry.
The retired node pointer is compared as a token, never dereferenced; the already
shifted native catalog index is not queried. The registry checks the exact path,
card and cached node/name. The native DeleteFile client is borrowed if already
held, otherwise its bounded request is released and read back. The existing
outer native catalog lock is owned by DeleteMarkedFiles; registry callbacks must
not acquire it again. Successful deletion forgets that exact registry entry.

The original stock DeleteFile removes its catalog record before card deletion.
This module reports failures through the original popup and false return, but
cannot promise an atomic catalog/disk rollback. Original Archive scope remains:
XQD primary deletion preserves the SD archive copy. No other directory/card is
searched or deleted merely because it has a matching basename.

`build.py` creates AArch64 objects and runs 40 focused host cases normally and
under ASAN/UBSAN. `prove_original.py` executes the actual original deletion-policy
region for five modes and proves the original XQD JPEG gap. Actual target wrapper
ABI/File lifecycle proof is supplied by the independent observer agent. These
are offline checks; camera/card deletion acceptance remains required.
