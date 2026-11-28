skrip/setup-xfce-lightdm.sh
#!/usr/bin/env bash
set -e

apt update
apt-add-repository -y universe
apt-add-repository -y multiverse

DEBIAN_FRONTEND=noninteractive apt install -y \
  xfce4 xfce4-goodies lightdm lightdm-gtk-greeter \
  xfce4-terminal network-manager-gnome

echo "lightdm shared/default-x-display-manager select lightdm" | debconf-set-selections
echo "/usr/sbin/lightdm" > /etc/X11/default-display-manager
dpkg-reconfigure -f noninteractive lightdm

apt purge -y ubuntu-desktop gnome-shell gdm3 \
  libreoffice* rhythmbox* thunderbird* \
  aisleriot gnome-mahjongg gnome-mines gnome-sudoku
apt autoremove -y

apt install -y ubiquity ubiquity-frontend-gtk casper

Mengaktifkan repositori universe/multiverse, memasang XFCE dan LightDM,
menjadikannya display manager default, menghapus paket GNOME/bawaan berat,
serta memastikan ubiquity dan casper tetap ada.
