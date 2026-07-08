# Databricks notebook source
# MAGIC %md
# MAGIC #Extract

# COMMAND ----------

from pyspark.sql.functions import *
from pyspark.sql.types import *
from pyspark.sql import *
spark = SparkSession.builder.appName("Sales ETL").getOrCreate()
df = spark.read.csv("/Workspace/Users/arjunposni@gmail.com/db_sales.csv",inferSchema=True,header=True)
df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC #transform

# COMMAND ----------

df=df.na.drop() #removing null values
sales=df.filter(col("amount")>0)
report=sales.groupBy("customer_id","city").agg(sum("amount").alias("total_sales")).orderBy(col("total_sales").desc())
report.show()

# COMMAND ----------

# MAGIC %md
# MAGIC #load

# COMMAND ----------

report.coalesce(1) \
    .write \
    .mode("overwrite") \
    .option("header", True) \
    .csv("/Volumes/workspace/default/assignment_data/final_report")

print("ETL pipeline completed successfully!")