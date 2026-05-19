use databricks;
CREATE TABLE employee_payments (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(30),
base_salary DECIMAL(10,2),
bonus DECIMAL(10,2),
joining_date DATE
);
INSERT INTO employee_payments VALUES
(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),
(2,'veena','HR',65000.40,4000.25,'2021-06-20'),
(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),
(4,'anil','Finance',70000.10,NULL,'2020-09-01'),
(5,'suresh','HR',60000.55,3000.30,'2022-11-25');

SELECT
    emp_id,
    CONCAT(UPPER(LEFT(emp_name,1)), LOWER(SUBSTRING(emp_name,2))) AS proper_name,
    department,
    ROUND(base_salary + IFNULL(bonus,0)) AS total_income,
    YEAR(joining_date) AS joining_year,
    TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS experience_years,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) > 7 THEN 'Senior'
        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) BETWEEN 4 AND 7 THEN 'Mid'
        ELSE 'Junior'
    END AS employee_level
FROM employee_payments;

CREATE TABLE orders_delivery (
order_id INT,
customer_name VARCHAR(50),
order_date DATE,
delivery_date DATE,
order_amount DECIMAL(10,2)
);
INSERT INTO orders_delivery VALUES
(101,'rajesh','2025-01-01','2025-01-05',12500.75),
(102,'meena','2025-01-10','2025-01-10',8400.40),
(103,'arun','2025-01-15','2025-01-20',15600.90),
(104,'pooja','2025-01-18',NULL,9200.10);

select order_id,upper(customer_name) as customer_name,order_date,
    IFNULL(delivery_date, CURDATE()) AS final_delivery_date,
    DATEDIFF(IFNULL(delivery_date, CURDATE()), order_date) AS delivery_days,
    TRUNCATE(order_amount,1) AS truncated_amount,
    CASE
        WHEN delivery_date IS NULL THEN 'Pending'
        WHEN DATEDIFF(delivery_date, order_date) = 0 THEN 'Same-day'
        WHEN DATEDIFF(delivery_date, order_date) > 3 THEN 'Delayed'
        ELSE 'Normal'
    END AS delivery_status
FROM orders_delivery;

CREATE TABLE customer_spending (
cust_id INT,
cust_name VARCHAR(50),
city VARCHAR(30),
purchase_amount DECIMAL(10,2),
purchase_date DATE
);

INSERT INTO customer_spending VALUES
(1,'amit','mumbai',12000.75,'2024-12-01'),
(2,'neha','delhi',8500.40,'2024-12-15'),
(3,'rohit','mumbai',15500.90,'2024-11-20'),
(4,'kavya','chennai',6000.10,'2024-10-05');

SELECT
    cust_id,
    CONCAT(UPPER(LEFT(cust_name,1)), LOWER(SUBSTRING(cust_name,2))) AS customer_name,
    MONTHNAME(purchase_date) AS purchase_month,
    ROUND(purchase_amount) AS rounded_amount,
    ABS(purchase_amount) AS absolute_amount,
    CASE
        WHEN purchase_amount > 15000 THEN 'High Spender'
        WHEN purchase_amount BETWEEN 8000 AND 15000 THEN 'Medium'
        ELSE 'Low'
    END AS spending_category
FROM customer_spending;

CREATE TABLE subscriptions (
user_id INT,
user_email VARCHAR(100),
start_date DATE,
end_date DATE,
subscription_fee DECIMAL(10,2)
);


INSERT INTO subscriptions VALUES
(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),
(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),
(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);

SELECT
    user_id,
    SUBSTRING_INDEX(user_email,'@',-1) AS email_domain,
    TIMESTAMPDIFF(MONTH,start_date,end_date) AS duration_months,
    FORMAT(subscription_fee,2) AS formatted_fee,
    DATEDIFF(end_date,CURDATE()) AS remaining_days,
    CASE
        WHEN end_date < CURDATE() THEN 'Expired'
        WHEN DATEDIFF(end_date,CURDATE()) <= 30 THEN 'Expiring Soon'
        ELSE 'Active'
    END AS subscription_status
FROM subscriptions;

CREATE TABLE loan_details (
loan_id INT,
customer_name VARCHAR(50),
loan_amount DECIMAL(12,2),
interest_rate DECIMAL(5,2),
loan_start DATE
);


INSERT INTO loan_details VALUES
(201,'suresh',500000.75,8.5,'2022-01-10'),
(202,'mahesh',750000.40,9.2,'2021-05-20'),
(203,'anita',300000.90,7.8,'2023-07-01');

select loan_id,upper(customer_name) as customer_name,timestampdiff(year,loan_start,CURDATE()) as loan_years,
round((loan_amount*(interest_rate/100))/12) as emi ,
power(1+interest_rate/100,1/12) as montly_interest,
CASE
   when interest_rate>9 then 'high risk'
   when interest_rate between 8 and 9 then 'medium risk'
   else 'low risk'
   end as risk_category
 from loan_details;
 
 CREATE TABLE attendance (
emp_id INT,
emp_name VARCHAR(50),
total_days INT,
present_days INT,
record_date DATE
);
INSERT INTO attendance VALUES
(1,'karthik',30,28,'2025-01-31'),
(2,'veena',30,22,'2025-01-31'),
(3,'ravi',30,18,'2025-01-31');

select emp_id,round((present_days/total_days)*100,2) as attendance,
monthname(record_date),
(total_days-present_days) as absent_days,
CASE
        WHEN (present_days/total_days)*100 >= 90 THEN 'Excellent'
        WHEN (present_days/total_days)*100 BETWEEN 75 AND 89 THEN 'Average'
        ELSE 'Poor'
    END AS attendance_status
FROM attendance;

CREATE TABLE product_sales (
product_id INT,
product_name VARCHAR(50),
mrp DECIMAL(10,2),
selling_price DECIMAL(10,2),
sale_date DATE
);
INSERT INTO product_sales VALUES
(1,'Laptop',75000.75,68000.50,'2025-01-10'),
(2,'Mobile',35000.40,33000.25,'2025-01-12'),
(3,'Tablet',25000.90,26000.75,'2025-01-15');

select product_id,abs(mrp-selling_price) as discount_amount,
round(((mrp-selling_price)*100)/mrp) as discount,
dayname(sale_date) as sale_day,
case
   when selling_price<mrp then 'valid_discount'
   when selling_price>mrp then 'overprised'
   else 'no discount'
   end as discount_status
   from product_sales;
   
   
   CREATE TABLE insurance_policies (
policy_id INT,
holder_name VARCHAR(50),
premium_amount DECIMAL(10,2),
policy_start DATE,
policy_end DATE
);
INSERT INTO insurance_policies VALUES
(301,'arjun',12000.50,'2023-01-01','2026-01-01'),
(302,'megha',8500.75,'2022-06-15','2025-06-15'),
(303,'vinod',15000.90,'2021-03-01','2024-03-01');

select policy_id,
timestampdiff(year,policy_start,policy_end) as policy_duration,
datediff(policy_end,curdate()) as days_remain,
upper(holder_name) as holder_name,
round(premium_amount) as rounded_premium,
case
   when policy_end<curdate() then 'expired'
   when timestampdiff(year,policy_end,curdate())>3 then 'long term' 
   else 'mid term'
   end as policy_status 
   from insurance_policies;


CREATE TABLE salary_revision (
emp_id INT,
emp_name VARCHAR(50),
current_salary DECIMAL(10,2),
rating INT,
last_hike DATE
);
INSERT INTO salary_revision VALUES
(1,'karthik',75000.75,5,'2023-01-01'),
(2,'veena',65000.40,4,'2024-01-01'),
(3,'ravi',85000.90,3,'2022-01-01');

select emp_id,
lower(emp_name) as emp_name,
timestampdiff(year,last_hike,curdate()),
case 
   when rating=5 then current_salary*0.2
   when rating=4 then current_salary*0.1
   else 0
   end as increment_amount,
round(current_salary+ case
                          when rating=5 then current_salary*0.2
   when rating=4 then current_salary*0.1
   else 0
   end ) as new_salary,
   case
      when rating=5 then 'high increment'
      when rating=4 then 'moderate increment'
      else 'no increment'
      end as increment_status
from salary_revision;

CREATE TABLE bank_accounts (
account_id INT,
customer_name VARCHAR(50),
balance DECIMAL(12,2),
last_transaction DATE,
branch VARCHAR(30)
);
INSERT INTO bank_accounts VALUES
(501,'ramesh',125000.75,'2024-12-20','hyderabad'),
(502,'sita',8500.40,'2023-06-15','delhi'),
(503,'manoj',-2500.90,'2025-01-05','mumbai');

select account_id,
customer_name,abs(balance) as absolute_balance,
datediff(curdate(),last_transaction) as days_since_transactions,
concat(upper(left(branch,1)),lower(substring(branch,2))) as branch_name,
CASE
        WHEN balance < 0 THEN 'Overdrawn'
        WHEN DATEDIFF(CURDATE(),last_transaction) > 365 THEN 'Dormant'
        ELSE 'Active'
    END AS account_status
FROM bank_accounts;