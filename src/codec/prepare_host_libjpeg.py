#!/usr/bin/env python3
"""Prepare one pinned official library locally; no global install or camera IO."""
import argparse
import hashlib
import json
import os
import pathlib
import subprocess
import tarfile
import urllib.request

parser = argparse.ArgumentParser()
parser.add_argument("--sanitize", action="store_true")
args = parser.parse_args()
root = pathlib.Path(__file__).resolve().parents[2]
base = root / "evidence/codec"
downloads = base / "downloads"
downloads.mkdir(parents=True, exist_ok=True)
package = downloads / "libjpeg-turbo-1.5.3.tar.gz"
url = "https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/1.5.3/libjpeg-turbo-1.5.3.tar.gz"
expected = "b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523"
if not package.exists():
    temporary = package.with_suffix(".download")
    with urllib.request.urlopen(url) as response, temporary.open("wb") as output:
        while chunk := response.read(1024 * 1024):
            output.write(chunk)
    temporary.replace(package)
if hashlib.sha256(package.read_bytes()).hexdigest() != expected:
    raise SystemExit("Pinned upstream package hash mismatch; build refused")
source = downloads / "libjpeg-turbo-1.5.3"
if not source.exists():
    with tarfile.open(package) as archive:
        for member in archive.getmembers():
            # Official package has no required links; do not permit escaping entries.
            if member.issym() or member.islnk() or not (downloads / member.name).resolve().is_relative_to(downloads.resolve()):
                raise SystemExit("Unsafe archive entry refused")
        archive.extractall(downloads)
build = base / "build" / ("libjpeg8_sanitized" if args.sanitize else "libjpeg8")
build.mkdir(parents=True, exist_ok=True)
environment = os.environ.copy()
environment["CC"] = "clang"
flags = "-O1 -g -fsanitize=address,undefined -fno-omit-frame-pointer" if args.sanitize else "-O2"
environment["CFLAGS"] = flags
environment["LDFLAGS"] = "-fsanitize=address,undefined" if args.sanitize else ""
configure = [str(source / "configure"), "--without-simd", "--with-jpeg8", "--disable-shared", "--without-turbojpeg", "--prefix=" + str(build / "unused-local-install")]
with (build / "configure.log").open("w") as log:
    subprocess.run(configure, cwd=build, env=environment, stdout=log, stderr=subprocess.STDOUT, check=True)
with (build / "make.log").open("w") as log:
    subprocess.run(["make", "-j4"], cwd=build, env=environment, stdout=log, stderr=subprocess.STDOUT, check=True)
library = build / ".libs/libjpeg.a"
record = {"upstream_release": "1.5.3", "package_url": url, "package_sha256": expected, "host_api": 80,
          "simd": False, "sanitized_all_library_c_sources": args.sanitize, "configure_command": configure,
          "cflags": flags, "library_path": str(library), "library_sha256": hashlib.sha256(library.read_bytes()).hexdigest(),
          "global_install": False, "camera_actions": 0}
(build / "provenance.json").write_text(json.dumps(record, indent=2) + "\n")
print(json.dumps(record))
