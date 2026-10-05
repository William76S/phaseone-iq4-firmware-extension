# F1 display revision14: configuration-domain correction and observations

Corrects the proven domain mismatch in revision13: full ROI is checked against configuration dimensions, while the locked Image is checked against actual output pixel dimensions. Configuration and pixels must retain the same exact aspect ratio. All LCD classification, source/destination separation, packing, rotation, normal zoom, projection and full-write clipping checks remain.

Adds bounded native-menu diagnostics through iq4_f1_report_14. No file, SDK, network, calibration or security access. Build and validate with menu02 build.py / validate_host.py. The combined menu02 SOURCE_SHA256.json freezes this source.

Counts represent callback invocations and returned native fill calls, not FPS or visible display acceptance. Detailed facts are only captured after the native LCD object and all read addresses pass the original classification. Unknown early rejection publishes no details. The independent scalar values are diagnostic snapshots; while LV is active they are not a guaranteed coherent frame transaction.
