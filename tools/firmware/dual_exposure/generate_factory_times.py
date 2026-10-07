#!/usr/bin/env python3
"""Reproduce host range fixture by executing exact stock A64 shutter-seconds.
No camera access. Emits only the requested local fixture header.
"""
from pathlib import Path
import sys, struct
ROOT=Path(__file__).resolve().parents[3]
sys.path.insert(0,str(ROOT/'tools/firmware/dual_exposure_02'))
from emulate_native import Native
from unicorn.arm64_const import UC_ARM64_REG_S0
out=Path(sys.argv[1]).resolve()
assert out.is_relative_to(ROOT)
n=Native(); rows=[]
for tick in range(167):
    n.run(0x71b538,w=tick)
    value=struct.unpack('<f',struct.pack('<I',n.u.reg_read(UC_ARM64_REG_S0)))[0]
    rows.append(repr(value)+'f')
out.write_text('/* Offline fixture: actual stock 71b538 outputs for ticks 0..166.\n * P1Linux6.03.21 SHA256 9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb.\n * Native A64 execution is validated separately; these are host range inputs. */\nstatic const float factory_seconds[167] = {\n'+',\n'.join('    '+', '.join(rows[i:i+5]) for i in range(0,len(rows),5))+'\n};\n')
