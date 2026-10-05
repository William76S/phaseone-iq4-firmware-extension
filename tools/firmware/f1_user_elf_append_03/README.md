# Finite linker 03

Raises only the input object-count limit from 64 to 96 to link independent native UI additions. The representation uses Python lists/dicts and tuple object indices, not a 64-bit bitmap. Original per-object 16 MiB and total appended 32 MiB limits, ELF format limits, import restrictions, relocation bounds, no RWX, and finite original patch checks remain unchanged. Existing linker02 is frozen. This is a host linker limit, not a claim about camera capacity.
