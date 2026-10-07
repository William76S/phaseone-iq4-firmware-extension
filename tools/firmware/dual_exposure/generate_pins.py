#!/usr/bin/env python3
"""Pin exact stock native code; omit only the seven admitted hook instructions."""
from pathlib import Path
import hashlib, importlib.util, sys, json
ROOT = Path(__file__).resolve().parents[3]
DEST = ROOT / 'src/display/dual_exposure_pins.h'
spec = importlib.util.spec_from_file_location('dual_pin_elf', ROOT/'tools/firmware/f1_user_elf_append_02/elf_append.py')
mod = importlib.util.module_from_spec(spec); sys.modules[spec.name] = mod; spec.loader.exec_module(mod)
path = ROOT/'analysis/firmware/extracted/P1Linux_6.03.21.bin'
raw = path.read_bytes()
assert hashlib.sha256(raw).hexdigest() == mod.BASE_SHA
elf = mod.Elf(raw,2)
ranges = [
 (0x5363c0,0x536eb4),(0x536eb8,0x536ed4),(0x536ed8,0x537e68),
 (0x537e6c,0x538540),(0x538544,0x53865c),(0x538660,0x5387a0),
 (0x5387a4,0x538810),(0x538814,0x538854),
 (0x4ad230,0x4ad428),(0x4d024c,0x4d0288),(0x4d1ad0,0x4d27bc),
 (0x4ab8fc,0x4ab940),(0x4ac06c,0x4ac144),(0x4acffc,0x4ad02c),
 (0x457cf0,0x457d54),(0x4ab898,0x4ab8fc),(0x4ab984,0x4abc9c),
 (0x4d1550,0x4d1678),(0xb8bb30,0xb8bcd0),(0x70c6c8,0x70c784),
 (0xb846e0,0xb84840),(0xb8bcd0,0xb8bef8),(0xba25f8,0xba28c0),
 (0x44136c,0x4413ec),(0x432314,0x43234c),(0x40c880,0x40c920),
 (0x4e1a2c,0x4e1a44),(0x9f8508,0x9f85b0),(0x5c3454,0x5c3504),
 (0x71b538,0x71ba70),(0xc264d8,0xc27194),(0xc27dd0,0xc27dd8)
]
out = ['#ifndef IQ4_DUAL_PINS_03_H','#define IQ4_DUAL_PINS_03_H',
 '#include <stdint.h>','#include <stddef.h>',
 'struct DualPin03 { uintptr_t va; size_t bytes; const unsigned char *data; };']
rows=[]
for i,(a,z) in enumerate(ranges):
 offset=elf.va_offset(a,z-a); data=raw[offset:offset+z-a]
 out.append('static const unsigned char dual_pin_03_%d[]={%s};'%(i,','.join('0x%02x'%v for v in data)))
 rows.append(dict(va=a,bytes=len(data),file_offset=offset,sha256=hashlib.sha256(data).hexdigest()))
out.append('static const DualPin03 dual_pins_03[]={'+','.join('{0x%x,%d,dual_pin_03_%d}'%(a,z-a,i) for i,(a,z) in enumerate(ranges))+'};')
out.append('#endif')
DEST.write_text('\n'.join(out)+'\n')
(Path(__file__).parent/'PINS.json').write_text(json.dumps({'stock':{'path':str(path.relative_to(ROOT)),'sha256':mod.BASE_SHA},'ranges':rows},indent=2)+'\n')
