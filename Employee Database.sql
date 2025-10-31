create database emp_details;
use emp_details;

create table Dept (
	deptno int,
    dname varchar(30),
    dloc varchar(30),
    primary key(deptno)
);

create table project (
	pno int,
    pname varchar(30),
    ploc varchar(30),
    primary key(pno)
);

create table employee (
	empno int,
    ename varchar(30),
	mgr_no int,
    hiredate date,
    sal decimal(10,2),
    deptno int,
    primary key(empno),
    foreign key(deptno) references dept(deptno)
);

create table incentives (
	empno int,
    incentive_date date,
    incentive_amount decimal(8,2),
    foreign key(empno) references employee(empno),
    primary key(empno, incentive_date)
);

create table assigned_to (
	empno int,
    pno int,
    job_role varchar(30),
    foreign key(empno) references employee(empno),
    foreign key(pno) references project(pno),
    primary key(empno,pno)
);

insert into dept values
(10, 'HR', 'Bengaluru'),
(20, 'IT', 'Hyderabad'),
(30, 'Finance', 'Mysuru'),
(40, 'Marketing', 'Chennai'),
(50, 'HR', 'Delhi'),
(60, 'Finance', 'Pune');

select * from dept;

insert into project values
(201,'Payroll','Bengaluru'),
(202,'Inventory','Hyderabad'),
(203,'ERP','Mysuru'),
(204,'Ad Campaign','Chennai'),
(205,'AI','Delhi'),
(206,'Logistics','Pune');

select * from project;

insert into employee values
(1001,'Arjun',1005,'2020-01-10',50000,10),
(1002,'Meena',1005,'2021-03-15',55000,20),
(1003,'Ravi',1002,'2019-07-22',60000,30),
(1004,'Sneha',1003,'2022-11-11',48000,40),
(1005,'Kiran',NULL,'2018-05-03',75000,50),
(1006,'Asha',1002,'2023-02-20',47000,60);

select * from employee;

insert into incentives values
(1001,'2023-12-01',5000),
(1002,'2024-02-10',4000),
(1003,'2024-03-05',3000),
(1005,'2023-06-15',7000),
(1006,'2023-04-09',2000),
(1001,'2024-07-18',2500);

select * from incentives;

insert into assigned_to values
(1001,201,'Analyst'),
(1002,202,'Developer'),
(1003,203,'Manager'),
(1004,204,'Designer'),
(1005,205,'Lead'),
(1006,206,'Coordinator');

select e.empno
from assigned_to a
inner join employee e on a.empno = e.empno
inner join project p on a.pno = p.pno
where p.ploc in ('Bengaluru','Hyderabad','Mysuru'); 

select e.empno
from employee e
where not exists (select 1
			  from incentives i
              where i.empno = e.empno);

select e.ename,e.empno,d.dname,a.job_role,d.dloc,p.ploc
from employee e
join dept d on e.deptno = d.deptno
join assigned_to a on e.empno = a.empno
join project p on a.pno = p.pno
where d.dloc = p.ploc;



