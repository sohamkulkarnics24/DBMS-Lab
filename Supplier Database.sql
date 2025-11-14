create database supplier;
use supplier;

create table supplier (
	sid int,
    sname varchar(30),
    city varchar(30),
    primary key(sid)
);

create table parts (
	pid int,
    pname varchar(30),
    color varchar(20),
    primary key(pid)
);

create table catalog (
	sid int,
    pid int,
    cost decimal(10,2),
    foreign key(sid) references supplier(sid),
    foreign key(pid) references parts(pid),
    primary key(sid,pid)
);

INSERT INTO supplier VALUES
(1, 'Acme Widget Suppliers', 'Delhi'),
(2, 'Global Supplies', 'Mumbai'),
(3, 'Universal Traders', 'Chennai');

INSERT INTO parts VALUES
(101, 'Bolt', 'Red'),
(102, 'Nut', 'Blue'),
(103, 'Screw', 'Red'),
(104, 'Washer', 'Green');

INSERT INTO catalog VALUES
(1, 101, 50.00),
(1, 102, 35.00),
(1, 103, 75.00),
(1, 104, 40.00),
(2, 101, 45.00),
(2, 102, 30.00),
(2, 103, 70.00),
(3, 101, 55.00),
(3, 103, 65.00);

select p.pname
from parts p
where exists ( select 1
			   from catalog c
               where c.pid = p.pid );

select s.sname
from supplier s
join catalog c on s.sid = c.sid
group by s.sname
having count(c.pid) = (select count(*) from parts);

select s.sname
from supplier s
join catalog c on s.sid = c.sid
join parts p on c.pid = p.pid
where p.color = 'Red'
group by s.sname
having count(c.pid) = (select count(*) from parts where color = 'Red');

select p.pname
from parts p
where exists 	(select 1
				from catalog c 
                join supplier s on c.sid = s.sid 
                where c.pid = p.pid && s.sname = 'Acme Widget Suppliers')
                && 
                not exists (select 1 
                from catalog c join supplier s  on c.sid = s.sid where c.pid = p.pid && s.sname <> 'Acme Widget Suppliers');
                
select s.sname, p.pname
from supplier s
join catalog c on c.sid = s.sid
join parts p on c.pid = p.pid
where (c.pid,c.cost) in (select c1.pid, max(c1.cost) as max from catalog c1 group by c1.pid);



    
	