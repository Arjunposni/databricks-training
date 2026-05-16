# SQL Window Functions and CTEs Assignment

A complete SQL practice assignment focused on **Window Functions** and **Common Table Expressions (CTEs)** using a retail sales database.

This project helps in understanding advanced SQL analytical concepts used in real-world business reporting and data analysis.

---

# Topics Covered

## Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- NTILE()
- LAG()
- LEAD()
- PARTITION BY
- Running Totals
- Moving Averages

---

## Common Table Expressions (CTEs)
- Basic CTEs
- Multiple CTEs
- Recursive CTEs

---

# Database Schema

## Employees Table

| Column Name | Data Type |
|---|---|
| employee_id | INT |
| employee_name | VARCHAR |
| department | VARCHAR |
| salary | INT |
| hire_date | DATE |

---

## Orders Table

| Column Name | Data Type |
|---|---|
| order_id | INT |
| customer_id | INT |
| employee_id | INT |
| order_date | DATE |
| total_amount | INT |

---

# Questions Completed

## Employee Ranking Queries

### 1. Assign row numbers using ROW_NUMBER()

### 2. Rank employees using RANK()

### 3. Rank employees using DENSE_RANK()

### 4. Find top 3 highest-paid employees

### 5. Rank employees within each department

### 6. Display highest salary in each department

---

## Sales and Running Calculations

### 7. Calculate running total of order amounts

### 8. Calculate cumulative sales for each employee

### 9. Use LAG() to show previous order amount

### 10. Use LEAD() to show next order amount

### 11. Find difference between current and previous order amount

### 12. Calculate moving average of last 3 orders

---

## Advanced Window Functions

### 13. Divide employees into salary quartiles using NTILE()

### 14. Find first order placed by each customer

### 15. Find latest order placed by each customer

### 16. Display employee salaries with department average salary

### 17. Find employees earning above department average salary

### 18. Calculate department payroll using SUM() OVER()

### 19. Find percentage contribution of employee salary

### 20. Show total number of employees using COUNT() OVER()

---

## Common Table Expressions (CTEs)

### 21. Create CTE to calculate total sales per employee

### 22. Find employees whose sales exceed company average

### 23. Calculate customer spending and rankings using multiple CTEs

### 24. Recursive CTE to generate numbers from 1 to 10

---

# SQL Concepts Practiced

| Concept | Description |
|---|---|
| ROW_NUMBER() | Assigns unique row numbers |
| RANK() | Assigns ranks with gaps |
| DENSE_RANK() | Assigns ranks without gaps |
| PARTITION BY | Performs group-wise calculations |
| LAG() | Access previous row values |
| LEAD() | Access next row values |
| NTILE() | Divides rows into groups |
| CTE | Temporary named result set |
| Recursive CTE | Recursive query generation |
| Window Aggregates | Running totals and averages |

---

# Tools Used

- MySQL Workbench
- SQL Window Functions
- Common Table Expressions (CTEs)

---

# Learning Outcomes

After completing this assignment, you will understand:

- Advanced SQL analytical queries
- Real-world business reporting
- Department-wise analysis
- Running calculations
- Recursive SQL logic
- Data analysis using SQL

---

# Author

**Arjun**  
Engineering Student | SQL Practice | Data Analytics Enthusiast

