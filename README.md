# Cloth Mask Vending Machine Assembly

Proyek Akhir SBK - 02 oleh Kelompok BeagleBoneBlack
  1. Haidar Hanif       (1806148694)
  2. Ivan Widjanarko    (1806148706)
  3. Jonathan Elloy     (1806148712)
  4. M. As’ad Muyassir  (1806199953)

## Latar Belakang

<p align="justify">       Pada tahun 2020, pandemi virus COVID-19 merajalela di seluruh belahan bumi, termasuk di Indonesia. Dilansir dari https://covid19.go.id, hingga tanggal 11 Mei 2020 pukul 16.21 WIB (Waktu Indonesia bagian Barat), masyarakat Indonesia yang telah dinyatakan positif mencapai 14.265 penduduk, di mana jumlah masyarakat yang sembuh adalah 2.881 penduduk dan jumlah masyarakat yang meninggal adalah 991 penduduk. Untuk mengatasi hal ini, pemerintah Indonesia berusaha memutus mata rantai penyebaran virus COVID-19 dengan menerapkan beberapa hal, seperti Physical Distancing, Self Isolation, serta PSBB (Pembatasan Sosial Berskala Besar). Selain itu, masyarakat juga dianjurkan untuk menjaga kebersihan diri, rajin mencuci tangan, hindari memakan daging mentah, dan memakai masker kain ketika bepergian keluar rumah. </p>
<p align="justify">       Mengetahui hal ini, tugas proyek akhir mata kuliah Sistem Berbasis Komputer – 02 untuk program Studi Teknik Komputer, Departemen Teknik Elektro, Fakultas Teknik, Universitas Indoensia diharuskan berkaitan dengan tindakan pencegahan, pemantauan, pengendalian, atau perawatan baik untuk pasien, masyarakat umum bukan pasien, lingkungan, dan sebagainya. Melalui proyek akhir ini, kelompok kami diminta untuk merancang hardware dan software sebuah sistem embedded sederhana dengan memanfaatkan MCU 8051 (atau keluarganya) dan mengimplementasikan program tersebut dengan menggunakan bahasa Assembly. Pada akhirnya, kelompok kami memutuskan untuk membuat suatu program vending machine (mesin penjual otomatis) masker kain dengan bahasa Assembly dan memanfaatkan software Proteus untuk mensimulasikan program tersebut. </p>

## Deskripsi Proyek

<p align="justify">       Dalam proyek akhir ini, kami berusaha untuk menerapkan beberapa topik kuliah terkait, seperti The 8051 Microcontroller & Hardware Connection, 8051 Assembly Language Programming, Jump, Loop and Call Instructions, I/O Port Programming, 8051 Addressing Modes, Arithmetic & Logic Instructions, Timer Programming, serta Serial Programming [2]. Input dari mesin vending machine ini adalah nomor NPM pembeli masker yang akan dimasukkan oleh pembeli dengan Matrix Keypad. Untuk outputnya, vending machine ini memiliki 3 buah perangkat keras output, yaitu 16X2 LCD, LED Dot Matrix, dan Servo Motor. 16X2 LCD dan LED Dot Matrix akan menampilkan informasi apakah pembeli berhasil mendapatkan masker kain atau tidak. Sementara itu, Servo Motor akan menggerakan masker kain, sehingga masker tersebut bisa diperoleh dan digunakan oleh pembeli dari vending machine tersebut untuk mencegah penularan virus COVID-19. </p>
<p align="justify">       Langkah-langkah pembelian masker kain dengan vending machine ini adalah sebagai berikut. Pertama, pembeli akan memasukkan NPM dengan menggunakan Matrix Keypad. Input pembeli tersebut akan diperiksa dan dicocokkan dengan data yang ada di dalam ROM. Jika input yang dimasukkan oleh pembeli sama dengan data yang ada di dalam ROM, maka Servo Motor motor akan digerakkan dan masker akan diterima oleh pembeli. Selain itu, terdapat juga  tulisan yang menandakan bahwa masker berhasil diperoleh pada 16X2 LCD serta simbol O pada LED Dot Matrix. Jika input yang dimasukkan oleh pembeli tidak sama dengan data yang ada di dalam ROM, maka akan terdapat tulisan yang menandakan bahwa input pembeli salah pada 16X2 LCD serta simbol X pada LED Dot Matrix. Penjelasan lebih lengkapnya akan dijelaskan pada bagian Skematik Rangkaian. </p>

## Flowchart

![alt text](https://github.com/IvanWidjanarko/Cloth-Mask-Vending-Machine-Assembly-/blob/master/Cloth%20Mask%20Vending%20Machine%20Flowchart.jpg)

## Skematik Rangkaian

![alt text](https://github.com/IvanWidjanarko/Cloth-Mask-Vending-Machine-Assembly-/blob/master/Cloth%20Mask%20Vending%20Machine%20Schematic.jpg)

<p align="justify">       Cara kerja Cloth Mask Vending Machine tersebut adalah sebagai berikut. Pertama, LCD akan menampilkan pesan 'SALAM,MAHASISWA!' di baris pertama dan ‘START!’ di baris kedua. Kemudian, tampilan LCD akan di-clear-kan dan menampilkan 'MASUKAN NPM:' pada baris pertama dan siap menampilkan input pembeli di baris kedua. Pembeli akan memasukkan NPM dengan menggunakan Matrix Keypad. Jika tidak ada input, maka program akan terus menunggu hingga terdapat input. </p>
<p align="justify">       Input dari pembeli tersebut akan ditampilkan pada LCD, lalu diperiksa dan dicocokkan dengan data yang ada di dalam ROM. Jika input yang dimasukkan oleh pembeli sama dengan data yang ada di dalam ROM, maka Servo Motor motor akan digerakkan dan masker akan diterima oleh pembeli. Selain itu, terdapat juga pesan ‘SILAHKAN AMBIL' pada LCD serta simbol O pada LED Dot Matrix. Servo Motor akan dikembalikan ke posisi semula, dan siap menggerakkan masker lagi nantinya. Jika input yang dimasukkan oleh pembeli tidak sama dengan data yang ada di dalam ROM, maka akan terdapat pesan ‘NPM SALAH' pada LCD serta simbol X pada LED Dot Matrix. Pada kondisi ini, Servo Motor tidak akan bergerak sama sekali. Setelah proses ini, maka pembeli dapat membeli lagi masker dengan memasukkan NPM. Program akan terus berjalan dan akan direset jika tombol / pin RST ditekan. </p>

## Source Code

Untuk code dari program kami ini, dapat diakses dari https://bit.ly/Proyek_SBK02_BeagleBoneBlack_Code

## Video Presentasi

Untuk video presentasi dari program kami ini, dapat diakses dari https://bit.ly/Proyek_SBK02_BeagleBoneBlack_Video

<iframe width="420" height="315"
src="https://www.youtube.com/embed/N-QcJWBDcuQ">
</iframe> 

## Laporan Proyek Akhir

Untuk laporan proyek akhir kami, dapat diakses dari https://bit.ly/Proyek_SBK02_BeagleBoneBlack_Laporan
