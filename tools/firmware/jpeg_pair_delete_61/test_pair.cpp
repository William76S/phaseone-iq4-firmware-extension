#define IQ4_JPEG_PAIR_TEST 1
#include "pair.cpp"
#include <cassert>
#include <cstdio>
#include <string>
#include <vector>
static uintptr_t C,F,D,S,R,P;static int error61,phase,raw_calls,jpeg_calls,popups,requests,releases,forgets;static std::string scenario,relative61;static std::vector<std::pair<uintptr_t,size_t>> ranges;
template<class T>static void wr(uintptr_t p,T x){memcpy((void*)p,&x,sizeof x);}
static uintptr_t mem(size_t n){auto*p=new unsigned char[n]{};ranges.push_back({(uintptr_t)p,n});return(uintptr_t)p;}
extern "C" int iq4_native_self_read_01(void*,uintptr_t p,void*out,size_t n){
 for(const auto&q:JpegPairPins61)if(p==q.address&&n==q.bytes){memcpy(out,q.expected,n);return scenario=="badpin"?0:1;}
 if(p==(uintptr_t)&error61&&n==sizeof(error61)){memcpy(out,&error61,n);return 1;}
 for(auto&q:ranges)if(p>=q.first&&n<=q.second&&p-q.first<=q.second-n){memcpy(out,(void*)p,n);return 1;}return 0;
}
extern "C" uintptr_t iq4_pair_test_call_61(uintptr_t pc,uintptr_t a,uintptr_t b,uintptr_t c,uintptr_t d){
 if(pc==0x8bf7e4){assert(a==260&&b==0&&c==0&&d==0);++popups;return 0;}
 if(pc==0x8ca888){assert(a==P&&b==3&&c==500);++requests;wr(P+0x17c,uint32_t(1u<<3));return scenario=="requestfail"?1:0;}
 if(pc==0x8ca708){assert(a==P&&b==3);++releases;wr(P+0x17c,scenario=="releasefail"?uint32_t(1u<<3):uint32_t(0));return 0;}
 if(pc==0x827348){assert(a==F);relative61=(char*)b;snprintf((char*)c,256,"%s%s",(char*)(F+0x15),(char*)b);return 1;}
 if(pc==0x40a4e0)return(uintptr_t)&error61;
 if(pc==0x9ef138){assert(strstr((char*)a,"/DCIM/100PHASE/IMG0001.JPG"));auto*st=(struct stat*)b;
  if(scenario=="statio"){error61=5;return uintptr_t(-1);}if(scenario=="missing"||phase==1){error61=2;return uintptr_t(-1);}
  st->st_mode=scenario=="directory"?S_IFDIR:S_IFREG;return 0;
 }
 if(pc==0x826a8c){assert(a==F&&!strcmp((char*)b,"DCIM/100PHASE/IMG0001.JPG"));++jpeg_calls;if(scenario=="removefail")return 0;if(scenario!="stillpresent")phase=1;return 1;}
 if(pc==0x82595c){assert(a==R);++raw_calls;return scenario=="rawfail"?0:1;}
 assert(false);return 0;
}
static void setup(uint32_t card){
 C=mem(0x800);F=mem(0x220);D=mem(64);S=mem(0x140);R=mem(24);P=mem(0x400);wr(P,uintptr_t(0xdb6628));wr(C+(card==11?0x7b8:0x788),P);wr(C+(card==11?0x7c0:0x790),uint32_t(3));
 wr(C,uintptr_t(0xb7ece0));wr(F,uintptr_t(0xd91450));strcpy((char*)(F+0x15),card==11?"/run/media/xqdcard/":"/run/media/sdcard/");strcpy((char*)D,"DCIM/100PHASE");
 wr(C+(card==11?0x7d0:0x7a0),F);wr(C+(card==11?0x7e0:0x7b0),D);wr(S+0x28,C);wr(S+(card==11?0x121:0x122),(unsigned char)1);
 strcpy((char*)(S+0x38),"IMG0001");strcpy((char*)(S+0x58),"DCIM/100PHASE/IMG0001.IIQ");wr(S+0x12b,(unsigned char)1);wr(S+0x13f,(unsigned char)1);wr(S+0x120,(unsigned char)1);wr(S+0x11f,(unsigned char)1);
 wr(R,uintptr_t(0xd90410));wr(R+8,F);wr(R+0x10,uint32_t(9));wr(R+0x14,(unsigned char)1);phase=raw_calls=jpeg_calls=popups=requests=releases=forgets=0;error61=0;
}
extern "C" int iq4_stock_jpeg_gallery_delete_card_61(uintptr_t cat,uintptr_t node,const char*name,uint32_t*out){assert(cat==C&&node==0&&!strcmp(name,"IMG0001.JPG"));if(scenario=="registryfail")return 0;*out=strstr((char*)(F+0x15),"xqd")?11:10;return 1;}
extern "C" int iq4_stock_jpeg_gallery_delete_path_61(uintptr_t cat,uintptr_t node,const char*name,uint32_t card,const char*path){assert(cat==C&&node==0&&!strcmp(name,"IMG0001.JPG")&&(card==10||card==11)&&strstr(path,"/DCIM/100PHASE/IMG0001.JPG"));return scenario=="pathfail"?0:1;}
extern "C" int iq4_stock_jpeg_gallery_forget_deleted_61(uintptr_t cat,uintptr_t node,const char*name,uint32_t card){assert(cat==C&&node==0&&!strcmp(name,"IMG0001.JPG")&&(card==10||card==11));++forgets;return scenario=="forgetfail"?0:1;}
int main(){unsigned cases=0;
 for(const char*s:{"pair","missing","statio","directory","removefail","stillpresent","rawfail","badpin","wrongdir","foreignfs","closed"}){
  for(uint32_t card:{10u,11u}){scenario=s;setup(card);if(scenario=="wrongdir")strcpy((char*)(S+0x58),"DCIM/999PHASE/IMG0001.IIQ");if(scenario=="foreignfs")wr(R+8,F+16);if(scenario=="closed")wr(R+0x14,(unsigned char)0);
   int rc=iq4_jpeg_pair_raw_delete_61(R,S,card);bool good=scenario=="pair"||scenario=="missing";assert(rc==int(good));assert(((unsigned char*)S)[0x12b]==int(good)&&((unsigned char*)S)[0x13f]==int(good));
   assert(raw_calls==(good||scenario=="rawfail"?1:0));assert(jpeg_calls==((scenario=="pair"||scenario=="rawfail"||scenario=="removefail"||scenario=="stillpresent")?1:0));
   assert(((unsigned char*)S)[card==11?0x11f:0x120]==(good?0:1));assert(((unsigned char*)S)[card==11?0x120:0x11f]==1);++cases;
  }
 }
 for(const char*s:{"onlypair","registryfail","pathfail","requestfail","missing","removefail","forgetfail","releasefail","borrowed"}){
  for(uint32_t card:{10u,11u}){scenario=s;setup(card);wr(S+0x121,(unsigned char)0);wr(S+0x122,(unsigned char)0);wr(S+0x123,(unsigned char)0);strcpy((char*)(S+0x38),"IMG0001.JPG");if(scenario=="borrowed")wr(P+0x17c,uint32_t(1u<<3));
   int rc=iq4_jpeg_only_delete_61(S);bool good=scenario=="onlypair"||scenario=="borrowed";assert(rc==int(good));assert(((unsigned char*)S)[0x13f]==int(good));assert(((unsigned char*)S)[0x123]==0);assert(raw_calls==0);assert(popups==int(!good));
   assert(requests==(scenario=="registryfail"?0:1));assert(releases==((scenario=="registryfail"||scenario=="borrowed")?0:1));++cases;
  }
 }
 assert(iq4_jpeg_pair_raw_delete_61(0,0,11)==0);printf("PASS %u focused pair-delete host cases; no camera\n",cases);
}
