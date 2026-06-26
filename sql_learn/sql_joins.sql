select * from students;
select * from address;

-- inner join
select students.name , students.gender , address.city ,address.state from students inner join address on students.sid = address.sid; 

-- left join 
select students.name , students.gender , address.city ,address.state from students left join address on students.sid = address.sid; 

-- right join
select students.name , students.gender , address.city ,address.state from students right join address on students.sid = address.sid; 

-- self join (join table it self no teo diffrent table nedd here)
alter table students add column referred_by int;
update students set referred_by = 1 where sid in (1,3,5,7,9,11);
update students set referred_by = 2 where sid in (2,4,6,8,10);

select a.sid,a.name as username , b.name as referred_by_name from students a inner join students b on a.referred_by = b.sid;
-- here we can use any type of join

-- union (remove dupicate data , no of column must be same)
select name , email from customers union select name , email from students;
select name , email , 'customers' as role from customers union select name , email , "student" as role from students;

show index from students; 