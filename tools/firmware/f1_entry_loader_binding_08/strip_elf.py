"""Read-only use of frozen exact LOAD preserving transformation."""
from pathlib import Path
import importlib.util
p=Path(__file__).resolve().parent.parent/'f1_entry_loader_binding_07/strip_elf.py'
s=importlib.util.spec_from_file_location('frozen_load_transform08',p);m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
strip=m.strip
