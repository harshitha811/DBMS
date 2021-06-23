create database AirlineInfo;
use AirlineInfo;

create table flight(fl_no int,fl_from varchar(20),fl_to varchar(20),distance int,depart varchar(20),arrives varchar(20),price int,
                    primary key(fl_no));

create table aircraft(aid int,aname varchar(20),cruising_range int,
					  primary key(aid));
                      
create table employee(eid int,ename varchar(20),salary int,primary key(eid));

create table certified(eid int, aid int,foreign key(eid) references employee(eid) on delete cascade,
					   foreign key(aid) references aircraft(aid) on delete cascade);

insert into flight values(4536,'Banglore','Mumbai',900,'7 AM','10 AM',5000);
insert into flight values(8457,'Mumbai','Delhi',540,'6 PM','8 PM',4000);
insert into flight values(3459,'Mumbai','Chennai',540,'6 PM','8 PM',6700);
insert into flight values(6457,'Mumbai','Punjab',540,'6 PM','8 PM',3400);
insert into flight values(7467,'Banglore','Delhi',540,'6 PM','8 PM',6000);
insert into flight values(7489,'Banglore','Frankfurt',5440,'6 PM','8 AM',60000);
insert into flight values(5689,'Banglore','Frankfurt',5440,'6 PM','8 AM',50000);
select * from flight;
insert into aircraft values(5643,'Spicejet',30000);
insert into aircraft values(2344,'AirAsia',10000);
insert into aircraft values(4563,'IndiGo',20000);
insert into aircraft values(7634,'AirIndia',15000);
insert into aircraft values(8548,'Vistara',44000);
insert into aircraft values(4623,'Boeing',400);
select * from aircraft;
insert into employee values(23,'Kush',50000);
insert into employee values(45,'Hitha',30000);
insert into employee values(56,'Ravi',25000);
insert into employee values(37,'Supri',35000);
insert into employee values(65,'Raam',33000);
insert into employee values(52,'Rita',90000);
select * from employee;
insert into certified values(23,5643);
insert into certified values(56,5643);
insert into certified values(23,4563);
insert into certified values(52,7634);
insert into certified values(23,7634);
insert into certified values(23,4563);
insert into certified values(23,2344);
insert into certified values(37,4623);
select * from certified;
show tables;

/*Find the names of aircraft such that all pilots certified to operate them have salaries more than
Rs.80,000.*/

select a.aname from aircraft a, certified c, employee e
where a.aid=c.aid 
and e.eid=c.eid
and not exists (select * from employee e2 where e2.eid=e.eid and e2.salary<80000);

/* For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising
range of the aircraft for which she or he is certified.*/

select c.eid, max(cruising_range) from certified c, aircraft a
where c.aid=a.aid 
group by c.eid having count(*) > 3;

/*iii. Find the names of pilots whose salary is less than the price of the cheapest route from Bengaluru to
Frankfurt.*/

select e.ename from employee e
where e.salary < (select min(f.price) from flight f where f.fl_from='Bangalore'and f.fl_to='Frankfurt');


/*iv. For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average
salary of all pilots certified for this aircraft.*/

select a.aname, a.aid, avg(e.salary) from aircraft a, employee e, certified c
where a.aid=c.aid and c.eid=e.eid and a.cruising_range>1000 group by a.aname, a.aid;

/*v. Find the names of pilots certified for some Boeing aircraft.*/

select e.ename from employee e, certified c, aircraft a where c.eid=e.eid and c.aid=a.aid and a.aname='Boeing';

/*vi. Find the aids of all aircraft that can be used on routes from Bengaluru to New Delhi.*/

select aid from aircraft where cruising_range>
    (select MIN(distance)
    from flights
    where fl_from='Bangalore'
    and fl_to='Delhi');

/*vii. A customer wants to travel from Madison to New York with no more than two changes of flight. List
the choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m.*/



/*viii. Print the name and salary of every non-pilot whose salary is more than the average salary for pilots.*/