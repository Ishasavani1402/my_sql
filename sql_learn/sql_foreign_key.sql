select * from students;
create table address(
aid int primary key auto_increment,
sid int , 
street varchar(50),
city varchar(30),
state varchar(40),
pincode int,
constraint fkey_user foreign key (sid) references students(sid) on delete cascade);
insert into address(sid , street , city , state , pincode) values
(1 , "katargam" , "surat" , "GJ",345678),
(4,"nikol","amdavad","GJ",456789);
insert into address(sid , street , city , state , pincode) values
(9 , "sahaj nagar" , "malad" , "mh",345678),
(10,"riverfront","amdavad","GJ",416789);
select * from address;