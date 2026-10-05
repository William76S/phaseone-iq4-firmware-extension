#!/usr/bin/env python3
"""Derive only a new runtime; frozen UI07 and display08 are read-only."""
from pathlib import Path
import difflib,hashlib
ROOT=Path(__file__).resolve().parents[3];HERE=Path(__file__).resolve().parent
def derive():
 p=HERE.parent/'f1_native_entry_binding_07/runtime_linux.cpp';original=p.read_text();s=original
 def replace(a,b,n=1):
  nonlocal s
  assert s.count(a)==n,(a,s.count(a));s=s.replace(a,b)
 replace('#include "bridge.hpp"','#include "../f1_native_entry_binding_07/bridge.hpp"\n#include "../f1_normal_fit_display_08/integration.hpp"')
 replace('alignas(Module) unsigned char module_storage',
  'alignas(iq4::f1::normal08::UI08Bridge) unsigned char ui08_storage[sizeof(iq4::f1::normal08::UI08Bridge)]{};\niq4::f1::normal08::UI08Bridge* ui08_bridge=nullptr;\nalignas(Module) unsigned char module_storage')
 replace('    entry07_bridge=new(entry07_storage)iq4::f1::entry07::BoundaryBridge;',
  '    entry07_bridge=new(entry07_storage)iq4::f1::entry07::BoundaryBridge;\n    ui08_bridge=new(ui08_storage)iq4::f1::normal08::UI08Bridge;')
 replace('entry07_admission','entry08_admission',2)
 replace('ui07.entry','ui08.entry')
 replace('IQ4_F1_UI07_ENTRY_ONLY','IQ4_F1_UI08_ENTRY_OBSERVE_ONLY',2)
 replace("// Protected entry-only admission from Root's separately reviewed new UI07", "// Protected default-OFF entry/finite-observation admission for this new UI08")
 needle='            iq4_f1_entry_binding_observed_07.sequence.fetch_add(1,std::memory_order_acq_rel);'
 replace(needle,'''            // Actual caller closes the source port. No provider contract is
            // configured here, no text hook is installed, and no token is issued.
            if(ui08_bridge&&entry07_bridge->admitted())
                (void)ui08_bridge->after_original_boundary_on_ui(
                    {nullptr,self_read},*module,entry07_bridge->binding(),input);
'''+needle)
 return original,s
def main():
 assert not(HERE/'SOURCE_SHA256.json').exists(),'Frozen source cannot be changed'
 original,s=derive();(HERE/'runtime_linux.cpp').write_text(s)
 (HERE/'RUNTIME_DIFF.txt').write_text(''.join(difflib.unified_diff(original.splitlines(True),s.splitlines(True),fromfile='frozen_UI07/runtime_linux.cpp',tofile='new_UI08/runtime_linux.cpp')))
 print(hashlib.sha256(s.encode()).hexdigest())
if __name__=='__main__':main()
