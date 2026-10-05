#include "../f1_scaler_hook_install_11/provider.hpp"
using namespace iq4::f1::normal10;
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
extern "C" const unsigned long long iq4_f1_loader10_layout[]={sizeof(PublishedIngress),S,W,G,offsetof(PublishedIngress,raw)};

#include "../f1_scaler_hook_install_11/prepare.hpp"
#include "transaction.hpp"
using namespace iq4::f1::hook10;
static_assert(sizeof(PreparationInput)==472&&offsetof(PreparationInput,provider)==160);
static_assert(sizeof(ActualProviderContract)==312&&offsetof(ActualProviderContract,owner)==208&&offsetof(ActualProviderContract,provider)==248&&offsetof(ActualProviderContract,inline_surface_offset)==304);
static_assert(sizeof(PublishedPreparation)==192&&offsetof(PublishedPreparation,metadata)==8&&sizeof(PreparationMetadata)==184);
static_assert(offsetof(PreparationMetadata,pid_ticks)==32&&offsetof(PreparationMetadata,renderer_status)==104&&offsetof(PreparationMetadata,input_sha)==112);
static_assert(sizeof(Contract)==960&&offsetof(Contract,pid_ticks)==16&&offsetof(Contract,own_executable)==96&&offsetof(Contract,own_executable_count)==224);
static_assert(offsetof(Contract,module_path)==228&&offsetof(Contract,state_dir)==388&&offsetof(Contract,proc_version_sha)==548&&offsetof(Contract,root_receipt_sha)==613&&offsetof(Contract,provider_receipt_sha)==678&&offsetof(Contract,off_clean_receipt_sha)==743);
static_assert(offsetof(Contract,prepared_publication)==808&&offsetof(Contract,prepared_generation)==816&&offsetof(Contract,preparation_receipt_sha)==824&&offsetof(Contract,prepared_input_sha)==889);
