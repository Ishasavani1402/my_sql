-- CTE (common table expression)

-- 1.Build a CTE that calculates the total amount per order, then use it to list the top orders for each state in a selected year.
with amount as (select orders.order_id , customers.state , year(orders.order_date) ,sum(order_details.total_price) as total_amount from orders
join customers on customers.customer_id = orders.customer_id
join order_details on orders.order_id = order_details.order_id
where year(orders.order_date) = 2025
group by orders.order_id , customers.state)

select * ,row_number() over (partition by state order by total_amount desc) as rnk from amount;

-- 2.Using a CTE that identifies the first order date per customer, return customers whose first order occurred within 30 days of their signup date.
