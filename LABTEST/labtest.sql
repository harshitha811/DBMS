create database AirlineFlightInfo;
use AirlineFlightInfo;

create table flight(fl_no int,fl_from varchar(20),fl_to varchar(20),distance int,depart varchar(20),arrives varchar(20),
                    primary key(fl_no));

create table aircraft(aid int,aname varchar(20),cruising_range int,fl_no int,
					  primary key(aid),foreign key(fl_no) references flight(fl_no) on delete cascade);
                      
create table employee(eid int,ename varchar(20),salary int,primary key(eid));

create table certified(eid int, aid int,foreign key(eid) references employee(eid) on delete cascade,
					   foreign key(aid) references aircraft(aid) on delete cascade);

insert into flight values(4536,'Banglore','Mumbai',900,'7 AM','10 AM');
insert into flight values(8457,'Mumbai','Delhi',540,'6 PM','8 PM');
insert into flight values(3459,'Mumbai','Chennai',540,'6 PM','8 PM');
insert into flight values(6457,'Mumbai','Punjab',540,'6 PM','8 PM');
insert into flight values(7467,'Banglore','Delhi',540,'6 PM','8 PM');
select * from flight;
insert into aircraft values(5643,'Spicejet',30000,4536);
insert into aircraft values(2344,'AirAsia',10000,8457);
insert into aircraft values(4563,'IndiGo',20000,4536);
insert into aircraft values(7634,'AirIndia',15000,7467);
insert into aircraft values(8548,'Vistara',44000,6457);
select * from aircraft;
insert into employee values(23,'Kush',50000);
insert into employee values(45,'Hitha',30000);
insert into employee values(56,'Ravi',25000);
insert into employee values(37,'Supri',35000);
insert into employee values(65,'Raam',33000);
select * from employee;
insert into certified values(23,5643);
insert into certified values(56,5643);
insert into certified values(23,4563);
select * from certified;
show tables;
/*Find all the employees who are flying least two aircrafts
By using Natural Join.*/

SELECT ename FROM Employee e NATURAL JOIN Certified c GROUP BY c.eid HAVING COUNT(c.aid) >= 2;

/*Find all the Employee Names,id who are certified and not certified*/

select * from employee left outer JOIN certified on employee.eid=certified.eid group by employee.ename;

/*Demonstrate how you delete a aircraft tuples whose cruising
Range is 10000km*/

delete from aircraft where cruising_range=10000;

/*Modify the Employee table by adding city attribute and check constraint to the employess
salary attribute(>20000).*/

alter table employee add column city varchar(20);
ALTER TABLE Employee ADD constraint CHK_salary CHECK(salary > 20000);
SELECT * FROM Employee;

/*Create a View which contains(eid,Totalsalary,AvgSalary) for each employee who are
certified.*/

cREATE VIEW aircraft_info(Emp_id,Total_Salary,AvgSalary)
AS Select e.eid,sum(salary),avg(salary)
     From employee e, certified c
     Where e.eid=c.eid
     Group By e.ename;

select * from aircraft_info;




