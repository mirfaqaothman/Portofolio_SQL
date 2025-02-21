# Membuat Tabel Customer/Pembeli
Create Table Customers(
id_customer int not null auto_increment,
nama_customer varchar (100) not null,
email_customer varchar (100) not null,
Nomor_Telepon varchar(20) not null,
alamat varchar(200) not null,
username varchar(30) not null,
password varchar(50) not null,
status text,
keterangan text,
primary key (id_customer)) engine = innodb;

select * from Customers;

# Membuat Tabel Products

CREATE TABLE Products (
    id_Product INT NOT NULL AUTO_INCREMENT,
    nama_Product VARCHAR(100) NOT NULL,
    deskripsi_Product TEXT,
    Kategori_Product VARCHAR(50),
    Jumlah_Stok_Product INT DEFAULT 0,
    Gambar VARCHAR(255),
    Status ENUM('Tersedia', 'Habis', 'Pre-Order') NOT NULL DEFAULT 'Tersedia',
    Keterangan TEXT,
    PRIMARY KEY (id_Product)
) ENGINE = InnoDB;
select * from Products;

# Karena lupa buat kolom untuk Harga Product, maka menambahkan kolom baru untuk harga product
ALTER TABLE Products 
ADD Harga DECIMAL(10,2) NOT NULL DEFAULT 0.00; 

# Membuat Tabel Order

CREATE TABLE Orders (
    id_Order INT NOT NULL AUTO_INCREMENT,
    id_Customer INT NOT NULL, -- Foreign key ke tabel Customer
    id_product INT NOT NULL,
    Tanggal Timestamp default current_timestamp,
    Status ENUM('Pending', 'Diproses', 'Selesai', 'Dibatalkan') NOT NULL DEFAULT 'Pending',
    Keterangan TEXT, -- Opsional untuk deskripsi tambahan
    Stok INT NOT NULL, -- Jumlah stok produk yang dipesan
    PRIMARY KEY (id_Order),
    FOREIGN KEY (id_Customer) REFERENCES Customers(id_Customer) ON DELETE CASCADE,
    FOREIGN KEY (id_product) REFERENCES Products(id_product) ON DELETE CASCADE
) ENGINE = InnoDB;
 

# Ada kolom yang ketinggalan yaitu Total Harga, jadi tambahin kolom baru

ALTER TABLE Orders
ADD Total_Harga DECIMAL(10,2) NOT NULL DEFAULT 0.00; 
select * from Orders;

# Membuat Tabel Detail
CREATE TABLE Detail(
	id_detail INT NOT NULL AUTO_INCREMENT,
    id_Order INT NOT NULL,
    id_Product INT NOT NULL,
    Quantity int not null,
    Sub_Total INT NOT NULL,
    Catatan TEXT,
    PRIMARY KEY (id_detail),
    FOREIGN KEY (id_Order) REFERENCES Orders(id_Order) ON DELETE CASCADE,
    FOREIGN KEY (id_product) REFERENCES Products(id_Product) ON DELETE CASCADE
    )ENGINE = InnoDB;
select * from Detail;

# Membuat Tabel Konfirmasi
CREATE TABLE Konfirmasi_Pembayaran (
    id_Konfirmasi INT NOT NULL AUTO_INCREMENT,
    id_Order INT NOT NULL,
    Tanggal Timestamp default current_timestamp ,
    Nama_Bank VARCHAR(100) NOT NULL,
    Nominal DECIMAL(10,2) NOT NULL, -- Menyimpan nominal pembayaran
    Status ENUM('Menunggu', 'Dikonfirmasi', 'Ditolak') NOT NULL DEFAULT 'Menunggu',
    Keterangan TEXT,
    Bukti_Bayar VARCHAR(255), -- Menyimpan path atau URL bukti pembayaran
    PRIMARY KEY (id_Konfirmasi),
    FOREIGN KEY (id_Order) REFERENCES Orders(id_Order) ON DELETE CASCADE
) ENGINE = InnoDB;
select * from Konfirmasi_Pembayaran;


## PROSES PEMBUATAN TABEL SUDAH SELESAI
# Masukan Data untuk Uji Coba

# 1. Memasukan Data di Tabel Customer
insert into customers( nama_customer, email_customer, Nomor_Telepon, alamat, username, password)
values ('Ucup Surucup', 'ucupsurucup@gmail.com', '089538765812', 'Jl. Ahmad Yani NO 1', 'ucupkeren', 'ucup123'),
		('Rudi Sarudi', 'RudiSarudiR@gmail.com', '088876397281', 'Jl. Ir Soekartno NO 2', 'rudikeren', 'Rudi123'),
        ('Viwy Puteri', 'ViwyPuteri@gmail.com', '081231234518', 'Jl. Gajah Mada NO 3', 'ViwyPuteri', 'Viwy123'),
        ('Ikmal Mauzaki', 'IkmalMauzaki@gmail.com', '083214566544', 'Jl. Bima Sakti No 4', 'IkmalMauzaki', 'ikmal123'),
        ('Neng Handini', 'NengHandini@gmail.com', '0845612365478', 'Jl. Kera Sakti', 'NengHandiri', 'Neng123');
 select * From Customers;
 
 # 2. Memasukan Data di Tabel Products
 insert into Products (Nama_Product, Deskripsi_Product, Kategori_Product, Jumlah_Stok_Product, Status, Harga)
 Value ( 'Toner Pegagan', 'Untuk Kulit Berjerawat, Digunakan setelah cuci muka, 100ml', 'skincare', 100, 'Tersedia', 100000),
	('Serum Pegagan', 'Untuk Kulit Berjerawat, Digunakan setelah toner, 50ml', 'skincare', 100, 'Tersedia', 110000),
    ('Moist Pegagan', 'Untuk Kulit Berjerawat, Digunakan setelah serum, 50ml', 'skincare', 100, 'Tersedia',125000),
    ('Sabun Mandi Mawar', 'Sabun Mandi aroma mawar, 500ml', 'bodycare', 150, 'Tersedia', 25000),
    ('Body Lotion Mawar', 'Body Lotio7 aroma mawar, 750ml', 'bodycare', 500, 'Tersedia',30000),
    ('Sampo Ketombe', 'Sampo untuk mengatasi Ketombe, 800ml', 'haircare', 170, 'Tersedia',22000),
	('Masker Rambut', 'Maker Rambut untuk semua masalah, 50ml', 'haircare', 170, 'Tersedia',9000);
select * From Products;
DELETE FROM Products WHERE id_Product = 1;
DELETE FROM Products WHERE id_Product = 2;
DELETE FROM Products WHERE id_Product = 3;
DELETE FROM Products WHERE id_Product = 4;
DELETE FROM Products WHERE id_Product = 5;
DELETE FROM Products WHERE id_Product = 6;
DELETE FROM Products WHERE id_Product = 7;
## Menguji Query Untuk Mengecek Relasi Pada Table 

# 1. Masukan Data pada tabel Order
insert into Orders( id_Customer,id_product, stok, Status, Total_Harga)
values (1, 8 ,1,'Selesai', 100000),
		(2, 14,2,'Selesai', 18000),
		(3,9, 1,'Selesai', 110000),
        (4,10, 1,'Selesai', 125000),
        (5, 12,1,'Selesai', 30000);
select * from orders;
# 2.Mengecek data pelanggan yang pernah melakukan Order
SELECT Customers.nama_customer, Orders.id_Order, Orders.Tanggal, Orders.Status
FROM Orders
JOIN Customers ON Orders.id_Customer = Customers.id_customer;

#kurang memasukan id_product di tabel order, jadi buat lagi tapi hapus dulu tabelnya
DROP table orders;
SET FOREIGN_KEY_CHECKS = 0;  -- Matikan sementara FK
DROP TABLE Orders;           -- Hapus tabel
SET FOREIGN_KEY_CHECKS = 1;  -- Aktifkan kembali FK

select * from detail;

# 2. Masukan data pada tabel detail
insert into Detail( id_order, id_product, quantity, sub_total, catatan)
VALUES ( 1, 8, 1, 100000, 'Yang rapih ya bungkusnya'),
		( 2,14, 2, 18000, 'semangat ya kak'),
        (3,9,1,110000, 'tutup nama produknya ya'),
        (4, 10, 1, 125000, 'Kasih bonus kalau ada ya'),
        (5,12,1,30000, 'Nyampe sebelum februari ya');
select * FROM detail;

			### Mengecek relasi antar table ###

SELECT Customers.nama_customer, Orders.id_order, Detail.id_detail
FROM Detail
JOIN Orders ON Detail.id_Order = Orders.id_Order
JOIN Customers ON Orders.id_Customer = Customers.id_customer;

## Menambah orderan ke table orders
insert into ORDERS ( id_Customer,id_product, stok, Status, Total_Harga)
Values (1,14,2,'Selesai', 18000),
	(2,10, 1,'Selesai', 100000);
select * from orders;
## Menambahkan data pada table detail
insert into Detail ( id_order, id_product, quantity, sub_total, catatan)
values( 8, 14, 2, 18000, 'ga ada catatan'),
		(9, 10, 1, 125000, 'tolong jangan sampe bocor');
# KARENA DATA JADI DOUBLE MANA DILAKUKAN PENGHAPUSAN PADA TABLE DETAIL
DELETE FROM Detail WHERE id_Detail IN (15, 16);

-- Menampilkan nama produk yang di beli bersama dengan nama customernya, serta ordernya bagaimana dan detailnya seperti apa
select products.nama_product, customers.nama_customer, orders.id_order, detail.id_detail
FROM Detail
JOIN Orders ON detail.id_order = Orders.id_order
JOIN Customers ON Orders.id_customer = Customers.id_customer
JOIN Products ON detail.id_product = Products.id_product;
        
# Karena salah membuat tipe data untuk table konfirmasi, maka hapus dulu table nya
drop table konfirmasi_pembayaran;
# scroll ke atas terus ganti tipe datanya

## Masukan Data ke table Konfirmasi Pembayaran

insert into Konfirmasi_Pembayaran ( id_order, Nama_Bank, Nominal)
Values (1, 'Mandiri', 100000),
		( 2, 'BCA', 18000),
        (3, 'BSI', 110000),
        (4, 'BCA', 125000),
        (5, 'BCA', 30000),
        (6, 'Mandiri', 18000),
        (7,  'Mandiri', 100000);
select * From Konfirmasi_Pembayaran;

# Mengecek relasi antar tabel
SELECT 
    Products.nama_product, 
    Customers.nama_customer, 
    Orders.id_order, 
    Detail.id_detail,
    Konfirmasi_Pembayaran.id_Konfirmasi, 
    Konfirmasi_Pembayaran.nama_bank
FROM Orders -- Kenapa menggunakan Tabel ORDERS? karena pusat relasinya ada di tabel Orders
-- Menghubungkan Orders dengan Customers (karena setiap pesanan punya pelanggan)
JOIN Customers ON Orders.id_customer = Customers.id_customer
-- Menghubungkan Orders dengan Detail (karena setiap pesanan punya banyak detail)
JOIN Detail ON Detail.id_order = Orders.id_order
-- Menghubungkan Detail dengan Products (karena setiap detail berisi produk yang dipesan)
JOIN Products ON Orders.id_product = Products.id_product
-- Menghubungkan Orders dengan Konfirmasi_Pembayaran (karena pesanan bisa memiliki pembayaran)
JOIN Konfirmasi_Pembayaran ON Orders.id_order = Konfirmasi_Pembayaran.id_order;

select * from orders;
select * from Konfirmasi_Pembayaran;
select * from Customers;

## Menampilkan Customer yang belum pernah melakukan ORDER

insert into Customers (nama_customer, email_customer, Nomor_Telepon, Alamat, Username, Password)
VALUES ('Fahri Umar', 'Fahriumar@gamil.com', '081786298365', 'Jl. Lagadar Raya No.D27', 'Fahriumar', 'Fahri123'),
		('Nuzulul Hafizoh', 'NuzululHafizoh@gamil.com', '081685375865', 'Jl. Lagadar Raya No.D27', 'Nuzulul', 'Nuzul123');

SELECT Customers.id_customer, Customers.nama_customer, Customers.email_customer
FROM Customers
LEFT JOIN Orders ON Customers.id_customer = Orders.id_customer
WHERE Orders.id_order IS NULL;

		### Aggregation Functions (SUM, COUNT, AVG, MAX, MIN) ###

# 1. SUM 
select SUM(Total_Harga) AS Total_Dari_Order
FROM Orders
Where Status = 'selesai';

select SUM(Nominal) AS Total_Pendapatan
FROM Konfirmasi_Pembayaran
Where status = 'Dikonfirmasi';

Update Konfirmasi_Pembayaran
set status = 'Dikonfirmasi'
where id_konfirmasi IN (5, 6,7);

update Konfirmasi_Pembayaran
SET status = 'Ditolak'
Where id_konfirmasi = 2;

SELECT SUM(nominal) AS Total_Pembayaran_Ditolak
FROM Konfirmasi_Pembayaran
WHERE STATUS = 'Ditolak';

#2. COUNT
-- Menghitung Jumlah id_Customer yang mendaftar di Toko Online
SELECT COUNT(id_Customer) AS Jumlah_Customer
FROM Customers;
-- Menghitung Jumlah id_Product yang ada 
SELECT COUNT(id_product) AS Jumlah_Macam_Product
FROM Products;
-- Menghitung Jumlah Pesanan per Customer
Select Customers.nama_customer,COUNT(Orders.id_order) AS Jumlah_Pesanan
FROM Orders
JOIN Customers ON Orders.id_customer = Customers.id_customer
Group by Customers.id_Customer;
-- Menghitung Jumlah Pembayaran yang sudah terkonfirmasi
SELECT COUNT(*) AS Pembayaran_Terkonfirmasi
FROM Konfirmasi_Pembayaran
WHERE status = 'Dikonfirmasi';

-- Menampilkan Customer yang sudah melakukan 2 atau lebih order

SELECT Customers.nama_customer,COUNT(Orders.id_order) AS Jumlah_Pesanan
FROM Orders
JOIN Customers ON Orders.id_customer = Customers.id_customer
Group by Customers.id_customer
HAVING Jumlah_Pesanan >= 2;

# 3. Order by
SELECT nama_product, Jumlah_Stok_Product
FROM Products
ORDER BY Jumlah_Stok_Product ASC; -- ASC untuk urutan naik, DESC untuk turun

#Menampilkan semua produk yang pernah dipesan oleh pelanggan dengan nama 'Ucup Surucup'
SELECT DISTINCT Products.nama_product 
FROM Products
JOIN Detail ON Products.id_product = Detail.id_product
JOIN Orders ON Detail.id_order = Orders.id_order
JOIN Customers ON Orders.id_customer = Customers.id_customer
WHERE Customers.nama_customer = 'Ucup Surucup';

# Menampilkan semua produk yang paling banyak dipesan

SELECT Products.nama_product, COUNT(Detail.id_product) AS total_dipesan
FROM Products
JOIN Detail ON Products.id_product = Detail.id_product
GROUP BY Products.id_product
ORDER BY total_dipesan DESC
LIMIT 1;


