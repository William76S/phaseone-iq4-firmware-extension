"""Directory-independent content identity for the actual linked ELF review.

Only artifact locations are omitted. An object provenance path is replaced by
its actual input index, byte count and SHA256; it is never silently discarded.
The original JSON files remain separately hashed evidence.
"""
import hashlib
import json


def semantic_identity(review, report, loader_proof, composition):
    objects = report['objects']
    by_label = {}
    for index, item in enumerate(objects):
        label = item['label']
        assert label not in by_label, 'ambiguous input object location'
        by_label[label] = dict(input_object_index=index, bytes=item['bytes'],
                              sha256=item['sha256'])
    omitted = []

    def normalize(value, at):
        if isinstance(value, (list, tuple)):
            return [normalize(item, at + '/' + str(index))
                    for index, item in enumerate(value)]
        if isinstance(value, dict):
            out = {}
            for key, item in value.items():
                location = at + '/' + key
                if key == 'path':
                    # These locations are supporting artifact identities, not
                    # a filesystem contract such as a card path or library soname.
                    assert isinstance(item, str) and 'bytes' in value and 'sha256' in value
                    omitted.append(dict(json_pointer=location, location=item))
                    continue
                if key == 'label':
                    assert isinstance(item, str) and item in by_label
                    assert value['bytes'] == by_label[item]['bytes']
                    assert value['sha256'] == by_label[item]['sha256']
                    out['input_object_index'] = by_label[item]['input_object_index']
                    omitted.append(dict(json_pointer=location, location=item))
                    continue
                if key == 'object' and isinstance(item, str):
                    assert item in by_label, 'object provenance must resolve to an actual input'
                    out[key] = dict(by_label[item])
                    omitted.append(dict(json_pointer=location, location=item))
                    continue
                out[key] = normalize(item, location)
            return out
        assert value is None or isinstance(value, (str, int, bool)), 'unknown review JSON value'
        return value

    # Retain the complete review and complete pre-seal link report. The latter
    # binds ordered input identities, all hook words, original imports and final
    # placements. The proof binds the exact library/source graph and the actual
    # compiled two-guard callback, beyond a copied metadata boolean.
    payload = dict(schema='iq4_exact_linked_ELF_semantic_review_identity_01',
                   review=normalize(review, '/review'),
                   actual_link_report=normalize(report, '/actual_link_report'),
                   loader_ABI_proof=normalize(loader_proof, '/loader_ABI_proof'),
                   runtime_contract_composition=normalize(composition, '/runtime_contract_composition'))
    canonical = json.dumps(payload, sort_keys=True, separators=(',', ':'),
                           ensure_ascii=True, allow_nan=False).encode('ascii')
    return payload, canonical, hashlib.sha256(canonical).hexdigest(), omitted
