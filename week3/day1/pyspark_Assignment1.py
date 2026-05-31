# Databricks notebook source
from pyspark.sql import functions as F
from pyspark.sql.functions import col, when, concat_ws, length, year

# COMMAND ----------

data = [
    (1, "Sravan", 25, "Hyderabad", "Data Engineer", 55000, "2023-01-15", "IT"),
    (2, "Ravi", 28, "Bangalore", "Software Engineer", 72000, "2022-11-10", "IT"),
    (3, "Priya", 24, "Chennai", "Analyst", 48000, "2023-03-12", "Analytics"),
    (4, "Kiran", 30, "Pune", "Manager", 85000, "2021-09-20", "Management"),
    (5, "Sneha", 27, "Mumbai", "HR", 45000, "2020-05-18", "HR"),
    (6, "Arjun", 26, "Delhi", "Developer", 61000, "2022-07-25", "IT"),
    (7, "Meena", 29, "Hyderabad", "Tester", 53000, "2021-12-11", "QA"),
    (8, "Rahul", 31, "Bangalore", "Architect", 98000, "2019-10-14", "IT"),
    (9, "Pooja", 23, "Chennai", "Support", 40000, "2023-04-19", "Support"),
    (10, "Vikas", 32, "Pune", "Lead", 91000, "2018-06-30", "IT"),

    (11, "Anjali", 26, "Mumbai", "Recruiter", 47000, "2022-02-15", "HR"),
    (12, "Ramesh", 35, "Delhi", "Manager", 105000, "2017-03-11", "Management"),
    (13, "Divya", 24, "Hyderabad", "Analyst", 51000, "2023-06-01", "Analytics"),
    (14, "Suresh", 29, "Chennai", "Developer", 68000, "2021-01-21", "IT"),
    (15, "Lavanya", 27, "Pune", "Tester", 54000, "2020-08-08", "QA"),
    (16, "Mahesh", 33, "Bangalore", "Consultant", 87000, "2019-11-19", "Consulting"),
    (17, "Keerthi", 25, "Mumbai", "HR", 43000, "2022-09-14", "HR"),
    (18, "Naresh", 28, "Delhi", "Engineer", 62000, "2021-05-17", "IT"),
    (19, "Swathi", 26, "Hyderabad", "Developer", 64000, "2022-12-05", "IT"),
    (20, "Ajay", 34, "Chennai", "Lead", 93000, "2018-04-22", "IT"),

    (21, "Bhavana", 22, "Pune", "Intern", 25000, "2024-01-10", "Training"),
    (22, "Nikhil", 30, "Mumbai", "Architect", 99000, "2019-07-09", "IT"),
    (23, "Harsha", 27, "Delhi", "Analyst", 52000, "2022-03-13", "Analytics"),
    (24, "Deepika", 29, "Hyderabad", "Manager", 81000, "2020-10-29", "Management"),
    (25, "Tarun", 31, "Bangalore", "Developer", 71000, "2021-11-01", "IT"),
    (26, "Neha", 24, "Chennai", "Tester", 50000, "2023-02-18", "QA"),
    (27, "Rohit", 28, "Pune", "Support", 42000, "2022-06-25", "Support"),
    (28, "Sanjana", 26, "Mumbai", "Recruiter", 46000, "2021-07-07", "HR"),
    (29, "Manoj", 35, "Delhi", "Director", 120000, "2016-12-15", "Management"),
    (30, "Asha", 23, "Hyderabad", "Intern", 27000, "2024-02-05", "Training"),

    (31, "Vinay", 29, "Bangalore", "Engineer", 67000, "2020-09-19", "IT"),
    (32, "Kavya", 25, "Chennai", "Analyst", 49000, "2023-05-28", "Analytics"),
    (33, "Gopi", 32, "Pune", "Lead", 88000, "2019-01-11", "IT"),
    (34, "Ishita", 27, "Mumbai", "Developer", 69000, "2021-04-04", "IT"),
    (35, "Pradeep", 30, "Delhi", "Consultant", 82000, "2020-03-23", "Consulting"),
    (36, "Sowmya", 24, "Hyderabad", "Tester", 51000, "2022-08-18", "QA"),
    (37, "Chandu", 26, "Bangalore", "Support", 41000, "2023-01-30", "Support"),
    (38, "Nandini", 28, "Chennai", "HR", 44000, "2021-06-16", "HR"),
    (39, "Teja", 31, "Pune", "Architect", 101000, "2018-02-12", "IT"),
    (40, "Madhavi", 29, "Mumbai", "Manager", 83000, "2019-09-27", "Management"),

    (41, "Karthik", 27, "Delhi", "Developer", 73000, "2020-11-05", "IT"),
    (42, "Shilpa", 25, "Hyderabad", "Analyst", 53000, "2023-03-17", "Analytics"),
    (43, "Yash", 33, "Bangalore", "Director", 125000, "2017-08-08", "Management"),
    (44, "Reshma", 26, "Chennai", "Tester", 55000, "2022-10-20", "QA"),
    (45, "Abhi", 24, "Pune", "Intern", 26000, "2024-03-11", "Training"),
    (46, "Nikitha", 28, "Mumbai", "Developer", 70000, "2021-02-14", "IT"),
    (47, "Lokesh", 30, "Delhi", "Lead", 92000, "2019-05-26", "IT"),
    (48, "Anu", 23, "Hyderabad", "Support", 39000, "2023-07-01", "Support"),
    (49, "Sandeep", 34, "Bangalore", "Manager", 97000, "2018-08-15", "Management"),
    (50, "Pallavi", 27, "Chennai", "Engineer", 65000, "2020-12-09", "IT")
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

# COMMAND ----------

#SELECT
# 1
df.select("emp_name","salary").show()
# 2
df.select("emp_id", "emp_name", "department").show()
# 3
df.select("city", "designation", "salary").show()
#4
df.filter(col("department")=="IT")\
    .select("emp_id", "emp_name", "salary").show()
#5
df.select("emp_id","emp_name","joining_date","salary").show()
#6
df.select(df.columns[:5]).show()
#7
df.select("salary").show()
#8
df.filter(col("city")=="Hyderabad").select("emp_name").show( )
#9
df.select("designation","department").show()
#10
df.drop("joining_date").show()

# COMMAND ----------

#ALIAS
#1
df.select(col("emp_name").alias("employee_name")).show()
# 2
df.select(col("salary").alias("monthly_salary")).show()
# 3
df.select(col("department").alias("dept")).show()
# 4
df.select(col("joining_date").alias("doj")).show()
# 5
df.select(
    col("emp_name").alias("name"),
    col("city").alias("location")
).show()
# 6
df.select(col("designation").alias("job_role")).show()
# 7
df.select(col("age").alias("employee_age")).show()
# 8
df.select(
    col("emp_id").alias("id"),
    col("emp_name").alias("name"),
    col("salary").alias("income")
).show()
# 9
df.select(
    col("salary").alias("emp_salary"),
    col("department").alias("emp_dept")
).show()
# 10
df.select(col("city").alias("work_location")).show()

# COMMAND ----------

#FILTER/WHERE
#1
df.filter(col("salary")>70000).show()
#2
df.filter(col("city") == "Hyderabad").show()
# 3
df.filter(col("age") < 25).show()
# 4
df.filter(col("department") == "IT").show()
# 5
df.filter(col("designation") == "Developer").show()
#6
df.filter(col("salary").between(50000, 70000)).show()
#7
df.filter(col("joining_date") >'2022-01-01').show()
# 8
df.filter(col("joining_date") > "2022-01-01").show()

# 9
df.filter(col("age") > 30).show()

# 10
df.filter(col("salary") < 50000).show()

# 11
df.filter(
    (col("city") == "Chennai") &
    (col("salary") > 60000)
).show()

# 12
df.filter(
    (col("city") == "Mumbai") |
    (col("city") == "Pune")
).show()

# 13
df.filter(col("emp_name").startswith("S")).show()

# 14
df.filter(col("emp_name").endswith("a")).show()

# 15
df.filter(col("department") == "HR").show()

# 16
df.filter(col("designation").contains("Engineer")).show()

# 17
df.filter(col("city") != "Hyderabad").show()

# 18
df.filter(col("age").between(25, 30)).show()

# 19
df.filter(col("salary") > 90000).show()

# 20
df.filter(col("department") == "Support").show()

# COMMAND ----------

# 1
df.withColumnRenamed("emp_name", "employee_name").show()

# 2
df.withColumnRenamed("department", "dept").show()

# 3
df.withColumnRenamed("joining_date", "doj").show()

# 4
df.withColumnRenamed("salary", "monthly_salary").show()

# 5
df.withColumnRenamed("designation", "job_role").show()

# 6
df.withColumnRenamed("city", "work_location").show()

# 7
df.withColumnRenamed("age", "employee_age").show()

# 8
df.withColumnRenamed("emp_name", "employee_name") \
  .withColumnRenamed("salary", "monthly_salary") \
  .show()

# 9
df.withColumnRenamed("emp_id", "employee_id").show()

# 10
df.withColumnRenamed("department", "business_unit").show()

# COMMAND ----------

# 1
df.limit(5).show()

# 2
df.limit(10).show()

# 3
df.filter(col("department") == "IT") \
  .limit(3).show()

# 4
df.orderBy(col("salary").desc()) \
  .limit(5).show()

# 5
df.orderBy("salary") \
  .limit(5).show()

# 6
df.orderBy("age") \
  .limit(7).show()

# 7
df.filter(col("city") == "Hyderabad") \
  .limit(2).show()

# 8
df.limit(15).show()

# 9
df.orderBy("age") \
  .limit(5).show()

# 10
df.filter(col("salary") > 60000) \
  .limit(8).show()

# COMMAND ----------

# 1
df.orderBy("salary").show()

# 2
df.orderBy(col("salary").desc()).show()

# 3
df.orderBy(col("age").desc()).show()

# 4
df.orderBy("emp_name").show()

# 5
df.orderBy("city", col("salary").desc()).show()

# 6
df.orderBy("joining_date").show()

# 7
df.orderBy("department").show()

# 8
df.orderBy(col("designation").desc()).show()

# 9
df.orderBy("city", "age").show()

# 10
df.orderBy(col("salary").desc()).limit(10).show()

# 11
df.orderBy(col("emp_id").desc()).show()

# 12
df.filter(col("department") == "IT") \
  .orderBy(col("salary").desc()) \
  .show()

# 13
df.orderBy(col("joining_date").desc()).show()

# 14
df.orderBy("emp_name").show()

# 15
df.orderBy(
    col("department"),
    col("salary").desc()
).show()

# COMMAND ----------

#withcolumn
# 1
df.withColumn("bonus", col("salary") * 0.10).show()

# 2
df.withColumn("annual_salary", col("salary") * 12).show()

# 3
df.withColumn("tax", col("salary") * 0.05).show()

# 4
df.withColumn("updated_salary", col("salary") + 5000).show()

# 5
df.withColumn(
    "salary_category",
    when(col("salary") >= 80000, "High")
    .when(col("salary") >= 50000, "Medium")
    .otherwise("Low")
).show()

# 6
df.withColumn(
    "age_group",
    when(col("age") < 25, "Young")
    .otherwise("Adult")
).show()

# 7
df.withColumn(
    "location",
    concat_ws("-", col("city"), col("department"))
).show()

# 8
df.withColumn(
    "increment_salary",
    col("salary") * 1.15
).show()

# 9
df.withColumn(
    "experience_status",
    when(year(col("joining_date")) < 2021, "Experienced")
    .otherwise("Fresher")
).show()

# 10
df.withColumn(
    "name_length",
    length(col("emp_name"))
).show()

# 11
df.withColumn(
    "is_high_salary",
    when(col("salary") > 80000, True).otherwise(False)
).show()

# 12
df.withColumn(
    "joining_year",
    year(col("joining_date"))
).show()

# 13
df.withColumn(
    "salary_after_tax",
    col("salary") - (col("salary") * 0.05)
).show()

# 14
df.withColumn(
    "department_code",
    F.upper(F.substring(col("department"), 1, 3))
).show()

# 15
df.withColumn(
    "double_salary",
    col("salary") * 2
).show()

# COMMAND ----------

# 1
df.withColumn("salary", col("salary").cast("string")).show()

# 2
df.withColumn("age", col("age").cast("double")).show()

# 3
df.withColumn("joining_date", col("joining_date").cast("date")).show()

# 4
df.withColumn("emp_id", col("emp_id").cast("string")).show()

# 5
df.withColumn("salary", col("salary").cast("integer")).show()

# 6
df.withColumn("age", col("age").cast("string")).show()

# 7
df.withColumn("joining_date", col("joining_date").cast("timestamp")).show()

# 8
df.withColumn("salary", col("salary").cast("float")).show()

# 9
df.withColumn("emp_id", col("emp_id").cast("long")).show()

# 10
df.withColumn("salary", col("salary").cast("float")) \
  .withColumn("age", col("age").cast("string")) \
  .withColumn("joining_date", col("joining_date").cast("date")) \
  .show()