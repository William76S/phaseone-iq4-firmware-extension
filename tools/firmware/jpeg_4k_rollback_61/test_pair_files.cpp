#define IQ4_JPEG_PAIR_TEST 1
#include "../jpeg_pair_delete_61/pair.cpp"
#include <cassert>
#include <cstdio>
#include <cerrno>
#include <string>
#include <vector>
#include <unistd.h>
static uintptr_t Cat,Fs,Dir,Sp,File,Power;static int Error,raw_calls,jpg_calls,requested,released,forgot;static std::string local_root;static std::vector<std::pair<uintptr_t,size_t>> ranges;static std::vector<unsigned char> stock;
template<class T>static void put61(uintptr_t p,T x){memcpy((void*)p,&x,sizeof x);}
static uintptr_t mem61(size_t n){auto*p=new unsigned char[n]{};ranges.push_back({(uintptr_t)p,n});return(uintptr_t)p;}
static std::string local61(const char*p){const char*r="/run/media/xqdcard/";assert(strncmp(p,r,strlen(r))==0);std::string tail=p+strlen(r);assert(tail.rfind("DCIM/100PHASE/",0)==0&&tail.find("..") == std::string::npos);return local_root+"/"+tail;}
static std::string relative61(const char*p){assert(p[0]!='/'&&strstr(p,"..") == nullptr);return local_root+"/"+p;}
extern "C" int iq4_native_self_read_01(void*,uintptr_t p,void*out,size_t n){
 if(p==(uintptr_t)&Error&&n==sizeof Error){memcpy(out,&Error,n);return 1;}
 for(auto&q:ranges)if(p>=q.first&&n<=q.second&&p-q.first<=q.second-n){memcpy(out,(void*)p,n);return 1;}
 if(p>=0x400000&&p+n<=0x400000+stock.size()){memcpy(out,stock.data()+p-0x400000,n);return 1;}return 0;
}
extern "C" uintptr_t iq4_pair_test_call_61(uintptr_t pc,uintptr_t a,uintptr_t b,uintptr_t c,uintptr_t d){
 if(pc==0x8bf7e4){assert(a==260&&!b&&!c&&!d);return 0;}
 if(pc==0x8ca888){assert(a==Power&&b==3&&c==500);++requested;put61(Power+0x17c,uint32_t(8));return 0;}
 if(pc==0x8ca708){assert(a==Power&&b==3);++released;put61(Power+0x17c,uint32_t(0));return 0;}
 if(pc==0x827348){assert(a==Fs);snprintf((char*)c,256,"/run/media/xqdcard/%s",(char*)b);return 1;}
 if(pc==0x40a4e0)return(uintptr_t)&Error;
 if(pc==0x9ef138){int rc=::stat(local61((char*)a).c_str(),(struct stat*)b);Error=errno;return(uintptr_t)rc;}
 if(pc==0x826a8c){assert(a==Fs);++jpg_calls;int rc=::remove(relative61((char*)b).c_str());Error=errno;return rc==0;}
 if(pc==0x82595c){assert(a==File);++raw_calls;int rc=::remove(relative61("DCIM/100PHASE/IMG0001.IIQ").c_str());Error=errno;return rc==0;}
 assert(false);return 0;
}
extern "C" int iq4_stock_jpeg_gallery_delete_card_61(uintptr_t cat,uintptr_t node,const char*name,uint32_t*out){assert(cat==Cat&&!node&&!strcmp(name,"IMG0001.JPG"));*out=11;return 1;}
extern "C" int iq4_stock_jpeg_gallery_delete_path_61(uintptr_t cat,uintptr_t node,const char*name,uint32_t card,const char*p){assert(cat==Cat&&!node&&!strcmp(name,"IMG0001.JPG")&&card==11);return local61(p)==relative61("DCIM/100PHASE/IMG0001.JPG");}
extern "C" int iq4_stock_jpeg_gallery_forget_deleted_61(uintptr_t cat,uintptr_t node,const char*name,uint32_t card){assert(cat==Cat&&!node&&!strcmp(name,"IMG0001.JPG")&&card==11);++forgot;return 1;}
static void setup61(){
 Cat=mem61(0x800);Fs=mem61(0x220);Dir=mem61(64);Sp=mem61(0x140);File=mem61(24);Power=mem61(0x400);
 put61(Cat,uintptr_t(0xb7ece0));put61(Fs,uintptr_t(0xd91450));put61(Power,uintptr_t(0xdb6628));put61(Cat+0x7d0,Fs);put61(Cat+0x7e0,Dir);put61(Cat+0x7b8,Power);put61(Cat+0x7c0,uint32_t(3));
 strcpy((char*)(Fs+0x15),"/run/media/xqdcard/");strcpy((char*)Dir,"DCIM/100PHASE");put61(Sp+0x28,Cat);put61(Sp+0x121,(unsigned char)1);put61(Sp+0x11f,(unsigned char)1);put61(Sp+0x120,(unsigned char)1);put61(Sp+0x12b,(unsigned char)1);put61(Sp+0x13f,(unsigned char)1);
 strcpy((char*)(Sp+0x38),"IMG0001");strcpy((char*)(Sp+0x58),"DCIM/100PHASE/IMG0001.IIQ");put61(File,uintptr_t(0xd90410));put61(File+8,Fs);put61(File+0x10,uint32_t(9));put61(File+0x14,(unsigned char)1);
}
int main(int argc,char**argv){assert(argc==3);local_root=argv[1];std::string scenario=argv[2];FILE*f=fopen("analysis/firmware/extracted/P1Linux_6.03.21.bin","rb");assert(f);stock.resize(11874544);assert(fread(stock.data(),1,stock.size(),f)==stock.size());fclose(f);setup61();int rc;
 bool denied=scenario=="jpeg_remove_denied";std::string dir=local_root+"/DCIM/100PHASE";
 if(denied){assert(geteuid()!=0);assert(::chmod(dir.c_str(),0500)==0);}
 if(scenario=="jpeg_only"){put61(Sp+0x121,(unsigned char)0);put61(Sp+0x123,(unsigned char)0);strcpy((char*)(Sp+0x38),"IMG0001.JPG");rc=iq4_jpeg_only_delete_61(Sp);assert(rc==1&&raw_calls==0&&jpg_calls==1&&forgot==1&&requested==1&&released==1);}
 else{rc=iq4_jpeg_pair_raw_delete_61(File,Sp,11);if(denied){assert(::chmod(dir.c_str(),0700)==0);assert(rc==0&&raw_calls==0&&jpg_calls==1);assert(((unsigned char*)Sp)[0x12b]==0&&((unsigned char*)Sp)[0x13f]==0);}else assert(rc==1&&raw_calls==1&&jpg_calls==1);}
 printf("PASS %s production helper: rc=%d RAW_delete_calls=%d JPEG_delete_calls=%d\n",argv[2],rc,raw_calls,jpg_calls);
 for(auto&q:ranges)delete[](unsigned char*)q.first;
}
