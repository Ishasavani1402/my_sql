use pizza_sales;
select * from pizzas;

-- category wise pizza count(partition by)
select category , name , count(category) over(partition by category) as category_count from pizza_types;

-- sum of total sales order by date it known as running total (order by)
with a as (select orders.order_date , round(sum(pizzas.price * order_details.quantity) , 2) as sales from orders 
join order_details using(order_id) join pizzas using(pizza_id) group by orders.order_date)
select * , 
sum(sales) over(order by order_date) as running_total,
sum(sales) over(partition by month(order_date), year(order_date) order by order_date) as MTD from a ;

-- rank() dense_rank() row_number() in windows
select pizza_types.category , pizza_types.name , pizzas.size , pizzas.price, 
rank() over(order by pizzas.price desc ) as price_rank,
dense_rank() over(order by pizzas.price desc) as d_rank,
row_number() over(order by pizzas.price desc ) as r_num  from pizza_types join pizzas  using(pizza_type_id); 

-- fetch top3 pizza by each caategory
with a as (select pizza_types.category , pizza_types.name , pizzas.size , pizzas.price,
dense_rank() over(order by pizzas.price desc) as d_rank
from pizza_types join pizzas  using(pizza_type_id))
select * from a where d_rank <=3; 

-- find median
with a as (select price, row_number() over(order by price) pos , count(*) over() n from pizzas)
select case 
when n % 2 = 0 then (select avg(price) from a where pos in ((n/2) , (n/2)+1))
else (select price from a where pos = (n+1)/2)
end as median from a limit 1;

-- lag() and lead() in windows
with a as (select month(orders.order_date) months  , round(sum(pizzas.price * order_details.quantity) , 2) as sales from orders 
join order_details using(order_id) join pizzas using(pizza_id) group by month(orders.order_date))
select * , 
lag(sales , 1) over(order by months) as prev_fun ,
lead(sales , 1) over(order by months) as fut_fun  from a; 
