#include "decode_receipt.h"
#include "decode_pins.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>
struct Region {uintptr_t va;size_t n;const unsigned char*bytes;};
static struct Region regions[32];static unsigned region_count;
static unsigned char code[16][4096];
static void region(uintptr_t va,const void*p,size_t n){assert(region_count<32);regions[region_count++]=(struct Region){va,n,p};}
static int read_mock(void*ctx,uintptr_t a,void*p,size_t n){(void)ctx;
 for(unsigned i=0;i<region_count;++i)if(a>=regions[i].va&&a-regions[i].va<=regions[i].n&&n<=regions[i].n-(a-regions[i].va)){memcpy(p,regions[i].bytes+a-regions[i].va,n);return 1;}return 0;}
uint64_t iq4_native_current_tid_01(void){return 7;}
static void put32(void*p,size_t at,uint32_t x){memcpy((unsigned char*)p+at,&x,4);}
static void put64(void*p,size_t at,uintptr_t x){memcpy((unsigned char*)p+at,&x,8);}
static void patch(uintptr_t pc,uintptr_t to){uint32_t b=0x94000000|((uint32_t)((to-pc)>>2)&0x3ffffff);
 for(unsigned i=0;i<region_count;++i)if(pc>=regions[i].va&&pc+4<=regions[i].va+regions[i].n){memcpy((unsigned char*)regions[i].bytes+pc-regions[i].va,&b,4);return;}abort();}
static void setup_code(void){for(size_t i=0;i<sizeof iq4_decode_pins_02/sizeof*iq4_decode_pins_02;++i){const struct Iq4DecodePin02*p=&iq4_decode_pins_02[i];assert(p->n<=4096);memcpy(code[i],p->bytes,p->n);region(p->va,code[i],p->n);}
 patch(0x963d28,0xa20000);patch(0x9226c0,0xa20100);patch(0x9226d8,0xa20100);patch(0x922a1c,0xa20200);}
static void one(unsigned which){
 setup_code();unsigned char payload[400]={0},decoded[512]={0},cancel=0,rowstates[8]={0},job[0x58]={0},decoder[0x58]={0};
 uint32_t rows[8],copied[8],pairs[2]={0,2};for(unsigned i=0;i<8;++i)rows[i]=copied[i]=i*16;
 uintptr_t copied_vector[3]={(uintptr_t)copied,(uintptr_t)(copied+8),(uintptr_t)(copied+8)};
 uintptr_t pair_vector[3]={(uintptr_t)pairs,(uintptr_t)(pairs+2),(uintptr_t)(pairs+2)};
 region((uintptr_t)payload,payload,sizeof payload);region((uintptr_t)decoded,decoded,sizeof decoded);
 region((uintptr_t)&cancel,&cancel,1);region((uintptr_t)rows,rows,sizeof rows);region((uintptr_t)copied,copied,sizeof copied);
 region((uintptr_t)pairs,pairs,sizeof pairs);region((uintptr_t)copied_vector,copied_vector,sizeof copied_vector);
 region((uintptr_t)pair_vector,pair_vector,sizeof pair_vector);region((uintptr_t)job,job,sizeof job);region((uintptr_t)decoder,decoder,sizeof decoder);
 Iq4DecodeOwner02 owner={0x500000,(uintptr_t)payload,(uintptr_t)rows,(uintptr_t)decoded,(uintptr_t)&cancel,
  sizeof payload,sizeof decoded,128,8,8,0,2,8,4,rowstates,sizeof rowstates};uint64_t gen=0;
 if(which==1)owner.payload_allocation_bytes=163;
 if(which==2)owner.decoded_allocation_bytes=255;
 if(which==3)owner.total_width=7;
 if(which==4)owner.valid_height=3;
 if(which==5)rows[4]=rows[3];
 if(which==6)rows[7]=128;
 if(which==7)rows[3]++;
 if(which==8)cancel=1;
 if(which==9)patch(0x9226c0,0xa20104);
 if(which==28)owner.row_states=(uint8_t*)owner.payload;
 if(which==29)owner.rows=UINTPTR_MAX-4;
 if(which==30)owner.valid_width=1; // same alignment remains safe for 8px
 if(which==31){owner.total_width=24;owner.valid_width=8;}
 if(which==32)owner.decoded=owner.payload;
 if(which==33)owner.cancel=owner.rows;
 if(which==34||which==35){owner.left=3;owner.valid_width=5;}
 if(which>=28&&which<=33&&which!=30){assert(iq4_f3_decode_begin_02(read_mock,0,&owner,&gen)==IQ4_DECODE_ARGUMENT);return;}
 if(which<=9&&which>=1){assert(iq4_f3_decode_begin_02(read_mock,0,&owner,&gen)==(which==9?IQ4_DECODE_UNBOUND:IQ4_DECODE_ARGUMENT));return;}
 assert(iq4_f3_decode_begin_02(read_mock,0,&owner,&gen)==IQ4_DECODE_OK);
 if(which==10){uint64_t other;assert(iq4_f3_decode_begin_02(read_mock,0,&owner,&other)==IQ4_DECODE_BUSY);}
 uintptr_t a[9]={owner.pool,0x500100,owner.decoded,(uintptr_t)copied_vector,owner.payload,128,8,8,0x500200};
 uintptr_t stack[10]={owner.valid_width,4,owner.top,owner.left,0,0,owner.valid_width,4,8,(uintptr_t)pair_vector};
 for(unsigned i=0;i<9;++i)stack[i]|=UINT64_C(0xa5a5a5a5)<<32; // untouched stack scalar padding
 if(which==11)copied[3]++;
 if(which==12)pairs[1]=0;
 if(which==13)a[5]=127;
 if(which==14)stack[8]=9;
 if(which==35){stack[2]=owner.left;stack[3]=owner.top;}
 iq4_f3_decode_reader_before_02(a,stack,0x600000,0x963d2c);
 if((which>=11&&which<=14)||which==35){Iq4DecodeView02 v;assert(iq4_f3_decode_end_02(gen,&v)==IQ4_DECODE_HOLD);return;}
 put64(job,0,(uintptr_t)pairs);put64(job,8,(uintptr_t)(pairs+2));put64(job,0x10,(uintptr_t)copied_vector);
 put64(job,0x18,owner.payload);put64(job,0x20,owner.decoded);put32(job,0x34,32);put32(job,0x38,8);put32(job,0x3c,8);put32(job,0x40,8);
 put32(decoder,0,8);
 if(which==15)put32(job,0x34,16);
 if(which==16)put32(decoder,0,9);
 for(unsigned pair=0;pair<2;++pair)for(unsigned second=0;second<2;++second){
  unsigned row=2+pair*2+second;uintptr_t ra[4]={(uintptr_t)decoder,owner.payload+rows[row],owner.decoded+row*32,8};
  uintptr_t index=(uintptr_t)(pairs+pair),pc=second?0x9226dc:0x9226c4;
  if(which==17&&row==3)ra[2]++;
  if(which==18&&row==3)ra[1]++;
  if(which==19&&row==3)continue;
  if(which==20){uintptr_t unrelated[4]={0};unsigned char stock[0x58]={0};region((uintptr_t)stock,stock,sizeof stock);iq4_f3_decode_row_before_02(unrelated,(uintptr_t)stock,index,pc);}
  iq4_f3_decode_row_before_02(ra,(uintptr_t)job,index,pc);
  if(which==21&&row==3)iq4_f3_decode_row_before_02(ra,(uintptr_t)job,index,pc);
  put64(decoder,0x50,ra[1]+(which==22&&row==3?20:4));
  if(which!=23||row!=3)iq4_f3_decode_row_after_02(ra,(uintptr_t)job,index,pc);
 }
 if(which!=24)iq4_f3_decode_join_after_02(0x600000-0x140+(which==36?0x240:0),owner.pool,0x922a20);
 if(which==25)iq4_f3_decode_join_after_02(0x600000-0x140,owner.pool,0x922a20);
 if(which==26)cancel=1;
 if(which!=27)iq4_f3_decode_reader_after_02(0x963d2c);
 Iq4DecodeView02 v;int rc=iq4_f3_decode_end_02(gen,&v);
 if((which>=15&&which<=18)||which==25||which==27||which==36)assert(rc==IQ4_DECODE_HOLD);
 else if(which==19||(which>=21&&which<=24)||which==26)assert(rc==IQ4_DECODE_INCOMPLETE);
 else assert(rc==IQ4_DECODE_OK&&v.complete&&v.rows_returned==4&&v.joins==1&&v.returned);
}
int main(void){uint64_t ceiling=0;assert(iq4_f3_codec8_read_ceiling_02(14308,&ceiling)&&ceiling==64384);
 assert(!iq4_f3_codec8_read_ceiling_02(7,&ceiling));
 for(unsigned i=0;i<37;++i){pid_t pid=fork();assert(pid>=0);if(!pid){one(i);_exit(0);}int status=0;assert(waitpid(pid,&status,0)==pid);if(!WIFEXITED(status)||WEXITSTATUS(status)){fprintf(stderr,"decode group %u failed\n",i);return 1;}}
 puts("{\"groups\":39,\"host_only\":true,\"native_decoder_executed\":false,\"device_accessed\":false}");return 0;
}
