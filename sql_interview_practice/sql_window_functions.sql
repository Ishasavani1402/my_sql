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
select  customers.customer_id  , orders.order_id , orders.order_date , 
row_number() over(partition by customers.customer_id order by orders.order_date) as order_num
from customers join orders using (customer_id) ;

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
select orders.order_id , order_details.total_price , avg( order_details.total_price) over()
as avg_total_price from orders inner join order_details 
on orders.order_id = order_details.order_id;

-- W9. For each order_detail row, show the total_price, the total revenue for that product's category, 
-- and what percentage this row contributes to its category's total revenue.
select order_details.order_detail_id , order_details.product_id , 
products.category , order_details.total_price , 
SUM(order_details.total_price) OVER (PARTITION BY products.category) AS category_total_revenue,
ROUND(100.0 * order_details.total_price / SUM(order_details.total_price) OVER (PARTITION BY products.category),2)
AS pct_of_category_total
from order_details inner join products on products.product_id = order_details.product_id
order by order_details.order_detail_id;

-- W10. Show each customer's total number of orders alongside the total number of orders across all customers, in each row. 
-- Show customer_id, customer_order_count, total_orders_all_customers.
select customers.customer_id , count(orders.order_id) as total_order ,
sum(count(orders.order_id)) over() as total_order_all_customers
from customers left join orders on 
customers.customer_id = orders.customer_id group by customers.customer_id;

-- W11. For each row in order_details, show the running total of total_price ordered by order_detail_id. 
-- Show order_detail_id, total_price, and running_total.
select order_detail_id , total_price , sum(sum(total_price))  over(order by order_detail_id) as running_total
from order_details group by order_detail_id , total_price;

-- W12. Show the running total of revenue month by month for 2024. Show year, month, monthly_revenue, and cumulative_revenue.
with revenue as (select year(orders.order_date) as order_year , 
month(orders.order_date) as order_month , 
sum(order_details.total_price) as total_revenue 
from orders join order_details using(order_id)  group by order_year , order_month
having order_year = 2024)
select order_year , order_month , total_revenue AS monthly_revenue,
sum(total_revenue) over(order by order_year , order_month) as cumulative_revenue 
from revenue order by order_year , order_month;

-- W13. For each order placed by a customer, show the current order_date and the previous order_date 
-- (the one placed just before it). Show customer_id, order_id, order_date, and prev_order_date.
select customers.customer_id , orders.order_id , orders.order_date, lag(orders.order_date) 
over(partition by customers.customer_id order by orders.order_date) as
preveious_order_date
from customers join orders
using(customer_id) 
order by  orders.order_date desc;

-- W14. From W13 — calculate the number of days between each order and the customer's previous order. 
-- Call it days_since_last_order. Rows where prev_order_date is NULL (first order) should show NULL or 0 — your choice.

with lag_ as (select customers.customer_id , orders.order_id , orders.order_date, 
lag(orders.order_date) over(partition by customers.customer_id order by orders.order_date) as
preveious_order_date
from customers join orders
using(customer_id) 
order by orders.order_date desc)
select customer_id  , order_id , order_date , preveious_order_date , 
datediff(order_date , preveious_order_date) as days_since_last_order
from lag_;

-- W15. For each product in order_details, show the current unit_price and the unit_price of the next order 
-- for the same product. Call it next_order_price. This helps spot if a product's price changed across orders.
select product_id , unit_price , lead(unit_price) over(partition by product_id order by order_id) as
next_order_price from order_details;

-- W16. Find the first order placed by each customer. Show customer_id, order_id, and order_date.
-- (Use ROW_NUMBER, not MIN — because interviewers specifically test this pattern)

with all_order_date as (select customers.customer_id , orders.order_id , orders.order_date ,
row_number() over(partition by customers.customer_id order by orders.order_date asc) as rnk
from customers  inner join orders on 
customers.customer_id = orders.customer_id )
select customer_id , order_id , order_date from all_order_date where rnk = 1;

-- W17. Rank customers by their total spend (sum of total_price). Show customer_id, total_spend, and rank. 
-- Use DENSE_RANK. Top spender = Rank 1.
with spent as (select customers.customer_id , sum(order_details.total_price) as total_spent  
from customers inner join orders on 
customers.customer_id = orders.customer_id
inner join order_details on order_details.order_id = orders.order_id
group by customers.customer_id)
select customer_id , total_spent , dense_rank() over(order by total_spent desc)as rnk
from spent;

-- W18. For each state, find the customer who spent the most. Show state, customer full name, and their total spend.
with spent as (select customers.state , concat(customers.first_name , " " , customers.last_name) as full_name , 
sum(order_details.total_price) as total_spent ,
row_number() over(partition by customers.state order by sum(order_details.total_price) desc)as rnk
from customers inner join orders on 
customers.customer_id = orders.customer_id
inner join order_details on order_details.order_id = orders.order_id
group by customers.state , full_name)
select state , full_name , total_spent from spent where rnk =1;

-- W19. For each month in 2024, calculate the month-over-month revenue change. 
-- Show month, monthly_revenue, previous_month_revenue, and the difference (positive = growth, negative = drop).
with a as (select year(orders.order_date) as order_year , month(orders.order_date) as order_month , 
sum(order_details.total_price) as total_revenue 
from orders join order_details using(order_id)  WHERE year(order_date)=2024 group by order_year ,  order_month 
order by order_month),
b as (select order_year , order_month , total_revenue ,
lag(total_revenue) over(order by order_month asc) as previous_month_revenue
from a)
select order_year , order_month , total_revenue ,previous_month_revenue ,
(total_revenue - previous_month_revenue) as diffrence from b;

-- W20. Show each order_detail row with its product's total revenue, and flag it as 'Above Avg' or 'Below Avg' 
-- based on whether its total_price is above or below the average total_price for that product category. 
-- Show order_detail_id, product_id, category, total_price, category_avg, and price_flag.
WITH category_avg AS (
    SELECT
        products.category,
        AVG(order_details.total_price) AS avg_price
    FROM
        order_details
    INNER JOIN
        products ON order_details.product_id = products.product_id
    GROUP BY
        products.category
)
SELECT
    od.order_detail_id,
    od.product_id,
    p.category,
    od.total_price,
    ca.avg_price AS category_avg,
    CASE
        WHEN od.total_price > ca.avg_price THEN 'Above Avg'
        ELSE 'Below Avg'
    END AS price_flag
FROM
    order_details od
INNER JOIN
    products p ON od.product_id = p.product_id
INNER JOIN
    category_avg ca ON p.category = ca.category
ORDER BY
    od.order_detail_id;