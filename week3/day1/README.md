# Employee Data Analysis using PySpark

This project demonstrates basic PySpark DataFrame operations using employee data in Databricks.

---

# Technologies Used

- Python
- PySpark
- Databricks

---

# Dataset Columns

- emp_id
- emp_name
- age
- city
- designation
- salary
- joining_date
- department

---

# Create DataFrame

```python
data = [
    (1, "Sravan", 25, "Hyderabad", "Data Engineer", 55000, "2023-01-15", "IT"),
    (2, "Ravi", 28, "Bangalore", "Software Engineer", 72000, "2022-11-10", "IT")
]

columns = [
    "emp_id",
    "emp_name",
    "age",
    "city",
    "designation",
    "salary",
    "joining_date",
    "department"
]

df = spark.createDataFrame(data, columns)

df.show()
Operations Covered
SELECT
df.select("emp_name", "salary").show()
FILTER
df.filter(df.salary > 70000).show()
WITHCOLUMN
from pyspark.sql.functions import col

df.withColumn("bonus", col("salary") * 0.10).show()
SORT
df.orderBy(df.salary.desc()).show()
LIMIT
df.limit(5).show()

```
#How to Run
##Open Databricks
##Create a notebook
##Paste the code
##Run the cells
#Author

##Arjun
