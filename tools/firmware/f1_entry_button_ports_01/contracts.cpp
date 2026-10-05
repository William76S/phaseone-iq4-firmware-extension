#include "contracts.hpp"
#include "entries.hpp"
namespace iq4::f1::entry_ports01 {
const EntrySpec* static_catalog(std::size_t& count) noexcept {
    count=sizeof(Entries)/sizeof(Entries[0]);return Entries;
}
}
