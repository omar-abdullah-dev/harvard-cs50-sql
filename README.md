
# Harvard CS50 – Intro to SQL

This repository contains notes, SQL queries, schemas, and problem set solutions gathered while working through Harvard's CS50 Introduction to Databases with SQL. It is organized to be a practical learning reference for SQL fundamentals.

## Repository Structure

```
harvard-cs50-sql/
├── README.md
├── Lecture Slides/
│   ├── lecture 0 - Querying.pdf
│   ├── lecture 1 - Relating.pdf
│   ├── lecture 2 - Designing.pdf
│   └── lecture 3 - Writing.pdf
├── Lectures Quick view/
│   ├── 0- Querying.md
│   ├── 1- Relating.md
│   ├── 2- Desiging.md
│   └── 3- Writing.md
├── notes/
│   ├── Lecture 0/
│   ├── Lecture 1/
│   ├── Lecture 2/
│   └── Lecture 3/
├── problems/
│   ├── Lecture 0 - Querying/
│   ├── Lecture 1 - Relating/
│   ├── Lecture 2 - Designing/
│   └── Lecture 3 - Writing/
├── queries/
│   ├── aggregations/
│   ├── basic/
│   ├── designing/
│   ├── groups/
│   ├── joins/
│   ├── sets/
│   └── subqueries/
├── schemas/
│   ├── Lecture 0/
│   ├── Lecture 1/
│   ├── Lecture 2/
│   └── Lecture 3/
├── Source Code/
│   ├── 0-Querying/
│   ├── 1-Relating/
│   ├── 2-Designing/
│   └── 3-Writing/
└── summaries/
    ├── SQL-APNA College.pdf
    └── SQL-Summary.pdf
```

## How to Use `run_sql.ps1`

This repository includes a PowerShell script `run_sql.ps1` to execute `.sql` files against the `identifier.sqlite` database.

**Prerequisites:**
- PowerShell
- SQLite3 installed and in your system's PATH.

**Usage:**

1.  Open a PowerShell terminal.
2.  Navigate to the root of this repository.
3.  Run the script, providing the path to the `.sql` file you want to execute.

**Example:**
```powershell
.\run_sql.ps1 -SqlFile "queries\basic\select_where.sql"
```

## Lecture Materials

This repository is organized into lectures, each with its own set of materials.

- **Lecture Slides:** PDFs of the lecture presentations.
- **Lectures Quick view:** Markdown files with quick summaries of the lectures.
- **notes:** Detailed Markdown notes for each lecture.
- **Source Code:** Source code and other materials from the lectures.

## Problems & Solutions

The `problems` directory contains the problem sets for each lecture. Each lecture's problem set is further divided into topics.

## SQL Queries

The `queries` directory contains a collection of SQL queries demonstrating various concepts. These are organized by topic.

## Database Schemas

The `schemas` directory contains the database files (`.db`) used in the lectures and problem sets.

## Summaries

The `summaries` directory contains additional summary documents related to SQL.
