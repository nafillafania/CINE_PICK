# CinePick

## Deskripsi Aplikasi

CinePick merupakan aplikasi informasi film berbasis Flutter yang dirancang untuk membantu pengguna mencari dan melihat informasi film dengan mudah. Aplikasi ini menggunakan tema gelap dengan aksen ungu agar tampilan terlihat menarik dan sesuai dengan tema perfilman.

Tujuan pengembangan CinePick adalah menyediakan aplikasi sederhana yang memungkinkan pengguna melihat daftar film, mencari film berdasarkan judul dan genre, melihat informasi detail film, serta menyimpan film favorit.

## Fitur dan Halaman Aplikasi

CinePick memiliki empat halaman utama:

1. **Beranda (Home)**  
   Menampilkan film pilihan dan daftar film populer yang dapat dipilih pengguna untuk melihat informasi lebih lanjut.

2. **Pencarian (Search)**  
   Memungkinkan pengguna mencari film berdasarkan judul dan menyaring daftar film berdasarkan genre.

3. **Detail Film (Movie Details)**  
   Menampilkan informasi film yang dipilih, meliputi poster, judul, rating, tahun rilis, genre, durasi, sinopsis, dan pemeran.

4. **Favorit (Favorites)**  
   Menampilkan daftar film yang telah ditambahkan ke favorit. Pengguna dapat menambahkan atau menghapus film melalui ikon favorit.

## Teknologi yang Digunakan

- **Flutter:** Framework untuk membangun antarmuka aplikasi.
- **Dart:** Bahasa pemrograman yang digunakan dalam pengembangan aplikasi.
- **Data dummy:** Data film disimpan dalam kode program dan digunakan untuk menampilkan informasi tanpa mengambil data dari API.

## Struktur Proyek

- `lib/main.dart` — Mengatur tema aplikasi dan navigasi utama.
- `lib/data/movie_data.dart` — Menyimpan data dummy film.
- `lib/models/movie.dart` — Mendefinisikan model data film.
- `lib/pages/` — Menyimpan halaman Beranda, Pencarian, Detail Film, dan Favorit.
- `lib/widgets/` — Menyimpan widget yang digunakan kembali, seperti kartu film, film unggulan, dan navigasi bawah.



