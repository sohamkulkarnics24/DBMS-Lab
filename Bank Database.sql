create database BankSK284;
use BankSK284;

create table Branch (
branch_name varchar(15),
branch_city varchar(15),
assets real,
primary key(branch_name)
);
alter table Branch 
modify column branch_name varchar(30);
create table BankAccount (
accno int,
branch_name varchar(15),
balance real,
primary key(accno),
foreign key(branch_name) references Branch(branch_name)
);
alter table BankAccount 
modify column branch_name varchar(30);

create table Depositer (
customer_name varchar(20),
accno int,
primary key(customer_name,accno),
foreign key(customer_name) references BankCustomer(customer_name),
foreign key(accno) references BankAccount(accno)
);

create table BankCustomer (
customer_name varchar(20),
customer_street varchar(20),
customer_city varchar(15),
primary key(customer_name)
);

create table Loan (
loan_number int,
branch_name varchar(15),
amount real,
primary key(loan_number),
foreign key(branch_name) references Branch(branch_name)
);
alter table Loan 
modify column branch_name varchar(30);

insert into Branch values
('SBI_Chamrajpet', 'Bangalore', 500000),
('SBI_ResidencyRoad', 'Bangalore', 100000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParliamentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);

select * from Branch;

insert into BankAccount values
(1,'SBI_Chamrajpet',2000),
(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),
(4,'SBI_ParliamentRoad',9000),
(5,'SBI_Jantarmantar',8000),
(6,'SBI_ShivajiRoad',4000),
(8,'SBI_ResidencyRoad',4000),
(9,'SBI_ParliamentRoad',3000),
(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);

select * from BankAccount;

insert into BankCustomer values
('Avinash','Bull Temple','Bangalore'),
('Dinesh','Bannergatta','Bangalore'),
('Mohan','National College','Bangalore'),
('Nikhil','Akbar Road','Delhi'),
('Ravi','Prithviraj Road','Delhi');

select * from BankCustomer;

insert into Depositer values
('Avinash',1),
('Dinesh',2),
('Nikhil',4),
('Ravi',5),
('Avinash',8),
('Nikhil',9),
('Dinesh',10),
('Nikhil',11);

select * from Depositer;

insert into loan values
(1,'SBI_Chamrajpet',1000),
(2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParliamentRoad',4000),
(5,'SBI_Jantarmantar',5000);

select * from Loan;

select branch_name, assets as assets_in_lakhs
from Branch;

select d.customer_name, a.branch_name, count(*)
from depositer d, BankAccount a
where d.accno = a.accno 
group by d.customer_name, a.branch_name
having count(*)>=2; 

create view TotalLoans as
select branch_name, sum(amount)
from loan
group by branch_name;

select * from TotalLoans;
