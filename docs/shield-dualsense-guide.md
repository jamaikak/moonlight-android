# NVIDIA Shield with a DualSense controller

## Problem

Shield firmware treats `KEYCODE_BUTTON_MODE` as a system "go Home" shortcut, whatever app is in front. The DualSense PS button is mapped to `BUTTON_MODE` in `/system/usr/keylayout/Vendor_054c_Product_0ce6.kl` (`key 316 BUTTON_MODE`), so pressing it leaves the stream. Removing the mapping stops that, but then Moonlight never sees the button and can't send Guide to the host.

## Fix

1. The key layout maps scancode 316 to `BUTTON_16`, which the Shield doesn't intercept.
2. Moonlight (`ControllerHandler.handleRemapping`) turns `BUTTON_16` with scancode 316 from a Sony device back into `BUTTON_MODE`, so it reaches the host as Guide.

You need this fork's app build and root on the Shield (to bind-mount over a file in `/system`).

## Applying it

[`shield-dualsense-guide.sh`](shield-dualsense-guide.sh) copies the device's key layout without the `key 316` line, appends `key 316   BUTTON_16`, and bind-mounts the result over the original. `/system` itself isn't modified.

```
adb push docs/shield-dualsense-guide.sh /data/local/tmp/
adb shell sh /data/local/tmp/shield-dualsense-guide.sh   # as root
adb shell grep 316 /system/usr/keylayout/Vendor_054c_Product_0ce6.kl
```

The last command should print `key 316   BUTTON_16`. Reconnect the controller afterwards. The script is safe to run more than once.

## Persistence

A bind mount doesn't survive a reboot. Run the script as root from whatever runs at boot on your device.

## Reverting

`umount /system/usr/keylayout/Vendor_054c_Product_0ce6.kl` as root (repeat if it was mounted more than once), or reboot if the script isn't in your boot runner.
