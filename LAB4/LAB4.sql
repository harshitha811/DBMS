CREATE database banking;
use banking;
create table branch (branch_name varchar(20),branch_city varchar(20),assets real,primary key(branch_name));
create table accounts(accno int,branch_name varchar(20),balance real,primary key(accno),
					  foreign key(branch_name) references branch(branch_name) on delete cascade);
create table customer(cust_name varchar(20),cust_street varchar(20),cust_city varchar(20),primary key(cust_name));
create table depositor(cust_name varchar(20),accno int,
					   foreign key(accno) references accounts(accno) on delete cascade,
                       foreign key(cust_name) references customer(cust_name) on delete cascade);
create table loan(loan_num int,branch_name varchar(20),amount real, primary key(loan_num),
				  foreign key(branch_name) references branch(branch_name) on delete cascade);
create table borrower(cust_name varchar(20),loan_num int,
					  foreign key(cust_name) references customer(cust_name) on delete cascade,
                      foreign key(loan_num) references loan(loan_num) on delete cascade);
		
show tables;

insert into branch values('SBI PD NAGAR', 'BANGALORE', 200000);
insert into branch values('SBI RAJAJI NAGAR',' BANGALORE', 500000);
insert into branch values('SBI JAYANAGAR' ,'BANGALORE ',660000);
insert into branch values('SBI VIJAY NAGAR' ,'BANGALORE', 870000);
insert into branch values('SBI HOSAKEREHALLI',' BANGALORE', 550000);
select * from branch;

insert into accounts values(1234602, 'SBI HOSAKEREHALLI', 5000);
insert into accounts values(1234603, 'SBI VIJAY NAGAR', 5000);
insert into accounts values(1234604, 'SBI JAYANAGAR', 5000);
insert into accounts values(1234605, 'SBI RAJAJI NAGAR', 10000);
insert into accounts values(1234503, 'SBI VIJAY NAGAR', 40000);
insert into accounts values(1234506, 'SBI PD NAGAR', 4000);
select * from accounts;

insert into customer values('KEZAR', 'M G ROAD', 'BANGALORE');
insert into customer values('LAL', 'KRISHNA ST MKS ROAD', 'BANGALORE');
insert into customer values('RAHUL', 'AUGSTEN ROAD', 'BANGALORE');
insert into customer values('LALLU', 'V S ROAD', 'BANGALORE');
insert into customer values('FAIZAL', 'RESEDENCY ROAD', 'BANGALORE');
select * from customer;

insert into depositor values('KEZAR',1234602);
insert into depositor values('LALLU',1234603);
insert into depositor values('RAHUL',1234604);
insert into depositor values('LAL',1234605);
insert into depositor values('LALLU',1234503);
select * from depositor;

DELETE FROM DEPOSITOR WHERE CUST_NAME='LALLU';
insert into loan values(10011, 'SBI JAYANAGAR', 10000);
insert into loan values(10012, 'SBI VIJAY NAGAR', 5000);
insert into loan values(10013, 'SBI HOSAKEREHALLI', 20000);
insert into loan values(10014, 'SBI PD NAGAR', 15000);
insert into loan values(10015, 'SBI RAJAJI NAGAR', 25000);
select * from loan;

insert into borrower values('KEZAR', 10011);
insert into borrower values('LAL', 10012);
insert into borrower values('RAHUL', 10013);
insert into borrower values('LALLU', 10014);
insert into borrower values('LAL', 10015);
select * from borrower;

/*Find all the customers who have at least two accounts at
the Main branch..*/
select d.cust_name from depositor d,accounts a where d.accno=a.accno and branch_name='SBI VIJAY NAGAR' group by d.cust_name having count(d.cust_name)>=2;

/*Find all the customers who have an account at all the
branches located in a specific city.*/
select d.cust_name from accounts a, branch b, depositor d where b.branch_name=a.branch_name and a.accno=d.accno and b.branch_city="BANGALORE" 
group by d.cust_name having count(distinct b.branch_name)=(select count(branch_name) from branch where branch_city="BANGALORE");


/*v) Demonstrate how you delete all account tuples at every
branch located in a specific city.*/

delete from accounts where branch_name in (select branch_name from branch where branch_city='Bangalore');
