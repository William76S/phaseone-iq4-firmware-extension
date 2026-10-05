#!/usr/bin/env python3
from pathlib import Path
import struct,sys,json
from decode_observation import decode,LAYOUT
def main():
    b=Path(sys.argv[1]).read_bytes();result=decode(b,b);assert result['publication']['metadata']['paint_present']==1
    count=1
    def bad(raw,other=None):
        nonlocal count
        try:decode(bytes(raw),bytes(raw)if other is None else other)
        except (AssertionError,ValueError):count+=1;return
        raise AssertionError('malformed observation accepted')
    bad(b[:-1]);bad(b+b'\0');x=bytearray(b);x[0]^=1;bad(x);bad(b,bytes(x))
    for key in ('mask_enabled','full_source_mapping_verified','fresh_blit_verified','surface_lease_verified','native_provider_getter_called','native_fill_called','native_ui_mutation_called','owner_present','source_anchor_startup','source_dispatch_epoch','exact_user_bytes'):
        x=bytearray(b);f=LAYOUT['Metadata']['fields'][key];value=2 if key=='owner_present'else 0 if key in ('source_anchor_startup','source_dispatch_epoch','exact_user_bytes')else 1
        struct.pack_into('<I'if f['bytes']==4 else'<Q',x,16+f['offset'],value);bad(x)
    for key,value in [('paint_attempts',65),('paint_call_serial',65),('source_stack_epoch',65),('bytes',0),('schema',5)]:
        x=bytearray(b);f=LAYOUT['Metadata']['fields'][key];struct.pack_into('<I'if f['bytes']==4 else'<Q',x,16+f['offset'],value);bad(x)
    print(json.dumps({'checks':count,'passed':True,'native_target_execution':False}))
if __name__=='__main__':main()
