create schema  cars;
use cars;

-- READ DATA --

select*from car_dekho;

-- Total Cars: to get a count of total records --

select count(*) from car_dekho;


-- The manager asked the employee How many car avilable in 2023 --

select count(*) from car_dekho where year = 2023;


-- the manager asked the employee How many car avilable in 2020,2021,2022 --

select*from car_dekho;
select count(*) from car_dekho where year in (2020,2021,2022) group by year;


-- client asked me to print the total of all cars by year. i dont sea a all details -- 
select year, count(*) from car_dekho group by year;


-- clent asked to car dealars agent How many Diesel Cars will there be in 2020 --
select*from car_dekho;
select count(*) from car_dekho where year = 2020 and fuel = "Diesel" ;


-- clent requesting car dealers agent how many petrol car in 2020 --

select count(*) from car_dekho where year =2020 and fuel = "Petrol"


-- Manger told the employee to give print of all fuel car (petrol deisel and cng) come all by year

select year, count(*) from car_dekho where fuel = "Diesel" group by year;
select year, count(*) from car_dekho where fuel = "Petrol" group by year;
select year, count(*) from car_dekho where fuel = "Diesel" group by year;
select year, count(*) from car_dekho where fuel = "CNG" group by year;


-- manager said there whore more then 100 cars in a given year, which year had more then 100 cars -- 

select year,count(*) from car_dekho group by year having count(*)>100;

-- the manger said to employee all car count details between 2015 and 2023 we need a complet list -- 

select count(*) from car_dekho where year between 2015 and 2023;

-- the manager said to employee all cars details between 2015 to 2023 we need a complet list -- 
select*from car_dekho where year between 2015 and 2023;
