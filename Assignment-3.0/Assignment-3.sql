-- deletes database
DROP DATABASE companydb1;
-- creates database
CREATE DATABASE IF NOT EXISTS Companydb1;
USE Companydb1;
-- creates table
CREATE TABLE IF NOT EXISTS Branch(
	Branch_id SMALLINT NOT NULL,
    `Branch Name` VARCHAR(45),
    Location VARCHAR(45),
    PRIMARY KEY(Branch_id)
);
CREATE TABLE IF NOT EXISTS Employee(
	Employee_id SMALLINT NOT NULL PRIMARY KEY,
    `First Name` VARCHAR(45),
    `Last Name` VARCHAR(45),
    DoB DATE,
    Salary INT,
    Branch_id SMALLINT,
	FOREIGN KEY(Branch_id) REFERENCES Branch(Branch_id)
);
-- returns schema of Employee table
DESCRIBE Employee;
-- creates manager table by copying employee table
CREATE TABLE Manager AS( SELECT * FROM Employee);
-- deletes manager table
DROP TABLE Manager; 
-- DESCRIBE Manager;
-- Shows all tables in the database
SHOW TABLES;
INSERT INTO Branch VALUES
	(01, 'Scranton', 'Pennsylvania'),
    (02, 'Corporate', 'New York'),
    (03, 'Nashua', 'New Hampshire'),
    (04, 'Stamford', 'Connecticut'),
    (05, 'Utica', 'New York');
INSERT INTO Employee VALUES
	(101, 'Michael', 'Scott', '1970-03-15', 150500, 01),
    (102, 'Jan', 'Levinson', '1971-12-10', 250000, 02),
    (103, 'Andy', 'Bernard', '1975-09-20', 90000, 04),
    (104, 'Karen','Filipelli', '1980-08-19', 95000, 05),
    (105, 'Jim', 'Halpert', '1978-10-01',90000, 01);
SELECT * FROM Employee;
SELECT `First NAme`, Salary FROM Employee;
-- Returns Data of employees with salary less than 1,00,000 
SELECT * FROM Employee WHERE Employee.Salary<100000;
-- Returns data of employees working in new york or pennsylvania
SELECT * FROM Branch WHERE Location='New York' OR Location='Pennsylvania';
-- Gives names of employees working in New York 
SELECT `First Name` 
FROM Employee 
WHERE Branch_id IN (SELECT Branch_id FROM Branch WHERE Location='New York');