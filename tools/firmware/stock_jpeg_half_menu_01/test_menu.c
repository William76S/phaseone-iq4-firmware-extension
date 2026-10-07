#include <assert.h>
#include <stdlib.h>
#include "menu.c"
static unsigned allocations,ctors,appends,fail_alloc,fail_ctor,fail_append,bad_pin;
static unsigned stage=100,busy,save_failure,unbound,set_calls;
static uint32_t selected,actual_quality=100;
static void *owned[12];static unsigned owned_count;
static unsigned char queue_mem[0x200],manager_mem[32];static uintptr_t actual_queue;
static void store(void *p,size_t off,uintptr_t v){memcpy((char *)p+off,&v,8);}
uint32_t iq4_extensions_installation_stage_02(void){return stage;}
int iq4_native_self_read_01(void *ctx,uintptr_t p,void *out,size_t n){
    (void)ctx;
    for(unsigned i=0;i<sizeof MenuPins01/sizeof *MenuPins01;++i){
        const struct MenuPin01 *pin=MenuPins01+i;
        if(p>=pin->va&&p+n<=pin->va+pin->bytes){
            memcpy(out,pin->data+p-pin->va,n);
            if(bad_pin&&p==pin->va)((unsigned char *)out)[0]^=1;
            return 1;
        }
    }
    if(p<0x100000000ULL)return 0;
    memcpy(out,(void *)p,n);return 1;
}
int iq4_f4_native_current_02(uintptr_t *out){*out=actual_queue;return 1;}
int iq4_f4_menu_new_03(size_t bytes,void **out){
    if(++allocations==fail_alloc){*out=0;return 1;}
    *out=calloc(1,bytes);assert(*out&&owned_count<12);owned[owned_count++]=*out;return 1;
}
int iq4_f4_menu_ctor_03(uintptr_t ctor,void *p){
    (void)p;if(++ctors==fail_ctor)return 0;
    assert(ctor==0x4e5744||ctor==0x4e9d30);return 1;
}
int iq4_f4_menu_append_03(void *root,void *item){
    if(++appends==fail_append)return 0;
    assert(root==size_menu&&(item==size_items[0]||item==size_items[1]||item==quality_item));return 1;
}
int iq4_stock_jpeg_extended_size_get_02(uint32_t *choice){
    if(unbound)return 0;*choice=selected;return 1;
}
int iq4_stock_jpeg_extended_size_set_02(uint32_t choice){
    assert(choice<2);++set_calls;if(busy||save_failure||unbound)return 0;
    selected=choice;return 1;
}
int iq4_stock_jpeg_quality_get_02(uint32_t *quality){
    if(unbound)return 0;*quality=actual_quality;return 1;
}
int main(int argc,char **argv){
    if(argc==3){unsigned n=(unsigned)atoi(argv[2]);
        if(!strcmp(argv[1],"alloc"))fail_alloc=n;
        else if(!strcmp(argv[1],"ctor"))fail_ctor=n;
        else if(!strcmp(argv[1],"append"))fail_append=n;
        else assert(0);
    }
    unsigned char root[0x118]={0},original[0x38]={0},dto[312]={0};
    store(root,0,0xb8f9b8);uint32_t title=389;memcpy(root+0x14,&title,4);
    store(original,0,0xb8fd40);store(original,0x18,(uintptr_t)dto);store(dto,0,0xbbf3f8);
    store(queue_mem,0,0xb91f48);store(queue_mem,0x1c8,(uintptr_t)manager_mem);
    store(manager_mem,0,0xb8f358);store(manager_mem,8,(uintptr_t)queue_mem);
    actual_queue=(uintptr_t)queue_mem;
    if(argc==2){
        if(!strcmp(argv[1],"stage"))stage=20;
        else if(!strcmp(argv[1],"pin"))bad_pin=1;
        else if(!strcmp(argv[1],"title")){title=391;memcpy(root+0x14,&title,4);}
        else if(!strcmp(argv[1],"ui"))store(manager_mem,8,0);
        else if(!strcmp(argv[1],"dto"))store(dto,0,0);
        else assert(0);
    }
    unsigned char original_copy[sizeof original],dto_copy[sizeof dto];
    memcpy(original_copy,original,sizeof original);memcpy(dto_copy,dto,sizeof dto);
    void *child=iq4_stock_jpeg_size_child_02(root,original,0x4f052c);
    assert(!memcmp(original_copy,original,sizeof original)&&!memcmp(dto_copy,dto,sizeof dto));
    if(argc>1){assert(child==original&&!saved_parent);assert(argc==2?allocations==0:held==1);}
    else{
        assert(child==size_menu&&saved_parent==(uintptr_t)root&&allocations==4&&ctors==4&&appends==3);
        assert(iq4_stock_jpeg_size_child_02(root,original,0x4f052c)==child&&allocations==4);
        assert(iq4_stock_jpeg_size_child_02(root,original,0)==original);
        char b[40];assert(!strcmp(menu_name(size_menu,b,sizeof b),"JPEG Size"));
        for(unsigned i=0;i<2;++i){
            assert(activate(size_items[i])==1&&selected==i);
            assert(!strcmp(item_name(size_items[i],b,sizeof b),labels[i]));
            assert(!strcmp(menu_value(size_menu,b,sizeof b),labels[i]));
            assert(!strcmp(item_value(size_items[i],b,sizeof b),"Selected"));
            assert(!strcmp(item_value(size_items[1-i],b,sizeof b),""));
        }
        assert(!strcmp(item_name(quality_item,b,sizeof b),"JPEG Quality"));
        assert(!strcmp(item_value(quality_item,b,sizeof b),"100"));
        unsigned quality_count=set_calls;assert(!activate(quality_item)&&set_calls==quality_count);
        actual_quality=90;assert(!strcmp(item_value(quality_item,b,sizeof b),"90"));actual_quality=100;
        busy=1;assert(!activate(size_items[0])&&selected==1);
        assert(!strcmp(menu_value(size_menu,b,sizeof b),"50%"));busy=0;
        save_failure=1;assert(!activate(size_items[0])&&selected==1);save_failure=0;
        unbound=1;assert(!activate(size_items[0])&&selected==1);
        assert(!strcmp(menu_value(size_menu,b,sizeof b),""));
        assert(!strcmp(item_value(size_items[1],b,sizeof b),""));unbound=0;
        actual_queue=0;unsigned count=set_calls;assert(!activate(size_items[0])&&set_calls==count);
        actual_queue=(uintptr_t)queue_mem;assert(!activate(original));
        char tiny[2]={'x','x'};item_name(size_items[1],tiny,sizeof tiny);assert(tiny[1]==0);
    }
    for(unsigned i=0;i<owned_count;++i)free(owned[i]);return 0;
}
