# Capture Output visibility repair 07

The original File Settings append wrapper remains unchanged. Menu06 skipped the
entire Capture Output subtree when the JPEG coordinator was not ready. Menu07
installs the verified native menu independently of backend readiness. It retains
the exact parent, UI-thread, list and original code guards.

Unavailable backend state is shown explicitly. Both automatic format selection
and manual export still require the real coordinator/capture capability. No fake
success, unconditional mode activation, or loss of the RAW safety path is added.
The existing subtree becomes usable if the backend becomes ready, with no second
allocation or duplicate append. Native menus, six sizes and both card selectors
retain their current ABI and policy06 implementation.

Nine normal plus nine ASan/UBSan cases pass, including construction while not
ready, no backend side effects, transition to ready, no duplicate entry, card
capabilities and unknown completion handling. The same not-ready regression
fails against old menu06. This proves the code defect, not that backend readiness
was the specific missing condition on the user's camera. No device was used.
