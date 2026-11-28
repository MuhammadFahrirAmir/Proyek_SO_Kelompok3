skrip/setup-plymouth.sh

#!/usr/bin/env bash
set -e

LOGO_SRC="/root/logo.png"
SPLASH_DIR="/usr/share/plymouth/themes/distro-splash"

apt install -y plymouth plymouth-themes linux-image-generic linux-headers-generic

mkdir -p "$SPLASH_DIR"
cp "$LOGO_SRC" "${SPLASH_DIR}/logo-distro.png"
cp /root/tahap1/konfigurasi/distro-splash.plymouth "${SPLASH_DIR}/distro-splash.plymouth"
cp /root/tahap1/skrip/distro-splash.script "${SPLASH_DIR}/distro-splash.script"

# Salinan logo tambahan agar tampil konsisten saat proses boot
cp "$LOGO_SRC" /usr/share/plymouth/ubuntu-logo.png
cp "$LOGO_SRC" /usr/share/plymouth/themes/spinner/watermark.png
cp "$LOGO_SRC" /usr/share/plymouth/themes/spinner/bgrt-fallback.png
cp "$LOGO_SRC" /usr/share/plymouth/themes/bgrt/watermark.png

chmod 644 \
  "${SPLASH_DIR}/logo-distro.png" \
  /usr/share/plymouth/ubuntu-logo.png \
  /usr/share/plymouth/themes/spinner/watermark.png \
  /usr/share/plymouth/themes/spinner/bgrt-fallback.png \
  /usr/share/plymouth/themes/bgrt/watermark.png

update-alternatives --install \
  /usr/share/plymouth/themes/default.plymouth default.plymouth \
  "${SPLASH_DIR}/distro-splash.plymouth" 200

update-alternatives --set default.plymouth \
  "${SPLASH_DIR}/distro-splash.plymouth"

update-initramfs -u -k all

Memasang Plymouth & kernel generic, menyalin logo ke tema distro-splash sekaligus ke file bawaan Ubuntu/spinner/bgrt (agar logo tetap muncul saat booting), mengaktifkan tema,
dan membangun ulang initramfs. (Pastikan /root/logo.png sudah tersedia di chroot).
