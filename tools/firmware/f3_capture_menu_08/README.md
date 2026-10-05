# JPEG quality UI 08

Changes the shared default and reset quality to 100. Adds an inert Current JPEG quality row inside the quality submenu; values follow the same atomic snapshot used by both cards and manual export. Existing format/backend gates are preserved.

Build: `python3 tools/firmware/f3_capture_menu_08/build.py --output analysis/firmware/f3_capture_menu_build_08_next`. 37 menu cases per normal/sanitized build plus 59 policy groups per build pass. No camera execution or delivery of a firmware candidate. Native Storage Setup size unification follows in menu09.
