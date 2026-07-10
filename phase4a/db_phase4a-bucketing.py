# Databricks notebook source
from pyspark.sql import SparkSession
spark=SparkSession.builder.appName("bucketing and segmentation").getOrCreate()
data=[ (1, "Arjun", 1200),
    (2, "Rahul", 3500),
    (3, "Sneha", 5500),
    (4, "Anjali", 9000),
    (5, "Kiran", 12000),
    (6, "Amit", 17000),
    (7, "Priya", 4800),
    (8, "Ravi", 10500)]
columns=["customer_id","name","amount_spent"]
df=spark.createDataFrame(data,columns)
df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC #methods to perform bucketing
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ## Method-1

# COMMAND ----------

# 1 coditional logic(most common)
from pyspark.sql.functions import when
df = df.withColumn(
 "segment",
 when(df.amount_spent > 10000, "Gold")
 .when((df.amount_spent >= 5000) & (df.amount_spent <= 10000), "Silver")
 .otherwise("Bronze")
)
df.show()
                

# COMMAND ----------

# MAGIC %md
# MAGIC ## Method-2

# COMMAND ----------

df.createOrReplaceTempView("customers")

# COMMAND ----------


result = spark.sql("""
SELECT *,
       CASE
           WHEN amount_spent > 10000 THEN 'Gold'
           WHEN amount_spent >= 5000 AND amount_spent <= 10000 THEN 'Silver'
           ELSE 'Bronze'
       END AS segment
FROM customers
""")

result.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ## Method-3

# COMMAND ----------

from pyspark.ml.feature import Bucketizer
splits=[-float("inf"),5000,10000,float("inf")]
bucketizer=Bucketizer(splits=splits,inputCol="amount_spent",outputCol="bucket")
bucket_df = bucketizer.transform(df)


# COMMAND ----------

bucket_df=bucket_df.drop("segment")

# COMMAND ----------

bucket_df=bucket_df.withColumn("segment",when(bucket_df.bucket==0,"Bronze").when(bucket_df.bucket==1,"Silver").otherwise("gold"))
bucket_df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ## method-4

# COMMAND ----------

#quantile based
quantiles=df.approxQuantile("amount_spent",[0.33,0.66],0)
print(quantiles)
q1 = quantiles[0]
q2 = quantiles[1]

quantile_df = df.withColumn(
    "segment",
    when(df.amount_spent <= q1, "Bronze")
    .when(df.amount_spent <= q2, "Silver")
    .otherwise("Gold")
)

quantile_df.show()

# COMMAND ----------

# MAGIC %md
# MAGIC ## Method-5

# COMMAND ----------

from pyspark.sql.window import Window
from pyspark.sql.functions import percent_rank

# COMMAND ----------

window=Window.orderBy("amount_spent")
rank_df=df.withColumn("rank_pct",percent_rank().over(window))
rank_df.show()

# COMMAND ----------

df.groupBy("segment").count().show()

# COMMAND ----------

quantiles = df.approxQuantile(
    "amount_spent",
    [0.25, 0.50, 0.75],
    0
)

print(quantiles)

# COMMAND ----------

