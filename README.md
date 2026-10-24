# 📊 Procurement & Purchase Order Analytics | MySQL

## 📌 Project Overview

This project analyzes procurement operations using **MySQL** and a relational database containing supplier information, departments, purchase orders, goods receipts, and invoices.

The objective is to demonstrate how SQL can be used to identify procurement risks, monitor purchase order statuses, analyze supplier spending, investigate invoice discrepancies, and detect potential data quality or process control issues.

This project uses synthetic sample data and is designed to demonstrate practical SQL and data analytics skills through business-oriented questions.

## 🎯 Business Objectives

- Analyze procurement spending across suppliers and departments.
- Identify overdue purchase orders that may require follow-up.
- Evaluate supplier spending concentration and dependency.
- Reconcile purchase order amounts against invoice totals.
- Identify pending and disputed invoices.
- Detect potential procurement process exceptions.
- Apply SQL techniques to convert raw relational data into actionable insights.

## 🗂️ Database Schema

The database is named `procurement_analytics` and contains five interconnected tables.

| Table | Description |
|---|---|
| `suppliers` | Stores supplier names, contact information, countries, and supplier status. |
| `departments` | Contains department names and department managers. |
| `purchase_orders` | Stores PO details, supplier and department references, dates, status, and order amounts. |
| `goods_receipts` | Tracks goods receipt dates, quantities received, and receipt statuses. |
| `invoices` | Contains invoice numbers, dates, amounts, and invoice statuses. |

### Entity Relationships

- **Suppliers → Purchase Orders:** One supplier can have multiple purchase orders.
- **Departments → Purchase Orders:** One department can raise multiple purchase orders.
- **Purchase Orders → Invoices:** One purchase order can have multiple invoices.
- **Purchase Orders → Goods Receipts:** One purchase order can have multiple goods receipts.

The database uses primary keys and foreign keys to maintain referential integrity.

[![Procurement Analytics Entity Relationship Diagram](er_diagram.png)](https://github.com/Divesh-Gaba/Procurement-Purchase-Order-Analytics-project-using-MySQL/blob/main/Procurement%20Purchase%20Order%20ER%20Diagram.png)

*The diagram above illustrates the database structure and relationships between the five tables.*

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **Query Language:** SQL
- **Development Environment:** MySQL Workbench
- **Version Control & Project Hosting:** GitHub

## 🧠 SQL Concepts Demonstrated

- Database and table creation
- Primary keys and foreign key constraints
- One-to-many relationships
- `INNER JOIN` and `LEFT JOIN`
- Aggregate functions: `SUM()`, `COUNT()`, and `AVG()`
- Date functions and overdue calculations

## 🔍 Business Questions & Analysis

### 1. Overdue Purchase Orders

Identify open or partially received purchase orders whose expected delivery dates have passed.

**Business value:** Helps procurement teams prioritize supplier follow-ups and investigate potential delivery delays.

### 2. Supplier Spending Analysis

Calculate procurement spending by supplier and rank suppliers according to their contribution to total procurement commitments.

**Business value:** Helps identify major suppliers and understand spending concentration.

**Important:** In this project, supplier spending is calculated using purchase order amounts, excluding cancelled purchase orders. It represents procurement commitments rather than confirmed cash payments.

### 3. Invoice Reconciliation

Compare purchase order amounts with associated invoice totals and identify potential discrepancies, pending invoices, and disputed invoices.

**Business value:** Supports invoice review and helps prioritize items that may need further investigation.

### 4. Procurement Process Controls

Identify potential exceptions, such as:

- Active purchase orders associated with inactive suppliers.
- Open purchase orders that already have goods receipts.
- Completed purchase orders with no recorded goods receipts.

**Business value:** Helps identify records that may require operational review.

These are potential exceptions rather than automatically confirmed errors, since actual procurement processes can vary.

### 5. Goods Receipt Analysis

Analyze goods receipt records to understand receipt frequency, quantities received, and receipt activity against purchase orders.

**Business value:** Helps monitor recorded delivery activity and identify purchase orders that may require additional investigation.

## 📁 Project Structure

The repository is organized to separate database setup, sample data, analysis queries, and documentation.

```text
procurement-purchase-order-analytics/
│
├── README.md
├── 01_create_tables.sql
└── er_diagram.png
```

**File descriptions:**

- `01_create_tables.sql` — Creates the database tables, primary keys, foreign keys, and constraints.
- Inserts synthetic sample records into the tables.
- Contains queries for checking data consistency and potential process exceptions.
- Contains the main business analysis queries.
- `er_diagram.png` — Visual representation of the database schema and relationships.


## 📈 Key Learning Outcomes

Through this project, I practiced:

- Designing a relational database for a realistic business scenario.
- Understanding relationships between parent and child tables.
- Writing SQL queries to answer business-focused questions.
- Using CTEs and window functions for ranking and cumulative analysis.
- Handling one-to-many joins without inflating aggregate totals.
- Applying conditional aggregation to analyze invoice statuses.
- Translating operational scenarios into measurable analytical questions.

## 🚀 Future Improvements

Potential next steps for this project include:

- Adding a dedicated payment transactions table to track actual payments.
- Building supplier delivery performance metrics.
- Measuring invoice processing turnaround time.
- Creating a Power BI dashboard for procurement monitoring.
- Expanding the dataset to explore additional business scenarios.
- Adding automated data validation and reporting.

## 👨‍💻 About This Project

This project is part of my ongoing journey toward becoming a Data Analyst. I am strengthening my SQL skills by building practical projects that connect technical concepts with real-world business questions.

I believe effective data analytics is not just about writing queries; it is about asking the right questions, validating the results, and generating insights that can support better decisions.

## 📌 Disclaimer

This is an independent learning project built using synthetic sample data. It is not affiliated with or representative of any specific company's internal procurement systems or confidential data.

---

**Skills:** MySQL · SQL · Data Analytics · Relational Database Design · Business Analysis · Data Quality Checks

**Author:** Divesh Gaba.
