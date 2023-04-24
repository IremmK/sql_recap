CREATE TABLE countries
(
    country_id CHAR(3),
    country_name VARCHAR(50),
    region_id SMALLINT
);
Insert into countries values ('AR','Argentina',2);
Insert into countries values ('AU','Australia',3);
Insert into countries values ('BE','Belgium',1);
Insert into countries values ('BR','Brazil',2);
Insert into countries values ('CA','Canada',2);
Insert into countries values ('CH','Switzerland',1);
Insert into countries values ('CN','China',3);
Insert into countries values ('DE','Germany',1);
Insert into countries values ('DK','Denmark',1);
Insert into countries values ('EG','Egypt',4);
Insert into countries values ('FR','France',1);
Insert into countries values ('IL','Israel',4);
Insert into countries values ('IN','India',3);
Insert into countries values ('IT','Italy',1);
Insert into countries values ('JP','Japan',3);
Insert into countries values ('KW','Kuwait',4);
Insert into countries values ('ML','Malaysia',3);
Insert into countries values ('MX','Mexico',2);
Insert into countries values ('NG','Nigeria',4);
Insert into countries values ('NL','Netherlands',1);
Insert into countries values ('SG','Singapore',3);
Insert into countries values ('UK','United Kingdom',1);
Insert into countries values ('US','United States of America',2);
Insert into countries values ('ZM','Zambia',4);
Insert into countries values ('ZW','Zimbabwe',4);
------------------------------------------------
CREATE TABLE companies
(
  company_id SMALLINT,
  company VARCHAR(20),
  number_of_employees SMALLINT
);
INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);
SELECT * FROM companies;
--1.Example: Find the company and number_of_employees whose number_of_employees is the second highest from the companies table
SELECT company , number_of_employees FROM companies
WHERE number_of_employees = (SELCT MAX (number_of_employees) FROM companies 
							 WHERE number_of_employees < 
						    (SELECT MAX (number_of_employees) FROM companies))
							
--2.WAY: 
SELECT company , number_of_employees FROM companies ORDER BY number_of_employees DESC OFFSET 1 ROW LIMIT 1

--2.Example: Find the company names and number of employees whose number of employees is less than the average number of employees
SELECT company , number_of_employees FROM companies WHERE number_of_employees< (SELECT AVG (number_of_employees) FROM companies)

--1.Example: Update the number of employees to 16000 if the number of employees is less than the average number of employees
UPDATE companies SET number_of_employees=16000 WHERE number_of_employees < (SELECT AVG (number_of_employees) FROM companies)

--1.Example: Update the number of employees to 9999 if the company name is IBM by using prepared statement
 UPDATE companies SET number_of_employees = 9999 WHERE company = 'IBM'
 
 --2.Example: Update the number of employees to 5555 if the company name is GOOGLE by using prepared statement
 UPDATE companies SET number_of_employes = 5555 WHERE company= 'GOOGLE'
 
 --1.Example: Create a function which uses 2 parameters and return the sum of the parameters
CREATE OR REPLACE FUNCTION additionF (x NUMERIC ,y NUMERIC) RETURNS NUMERIC LANGUAGE plpgsql AS $$ BEGIN  RETURN x+y; END $$ 

--2.Example: Create a function which calculates the volume of cone
CREATE OR REPLACE FUNCTION volume (r NUMERIC ,p NUMERIC ,h NUMERIC ) LANGUAGE plpgsql AS  

SELECT * FROM companies





