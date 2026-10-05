# Explicit release date wrapper 03

Uses the exact frozen stock wrapper 02 and original licensed stock FWP/FWR.
Changes the inner `release_date` and outer `date` to a caller-supplied ISO date,
while preserving model/hardware selectors and the LinuxApp-only package.
Does not change the camera clock or the original RTC fallback build timestamp.

The firmware information Date row is sourced separately from the LinuxApp
compiler timestamp. The native UI getter and firmware date fields are recorded
in `analysis/firmware/firmware_release_date_review_01`.

Always pass `--release-date YYYY-MM-DD`. Reproduction passes the recorded date,
never the wall clock, so the complete FWR/FWP remain deterministic.
Static packaging checks do not establish on-camera acceptance or recovery.
