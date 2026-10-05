#include "../f1_normal_fit_display_08/provider.hpp"
using namespace iq4::f1::normal08;
constexpr auto S=offsetof(PublishedIngress,metadata);
constexpr auto W=S+offsetof(IngressStatus,last);
constexpr auto G=W+offsetof(WriteFacts,geometry);
static_assert(sizeof(PublishedIngress)==496&&sizeof(IngressStatus)==328&&sizeof(WriteFacts)==296&&sizeof(Geometry)==144);
static_assert(S==8&&W==40&&G==120&&offsetof(PublishedIngress,raw)==336);
static_assert(S+offsetof(IngressStatus,result)==16&&S+offsetof(IngressStatus,emitted)==20&&S+offsetof(IngressStatus,normal_returns)==24&&S+offsetof(IngressStatus,serial)==32);
static_assert(W+offsetof(WriteFacts,paint_serial)==104&&W+offsetof(WriteFacts,geometry_epoch)==112);
static_assert(G+offsetof(Geometry,rotation)==128&&G+offsetof(Geometry,source_rectangle)==132&&G+offsetof(Geometry,clipped_source_rectangle)==148&&G+offsetof(Geometry,image_viewport)==164);
static_assert(G+offsetof(Geometry,display_bounds)==180&&G+offsetof(Geometry,clip)==196&&G+offsetof(Geometry,scale)==212&&G+offsetof(Geometry,normal_fit_scale)==216);
static_assert(G+offsetof(Geometry,pan)==220&&G+offsetof(Geometry,pan_animation)==228&&G+offsetof(Geometry,config_width)==232&&G+offsetof(Geometry,original_locked_roi)==248);
static_assert(W+offsetof(WriteFacts,stock_clean_coverage)==264&&W+offsetof(WriteFacts,present_target)==280&&W+offsetof(WriteFacts,getter_words)==288&&W+offsetof(WriteFacts,present_words)==312&&W+offsetof(WriteFacts,getter_words_read)==328&&W+offsetof(WriteFacts,present_words_read)==332);
static_assert(offsetof(PublishedIngress,raw)+offsetof(RawWriteObservation,normal_original_return)==480&&offsetof(PublishedIngress,raw)+offsetof(RawWriteObservation,mask_enabled)==492);
extern "C" const unsigned long long iq4_f1_loader08_layout[]={sizeof(PublishedIngress),S,W,G,offsetof(PublishedIngress,raw)};
