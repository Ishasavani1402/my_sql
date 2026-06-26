-- CASE operator
-- 1.Classify orders by delivery speed: if the delivery date is within 3 days of order date mark as Fast, within 7 days as Normal, else Delayed.
select order_id , order_date,delivery_date,
case 
when datediff(delivery_date , order_date) <=3 then "Fast"
when datediff(delivery_date , order_date) <=7 then "Normal"
else "Delayed"
end as delivery_speed from orders;

-- 2.Create a report of customers showing age groups: Youth (under 25), 
-- Adult (25–40), Senior (above 40), and count customers in each group (transpose style).
with a as (select concat(first_name , " ",last_name) as fullname, age , 
case 
when age <25 then "Youth"
when age >=25 and age <=40 then "Adult"
else "Senior"
end as age_category from customers)
select  age_category , count(age_category) as count_of_people from a group by age_category;


-- 3.For each product category, show total revenue and classify performance: 
-- High Revenue (above 1,00,000), Medium Revenue (50,000–1,00,000), Low Revenue (below 50,000).

with rev as (select products.category , sum(order_details.total_price) as total_revenue
from order_details join products on products.product_id = order_details.product_id group by products.category)
select category , total_revenue ,
case 
when total_revenue > 100000 then "high revenue"
when total_revenue between 50000 and 100000 then "Medium revenue"
else "low revenue"
end as category_revenue from rev; 

-- 4.Pivot the returns table: count how many returns are in each refund status
-- (Approved, Pending, Processed), using CASE inside aggregates to simulate transposed columns.

select 
sum(case when refund_status ="Approved" then 1 else 0 end) as approved,
sum(case when refund_status ="Processed" then 1 else 0 end) as Processed,
sum(case when refund_status ="pending" then 1 else 0 end) as pending
from returns;

select refund_status , count(refund_status) as total_count  from returns group by refund_status;

-- 5.For each state, calculate the number of orders paid by different payment methods 
-- (Credit Card, UPI, Cash) using CASE expressions, and return only states where at least two payment methods are used significantly.

select customers.state , 
sum(case when orders.payment_method = "Credit Card" then 1 else 0 end) as credit_card,
sum(case when orders.payment_method = "UPI" then 1 else 0 end) as UPI,
sum(case when orders.payment_method = "Wallet" then 1 else 0 end) as Wallet,
sum(case when orders.payment_method = "Cash on delivery" then 1 else 0 end) as cash_on_delivery,
sum(case when orders.payment_method = "Debit Card" then 1 else 0 end) as debit_card
from customers join orders on customers.customer_id = orders.customer_id group by customers.state;
