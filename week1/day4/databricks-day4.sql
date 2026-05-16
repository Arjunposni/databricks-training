use databricks;
drop table employees;
-- ============================================
-- TABLE: employees
-- ============================================

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);
INSERT INTO employees VALUES
(1, 'Alice Johnson', 'Sales', 70000, '2020-01-15'),
(2, 'Bob Smith', 'Sales', 65000, '2021-03-20'),
(3, 'Charlie Brown', 'IT', 90000, '2019-07-01'),
(4, 'Diana Prince', 'IT', 95000, '2018-11-11');
-- ============================================
-- TABLE: orders
-- ============================================

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount INT
);

INSERT INTO orders VALUES
(101, 1, 1, '2024-01-10', 500),
(102, 2, 2, '2024-01-11', 700),
(103, 1, 1, '2024-01-15', 1200),
(104, 3, 3, '2024-01-18', 300);
-- ============================================
-- WINDOW FUNCTIONS & CTE ASSIGNMENT
-- ============================================
-- 1. Assign row number ordered by salary descending
SELECT *,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM employees;

-- 2. Rank employees by salary
select *,rank() over(order by salary desc) as rank_num from employees;

-- 3. Dense rank employees by salary
select *,dense_rank() over(order by salary desc) as salary_dense_rank from employees;

-- 4. Top 3 highest-paid employees
select * from(select *,row_number() over(order by salary desc) as rn from employees) t where rn<4;

-- 5. Rank employees within each department
select *,rank() over(partition by department order by salary) as dept_rank from employees;

-- 6. Highest salary in each department
select * from(select *,rank() over(partition by department order by salary desc) as rn from employees ) t where rn<2;

-- 7. Running total of order amounts
SELECT *,
SUM(total_amount) OVER(ORDER BY order_date) AS running_total
FROM orders;

-- 8. Cumulative sales amount for each employee
SELECT *,
SUM(total_amount) OVER(PARTITION BY employee_id ORDER BY order_date) AS cumulative_sales
FROM orders;
-- =========================================
-- 9. Use LAG() to show the previous order 
--    amount for each customer.
-- =========================================
SELECT customer_id, order_id, total_amount,
LAG(total_amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
) AS previous_order
FROM orders;
-- =========================================
-- 10. Use LEAD() to show the next order 
--     amount for each customer.
-- =========================================
SELECT customer_id, order_id, total_amount,
LEAD(total_amount) OVER(
    PARTITION BY customer_id
    ORDER BY order_date
) AS next_order
FROM orders;
-- =========================================
-- 11. Find the difference between the 
--     current order amount and previous 
--     order amount.
-- =========================================
select customer_id,order_id,total_amount,total_amount-lag(total_amount) over(partition by customer_id order by order_date) as difference  from orders;
-- =========================================
-- 12. Calculate a moving average of the 
--     last 3 orders.
-- =========================================
select order_id,total_amount,order_date,avg(total_amount) over(order by order_date rows between 2 PRECEDING AND CURRENT ROW)
as moving_avg from orders;
-- =========================================
-- 13. Use NTILE(4) to divide employees 
--     into salary quartiles.
-- =========================================
select employee_name,salary,ntile(4) over(order by salary desc) as quartile from employees;
-- =========================================
-- 14. Find the first order placed by each 
--     customer using ROW_NUMBER().
-- =========================================
SELECT *
FROM (
    SELECT customer_id, order_id, order_date,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS rn
    FROM orders
) t
WHERE rn = 1;
-- =========================================
-- 15. Find the latest order placed by each 
--     customer.
-- =========================================

SELECT *
FROM (
    SELECT customer_id, order_id, order_date,
    ROW_NUMBER() OVER(
        PARTITION BY customer_id
        ORDER BY order_date DESC
    ) AS rn
    FROM orders
) t
WHERE rn = 1;
-- =========================================
-- 16. Display employee salaries along with 
--     department average salary.
-- =========================================
select employee_name,salary,department,avg(salary) over(partition by department) as dpt_avg_salary from employees;
-- =========================================
-- 17. Find employees earning above their 
--     department average salary.
-- =========================================
select * FROM (select employee_name,department,salary,avg(salary) over(partition by department) as avg_sal from employees) t where salary>avg_sal;

-- =========================================
-- 18. Use SUM() OVER(PARTITION BY 
--     department) to calculate department 
--     payroll.
-- =========================================
select employee_name,department,salary,sum(salary) over(partition by department) as dept_total from employees;
-- =========================================
-- 19. Find the percentage contribution of 
--     each employee salary within their 
--     department.
-- =========================================
select employee_name,salary,department, round(100*salary/sum(salary) over(partition by department),2) as salary_percentage from employees;
-- =========================================
-- 20. Use COUNT() OVER() to show total 
--     number of employees alongside each 
--     row.
-- =========================================

SELECT employee_name, department,
COUNT(*) OVER() AS total_employees
FROM employees;

-- =========================================
-- 21. Create a CTE to calculate total 
--     sales per employee.
-- =========================================
WITH employee_sales AS (
    SELECT employee_id,
    SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)

SELECT *
FROM employee_sales;
-- =========================================
-- 22. Use a CTE to find employees whose 
--     sales exceed the company average.
-- =========================================
WITH employee_sales AS (
    SELECT employee_id,
    SUM(total_amount) AS total_sales
    FROM orders
    GROUP BY employee_id
)SELECT *
FROM employee_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM employee_sales
);

-- =========================================
-- 23. Create multiple CTEs to calculate 
--     customer total spending and rankings.
-- =========================================

WITH customer_spending AS (
    SELECT customer_id,
    SUM(total_amount) AS total_spending
    FROM orders
    GROUP BY customer_id
),

customer_ranking AS (
    SELECT customer_id, total_spending,
    RANK() OVER(
        ORDER BY total_spending DESC
    ) AS ranking
    FROM customer_spending
)

SELECT *
FROM customer_ranking;
-- =========================================
-- 24. Write a recursive CTE to generate 
--     numbers from 1 to 10.
-- =========================================
WITH RECURSIVE numbers AS (
    SELECT 1 AS num

    UNION ALL

    SELECT num + 1
    FROM numbers
    WHERE num < 10
)

SELECT *
FROM numbers;
