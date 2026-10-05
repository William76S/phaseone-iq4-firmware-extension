# Exclusive file-backed renderer arena

Original `962058` accepts a backing pointer and uint64 capacity. It reserves
80MiB, then `963d5c..963d80` deducts the decoded Bayer frame; native allocator
usage/limit in `91ae88..91aef0` are uint64. Full RGB16 intermediates, RGB32 and
planar output reside in this arena. These are finite static facts from the
original User, not proof of a supported camera mapping or sufficient capacity.

This implementation reserves a private card file and maps it MAP_SHARED. On
unsupported fallocate it physically zero-writes the complete length with
checked counts, fsync and exact fd/path identity before mapping. A sparse
ftruncate alone is never accepted as reservation. No saved IIQ or output JPEG
is opened for writing. Capacity is page aligned and below 4GiB; native single
plane signed-32-bit limits remain the renderer's responsibility.

The production Linux syscall bridge binds the existing verified syscall/errno
PLT aliases used by FS04. No native constructor, address probe or file call
runs on module startup. Actual card lease/epoch and exclusive task namespace
must be supplied by the native coordinator. It retains mapping/fd on UNKNOWN,
rejects cleanup while loaned to a worker and rejects changed file identity.
Stat followed by unlink is not an inode-conditional delete: the actual sole
namespace owner must remain held through cleanup. Native generator/workers
must have truly joined and been destroyed before ending a loan; a logical loan
token is not a native completion receipt.

Host tests exercise real small file-backed memory, readback, partial writes,
ENOSPC, map-boundary epoch loss, owner loss, replacement, flush failure and
post-unmap epoch loss. The supported-fallocate fixture is synthetic; it does
not claim macOS or IQ4 supports Linux fallocate. AArch64 code is compiled only.

Unverified on IQ4: target filesystem allocation/mmap semantics, physical card
removal during page faults, original native allocator upper bound, working
set, extra profile/map allocations, source/worker ownership, performance and
power-loss recovery. This module therefore does not prove full-size export or
authorize installation. Source-card access remains leased until scratch and
source cleanup have completed; existing hardware thermal protection remains.
