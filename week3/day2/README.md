# Phase 3A – Data Quality & Cleaning Challenge

## 📌 Objective

The objective of this project is to clean messy real-world data using PySpark before processing and analysis.

This project demonstrates:
- Identifying data quality issues
- Cleaning invalid and incomplete data
- Validating cleaned data
- Performing aggregation

---

# 🛠 Technologies Used

- Python
- PySpark
- Apache Spark

---

# 📂 Dataset

```python
data = [
    (1, "Ravi", "Hyderabad", 25),
    (2, None, "Chennai", 32),
    (None, "Arun", "Hyderabad", 28),
    (4, "Meena", None, 30),
    (4, "Meena", None, 30),
    (5, "John", "Bangalore", -5)
]

columns = ["customer_id", "name", "city", "age"]
