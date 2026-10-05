# Actual fresh source reproduction 01

The final source ZIP was extracted into a new project tree. All 107 source/provenance member hashes and 722 exact compiler/header hashes were verified. The eleven recorded compiler invocations produced actual AArch64 ET_REL objects with exit code 0. No target object, User, SDK or firmware was executed.

A fresh input lock used the real rebuilt object hashes and copied exact original User/libstdc++ local inputs. The unchanged ELF backend linked User 6.03.22, and wrapper02 read the original FWR/FWP by explicit absolute paths to emit release 6.03.19/system 8.02.1. Whole User, FWR and FWP bytes were directly compared with the final candidates and are identical. Different DWARF-root object hashes were recorded honestly rather than translated to old receipts.

Source ZIP: 527,256 bytes, SHA-256 `96070f83c198d311b7080355999c4e72a7dc745ee6c83eaa03bc62b97a71746e`. User SHA-256 `aa9c594ac60f594ed7e14b8cc5d765c356d759b72001f1c4ec5469087aa8d115`; FWR `1f0105c37b80d6970288788999f07d876c6f22e0a5aa26722ebb85d643edb49d`; FWP `7e7503101db6c046b29b15cc131f494d33b890dffff98c73bb2e374112d06658`.

This verifies source/build/package reproducibility on the local Mac. Camera acceptance, UI behavior and recovery remain unverified. Original full historical materialize/freeze validators are explicitly not a source-ZIP-only claim; the bundle manifest names their omitted references.
