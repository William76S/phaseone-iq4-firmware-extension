The 54 core extends the working 53 XQD JPEG route with a 50% option. It borrows
the original processing worker's complete RAW input and WorkingSettings,
renders 7102 × 5326 ARGB8 synchronously, and sends those rows to the original
JPEG82 API at quality 100. It never enlarges the existing 4K preview.

The JPEG job owns the unpublished 100 MiB output buffer. Its transaction first
captures the catalog index, node identity and basename under the native
catalog mutex. A processing worker claims that transaction atomically before
reading its fields, then checks its worker, index and held node. Encoding runs
on that processing thread; card publication runs only on the original JPEG
writer thread after terminal rendering, all three joins, encoder return,
WorkingSettings restoration and release of the borrowed image.

The original 4K preview still runs once to complete the factory IFM lifecycle.
Its encoder cannot overwrite a Half JPEG or act as a fallback. An unmatched or
failed Half writes no JPEG and retains the RAW. If the native wait ends while
the processing lease is active, the core enters HOLD and prevents further use
of its output buffer until restart. Only Half's native background wait changes
from 10 to 60 seconds; the factory callback and cleanup remain in use.

The first supported scope is full 14204 × 10652 RAW with native rotation zero.
Both 4K and 50% use quality 100; their getter reports the actual implementation.
Size choices persist in the extension-owned `/mnt/qspi/iq4-stock-half.cfg`
with its own backup and temporary files. Native JPEG Size remains enum 1.
The factory done bit remains intact: All skips photographs already exported
to JPEG, including an existing 4K JPEG. Test Half on a fresh photograph or a
RAW that has not yet been exported.

`build.py` runs seven focused ownership fixtures and compiles the new core and
configuration objects. The unchanged sink reuses its real host JPEG encode
and full entropy decode evidence. Original A64 receipts separately establish
ARGB15 conversion, same-index reprocessing and fresh waiter state. These are
offline results; camera generation and physical card writing require actual
54 acceptance. Freeze the source and object closure with `freeze.py`.
