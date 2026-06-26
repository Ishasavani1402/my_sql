use boat_sales;
select * from customers;
select * from order_details;
select * from orders;
select * from products;
select * from returns;

-- basic level
-- Q1. List all customers from the state of Gujarat. 
select concat(first_name , " " , last_name) as full_name from customers where state = "Gujarat";
select * from customers where state = "Gujarat";

-- Q2. Show all unique product categories available in the store.
select distinct category as unique_category  from products;

-- Q3. Get the top 10 most expensive products, showing only product name, category, and price. Sort by price descending.
select product_name , category , price from products order by price desc limit 10;

-- Q4. Find all orders that were cancelled. Display order_id, order_date, and payment_method.
select order_id , order_date , payment_method from orders where order_status = "Cancelled" order by order_date;

-- Q5. Count the total number of customers in the database.
select count(customer_id) as total_customers from customers;

-- Q6. Show the total number of orders placed for each order status (Delivered, Shipped, Cancelled, Returned).
select order_status , count(*) as total_order from orders group by order_status;

-- Q7. Find the average product price per category.
select category , round(avg(price),2) as avg_price from products group by category; 

-- Q8. Get all customers whose age is between 18 and 25 (inclusive).
-- Show their full name, city, and age.
select concat(first_name , " " , last_name) as full_name , city , age from customers where age between 18 and 25;

-- Q9. Find all products whose name contains the word "ANC". Show product name, category, and price.
select product_name ,category , price from products where product_name like "%ANC%";

-- Q10. Show the total revenue generated (sum of total_price) from the order_details table.
select sum(total_price) as total_revenue from order_details;

-- Q11. List the distinct payment methods used across all orders.
select distinct payment_method from orders;

-- Q12. Find the minimum and maximum price of products in each sub_category.
select sub_category , min(price) as min_price , max(price) as max_price from products group by sub_category;

-- Q13. Get all orders placed in the year 2025. Show order_id, customer_id, order_date, and order_status.
select order_id, customer_id , order_date , order_status from orders where year(order_date) = "2025" order by order_date;
SELECT order_id,customer_id,order_date,order_status FROM orders
WHERE order_date >= '2025-01-01' AND order_date < '2026-01-01' ORDER BY order_date;

-- Q14. List the top 5 cities with the most registered customers.
select city , count(*) as total_registered_customers from customers 
group by city order by total_registered_customers desc limit 5;

-- Q15. Show how many products fall under each color. Sort by count descending.
select color , count(*) as total_products from products group by color order by total_products desc;