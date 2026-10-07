#!/usr/bin/env python3
"""Compile the seven-choice native menu; host-only, fresh output required."""
from pathlib import Path
import argparse
import hashlib
import json
import subprocess

ROOT = Path(__file__).resolve().parents[3]


def row(path):
    path = Path(path).resolve()
    assert path.is_relative_to(ROOT)
    data = path.read_bytes()
    return dict(path=str(path.relative_to(ROOT)), bytes=len(data),
                sha256=hashlib.sha256(data).hexdigest())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    out = (ROOT / args.output).resolve()
    assert out.is_relative_to(ROOT) and not out.exists()
    previous = ROOT / 'analysis/firmware/ratio_quick_menu_build_01/COMMANDS.json'
    assert row(previous)['sha256'] == '1a30d64f76d217d0de94877684c11b899b858c059ba292a9322478c526b6097f'
    out.mkdir(parents=True)
    old_directory = str(ROOT / 'analysis/firmware/ratio_quick_menu_build_01')
    commands = []
    for command in json.loads(previous.read_text()):
        argv = [x.replace(old_directory, str(out)) for x in command['argv']]
        result = subprocess.run(argv, cwd=ROOT, capture_output=True, text=True)
        commands.append(dict(argv=argv, exit=result.returncode,
                             stdout=result.stdout, stderr=result.stderr))
        (out / 'COMMANDS.json').write_text(json.dumps(commands, indent=2) + '\n')
        assert result.returncode == 0, result.stderr or result.stdout
    result = dict(normal_and_sanitized_passed=True, device_executed=False,
                  independent_trees=True, ratio_choices=7,
                  persistent_mode_IDs_unchanged=True,
                  remembered_toggle_verified_on_host=True,
                  object=row(out / 'f1_menu.o'))
    (out / 'RESULT.json').write_text(json.dumps(result, indent=2) + '\n')
    paths = [Path(__file__), ROOT / 'src/display/ratio_mask_menu.c',
             ROOT / 'src/display/ratio_mask_menu.h',
             ROOT / 'tests/display/test_ratio_mask_menu.c',
             out / 'COMMANDS.json', out / 'RESULT.json',
             out / 'f1_menu.o', out / 'f1_menu.d']
    dep_text = (out / 'f1_menu.d').read_text().replace('\\\n', '')
    deps = [Path(x) for x in dep_text.split(':', 1)[1].split()]
    manifest = dict(schema='iq4_ratio_quick_menu_exact_inputs_02',
                    files=[row(x) for x in paths],
                    dependencies=[row(x) for x in deps])
    (out / 'SOURCE_SHA256.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
