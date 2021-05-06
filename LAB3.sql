create database OrderProcessing;
use OrderProcessing;
 
create table customer(cust_no int,cname varchar(20),city varchar(20),primary key(cust_no));
create table OPorder(order_no int,odate date,cust_no int,ord_amt int,primary key(order_no),
                     foreign key(cust_no) references customer(cust_no) on delete cascade);
create table item(item_no int,unit_price int,primary key(item_no));
create table order_item (order_no int,item_no int,qty int,
						 foreign key(order_no) references OPorder(order_no) on delete set null,
						 foreign key(item_no) references item(item_no) on delete set null);
create table warehouse(warehouse_no int,city varchar(20),primary key(warehouse_no));
create table shipment(order_no int,warehouse_no int,sdate date,
					  foreign key(order_no) references OPorder(order_no) on delete set null,
                      foreign key(warehouse_no) references warehouse(warehouse_no) on delete set null);

desc customer; 

insert into customer values(771,'PUSHPA K',' BANGALORE');
insert into customer values(772, 'SUMAN',' MUMBAI');
insert into customer values(773,' SOURAV', 'CALICUT');
insert into customer values(774 ,'LAILA' ,'HYDERABAD');
insert into customer values(775 ,'FAIZAL' ,'BANGALORE');
select * from customer;

insert into OPorder values(111,'22-01-02', 771 ,18000);
insert into OPorder values(112 ,'30-07-02' ,774, 6000);
insert into OPorder values(113 ,'03-04-03' ,775 ,9000);
insert into OPorder values(114 ,'03-11-03', 775 ,29000);
insert into OPorder values(115 ,'10-12-03', 773 ,290000);
insert into OPorder values(116, '19-07-04', 772 ,560000);
insert into OPorder values(117 ,'10-09-04' ,771 ,20000);
insert into OPorder values(118 ,'20-11-04', 775 ,29000);
insert into OPorder values(119 ,'13-02-05' ,774, 29000);
insert into OPorder values(120 ,'13-10-05', 775 ,29000);
select * from OPorder;

insert into item values(5001, 503);
insert into item values(5002, 750);
insert into item values(5003 ,150);
insert into item values(5004 ,600);
insert into item values(5005 ,890);
select * from item;

insert into order_item values(111 ,5001 ,50);
insert into order_item values(112, 5003 ,20);
insert into order_item values(113 ,5002 ,50);
insert into order_item values(114 ,5005 ,60);
insert into order_item values(115 ,5004 ,90);
insert into order_item values(116 ,5001 ,10);
insert into order_item values(117 ,5003 ,80);
insert into order_item values(118 ,5005 ,50);
insert into order_item values(119 ,5002 ,10);
insert into order_item values(120 ,5004 ,45);
select * from order_item;

insert into warehouse values(1 ,'DELHI');
insert into warehouse values(2 ,'BOMBAY');
insert into warehouse values(3 ,'CHENNAI');
insert into warehouse values(4 ,'BANGALORE');
insert into warehouse values(5 ,'BANGALORE');
insert into warehouse values(6 ,'DELHI');
insert into warehouse values(7 ,'BOMBAY');
insert into warehouse values(8 ,'CHENNAI');
insert into warehouse values(9 ,'DELHI');
insert into warehouse values(10, 'BANGALORE');
select * from warehouse; 

insert into shipment values(111 ,1 ,'10-02-02');
insert into shipment values(112 ,5 ,'10-09-02');
insert into shipment values(113 ,8 ,'10-02-03');
insert into shipment values(114 ,3 ,'10-12-03');
insert into shipment values(115 ,9 ,'19-01-04');
insert into shipment values(116 ,1 ,'20-09-04');
insert into shipment values(117 ,5 ,'10-09-04');
insert into shipment values(118 ,7 ,'30-01-04');
insert into shipment values(119 ,7 ,'30-04-05');
insert into shipment values(120 ,6 ,'21-12-05');
select * from shipment;

/*Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column
is the total
numbers of orders by the customer and the last column is the average order amount for that
customer.*/
select cname, count(*), avg(ord_amt) from customer right join OPorder on customer.cust_no=OPorder.cust_no group by customer.cname;

/*List the order# for orders that were shipped from all warehouses that the company has in a
specific city.*/

select order_no from warehouse as w,shipment as s where w.warehouse_no=s.warehouse_no and city='DELHI';

/*Demonstrate how you delete item# 10 from the ITEM table and make that field null in the
ORDER_ITEM*/

delete from item where item_no=5005;