-- ============================================================
-- SOAL KUIS PRAKTIKUM SISTEM BASIS DATA
-- Studi Kasus : Sistem Informasi Penjualan Toko
-- DBMS        : MySQL / MariaDB (XAMPP)
-- Database    : penjualan_putra
-- ============================================================

-- ============================================================
-- 1. MEMBUAT DATABASE DAN TABEL (DDL)
-- ============================================================

CREATE DATABASE IF NOT EXISTS penjualan_putra;
USE penjualan_putra;

-- Hapus tabel lama (urutan: anak dulu, baru induk) agar skrip bisa dijalankan ulang
DROP TABLE IF EXISTS transaksi;
DROP TABLE IF EXISTS produk;
DROP TABLE IF EXISTS pelanggan;

-- Tabel pelanggan
CREATE TABLE pelanggan (
    id_pelanggan    INT PRIMARY KEY,
    nama_pelanggan  VARCHAR(100) NOT NULL,
    alamat          VARCHAR(150),
    no_hp           VARCHAR(15)
);

-- Tabel produk
CREATE TABLE produk (
    id_produk   INT PRIMARY KEY,
    nama_produk VARCHAR(100) NOT NULL,
    harga       DECIMAL(12,2) NOT NULL,
    stok        INT
);

-- Tabel transaksi
CREATE TABLE transaksi (
    id_transaksi      INT PRIMARY KEY,
    id_pelanggan      INT,
    id_produk         INT,
    tanggal_transaksi DATE NOT NULL,
    jumlah            INT NOT NULL,
    CONSTRAINT fk_transaksi_pelanggan
        FOREIGN KEY (id_pelanggan) REFERENCES pelanggan (id_pelanggan),
    CONSTRAINT fk_transaksi_produk
        FOREIGN KEY (id_produk) REFERENCES produk (id_produk)
);

-- ============================================================
-- 2. MENGISI DATA (DML - INSERT)
-- ============================================================

-- Data pelanggan (minimal 5)
INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, alamat, no_hp) VALUES
(1, 'Andi',  'Bandar Lampung', '081234567801'),
(2, 'Budi',  'Metro',          '081234567802'),
(3, 'Citra', 'Pringsewu',      '081234567803'),
(4, 'Deni',  'Pesawaran',      '081234567804'),
(5, 'Eka',   'Bandar Lampung', '081234567805');

-- Data produk (minimal 5)
INSERT INTO produk (id_produk, nama_produk, harga, stok) VALUES
(101, 'Mouse Wireless',   85000.00, 20),
(102, 'Keyboard',        150000.00, 15),
(103, 'Flashdisk 32 GB',  75000.00, 30),
(104, 'Headset',         125000.00, 10),
(105, 'Kabel USB',        25000.00, 40);

-- Data transaksi (minimal 5)
-- Andi (id 1) bertransaksi lebih dari sekali: transaksi 1 dan 3
-- Mouse Wireless (id 101) muncul lebih dari sekali: transaksi 1 dan 4
INSERT INTO transaksi (id_transaksi, id_pelanggan, id_produk, tanggal_transaksi, jumlah) VALUES
(1, 1, 101, '2026-10-01', 2),
(2, 2, 102, '2026-10-02', 1),
(3, 1, 103, '2026-10-03', 3),
(4, 3, 101, '2026-10-04', 1),
(5, 4, 105, '2026-10-05', 4),
(6, 5, 104, '2026-10-06', 2);

-- ============================================================
-- 3. MENAMPILKAN DATA (DML - SELECT)
-- ============================================================

-- 3.1 Menampilkan seluruh data pelanggan
SELECT * FROM pelanggan;

-- 3.2 Menampilkan produk dengan harga di atas Rp100.000
SELECT * FROM produk
WHERE harga > 100000;

-- 3.3 Menampilkan produk dengan stok kurang dari 20
SELECT * FROM produk
WHERE stok < 20;

-- 3.4 Menampilkan transaksi pada tanggal tertentu (contoh: 2026-10-03)
SELECT * FROM transaksi
WHERE tanggal_transaksi = '2026-10-03';

-- 3.5 Menampilkan nama pelanggan, nama produk, tanggal transaksi, dan jumlah barang (JOIN)
SELECT
    p.nama_pelanggan,
    pr.nama_produk,
    t.tanggal_transaksi,
    t.jumlah
FROM transaksi t
JOIN pelanggan p  ON t.id_pelanggan = p.id_pelanggan
JOIN produk    pr ON t.id_produk    = pr.id_produk
ORDER BY t.id_transaksi;

-- ============================================================
-- 4. MENGUBAH DAN MENGHAPUS DATA (DML)
-- ============================================================

-- 4.1 Mengubah alamat pelanggan dengan ID 2 menjadi Bandar Lampung
UPDATE pelanggan
SET alamat = 'Bandar Lampung'
WHERE id_pelanggan = 2;

-- 4.2 Mengubah harga produk dengan ID 103 menjadi Rp80.000
UPDATE produk
SET harga = 80000.00
WHERE id_produk = 103;

-- 4.3 Menambah stok produk dengan ID 101 sebanyak 5 unit
UPDATE produk
SET stok = stok + 5
WHERE id_produk = 101;

-- 4.4 Menghapus salah satu transaksi berdasarkan ID transaksi yang ditentukan (ID = 5)
DELETE FROM transaksi
WHERE id_transaksi = 5;

-- ============================================================
-- 5. MENGUBAH STRUKTUR TABEL (DDL - ALTER TABLE)
-- ============================================================

-- 5.1 Menambahkan kolom email VARCHAR(100) pada tabel pelanggan
ALTER TABLE pelanggan
ADD COLUMN email VARCHAR(100);

-- 5.2 Menambahkan kolom kategori VARCHAR(50) pada tabel produk
ALTER TABLE produk
ADD COLUMN kategori VARCHAR(50);

-- 5.3 Menampilkan struktur tabel setelah perubahan
DESCRIBE pelanggan;
DESCRIBE produk;
DESCRIBE transaksi;

-- ============================================================
-- 6. ANALISIS RELASI TABEL
-- Jawaban lengkap ada pada file: analisis_relasi_tabel.txt
-- ============================================================

-- ============================================================
-- VERIFIKASI HASIL AKHIR
-- ============================================================

-- Struktur tabel pelanggan setelah ALTER
SHOW COLUMNS FROM pelanggan;

-- Struktur tabel produk setelah ALTER
SHOW COLUMNS FROM produk;

-- Data pelanggan setelah update dan ALTER
SELECT * FROM pelanggan;

-- Data produk setelah update dan ALTER
SELECT * FROM produk;

-- Data transaksi setelah delete
SELECT * FROM transaksi;

-- Hasil JOIN akhir
SELECT
    t.id_transaksi,
    p.nama_pelanggan,
    pr.nama_produk,
    t.tanggal_transaksi,
    t.jumlah
FROM transaksi t
JOIN pelanggan p  ON t.id_pelanggan = p.id_pelanggan
JOIN produk    pr ON t.id_produk    = pr.id_produk
ORDER BY t.id_transaksi;
