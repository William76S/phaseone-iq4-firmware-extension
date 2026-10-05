#pragma once
#include "../f3_native_executor_03/executor.h"
#include "../f3_save_coordinator_06/coordinator.h"
/* Own control flow shared by actual coordinator and host fault injection. All
 * functions in the production instance are the exact linked implementations. */
struct F3SavedDispatch08 {
 int(*begin)(F3CapturedRaw01*,F3ExecutorSavedReservation03*);
 int(*prepare)(F3CapturedRaw01*,void**);
 int(*invoke)(const F3ExecutorTask01*,F3CapturedRaw01*,const F3ExecutorSavedReservation03*);
 int(*cancel)(F3CapturedRaw01*,const F3ExecutorSavedReservation03*);
 int(*ended)(int);void(*retain)(F3CapturedRaw01*);
 F3ExecutorRun01 run;
};
inline int f3_saved_route_08(F3CapturedRaw01*c,const F3SavedDispatch08&api){
 F3ExecutorSavedReservation03 reserved{};int admission=api.begin(c,&reserved);
 if(admission!=F3_EXEC_OK01){
  if(admission==F3_EXEC_BUSY01||admission==F3_EXEC_REJECTED01)return 1;
  api.retain(c);return 0;
 }
 void*ticket=nullptr;int prepared=api.prepare(c,&ticket);
 if(prepared!=F3_COORD_KNOWN_ENDED06){
  if(prepared!=F3_COORD_BUSY06&&prepared!=F3_COORD_REJECTED06){api.retain(c);return 0;}
  if(api.cancel(c,&reserved)!=F3_EXEC_OK01){api.retain(c);return 0;}
  return 1; // known no-enqueue; producer owns normal RAW/card cleanup
 }
 if(!ticket||!reserved.mailbox.sequence){api.retain(c);return 0;}
 F3ExecutorTask01 t{ticket,api.run,reserved.mailbox.sequence,0};
 int result=api.invoke(&t,c,&reserved);int ack=api.ended(result);
 if(result==F3_EXEC_BUSY01||result==F3_EXEC_REJECTED01){
  if(!ack||api.cancel(c,&reserved)!=F3_EXEC_OK01){api.retain(c);return 0;}
 }
 return ack;
}
