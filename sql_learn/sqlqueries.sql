use cloud;
select * from customers where gender = 'male';
select * from customers where name like '%p%';
select * from customers where name like '%p%' or name like 'a%' order by uid desc ;
select * from customers;
alter table customers add salary int;
truncate table customers;
insert into customers (name , email , gender , salary) value 
("isha","isha@gmail.com","female",10000);
INSERT INTO customers (name, email, gender, salary) VALUES
("neha", "neha@gmail.com", "female", 12000),
("rahul", "rahul@gmail.com", "male", 18000),
("ankit", "ankit@gmail.com", "male", 22000),
("priya", "priya@gmail.com", "female", 15000),
("rohit", "rohit@gmail.com", "male", 25000),
("sonam", "sonam@gmail.com", "female", 17000),
("vikas", "vikas@gmail.com", "male", 30000),
("kajal", "kajal@gmail.com", "female", 14000),
("amit", "amit@gmail.com", "male", 27000),
("pooja", "pooja@gmail.com", "female", 16000);
update customers set email = "rohitmoradiya@gmail.com",salary = 1000000 where uid = 6;

-- functions
-- 1.count
select count(*) from customers;
select min(salary) as min_salary , max(salary) as max_salary from customers;
select sum(salary) as total_salary from customers;
select avg(salary) as avg_salary from customers;
select gender , avg(salary) as avg_salary from customers group by gender;   -- group by
select name , length(name) as name_length from customers;
select name , concat((name),"1234") as user_name from customers;
select round(salary) as round_fig , floor(salary) as floor_salary from customers;
select lower(name) as lowercase from customers;