select * from  unclean_customer_data;

##1. Mengecek data yang duplikat
select Customer_id, count(*) AS Count
From  unclean_customer_data
group by customer_id
HAVING COUNT(*)>1;

# Menghapus Data di customer_id yang duplikat, yang dipake cuman baris paling awal aja
WITH CTE AS ( SELECT customer_ID, ROW_NUMBER() 
OVER (PARTITION BY customer_ID ORDER BY (SELECT NULL)) AS row_num
FROM unclean_customer_data)
DELETE FROM unclean_customer_data 
WHERE customer_ID IN (SELECT customer_ID FROM CTE WHERE row_num > 1);

select * from unclean_customer_data;

#2. ANNUAL_INCOME (SKEWED DISTRIBUTION)

START TRANSACTION;

SELECT 
    (SUM(POWER(Annual_Income - (SELECT AVG(Annual_Income) FROM unclean_customer_data), 3)) /
     ((SELECT COUNT(*) FROM unclean_customer_data) * POWER((SELECT STDDEV(Annual_Income) FROM unclean_customer_data), 3))) 
    AS skewness
FROM unclean_customer_data;
ROLLBACK;

# 3. Spending_Score (Unnormalized)
# Cek Minimal dan Maksimal pada Kolomnya

select MIN(Spending_Score) AS Min_Value,
		MAX(Spending_Score) AS MAX_VALUES
FROM unclean_customer_data;

# Cek Distribusi (Mean dan Std Dev)
Select AVG(Spending_Score) AS Mean_Value,
	STDDEV(Spending_Score) AS std_dev
FROM unclean_customer_data;

select * from unclean_customer_data;


SELECT * FROM unclean_customer_data 
WHERE customer_ID IS NULL OR customer_ID = ''
   OR Age IS NULL OR Age = ''
   OR Annual_Income IS NULL OR Annual_Income = ''
   OR spending_score IS NULL OR spending_score = ''
   OR Purchase_Frequency IS NULL OR Purchase_Frequency = '';

# Mengecek berapa banyak data Purchase_Frequency yang jumlah nul atau 0

select Purchase_Frequency, COUNT(*) AS Count
FROM unclean_customer_data
WHERE Purchase_Frequency IS NULL OR Purchase_Frequency= ''
GROUP BY Purchase_Frequency;

# Menghapus data jika hasilnya 0 maka Tidak Valid

DELETE FROM unclean_customer_data
WHERE Purchase_Frequency IS NULL OR Purchase_Frequency= '';

SELECT * FROM unclean_customer_data;

# Mengecek Transaction_Amount (With noise & missing values)
select Transaction_Amount, COUNT(*) AS Count
FROM unclean_customer_data
WHERE Transaction_Amount IS NULL OR Transaction_Amount= ''
GROUP BY Transaction_Amount;
