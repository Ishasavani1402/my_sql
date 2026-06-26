-- numeric and aggregated functions
-- 1.Round the product price to the nearest whole number.
select product_name , round(price) as roung_figure from products;

-- 2.Return the ceiling of each unit price in order details.
select ceil(unit_price) as ceil from order_details;

-- 3.Return the floor of each total price in order details.
select floor(unit_price) as ceil from order_details;

-- 4.Show the modulus when dividing customer age by 10.
select first_name , mod(age , 10) as age from customers;

-- 5.Generate a random number for every product record.
 select product_id , product_name , floor(rand()*100)+1 as random_num_1_to_10 from products;
 
 -- 6.Calculate the square root of each product price.
select product_name , round(sqrt(price),2) as sqrt from  products;

-- 7.Find the total quantity ordered across all order details.
select sum(quantity) as total_qty from order_details;

-- 8.Find the average discount percent across all orders.
select avg(discount_percent) as avg_dscnt from order_details ;

-- 9.Return the maximum product price from products.
select max(price) as max_price from products;

-- 10.Return the minimum customer age from customers.
select min(age) as min_age from customers;
