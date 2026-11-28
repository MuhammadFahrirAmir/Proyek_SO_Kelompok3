# TROUBLESHOOTING OPENSSH SERVER ARKANODE

## 1. Pendahuluan

OpenSSH Server merupakan salah satu komponen penting dalam proyek ARKANODEOS yang berfungsi menyediakan akses administrasi jarak jauh melalui protokol Secure Shell (SSH). Layanan ini memungkinkan administrator mengelola sistem server melalui jaringan dengan mekanisme komunikasi yang terenkripsi.

Dalam penerapannya, OpenSSH Server dapat mengalami berbagai kendala, baik yang berkaitan dengan layanan, jaringan, autentikasi pengguna, maupun konfigurasi keamanan. Oleh karena itu, diperlukan panduan troubleshooting untuk membantu mengidentifikasi penyebab gangguan dan menentukan langkah penanganan yang sesuai.

Dokumentasi ini disusun sebagai panduan pemecahan masalah OpenSSH Server pada sistem ARKANODEOS.

## 2. Tujuan

Dokumentasi ini memiliki beberapa tujuan:

1. Mengidentifikasi permasalahan yang mungkin terjadi pada OpenSSH Server.
2. Menjelaskan penyebab umum gangguan koneksi SSH.
3. Memberikan langkah penanganan terhadap kesalahan konfigurasi dan autentikasi.
4. Membantu administrator melakukan pemeriksaan ketika layanan SSH mengalami gangguan.
5. Menjaga agar akses administrasi jarak jauh pada ARKANODEOS dapat berjalan dengan baik dan aman.

## 3. Jenis Permasalahan dan Penanganannya

### A. Connection Refused

**Pesan kesalahan:**

```text
ssh: connect to host 192.168.1.10 port 22: Connection refused
```

**Kemungkinan penyebab:**

- Layanan SSH tidak sedang berjalan.
- Server tidak menerima koneksi pada port SSH yang digunakan.
- Konfigurasi SSH mengalami kesalahan.
- Layanan SSH belum berhasil dijalankan.

**Langkah penanganan:**

1. Periksa status layanan SSH.
2. Pastikan layanan SSH sudah aktif.
3. Periksa konfigurasi port pada file `/etc/ssh/sshd_config`.
4. Pastikan tidak terdapat kesalahan konfigurasi.
5. Jalankan ulang layanan SSH setelah perbaikan dilakukan.

Perintah untuk memeriksa konfigurasi:

```bash
sudo sshd -t
```

Jika tidak menampilkan pesan kesalahan, pemeriksaan sintaks konfigurasi berhasil.

Untuk menjalankan ulang layanan:

```bash
sudo systemctl restart ssh
```

### B. Connection Timed Out

**Pesan kesalahan:**

```text
ssh: connect to host 192.168.1.10 port 22: Connection timed out
```

**Kemungkinan penyebab:**

- Server dan komputer klien tidak terhubung ke jaringan yang sesuai.
- Alamat IP server berubah.
- Firewall memblokir koneksi SSH.
- Port SSH tidak dapat dijangkau dari komputer klien.

**Langkah penanganan:**

1. Pastikan komputer klien dapat menjangkau alamat IP server.
2. Periksa kembali alamat IP yang digunakan.
3. Periksa aturan firewall pada server.
4. Pastikan koneksi TCP menuju port SSH tidak diblokir.

Perintah untuk memeriksa aturan firewall UFW:

```bash
sudo ufw status verbose
```

Jika UFW digunakan dan port SSH memang perlu diizinkan, jalankan:

```bash
sudo ufw allow 22/tcp
```

Catatan: Pastikan port yang diizinkan sesuai dengan port SSH yang digunakan pada konfigurasi server.

### C. Permission Denied

**Pesan kesalahan:**

```text
Permission denied (publickey,password).
```

**Kemungkinan penyebab:**

- Nama pengguna yang dimasukkan tidak sesuai.
- Kata sandi yang digunakan salah.
- Autentikasi password dinonaktifkan.
- Kunci publik SSH belum terdaftar dengan benar.
- Hak akses direktori atau file SSH tidak sesuai.

**Langkah penanganan:**

1. Pastikan nama pengguna yang digunakan benar.
2. Periksa metode autentikasi yang diizinkan pada konfigurasi SSH.
3. Jika menggunakan autentikasi kunci, pastikan kunci publik sudah terdaftar pada file `authorized_keys`.
4. Periksa izin akses file dan direktori SSH.

Contoh pengaturan izin akses:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

Perintah tersebut digunakan untuk membatasi akses terhadap direktori SSH dan daftar kunci publik pengguna.

### D. SSH Tidak Dapat Dimulai

**Gejala:**

Layanan SSH gagal dijalankan atau langsung berhenti setelah dijalankan.

**Kemungkinan penyebab:**

- Terdapat kesalahan sintaks pada konfigurasi SSH.
- Port yang digunakan mengalami konflik.
- File konfigurasi mengalami perubahan yang tidak sesuai.
- Komponen OpenSSH Server mengalami masalah.

**Langkah penanganan:**

Periksa validitas konfigurasi:

```bash
sudo sshd -t
```

Periksa informasi layanan:

```bash
sudo journalctl -u ssh -n 50 --no-pager
```

Periksa apakah port 22 sedang digunakan:

```bash
sudo ss -tlnp | grep ':22'
```

Jika ditemukan kesalahan konfigurasi, lakukan perbaikan terlebih dahulu sebelum mencoba menjalankan ulang layanan.

### E. Port SSH Tidak Dapat Diakses

**Gejala:**

Komputer klien tidak dapat terhubung ke port SSH server.

**Kemungkinan penyebab:**

- Port SSH menggunakan nomor yang berbeda dari port default.
- Firewall membatasi akses ke port tertentu.
- Konfigurasi jaringan belum sesuai.

**Langkah penanganan:**

1. Periksa pengaturan `Port` pada `/etc/ssh/sshd_config`.
2. Pastikan firewall mengizinkan port yang digunakan.
3. Periksa port yang sedang didengarkan oleh server.

Contoh pemeriksaan port:

```bash
sudo ss -tlnp
```

Jika port SSH diubah, sesuaikan perintah koneksi dari komputer klien dengan nomor port tersebut.

Contoh:

```bash
ssh -p 2222 nama_pengguna@alamat_ip_server
```

### F. Koneksi SSH Terputus Secara Tiba-Tiba

**Gejala:**

Koneksi SSH terputus ketika administrator sedang mengakses server.

**Kemungkinan penyebab:**

- Koneksi jaringan tidak stabil.
- Server mengalami gangguan.
- Komputer klien mengalami perubahan jaringan.
- Sesi SSH dihentikan karena kondisi tertentu pada server.

**Langkah penanganan:**

1. Periksa kestabilan jaringan.
2. Periksa kondisi server.
3. Periksa catatan aktivitas layanan SSH.
4. Jika diperlukan, lakukan koneksi ulang setelah penyebab gangguan ditangani.

Untuk melihat catatan layanan:

```bash
sudo journalctl -u ssh --since "30 minutes ago"
```

## 4. Pemeriksaan Log SSH

Log merupakan sumber informasi penting untuk mengetahui penyebab kegagalan koneksi maupun masalah autentikasi.

Pada sistem Ubuntu, administrator dapat menggunakan perintah:

```bash
sudo journalctl -u ssh
```

Untuk melihat 50 catatan terakhir:

```bash
sudo journalctl -u ssh -n 50 --no-pager
```

Untuk melihat aktivitas secara langsung:

```bash
sudo journalctl -u ssh -f
```

Informasi log dapat membantu administrator mengetahui waktu terjadinya gangguan, aktivitas autentikasi, serta pesan kesalahan yang dihasilkan layanan SSH.

## 5. Pemeriksaan Keamanan OpenSSH

Selain memastikan layanan berjalan, administrator perlu memperhatikan keamanan akses SSH.

Beberapa langkah yang dapat diterapkan antara lain:

### A. Membatasi Akses Pengguna

Administrator dapat membatasi akun yang diperbolehkan menggunakan SSH melalui pengaturan `AllowUsers` pada file konfigurasi SSH.

Contoh:

```text
AllowUsers administrator
```

Pengaturan tersebut membatasi akses SSH kepada akun yang disebutkan.

### B. Menggunakan Autentikasi Kunci SSH

Autentikasi menggunakan pasangan kunci publik dan privat dapat digunakan sebagai alternatif autentikasi kata sandi.

Kunci publik ditempatkan pada server, sedangkan kunci privat disimpan dengan aman pada komputer klien.

### C. Memeriksa Pengaturan Login Root

Akses login langsung menggunakan akun root dapat dibatasi melalui pengaturan:

```text
PermitRootLogin no
```

Pengaturan ini bertujuan mengurangi risiko akses administratif langsung menggunakan akun root.

**Catatan:** Perubahan pengaturan keamanan harus disesuaikan dengan kebutuhan proyek dan diuji terlebih dahulu. Pastikan masih tersedia akun administrator yang dapat digunakan sebelum menonaktifkan metode login tertentu.

## 6. Prosedur Penanganan Gangguan

Untuk mempermudah proses troubleshooting, administrator dapat mengikuti urutan berikut:

1. Identifikasi pesan kesalahan yang muncul.
2. Tentukan apakah masalah berkaitan dengan layanan, jaringan, autentikasi, atau konfigurasi.
3. Periksa log layanan SSH untuk mendapatkan informasi tambahan.
4. Lakukan pemeriksaan pada bagian yang mengalami gangguan.
5. Terapkan perbaikan sesuai penyebab yang ditemukan.
6. Periksa kembali konfigurasi SSH menggunakan `sshd -t` jika konfigurasi diubah.
7. Jalankan ulang layanan jika diperlukan.
8. Dokumentasikan masalah dan solusi yang telah diterapkan.

## 7. Tabel Ringkasan Troubleshooting

| No. | Permasalahan | Kemungkinan Penyebab | Penanganan |
|---|---|---|---|
| 1 | Connection Refused | Layanan atau port SSH tidak menerima koneksi | Periksa layanan dan konfigurasi port |
| 2 | Connection Timed Out | Gangguan jaringan atau firewall | Periksa konektivitas dan aturan firewall |
| 3 | Permission Denied | Kesalahan autentikasi atau hak akses | Periksa akun, password, dan kunci SSH |
| 4 | SSH Gagal Dimulai | Kesalahan konfigurasi atau konflik port | Periksa sintaks dan log layanan |
| 5 | Port Tidak Dapat Diakses | Port diblokir atau tidak sesuai | Periksa port dan firewall |
| 6 | Koneksi Terputus | Jaringan atau server mengalami gangguan | Periksa jaringan dan log SSH |

## 8. Kesimpulan

Troubleshooting OpenSSH Server merupakan bagian penting dalam pemeliharaan layanan administrasi jarak jauh pada ARKANODEOS. Gangguan seperti kegagalan koneksi, kesalahan autentikasi, konflik port, dan kesalahan konfigurasi dapat ditangani melalui pemeriksaan sistematis terhadap layanan, jaringan, konfigurasi, serta log SSH.

Dengan adanya dokumentasi ini, anggota tim pengembang ARKANODEOS diharapkan memiliki panduan untuk mengidentifikasi dan menangani permasalahan OpenSSH Server secara lebih terstruktur.

Dokumentasi ini bersifat panduan teknis. Penerapan setiap solusi perlu disesuaikan dengan kondisi sistem dan diverifikasi melalui pengujian langsung.
