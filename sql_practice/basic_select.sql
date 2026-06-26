-- basic select
-- 1.List every record from the customers table.
select * from customers;

-- 2.Show the unique states where customers are located, sorted alphabetically.
select distinct state from customers order by state ASC;

-- 3.Return the first 10 customers as they appear in the table.
select concat(first_name , ' ' ,last_name) as full_name  from customers limit 10;

-- 4.Find customers whose age is greater than 35.
select concat(first_name , ' ' ,last_name) as full_name from customers where age > 35;     

-- 5.List customers whose first name starts with the letter ‘A’.
select first_name from customers where first_name like "A%";

-- 6.Show customers whose email address uses the ‘gmail.com’ domain.
select email from customers where email like "%gmail.com";

-- 7.Retrieve customers who registered in the year 2024.
select concat(first_name , ' ' ,last_name) as full_name , year(signup_date) from customers where year(signup_date) = "2024";

-- 8.Return customers whose age is between 20 and 30 (inclusive).
select concat(first_name , ' ' ,last_name) as full_name , age from customers where age between "20" and "30";

-- 9.List customers who live in any of these cities: Mumbai, New Delhi, Bengaluru, or Jaipur.
select concat(first_name , ' ' ,last_name) as full_name , city from customers where city in("Mumbai","New Delhi","Bengaluru","Jaipur");

-- 10.List customers who do not live in these cities: Mumbai, New Delhi, Bengaluru, or Jaipur.
select concat(first_name , ' ' ,last_name) as full_name , city from customers where city not in("Mumbai","New Delhi","Bengaluru","Jaipur");

-- 11.Show the 5 oldest customers, from oldest to youngest.
select concat(first_name , ' ' ,last_name) as full_name , age from customers order by age desc limit 5 ;

-- 12,Show the 5 youngest customers, from youngest to oldest.
select concat(first_name , ' ' ,last_name) as full_name , age from customers order by age asc limit 5 ;

-- 13.Find customers whose phone number starts with ‘9’.
select concat(first_name , ' ' ,last_name) as full_name , phone from customers where phone like "9%" ;

-- 14.Return all orders placed in the year 2025.
select order_id , year(order_date) from orders where year(order_date) = "2025";
select order_id , order_date from orders where order_date >="2025-01-01" and order_date < "2026-01-01";  

-- 15.List products priced between 10,000 and 50,000, ordered from highest to lowest price.
select product_name , price from products where price between "10000" and "500000" order by price desc;









