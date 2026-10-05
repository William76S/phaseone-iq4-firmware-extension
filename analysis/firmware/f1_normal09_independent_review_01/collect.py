"""Finite offline Normal09 source/ELF review. Does not build or load code."""
from pathlib import Path
import hashlib, importlib.util, json, struct, sys
sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
SOURCE = ROOT / 'tools/firmware/f1_normal_fit_display_09/SOURCE_SHA256.json'
EXPECTED = '1271de60d10c04ca6ed580bd93ebf4bbdd8544e401e98a9ee581e2f17e3e69cb'
def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()
def main():
    out = HERE / 'STATIC_REVIEW.json'
    assert not out.exists(), 'Independent review is not rewritten'
    assert sha(SOURCE) == EXPECTED
    manifest = json.loads(SOURCE.read_bytes())
    counts = {}
    for key in ('members', 'frozen_refs', 'review_artifacts'):
        counts[key] = len(manifest[key])
        for row in manifest[key]:
            path = ROOT / row['path']
            assert path.stat().st_size == row['bytes'] and sha(path) == row['sha256'], row['path']
    assert counts == {'members': 19, 'frozen_refs': 474, 'review_artifacts': 23}
    parser_path = ROOT / 'analysis/firmware/f1_entry_observe_independent_review_08/collect.py'
    spec = importlib.util.spec_from_file_location('owned_elf_review_reader', parser_path)
    parser = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(parser)  # Pure ELF helper; its main is not invoked.
    build = json.loads((ROOT / 'analysis/firmware/f1_normal_fit_display_build_09/BUILD_PREPARATION.json').read_bytes())
    results = {}
    for kind, row in build['outputs'].items():
        path, full_path = ROOT / row['path'], ROOT / row['unstripped_path']
        assert sha(path) == row['sha256'] and path.stat().st_size == row['bytes']
        assert sha(full_path) == row['unstripped_sha256']
        b, ph, dyn, _, needed, tags, _, span = parser.elf(path)
        _, full_ph, full_dyn, full, full_needed, _, init, full_span = parser.elf(full_path)
        assert ph == full_ph and dyn == full_dyn and needed == full_needed
        exports = sorted(k for k, v in dyn.items() if v['section'])
        undefined = sorted(k for k, v in dyn.items() if not v['section'])
        assert exports == sorted(row['exports']) and undefined == sorted(row['undefined'])
        pub = dyn[row['publication_symbol']]
        assert pub['va'] == row['publication_va'] and pub['size'] == 496
        unlock = dyn['pthread_mutex_unlock']
        body = span(unlock['va'], unlock['size'])
        assert body == full_span(unlock['va'], unlock['size'])
        words = struct.unpack('<' + 'I' * (len(body) // 4), body)
        assert words.count(0xd63f02c0) == 1  # BLR x22, actual original pointer.
        assert words[0x58 // 4] == 0xb9000277 and words[0x60 // 4] == 0xd63f02c0
        errno_stores = [i for i, word in enumerate(words) if word == 0xb9000277]
        assert words[0x68 // 4] == 0xb9400277 and errno_stores == [0x58 // 4, 0x68c // 4]
        retained = {}
        for key in ('fixed_normal_plan', 'dispatch_scaler_return_on_ui', 'after_native_write_on_ui',
                    'iq4_f1_scaler_bridge_09', 'sample_boundary_scalars_on_actual_ui',
                    'configure_on_actual_ui', 'iq4_f1_ui09_bind_actual_provider_before_patch'):
            matches = {k: v for k, v in full.items() if key in k}
            assert matches, key
            retained.update(matches)
        trampoline = full['iq4_f1_scaler_trampoline_09']
        assert trampoline['size'] == 8 and span(trampoline['va'], 8) == bytes(8)
        assert not any('configure_on_actual_ui' in k or 'bind_actual_provider' in k
                       or 'scaler_bridge' in k or 'scaler_trampoline' in k for k in exports)
        assert tags[30] & 8 and tags[0x6ffffffb] & 1
        results[kind] = dict(path=row['path'], bytes=len(b), sha256=sha(path),
            ELF_type='ET_DYN', ELF_machine='AArch64', exports=exports, undefined=undefined,
            DT_NEEDED=needed, bind_now=True, publication=pub, init_array_order=init,
            retained_production_symbols=retained, trampoline_initial=trampoline,
            trampoline_initial_value=0,
            original_unlock=dict(va=unlock['va'], bytes=unlock['size'],
                body_sha256=hashlib.sha256(body).hexdigest(), original_pointer_BLR_count=1,
                incoming_errno_restore_va=unlock['va']+0x58,
                original_BLR_va=unlock['va']+0x60, original_errno_save_va=unlock['va']+0x68,
                return_errno_restore_va=unlock['va']+4*errno_stores[1]))
    runtime = (ROOT / 'tools/firmware/f1_normal_fit_display_09/runtime_linux.cpp').read_text()
    assert runtime.count('ui09_bridge->after_original_boundary_on_ui(') == 1
    assert 'configure_on_actual_ui(' not in runtime and 'bind_actual_provider_before_patch_on_ui(' not in runtime
    result = dict(schema='iq4_f1_normal09_independent_static_review',
        source_sha256=EXPECTED, checked_reference_rows=sum(counts.values()), groups=counts,
        outputs=results, runtime_provider_configuration_caller_present=False,
        persistent_UI_ports_needed_before_production=True,
        review_scope='source_and_existing_linked_SO_only', target_loaded=False,
        mask_accepted=False, SDK_or_Windows_or_network_used=False, new_or_old_build_executed=False,
        ELF_parser={'path': str(parser_path.relative_to(ROOT)), 'sha256': sha(parser_path)})
    out.write_text(json.dumps(result, indent=2)+'\n')
    print(json.dumps({'checked_reference_rows': result['checked_reference_rows'],
        'source_sha256': EXPECTED, 'target_loaded': False, 'new_or_old_build_executed': False}))
if __name__ == '__main__':
    main()
