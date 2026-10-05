# Ratio Mask opacity candidate06

Only original LiveView Settings owns Ratio Mask; the Grid menu hook is removed. Eight choices: Off / Native, XPan65:24,16:9,3:2,1:1,4:5,6:7,21:9. Nested native Opacity has21 choices0–100 in5 percent steps. Percent is black opacity:0 clear,100 black,default65. Nine diagnostic rows follow. Startup Off/65; neither setting persists across reboot.

Uses original SubMenu/EventItem constructors and complete native vtables with owned text/value/activate overrides. One original menu BL and one display BL are changed; exact Configure Grid call bytes stay stock. Display16 preserves candidate05 requested-pair and actual-write clipping. No file, security, RAW/JPEG or video hooks are added.

## Rebuild

Use absolute compiler and input paths from a fresh source root:

```sh
python3 -B tools/firmware/f1_stock_menu_04/build.py \
  --output build/ratio_mask_rebuild_new \
  --zig /absolute/path/to/zig-aarch64-macos-0.15.2/zig \
  --stock /absolute/path/to/P1Linux_6.03.21.bin \
  --original-fwr /absolute/path/to/Firmware-BP-IQ4-IQ4_6.03.18.fwr \
  --original-fwp /absolute/path/to/XFSystem8.02.0.fwp
```

Output must be a fresh directory inside the source root. The build checks locked source/dependency SHA256, original User, exact native ABI windows and compiler; compiles four AArch64 objects, links real User/init/EH and packages User-only FWP. It never runs target or SDK.

```sh
python3 -B tools/firmware/f1_stock_menu_04/validate_host.py --output build/ratio_mask_host_new
```

Native callback strings fit64/32 character buffers, including NUL. E3 denotes transparent opacity after valid geometry, with no fill. E2 means native fill calls returned, not hardware visibility or FPS. Scalar diagnostics may span frames. Integer alpha round-to-nearest keeps65 percent identical to candidate05 alpha166. All21 UI values, source isolation, exact band geometry and retained original479-row write footprint are host tested. Original340 init order and all legacy EH entries must remain.

Experimental versions P1Linux6.03.27 / IQ6.03.24 / System8.02.6. New payload has not been hardware accepted. Corresponding marker eraseblock original and independent failed-User restore remain unverified; source/host/package checks do not establish safe install or recovery.
