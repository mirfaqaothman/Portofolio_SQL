# Portofolio_SQL
# Data yang digunakan data 

show tables;
SELECT * FROM `people-2000000`;
rename  table  `people-2000000` to People_50000;
rename table people_50000 to people50k;

select * from people50k;

# ubah nama kolom yang namanya pake space diganti jadi pake '_-
alter table people50k
rename column `job title` to Job_Title;

alter table people50k
rename column `First Name` to First_Name;

alter table people50k
rename column
`Last Name` to Last_Name;

alter table people50k
rename column`Date of birth` to TTL;

alter  table people50k
rename column `User Id` to user_id;

# Menghitung jumlah pekerja berdasarkan job title-nya
select Job_Title, count(*) AS 'Jumlah Pekerja'
from people50k
group by Job_title;

# Mengecek tipe data dari setiap column dari tabel people50k
show create table people50k;

# Mengubah tipe data kolom sex menjadi enum

alter table people50k
modify column sex ENUM ('Female','Male');

# Menghitung Jumlah Female dan Male (perempuan) 
select sex, count(sex) AS 'Jumlah'
FROM people50k group by sex;

# Mengubah jenis data di kolom TLL dari text menjadi DATETIME

alter tablE people50k
modify column TTL DATETIME not null ;
# Menghitung people yang lahir di tahun 1990-2000

select count(TTL) AS 'Jumlah Orang'
FROM people50k where (1990-01-01) between 1990 and 2000
group by sex; #perintah ini ga keluar hasilnya

SELECT TTL FROM people50k LIMIT 10;
SELECT DISTINCT YEAR(TTL) FROM people50k ORDER BY YEAR(TTL);

# Data TTL tetep berjenis string padahal udah di ganti ke datetime 
SELECT TTL, COUNT(TTL) AS 'Jumlah Orang'
FROM people50k 
WHERE YEAR(STR_TO_DATE(TTL, '%Y-%m-%d')) BETWEEN 1990 AND 2000;

# Mencari apakah adanya kolom yang isinya duplikast

select `user id`, count(*) as Jumlah FROM people50k 
GROUP BY `user id` HAVING count(*) > 1;

# Menghapus duplasi dalam hasil query
select distinct user_id FROM people50k;

select * from people50k;

# Menampilkan orang dengan  yang bekerja sebagai techical  brewer
select first_name, job_title FROM people50k
WHERE job_title = 'Technical brewer';

# Menghitung Jumlah orang yang bekerja sebagai Technicl Brewer
select count(*) AS Jumlah_Pekerja_Technical_Brewer
FROM people50k
WHERE job_title = 'Technical Brewer';

#LIMIT
# Menampilkan 20 baris pertama pada tabel people50k
select * from people50k 
limit 20;
# Menampilkan 10 baris pertama dengan melompati 15 baris sebelumnya menggunakan OFFSET
select  first_name, job_tiTle
FROM people50k
LIMIT 10 OFFSET 15;
# Menampilkan 10 orang pertama yang bekerja sebagai Technical Brewer
select first_name, job_title FROM people50k
Where Job_Title= 'Technical Brewer'
LIMIT 10;

# Menampilkan 5 Kota dengan jumlah karyawan dengan job_title yang sama
select Job_Title, count(*) AS Jumlah_Orang
FROM people50k
group by Job_Title
Order by Job_Title Desc
LIMIT 5;


