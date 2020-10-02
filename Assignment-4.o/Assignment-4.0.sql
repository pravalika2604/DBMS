-- ASSIGNMENT 4
Use Companydatabase;
CREATE TABLE IF NOT EXISTS Projects(
	Project_id INT NOT NULL,
    Employee_id SMALLINT NOT NULL,
    FOREIGN KEY(Employee_id) REFERENCES Employee(Employee_id)
);
INSERT INTO  Projects VALUES
	(1001, 101),
    (1001, 102),
    (1002, 103),
    (1002, 101),
    (1002, 104);
SELECT * FROM Projects;
-- Shows employees salary in descending order and then employee id in ascending
SELECT * FROM Employee ORDER BY Salary DESC, Employee_id;
INSERT INTO Employee VALUES
	(106, 'Pam', 'Beesly', '1979-03-15', 90000, 1),
    (107, 'Dwight', 'Shrute', '1974-09-12', 90000, 1);
SELECT * FROM Employee;
-- groups the people in terms of their branch and salary, and in that lists those with branch_id 1
SELECT * FROM Employee GROUP BY Salary, Branch_id HAVING Branch_id=1;
-- returns the different number of branches the employees belong to(total employees=7)
SELECT COUNT(DISTINCT Branch_id) FROM Employee;
-- returns the maximum salary
SELECT MAX(Salary) FROM Employee;
-- returns the average salary of the office
SELECT AVG(Salary) FROM Employee;
-- returns employees with first names that contain the letter e or an i
SELECT Employee_id, `First Name` FROM Employee WHERE `First Name` LIKE '%e%' OR `First Name` LIKE '%i%';
-- NESTED SUBQUERIES
-- returns employees with salary greater than the average salary
SELECT * FROM Employee WHERE Salary > (SELECT AVG(Salary) FROM Employee);
-- returns branches with employees whose salary is less than average
SELECT * FROM Branch 
	WHERE Branch_id IN (
			SELECT Branch_id FROM Employee
				WHERE Salary < (
					SELECT AVG(Salary) FROM Employee));
-- returns branches with employees with age greater than average
SELECT Branch_id, `Branch Name` FROM Branch
			WHERE Branch_id IN(
					SELECT Branch_id FROM Employee 
							WHERE year(curdate())-year(DoB)   > (
									SELECT AVG(year(curdate())-year(DoB)) FROM Employee));
-- returns the projects done by employees working in branch 01
SELECT Project_id FROM Projects
		WHERE Employee_id IN(
				SELECT Employee_id FROM Employee
							WHERE Branch_id =01);
