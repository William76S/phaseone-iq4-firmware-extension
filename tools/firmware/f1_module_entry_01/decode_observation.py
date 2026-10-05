#!/usr/bin/env python3
"""Decode only our fixed 200-byte data publication; never read a process/device."""
import math,struct

SIZE=440
STARTUP=('not_selected','selected','provider_verified','user_verified','observation_ready','provider_rejected','user_rejected','module_rejected')
PHASE=('disabled','waiting','owner_observed','lv_not_current','stopped','hold')
def decode_samples(first:bytes,second:bytes)->dict:
    if type(first) is not bytes or type(second) is not bytes or len(first)!=SIZE or first!=second:
        raise ValueError('two bounded identical own publications required')
    outer,span,startup,reserved=struct.unpack_from('<4I',first)
    schema,inner_span,sequence,phase=struct.unpack_from('<4I',first,16)
    if outer&1 or sequence&1 or span!=SIZE or reserved or startup>=len(STARTUP) or schema!=1 or inner_span!=424 or phase>=len(PHASE):
        raise ValueError('unknown/torn own publication')
    epoch,qualified,rejected=struct.unpack_from('<3Q',first,32)
    objects=struct.unpack_from('<10Q',first,56)
    rect_vt,x,y,w,h=struct.unpack_from('<Q4i',first,136)
    pan_x,pan_y,turn,scale=struct.unpack_from('<3if',first,160)
    countdown,visible,running,calls,mutations,mask=struct.unpack_from('<6I',first,176)
    priority_first,priority_last,normal_first,normal_last=struct.unpack_from('<4Q',first,200)
    stack_count,complete,tail_lv,priority_empty=struct.unpack_from('<4I',first,232)
    stack_nodes=struct.unpack_from('<8Q',first,248);stack_dialogs=struct.unpack_from('<8Q',first,312);stack_vtables=struct.unpack_from('<8Q',first,376)
    if qualified>64 or epoch!=qualified or calls<qualified or calls>64 or mutations or mask or not math.isfinite(scale):
        raise ValueError('not this finite observe-only revision')
    if phase in (2,3) and (startup!=4 or not qualified or objects[6]!=0x6be8ac or any(v<4096 or v&7 for i,v in enumerate(objects) if i!=6)):
        raise ValueError('invalid candidate owner publication')
    if phase in (2,3) and (not 1<=stack_count<=8 or complete!=1 or tail_lv!=1 or priority_empty!=1 or stack_dialogs[stack_count-1]!=objects[3] or any(stack_nodes[stack_count:]+stack_dialogs[stack_count:]+stack_vtables[stack_count:])):
        raise ValueError('unknown original stack metadata')
    return {'schema':'iq4_f1_entry_own_observation_v1','startup':STARTUP[startup],'phase':PHASE[phase],
      'outer_sequence':outer,'dispatch_epoch':epoch,'qualified_boundaries':qualified,'rejected_boundaries':rejected,
      'objects':dict(zip(('queue','manager','data','lv','stock_popup','popped_observer','caller_pc','frame_pointer','thread_pointer','mutex'),objects)),
      'local_control_bounds_candidate':{'vtable':rect_vt,'x':x,'y':y,'width':w,'height':h},
      'pan_cached_candidate':[pan_x,pan_y],'quarterturn_candidate':turn,'scale_candidate':scale,
      'countdown_candidate':countdown,'visible_candidate':visible,'running_candidate':running,
      'original_tls_getter_attempts':calls,'mutating_port_calls':mutations,'mask_enabled':False,
      'original_stack_candidate':{'priority_first':priority_first,'priority_last':priority_last,'normal_first':normal_first,'normal_last':normal_last,'bounded_complete':complete,'lv_at_tail':tail_lv,'priority_empty':priority_empty,'normal_nodes':stack_nodes[:stack_count],'normal_dialogs':stack_dialogs[:stack_count],'normal_node_vtables':stack_vtables[:stack_count]},
      'hardware_facts_verified':False,'geometry_viewport_verified':False,'lease_or_fresh_blit_verified':False,
      'publication_is_source_frame_count':False,'two_equal_samples_are_not_lifetime_or_quiescence_proof':True}
