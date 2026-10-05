#include "export_regression.inc"
int main(void){
 assert(original_export_regression()==0);
 const uint64_t budgets[]={UINT64_C(299235877),UINT64_C(1073741824),UINT64_C(1073741825)};
 for(unsigned i=0;i<3;++i){struct Mock m={0};struct F3ExportStream03 c={0};struct F3Session s={1,0,0};struct F3Ports p=ports(&m);struct F3ExportRequest03 r=request(14204,10652,0,0);r.quality=100;
  int result=f3_export_stream_begin_03(&c,&s,&r,&p,budgets[i],scratch,sizeof scratch);
#ifdef IQ4_OLD_CAPACITY_COUNTEREXAMPLE
  assert(!result&&!m.calls);
#else
  if(i<2){assert(result&&c.checked.byte_budget==budgets[i]&&m.write_open);const struct F3StreamResult*end=f3_stream_abort_03(&c.checked);assert(end&&!m.write_open&&!s.in_progress&&!m.removed&&!m.published);}
  else assert(!result&&!m.calls);
#endif
 }
 puts("PASS quality100 file capacity boundaries; streaming, no RAW deletion");
}
