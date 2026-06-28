select * from customers;
select * from order_details;
select * from orders;
select * from products;
select * from returns;

-- W1. Assign a serial number to every order, ordered by order_date (oldest = 1). 
-- Show order_id, customer_id, order_date, and the serial number as order_serial.
select  orders.order_id,  customers.customer_id  , orders.order_date ,
row_number() over(order by  orders.order_date asc) as serial_num
from customers join orders using (customer_id);

-- W2. For each customer, number their orders from 1, 2, 3... in the order they were placed. 
-- Show customer_id, order_id, order_date, and order_rank_per_customer.
select  customers.customer_id  , orders.order_id , orders.order_date , count(orders.order_id) as total_orders , 
row_number() over(partition by customers.customer_id) as order_num
from customers join orders using (customer_id) group by   orders.order_id,  customers.customer_id  , orders.order_date;

-- W3. Rank all products by price (highest = rank 1). Show product_name, category, price, and price_rank.
-- Use RANK(). Notice what happens when two products have the same price.
select  product_name, category, price , rank() over(order by price desc) as price_rank
from products;

-- W4. Now do the same as W3 but use DENSE_RANK(). Compare your output with W3.
select  product_name, category, price , dense_rank() over(order by price desc) as price_rank
from products;

-- W5. Within each product category, rank products by price (highest = rank 1) using DENSE_RANK(). 
-- Show product_name, category, price, and rank_within_category.
select product_name , category , price , dense_rank() over(partition by category order by price desc) as price_rank
from products;

-- W6. From W5 — now filter to show ONLY the top 1 product per category (rank = 1). Wrap your W5 query in a subquery or CTE.
with all_ranked as (select product_name , category , price , dense_rank() over(partition by category order by price desc) 
as price_rank from products)
select product_name , category , price , price_rank from all_ranked where price_rank = 1;

-- W7. From W5 — show the top 2 products per category by price. (rank_within_category <= 2)
with all_ranked as (select product_name , category , price , dense_rank() over(partition by category order by price desc) 
as price_rank from products)
select product_name , category , price , price_rank from all_ranked where price_rank <=2;

-- W8. Show each order's total_price alongside the overall average total_price across all orders. 
-- Show order_id, total_price, and overall_avg_price in each row.
select orders.order_id , order_details.total_price , avg( order_details.total_price) over(partition by orders.order_id)
as avg_total_price from orders inner join order_details 
on orders.order_id = order_details.order_id;

-- W9. For each order_detail row, show the total_price, the total revenue for that product's category, 
-- and what percentage this row contributes to its category's total revenue.
select products.category , 
sum(order_details.total_price) as total_revenue , 
round(100.0 * sum(order_details.total_price)/ sum(sum(order_details.total_price)) over(),2) as pct_of_total
from order_details inner join products on order_details.product_id = products.product_id
group by products.category;

-- W10. Show each customer's total number of orders alongside the total number of orders across all customers, in each row. 
-- Show customer_id, customer_order_count, total_orders_all_customers.
select customers.customer_id , count(orders.order_id) as total_order ,
sum(count(orders.order_id)) over() as total_order_all_customers
from customers left join orders on 
customers.customer_id = orders.customer_id group by customers.customer_id;


