#!/usr/bin/env python3
"""Reverse only intended predicate/format/include changes and require exact59 source."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[2]
base=HERE.parent/'half_request_owner_59/runtime.cpp';current=HERE/'runtime.cpp'
s=current.read_text().replace('#include "../half_request_owner_59/owner.h"\n#include "../half_request_owner_59/request_pins.h"\n#include "stages.h"','#include "owner.h"\n#include "request_pins.h"')
replacements=[('!iq4_half_stage_counts_valid_60(render->stages,render->joins)','render->stages!=3||render->joins!=3'),('iq4_half_stage_counts_valid_60(render->stages,render->joins)','render->stages==3&&render->joins==3'),('!iq4_half_stage_counts_valid_60(render.stages,render.joins)','render.stages!=3||render.joins!=3')]
# Replace the negative predicate first so the positive substring cannot match it.
for a,b in replacements:
 assert s.count(a)==1,(a,s.count(a));s=s.replace(a,b)
assert s.count('render->format!=2')==1 and s.count('render.format!=2')==1
s=s.replace('render->format!=2','render->format!=5').replace('render.format!=2','render.format!=5')
assert s.encode()==base.read_bytes()
print(json.dumps(dict(exact59_source_after_reversing_three_predicates_two_format_guards_and_include_relocation=True,base_sha256=hashlib.sha256(base.read_bytes()).hexdigest(),new_sha256=hashlib.sha256(current.read_bytes()).hexdigest())))
