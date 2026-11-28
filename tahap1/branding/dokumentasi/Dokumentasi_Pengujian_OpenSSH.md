# DOKUMENTASI PENGUJIAN OPENSSH SERVER ARKANODEOS

## 1. Pendahuluan

OpenSSH Server merupakan layanan yang digunakan untuk menyediakan akses jarak jauh (remote access) ke sistem Linux melalui protokol Secure Shell (SSH). Dalam proyek ARKANODEOS, OpenSSH Server berperan sebagai salah satu komponen pendukung administrasi server agar pengelolaan sistem dapat dilakukan melalui jaringan secara aman.

Dokumentasi ini disusun untuk menjelaskan tahapan pemeriksaan, konfigurasi dasar, dan pengujian layanan OpenSSH Server pada lingkungan ARKANODEOS.

## 2. Tujuan

Dokumentasi pengujian ini memiliki beberapa tujuan, yaitu:

1. Memastikan paket OpenSSH Server tersedia pada sistem.
2. Memeriksa status layanan SSH.
3. Mengetahui cara mengaktifkan layanan SSH.
4. Memeriksa alamat IP server yang digunakan.
5. Menjelaskan prosedur pengujian koneksi SSH dari komputer klien.
6. Mengetahui fungsi OpenSSH Server dalam mendukung administrasi jarak jauh ARKANODEOS.

## 3. Persiapan Pengujian

Sebelum melakukan pengujian, beberapa kebutuhan yang harus disiapkan adalah:

- Sistem ARKANODEOS atau lingkungan Ubuntu Linux sebagai server.
- Paket OpenSSH Server.
- Komputer klien yang terhubung ke jaringan yang sama dengan server.
- Akun pengguna yang memiliki izin untuk mengakses server.
- Terminal untuk menjalankan perintah pengujian.

## 4. Tahapan Pemeriksaan dan Pengujian

### A. Memeriksa Instalasi OpenSSH Server

Untuk memastikan paket OpenSSH Server telah terpasang, jalankan perintah:

```bash
dpkg -l openssh-server
```

Perintah tersebut digunakan untuk melihat informasi paket OpenSSH Server yang terpasang pada sistem.

### B. Memeriksa Status Layanan SSH

Jalankan perintah berikut:

```bash
sudo systemctl status ssh
```

Perintah ini digunakan untuk mengetahui kondisi layanan SSH. Jika layanan berjalan dengan baik, statusnya akan menunjukkan `active (running)`.

### C. Mengaktifkan Layanan SSH

Jika layanan belum berjalan, gunakan perintah:

```bash
sudo systemctl enable --now ssh
```

Perintah tersebut berfungsi untuk menjalankan layanan SSH sekaligus mengaktifkannya secara otomatis ketika sistem dinyalakan.

### D. Memeriksa Alamat IP Server

Untuk mengetahui alamat IP server, jalankan:

```bash
hostname -I
```

Alamat IP yang ditampilkan digunakan sebagai tujuan koneksi dari komputer klien.

### E. Melakukan Pengujian Koneksi SSH

Pada komputer klien, buka terminal dan jalankan:

```bash
ssh nama_pengguna@alamat_ip_server
```

Ganti `nama_pengguna` dengan nama akun pada server dan `alamat_ip_server` dengan alamat IP yang diperoleh sebelumnya.

Jika koneksi berhasil, pengguna akan diminta melakukan autentikasi sesuai konfigurasi SSH server.

## 5. Aspek yang Diamati

Beberapa aspek yang perlu diperhatikan selama pengujian meliputi:

1. Keberadaan paket OpenSSH Server pada sistem.
2. Kondisi layanan SSH setelah diaktifkan.
3. Ketersediaan alamat IP server.
4. Kemampuan komputer klien menjangkau server.
5. Keberhasilan proses autentikasi pengguna.
6. Kemampuan mengakses terminal server dari jarak jauh.

## 6. Hasil Pengujian

Bagian ini diisi berdasarkan hasil pengujian yang benar-benar dilakukan pada sistem.

| No. | Aspek Pengujian | Hasil |
|---|---|---|
| 1 | Pemeriksaan paket OpenSSH Server | Belum diuji |
| 2 | Pemeriksaan status layanan SSH | Belum diuji |
| 3 | Aktivasi layanan SSH | Belum diuji |
| 4 | Pemeriksaan alamat IP server | Belum diuji |
| 5 | Pengujian koneksi dari klien | Belum diuji |

## 7. Kesimpulan

OpenSSH Server merupakan komponen penting dalam mendukung pengelolaan ARKANODEOS sebagai sistem operasi berbasis server. Melalui layanan SSH, administrator dapat melakukan akses dan pengelolaan sistem dari perangkat lain melalui jaringan.

Tahapan pemeriksaan dan pengujian dalam dokumentasi ini dapat digunakan sebagai panduan untuk memastikan layanan OpenSSH Server telah dikonfigurasi dan berfungsi sesuai kebutuhan proyek.

Hasil akhir pengujian perlu dilengkapi berdasarkan pelaksanaan langsung pada lingkungan ARKANODEOS.
