"""Existing Normal10 frozen-source and linked-ELF review; never builds/loads."""
from pathlib import Path
import hashlib, importlib.util, json, struct, sys
sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
SOURCE = ROOT/'tools/firmware/f1_scaler_hook_install_10/SOURCE_SHA256.json'
EXPECTED = '5793c044638b7f88a8fabae547b2b56b5c6ce17ac02c1ff23551a9048ed68b1e'
def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()
def main():
    out = HERE/'STATIC_REVIEW.json'
    assert not out.exists()
    assert sha(SOURCE) == EXPECTED
    manifest = json.loads(SOURCE.read_bytes())
    counts = {}
    for key in ('members', 'frozen_refs', 'review_artifacts'):
        counts[key] = len(manifest[key])
        for row in manifest[key]:
            p = ROOT/row['path']
            assert p.stat().st_size == row['bytes'] and sha(p) == row['sha256'], row['path']
    assert counts == {'members': 30, 'frozen_refs': 524, 'review_artifacts': 55}
    parser_path = ROOT/'analysis/firmware/f1_entry_observe_independent_review_08/collect.py'
    spec = importlib.util.spec_from_file_location('owned_elf_review_reader', parser_path)
    parser = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(parser)
    build = json.loads((ROOT/'analysis/firmware/f1_scaler_hook_install_build_10/BUILD_PREPARATION.json').read_bytes())
    row = build['module']
    p = ROOT/row['path']
    full_path = p.with_name('libiq4_f1_normal_fit_hook_10_authenticated_candidate.so')
    assert p.stat().st_size == row['bytes'] == 118048 and sha(p) == row['sha256']
    assert row['sha256'] == '88417d06b6cb8ca2553ad1ae76a3444e4014829d75e6c1b66a3946fbd05d7c5c'
    assert sha(full_path) == row['unstripped_sha256']
    b, ph, dyn, _, needed, tags, _, span = parser.elf(p)
    _, full_ph, full_dyn, full, full_needed, _, init, full_span = parser.elf(full_path)
    assert ph == full_ph and dyn == full_dyn and needed == full_needed
    exports = sorted(k for k,v in dyn.items() if v['section'])
    undefined = sorted(k for k,v in dyn.items() if not v['section'])
    assert exports == sorted(row['exports']) and undefined == sorted(row['undefined'])
    def unique(key):
        candidates = [(k,v) for k,v in full.items() if key in k and v['section']]
        assert len(candidates) == 1, (key,candidates)
        return candidates[0]
    def words(symbol):
        blob = span(symbol['va'], symbol['size'])
        assert blob == full_span(symbol['va'], symbol['size'])
        return blob, struct.unpack('<'+'I'*(len(blob)//4), blob)
    def calls(symbol):
        _, ws = words(symbol)
        result = []
        for index,w in enumerate(ws):
            if w&0xfc000000 != 0x94000000:
                continue
            delta = w&0x3ffffff
            if delta&(1<<25): delta -= 1<<26
            at = symbol['va']+index*4
            target = at+delta*4
            result.append({'at':at,'target':target,'names':[k for k,v in full.items() if v['va']==target]})
        return result
    functions = {}
    for key in ('prepare_once_at_live_ui','bind_actual_provider_before_patch_on_ui',
                'configure_on_actual_ui','after_original_boundary_on_ui',
                'Binding14native_current','install_after_original_boundary',
                'dispatch_scaler_return_on_ui','after_native_write_on_ui',
                'fixed_normal_plan','iq4_f1_scaler_bridge_10','iq4_f1_scaler_after_10'):
        name,symbol = unique(key)
        body,ws = words(symbol)
        functions[key] = {'name':name, **symbol, 'body_sha256':hashlib.sha256(body).hexdigest(),
                          'direct_BL_calls':calls(symbol)}
    unlock = dyn['pthread_mutex_unlock']
    body,ws = words(unlock)
    assert ws.count(0xd63f02c0) == 1 and ws[0x60//4] == 0xd63f02c0
    assert ws[0x58//4] == 0xb9000277 and ws[0x68//4] == 0xb9400277
    errno_stores = [unlock['va']+i*4 for i,w in enumerate(ws) if w == 0xb9000277]
    assert errno_stores == [unlock['va']+0x58,unlock['va']+0x6a8]
    uc = calls(unlock)
    boundary_calls = [x for x in uc if x['target'] == functions['after_original_boundary_on_ui']['va']]
    preparation_calls = [x for x in uc if x['target'] == functions['prepare_once_at_live_ui']['va']]
    assert len(boundary_calls) == len(preparation_calls) == 1
    assert boundary_calls[0]['at'] < preparation_calls[0]['at']
    prepare = functions['prepare_once_at_live_ui']
    _,pw = words(prepare)
    pc = prepare['direct_BL_calls']
    configure_calls = [x for x in pc if x['target'] == functions['bind_actual_provider_before_patch_on_ui']['va']]
    assert len(configure_calls) == 1
    releases = [{'at':prepare['va']+i*4,'word':w} for i,w in enumerate(pw) if w&0xfffffc00 == 0xc89ffc00]
    assert len(releases) == 1 and configure_calls[0]['at'] < releases[0]['at']
    barriers = [{'at':prepare['va']+i*4,'word':w} for i,w in enumerate(pw) if w in (0xd5033b9f,0xd5033fdf)]
    assert [x['word'] for x in barriers] == [0xd5033b9f,0xd5033fdf]
    slot = full['iq4_f1_scaler_trampoline_10']
    assert slot['va'] == row['trampoline_slot_va'] == 312656 and span(slot['va'],8) == bytes(8)
    assert functions['iq4_f1_scaler_bridge_10']['va'] == row['bridge_va'] == 168504
    pubs = {}
    for label,sizes in (('normal_fit_ingress',row['normal_publication']),
                        ('hook_preparation',row['preparation_publication']),
                        ('entry_binding',row['entry_publication'])):
        k = next(k for k in exports if label in k)
        value = dyn[k]
        assert [value['va'],value['size']] == sizes
        cover = [x for x in ph if x[0]==1 and x[1]==6 and x[3]<=value['va'] and value['va']+value['size']<=x[3]+x[5]]
        assert len(cover) == 1
        pubs[k] = {**value,'file_backed_RW_load':cover[0]}
    assert tags[30]&8 and tags[0x6ffffffb]&1
    runtime = (ROOT/'tools/firmware/f1_scaler_hook_install_10/runtime_prepare_10.cpp').read_text()
    integration = (ROOT/'tools/firmware/f1_scaler_hook_install_10/integration.hpp').read_text()
    normal = (ROOT/'tools/firmware/f1_scaler_hook_install_10/normal_fit.cpp').read_text()
    assert 'if(ready)iq4::f1::hook10::prepare_once_at_live_ui' in runtime
    assert 'e.persistent_ports_on_ui()' in normal and 'm.selector_ports()' not in normal
    assert 'persistent_=entry.persistent_ports_on_ui()' in integration
    assert 'configure_on_actual_ui(memory,persistent_,contract)' in integration
    assert 'module.selector_ports()' not in integration
    prep_source = (ROOT/'tools/firmware/f1_scaler_hook_install_10/prepare_linux.cpp').read_text()
    ordering = [prep_source.index(x) for x in ('if(!bridge.bind_actual_provider_before_patch_on_ui',
                '__atomic_store_n(&iq4_f1_scaler_trampoline_10','finish(PreparationResult::Prepared)')]
    assert ordering == sorted(ordering)
    controller = (ROOT/'tools/firmware/f1_scaler_hook_install_10/linux_controller.cpp').read_text()
    assert 'slot==c.near_page+16' in controller and 'contract.pid,static_cast<unsigned long long>(contract.pid_ticks)' in controller
    binding_source = (ROOT/'tools/firmware/f1_scaler_hook_install_10/entry_binding_10.cpp').read_text()
    thunk = binding_source.split('Address Binding::native_current(void*c)noexcept{',1)[1].split('Triple Binding::native_triple',1)[0]
    assert 'status_.phase' not in thunk
    result = {'schema':'iq4_f1_normal10_independent_static_review','source_sha256':EXPECTED,
        'checked_reference_rows':sum(counts.values()),'groups':counts,'SO':{'path':row['path'],
        'bytes':len(b),'sha256':sha(p),'DT_NEEDED':needed,'exports':exports,'undefined':undefined,
        'init_array_order':init,'publication':pubs,'trampoline_initial':slot,'trampoline_initial_value':0,
        'retained_functions':functions,'original_unlock':{'va':unlock['va'],'bytes':unlock['size'],
        'body_sha256':hashlib.sha256(body).hexdigest(),'original_BLR_count':1,
        'original_BLR_at':unlock['va']+0x60,'errno_stores':errno_stores,
        'boundary_call':boundary_calls[0],'preparation_call':preparation_calls[0]},
        'prepare_configure_call':configure_calls[0],'prepare_release_store':releases[0],
        'prepare_explicit_barriers':barriers},
        'source_persistent_ports_3_paths_present':True,'source_original_observation_cap_preserved':True,
        'source_slot_before_Prepared_and_external_readback_present':True,
        'new_state_propagation_gap':{'binding_Hold_rechecked_by_captured_current_thunk':False,
            'locations':['entry_binding_10.hpp:38','entry_binding_10.cpp:88',
                         'normal_fit.cpp:39','provider.cpp:115'],
            'scope':'source conditional path, not an observed camera failure'},
        'target_loaded':False,'mask_accepted':False,
        'new_or_old_test_or_build_executed':False,'SDK_or_Windows_or_network_used':False,
        'ELF_parser':{'path':str(parser_path.relative_to(ROOT)),'sha256':sha(parser_path)}}
    out.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'checked_reference_rows':609,'source_sha256':EXPECTED,'SO_sha256':sha(p),
                      'new_or_old_test_or_build_executed':False,'target_loaded':False}))
if __name__ == '__main__':
    main()
