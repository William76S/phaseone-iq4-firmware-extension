# F3 original Reader dependencies 01

Static/host-only production pointer-discovery code. No SDK, target executable,
Windows, or camera was used. Original User is 11,874,544 bytes, SHA256
`9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb`.

`snapshot_from_ifm` consumes the actual IFM passed by the original Gallery/native
caller. Main `424974` constructs the original Reader and `424ae0/424ae8` passes
that same Reader to derived IFM constructor `4921fc`. Its base `487010` stores it
at `IFM+4d8` (`487160`); the derived primary VT is `b7ece0`. Reader primary VT is
`d86708`. Source01's exact original seven-argument Reader constructor stores
module B at `Reader+8`, module A at `Reader+10`. Its parser at `Reader+380a0`
stores the three metadata initializer arguments at parser `2ab58/2ab60/2ab68`,
giving Reader offsets `62bf8/62c00/62c08`.

`snapshot_from_raw_manager(actualManager, actualNode)` supplies a concrete capture
route: after `8dc4c0` stores the actual newly acquired node at `manager+48`,
`manager+38` is the same NodeManager used by the original acquisition/retirement
chain. `8c5990` reads `NodeManager+320` as IFM before original IFM retirement.
The function verifies both ends twice and checks the still-current node. These
addresses are borrowed owner identities, not a substitute for the caller's
serialized capture lifetime. Run it while the original storage task remains
active, before original node retirement. It does not retain or mutate the node.

`constructor_inputs` rechecks the snapshot and uses the actual held Card05/06 FS
with original Linux FS VT `d91450`. It never uses the original Reader's mutable
`+18` FS. It never opens the shared Reader, borrows its File, rows, decode arena,
parser buffers, or calls its FS setter. Own Reader storage belongs to Source01.
The five metadata/module objects remain borrowed from their original process
owners through native render cleanup, Reader shutdown, and final lease cleanup.
Readable/unchanged pointers are not a proof of lifetime after original owners
are stopped or the process exits; the integrated sole activity owner must retain
the ordinary process/source/card lifetime. Failure keeps RAW and refuses render.

An important manual-export distinction: native IFM VT+38 targets `494c8c`, which
calls `7d95d0` to change the shared Reader's filesystem. It is not a read-only
directory getter. Under the original catalog mutex, its exact file-presence
rule is record byte `+0e & 2` -> FS `IFM+7d0`, directory `+7e0`; else `&4` -> FS
`+7a0`, directory `+7b0`. Native `48c394` obtains the actual catalog record using
`48e9f4` then `48f4f0`; the former mutates/acquires its original node handle.
The new selected-file stage must copy the record's bounded name, directory, and
FS under the original catalog mutex, then independently open/verify that file.
This package supplies dependency discovery, not a completed selected-file stage.
No guessed global selected index/path or all-image export is introduced.

Runtime checks cover nine finite code/table byte windows, actual VT identities,
double-read owner/field consistency, nonnull/readable dependency objects,
address bounds, and fresh snapshot comparison. They do not weaken whole-User
deployment identity or make fabricated positive lease flags. The code only
reads; no native getter, mutex, constructor, SDK, or device call executes here.

Reproduce own host fixtures and compile-only target object:

```sh
python3 tools/firmware/f3_source_dependencies_01/collect_static.py
python3 tools/firmware/f3_source_dependencies_01/build.py
```

12 targeted host cases pass normally and with ASan/UBSan: actual same-reader
discovery, wrong image/IFM/Reader, absent/unreadable dependency, changing owner,
wrong pending node, changed dependency, mutable shared FS independence, wrong
held FS, and overflow. Native owners are explicit fixtures; none are hardware
evidence. Target object is AArch64 ET_REL with no execution. Initial own draft
had an include-line typo, missing explicit macOS C++ headers, and one unqualified
test namespace; final source fixes those compile errors. No previous failed
draft is represented as a passed build.
