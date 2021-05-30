create database bookdealer;
use bookdealer;
create table author(author_id int,aname varchar(10),city varchar(10),country varchar(10),primary key(author_id));
create table publisher(publisher_id int,pname varchar(10),city varchar(10),country varchar(10),primary key(publisher_id));
create table category(category_id int,description varchar(20),primary key (category_id));
create table catalog(book_id int,title varchar(10),author_id int,publisher_id int, 
			 category_id int,cyear int,price int,primary key(book_id), 
             foreign key(author_id) references author(author_id),
             foreign key(publisher_id) references publisher(publisher_id),
             foreign key(category_id) references category(category_id));
create table offer_details(order_no int,book_id int,qauntity int,primary key (order_no),
			 foreign key(book_id) references catalog(book_id)); 
insert into author values(1001,'TERAS CHAN','CA','USA');
insert into author values(1002,'STEVENS', 'ZOMBI', 'UGANDA');
insert into author values(1003 ,'M MANO' ,'CAIR', 'CANADA');
insert into author values(1004 ,'KARTHIK BP','NEW YORK ','USA');
insert into author values(1005,'WILLIAM','LAS VEGAS' ,'USA');
select * from author;

insert into publisher values(1,'PEARSON',' NEW YORK','USA');
insert into publisher values(2,'EEE','SOUTHVALES',' USA');
insert into publisher values(3 ,'PHI ','DELHI',' INDIA');
insert into publisher values(4,'WILLEY ','BERLIN',' GERMANY');
insert into publisher values(5 ,'MGH ','NEW YORK',' USA');
select * from publisher;

insert into category values(1001,'COMPUTER SCIENCE');
insert into category values(1002,'ALGORITHM DESIGN');
insert into category values(1003,'ELECTRONICS');
insert into category values(1004,'PROGRAMMING');
insert into category values(1005,'OPERATING SYSTEMS');
select * from category;

insert into catalog values(11,'USP', 1001, 1 ,1001, 2000,251);
insert into catalog values(12 ,'DS' ,1002, 2, 1003, 2001,425);
insert into catalog values(13 ,'LogicDesig', 1003, 3 ,1002, 1999,225);
insert into catalog values(14,'ServerPrg',1004, 4 ,1004, 2001,333);
insert into catalog values(15,'Linux OS', 1005 ,5 ,1005, 2003,326);
insert into catalog values(16 ,'C++ Bible', 1005 ,5 ,1001, 2000,526);
insert into catalog values(17,'COBOLHBook' ,1005, 4 ,1001, 2000,658);
select * from catalog;

insert into offer_details values(1,11,5);
insert into offer_details values(2,12,8);
insert into offer_details values(3,13,15);
insert into offer_details values(4,14,22);
insert into offer_details values(5,15,3);
insert into offer_details values(6,17,10);
select * from offer_details;

/*iii) Give the details of the authors who have 2 or more books in the catalog and the price of the books in the
catalog and the year of publication is after 2000.*/
SELECT a.author_id,a.aname,a.city,a.country,c.price FROM AUTHOR a,CATALOG c
WHERE a.author_id=c.author_id
AND c.cyear>2000
GROUP BY c.author_id
HAVING COUNT(c.author_id)>=2;

/*iv) Find the author of the book which has maximum sales.*/
SELECT a.aname FROM AUTHOR a,CATALOG c,OFFER_DETAILS o
WHERE a.author_id=c.author_id
AND c.book_id=o.book_id
AND o.qauntity=(SELECT MAX(qauntity) FROM OFFER_DETAILS);



/*Demonstrate how you increase the price of books published by a specific publisher by 10%.*/
UPDATE CATALOG c 
SET c.price=1.1*c.price
WHERE c.publisher_id=(SELECT publisher_id FROM PUBLISHER WHERE pname="PEARSON");
SELECT * FROM CATALOG;
