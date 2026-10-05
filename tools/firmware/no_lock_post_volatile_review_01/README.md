# Offline review only

`verify.py` reads the exact package User, frozen security source manifests and selected byte windows. It never imports or runs an SDK, accesses a device/private original, sends a command, writes an EEPROM image, or executes target firmware. The command constraints are source references, not an outgoing plan or a new device tool.

Run from the project root with a fresh output path:

```sh
python3 -B tools/firmware/no_lock_post_volatile_review_01/verify.py --output analysis/firmware/no_lock_post_volatile_review_01/LOCAL_REVIEW.json
```

Existing output is refused. The review distinguishes native UI U8 setter from OsEvent text decoder+notify and preserves the cold NoLock counterexample. It does not establish actual current User/unique event ownership, EEPROM originals, restoration, or persistent recovery.
