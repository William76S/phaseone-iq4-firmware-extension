#!/usr/bin/env python3
"""A unique output per CTest run; calls no device or original native code."""
import subprocess
import sys
import uuid
from pathlib import Path

root = Path(__file__).resolve().parents[2]
output = root / 'evidence/f3_native_render_02' / ('ctest-' + uuid.uuid4().hex)
raise SystemExit(subprocess.call([
    sys.executable, str(Path(__file__).with_name('verify.py')),
    '--output', str(output)], cwd=root))
