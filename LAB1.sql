create database insurance;
use insurance;
create table person(driver_id varchar(10),pname varchar(10),addresss varchar(20),primary key(driver_id));
create table car(reg_no varchar(10),model varchar(10),cyear int,primary key(reg_no));
create table accident(report_no int,adate date,location varchar(20),primary key(report_no));
create table owns(driver_id varchar(10),reg_no varchar(10),primary key(driver_id,reg_no),
foreign key(driver_id) references person(driver_id) on delete cascade,
foreign key (reg_no) references car(reg_no) on delete cascade);
create table participated(driver_id varchar(10),reg_no varchar(10),report_no int,damage_amt float,primary key(driver_id),
foreign key(driver_id) references owns(driver_id) on delete cascade,
foreign key (reg_no) references owns(reg_no) on delete cascade,foreign key(report_no) references accident(report_no) on delete cascade);
insert into person values (1111,'RAMU','K.S.LAYOUT');
insert into person values (2222,'JOHN','INDIRANAGAR');
insert into person values (3333,'PRIYA',' JAYANAGAR');
insert into person values (4444,'GOPAL','WHITEFIELD');
insert into person values (5555,'LATHA','VIJAYANAGAR');
select * from person;
insert into car values ('KA04Q2301','MARUTHI-DX',2000);
insert into car values ('KA05P1000','FORDICON',2000);
insert into car values('KA03L1234','ZEN-VXI',1999);
insert into car values('KA03L9999','MARUTH-DX',2002);
insert into car values('KA01P4020','INDICA-VX',2002);
select * from car;
insert into accident values (12, '01-06-02','M G ROAD');
insert into accident values (200,'10-12-02','DOUBLE ROAD');
insert into accident values (300,'23-07-09', ' M G ROAD');
insert into accident values (25000,'11-06-00','RESIDENCY ROAD');
insert into accident values (26500,'16-10-01','RICHMOND ROAD');
select * from accident;
insert into owns values(1111, 'KA04Q2301');
insert into owns values(1111,'KA05P1000');
insert into owns values(2222,'KA03L1234');
insert into owns values(3333,'KA03L9999');
insert into owns values(4444,'KA01P4020');
select * from owns;
insert into participated values (1111,'KA04Q2301',12, 20000);
insert into participated values(2222,'KA03L1234',200,500);
insert into participated values(3333,'KA03L9999',300,10000);
insert into participated values(4444,'KA01P4020',25000,2375);
select * from participated;
update participated set damage_amt=25000 where report_no=12 and  reg_no="KA04Q2301";
insert into accident values (13, '01-08-16','J P NAGAR');
/*Find the total number of people who owned cars that involved in accidents in 2008.
v. Find the number of accidents in which cars belonging to a specific model were involved.*/
SELECT COUNT(*) FROM ACCIDENT
WHERE ADATE LIKE "%-%-02";

SELECT count(A.REPORT_NO)
FROM ACCIDENT A, PARTICIPATED P, CAR C
WHERE A.REPORT_NO=P.REPORT_NO
AND
P.REG_NO=C.REG_NO
AND
C.MODEL="MARUTHI-DX";
commit;
