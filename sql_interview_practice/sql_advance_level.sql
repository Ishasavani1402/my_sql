select * from customers;
select * from order_details;
select * from orders;
select * from products;
select * from returns;

-- Advance level
-- Q31. Rank customers by total amount spent using DENSE_RANK(). Show customer full name, total spent, and their rank. 
-- Top spender = Rank 1.
with spent as (select concat(customers.first_name , " " , customers.last_name) as full_name,
sum(order_details.total_price) as total_spent from customers inner join orders on customers.customer_id = orders.customer_id
inner join order_details on order_details.order_id = orders.order_id
group by customers.customer_id , full_name)
select full_name , total_spent , dense_rank() over(order by total_spent desc) as ranked from spent;

-- Q32. For each product category, find the top 2 products by total revenue earned . 
-- Use ROW_NUMBER() inside a CTE.
with revenue as (select products.product_name , products.category , sum(order_details.total_price) as total_revenue
from products inner join order_details on products.product_id = order_details.product_id
group by products.product_id , products.product_name , products.category order by total_revenue desc limit 2)
select product_name , category , total_revenue , row_number() over(order by total_revenue desc) as ranked
from revenue;

-- Q33. Using LAG(), find each customer's previous order date alongside their current order date. 
-- Show customer_id, order_id, order_date, and prev_order_date. Only show customers with more than 1 order.
select customers.customer_id , orders.order_id , orders.order_date , 
lag(orders.order_date) over(order by orders.order_date) as previous_order_date , 
count(orders.order_id) as total_order
from customers inner join orders on customers.customer_id = orders.customer_id
group by customers.customer_id , orders.order_id , orders.order_date 
having total_order > 1;

-- Q34. Write a CTE to calculate each customer's total orders and total spend. Then from that CTE, 
-- find customers whose total spend is in the top 10% of all customers.
with all_spent as (select customers.customer_id , count(orders.order_id) as total_orders , 
sum(order_details.total_price) as total_spent ,
ntile(10) over(order by sum(order_details.total_price) desc) as top_10_per
from customers
inner join orders on customers.customer_id  = orders.customer_id
inner join order_details on order_details.order_id = orders.order_id
group by customers.customer_id)
select customer_id , total_orders , total_spent , top_10_per
from all_spent where top_10_per = 1;

-- Q35. Find the running total of revenue month by month for the entire dataset. 
-- Show year, month, monthly_revenue, and cumulative_revenue using SUM() as a window function.
with revenue as (select year(orders.order_date) as order_year , 
month(orders.order_date) as order_month , 
sum(order_details.total_price) as total_revenue 
from orders join order_details using(order_id) group by order_year , order_month)
select order_year , order_month , sum(total_revenue) over(order by order_year , order_month) as cumulative_revenue 
from revenue order by order_year , order_month;

-- Q36. Using CASE inside an aggregate, calculate the total revenue split by payment method as separate columns 
-- all in a single row: UPI_revenue, Credit_Card_revenue, Debit_Card_revenue, COD_revenue, Wallet_revenue
select sum(case when orders.payment_method = "Credit Card" then order_details.total_price else 0 end) as credit_revenue,
sum(case when orders.payment_method = "UPI" then order_details.total_price else 0 end) as upi_revenue,
sum(case when orders.payment_method = "Debit Card" then order_details.total_price else 0 end) as Debit_revenue,
sum(case when orders.payment_method = "Cash on Delivery" then order_details.total_price else 0 end) as cash_on_delivery_revenue,
sum(case when orders.payment_method = "Wallet" then order_details.total_price else 0 end) as wallet_revenue
from orders inner join order_details on orders.order_id = order_details.order_id ;

-- Q37. Identify customers who placed an order in 2024 but NOT in 2025. Use CTEs or subqueries.
with 2024_ as (select customers.customer_id , orders.order_date from customers 
join orders using(customer_id) where year(orders.order_date) = 2024),
2025_ as (select customers.customer_id , orders.order_date from customers 
join orders using(customer_id) where year(orders.order_date) = 2025)
select 2024_.customer_id , 2024_.order_date from 2024_ where 2024_.customer_id not in (select customer_id from 2025_);

-- Q38. For each order, calculate the number of days between shipped_date and delivery_date (transit time). 
-- Then using a window function, compute the average transit time per state (use the customer's state). 
-- Show order_id, state, transit_days, and avg_transit_days_per_state.
select customers.customer_id , orders.order_date from customers 
join orders using(customer_id) where year(orders.order_date) = 2024;
