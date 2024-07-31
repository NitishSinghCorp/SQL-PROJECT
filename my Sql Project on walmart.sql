SELECT * FROM salesdatawalmart.sales;

-------- Feature Engineering -----
SELECT
 TIME,
 (CASE
WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
ELSE "EVENING"
END
 ) AS time_of_date
 FROM sales; 
 
 ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
 
 UPDATE sales
 SET time_of_day = (
CASE
WHEN time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
WHEN time BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
ELSE "EVENING"
END
 );
 
 -- day_name --
 SELECT
date,
DAYNAME(DATE)
FROM sales;
------ i remove alter code because of previeus use --
 
 UPDATE sales
 SET day_name = DAYNAME(date);
 
 -- months_name
 SELECT
 date,
 MONTHNAME(date)
 from sales;
 
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales
SET month_name = MONTHNAME(date);

-- -------------------------------------------------------------------------------------------------------
-- -------------------------------------------Geniric QuestioN-----------------------------------------------
-- How many unique cities does the data have?
SELECT
 DISTINCT city
 From sales;
 
 
--  In which city is each branch?
SELECT
 DISTINCT branch
 From sales;
 
 
-- ---------------------------------------------------------------------
-- ------------------Product--------------


-- How many unique product lines does the data have?
SELECT
count(DISTINCT product_line)
FROM sales;


-- What is the most common payment method?
SELECT payment,
COUNT(payment)
FROM sales
GROUP BY payment;


-- What is the most selling product line? -- 
SELECT product_line,
count(product_line) AS cnt
FROM sales group by product_line
ORDER BY cnt DESC;


-- What is the total revenue by month? --
SELECT
month_name AS month,
SUM(total) AS total_revenue
FROM sales GROUP BY month_name
ORDER BY total_revenue DESC;


-- What month had the largest COGS? --
SELECT 
month_name AS month,
SUM(cogs) AS total_cogs
FROM sales 
GROUP BY month_name
ORDER BY total_cogs DESC;


-- What product line had the largest revenue? --
SELECT product_line,
SUM(total) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue? --
SELECT city,
SUM(total) AS total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;


-- What product line had the largest VAT? --
SELECT product_line,
AVG(VAT) AS avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;


-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales --
SELECT *
FROM sales;

-- Which branch sold more products than average product sold? --
SELECT branch,
SUM(quantity) AS qty
FROM sales
GROUP BY branch
HAVING SUM(QUANTITY) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender? --
SELECT 
gender,
product_line,
COUNT(gender) AS total_product_line
FROM sales
GROUP BY gender, product_line
ORDER BY total_product_line DESC;


-- What is the average rating of each product line? --
SELECT 
 AVG(rating) AS avg_rating,
 product_line
 FROM sales
 GROUP BY product_line
 ORDER BY avg_rating DESC;
 
