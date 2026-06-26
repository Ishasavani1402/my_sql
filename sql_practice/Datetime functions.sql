-- Datetime functions
-- 1.Display the year of each customer’s signup date.
select concat(first_name , " ",last_name) as full_name , year(signup_date)as signed_year from customers;

-- 2.Show the month name of each order date.
select monthname(order_date)  as order_month from orders;

-- 3.Find customers who signed up in the last 6 months.
select concat(first_name , " ",last_name) as full_name , 
signup_date from customers where signup_date >= date_sub(curdate() , interval 6 month) ;

-- 4.Calculate the number of days between order date and delivery date.
select order_id , datediff(delivery_date , order_date) as date_diff from orders;

-- 5.Extract the weekday name of shipped dates.
select dayname(shipped_date) as days from orders;

-- 6.Show all orders placed in February.
select order_id  , order_date from orders where month(order_date) = 2;

-- 7.Add 7 days to each order date and display the result.
select order_id , order_date , date_add(order_date , interval 7 day) add_7_days from orders;

-- 8.Find customers who signed up on a weekend.
SELECT CONCAT(first_name, ' ', last_name) AS full_name,
dayname(signup_date) FROM customers
WHERE DAYOFWEEK(signup_date) IN (1, 7);

-- 9.Calculate the age of each order (difference between today’s date and order date).
select order_date , datediff(curdate() , order_date) from orders;

-- 10.Return the year and quarter for each order date.
select order_id , year(order_date) as order_year , quarter(order_date) as qtr from orders;