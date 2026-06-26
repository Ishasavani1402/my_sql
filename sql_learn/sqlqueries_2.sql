use cloud;
create table students(
sid int primary key auto_increment,
name varchar(20) not null,
email varchar(50) unique not null,
gender enum ('male','female'),
sem varchar(20),
department varchar(20));
select * from students;
INSERT INTO students (name, email, gender, sem, department,DOB) VALUES
("Isha", "isha@gmail.com", "female", "Sem 1", "MCA","2001-03-13");
INSERT INTO students (name, email, gender, sem, department, DOB) VALUES
("Neha", "neha1@gmail.com", "female", "Sem 2", "MCA", "2000-06-21"),
("Rahul", "rahul1@gmail.com", "male", "Sem 3", "BCA", "2001-09-15"),
("Ankit", "ankit1@gmail.com", "male", "Sem 4", "BCA", "2000-12-02"),
("Priya", "priya1@gmail.com", "female", "Sem 1", "MBA", "2002-01-10"),
("Rohit", "rohit1@gmail.com", "male", "Sem 2", "MBA", "2000-08-19"),
("Kajal", "kajal1@gmail.com", "female", "Sem 3", "B.Tech", "2001-04-05"),
("Amit", "amit1@gmail.com", "male", "Sem 4", "B.Tech", "2002-11-23"),
("Pooja", "pooja1@gmail.com", "female", "Sem 5", "MCA", "2001-07-30"),
("Vikas", "vikas1@gmail.com", "male", "Sem 6", "BCA", "2000-02-14"),
("Sonam", "sonam1@gmail.com", "female", "Sem 2", "MBA", "2003-05-18");
delete from students where sid = 6;
-- delete from students where department = "MCA";
-- delete from students where sem = "Sem1";

-- above both delete query is correct
alter table students add column DOB date check (DOB >= '2000-01-01'); 
truncate table students;

-- set autocommit = 0;  -- ye  karne se jitne bhi changes hai iske bad ke wo sare changes save nahi hongr untill we use commit 
delete from students where sid = 10;
rollback; -- previos changes tak le jata hai
-- we can change autoincrement value after create -> alter table students autoincrement = 1000;