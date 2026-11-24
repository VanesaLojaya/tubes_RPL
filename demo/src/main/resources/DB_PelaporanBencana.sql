-- Inisialisasi
CREATE DATABASE ampun_db

-- USE ampun_db

--DROP TABLE IF EXISTS admin;
--DROP TABLE IF EXISTS Petugas;
--DROP TABLE IF EXISTS Pelapor;
--DROP TABLE IF EXISTS Instansi_Pembantu;
--DROP TABLE IF EXISTS Kelurahan;
--DROP TABLE IF EXISTS Kecamatan;
--DROP TABLE IF EXISTS Jenis_Bencana;
--DROP TABLE IF EXISTS Pertolongan;
--DROP TABLE IF EXISTS Berita;
--DROP TABLE IF EXISTS Data_Korban;
--DROP TABLE IF EXISTS Laporan;
--DROP TABLE IF EXISTS Wilayah;
--DROP TABLE IF EXISTS Provinsi;
--GO


-- tabel2  referensi
CREATE TABLE Provinsi (
	Id_Provinsi INT not null Primary key,
	Nama_Provinsi varchar(100) not null
);

CREATE TABLE Wilayah (
	Id_Provinsi INT references Provinsi(Id_Provinsi),
	-- FOREIGN KEY (Id_provinsi) REFERENCES Provinsi(Id_Provinsi)
	Id_Wilayah INT NOT NULL PRIMARY KEY,
	Nama_Wilayah VARCHAR(100) NOT NULL,
	Jenis_Wilayah VARCHAR(20) NOT NULL CHECK (Jenis_Wilayah IN ('Kabupaten', 'Kota')),
	-- Jenis_Wilayah enum ('Kabupaten', 'Kota') not null
);

CREATE TABLE Kecamatan (
	Id_Wilayah int foreign key references Wilayah (Id_Wilayah),
	Id_Kecamatan INT not null Primary key,
	Nama_Kecamatan varchar(100) not null
);

CREATE TABLE Kelurahan (
	Id_Kecamatan INT references Kecamatan(Id_Kecamatan),
	Id_Kelurahan INT NOT NULL PRIMARY KEY,
	Nama_Subwilayah VARCHAR(100) NOT NULL,
	Jenis_Subwilayah VARCHAR(10) NOT NULL CHECK (Jenis_Subwilayah IN ('Kelurahan', 'Desa'))
);

CREATE TABLE Bencana (
	Id_Bencana int not null primary key,
	Nama_Bencana varchar (50) not null,
	Jenis_Bencana VARCHAR(20) NOT NULL CHECK (Jenis_Bencana IN ('Bencana alam', 'Bencanan Non-alam'))
);

CREATE TABLE Instansi_Pembantu (
	Id_Instansi int not null primary key,
	Nama_Instansi varchar (100) not null
);

CREATE TABLE Data_Korban (
	Id_Data int not null primary key,
	Korban_Luka int,
	Korban_Menghilang int,
	Korban_Jiwa int
);

CREATE TABLE Pertolongan (
	Id_Pertolongan int not null primary key,
	Jumlah_Pakaian int,
	Jumlah_Obat int,
	Jumlah_Makanan int
);

CREATE TABLE Pelapor (
	NIK char(16) not null primary key,
	Username varchar(100) not null,
	Nomor_Telepon varchar(20) not null,
	Pass varchar(255) not null
);

CREATE TABLE Admin (
	Id_Admin char(4) not null primary key,
	Nama varchar (100) not null,
	Username varchar (100) not null,
	Pass varchar (255) not null
);

CREATE TABLE Petugas (
	Id_Petugas char(4) not null primary key,
	Nama varchar(100) not null,
	Nomor_Telepon varchar(20) not null,
	Domisili varchar (50) not null,
	Pass varchar(100) not null,
	Is_SubAdmin char(1) NOT NULL CHECK (Is_SubAdmin IN ('0', '1'))
	-- 0 adalah false dan 1 adalah true
);

CREATE TABLE Laporan (
	Id_Laporan int not null primary key,
	NIK char(16) not null foreign key references Pelapor (NIK),
	Id_Bencana int not null foreign key references Bencana (Id_Bencana),
	Id_Kelurahan int not null foreign key references Kelurahan (Id_Kelurahan),
	Id_Pertolongan int not null foreign key references Pertolongan (Id_Pertolongan),
	Id_Data int not null foreign key references Data_Korban (Id_Data),

	Waktu_Kejadian time not null,
	Waktu_Laporan time not null,
	Tanggal_Kerjadian date not null,
	Status_Verifikasi varchar(20) NOT NULL CHECK (Status_Verifikasi IN ('Menunggu Verifikasi', 'Valid', 'Tidak Valid')),
	Status_Penanganan varchar(20) NOT NULL CHECK (Status_Penanganan IN ('Belum ditangani', 'Sedang ditangani', 'Selesai'))
);

CREATE TABLE Berita (
	Id_Berita int not null primary key,
	Judul_Berita varchar (100),
	Id_Laporan int foreign key references Laporan (Id_Laporan)
);

--  Transaction table
--CREATE TABLE (
	
--);

-- Master data


-- Data transaksi
