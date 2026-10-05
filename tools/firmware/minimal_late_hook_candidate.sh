#!/bin/sh
# UNINSTALLED STATIC CANDIDATE. Do not place on the IQ4 until original backups,
# live target hashes, internal storage access, and an independently tested
# disable/recovery route are established by the sole camera executor.
# The stock hook is /run/media/storage/late-autostart.sh (usually internal QSPI).
# This probe writes only volatile /run files, does not start services or modify
# factory applications, boot selection, calibration, keys, or persistent config.
set -eu
# A host test may provide its own writable run directory; real IQ4 uses /run.
probe_root=${IQ4_EXT_PROBE_RUN:-/run}
probe_dir="$probe_root/iq4-extension-probe"
[ -d "$probe_root" ] || exit 0
umask 077
mkdir -p "$probe_dir" || exit 0
probe_file="$probe_dir/baseline.$$.txt"
{
    printf 'iq4-extension-probe-v1\n'
    printf 'evidence_level=temporary_device_probe_if_executed_on_camera\n'
    printf 'architecture='; uname -m
    printf 'monotonic_uptime='; cat /proc/uptime
    printf 'kernel='; uname -r
    printf 'boot_cmdline='; cat /proc/cmdline
    printf 'internal_storage_target='; readlink /run/media/storage || :
    printf 'memory_summary\n'
    sed -n '/^MemTotal:/p;/^MemAvailable:/p;/^HugePages_Total:/p;/^HugePages_Free:/p' /proc/meminfo
} > "$probe_file" 2>&1 || :
exit 0
