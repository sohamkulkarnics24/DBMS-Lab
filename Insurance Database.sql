show databases;
create database Insurance;
use Insurance;

create table person(
	driver_id varchar(10),
    name varchar(20),
    address varchar(30),
    primary key(driver_id)
);

desc person;

create table car(
	reg_num varchar(10),
    model varchar(10),
    year int,
    primary key(reg_num)
);

create table accident(
	report_num int,
    accident_date date,
    location varchar(20),
    primary key(report_num)
);

create table owns(
	driver_id varchar(10),
    reg_num varchar(10),
    primary key(driver_id,reg_num),
    foreign key(driver_id) references person(driver_id),
    foreign key(reg_num) references car(reg_num)
);

create table participated(driver_id varchar(10),
	reg_num varchar(10),
	report_num int,
    damage_amount int,
	primary key(driver_id, reg_num, report_num),
	foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num),
	foreign key(report_num) references accident(report_num)
);

insert into person values ('A01','Richard','Srinivas Nagar');
insert into person values ('A02','Pradeep','Rajijinagar');
insert into person values ('A03','Smith','Ashoknagar');
insert into person values ('A04','Venu','N.R. Colony');
insert into person values ('A05','John','Hanumanth Nagar');

insert into car values ('KA052250','Indica',1990);
insert into car values ('KA031181','Lancer',1957);
insert into car values ('KA095477','Toyota',1998);
insert into car values ('KA053408','Honda',2008);
insert into car values ('KA051212','Maruti',2012);

insert into accident values
(11,'2003-01-01','Mysore Road'),
(12,'2004-02-02','South End Circle'),
(13,'2005-12-04','Bull Temple Road'),
(14,'2003-01-01','Mysore Road'),
(15,'2003-01-01','Kanakpura Road');

insert into owns values
('A01','KA052250'),
('A02','KA031181'),
('A03','KA095477'),
('A04','KA053408'),
('A05','KA051212');

insert into participated values
('A01','KA052250',11,10000),
('A02','KA031181',12,50000),
('A03','KA095477',13,12000),
('A04','KA053408',14,15000),
('A05','KA051212',15,20000);


select accident_date, location
from accident;

select name, damage_amount
from person, participated
where person.driver_id = participated.driver_id and participated.damage_amount >= 25000;

select name, model
from person, car, owns
where owns.driver_id = person.driver_id and owns.reg_num = car.reg_num;

select accident_date, location, name, damage_amount
from accident,person,participated
where accident.report_num = participated.report_num and person.driver_id = participated.driver_id;

select name, count(*)
from person,participated
where person.driver_id = participated.driver_id
group by participated.driver_id
having count(*) > 1;

select model
from car
where reg_num not in (select reg_num
					  from participated);
                      
select *
from accident
where accident_date >= all(select accident_date
						  from accident);
                          
select avg(damage_amount)
from participated;

update participated 
set damage_amount = 25000 
where driver_id = 'A01';
select *
from participated;

select name
from person,participated
where person.driver_id = participated.driver_id and participated.damage_amount >= all(select damage_amount
																					  from participated);
                                                                                      
select c.model, sum(p.damage_amount) as total_damage
from car c
join participated p on c.reg_num = p.reg_num
group by c.model
having sum(p.damage_amount > 20000);

create view accident_summary as
select 
    a.report_num,
    a.accident_date,
    a.location,
    COUNT(p.driver_id) as participant_count,
    SUM(p.damage_amount) as total_damage
from accident a
join participated p on a.report_num = p.report_num
group by a.report_num, a.accident_date, a.location;
select * from accident_summary;