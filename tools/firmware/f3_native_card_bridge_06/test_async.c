#define main unused_card_fixture_main_async06
#include "../f3_native_card_bridge_05/test_card.c"
#undef main
#include "card.h"
static uintptr_t ui_vt=0xb91f48,ui_current;static unsigned request_calls,current_calls;static int scenario;
static uintptr_t current(void*p){(void)p;++current_calls;return ui_current;}
static int memory(void*p,uintptr_t a,void*out,size_t n){if(a==(uintptr_t)&ui_vt&&n==8){memcpy(out,&ui_vt,8);return 1;}return readmem(p,a,out,n);}
static enum F3CardOutcome05 request(void*p,uintptr_t a,uint32_t id,uint32_t*out){(void)p;++request_calls;uint32_t mask;memcpy(&mask,(void*)(a+0x17c),4);u32((void*)(a+0x17c),mask|(1u<<id));if(scenario==3)return F3_CARD_UNKNOWN;*out=scenario==1||scenario==4||scenario==5?0:1;u32((void*)(a+0x320),*out);return F3_CARD_OK;}
int main(int argc,char**argv){assert(argc==3);scenario=atoi(argv[2]);FILE*f=fopen(argv[1],"rb");assert(f&&!fseek(f,0,SEEK_END));stock_bytes=(size_t)ftell(f);assert(!fseek(f,0,SEEK_SET));stock=malloc(stock_bytes);assert(stock&&fread(stock,1,stock_bytes,f)==stock_bytes&&!fclose(f));
 for(unsigned i=0;i<2;++i){up(power[i],0xdb6628);up(power[i]+0x68,i?0x9f3fe8:0x9f4000);up(filesystems[i],0xd91450);strcpy((char*)filesystems[i]+0x15,i?"/run/media/xqdcard/":"/run/media/sdcard/");u32(rows[i],10+i);up(rows[i]+16,(uintptr_t)filesystems[i]);u32(rows[i]+24,2);}head=(uintptr_t)power[0];tail=(uintptr_t)power[1];up(power[0]+0x170,tail);ui_current=(uintptr_t)&ui_vt;if(scenario==2)ui_vt=0;
 struct F3CardRead05 m={0,memory};struct F3LeaseCalls05 a={0,reg,waitreq,release};struct F3CardIo05 io={openroot,parent,mounted,statfd,closefd};struct F3TryCalls06 t={0,current,request};struct F3Card05 c={0};int r=f3_card_request_06(&c,&m,&a,&io,&t,11,10);assert(!wait_calls);
 if(scenario==2){assert(r==F3_CARD_FAIL&&!request_calls&&!reg_calls&&!release_calls);}
 else if(scenario==3){assert(r==F3_CARD_UNKNOWN&&request_calls==1&&c.hold&&!release_calls);}
 else if(scenario==1||scenario==4||scenario==5){assert(r==F3_CARD_PENDING_06&&request_calls==2&&c.state==6&&c.raw_dir<0);for(unsigned i=0;i<3;++i)assert(f3_card_poll_06(&c)==F3_CARD_PENDING_06&&request_calls==2&&!wait_calls);
  if(scenario==4){assert(f3_card_cancel_pending_06(&c)==F3_CARD_FAIL&&release_calls==2&&c.state==3);}
  else if(scenario==5){ui_current=0;assert(f3_card_poll_06(&c)==F3_CARD_UNKNOWN&&c.hold&&!release_calls);}
  else{u32(power[0]+0x320,1);u32(power[1]+0x320,1);assert(f3_card_poll_06(&c)==F3_CARD_OK&&c.state==2&&request_calls==2);ui_current=0;unsigned cur=current_calls;assert(f3_card_valid_05(&c)&&current_calls==cur&&f3_card_close_dirs_05(&c)==F3_CARD_OK&&current_calls==cur);ui_current=(uintptr_t)&ui_vt;assert(f3_card_release_requests_05(&c)==F3_CARD_OK&&release_calls==2);}}
 else {assert(r==F3_CARD_OK&&request_calls==2);ui_current=0;unsigned cur=current_calls;assert(f3_card_valid_05(&c)&&current_calls==cur&&f3_card_close_dirs_05(&c)==F3_CARD_OK&&current_calls==cur);
  if(scenario==6){assert(f3_card_release_requests_05(&c)==F3_CARD_UNKNOWN&&c.hold&&!release_calls);}else{ui_current=(uintptr_t)&ui_vt;assert(f3_card_release_requests_05(&c)==F3_CARD_OK&&release_calls==2);}}
 if(c.hold){unsigned req=request_calls,rels=release_calls;assert(f3_card_poll_06(&c)==F3_CARD_UNKNOWN&&f3_card_cancel_pending_06(&c)==F3_CARD_UNKNOWN&&request_calls==req&&release_calls==rels);struct F3Card05 blocked={0};assert(f3_card_request_06(&blocked,&m,&a,&io,&t,10,10)==F3_CARD_FAIL&&request_calls==req);}
 free(stock);printf("{\"async_card_case\":%d,\"passed\":true,\"UI_and_mount_fixture\":true,\"wait_calls\":0,\"target_executed\":false}\n",scenario);return 0;}
