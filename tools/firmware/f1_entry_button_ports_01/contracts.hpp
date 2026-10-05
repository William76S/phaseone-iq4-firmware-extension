#pragma once
#include <cstddef>
#include <cstdint>
namespace iq4::f1::entry_ports01 {
inline constexpr bool ProductionEntryEnabled=false;
inline constexpr const char UserSHA[]="9b611efe64067685b770ba3984ae951684c5a401f73f77a03b316be374032cdb";
// These signatures describe this exact native input; no function is invoked
// or resolved here. Original flags retain numeric names where semantics are unknown.
using TextButtonCtor=void(*)(void* storage,std::int32_t width,std::int32_t height,
    void* resource_provider,std::uint32_t font_id,const char* persistent_text,
    std::uint8_t flag6,std::uint32_t value7,std::uint32_t value9_on_stack);
using PopupCtor=void(*)(void* storage,void* manager,void* root,
    std::uint32_t list_width,std::uint8_t flag4);
struct ControlObserverNative {const void* address_point{};};
struct QueueObserverNative {const void* address_point{};void* queue{};const char* persistent_name{};};
static_assert(sizeof(ControlObserverNative)==8&&sizeof(QueueObserverNative)==24);
using ControlObserverCtor=void(*)(ControlObserverNative*);
using QueueObserverCtor=void(*)(QueueObserverNative*,const char*,void* queue);
// Original direct Control callback ABI. Its event pointer is borrowed only
// during this call; QueueObserver's callback has a different two-argument ABI.
using ControlNotification=void(*)(ControlObserverNative*,void* sender,const void* borrowed_event,std::uint32_t tag);
using QueueNotification=void(*)(QueueObserverNative*,void* native_event);
using EventCtor=void(*)(void*,const char* persistent_name);
using Subscribe=void(*)(QueueObserverNative*,void* native_event);
using EventNotify=void(*)(void* native_event);
using ControlBind=void(*)(void* own_control,ControlObserverNative*,std::uint32_t own_tag);
using ControlAttach=void(*)(void* parent,void* own_child,std::int32_t x,std::int32_t y,std::uint32_t flag_a,std::uint32_t flag_b);
using ControlDetach=void(*)(void* own_child);
using Method=void(*)(void*);
using SetMenu=void(*)(void* selector,void* root);
using SetFlag41=void(*)(void* own_control,std::uint8_t);
using CurrentThread=void*(*)();
using SubMenuCtor=void(*)(void*,std::uint32_t title,void* property2,void* property3);
using EventItemCtor=void(*)(void*,std::uint32_t title,void* event,void* enabled_property);
using AppendItem=void(*)(void* own_submenu,void* own_item);
// No constructor, native resolver, actual-ready parameter or enabled create API.
// Runtime metadata/owner/quiescence does not follow from these null slots.
struct Candidates {
    TextButtonCtor text_button_ctor{};PopupCtor own_popup_ctor{};
    ControlObserverCtor control_observer_ctor{};QueueObserverCtor queue_observer_ctor{};
    EventCtor event_ctor{};Subscribe subscribe{},unsubscribe{};EventNotify notify{};
    ControlBind control_bind{};ControlAttach control_attach{};ControlDetach control_detach{};
    SetMenu set_menu{};Method show{},close{};CurrentThread current_thread{};
    SubMenuCtor submenu_ctor{};EventItemCtor item_ctor{};AppendItem append_item{};SetFlag41 set_flag41{};
};
struct EntrySpec {const char* name;std::uintptr_t captured_va;unsigned char first16[16];};
const EntrySpec* static_catalog(std::size_t& count) noexcept;
// Metadata offsets only. They do not establish that a runtime pointer is valid.
inline constexpr std::size_t TextButtonBytes=0xb8,PopupBytes=0x4b8;
inline constexpr std::size_t ManagerResourceWrapper=0x788,LVResourceWrapper=0xf0,WrapperProvider=0x10;
inline constexpr std::size_t Parent=0x8,FirstChild=0x10,PreviousSibling=0x18,NextSibling=0x20;
inline constexpr std::size_t ControlObserver=0x60,ControlTag=0x68;
inline constexpr std::uintptr_t TextButtonVT=0xba6230,PopupVT=0xb931b0,ControlObserverVT=0xb89650,QueueObserverVT=0xc23a98;
// Tree detach clears siblings, retains Parent, and does not delete. No input
// capture/quiescence cancellation contract or hot-unload proof is supplied.
}
