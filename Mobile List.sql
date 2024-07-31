SELECT * FROM mobile_list.`mobile analysis`;

SELECT * FROM mobile_list.`mobile analysis`;

-- check mobile features and price list

SELECT Phone_name, Price FROM mobile_list.`mobile analysis`;

-- find out the price of 5 most expensive phones

SELECT Phone_name, Price
FROM mobile_list.`mobile analysis`
order by price desc limit 5;

-- find out the price of 5 most chepest phones

SELECT Phone_name, Price
FROM mobile_list.`mobile analysis`
order by price asc limit 5;

-- List of top 5 samsung phones with price and all features

SELECT * FROM mobile_list.`mobile analysis`
where brands = "Samsung"
order by Price desc limit 5;

-- must have android phone list then top 5 high price android phones

select Phone_name, Price
from mobile_list.`mobile analysis`
where Operating_System_Type = "Android"
order by Price desc Limit 5;

-- must have andorid phone list then top 5 lower price andorid phones

select Phone_name, Price
from mobile_list.`mobile analysis`
where Operating_System_Type = "Android"
order by Price ASC Limit 5;

-- must have IOS phone list then top 5 high price IOS phones

select Phone_name, Price
from mobile_list.`mobile analysis`
where Operating_System_Type = "IOS"
order by Price desc Limit 5;

-- must have IOS phone list then top 5 low price IOS phones

select Phone_name, Price
from mobile_list.`mobile analysis`
where Operating_System_Type = "IOS"
order by Price ASC Limit 5;

-- Write a query which phone support 5g and also top 5 phone with 5g support

select Phone_name, Price
from mobile_list.`mobile analysis`
where 5G_Availability = "yes"
order by Price Desc Limit 5;

-- Total price of all mobile is to be found with brand name

select Brands, sum(Price) 
from mobile_list.`mobile analysis`
group by brands;