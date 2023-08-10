USE hr_analysis;

SELECT * FROM hr_2;

select * from  hr_1;

-- Joining of coloums

SELECT * FROM hr_1
INNER JOIN hr_2
ON hr_1.EmployeeCount = hr_2.Employee_ID;

-- COUNT OF EMPLOYES 

SELECT COUNT(*) FROM hr_1;

-- COUNT OF ATTRATION 

SELECT COUNT(*) FROM hr_1
WHERE Attrition = 'Yes';

-- Attration By Department

SELECT Department,COUNT(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes' 
GROUP BY Department
ORDER BY COUNT DESC; 

-- Attration By Educayionfield

SELECT EducationField,COUNT(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes' 
GROUP BY EducationField
ORDER BY COUNT DESC;

-- Attration By JOBROLE

SELECT JobRole,COUNT(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes' 
GROUP BY JobRole
ORDER BY COUNT DESC;  

-- Attration By GENDER

SELECT Gender, COUNT(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes'
GROUP BY Gender
ORDER BY COUNT DESC;

-- Attration on GENDER BY maritalStates

SELECT Gender,MaritalStatus, COUNT(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes'
GROUP BY Gender,MaritalStatus
ORDER BY MaritalStatus DESC;

-- Attration on GENDER BY Department

SELECT Department,Gender,Count(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes'
GROUP BY Department,Gender
ORDER BY COUNT DESC,Department
LIMIT 5;

-- Attration  Department , jobrole, educationfiled on attration rate

SELECT Department, JobRole, EducationField, Count(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes'
GROUP BY Department, JobRole, EducationField
ORDER BY COUNT DESC
LIMIT 5;

-- Attration RATE ON Department by jobsatisification

SELECT Department,JobSatisfaction, COUNT(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes'
GROUP BY JobSatisfaction,Department
ORDER BY COUNT DESC
LIMIT 5;

-- Attration RATE ON  jobsatisification

SELECT JobSatisfaction, COUNT(*) AS COUNT FROM hr_1
WHERE Attrition = 'Yes'
GROUP BY  JobSatisfaction
ORDER BY COUNT DESC;

-- Attration RATE ON  Department

SELECT Department, COUNT(EmployeeNumber) AS EMP FROM hr_1
GROUP BY Department
ORDER BY EMP DESC;

-- Attration RATE ON  Department WITH SALARY

SELECT COUNT(*),Department,SUM(MonthlyIncome) AS SUM FROM hr_1
INNER JOIN hr_2
ON hr_1.EmployeeNumber = hr_2.Employee_ID
WHERE Attrition = 'Yes'
GROUP BY Department;

-- EMPLOYEE COUNT ON BY YEAR OF JOINING

SELECT COUNT(*) AS COUNT , Year_of_Joining FROM hr_2
INNER JOIN hr_1
ON hr_1.EmployeeNumber = hr_2.Employee_ID
GROUP BY Year_of_Joining
ORDER BY COUNT DESC
LIMIT 5;

-- EMPLOYEE COUNT ON BY YEAR OF JOINING

SELECT avg(MonthlyIncome) AS salary , Department FROM hr_2
INNER JOIN hr_1
ON hr_1.EmployeeNumber = hr_2.Employee_ID
GROUP BY Department
ORDER BY salary DESC
LIMIT 5;

SELECT ROUND(AVG(MonthlyIncome),0) AS salary , Year_of_Joining Y FROM hr_2
INNER JOIN hr_1
ON hr_1.EmployeeNumber = hr_2.Employee_ID
GROUP BY Y
ORDER BY salary DESC
LIMIT 010;

SELECT Department,WorkLifeBalance, COUNT(*) AS COUNT FROM hr_2
INNER JOIN hr_1
ON hr_1.EmployeeNumber = hr_2.Employee_ID
WHERE Attrition = 'Yes'
GROUP BY Department,WorkLifeBalance
ORDER BY Department,WorkLifeBalance,COUNT DESC
LIMIT 10;

SELECT WorkLifeBalance,Department, COUNT(*) AS COUNT FROM hr_1
LEFT JOIN hr_2
ON hr_1.EmployeeNumber = hr_2.Employee_ID
WHERE Attrition = 'Yes'
GROUP BY Department,WorkLifeBalance
ORDER BY Department,WorkLifeBalance,COUNT DESC;









create table salespeople(
Snum int unsigned,
sname varchar(30),
city varchar(20),
comm decimal(10,2));

insert into salespeople (Snum,sname,city,comm) values (1001,'Peel','London',0.12),(1002,'Serres','San Jose',0.13),(1003,'Axelrod','New york',0.10),(1004,'Motika','London',0.11),(1007,'Rafkin','Barcelona',0.15); 

SELECT  * FROM salespeople;

set sql_safe_updates = 0;

create table cust(
cnum int(20),
cname varchar(30),
city varchar(20),
rating int(20),
snum int(20));

insert into cust(cnum,cname,city,rating,snum) values (2001,'Hoffman','London',100,1001);
insert into cust(cnum,cname,city,rating,snum) values (2002,'Giovanne','Rome',200,1003);
insert into cust(cnum,cname,city,rating,snum) values (2003,'Liu','San Josh',300,1002);
insert into cust(cnum,cname,city,rating,snum) values (2004,'Grass','Berlin',100,1002);
insert into cust(cnum,cname,city,rating,snum) values (2006,'Clemens','London',300,1007);
insert into cust(cnum,cname,city,rating,snum) values (2007,'Pereira','Rome',100,1004);
insert into cust(cnum,cname,city,rating,snum) values (2008,'James','London',200,1007);

SELECT * FROM cust;

create table Orders(
onum int,
amt decimal(10,2),
odate date,
cnum int(20),
snum int(20));

insert into Orders(onum,amt,odate,cnum,snum) values (3001,18.69,'1994-10-03',2008,1007),(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19,'1994-10-03',2001,1001),(3005,5160.45,'1994-10-03',2003,1002),(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),(3008,4723.00,'1994-10-05',2006,1001),(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),(3011,9891.88,'1994-10-06',2006,1001);

SELECT * FROM Orders;

-- 4.	Write a query to match the salespeople to the customers according to the city they are living.

SELECT salespeople.sname AS "Salesman",
cust.cname as customer, cust.city 
FROM salespeople,cust
WHERE salespeople.city=cust.city;

-- 5.	Write a query to select the names of customers and the salespersons who are providing service to them.

SELECT salespeople.sname,cust.cname
FROM salespeople,cust
WHERE salespeople.snum = cust.snum;

SELECT salespeople.sname,cust.cname FROM salespeople
INNER JOIN cust
WHERE salespeople.snum = cust.snum;

-- 6.	Write a query to find out all orders by customers not located in the same cities as that of their salespeople

SELECT orders.onum, cust.cname, cust.cnum, salespeople.sname 
FROM orders , cust, salespeople
WHERE cust.city <> salespeople.city 
AND orders.cnum = cust.cnum
AND orders.snum = salespeople.snum;

select cust.cname,salespeople.sname,salespeople.city
from salespeople
join cust
on salespeople.city = cust.city;

-- 7.	Write a query that lists each order number followed by name of customer who made that order 
 
 SELECT orders.onum, cust.cname from cust,orders
 WHERE orders.cnum = cust.cnum;

-- 8.	Write a query that finds all pairs of customers having the same rating………………

SELECT cust.cname, cust.rating as rate FROM cust
ORDER BY rate DESC;

SELECT c1.cname, c2.cname,c1.rating
FROM cust c1, cust c2
WHERE c1.rating = c2.rating AND c1.cname < c2.cname
ORDER BY c1.rating;

-- 9.	Write a query to find out all pairs of customers served by a single salesperson………………

SELECT cust.cname, salespeople.sname FROM cust, salespeople
WHERE cust.snum = salespeople.snum
GROUP BY salespeople.sname, cust.cname
ORDER BY salespeople.sname;

-- 10.	Write a query that produces all pairs of salespeople who are living in same city………………..
 
SELECT s1.sname, s2.sname, s1.city 
FROM salespeople s1 , salespeople s2
WHERE s1.city = s2.city AND s1.sname < s2.sname;

-- 11.	Write a Query to find all orders credited to the same salesperson who services Customer 2008

-- 12.	Write a Query to find out all orders that are greater than the average for Oct 4th

 SELECT * FROM orders
 WHERE amt > 
	( SELECT AVG(amt)  FROM orders
	  where odate = '1994-10-04');
      

-- 13.	Write a Query to find all orders attributed to salespeople in London.
	
SELECT * FROM orders
WHERE snum IN
    (SELECT Snum
     FROM salespeople
     WHERE city ='London');
     
-- 14.	Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 

