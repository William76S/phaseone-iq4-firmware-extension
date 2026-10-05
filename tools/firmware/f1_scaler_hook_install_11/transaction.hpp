#pragma once
#include <cstddef>
#include <cstdint>
#include "module_identity.hpp"
namespace iq4::f1::hook10 {
using Address=std::uint64_t;
constexpr std::size_t max_threads=128;
constexpr Address entry=0x47f910;
constexpr std::uint64_t original_pair=0xa9057bfdd10403ffULL;
struct Range {Address begin{},end{};};
struct Thread {std::uint32_t tid{};std::uint64_t ticks{};};
struct Registers {std::uint64_t x[31]{},sp{},pc{},pstate{};};
static_assert(sizeof(Registers)==272&&offsetof(Registers,pc)==256);
struct Snapshot {Thread threads[max_threads]{};std::uint32_t count{};};
enum class Operation:std::uint32_t {Install=1,Restore=2};
enum class Phase:std::uint32_t {Prep=0,Acquiring,StoppedVerified,WriteIntent,InstalledStopped,RestoredStopped,Detaching,Detached,Hold};
// Receipt hashes identify Root's actual, independently reviewed inputs. They
// are not accepted as proof merely because 64 hex characters were supplied.
// The Root controller embeds them only after its actual preparation/recovery
// review. No enabled contract is generated in this offline source package.
struct Contract {
 std::uint32_t schema{10},pid{},ui_tid{},kernel_profile{};
 std::uint64_t pid_ticks{},user_dev{},user_ino{},module_dev{},module_ino{};
 Address module_bias{},near_page{},near_bytes{},own_bridge{},trampoline_slot{};
 Range own_executable[8]{};std::uint32_t own_executable_count{};
 char module_path[160]{},state_dir[160]{};
 char proc_version_sha[65]{},root_receipt_sha[65]{},provider_receipt_sha[65]{},off_clean_receipt_sha[65]{};
 // Prepared on the live UI before any stop. Not an invitation to call target
 // code while stopped: pointer/veneer/trampoline bytes are only read back.
 Address prepared_publication{};std::uint64_t prepared_generation{};
 char preparation_receipt_sha[65]{},prepared_input_sha[65]{};
};
struct Journal {
 std::uint32_t schema{10};Phase phase{Phase::Prep};Operation operation{};
 std::uint32_t pid{},tid_count{},attached_count{},detached_count{};
 std::uint64_t pid_ticks{},before{},after{},write_attempts{},restore_attempts{};
 Thread threads[max_threads]{};Registers registers[max_threads]{};
 bool write_may_have_happened{},original_restored{},all_stopped{},exited{};
};
struct Ops {
 void* context{};
 bool(*identity)(void*,const Contract&,Operation)noexcept{};
 bool(*list)(void*,const Contract&,Snapshot&)noexcept{};
 bool(*seize)(void*,std::uint32_t)noexcept{};
 bool(*interrupt_and_wait)(void*,std::uint32_t)noexcept{};
 bool(*registers)(void*,std::uint32_t,Registers&)noexcept{};
 bool(*read_pair)(void*,std::uint32_t,Address,std::uint64_t&)noexcept{};
 bool(*poke_pair)(void*,std::uint32_t,Address,std::uint64_t)noexcept{};
 bool(*save)(void*,const Journal&)noexcept{};
 bool(*detach)(void*,std::uint32_t)noexcept{};
};
bool fixed_contract(const Contract&)noexcept;
bool patched_pair(const Contract&,std::uint64_t&)noexcept;
// Never calls target code, modifies registers, resumes a stopped target to run
// a cache helper, changes mprotect, or detaches after a partial/unknown failure.
class Transaction {
public:
 explicit Transaction(Ops ops)noexcept:ops_(ops){}
 bool stop(const Contract&,Operation)noexcept;
 bool write_once(const Contract&)noexcept;
 bool restore_after_failed_install(const Contract&)noexcept;
 bool detach_ordered(const Contract&)noexcept;
 const Journal&journal()const noexcept{return journal_;}
private:
 bool persist(Phase)noexcept;
 bool hold()noexcept;
 bool stable(const Contract&)noexcept;
 bool pc_allowed(const Contract&,const Registers&)const noexcept;
 Ops ops_{};Journal journal_{};bool detached_[max_threads]{};
};
}
