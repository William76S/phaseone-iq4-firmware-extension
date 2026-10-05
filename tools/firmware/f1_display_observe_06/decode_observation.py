#!/usr/bin/env python3
"""Decode two exact copied publications; never opens a process or target library."""
from pathlib import Path
import json,math,struct,sys
HERE=Path(__file__).resolve().parent
LAYOUT=json.loads((HERE/'PUBLICATION_LAYOUT.json').read_text())
SHA='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
SIGNED={'x','y','width','height','pan_x','pan_y','rotation','client_id','access_owner','config_width','config_height','slot_width','slot_height','provider_offset_to_top'}
NESTED={'Published':{'metadata':'Metadata'},'Metadata':{'owner_before':'OwnerFacts','owner_after':'OwnerFacts','geometry_before':'GeometryFacts','geometry_after':'GeometryFacts','paint':'PaintFacts'},'OwnerFacts':{'owner':'Owner'},'GeometryFacts':{'scalars':'WireGeometry'}}
RECTS={'local_control','recursive_bounds_candidate','locked_roi','input_draw','input_clip','display_bounds','original_return','post_draw','post_clip','post_display_bounds'}
def unpack(raw,kind,base=0):
    result={}
    for name,spec in LAYOUT[kind]['fields'].items():
        at=base+spec['offset'];n=spec['bytes']
        if name in NESTED.get(kind,{}):value=unpack(raw,NESTED[kind][name],at)
        elif name in RECTS:value=unpack(raw,'Rectangle24',at)
        elif name=='config_point_candidates':value=[unpack(raw,'geometry03::Point8',at+8*i)for i in range(4)]
        elif name in {'exact_user_sha256','getter_first16','present_first16'}:value=raw[at:at+n].hex()
        elif name in {'scale','normal_fit_scale'}:value=struct.unpack_from('<f',raw,at)[0]
        else:
            assert n in (4,8),(kind,name,n)
            value=struct.unpack_from('<'+({4:'i',8:'q'}if name in SIGNED else{4:'I',8:'Q'})[n],raw,at)[0]
        result[name]=value
    return result
def decode(first:bytes,second:bytes):
    assert len(first)==len(second)==LAYOUT['Published']['bytes'],'exact publication length'
    assert first==second,'publication changed between copies'
    p=unpack(first,'Published');m=p['metadata']
    assert p['sequence']%2==0 and p['schema']==6 and p['bytes']==len(first) and p['reserved']==0,'publication header'
    assert m['schema']==6 and m['bytes']==LAYOUT['Metadata']['bytes'] and m['exact_user_sha256']==SHA and m['exact_user_bytes']==11874544,'bound static User identity'
    for key in ('mask_enabled','full_source_mapping_verified','fresh_blit_verified','surface_lease_verified','native_provider_getter_called','native_fill_called','native_ui_mutation_called','reserved'):
        assert m[key]==0,key+' must remain unavailable/zero'
    for key in ('owner_present','geometry_present','paint_present','shadow_table_ready'):
        assert m[key]in(0,1),key
    assert 0<=m['result']<=8 and 0<=m['kind']<=2,'finite enums'
    assert m['boundary_attempts']<=64 and m['paint_attempts']<=64 and m['paint_call_serial']<=64 and m['publication_epoch']<=128,'finite sampling counters'
    assert m['source_dispatch_epoch']<=64 and m['source_stack_epoch']<=64 and m['source_anchor_startup']in(0,4) and m['source_anchor_relation']in(0,1,2),'anchor metadata'
    for side in ('owner_before','owner_after'):
        o=m[side]
        for key in ('provider_header_present','getter_prefix_present','present_prefix_present','getter_in_original_user_executable_load','provider_alias_equal','resource_alias_equal','shadow_instance'):
            assert o[key]in(0,1),side+'.'+key
        for prefix in ('getter','present'):
            if not o[prefix+'_prefix_present']:assert o[prefix+'_first16']=='00'*16,'missing prefix carried stale bytes'
    if m['result']==1 and m['kind']in(1,2):
        assert m['owner_present']==m['geometry_present']==1 and m['source_anchor_startup']==4 and m['source_dispatch_epoch']>0 and m['source_stack_epoch']>0,'actual accepted source anchor'
        g=m['geometry_before']['scalars'];assert math.isfinite(g['scale'])and g['scale']>0 and math.isfinite(g['normal_fit_scale'])and g['normal_fit_scale']>0 and g['locked_slot']<=4,'finite geometry'
    for key in ('original_returned_normally','geometry_equal_before_after','surface_metadata_equal'):
        assert m['paint'][key]in(0,1),'paint.'+key
    assert m['paint']['reserved']==0
    if m['paint_present']:
        r=m['paint'];assert m['kind']==2 and m['result']==1 and r['original_returned_normally']==1,'normal paint receipt'
        assert r['caller_pc']==0x4abe94 and r['lv']==m['owner_before']['owner']['lv']==m['owner_after']['owner']['lv'],'same observed LV/caller'
        assert r['surface']and r['control_frame']and r['manager_frame']and r['draw_owner']and r['draw_vtable']==0xb7b7d8,'actual scope metadata'
        assert r['draw_arg']==r['control_frame']+0xb8 and r['clip_arg']==r['control_frame']+0xd0,'actual argument addresses'
    return {'scope':'copied scalar observation only','actual_process_or_mapping_identity_checked_here':False,'production_mask_enabled':False,'full_source_mapping_verified':False,'fresh_blit_verified':False,'surface_lease_verified':False,'publication':p}
def main():
    assert len(sys.argv)==3,'two actual copied publication files required'
    print(json.dumps(decode(Path(sys.argv[1]).read_bytes(),Path(sys.argv[2]).read_bytes()),ensure_ascii=False,indent=2,allow_nan=False))
if __name__=='__main__':main()
