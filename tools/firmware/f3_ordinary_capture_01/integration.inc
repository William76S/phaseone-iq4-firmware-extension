// Included only in the generated capture03 runtime replacement object.
#include "ordinary.cpp"
extern "C" void iq4_f3_original_calibration_enqueue_01(void*,void*);
extern "C" void iq4_f3_original_node_reset_01(void*);
extern "C" void iq4_f3_original_queue_guard_release_01(void*);
static iq4::ordinary_capture_01::Guard ordinary_guard01;
static iq4::ordinary_capture_01::Memory ordinary_memory01;
extern "C" void iq4_f3_ordinary_enqueue_wrapper_01(void*pool,void*node,void*cm){
 uint64_t receipt=ordinary_guard01.begin(ordinary_memory01,uintptr_t(cm),uintptr_t(pool),uintptr_t(node));
 try{iq4_f3_original_calibration_enqueue_01(pool,node);}catch(...){ordinary_guard01.complete(receipt,false);throw;}
 // Outer void return alone cannot prove queue insertion. Only the real
 // insertion bool at the inner normal-unlock hook can publish Ready.
 ordinary_guard01.complete(receipt,true);
}
extern "C" void iq4_f3_ordinary_queue_unlock_wrapper_01(void*guard,void*queue,void*link,uint32_t inserted){
 ordinary_guard01.before_queue_unlock(ordinary_memory01,uintptr_t(guard),uintptr_t(queue),uintptr_t(link),inserted);
 try{iq4_f3_original_queue_guard_release_01(guard);}catch(...){
  if(uintptr_t(link)>=0x78)ordinary_guard01.invalidate(uintptr_t(link)-0x78);throw;
 }
}
extern "C" void iq4_f3_ordinary_node_reset_wrapper_01(void*node){
 ordinary_guard01.invalidate(uintptr_t(node));
 iq4_f3_original_node_reset_01(node);
}
