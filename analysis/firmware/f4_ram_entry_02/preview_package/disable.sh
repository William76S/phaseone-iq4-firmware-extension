#!/bin/sh
set -eu
# Default is preflight. Never stops/signals User.
ENABLED=0
case "${1:---preflight}" in
  --preflight) exec /run/iq4_f4_entry02/entrytool --preflight ;;
  --disable) [ "$ENABLED" -eq 1 ] || { echo preview-only; exit 2; }; exec /run/iq4_f4_entry02/entrytool --disable ;;
  *) echo unsupported-mode; exit 2 ;;
esac
