#include "prepare.hpp"
#include "transaction.hpp"
#include <cstdio>
using namespace iq4::f1::hook10;
#define O(T,M) offsetof(T,M)
#ifdef IQ4_F1_HOOK10_LAYOUT_HOST
#define LAYOUT_SECTION __attribute__((used))
#else
#define LAYOUT_SECTION __attribute__((used,section(".rodata.f1_hook10_layout")))
#endif
extern "C" LAYOUT_SECTION const std::uint64_t iq4_f1_hook10_layout[]={sizeof(PreparationInput),O(PreparationInput,provider),sizeof(iq4::f1::normal10::ActualProviderContract),O(iq4::f1::normal10::ActualProviderContract,owner),O(iq4::f1::normal10::ActualProviderContract,provider),O(iq4::f1::normal10::ActualProviderContract,inline_surface_offset),sizeof(PublishedPreparation),sizeof(PreparationMetadata),O(PreparationMetadata,pid_ticks),O(PreparationMetadata,renderer_status),O(PreparationMetadata,input_sha),sizeof(iq4::f1::normal10::Status),sizeof(Contract),O(Contract,prepared_publication),sizeof(Journal),sizeof(Registers),O(Registers,pc)};
#ifdef IQ4_F1_HOOK10_LAYOUT_HOST
int main(){for(unsigned i=0;i<sizeof(iq4_f1_hook10_layout)/8;++i)std::printf("%s%llu",i?",":"[",static_cast<unsigned long long>(iq4_f1_hook10_layout[i]));std::puts("]");}
#endif
