use DATABRICKS;
show tables;
drop table employee;
create table employees(emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    experience INT
);
describe table employees;
insert into employees values(101, 'Rahul', 'IT', 75000, 'Hyderabad', 5),
(102, 'Anjali', 'HR', 45000, 'Chennai', 3),
(103, 'Kiran', 'IT', 82000, 'Bangalore', 6),
(104, 'Sneha', 'Finance', 67000, 'Hyderabad', 4),
(105, 'Aman', 'HR', 39000, 'Pune', 2),
(106, 'Ravi', 'Finance', 91000, 'Mumbai', 8),
(107, 'Divya', 'IT', 55000, 'Chennai', 3),
(108, 'Meena', 'Sales', 48000, 'Bangalore', 2),
(109, 'Arjun', 'Sales', 61000, 'Hyderabad', 5),
(110, 'Pooja', 'IT', 73000, 'Mumbai', 4),
(111, 'Vikas', 'HR', 52000, 'Pune', 3),
(112, 'Nisha', 'Finance', 88000, 'Bangalore', 7),
(113, 'Tarun', 'Sales', 46000, 'Chennai', 2),
(114, 'Kavya', 'IT', 97000, 'Hyderabad', 9),
(115, 'Manoj', 'Finance', 58000, 'Mumbai', 4);
-- 1. Display all employee details.
select * from employees;
-- 2. Display only employee names and salaries.
select emp_name,salary from employees;
-- 3. Display employee names and departments.
select emp_name,department from employees;
-- 4. Display all employees from the IT department.
select * from employees where department='IT';
-- 5. Display employee names and experience.
select emp_name,experience from employees;

-- =========================================
-- WHERE
-- =========================================

-- 1. Find employees with salary greater than 70000.
select * from employees where salary>70000;
-- 2. Find departments where average salary is greater than 60000.
select department,avg(salary) as avg_salary from employees group by department having avg_salary>60000;
-- 3. Find cities having more than 2 employees.
select city,count(*) as count_of_employees from employees group by city having count_of_employees>2;
-- 4. Find departments where total salary is greater than 200000.
select department,sum(salary) as total from employees group by department having total>200000;
-- 5. Find departments where maximum salary is above 90000.
select department,max(salary) as max_salary from employees group by department having max_salary>90000;


-- =========================================
-- TOP (LIMIT IN MYSQL)
-- =========================================


-- 1. Display top 5 highest paid employees.
select * from employees order by salary desc limit 5;
-- 2. Display top 3 employees with highest experience.
select * from employees order by experience desc limit 3;
-- 3. Display top 2 salaries from Finance department.
select * from employees where department='Finance' order by salary desc limit 2;
-- 4. Display top 4 employees from Hyderabad.
select * from employees where city='Hyderabad' limit 4;
-- 5. Display top 1 highest salary employee.
select * from employees order by salary desc limit 1;

-- =========================================
-- DISTINCT
-- =========================================

-- 1. Display distinct department names.
select distinct department from employees;
-- 2. Display distinct city names.
select distinct city from employees;
-- 3. Display distinct salary values.
select distinct salary from employees;
-- 4. Display distinct combinations of department and city.
SELECT DISTINCT department, city
FROM Employees;
-- 5. Display distinct experience values.
SELECT DISTINCT experience
FROM Employees;
-- =========================================
-- COMPARISON OPERATORS
-- =========================================

-- 1. Find employees with salary >= 80000.
select * from employees where salary>=80000;
-- 2. Find employees with experience <= 3.
select * from employees where experience<=3;
-- 3. Find employees whose salary <> 45000.
select * from employees where salary<>45000;
-- 4. Find employees with salary < 50000.
select * from employees where salary<50000;
-- 5. Find employees with experience > 5
select * from employees where experience>5;

-- =========================================
-- LOGICAL OPERATORS
-- =========================================

-- 1. Find employees from IT department AND salary greater than 70000.
select * from employees where salary>70000 and department='IT';
-- 2. Find employees from Hyderabad OR Bangalore.
SELECT *
FROM Employees
WHERE city = 'Hyderabad'
OR city = 'Bangalore';

-- 3. Find employees from HR department AND experience less than 3.
SELECT *
FROM Employees
WHERE department = 'HR'
AND experience < 3;

-- 4. Find employees with salary greater than 60000 OR experience greater than 6.
SELECT *
FROM Employees
WHERE salary > 60000
OR experience > 6;

-- 5. Find employees NOT from Sales department.
SELECT *
FROM Employees
WHERE department != 'Sales';

-- =========================================
-- IN AND NOT IN
-- =========================================

-- 1. Find employees working in ('Hyderabad', 'Mumbai').
select * from employees where city in ('Hyderabad', 'Mumbai');
-- 2. Find employees whose department IN ('IT', 'Finance').
SELECT *
FROM Employees
WHERE department IN ('IT', 'Finance');

-- 3. Find employees whose city NOT IN ('Chennai', 'Pune').
SELECT *
FROM Employees
WHERE city NOT IN ('Chennai', 'Pune');

-- 4. Find employees whose salary IN (45000, 75000, 91000).
SELECT *
FROM Employees
WHERE salary IN (45000, 75000, 91000);

-- 5. Find employees whose department NOT IN ('HR', 'Sales').
SELECT *
FROM Employees
WHERE department NOT IN ('HR', 'Sales');

-- =========================================
-- BETWEEN
-- =========================================
-- 1. Find employees with salary BETWEEN 50000 AND 80000.
SELECT *
FROM Employees
WHERE salary BETWEEN 50000 AND 80000;

-- 2. Find employees with experience BETWEEN 3 AND 6.
SELECT *
FROM Employees
WHERE experience BETWEEN 3 AND 6;

-- 3. Find employees whose emp_id BETWEEN 105 AND 112.
SELECT *
FROM Employees
WHERE emp_id BETWEEN 105 AND 112;

-- 4. Find employees with salary NOT BETWEEN 40000 AND 60000.
SELECT *
FROM Employees
WHERE salary NOT BETWEEN 40000 AND 60000;

-- 5. Find employees with experience BETWEEN 2 AND 4.
SELECT *
FROM Employees
WHERE experience BETWEEN 2 AND 4;


-- =========================================
-- LIKE OPERATOR
-- =========================================

-- 1. Find employees whose names start with 'R'.
SELECT *
FROM Employees
WHERE emp_name LIKE 'R%';

-- 2. Find employees whose names end with 'a'.
SELECT *
FROM Employees
WHERE emp_name LIKE '%a';

-- 3. Find employees whose names contain 'v'.
SELECT *
FROM Employees
WHERE emp_name LIKE '%v%';
-- 4. Find employees whose city starts with 'B'.
SELECT *
FROM Employees
WHERE city LIKE 'B%';

-- 5. Find employees whose department ends with 's'.
SELECT *
FROM Employees
WHERE department LIKE '%s';