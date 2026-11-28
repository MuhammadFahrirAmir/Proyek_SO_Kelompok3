scrip/cleanup-chroot.sh

#!/usr/bin/env bash
set -e

apt clean
rm -rf /tmp/* /var/lib/apt/lists/*

Membersihkan cache APT dan file sementara sebelum keluar dari chroot Cubic agar ukuran ISO hasil build lebih ringkas.
