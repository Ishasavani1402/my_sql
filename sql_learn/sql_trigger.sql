use cloud;
create table student_log(id int primary key auto_increment , 
uid int, name varchar(20),created_on timestamp default current_timestamp);

select * from students;

-- trigger
delimiter $$
create trigger after_user_insert
after insert on students
for each row
begin
insert into student_log(uid , name)values(new.sid , new.name);
end $$
delimiter :

insert into students(name , email , gender , sem , department , DOB,referred_by) value
("manan","manan@gmail.com","male","Sem1" , "B.Tech","2000-01-23" , 1);

select * from student_log;

drop trigger if exists after_user_insert;