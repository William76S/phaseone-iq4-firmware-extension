# Native JPEG catalog destination

Two bounded B replacements replay original directory scan loads `493600` and
`49360c`. Only saved input flag16 (JPEG presence) follows the selected SD/XQD
destination. RAW flag4 keeps its original SD filesystem/path; original flag2
enters the untouched XQD branch. No completion flag is set or cleared here.

The JPEG scan retains original `493598(catalog, ".JPG", 1024, 16)`, actual native
directory enumeration, filename matching, node bit OR, and catalog mutex. It
does not relabel flag16 as RAW flag2. All registers except the replaced load's x0
result, SIMD registers, NZCV, original stack and native parent unwind state are
preserved by the wrappers.

Main `424990..424ae8` obtains SD/XQD filesystems using original registry IDs10/11.
Corresponding path pointers come from each original directory object's VT+28
method. The XQD path is the original +7e0 scope used by RAW scanning; no new root
path or recursive All-images scope is invented.

Destination changes additionally need a real clear+scan in the bridge under
idle-job/requester ownership. Original `493994(catalog,16)` has no mutex itself;
the bridge must guard it with original catalog+1c0 mutex. Original scan takes that
mutex itself, so release the outer guard before scanning. Original card/settings
dispatcher `492a38` gates JPEG scanning on SD availability and cannot alone prove
no-SD XQD refresh. This component supplies selector hooks, not that transaction.

No camera control, deployment, full-size output or device acceptance is claimed.
