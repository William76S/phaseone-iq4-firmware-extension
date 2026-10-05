#include "decode_receipt.h"
#include "../native_runtime_01/self_read.h"
#include "decode_pins.h"
#include <string.h>
static struct {Iq4DecodeRead02 read;void*ctx;Iq4DecodeOwner02 owner;Iq4DecodeView02 view;
 uintptr_t copied_rows,pair_begin,pair_end,reader,reader_frame;
 uint64_t thread;uint32_t active,failed;} state;
static uint64_t serial=1,published;
static unsigned lock_word;
static void lock(void){while(__atomic_exchange_n(&lock_word,1,__ATOMIC_ACQUIRE)){} }
static void unlock(void){__atomic_store_n(&lock_word,0,__ATOMIC_RELEASE);}
static int rd(uintptr_t p,void*b,size_t n){return p>=4096&&n&&n<=4096&&p<=UINTPTR_MAX-n&&state.read&&state.read(state.ctx,p,b,n)==1;}
static int r32(uintptr_t p,uint32_t*b){return rd(p,b,4);}
static int r64(uintptr_t p,uintptr_t*b){return rd(p,b,8);}
static void fail(void){state.failed=1;}
static void hold(void){state.view.held=1;fail();}
static int range(uintptr_t p,uint64_t n){return p>=4096&&n&&n<=UINTPTR_MAX-p;}
static int disjoint(uintptr_t a,uint64_t an,uintptr_t b,uint64_t bn){return a+an<=b||b+bn<=a;}
int iq4_f3_codec8_read_ceiling_02(uint32_t w,uint64_t*out){
 if(!out||w<8||w>65500)return 0;
 /* Nine refill load sites can each execute at most once per eight-pixel
  * iteration; the remaining one executes at most once per tail pixel.
  * This conservative count is locked to the full decoder bytes/CFG. */
 *out=4*(UINT64_C(9)*(w/8)+(w%8));return 1;
}
static int branch(uintptr_t pc,uintptr_t to){uint32_t w;int64_t d=(int64_t)to-(int64_t)pc;
 return !(d&3)&&d>=-(INT64_C(1)<<27)&&d<(INT64_C(1)<<27)&&r32(pc,&w)&&
  w==(UINT32_C(0x94000000)|((uint32_t)(d>>2)&UINT32_C(0x3ffffff)));}
static int admit(void){unsigned char b[64];
 for(size_t i=0;i<sizeof iq4_decode_pins_02/sizeof*iq4_decode_pins_02;++i){const struct Iq4DecodePin02*p=&iq4_decode_pins_02[i];
  for(size_t at=0;at<p->n;at+=4){uintptr_t a=p->va+at;
   if(a==0x963d28||a==0x9226c0||a==0x9226d8||a==0x922a1c)continue;
   if(!rd(a,b,4)||memcmp(b,p->bytes+at,4))return 0;}}
#ifdef IQ4_NATIVE_HOST_FIXTURE
 return branch(0x963d28,0xa20000)&&branch(0x9226c0,0xa20100)&&
  branch(0x9226d8,0xa20100)&&branch(0x922a1c,0xa20200);
#else
 return branch(0x963d28,(uintptr_t)iq4_f3_decode_native_reader_wrapper_02)&&
  branch(0x9226c0,(uintptr_t)iq4_f3_decode_native_row_wrapper_02)&&
  branch(0x9226d8,(uintptr_t)iq4_f3_decode_native_row_wrapper_02)&&
  branch(0x922a1c,(uintptr_t)iq4_f3_decode_native_join_wrapper_02);
#endif
}
int iq4_f3_decode_begin_02(Iq4DecodeRead02 read,void*ctx,const Iq4DecodeOwner02*o,uint64_t*g){
 if(!read||!o||!g||!o->pool||!o->payload||!o->rows||!o->decoded||!o->cancel||!o->row_states||
  o->row_states_bytes<o->total_height||!o->total_height||o->total_height>65500||
  !o->valid_height||(o->valid_height&1)||(o->top&1)||o->top>o->total_height||
  o->valid_height>o->total_height-o->top||o->left>o->total_width||
  !o->valid_width||o->valid_width>o->total_width-o->left||!o->payload_bytes)return IQ4_DECODE_ARGUMENT;
 uint64_t ceiling,stride=(UINT64_C(2)*o->total_width+31)&~UINT64_C(31);
 const uint64_t native_stride=(UINT64_C(2)*(o->left+o->valid_width)+31)&~UINT64_C(31);
 if(!iq4_f3_codec8_read_ceiling_02(o->total_width,&ceiling)||
  o->payload_allocation_bytes<o->payload_bytes+ceiling||
  o->payload_allocation_bytes>UINTPTR_MAX-o->payload||
  o->decoded_allocation_bytes<stride*o->total_height||
  o->decoded_allocation_bytes>INT32_MAX||o->decoded_allocation_bytes>UINTPTR_MAX-o->decoded||
  native_stride!=stride)
  return IQ4_DECODE_ARGUMENT;
 /* The native reader uses min(totalW,left+validW) for its storage stride,
  * but the codec writes totalW pixels. Restrict to equal aligned strides,
  * before dispatch, instead of detecting an unsafe row only afterward. */
 uintptr_t bases[5]={o->payload,o->rows,o->decoded,o->cancel,(uintptr_t)o->row_states};
 uint64_t sizes[5]={o->payload_allocation_bytes,(uint64_t)o->total_height*4,
  o->decoded_allocation_bytes,1,o->total_height};
 for(unsigned i=0;i<5;++i){if(!range(bases[i],sizes[i]))return IQ4_DECODE_ARGUMENT;
  for(unsigned j=0;j<i;++j)if(!disjoint(bases[i],sizes[i],bases[j],sizes[j]))return IQ4_DECODE_ARGUMENT;}
 lock();if(state.view.held){unlock();return IQ4_DECODE_HOLD;}
 if(state.active){unlock();return IQ4_DECODE_BUSY;}
 memset(&state,0,sizeof state);state.read=read;state.ctx=ctx;state.owner=*o;
 if(!admit()){unlock();return IQ4_DECODE_UNBOUND;}
 uint32_t previous=0;unsigned char cancelled;
 for(uint32_t i=0;i<o->total_height;++i){uint32_t at;
  if(!r32(o->rows+4*(uintptr_t)i,&at)||at>=o->payload_bytes||(at&3)||(i&&at<=previous)){
   unlock();return IQ4_DECODE_ARGUMENT;}previous=at;}
 if(!rd(o->cancel,&cancelled,1)||cancelled||serial==UINT64_MAX){unlock();return IQ4_DECODE_ARGUMENT;}
 const uint64_t tid=iq4_native_current_tid_01();if(!tid){unlock();return IQ4_DECODE_UNBOUND;}
 memset(o->row_states,0,o->total_height);state.active=1;state.thread=tid;
 state.view.generation=serial++;*g=state.view.generation;
 __atomic_store_n(&published,state.view.generation,__ATOMIC_RELEASE);unlock();return IQ4_DECODE_OK;
}
static int main_thread(void){return state.thread&&iq4_native_current_tid_01()==state.thread;}
void iq4_f3_decode_reader_before_02(const uintptr_t a[9],const uintptr_t s[10],uintptr_t sp,uintptr_t pc){
 if(!__atomic_load_n(&published,__ATOMIC_ACQUIRE))return;lock();
 if(!main_thread()){unlock();return;}
 const Iq4DecodeOwner02*o=&state.owner;
 if(!a||!s||pc!=0x963d2c||state.view.entered||state.failed||a[0]!=o->pool||
  a[2]!=o->decoded||a[4]!=o->payload||a[5]!=o->payload_bytes||a[6]!=o->total_width||a[7]!=o->total_height||
  (uint32_t)s[0]!=o->valid_width||(uint32_t)s[1]!=o->valid_height||
  /* Native ctor w4=Y, w5=X: outgoing stack is top, then left. */
  (uint32_t)s[2]!=o->top||(uint32_t)s[3]!=o->left||
  (uint32_t)s[4]||(uint32_t)s[5]||(uint32_t)s[6]!=o->valid_width||
  (uint32_t)s[7]!=o->valid_height||(uint32_t)s[8]!=8||!a[8]||sp<0x140){
  hold();unlock();return;}
 uintptr_t begin,end,pbegin,pend;
 if(!r64(a[3],&begin)||!r64(a[3]+8,&end)||end<begin||end-begin!=(uint64_t)o->total_height*4||
  !r64(s[9],&pbegin)||!r64(s[9]+8,&pend)||pend<pbegin||pend-pbegin!=(uint64_t)o->valid_height*2){
  hold();unlock();return;}
 for(uint32_t i=0;i<o->total_height;++i){uint32_t actual,expected;
  if(!r32(begin+4*(uintptr_t)i,&actual)||!r32(o->rows+4*(uintptr_t)i,&expected)||actual!=expected){hold();unlock();return;}}
 for(uint32_t i=0;i<o->valid_height/2;++i){uint32_t actual;
  if(!r32(pbegin+4*(uintptr_t)i,&actual)||actual!=i*2){hold();unlock();return;}}
 state.copied_rows=a[3];state.pair_begin=pbegin;state.pair_end=pend;
 state.reader=a[8];state.reader_frame=sp-0x140;state.view.entered=1;unlock();
}
static int row_identity(const uintptr_t a[4],uintptr_t job,uintptr_t index,uintptr_t pc,uint32_t*out){
 uintptr_t rows,payload,dest,begin,end;uint32_t pair,width,format,stride,left,top;
 if(!a||!job||!r64(job+0x10,&rows)||!r64(job+0x18,&payload))return 0;
 if(rows!=state.copied_rows||payload!=state.owner.payload)return 0; // unrelated stock job
 if(state.failed)return 0;
 if(!state.view.entered||state.failed||!r64(job,&begin)||!r64(job+8,&end)||
  begin<state.pair_begin||end>state.pair_end||end<begin||index<begin||index>=end||((index-begin)&3)||
  !r32(index,&pair)||pair>=state.owner.valid_height||(pair&1)||
  !r32(a[0],&width)||width!=state.owner.total_width||a[3]!=8||
  !r32(job+0x38,&format)||format!=8||!r32(job+0x34,&stride)||
  stride!=((state.owner.total_width*2+31)&~31u)||
  !r32(job+0x2c,&left)||left||!r32(job+0x30,&top)||top||
  !r64(job+0x20,&dest)||dest!=state.owner.decoded){hold();return -1;}
 const uint32_t row=state.owner.top+pair+(pc==0x9226dc?1u:0u);
 if((pc!=0x9226c4&&pc!=0x9226dc)||row>=state.owner.total_height){hold();return -1;}
 uint32_t offset;if(!r32(state.owner.rows+4*(uintptr_t)row,&offset)||
  a[1]!=state.owner.payload+offset||a[2]!=dest+(uint64_t)row*stride){hold();return -1;}
 *out=row;return 1;
}
void iq4_f3_decode_row_before_02(const uintptr_t a[4],uintptr_t job,uintptr_t index,uintptr_t pc){
 if(!__atomic_load_n(&published,__ATOMIC_ACQUIRE))return;lock();uint32_t row;
 if(row_identity(a,job,index,pc,&row)==1){if(state.owner.row_states[row])fail();else state.owner.row_states[row]=1;}unlock();
}
void iq4_f3_decode_row_after_02(const uintptr_t a[4],uintptr_t job,uintptr_t index,uintptr_t pc){
 if(!__atomic_load_n(&published,__ATOMIC_ACQUIRE))return;lock();uint32_t row;
 if(row_identity(a,job,index,pc,&row)==1){uintptr_t cursor;uint32_t end=state.owner.payload_bytes;
  if(row+1<state.owner.total_height&&!r32(state.owner.rows+4*(uintptr_t)(row+1),&end)){hold();unlock();return;}
  if(state.owner.row_states[row]!=1||!r64(a[0]+0x50,&cursor)||cursor<=a[1]||cursor>state.owner.payload+end){fail();}
  else{state.owner.row_states[row]=2;++state.view.rows_returned;}}
 unlock();
}
void iq4_f3_decode_join_after_02(uintptr_t frame,uintptr_t pool,uintptr_t pc){
 if(!__atomic_load_n(&published,__ATOMIC_ACQUIRE))return;lock();
 if(!main_thread()){unlock();return;}
 if(pc!=0x922a20||frame!=state.reader_frame||pool!=state.owner.pool||state.view.joins){hold();}
 else{state.view.joins=1;if(state.view.rows_returned!=state.owner.valid_height)fail();}
 unlock();
}
void iq4_f3_decode_reader_after_02(uintptr_t pc){
 if(!__atomic_load_n(&published,__ATOMIC_ACQUIRE))return;lock();
 if(!main_thread()){unlock();return;}
 if(pc!=0x963d2c||!state.view.entered||state.view.returned){hold();}
 else{state.view.returned=1;if(state.view.joins!=1)fail();}unlock();
}
int iq4_f3_decode_end_02(uint64_t g,Iq4DecodeView02*out){
 lock();if(!out||!g||g!=state.view.generation||!state.active||!main_thread()){unlock();return IQ4_DECODE_ARGUMENT;}
 unsigned char cancel;state.view.complete=!state.failed&&!state.view.held&&state.view.returned&&
  state.view.joins==1&&state.view.rows_returned==state.owner.valid_height&&rd(state.owner.cancel,&cancel,1)&&!cancel;
 *out=state.view;if(state.view.held){unlock();return IQ4_DECODE_HOLD;}
 if(!state.view.returned){hold();*out=state.view;unlock();return IQ4_DECODE_HOLD;}
 __atomic_store_n(&published,0,__ATOMIC_RELEASE);state.active=0;
 int result=state.view.complete?IQ4_DECODE_OK:IQ4_DECODE_INCOMPLETE;unlock();return result;
}
int iq4_f3_decode_abort_joined_02(uint64_t g){
 lock();if(!g||g!=state.view.generation||!state.active||!main_thread()){unlock();return IQ4_DECODE_ARGUMENT;}
 if(state.view.held){unlock();return IQ4_DECODE_HOLD;}
 for(uint32_t i=0;i<state.owner.total_height;++i)if(state.owner.row_states[i]==1){hold();unlock();return IQ4_DECODE_HOLD;}
 __atomic_store_n(&published,0,__ATOMIC_RELEASE);state.active=0;unlock();return IQ4_DECODE_OK;
}
