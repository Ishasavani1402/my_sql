select * from customers;
select * from order_details;
select * from orders;
select * from products;
select * from returns;

-- intermediate level
-- Q16. Get the full name of each customer along with their order_id 
-- and order_status. 
select concat(customers.first_name , " " , customers.last_name) as full_name,
orders.order_id , orders.order_status from customers inner join orders on customers.customer_id = orders.customer_id;

-- Q17. Find all customers who have never placed an order. Show their customer_id, full name, and city.
SELECT customers.customer_id ,
concat(customers.first_name , " " , customers.last_name) as full_name,
customers.city FROM customers 
LEFT JOIN orders  ON customers.customer_id = orders.customer_id
WHERE orders.customer_id IS NULL;

-- Q18. Show the total amount spent by each customer (sum of total_price from order_details). 
-- Include only customers who have spent more than 10,000. Show customer full name and total spent, sorted highest to lowest.
select concat(customers.first_name , " " , customers.last_name) as full_name,
sum(order_details.total_price) as total_spent from customers 
inner join orders on customers.customer_id = orders.customer_id
inner join order_details on orders.order_id = order_details.order_id
group by customers.customer_id,full_name
having total_spent > 10000
order by total_spent desc ;

-- Q19. For each order, calculate the number of days between order_date and delivery_date. 
-- Call this column delivery_days. Show order_id, order_date, delivery_date, delivery_days. 
-- Filter for orders where delivery took more than 7 days.
select order_id , order_date , delivery_date , datediff(delivery_date , order_date) as delivery_days
from orders WHERE DATEDIFF(delivery_date,order_date) > 7;

-- Q20. Find the top 3 best-selling products by total quantity sold. Show product_name, category, and total_quantity.
select products.product_name , products.category , sum(order_details.quantity) as total_quentity
from products inner join order_details on products.product_id = order_details.product_id
group by products.product_id,products.product_name , products.category order by total_quentity desc limit 3; 

-- Q21. Show all products that have never been ordered.
SELECT products.product_name ,
products.category, products.sub_category
FROM products 
LEFT JOIN order_details  ON order_details.product_id = products.product_id
left join orders on order_details.order_id = orders.order_id
WHERE order_details.product_id IS NULL;

-- Q22. Classify each order by value using a CASE statement:
-- total_price >= 5000 → 'High Value'
-- total_price between 2000 and 4999 → 'Medium Value'
-- total_price < 2000 → 'Low Value' , Show order_id, total_price, and the value_segment label.
select order_id , case when total_price >= 5000 then "High value"
when total_price between 2000 and 4999 then "medium value"
else "low value" end as value_segment , total_price
from order_details ;


-- Q23. Find the month-wise total revenue for the year 2024. Show month number, month name, and total revenue. Sort by month.
select month(orders.order_date) as month_num , monthname(orders.order_date) as month_name,
round(sum(order_details.total_price),2) as total_revenue 
from orders inner join order_details on orders.order_id = order_details.order_id
where year(orders.order_date) = 2024
group by month_num , month_name 
order by month_num;

-- Q24. Find all customers who placed more than 3 orders. Show their full name, city, and order count.
select concat(customers.first_name , " " , customers.last_name) as full_name, 
customers.city, count(orders.order_id) as order_count 
from customers inner join orders on customers.customer_id = orders.customer_id
group by  customers.customer_id , full_name , customers.city having count(orders.order_id) > 3 ;

-- Q25. Show the return reason and count of returns for each reason, but only show reasons that have more than 50 returns. 
-- Sort by count descending.
select reason , count(*) as count_ from returns group by reason having count(*) > 50 order by count_ desc ;

-- Q26. Write a subquery to find customers whose age is above the average age of all customers. 
-- Show their full name, age, and city.
select  concat(customers.first_name , " " , customers.last_name) as full_name, 
age , city from customers where age > (select avg(age) from customers); 

-- Q27. Find the most expensive product in each product category using a subquery.
SELECT product_name,category,price FROM products p1
WHERE price = ( SELECT MAX(price) FROM products p2 WHERE p2.category = p1.category);

-- Q28. Show each state along with its total revenue . Sort by total revenue descending.
select customers.state , sum(order_details.total_price) as total_revenue
from customers inner join orders on customers.customer_id = orders.customer_id
inner join order_details on orders.order_id = order_details.order_id
group by customers.customer_id , customers.state order by total_revenue desc;

-- Q29. Find all returns where the refund_status is 'Pending'. 
-- Show the return_id, return_date, reason, and the associated order_id
select returns.return_id , returns.return_date , returns.reason, order_details.order_detail_id
from returns inner join order_details on returns.order_detail_id = order_details.order_detail_id
where returns.refund_status = "Pending";

-- Q30. Show the number of orders placed per payment method per year. Rows: payment_method, year, order_count.
select payment_method , year(order_date) as order_year , count(*) as count
from orders group by payment_method , order_year order by order_year;