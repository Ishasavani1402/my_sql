-- views -> it like virtuL table base on result of select query , dose not store data itself it use when we have complex query
-- usefull when-> simplyfy complex query , want reuse logic , want hide columns ...
-- when we make change in original table it reflect in view tablw also...
use cloud;
select * from students;
create view stud as select * from students where department = "MCA"; 

update students set department ="B.Tech" where sid = 9;
select * from stud;
drop view stud;

-- indexes
show indexes from students;
create index idx_email on students(gender); -- gender vali column me index bani hai
create index idx_salary on studentscustomers(gender,sem);

drop index idx_email on students;

select * from customers;

-- subqueries
select name , salary from customers where salary > (select  avg(salary) from customers);
select name , salary,(select avg(salary) from customers) as avg_salary from customers; 

-- group by 
-- after group by we can't put where cluse
select  gender , avg(salary) as 'avg_salary', count(*) as 'count'from customers  where uid < 30 group by gender;

-- having cluse
select  gender , avg(salary) as 'avg_salary', count(*) as 'count'from customers group by gender having avg(salary) > 10000 and count(*) > 6;

-- store procedure
delimiter $$
create procedure my_pro()
begin
select * from address;  -- here we can write any query
end $$
delimiter :

call my_pro();

delimiter $$
create procedure add_data()
begin
insert into address(sid , street , city , state , pincode) values (2 , "nikol","amdavad" , "GJ",098765);
end $$
delimiter :

call add_data();

select * from address;
