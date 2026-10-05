"""Finite own unwind pointer/RTTI closure for the actual linked IQ4 ELF.

Ordinary object state and loader COPY outputs are never called immutable.
COPY bindings are emitted separately for the native libstdc++ ABI verifier.
"""
import hashlib
import struct


class UnwindDependencies:
    def __init__(self, root, elf, module, report):
        self.e, self.m, self.report = elf, module, report
        self.immutable, self.copies, self.visited = {}, {}, set()
        self.dyn = {tag: (value, elf.sh[elf.index('.dynamic')][3] + at)
                    for at in range(0, elf.sh[elf.index('.dynamic')][5], 16)
                    for tag, value in [struct.unpack_from('<qQ', elf.section_bytes(elf.index('.dynamic')), at)]}
        self.relocations = []
        for address_tag, length_tag in ((7, 8), (23, 2)):
            if address_tag in self.dyn and length_tag in self.dyn:
                address, length = self.dyn[address_tag][0], self.dyn[length_tag][0]
                assert length % 24 == 0
                for off in range(0, length, 24):
                    target, info, addend = struct.unpack('<QQq', self.read(address + off, 24))
                    assert info & 0xffffffff in (1024, 1025, 1026, 1027), 'unclosed dynamic relocation write width'
                    self.relocations.append(dict(target=target, info=info, addend=addend, record_va=address + off))
        # Original indices are preserved even when a final dynamic table clone
        # adds the single allowed terminate import.
        self.dynsym_va = self.dyn[6][0]
        self.dynstr_va = self.dyn[5][0]
        self.version_va = self.dyn[0x6ffffff0][0]
        self.symbols = elf.symbols(elf.index('.dynsym'))
        self.dynamic_names = {x[6]: (i, x) for i, x in enumerate(self.symbols)}
        objects = []
        for item in report['objects']:
            data = (root / item['label']).read_bytes()
            assert len(data) == item['bytes'] and hashlib.sha256(data).hexdigest() == item['sha256']
            objects.append((item['label'], data))
        # Reconstruct local compiler symbols/relocation provenance; the final
        # public symbol list intentionally omits local Retain/Unknown RTTI.
        module.ALIASES = {k: (v['va'], v['kind']) for k, v in report['original_import_bindings'].items()}
        module.REQUIRED_SYMBOLS = ()
        self.link = module.Linker((root / 'analysis/firmware/extracted/P1Linux_6.03.21.bin').read_bytes(), objects)
        self.link.relocate()
        reserved = report['own_symbols'].get('iq4_linked_contract_seal_01', 0)
        for s in self.link.sections:
            if s.size and not (s.va == reserved and s.size == 131072):
                assert self.read(s.va, s.size) == bytes(s.data), (s.obj, s.name)
        self.own_objects = []
        for (oi, table), symbols in self.link.symtabs.items():
            for si, x in enumerate(symbols):
                if x[3] and x[3] not in (0xfff1, 0xfff2) and x[1] & 15 == 1 and x[5]:
                    address = self.link.symbol((oi, table, si))
                    self.own_objects.append(dict(name=x[6], va=address, bytes=x[5], object=oi,
                                                 section=self.link.lookup[(oi, x[3])].name))

    def read(self, address, length):
        at = self.e.va_offset(address, length)
        return self.e.data[at:at + length]

    def section(self, address, length):
        matches = [(i, h) for i, h in enumerate(self.e.sh)
                   if h[2] & 2 and h[1] != 8 and h[3] <= address and address + length <= h[3] + h[5]]
        assert len(matches) == 1, (hex(address), length)
        return matches[0]

    def no_dynamic_write(self, address, length):
        # Finite target ABI admits only RELA. Conservatively use 8-byte writes
        # for pointers and full symbol size for R_AARCH64_COPY.
        for r in self.relocations:
            size = 8
            if r['info'] & 0xffffffff == 1024:
                index = r['info'] >> 32
                assert index < len(self.symbols)
                size = self.symbols[index][5]
            assert not (r['target'] < address + length and address < r['target'] + size), (
                'dynamic relocation can write immutable dependency', hex(address), r)

    def immutable_span(self, address, length, kind, provenance):
        idx, h = self.section(address, length)
        assert not h[2] & 4
        assert h[1] == 1 or kind == 'loader_COPY_binding_metadata' and h[1] in (3, 4, 11, 0x6ffffffe, 0x6fffffff) or kind == 'loader_COPY_dynamic_selector' and h[1] == 6
        self.no_dynamic_write(address, length)
        record = dict(va=address, bytes=length, sha256=hashlib.sha256(self.read(address, length)).hexdigest(),
                      section=self.e.names[idx], kind=kind, no_dynamic_relocation_target=True,
                      writable_section=bool(h[2] & 1), provenance=provenance)
        key = address, length
        if key in self.immutable:
            assert self.immutable[key]['sha256'] == record['sha256']
        else:
            self.immutable[key] = record

    def cell(self, address, role):
        assert address % 8 == 0
        idx, h = self.section(address, 8)
        assert self.e.names[idx].startswith('.f1.') and not h[2] & 4
        relocations = [(s, at, kind, key, addend) for s, at, kind, key, addend in self.link.relocations
                       if s.va + at == address]
        assert len(relocations) == 1 and relocations[0][2] == 257, ('not one ABS64 cell', hex(address))
        s, off, _, key, addend = relocations[0]
        symbol = self.link.symtabs[key[:2]][key[2]]
        target = self.link.symbol(key) + addend
        assert struct.unpack('<Q', self.read(address, 8))[0] == target
        overlaps = [x for x in self.own_objects if x['va'] < address + 8 and address < x['va'] + x['bytes']]
        if role == 'personality':
            assert s.name == '.data.DW.ref.__gxx_personality_v0'
            assert target == 0x40a640 and symbol[6] == '__gxx_personality_v0' and addend == 0
            assert overlaps and all(x['name'] == 'DW.ref.__gxx_personality_v0' and x['va'] == address
                                    and x['bytes'] == 8 for x in overlaps)
        elif role == 'type':
            # Clang's typed LSDA can use unnamed trailing pointer cells in
            # .data. Admit only the actual indirect LSDA target, one ABS64,
            # outside every ordinary mutable STT_OBJECT (e.g. Job's extent).
            assert not overlaps, ('LSDA indirection overlaps mutable object', overlaps)
            assert s.name == '.data' or s.name.startswith('.data.DW.ref.') or s.name.startswith('.data.rel.ro')
            if s.name == '.data':
                # The actual coordinator cells are trailing compiler constants,
                # outside the preceding complete Job object, not gaps within it.
                ends = [x['va'] + x['bytes'] for x in self.own_objects
                        if x['object'] == s.obj and x['section'] == '.data']
                assert not ends or address >= max(ends)
        else:
            raise AssertionError(('unknown indirection role', role))
        self.immutable_span(address, 8, role + '_indirection_cell',
                            dict(object=self.report['objects'][s.obj]['label'], input_section=s.name,
                                 input_offset=off, relocation=257, symbol=symbol[6], addend=addend,
                                 value=target, ordinary_mutable_object_overlap=False))
        return target

    def metadata_span(self, address, length, reason):
        idx, h = self.section(address, length)
        assert not h[2] & 1, ('loader metadata itself must be immutable', self.e.names[idx])
        self.immutable_span(address, length, 'loader_COPY_binding_metadata', reason)

    def version_requirement(self, index, symbol):
        base = self.dyn[0x6ffffffe][0]
        _, h = self.section(base, 16)
        limit = h[3] + h[5]
        def string(offset):
            p = self.dynstr_va + offset
            raw = bytearray()
            for _ in range(256):
                raw.extend(self.read(p + len(raw), 1))
                if not raw[-1]:
                    return p, bytes(raw), raw[:-1].decode('ascii')
            raise AssertionError('unbounded version requirement string')
        at, matches, visited = base, [], set()
        while True:
            assert at not in visited and base <= at and at + 16 <= limit
            visited.add(at)
            version, count, file, aux, next_ = struct.unpack('<HHIII', self.read(at, 16))
            assert version == 1 and 0 < count <= 64 and aux >= 16
            library_p, library_b, library = string(file)
            item, seen = at + aux, set()
            for i in range(count):
                assert item not in seen and base <= item and item + 16 <= limit
                seen.add(item)
                hash_, flags, other, name, next_aux = struct.unpack('<IHHII', self.read(item, 16))
                if other & 0x7fff == index:
                    name_p, name_b, name_text = string(name)
                    assert library == 'libstdc++.so.6' and name_text == 'CXXABI_1.3'
                    for p, n, what in ((at, 16, 'Verneed header'), (item, 16, 'Vernaux requirement'),
                                       (library_p, len(library_b), 'needed library string'),
                                       (name_p, len(name_b), 'required symbol version string')):
                        self.metadata_span(p, n, dict(symbol=symbol, what=what))
                    matches.append(dict(needed_library=library, version_name=name_text,
                                        version_requirement_va=item, version_hash=hash_, version_flags=flags))
                if i + 1 < count:
                    assert next_aux >= 16
                    item += next_aux
                else:
                    assert next_aux == 0
            if not next_:
                break
            assert next_ >= 16
            at += next_
        assert len(matches) == 1, ('unclosed exact COPY version requirement', symbol, index)
        return matches[0]

    def copy(self, name, reason):
        assert name in ('_ZTIi', '_ZTVN10__cxxabiv117__class_type_infoE',
                        '_ZTVN10__cxxabiv120__si_class_type_infoE'), ('unclosed original COPY symbol', name)
        # Exact active records are insufficient if their table selectors can
        # drift unnoticed. Only these fixed ET_EXEC pointer/size selectors are
        # immutable; DT_DEBUG and unrelated writable .dynamic state stay out.
        selectors = {7: 'DT_RELA', 8: 'DT_RELASZ', 9: 'DT_RELAENT',
                     6: 'DT_SYMTAB', 11: 'DT_SYMENT', 5: 'DT_STRTAB', 10: 'DT_STRSZ',
                     0x6ffffff0: 'DT_VERSYM', 0x6ffffffe: 'DT_VERNEED',
                     0x6fffffff: 'DT_VERNEEDNUM', 23: 'DT_JMPREL', 2: 'DT_PLTRELSZ', 20: 'DT_PLTREL'}
        dynamic = self.e.section_bytes(self.e.index('.dynamic'))
        for tag, title in selectors.items():
            assert tag in self.dyn and sum(struct.unpack_from('<q', dynamic, at)[0] == tag
                                          for at in range(0, len(dynamic), 16)) == 1
            value, address = self.dyn[tag]
            self.immutable_span(address, 16, 'loader_COPY_dynamic_selector',
                                dict(tag=tag, name=title, value=value, fixed_ET_EXEC=True))
        index, sym = self.dynamic_names[name]
        expected = 16 if name == '_ZTIi' else 88
        assert sym[5] == expected and sym[3] not in (0, 0xfff1, 0xfff2)
        copies = [r for r in self.relocations if r['target'] == sym[4] and r['info'] & 0xffffffff == 1024]
        assert len(copies) == 1 and copies[0]['info'] >> 32 == index and copies[0]['addend'] == 0
        r = copies[0]
        assert self.read(sym[4], sym[5]) == bytes(sym[5]), 'expected original COPY file reservation'
        raw = self.read(self.dynsym_va + index * 24, 24)
        assert struct.unpack('<IBBHQQ', raw)[4:] == (sym[4], sym[5])
        version = struct.unpack('<H', self.read(self.version_va + index * 2, 2))[0] & 0x7fff
        requirement = self.version_requirement(version, name)
        self.metadata_span(r['record_va'], 24, dict(symbol=name, what='active R_AARCH64_COPY record'))
        self.metadata_span(self.dynsym_va + index * 24, 24, dict(symbol=name, what='active dynsym record'))
        self.metadata_span(self.version_va + index * 2, 2, dict(symbol=name, what='active version index'))
        name_offset = struct.unpack_from('<I', raw)[0]
        self.metadata_span(self.dynstr_va + name_offset, len(name) + 1, dict(symbol=name, what='active dynstr name'))
        self.copies[name] = dict(symbol=name, va=sym[4], bytes=sym[5], dynsym_index=index,
                                 version_index=version, copy_relocation=dict(va=r['record_va'], bytes=24,
                                 sha256=hashlib.sha256(self.read(r['record_va'], 24)).hexdigest(),
                                 type=1024, record_hex=self.read(r['record_va'], 24).hex()),
                                 static_file_zero=True, file_zero_is_not_runtime_hash=True, reason=reason)
        self.copies[name].update(requirement)
        # SI is the copied metatype dependency used by the exact original
        # class_type_info RTTI closure; the native library verifier owns values.
        if name == '_ZTVN10__cxxabiv117__class_type_infoE':
            self.copy('_ZTVN10__cxxabiv120__si_class_type_infoE', 'class_type_info native metatype closure')
        return sym[4]

    def rtti(self, address):
        if address in self.visited:
            return
        self.visited.add(address)
        originals = [name for name, (_, x) in self.dynamic_names.items() if x[4] == address and name.startswith('_ZTI')]
        if originals:
            assert originals == ['_ZTIi']
            self.copy('_ZTIi', 'actual typed LSDA fundamental int dependency')
            return
        matches = [x for x in self.own_objects if x['va'] == address and x['name'].startswith('_ZTI')]
        assert len(matches) == 1, ('unknown RTTI target', hex(address), matches)
        obj = matches[0]
        assert obj['section'] == '.data.rel.ro' or obj['section'].startswith('.data.rel.ro.')
        assert obj['bytes'] in (16, 24), ('unclosed own RTTI inheritance layout', obj)
        self.immutable_span(address, obj['bytes'], 'own_immutable_RTTI', obj)
        vptr, name_pointer = struct.unpack('<QQ', self.read(address, 16))
        kind = '_ZTVN10__cxxabiv117__class_type_infoE' if obj['bytes'] == 16 else '_ZTVN10__cxxabiv120__si_class_type_infoE'
        assert vptr == self.copy(kind, 'actual own RTTI vptr') + 16
        names = [x for x in self.own_objects if x['va'] == name_pointer and x['name'] == '_ZTS' + obj['name'][4:]]
        assert len(names) == 1 and 1 < names[0]['bytes'] <= 1024
        name = self.read(name_pointer, names[0]['bytes'])
        assert name[-1:] == b'\0' and b'\0' not in name[:-1] and all(32 <= c <= 126 for c in name[:-1])
        assert not self.section(name_pointer, len(name))[1][2] & 1
        self.immutable_span(name_pointer, len(name), 'own_immutable_RTTI_name', names[0])
        if obj['bytes'] == 24:
            self.rtti(struct.unpack('<Q', self.read(address + 16, 8))[0])

    def result(self):
        return (sorted(self.immutable.values(), key=lambda x: (x['va'], x['bytes'])),
                sorted(self.copies.values(), key=lambda x: x['va']))
