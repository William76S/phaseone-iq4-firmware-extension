#!/usr/bin/env python3
"""Tests that locations are the only removed semantic review information."""
from copy import deepcopy
import json
from identity import semantic_identity


def main():
    objects = [dict(label='one/a.o', bytes=8, sha256='a' * 64),
               dict(label='one/b.o', bytes=16, sha256='b' * 64)]
    report = dict(objects=objects, candidate_sha256='c' * 64,
                  original_import_bindings={'symbol': dict(va=32, proof_bytes='01234567')},
                  hooks=[dict(va=44, old_bytes='12345678', new_bytes='87654321')])
    review = dict(User=dict(path='one/User', bytes=128, sha256='c' * 64),
                  verifier=[dict(path='one/check.py', bytes=10, sha256='d' * 64)],
                  immutable_unwind_dependencies=[dict(va=64, bytes=8, sha256='e' * 64,
                                                      provenance=dict(object='one/a.o', input_offset=4))],
                  own_FDEs=[dict(pc=72, bytes=4, fde=80)], loader_COPY_dependencies=[])
    proof = dict(bindings=[dict(symbol='RTTI', va=96)],
                 actual_libstdcxx=dict(path='one/library', bytes=64, sha256='f' * 64))
    composition = dict(va=104, bytes=8, sha256='0' * 64, object=objects[1], calls=[[104, 32]])
    original = semantic_identity(review, report, proof, composition)
    r, p, l, c = deepcopy((review, report, proof, composition))
    r['User']['path'] = 'fresh/other-name.bin'
    r['verifier'][0]['path'] = 'fresh/check.py'
    r['immutable_unwind_dependencies'][0]['provenance']['object'] = 'fresh/a.o'
    p['objects'][0]['label'] = 'fresh/a.o'
    p['objects'][1]['label'] = 'fresh/b.o'
    c['object']['label'] = 'fresh/b.o'
    l['actual_libstdcxx']['path'] = 'fresh/library'
    changed = semantic_identity(r, p, l, c)
    assert original[1] == changed[1] and original[2] == changed[2]
    assert original[3] != changed[3]
    assert json.loads(original[1]) == original[0]
    counts = dict(path_only_relocation=1, semantic_mutation_rejected=0,
                  unknown_provenance_rejected=0, unknown_location_field_rejected=0)
    for which, mutate in (
        ('review', lambda x: x['User'].__setitem__('sha256', '1' * 64)),
        ('review', lambda x: x['immutable_unwind_dependencies'][0].__setitem__('va', 65)),
        ('review', lambda x: x['immutable_unwind_dependencies'][0].__setitem__('sha256', '2' * 64)),
        ('review', lambda x: x['immutable_unwind_dependencies'][0]['provenance'].__setitem__('input_offset', 8)),
        ('review', lambda x: x['own_FDEs'][0].__setitem__('pc', 76)),
        ('report', lambda x: x['original_import_bindings']['symbol'].__setitem__('proof_bytes', '89abcdef')),
        ('report', lambda x: x['hooks'][0].__setitem__('new_bytes', '00000000')),
        ('proof', lambda x: x['bindings'][0].__setitem__('va', 100)),
        ('proof', lambda x: x['actual_libstdcxx'].__setitem__('sha256', '3' * 64)),
        ('composition', lambda x: x['calls'][0].__setitem__(1, 36)),
    ):
        values = dict(zip(('review', 'report', 'proof', 'composition'), deepcopy((review, report, proof, composition))))
        mutate(values[which])
        assert semantic_identity(*values.values())[2] != original[2]
        counts['semantic_mutation_rejected'] += 1
    r = deepcopy(review); r['immutable_unwind_dependencies'][0]['provenance']['object'] = 'unknown/a.o'
    try:
        semantic_identity(r, report, proof, composition)
        raise RuntimeError('unknown provenance accepted')
    except AssertionError:
        counts['unknown_provenance_rejected'] += 1
    r = deepcopy(review); r['unexpected_semantic_contract'] = dict(path='/run/media/sdcard')
    try:
        semantic_identity(r, report, proof, composition)
        raise RuntimeError('semantic path discarded')
    except AssertionError:
        counts['unknown_location_field_rejected'] += 1
    print(json.dumps(dict(schema='iq4_semantic_identity_host_regression_01',
                         counts=counts, cases=sum(counts.values()), passed=True,
                         target_executed=False, camera_accessed=False), sort_keys=True))


if __name__ == '__main__':
    main()
