CREATE TABLE calisma(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);

INSERT INTO calisma VALUES(123456789, 'Ali Seker  ', 'Istanbul', 2500, 'Vakko');


SELECT *
FROM customers 
ORDER BY country ASC, score DESC  --sıralama  DESC 

SELECT * 
FROM customers 
WHERE country = 'Germany'
ORDER BY country ASC, score DESC
OFFSET 2 -- 2 satır atla başla
LIMIT 2  -- ilk 2 sini getirir.


SELECT * 
FROM customers 
WHERE country = 'Germany' -- != <> eşit olmayan herşey
AND score < 400 

SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;

SELECT *
FROM customers
WHERE customer_id IN(1,2,5);

SELECT *
FROM customers
WHERE first_name LIKE '%n'; /* n ile bitenler '__r%' 3. harfi r olanlar
'M%' M ile başlayanlar, '%r%' içinde r harfi olanlar, */

SELECT count(*) AS total_customers,
country 
FROM customers
GROUP BY country
ORDER BY count(*) asc;


SELECT count(*) AS total_score
FROM customers

SELECT SUM(quantity) AS total 
FROM orders;

SELECT avg(score) AS avg_score -- ama burada NULL değerleri ve satırı görmedi.
FROM customers ;

SELECT avg(COALESCE (score,0)) AS avg_score -- NULL değerleri 0 olarak aldı.
FROM customers ;

SELECT concat(first_name, ' ' ,last_name) cust_name_surname
FROM customers 

SELECT upper(first_name) AS buyuk_ad, lower(last_name) AS kucuk_soyad
FROM customers c

SELECT last_name,
length(last_name) AS len_lastname,   -- Trim öncesi uzunluklar
TRIM(last_name) AS clean_lastname,  -- Trim işlemi
LENGTH(TRIM(last_name))AS clean_len_lastname --Trim sonrası uzunluklar

SELECT last_name,
substring(last_name,2,3) AS kesilmis_last_name  -- 2 . harfinden sonra 3 harf al
FROM customers c

-- herbir ülke için en yüksek score getir.
SELECT 
max(score) AS max_score,
country
FROM customers
GROUP BY country
ORDER BY max(score);

--soru :her ülke için toplam müşteri sayısını bulup sadece 1 den fazla olan toplam kişi sayılarını getir
SELECT 
	country,
	count(*) AS musteri_sayi
FROM customers
GROUP BY country
HAVING count(*) > 1 ;

UPDATE customers 
SET country = 'Germany'
WHERE customer_id = 6;

/*örn:
DELETE = satır siler 
TRUNCATE = Tablonun içindeki bilgileri siler.
DROP = tabloyu komple siler.*/

DELETE
FROM customers 
WHERE  customer_id IN(6,7)

TRUNCATE TABLE customers 







