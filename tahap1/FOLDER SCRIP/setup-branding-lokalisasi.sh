#!/usr/bin/env bash
set -e

# Branding /etc/os-release
cat << 'EOF' > /etc/os-release
PRETTY_NAME="ARKANODEOS"
NAME="ARKANODEOS"
VERSION_ID="22.04"
VERSION="22.04.5 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
EOF

# Branding /etc/lsb-release
cat << 'EOF' > /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="ARKANODEOS"
EOF

# Zona waktu dan locale
ln -sf /usr/share/zoneinfo/Asia/Makassar /etc/localtime
echo "Asia/Makassar" > /etc/timezone
locale-gen en_US.UTF-8 id_ID.UTF-8
update-locale LANG=en_US.UTF-8

# Skrip first-login
mkdir -p /usr/local/bin /etc/skel/.config/autostart
cat << 'EOF' > /usr/local/bin/first-login.sh
#!/bin/bash
FLAG="$HOME/.first_login_done"
if [ ! -f "$FLAG" ]; then
  xfce4-terminal --hold -e "bash -c 'echo Selamat datang di ARKANODEOS!; uname -a; echo Konfigurasi awal berhasil dijalankan.'"
  touch "$FLAG"
fi
EOF
chmod +x /usr/local/bin/first-login.sh

cp /root/tahap1/konfigurasi/first-login.desktop \
  /etc/skel/.config/autostart/first-login.desktop
