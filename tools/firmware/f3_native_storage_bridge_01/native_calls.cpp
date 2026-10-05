#include <cstdint>
#ifdef IQ4_F3_STORAGE_BRIDGE_SYNTHETIC_HOST
extern void iq4_fixture_storage_set(void*,uint32_t);
extern uint32_t iq4_fixture_storage_get(void*);
extern uint32_t iq4_fixture_legacy_get(void*);
#endif
extern "C" uint32_t iq4_extensions_installation_stage_02(void);
extern "C" void iq4_f3_storage_ui_set_call_01(uintptr_t,uint32_t);
/* The constructor's completed stage is immutable after startup. Do not query
 * coordinator_ready here: it becomes false on Hold and must never reactivate
 * the old thumbnail writer after a new full-RAW transaction failed. */
extern "C" uint32_t iq4_f3_legacy_jpeg_disabled_01(void*event) {
 if(iq4_extensions_installation_stage_02()==100)return 0;
#ifdef IQ4_F3_STORAGE_BRIDGE_SYNTHETIC_HOST
 return iq4_fixture_legacy_get(event);
#else
 return reinterpret_cast<uint32_t(*)(void*)>(uintptr_t(0x5e8c20))(event);
#endif
 /* An original getter exception is deliberately allowed to propagate. */
}
/* These original native event methods keep their notification behavior; the
 * paired body hooks add the separate project mutex before that notification. No result is reported if a vendor call unwinds. */
extern "C" int iq4_f3_native_storage_write_read_01(uintptr_t event,uint32_t mode,uint32_t*out) noexcept {
 if(!event||!out||mode>2)return 0;
 try {
#ifdef IQ4_F3_STORAGE_BRIDGE_SYNTHETIC_HOST
  iq4_fixture_storage_set(reinterpret_cast<void*>(event),mode);
  *out=iq4_fixture_storage_get(reinterpret_cast<void*>(event));
#else
  iq4_f3_storage_ui_set_call_01(event,mode);
  *out=reinterpret_cast<uint32_t(*)(void*)>(uintptr_t(0x55b500))(reinterpret_cast<void*>(event));
#endif
  return 1;
 }catch(...){return 0;}
}
