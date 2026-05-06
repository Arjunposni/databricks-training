use DATABRICKS;
-- 1. Select all columns from the Employee table.
select * from employee;
-- 2. Select only the name and salary columns from the Employee table.
select name,salary from employee;
-- 3. Select employees who are older than 30.
select * from employee where age>30;
-- 4. Select the names of all departments.
select name from department;
-- 5. Select employees who work in the IT department.
select e.* from employee e join department d on e.department_id=d.department_id where d.name='IT';
-- 6. Select employees whose names start with ‘J’.
select * from employee where name like 'J%';
-- 7. Select employees whose names end with ‘e’.
select * from employee where name like '%e';
-- 8. Select employees whose names contain ‘a’.
select * from employee where name like '%a%';
-- 9. Select employees whose names are exactly 9 characters long.
select * from employee where length(name)=9;
-- 10. Select employees whose names have ‘o’ as the second character.
select * from employee where name like '_o%';
-- 11. Select employees hired in the year 2020.
select * from employee where year(hire_date)=2020;
-- 12. Select employees hired in January of any year.
select * from employee where month(hire_date)=1;
-- 13. Select employees hired before 2019.
select * from employee where hire_date<'2019-01-01';
-- 14. Select employees hired on or after March 1, 2021.
select * from employee where hire_date<='2021-03-01';
-- 15. Select employees hired in the last 2 years.
select * from employee where hire_date>=current_date - interval 2 YEAR;
-- 16. Select the total salary of all employees.
select sum(salary) as total_salary from employee;
-- 17. Select the average salary of employees.
select avg(salary) as avg_salary from employee;
-- 18. Select the minimum salary in the Employee table.
select min(salary) as min_salary from employee;
-- 19. Select the number of employees in each department.	
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id;
-- 20. Select the average salary of employees in each department.
select department_id, avg(salary) as avg__of_department from employee group by department_id;
-- 21. Select the total salary for each department.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;
-- 22. Select the average age of employees in each department. 
SELECT department_id, AVG(age) AS average_age
FROM Employee
GROUP BY department_id;
-- 23. Select the number of employees hired in each year.
SELECT YEAR(hire_date) AS hire_year, COUNT(*) AS employee_count
FROM Employee
GROUP BY YEAR(hire_date);
-- 24. Select the highest salary in each department.
select department_id,max(salary) from employee group by department_id;
-- 25. Select the department with the highest average salary.
select department_id,avg(salary) as avg_salary from employee group by department_id order by avg_salary limit 1;
-- 26. Select departments with more than 2 employees.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;
-- 27. Select departments with an average salary greater than 55000.
select department_id,avg(salary) as avg_salary from employee group by department_id having avg_salary>55000;
-- 28. Select years with more than 1 employee hired.
select year(hire_date),count(*) as employee_count from employee group by year(hire_date) having count(*)>1;
-- 29. Select departments with a total salary expense less than 100000.
select department_id, sum(salary) as total_salary from employee group by department_id having total_salary<100000;
-- 30. Select departments with the maximum salary above 75000.
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;
-- 31. Select all employees ordered by their salary in ascending order.
select * from employee order by salary asc;
-- 32. Select all employees ordered by their age in descending order.
SELECT * FROM Employee
ORDER BY age DESC;
-- 33. Select all employees ordered by their hire date in ascending order.
SELECT * FROM Employee
ORDER BY hire_date ASC;
-- 34. Select employees ordered by their department and then by their salary.
SELECT * FROM Employee
ORDER BY department_id, salary;
-- 35. Select departments ordered by the total salary of their employees.
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id
ORDER BY total_salary DESC;
-- 36. Select employee names along with their department names.
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id;

-- 37. Select project names along with the department names they belong to.
SELECT p.name AS project_name, d.name AS department_name
FROM Project p
JOIN Department d
ON p.department_id = d.department_id;

-- 38. Select employee names and their corresponding project names.
SELECT e.name AS employee_name, p.name AS project_name
FROM Employee e
JOIN Project p
ON e.department_id = p.department_id;

-- 39. Select all employees and their departments, including those without a department.
SELECT e.name, d.name AS department_name
FROM Employee e
LEFT JOIN Department d
ON e.department_id = d.department_id;

-- 40. Select all departments and their employees, including departments without employees.
SELECT d.name AS department_name, e.name AS employee_name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id;

-- 41. Select employees who are not assigned to any project.
SELECT e.name
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
WHERE p.project_id IS NULL;

-- 42. Select employees and the number of projects their department is working on.
SELECT e.name, COUNT(p.project_id) AS project_count
FROM Employee e
LEFT JOIN Project p
ON e.department_id = p.department_id
GROUP BY e.name;

-- 43. Select the departments that have no employees.
SELECT d.name
FROM Department d
LEFT JOIN Employee e
ON d.department_id = e.department_id
WHERE e.emp_id IS NULL;

-- 44. Select employee names who share the same department with ‘John Doe’.
SELECT name
FROM Employee
WHERE department_id = (
    SELECT department_id
    FROM Employee
    WHERE name = 'John Doe'
);

-- 45. Select the department name with the highest average salary.
SELECT d.name
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
GROUP BY d.name
ORDER BY AVG(e.salary) DESC
LIMIT 1;

-- 46. Select the employee with the highest salary.
SELECT *
FROM Employee
WHERE salary = (
    SELECT MAX(salary)
    FROM Employee
);

-- 47. Select employees whose salary is above the average salary.
SELECT *
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);

-- 48. Select the second highest salary from the Employee table.
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (
    SELECT MAX(salary)
    FROM Employee
);

-- 49. Select the department with the most employees.
SELECT department_id, COUNT(*) AS employee_count
FROM Employee
GROUP BY department_id
ORDER BY employee_count DESC
LIMIT 1;

-- 50. Select employees who earn more than the average salary of their department.
SELECT e.name, e.salary
FROM Employee e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 51. Select the nth highest salary (for example, 3rd highest).
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 2;

-- 52. Select employees who are older than all employees in the HR department.
SELECT *
FROM Employee
WHERE age > ALL (
    SELECT age
    FROM Employee
    WHERE department_id = (
        SELECT department_id
        FROM Department
        WHERE name = 'HR'
    )
);

-- 53. Select departments where the average salary is greater than 55000.
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- 54. Select employees who work in a department with at least 2 projects.
SELECT e.name
FROM Employee e
WHERE e.department_id IN (
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(project_id) >= 2
);

-- 55. Select employees who were hired on the same date as ‘Jane Smith’.
SELECT *
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    WHERE name = 'Jane Smith'
);

-- 56. Select the total salary of employees hired in the year 2020.
SELECT SUM(salary) AS total_salary
FROM Employee
WHERE YEAR(hire_date) = 2020;

-- 57. Select the average salary of employees in each department, ordered by average salary descending.
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
ORDER BY avg_salary DESC;

-- 58. Select departments with more than 1 employee and average salary greater than 55000.
SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 1 AND AVG(salary) > 55000;

-- 59. Select employees hired in the last 2 years, ordered by hire date.
SELECT *
FROM Employee
WHERE hire_date >= CURRENT_DATE - INTERVAL 2 YEAR
ORDER BY hire_date;

-- 60. Select the total number of employees and average salary for departments with more than 2 employees.
SELECT department_id, COUNT(*) AS total_employees, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 61. Select the name and salary of employees whose salary is above the department average.
SELECT e.name, e.salary
FROM Employee e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 62. Select employees hired on the same date as the oldest employee.
SELECT name
FROM Employee
WHERE hire_date = (
    SELECT hire_date
    FROM Employee
    WHERE age = (
        SELECT MAX(age)
        FROM Employee
    )
);

-- 63. Select department names along with total projects, ordered by project count.
SELECT d.name AS department_name, COUNT(p.project_id) AS total_projects
FROM Department d
LEFT JOIN Project p
ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY total_projects DESC;

-- 64. Select the employee with the highest salary in each department.
SELECT e.department_id, e.name, e.salary
FROM Employee e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);

-- 65. Select employees older than the average age of their department.
SELECT e.name, e.salary
FROM Employee e
WHERE e.age > (
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);
