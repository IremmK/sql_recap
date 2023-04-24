CREATE TABLE workers
(
    id SMALLINT,
    name VARCHAR(50),
    salary SMALLINT,
    CONSTRAINT id4_pk PRIMARY KEY(id)
);
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);
SELECT * FROM workers;

--Find rhe max and min salary values having records from the table.
--YOUR WAY:
SELECT MAX(salary) FROM workers;
SELECT MIN (salary) FROM workers;
--TEACHERS'S WAY:
SELECT* FROM workers
WHERE salary IN ((SELECT MAX (salary) FROM workers),(SELECT MIN (salary) FROM workers));
--TEACHER'S 2.WAY:
SELECT * FROM workers
WHERE salary= (SELECT MAX(salary) FROM workers) OR salary= (SELECT MIN (salary) FROM workers);

--'AS' keyword is use to create a temporary field from your table
--Find the highest salary and d'splay the data under the highest salary heading
SELECT MAX (salary) AS the_highest_salary 
FROM workers;

--Find the lowest salary and use 'AS' keyword
SELECT MIN(salary) AS the_lowest_salary
FROM workers;

--Find the average salary and use 'AS' keyword
SELECT AVG (salary) AS average_salary
FROM workers;

--Find the total num of the records
SELECT COUNT (name) AS number_of_workers
FROM workers;

--Find the total value of salaries
SELECT SUM (salary) AS total_salary
FROM workers;

--What are the 'Aggregate Functions' in SQL?
--SUM, COUNT, MAX, MIN, AVG

--INTERVIEW QUESTION: Find the second highest salary?
SELECT MAX (salary) AS second_highest_salary
FROM workers 
WHERE salary<(SELECT MAX(salary) FROM workers);

--Interview Question: Find the second lowest salary
SELECT MIN (salary) AS second_lowest_salary
FROM workers
WHERE salary> (SELECT MIN(salary) FROM workers);

--IQ: Find the third highest salary
SELECT MAX (salary) AS third_highest_salary
FROM workers
WHERE salary<(SELECT MAX (salary)
FROM workers
WHERE salary<(SELECT MAX (salary) FROM workers)) ;
--Here we use sub query because we use multiple select and where keywords
--2.WAY: By using "order by" aggregate function 
SELECT * FROM workers 
ORDER BY salary DESC 
OFFSET 2 ROW 
FETCH NEXT 1 ROW ONLY;

--*****************************************
CREATE TABLE customers_products
( 
  product_id INT,
  customer_name VARCHAR(50),
  product_name VARCHAR(50)
);
 
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy', 'Palm');
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple'); 
SELECT * FROM customers_products;

-- Find the records that has the customer product name value as Orange, apple or palm
SELECT * FROM customers_products
WHERE product_name ='Apple' OR product_name='Orange' OR product_name='Palm';

SELECT * FROM customers_products
WHERE product_name IN ('Orange', 'Apple','Palm');

--Find the records that has the product name not to be apple, orange or palm
SELECT * FROM customers_products
WHERE product_name NOT IN ('Apple', 'Orange', 'Palm');

--BETWEEN--> YOU can select or using not between you can eliminate the reading options

--find the product_name that have product_id les tan 30 or equal to 30 and greater and equal to20
--1.way: 
SELECT * FROM customers_products
WHERE product_id <= 30 AND product_id >=20;
--2.way:recommended
SELECT* FROM customers_products
WHERE product_id BETWEEN 20 AND 30;

--> BETWEEN condition except the given value as "inclusive"
--HOMEWORK: 	Find the product_name whose id is less than 20 and greater than 30
--1.Way:
SELECT * FROM customers_products
WHERE product_id< 20 OR product_id >30;

--2.Way: use not between condition
SELECt * FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 30;
--**********************************************************
CREATE TABLE customers_likes
( 
  product_id CHAR(10),
  customer_name VARCHAR(50),
  liked_product VARCHAR(50)
);


INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');

SELECT* FROM customers_likes;

--EXIST CONDITION --> we use 'EXISTS' condition with sub-query.
--If the sub-query selects a data then the exists condition can be used
--If the sub-query does not find any data then "outer query" cannot be executed
--We can use exists condition with select, insert, update, delete commands.

--If the customer name field has 'lary' among the customer name field update all customer name field as" no name"
UPDATE customers_likes
SET customer_name = 'No Name'
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE customer_name='Lary' );

--If among the liked product orange or pineapple or avocado exists then update all customer names to no name 
UPDATE customers_likes
SET customer_name='Murat'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE liked_product IN ('Orange','Pineapple','Avocado'));


SELECT * FROM customers_likes;

--Delete all the records if orange exists among the liked_product
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product='Orange');
SELECT * FROM customers_likes;

--*******************************************************************
--SUBQUERY

CREATE TABLE employees 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM employees;

CREATE TABLE companies
(
  company_id CHAR(9),
  company VARCHAR(20),
  number_of_employees SMALLINT
);
INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);
SELECT * FROM companies;

--Find the names and company names that has number_of_employees > than 15000 
SELECT name, company 
FROM employees 
WHERE company IN (SELECT company FROM companies WHERE number_of_employees > 15000);

--Find the company names and company ids which are in Florida
SELECT company, company_id
FROM companies 
WHERE company IN (SELECT company FROM employees WHERE state='Florida' );

--Find the company names and their states whose id is greater than 100 
  SELECT name, state, company
    FROM employees
    WHERE company IN(SELECT company FROM companies WHERE company_id>100);











