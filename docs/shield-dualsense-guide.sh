#!/system/bin/sh
# Run as root on the Shield (e.g. from the boot runner, once per boot).
# Remaps the DualSense PS button (scancode 316) from BUTTON_MODE, which the
# Shield intercepts as a global Home shortcut, to BUTTON_16. Moonlight
# translates BUTTON_16 from scancode 316 back to the Guide button.
KL=/system/usr/keylayout/Vendor_054c_Product_0ce6.kl
NEW=/data/local/tmp/Vendor_054c_Product_0ce6.kl

# Already applied this boot?
grep -q 'BUTTON_16' "$KL" && exit 0

sed '/^key 316 /d' "$KL" > "$NEW" || exit 1
echo 'key 316   BUTTON_16' >> "$NEW"
chmod 644 "$NEW"
chcon u:object_r:system_file:s0 "$NEW" 2>/dev/null
mount -o bind "$NEW" "$KL"
