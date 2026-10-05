#!/usr/bin/env python3
"""Decode bounded copies of OWN Geo04 data; never read a device/process."""
import importlib.util
import math
import struct
from pathlib import Path

SIZE=760
USER_SHA256='9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb'
USER_BYTES=11874544
RESULT=('ok_scalar_candidate','owner_rejected','read_failed','changing','invalid','unsupported_parent','no_source_lease','no_paint_scope','not_attempted','source_rejected')
_spec=importlib.util.spec_from_file_location('frozen_entry01_decoder',Path(__file__).resolve().parents[1]/'f1_module_entry_01/decode_observation.py')
_entry=importlib.util.module_from_spec(_spec);_spec.loader.exec_module(_entry)

def _rect(b,at):
    vt,x,y,w,h=struct.unpack_from('<Q4i',b,at)
    return {'vtable':vt,'x':x,'y':y,'width':w,'height':h}

def _positive(r):
    return r['vtable']==0xb73b98 and r['width']>0 and r['height']>0 and r['x']+r['width']<=2147483647 and r['y']+r['height']<=2147483647

def decode_samples(first:bytes,second:bytes,entry_first:bytes|None=None,entry_second:bytes|None=None)->dict:
    if type(first)is not bytes or type(second)is not bytes or len(first)!=SIZE or first!=second:
        raise ValueError('two bounded identical own Geo04 publications required')
    outer,span,version,reserved=struct.unpack_from('<4I',first)
    schema,inner_span,result,present=struct.unpack_from('<4I',first,16)
    attempts,geometry_epoch,source_epoch,successes,rejected=struct.unpack_from('<5Q',first,32)
    user=first[72:104].hex();user_size,access,engine,buffer=struct.unpack_from('<4Q',first,104)
    startup,paint_called,full_source,fresh,surface,meta_reserved=struct.unpack_from('<6I',first,136)
    if outer&1 or outer!=attempts*2 or span!=SIZE or version!=4 or reserved or schema!=4 or inner_span!=744 or result not in (0,1,2,3,4,8,9) or present not in (0,1):
        raise ValueError('unknown/torn/nonfinite own publication')
    if attempts>64 or geometry_epoch!=successes or successes+rejected!=attempts or source_epoch!=attempts or user!=USER_SHA256 or user_size!=USER_BYTES or paint_called or full_source or fresh or surface or meta_reserved:
        raise ValueError('not this fixed source/epoch/scalar-only revision')
    source_raw=first[160:584]
    # Decode unchanged embedded metadata using the exact frozen Entry01 schema;
    # this constructed decoder header is not an observed old publication.
    source_view=struct.pack('<4I',0,440,startup,0)+source_raw
    source=_entry.decode_samples(source_view,source_view)
    if attempts:
        if startup!=4 or result==8 or source['dispatch_epoch']!=source_epoch or source['phase'] not in ('owner_observed','lv_not_current'):
            raise ValueError('source epoch/startup mismatch')
    elif result!=8 or present or startup or successes or rejected or source['dispatch_epoch'] or source['phase']!='disabled':
        raise ValueError('unknown default-off state')
    paired=False
    if entry_first is not None or entry_second is not None:
        if entry_first is None or entry_second is None:
            raise ValueError('both old publication copies required')
        _entry.decode_samples(entry_first,entry_second)
        if entry_first[16:]!=source_raw or struct.unpack_from('<I',entry_first,8)[0]!=startup:
            raise ValueError('old/new publications are different dispatch observations')
        paired=True
    if (result==0)!=bool(present):
        raise ValueError('result/presence mismatch')
    scalar=None
    if not present:
        if access or engine or buffer or any(first[584:]):
            raise ValueError('failure/default must not publish stale context or scalars')
    else:
        if not successes or source['phase']!='owner_observed' or any(v<4096 or v&7 or v>2**64-1-0x476c for v in (access,engine,buffer)) or buffer!=engine+0x2170:
            raise ValueError('unknown context candidate')
        local=_rect(first,584);recursive=_rect(first,608);roi=_rect(first,632)
        pan_x,pan_y,scale,fit=struct.unpack_from('<2i2f',first,656)
        rotation,client,access_owner,cw,ch,sw,sh=struct.unpack_from('<7i',first,672)
        countdown,completion,slot,depth,align=struct.unpack_from('<5I',first,700)
        flags=struct.unpack_from('<10I',first,720)
        running,visible,animation,borrowed,retain,locked,recursive_present,would_write,consistent,reserved_flag=flags
        if any(v not in (0,1)for v in flags[:9]) or consistent!=1 or reserved_flag or not _positive(local) or not math.isfinite(scale) or scale<=0 or not math.isfinite(fit) or fit<=0 or rotation not in (0,90,180,270) or client not in range(5) or access_owner not in range(-1,5) or not 0<cw<=1048576 or not 0<ch<=1048576 or slot>4 or depth>16:
            raise ValueError('invalid geometry scalar candidate')
        if locked!=int(slot<4) or (locked and (not 0<sw<=1048576 or not 0<sh<=1048576 or not _positive(roi))) or (not locked and (sw or sh or completion or any(first[632:656]))):
            raise ValueError('invalid locked-slot candidate')
        if recursive_present and (not depth or not _positive(recursive)):
            raise ValueError('invalid recursive candidate')
        old=source['local_control_bounds_candidate']
        if local!=old or [pan_x,pan_y]!=source['pan_cached_candidate'] or rotation!=source['quarterturn_candidate'] or scale!=source['scale_candidate'] or countdown!=source['countdown_candidate'] or running!=source['running_candidate'] or visible!=source['visible_candidate']:
            raise ValueError('embedded source disagrees with this geometry epoch')
        scalar={'local_control_candidate':local,'recursive_bounds_candidate':recursive,'locked_roi_candidate':roi,
          'cached_pan_candidate':[pan_x,pan_y],'scale_candidate':scale,'normal_fit_scale_candidate':fit,'rotation_candidate':rotation,
          'client_id_candidate':client,'access_owner_candidate':access_owner,'engine_config_dimensions_candidate':[cw,ch],
          'locked_slot_dimensions_candidate':[sw,sh],'locked_slot_candidate':slot,'software_completion_id_candidate':completion,
          'countdown_candidate':countdown,'parent_depth':depth,'alignment_flags_candidate':align,
          'running_candidate':bool(running),'visible_candidate':bool(visible),'pan_animation_candidate':bool(animation),
          'borrowed_pointer_present_only':bool(borrowed),'retain_borrowed_candidate':bool(retain),'locked_metadata_present':bool(locked),
          'recursive_bounds_candidate_present':bool(recursive_present),'original_parent_transform_would_update_local_size':bool(would_write),
          'consistent_double_scalar_read':True}
    return {'schema':'iq4_f1_observe_geometry_04','outer_sequence':outer,'attempts':attempts,'geometry_epoch':geometry_epoch,
      'source_dispatch_epoch':source_epoch,'successes':successes,'rejected':rejected,'result':RESULT[result],
      'exact_user_source_binding':{'bytes':user_size,'sha256':user},'embedded_source_metadata':source,
      'context_candidates':{'access':access,'engine':engine,'buffer_metadata_object':buffer},'scalars':scalar,
      'old_new_exact_observation_pair_verified':paired,'paint_scope_called':False,'full_source_mapping_verified':False,
      'fresh_blit_verified':False,'surface_lease_verified':False,'hardware_verified':False,'mask_enabled':False,
      'is_source_frame_counter':False,'two_equal_samples_are_not_lifetime_or_quiescence_proof':True}
