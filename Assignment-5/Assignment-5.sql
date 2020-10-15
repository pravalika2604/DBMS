-- Assignment 5
USE Companydb1;
-- made employee id in projects table null because some projects may remain unassigned
ALTER TABLE projects
MODIFY COLUMN Employee_id SMALLINT;
INSERT INTO Projects  VALUES (1003,107), (1003,105);
-- unassigned projects
INSERT INTO Projects (Project_id) VALUES (1004), (1005);
INSERT INTO employee VALUES (108, 'Creed', 'Bratton', '1950-08-10', 70000, 1), (109, 'David', 'Wallce', '1969-05-05', 250000, 2), (110, 'AJ', NULL , '1972-07-20', 90000, 3);

-- 1. Returns the employees that are assigned to a project
SELECT 
    Employee.Employee_id,
    employee.`First Name`,
    projects.Project_id
FROM
    projects
        INNER JOIN
    employee ON employee.Employee_id = projects.Employee_id
ORDER BY employee.Employee_id;

-- 2. Returns the employees and the projects assigned to them from the scranton branch
SELECT 
    Employee.Employee_id,
    employee.`First Name`,
    projects.Project_id
FROM
    projects
        INNER JOIN
    employee ON employee.Employee_id = projects.Employee_id
WHERE
    employee.Branch_id = (SELECT 
            Branch_id
        FROM
            branch
        WHERE
            `Branch Name` = 'Scranton')
ORDER BY employee.Employee_id;
                                                    
-- 3. Returns the project ids that have been assigned to employees along with their branch
SELECT 
    employee.Employee_id,
    employee.`First Name`,
    projects.Project_id,
    branch.`Branch Name`
FROM
    projects
        INNER JOIN
    employee ON employee.Employee_id = projects.Employee_id
        INNER JOIN
    branch ON branch.Branch_id = employee.Branch_id
ORDER BY employee.Employee_id;

-- 4. Returns all employees and their project ids
SELECT 
    Employee.Employee_id,
    employee.`First Name`,
    projects.Project_id
FROM
    employee
        LEFT JOIN
    projects ON employee.Employee_id = projects.Employee_id
ORDER BY employee.Employee_id;


-- 5. Returns the employees and their branch names who have been assigned to projects 1002 and 1003
SELECT 
    employee.Employee_id,
    employee.`First Name`,
    branch.`Branch Name`
FROM
    employee
        LEFT JOIN
    branch ON employee.Branch_id = branch.Branch_id
WHERE
    employee.Employee_id IN (SELECT 
            Employee_id
        FROM
            projects
        WHERE
            Project_id = 1002 AND 1003)
ORDER BY Employee_id;
            
-- 6. Returns employees with salary greater than 90000 who have been assigned a project
SELECT 
    employee.Employee_id,
    employee.`First Name`,
    projects.Project_id
FROM
    projects
        LEFT JOIN
    employee ON employee.Employee_id = projects.Employee_id
WHERE
    employee.Salary > 90000
ORDER BY `First Name`;

-- 7. Returns all the projects and the employees assigned to them
SELECT 
    Employee.Employee_id,
    employee.`First Name`,
    projects.Project_id
FROM
    employee
        RIGHT JOIN
    projects ON employee.Employee_id = projects.Employee_id
ORDER BY projects.Project_id;

-- 8. Returns projects assigned to those employees with below average age
SELECT 
    Employee.Employee_id,
    employee.`First Name`,
    projects.Project_id,
    YEAR(CURDATE()) - YEAR(DoB) AS Age
FROM
    employee
        RIGHT JOIN
    projects ON employee.Employee_id = projects.Employee_id
WHERE
    YEAR(CURDATE()) - YEAR(DoB) < (SELECT 
            AVG(YEAR(CURDATE()) - YEAR(DoB))
        FROM
            Employee)
ORDER BY projects.Project_id;

-- 9. Returns all the branches that have been assigned projects
SELECT 
    branch.Branch_id, branch.`Branch Name`
FROM
    projects
        INNER JOIN
    employee ON employee.Employee_id = projects.Employee_id
        RIGHT JOIN
    branch ON employee.Branch_id = branch.Branch_id
WHERE
    projects.Employee_id IS NOT NULL
GROUP BY `Branch Name`;