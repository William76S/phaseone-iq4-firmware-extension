#!/usr/bin/env python3
"""Decode only exact copies of this own publication; no process/device reads."""
import importlib.util
import struct
from pathlib import Path

SIZE=1192
USER_SHA256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
RESULT=('not_attempted','collected_shape_candidate','unsupported_shape_or_request','owner_rejected','read_failed','changing','invalid')
SHAPE=('unsupported','sole_lv','home_class_candidate_then_lv','lv_then_popup','home_class_candidate_then_lv_then_popup')
RELATION=('none','fresh_entry_dispatch','prior_entry_owner_anchor')
KIND=('unknown','original_lv','captured_home_class_candidate','original_popup')
def _load(folder):
    s=importlib.util.spec_from_file_location(folder,Path(__file__).resolve().parents[1]/folder/'decode_observation.py')
    m=importlib.util.module_from_spec(s);s.loader.exec_module(m);return m
_entry=_load('f1_module_entry_01')
_geometry=_load('f1_observe_geometry_04')
def _ptr(v):return 4096<=v<=2**64-1-0x5000 and not v&7
def _shape(nodes):
    if any(n['request_pending']for n in nodes):return 0
    return {(1,):1,(2,1):2,(1,3):3,(2,1,3):4}.get(tuple(n['kind_id']for n in nodes),0)

def decode_samples(first:bytes,second:bytes,entry_first:bytes|None=None,entry_second:bytes|None=None,
                   geometry_first:bytes|None=None,geometry_second:bytes|None=None)->dict:
    if type(first)is not bytes or type(second)is not bytes or len(first)!=SIZE or first!=second:
        raise ValueError('two identical bounded Stack05 publications required')
    outer,span,version,reserved=struct.unpack_from('<4I',first)
    schema,inner_span,result,present=struct.unpack_from('<4I',first,16)
    attempts,epoch,source_epoch,prior_epoch,accepted,rejected=struct.unpack_from('<6Q',first,32)
    sha=first[80:112].hex();user_bytes=struct.unpack_from('<Q',first,112)[0]
    startup,relation,shape,projection,prior_sequence,current_called,paint_called,full_source,fresh,surface,scene,meta_reserved=struct.unpack_from('<12I',first,120)
    observer,tail,selected=struct.unpack_from('<3Q',first,168)
    source_raw=first[192:616]
    if outer&1 or outer!=attempts*2 or span!=SIZE or version!=5 or reserved or schema!=5 or inner_span!=1176 or result>=len(RESULT) or present not in (0,1):
        raise ValueError('unknown/torn Stack05 header')
    if attempts>64 or accepted+rejected!=attempts or epoch>attempts or accepted>epoch or sha!=USER_SHA256 or user_bytes!=11874544 or any((current_called,paint_called,full_source,fresh,surface,scene,meta_reserved)):
        raise ValueError('not this fixed scalar-only bounded revision')
    source_view=struct.pack('<4I',0,440,startup,0)+source_raw
    source=_entry.decode_samples(source_view,source_view)
    sequence=struct.unpack_from('<I',source_raw,8)[0]
    if attempts:
        if result==0 or startup!=4 or source['phase']not in ('owner_observed','lv_not_current') or source['dispatch_epoch']!=source_epoch or sequence!=source_epoch*2 or relation not in (1,2):
            raise ValueError('invalid actual Entry anchor/source relation')
        if relation==1 and (source_epoch!=prior_epoch+1 or sequence!=prior_sequence+2):
            raise ValueError('fresh relation does not advance actual Entry epoch')
        if relation==2 and (source_epoch!=prior_epoch or sequence!=prior_sequence):
            raise ValueError('prior anchor was relabelled as fresh')
    elif result or present or any((epoch,source_epoch,prior_epoch,accepted,rejected,startup,relation,shape,projection,prior_sequence,observer,tail,selected)) or source['phase']!='disabled':
        raise ValueError('invalid default OFF publication')
    paired=False
    if entry_first is not None or entry_second is not None:
        if entry_first is None or entry_second is None:raise ValueError('both original Entry samples required')
        _entry.decode_samples(entry_first,entry_second)
        if entry_first[16:]!=source_raw or struct.unpack_from('<I',entry_first,8)[0]!=startup:raise ValueError('Entry publication/source mismatch')
        paired=True
    geometry=None
    if geometry_first is not None or geometry_second is not None:
        if geometry_first is None or geometry_second is None:raise ValueError('both unchanged Geometry04 samples required')
        geometry=_geometry.decode_samples(geometry_first,geometry_second)
        if geometry_first[160:584]!=source_raw:raise ValueError('Geometry04 publication/source mismatch')
    if (result in (1,2))!=bool(present):raise ValueError('graph/result mismatch')
    nodes=[];facts=None
    if not present:
        if any((shape,projection,observer,tail,selected))or any(first[616:]):raise ValueError('failed/default capture contains stale graph facts')
    else:
        if not epoch or projection!=1 or not _ptr(observer) or not _ptr(tail) or selected!=tail or shape>=len(SHAPE):raise ValueError('invalid tail projection')
        pf,pl,nf,nl,override,aux,active,count,complete,priority_empty=struct.unpack_from('<6Q4I',first,616)
        objects=source['objects'];m=objects['manager'];head=m+0x78;prior=head
        if override or aux or active or not 1<=count<=8 or complete!=1 or priority_empty!=1 or pf!=m+0x50 or pl!=m+0x50:
            raise ValueError('normal projection with higher-priority/unknown state')
        for i in range(8):
            values=struct.unpack_from('<7Q2I',first,680+64*i)
            if i>=count:
                if any(values):raise ValueError('unbounded graph suffix')
                continue
            node,dialog,nvt,pvt,next_,previous,manager,request,kind=values
            if any(not _ptr(v)for v in (node,dialog,nvt,pvt,next_,previous,manager))or node!=dialog+0x88 or manager!=m or previous!=prior or request not in (0,1)or kind>=len(KIND)or any(n['node']==node for n in nodes):
                raise ValueError('invalid reciprocal owner/list/node candidate')
            if i and nodes[-1]['next']!=node:raise ValueError('broken forward link')
            expected=0
            if dialog==objects['lv']:
                if (pvt,nvt)!=(0xb9a9d8,0xb9abf8):raise ValueError('wrong original LV table')
                expected=1
            elif dialog==objects['stock_popup']:
                if (pvt,nvt)!=(0xb931b0,0xb933e0):raise ValueError('wrong original popup table')
                expected=3
            elif (pvt,nvt)==(0xb94fe8,0xb95200):expected=2
            if kind!=expected:raise ValueError('class candidate not bound to both tables/owner')
            nodes.append({'node':node,'dialog':dialog,'node_vtable':nvt,'primary_vtable':pvt,'next':next_,'previous':previous,'manager':manager,'request_pending':bool(request),'kind_id':kind,'kind_candidate':KIND[kind]});prior=node
        if nf!=nodes[0]['node']or nl!=prior or nodes[-1]['next']!=head or tail!=nodes[-1]['dialog']or shape!=_shape(nodes)or (result==1)!=(shape!=0):
            raise ValueError('shape/tail/sentinel mismatch')
        if relation==1:
            old=source['original_stack_candidate']
            if observer!=objects['popped_observer']or [n['node']for n in nodes]!=list(old['normal_nodes'])or [n['dialog']for n in nodes]!=list(old['normal_dialogs'])or [n['node_vtable']for n in nodes]!=list(old['normal_node_vtables'])or nf!=old['normal_first']or nl!=old['normal_last']:
                raise ValueError('fresh Entry graph disagrees with actual boundary graph')
        facts={'priority_empty':True,'bounded_complete_graph':True,'normal_first':nf,'normal_last':nl,'normal_count':count,'nodes':nodes}
    return {'schema':'iq4_f1_stack_observation_05','outer_sequence':outer,'attempts':attempts,'snapshot_epoch':epoch,'source_dispatch_epoch':source_epoch,
      'prior_source_dispatch_epoch':prior_epoch,'accepted_shapes':accepted,'rejected_or_unsupported':rejected,'result':RESULT[result],
      'source_relation':RELATION[relation],'shape_candidate':SHAPE[shape],'normal_tail_dialog':tail,'selected_dialog_branch_projection':selected,
      'actual_boundary_popped_observer':observer,'exact_user_source_binding':{'sha256':sha,'bytes':user_bytes},'embedded_entry_source':source,'stack_facts':facts,
      'paired_unchanged_entry_publication':paired,'paired_unchanged_geometry04_result':None if geometry is None else geometry['result'],
      'native_current_called':False,'actual_home_scene_verified':False,'paint_called':False,'full_source_mapping_verified':False,
      'fresh_blit_verified':False,'surface_lease_verified':False,'mask_enabled':False,'hardware_verified':False,'is_source_frame_counter':False,
      'two_equal_samples_are_not_lifetime_or_quiescence_proof':True}
