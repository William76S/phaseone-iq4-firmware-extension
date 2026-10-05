This is a finite scratch-inode recovery probe, default OFF. It never opens,
changes, signals or restarts the runner/User, nor reads EEPROM or calls SDK.
There is no stager, transport profile or camera launch authorization here.

Future actual execution must follow accepted Baseline03 and readfacts results,
prove actual RAM parent/mount identity and a sole no-foreign-mutation lease,
and stage the exact target ELF with its own reversible cleanup route. Production
accepts only Linux root and the fixed parent /p1/scripts, pinned by actual
major/minor/inode arguments; a 12-digit hexadecimal token names a fresh owned
scratch directory. No argv is taken as a pathname. Host builds use an explicit
test macro and a temporary fixture parent; those cannot be used as camera proof.

The probe creates two small known scratch files, file-fsyncs them, hardlinks the
original, atomically renames the candidate, directory-fsyncs, and restores the
original scratch inode through link/rename. Exact bytes, mode, inode, device,
owner and link counts are read back. Successful cleanup removes only this
directory's verified own names, directory-fsyncs and checks ENOENT. Any failure
retains partial scratch state for held-owner review and reports the failed phase.
It never guesses cleanup, replaces a foreign path or retries a rejected launch.
Compare-then-unlink is not atomic against a foreign root actor. Successful scratch
restoration does not prove runner restoration, process recovery, power-loss
durability, cold boot, UI rendering or installation; those remain actual gates.

Run SDK-free host fixtures and cross compilation once with:

    python3 -B tools/firmware/f1_scratch_restore_probe_01/validate_host.py

The target AArch64 ELF is inspected only. Nothing is executed on the camera.
