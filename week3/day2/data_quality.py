# Databricks notebook source
from pyspark.sql import SparkSession
from pyspark.sql.functions import col,when,count

# COMMAND ----------

spark=SparkSession.builder.appName("Data Cleaning").getOrCreate()
data=[
    (1, "Ravi", "Hyderabad", 25),
    (2, None, "Chennai", 32),
    (None, "Arun", "Hyderabad", 28),
    (4, "Meena", None, 30),
    (4, "Meena", None, 30),
    (5, "John", "Bangalore", -5)
]
columns = ["customer_id", "name", "city", "age"]
df=spark.createDataFrame(data,columns)
df.show()


# COMMAND ----------

duplicates_count=df.count()-df.dropDuplicates().count()
print("Duplicate rows:",duplicates_count)

# COMMAND ----------

null_values=df.select([count(when(col(c).isNull(),c)).alias(c) for c in columns]).show()

# COMMAND ----------

df.filter(col("age")<0).show()

# COMMAND ----------

df_clean = df.filter(col("customer_id").isNotNull())

df_clean = df_clean.fillna({"name":"Unknown"})

df_clean.show()

# COMMAND ----------

df_clean=df_clean.dropDuplicates()
df_clean=df_clean.filter(col("age")>=0)
#after data cleaning
after_count=df_clean.count()
print("Rows After Cleaning:", after_count)
print("Cleaned Data")
df_clean.show()

# COMMAND ----------

#aggregation
print("customer by city")
city_count=df_clean.groupBy("city").count()
print(city_count.show())

# COMMAND ----------

