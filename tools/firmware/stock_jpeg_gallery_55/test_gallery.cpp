#define IQ4_JPEG_GALLERY_TEST
#include "gallery.cpp"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <string>
struct Range {uintptr_t start;size_t n;};static std::vector<Range> ranges;
static std::vector<unsigned char> original;
static uintptr_t cat,ifm,vec,records,nodes[2],fs[2],directory,context,thumb[2],preview[2],final_pool;
static unsigned count=1,lease=0,entered=0,left=0,notifications=0,raw_enqueues=0,replies=0,enumerations=0,closes=0,invalidations=0;
static uintptr_t native_file_entry;static int broken=0,cancel_after=0,lock_depth=0;static uint32_t orientation=6;static std::string scenario;static unsigned full_decodes=0;
static uintptr_t alloc(size_t n){uintptr_t p=(uintptr_t)calloc(1,n);assert(p);ranges.push_back({p,n});return p;}
static bool covered(uintptr_t p,size_t n){for(auto&r:ranges)if(p>=r.start&&n<=r.n&&p-r.start<=r.n-n)return true;return false;}
template<class T>static T get(uintptr_t p){assert(covered(p,sizeof(T)));T v;memcpy(&v,(void*)p,sizeof v);return v;}
extern "C" int iq4_native_self_read_01(void*ctx,uintptr_t p,void*out,size_t n){assert(!ctx);
 if(native_file_entry&&p>=native_file_entry&&n<=0x150&&p-native_file_entry<=0x150-n){memcpy(out,(void*)p,n);return 1;}
 if(p==0xf62208&&n==4){const uint32_t cap=640*480;memcpy(out,&cap,4);return 1;}
 if(covered(p,n)){memcpy(out,(void*)p,n);return 1;}
 if(p>=0x400000&&p+n<=0x400000+original.size()){memcpy(out,original.data()+p-0x400000,n);return 1;}return 0;
}
extern "C" int iq4_stock_jpeg_decoder_bound_55(void){return 1;}
extern "C" int iq4_stock_jpeg_gallery_card_enter_55(uint32_t card){if(card!=11)return 0;if(scenario=="busy")return 0;assert(!lease);lease=card;++entered;return 1;}
extern "C" int iq4_stock_jpeg_gallery_card_guard_55(uint32_t card){assert(!lock_depth);return lease==card&&!broken;}
extern "C" int iq4_stock_jpeg_gallery_card_leave_55(uint32_t card){assert(lease==card);lease=0;++left;return 1;}
extern "C" int iq4_stock_jpeg_probe_file_55(const char*path,int(*guard)(void*),void*ctx,Iq4JpegDecodeResult55*out){assert(strstr(path,"/DCIM/100PHASE/")&&strstr(path,".JPG"));if(guard(ctx)!=1)return 0;*out={4000,3000,0,0,0,orientation};return scenario=="badfile"?0:1;}
static int decode(const char*path,uint32_t w,uint32_t h,uint8_t*p,size_t cap,uint32_t stride,uint32_t maxw,uint32_t maxh,int(*guard)(void*),void*ctx,Iq4JpegDecodeResult55*out){
 assert(!lock_depth);++full_decodes;assert(strstr(path,".JPG")&&p&&stride>=maxw*3&&cap>0);if(guard(ctx)!=1)return 0;if(scenario=="entropyfail")return 0;
 uint32_t ow=maxw,oh=(uint32_t)((uint64_t)ow*h/w);if(oh>maxh){oh=maxh;ow=(uint32_t)((uint64_t)oh*w/h);}assert(ow&&oh&&(uint64_t)(oh-1)*stride+ow*3<=cap);
 for(uint32_t y=0;y<oh;++y){if(cancel_after&&y==1)put<uint8_t>(context+0x788,1);if(guard(ctx)!=1)return 0;for(uint32_t x=0;x<ow;++x){p[(size_t)y*stride+x*3]=(uint8_t)x;p[(size_t)y*stride+x*3+1]=(uint8_t)y;p[(size_t)y*stride+x*3+2]=88;}}
 *out={4000,3000,ow,oh,oh,orientation};return 1;
}
extern "C" int iq4_stock_jpeg_decode_file_55(const char*p,uint8_t*b,size_t cap,uint32_t st,uint32_t mw,uint32_t mh,int(*g)(void*),void*c,Iq4JpegDecodeResult55*r){return decode(p,4000,3000,b,cap,st,mw,mh,g,c,r);}
extern "C" int iq4_stock_jpeg_decode_crop_file_55(const char*p,uint32_t x,uint32_t y,uint32_t w,uint32_t h,uint8_t*b,size_t cap,uint32_t st,uint32_t mw,uint32_t mh,int(*g)(void*),void*c,Iq4JpegDecodeResult55*r){assert(x==200&&y==2000&&w==1200&&h==900);return decode(p,w,h,b,cap,st,mw,mh,g,c,r);}
extern "C" uintptr_t iq4_gallery_test_call_55(uintptr_t pc,uintptr_t a,uintptr_t b,uintptr_t c,uintptr_t,uintptr_t,uintptr_t,uintptr_t){
 if(pc==0x411bc0){assert(b==cat+0x1c0&&!lock_depth);lock_depth=1;return a;}if(pc==0x411bf4){assert(lock_depth==1);lock_depth=0;return 0;}
 if(pc==0x48f4bc){assert(lock_depth==1&&a==vec);return 4;}if(pc==0x48f4f0){assert(lock_depth==1&&a==vec&&b<4);return records+40*b;}
 if(pc==0x827348){assert(!lock_depth);assert(a==fs[1]&&!strcmp((char*)b,"DCIM/100PHASE/IMG0002.JPG")||a==fs[1]&&!strcmp((char*)b,"DCIM/100PHASE/IMG0001.JPG"));snprintf((char*)c,260,"/run/media/xqdcard/%s",(char*)b);return 1;}
 if(pc==0x48df80){native_file_entry=a;return a;}if(pc==0x48f36c){native_file_entry=0;return a;}
 if(pc==0x826010){assert(a==fs[1]&&!strcmp((char*)b,"DCIM/100PHASE/*.*"));++enumerations;memset((void*)c,0,0x150);strcpy((char*)c,"IMG0002.JPG");put<uint32_t>(c+0x104,8000);return 1;}
 if(pc==0x826080)return 0;if(pc==0x826388){++closes;return 0;}
 if(pc==0x709be4)return 123;if(pc==0x49037c)return 456;
 if(pc==0x48ae68){assert(a==cat&&b==2);count=2;put<uint32_t>(cat+0x1b8,2);return 0;}
 if(pc==0x48b828){assert(a==cat);return 0;}
 if(pc==0x48dce8){assert(b==nodes[1]);put<uintptr_t>(a,thumb[1]);return a;}
 if(pc==0x48dd9c){uintptr_t p;memcpy(&p,(void*)a,8);return p;}if(pc==0x48dd4c)return 0;
 if(pc==0x70f2f8){assert(a==ifm+0x6c0);++notifications;return 0;}
 if(pc==0x48da14||pc==0x48d9e4){assert(a==nodes[0]);++invalidations;return 0;}
 if(pc==0x490288||pc==0x48fff8){assert(b);if(a==context+0x3b8||a==context+8)++raw_enqueues;else{assert(a==context+0x5a0||a==context+0x1e0);++replies;}return 0x99;}
 if(pc==0x487ab8){assert(a==cat);++notifications;return 0x55;}
 fprintf(stderr,"unexpected native fixture call %lx\n",(unsigned long)pc);abort();
}
static uintptr_t pool(uint32_t capacity,bool gray=false){uintptr_t p=alloc(0xa0);put<uint32_t>(p+0x38,capacity);uintptr_t pixels=alloc(capacity);put<uintptr_t>(p+0x40,pixels);Image55 im={0,0,0,0,pixels};memcpy((void*)(p+0x20),&im,sizeof im);if(gray){uintptr_t gp=alloc(640*480);put<uintptr_t>(p+0x88,gp);Image55 gi={9,0,0,0,gp};memcpy((void*)(p+0x70),&gi,sizeof gi);}return p;}
int main(int argc,char**argv){assert(argc==2);scenario=argv[1];FILE*f=fopen("analysis/firmware/extracted/P1Linux_6.03.21.bin","rb");assert(f);original.resize(11874544);assert(fread(original.data(),1,original.size(),f)==original.size());fclose(f);
 cat=alloc(0x800);ifm=alloc(0x1000);vec=alloc(24);records=alloc(160);context=alloc(0x1000);directory=alloc(260);strcpy((char*)directory,"DCIM/100PHASE");put<uintptr_t>(cat,0xb7ece0);put<uintptr_t>(cat+0x328,ifm);put<uintptr_t>(ifm,0xb7f960);put<uintptr_t>(ifm+0xfa8,cat);put<uintptr_t>(cat+0x1b0,vec);put<uint32_t>(cat+0x1a8,4);put<uint32_t>(cat+0x1b8,1);put<uintptr_t>(cat+0x4d0,context);
 for(unsigned i=0;i<2;++i){fs[i]=alloc(0x100);put<uintptr_t>(fs[i],0xd91450);strcpy((char*)(fs[i]+0x15),i?"/run/media/xqdcard/":"/run/media/sdcard/");put<uintptr_t>(cat+(i?0x7d0:0x7a0),fs[i]);put<uintptr_t>(cat+(i?0x7e0:0x7b0),directory);nodes[i]=alloc(0x100);put<uint32_t>(nodes[i]+0xd8,i);thumb[i]=pool(160000);put<uintptr_t>(thumb[i],0xdb5500);preview[i]=pool(640*480*3,true);}
 final_pool=pool(1600*1200*3);strcpy((char*)records,"IMG0001.IIQ");put<uint8_t>(records+0xe,2);put<uint8_t>(records+0xd,0x5a);put<uint16_t>(records+0x10,0x21);put<uintptr_t>(records+0x20,nodes[0]);
 assert(iq4_stock_jpeg_gallery_bind_55(cat));assert(iq4_stock_jpeg_only_gallery_bound_55());
 if(scenario=="busy"){assert(count==1&&!enumerations&&!lease);goto done;}
 if(scenario=="badfile"){assert(count==1&&!entries[0].state);goto done;}
 assert(count==2&&get<uint8_t>(records+0xe)==2&&!strcmp((char*)records,"IMG0001.IIQ"));assert(!strcmp((char*)(records+40),"IMG0002.JPG")&&get<uint8_t>(records+40+0xe)==16&&get<uint16_t>(records+40+0x10)==0x20);
 put<uintptr_t>(records+40+0x20,nodes[1]);assert(!iq4_stock_jpeg_gallery_is_photo_55(cat,nodes[0])&&iq4_stock_jpeg_gallery_is_photo_55(cat,nodes[1]));
 if(scenario=="entropyfail"){assert(iq4_stock_jpeg_gallery_prepare_retire_55(cat,nodes[0],0,11)==0&&full_decodes==1&&get<uint8_t>(records+0xe)==2&&!strcmp((char*)records,"IMG0001.IIQ"));goto done;}
 if(scenario=="retire"){
  assert(iq4_stock_jpeg_gallery_prepare_retire_55(cat,nodes[0],0,11)==1&&full_decodes==1);assert(iq4_stock_jpeg_gallery_commit_retire_55(cat,nodes[0],0,11)==-1);assert(get<uint8_t>(records+0xe)==2);
  put<uint8_t>(records+0xe,16);assert(iq4_stock_jpeg_gallery_commit_retire_55(cat,nodes[0],0,11)==1);assert(!strcmp((char*)records,"IMG0001.JPG")&&get<uint8_t>(records+0xd)==0x5a&&get<uint16_t>(records+0x10)==0x20&&invalidations==2&&get<uint32_t>(nodes[0]+0x70)==90);goto done;
 }
 if(scenario=="metadata"){assert(iq4_stock_jpeg_gallery_metadata_55(cat,nodes[0],1)==-2);assert(iq4_stock_jpeg_gallery_metadata_55(cat,nodes[1],1)==1);assert(get<uint32_t>(nodes[1]+0x38)==4000&&get<uint32_t>(nodes[1]+0x3c)==3000&&get<uint32_t>(nodes[1]+0x70)==90&&get<uint8_t>(nodes[1]+0x24)==1&&get<uint8_t>(thumb[1]+8)==1);goto done;}
 {uintptr_t request=alloc(0x88);put<uint32_t>(request+0x2c,640*480*3);put<uintptr_t>(request+0x40,preview[1]+0x20);put<uintptr_t>(request+0x48,preview[1]+0x70);put<uintptr_t>(request+0x50,nodes[1]);put<uintptr_t>(request+0x58,context+0x788);put<uint32_t>(request+0x7c,640);put<uint32_t>(request+0x80,480);
  if(scenario=="cancel")cancel_after=1;
  assert(iq4_stock_jpeg_gallery_preview_enqueue_55(context+0x3b8,request)==0x99);assert(replies==1&&!raw_enqueues&&get<uint8_t>(request)==(scenario=="cancel"?0:1));
  if(scenario=="cancel")goto done;
  assert(get<Image55>(preview[1]+0x20).width==640&&get<Image55>(preview[1]+0x70).format==9);put<uintptr_t>(request+0x50,nodes[0]);assert(iq4_stock_jpeg_gallery_preview_enqueue_55(context+0x3b8,request)==0x99&&raw_enqueues==1);
 }
 if(scenario=="zoom"){
  uintptr_t r=alloc(0x80);Rect55 rect={0xb73b98,100,200,900,1200};memcpy((void*)(r+8),&rect,sizeof rect);float angle=90;memcpy((void*)(r+0x24),&angle,4);put<uint32_t>(r+0x2c,1600*1200*3);put<uintptr_t>(r+0x48,final_pool+0x20);put<uintptr_t>(r+0x58,nodes[1]);put<uintptr_t>(r+0x60,context+0x788);put<uint32_t>(r+0x68,1600);put<uint32_t>(r+0x6c,1200);
  assert(iq4_stock_jpeg_gallery_final_enqueue_55(context+8,r)==0x99&&get<uint8_t>(r)==1);Image55 im=get<Image55>(final_pool+0x20);assert(im.width==900&&im.height==1200&&im.stride==2700);
 }
done:assert(!lease&&!lock_depth&&entered==left);printf("PASS gallery %s, scoped native service/decoder fixtures, entered=%u left=%u\n",argv[1],entered,left);for(auto&r:ranges)free((void*)r.start);return 0;
}
