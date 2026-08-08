                      # 📚 Library Management System — SQL Project

## 📌 Project Overview

This project is a **Library Management System SQL project** built using **MySQL** and **MySQL Workbench**.
The project contains a series of SQL tasks designed to practice working with a relational database and answer practical questions related to library operations.
The analysis focuses on **books, members, employees, branches, book issues, returns, overdue books, and rental income**.
This project is part of my **SQL learning journey**, where I am developing my ability to translate real-world business questions into SQL queries.

---
## 🎯 Project Objectives
The main objectives of this project were to:
* Practice SQL CRUD operations
* Retrieve and filter data from relational tables
* Work with multiple tables using `JOIN`
* Use aggregation to analyze library activity
* Identify members with multiple book issues
* Find books that have not been returned
* Identify overdue books
* Calculate overdue fines
* Analyze rental income by category
* Analyze employee and branch performance
* Create summary tables using **CTAS**
* Practice working with MySQL date functions
  
---
## 🗂️ Database Tables
The project uses the following tables:

| Table           | Description                                                                                          |
| --------------- | ---------------------------------------------------------------------------------------------------- |
| `books`         | Contains book information such as ISBN, title, category, rental price, author, publisher, and status |
| `members`       | Contains library member information and registration details                                         |
| `issued_status` | Records books issued to members and the employees who processed the issues                           |
| `return_status` | Contains information about returned books                                                            |
| `employees`     | Contains employee information and branch assignments                                                 |
| `branch`        | Contains library branch information and manager details                                              

---

# 🔎 SQL Tasks

## Task 1 — Create a New Book Record
Inserted a new book into the `books` table using `INSERT INTO`.

**SQL concepts:**
* `INSERT INTO`
* Specifying columns and values

---
## Task 2 — Update an Existing Member's Address
Updated the address of a specific library member.

**SQL concepts:**
* `UPDATE`
* `WHERE`
* MySQL safe update mode

---
## Task 3 — Delete a Record from the Issued Status Table
Deleted a specific issued-book record using its `issued_id`.

**SQL concepts:**
* `DELETE`
* `WHERE`

---
## Task 4 — Retrieve Books Issued by a Specific Employee
Retrieved the books processed by employee `E101`.

**SQL concepts:**
* `SELECT`
* `WHERE`
* Filtering records

---
## Task 5 — Retrieve Books in a Specific Category
Retrieved all books belonging to the **Classic** category.

**SQL concepts:**
* `SELECT`
* `WHERE`

---
## Task 6 — Members Registered in the Last 180 Days
Identified members who registered within the previous 180 days.

**SQL concepts:**
* `CURDATE()`
* `INTERVAL`
* Date filtering

---
## Task 7 — Members Who Issued More Than One Book
Identified members who have issued more than one book.

**SQL concepts:**
* `GROUP BY`
* `COUNT()`
* `HAVING`

---
## Task 8 — Book Issue Summary Using CTAS
Created a new table called `book_cnts` containing each book and the number of times it has been issued.
**Output includes:**
* ISBN
* Book title
* Number of issues

**SQL concepts:**
* `CREATE TABLE AS SELECT`
* `JOIN`
* `COUNT()`
* `GROUP BY`

---
## Task 9 — Total Rental Income by Category
Calculated rental income and the number of issued books for each book category.
**Output includes:**
* Category
* Total rental income
* Number of books issued
  
**SQL concepts:**
* `SUM()`
* `COUNT()`
* `JOIN`
* `GROUP BY`
* `ORDER BY`

---
## Task 10 — Employees, Managers, and Branch Details
Retrieved employee information together with their branch and branch manager details.
This required joining the `employees` table to itself through the branch manager relationship.

**SQL concepts:**
* Multiple `JOIN`s
* Self-join
* Table aliases

---
## Task 11 — Books Not Yet Returned
Identified books that have been issued but do not have a corresponding return record.

**SQL concepts:**
* `LEFT JOIN`
* `IS NULL`
* `DISTINCT`

---
## Task 12 — Identify Members with Overdue Books
Identified members who have books that have not been returned after the assumed **850-day return period**.
The query displays:
* Member ID
* Member name
* Book title
* Issue date
* Return date
* Days since issue
  
**SQL concepts:**
* Multiple `JOIN`s
* `LEFT JOIN`
* `DATEDIFF()`
* `CURDATE()`
* `IS NULL`
* Date filtering

---
## Task 13 — Create a Table of Expensive Books
Created a new table called `expensive_books` containing books with a rental price greater than **$7**.

**SQL concepts:**
* `CREATE TABLE AS SELECT`
* `WHERE`
* Comparison operators

---
## Task 14 — Branch Performance Report
Created a `branch_report` table to analyze branch-level performance.
The report includes:
* Branch ID
* Manager ID
* Number of books issued
* Number of books returned
* Total rental revenue

**SQL concepts:**
* Multiple table joins
* `COUNT()`
* `SUM()`
* `LEFT JOIN`
* `GROUP BY`
* CTAS

---
## Task 15 — Active Members
Created an `active_members` table containing members who issued at least one book during the previous **28 months**.
`DISTINCT` was used to prevent members with multiple issues from appearing more than once.

**SQL concepts:**
* CTAS
* `DISTINCT`
* `JOIN`
* `INTERVAL`
* Date filtering

---
## Task 16 — Member Overdue Books & Fines
Created a `member_fines` table containing members with books that have not been returned within the assumed **850-day period**.
The table calculates:
* Member ID
* Number of overdue books
* Total fines
The fine is calculated at **$0.50 for each overdue day**.
### Fine Calculation
```text

Overdue Days = Days Since Issue − 850
Fine = Overdue Days × $0.50
```

**SQL concepts:**
* CTAS
* `DATEDIFF()`
* `SUM()`
* `COUNT()`
* `LEFT JOIN`
* `IS NULL`
* `GROUP BY`

---
## Task 17 — Top 3 Employees by Books Processed
Identified the top three employees who processed the highest number of book issues.
The result displays:
* Employee name
* Branch ID
* Branch address
* Number of books processed
**SQL concepts:**
* Multiple `JOIN`s
* `COUNT()`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`

---

# 🛠️ SQL Skills Practiced
Through this project, I practiced the following SQL concepts:

### Basic SQL
* `SELECT`
* `INSERT INTO`
* `UPDATE`
* `DELETE`
  
### Filtering
* `WHERE`
* `IS NULL`
* Comparison operators
* Date-based filtering
  
### Aggregation
* `COUNT()`
* `SUM()`
* `GROUP BY`
* `HAVING`

### JOINs
* `INNER JOIN`
* `LEFT JOIN`
* Self-joins
* Multiple-table joins

### Date Functions
* `CURDATE()`
* `DATEDIFF()`
* `INTERVAL`

### Table Creation
* `CREATE TABLE`
* `CREATE TABLE AS SELECT (CTAS)`

### Other SQL Concepts
* `DISTINCT`
* `ORDER BY`
* `LIMIT`
* Table aliases
* Aggregate filtering

---
# 💡 Key Learning Outcomes
This project helped me develop a stronger understanding of how SQL can be used to solve practical data problems.
Some of the key things I learned include:

* How to manipulate data using CRUD operations
* How to combine information from multiple relational tables
* How `INNER JOIN` and `LEFT JOIN` produce different results
* How to identify missing records using `IS NULL`
* How to group and summarize data using aggregate functions
* How `HAVING` can filter aggregated results
* How to work with dates in MySQL
* How to calculate overdue periods and fines
* How to create reusable summary tables using CTAS
* How to use SQL to answer business-oriented questions

---
# 🚀 Future Improvements

As I continue improving my SQL skills, I plan to expand this project by adding:

* Common Table Expressions (CTEs)
* Window functions
* More advanced subqueries
* Monthly and yearly library usage analysis
* Member borrowing trends
* Employee performance analysis
* More detailed revenue analysis
* Additional data quality checks
* Power BI visualizations based on the SQL analysis

---
### Tools Used

* **MySQL**
* **MySQL Workbench**
* **SQL**

---
This project is part of my ongoing journey to develop practical **data analytics and SQL skills**.
