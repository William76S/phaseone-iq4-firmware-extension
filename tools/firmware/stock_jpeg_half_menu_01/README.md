# Two-choice native JPEG Size

Future53 component replaces the existing Storage Setup JPEG Size child with
exactly 4K and 50%. It retains the original PropertyEnum/DTO/event without changing
their two-value native enum. The producer's independent extended choice is0=4K,
1=50%; native JpegSize stays1. Full RAW to half-width/half-height JPEG is the
producer's responsibility; this menu never implements an IIQ-file decode fallback.

The new `4f0528` wrapper replaces52's wrapper object/hook, while retaining52's
`menu.o` for JPEG Export Mode/Destination. It obtains the replacement before
calling the original append exactly once, then calls the existing after-append
helper with the retained original PropertyEnum. No duplicate Size entry is added.

`Selected` comes only from the real extended-size getter; the setter owns busy,
native-size validation, persistence and source selection. A rejection leaves the
current displayed selection unchanged. A read-only JPEG Quality row displays the
true producer getter value; the53 producer sets4K/Half quality100. Getter failure
leaves the value blank. There is no Ready/status/debug row.

The component builds with unresolved genuine producer APIs in `half.h`, never a
production stub. Host fixtures use explicit test-only producer state. Integration
requires the matching53 producer implementation before it can link or run. No53
firmware, card write, camera control or hardware acceptance occurs here.
