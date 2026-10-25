# Fork changes

Everything below is on top of upstream Artemis (`moonlight-noir` branch).

## Foldable and desktop-mode support

**Match screen size** (Settings, Video, `list_match_screen_scale`)
Streams at 100, 75, 67 or 50% of the current screen or window size, in multiples of 8 with the long side capped at 4096. The stream restarts when the window shape changes: folding or unfolding a foldable, rotating, or resizing a desktop-mode window. When on, it replaces the fixed video resolution setting. The default is off.

**Tabletop mode**
When a foldable is half open with a horizontal hinge, the stream shrinks to the half above the hinge. The lower half becomes a trackpad with the on-screen keyboard (capped at 60% of the lower half). With Match screen size on, the stream is resized to that area. Fold state comes from Jetpack WindowManager. The window draws under the display cutout so the stream fills the top half.

**Desktop (freeform window) mode**
The stream no longer captures the mouse, so the Android cursor can leave the window. `Ctrl+Alt+Shift+F` or the game menu entry "Toggle Window Fullscreen" hides the system bars and title bar.

## Phone touchpad

A second launcher icon, "Moonlight Touchpad", opens the touchpad and keyboard screen while a stream runs on an external monitor. The screen opens on the phone display even if launched from a desktop-mode monitor.

## Controllers

On Sony devices, a key event with scancode 316 and keycode `BUTTON_16` is treated as the Guide button. This pairs with a custom key layout on NVIDIA Shield. See [shield-dualsense-guide.md](shield-dualsense-guide.md).

## Build and CI

- GitHub Actions builds the `nonRoot_game` debug APK on demand ([building.md](building.md)).
- Debug builds are signed with a fixed, public keystore (`app/fork-debug.keystore`) so every build installs as an update over the last one.
