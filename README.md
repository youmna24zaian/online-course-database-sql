# Online Course Database SQL

A small Microsoft SQL Server / T-SQL learning project based on the original **Exercise 2.sql** file. It creates and populates an online-course database, then demonstrates filtering, sorting, aggregate functions, grouping, `HAVING`, and nested subqueries.

> **Database engine:** Microsoft SQL Server. The scripts intentionally use T-SQL features such as `GO`, `USE`, `DB_ID`, and `TOP`; they are not SQLite scripts.

## Purpose

The database models students and their course enrollments. It is designed for SQL fundamentals practice rather than production course-management software. The original learning objectives and sample records are preserved while the SQL is split into readable, executable sections.

## Project structure

```text
.
├── README.md
├── .gitignore
├── docs/
│   └── screenshot-placeholder.md
└── sql/
    ├── 01_setup.sql
    └── 02_queries.sql
```

## Tables and relationships

### `dbo.Students`

Stores one row per learner:

- `StudentID` — primary key.
- `FirstName`, `LastName` — required names.
- `Age` — optional age with a basic range check.
- `City` — optional city.
- `GPA` — optional GPA constrained to `0.00`–`4.00`.

### `dbo.Enrollments`

Stores one row per course enrollment:

- `EnrollmentID` — primary key.
- `StudentID` — foreign key to `dbo.Students(StudentID)`.
- `CourseName` — course label such as `Database`, `Programming`, or `AI`.
- `Grade` — optional numeric grade constrained to `0`–`100`.
- `Fee` — optional non-negative course fee.
- `Semester` — semester label such as `Fall` or `Spring`.

The relationship is **one-to-many**: one student can have many enrollment records, while each enrollment belongs to one student.

## Setup and execution

1. Install or connect to a Microsoft SQL Server instance. SQL Server Express, Developer Edition, or a hosted SQL Server instance can be used.
2. Open `sql/01_setup.sql` in SQL Server Management Studio, Azure Data Studio, or run it with `sqlcmd`.
3. Execute the setup script once against an account that can create a database. It creates `Online_Course`, the two tables, constraints, and the sample data.
4. Open `sql/02_queries.sql` and execute it after the setup script completes.

Example `sqlcmd` commands:

```powershell
sqlcmd -S <server-name> -E -i .\sql\01_setup.sql
sqlcmd -S <server-name> -E -d Online_Course -i .\sql\02_queries.sql
```

For SQL authentication, replace `-E` with the appropriate `-U` and `-P` options. Do not commit credentials to this repository.

### Rerun note

`01_setup.sql` creates the database only when it does not exist, but it does not drop existing tables or protect the sample `INSERT` statements from duplicate-key errors. Run it against a fresh database, or remove/reset the existing sample objects before rerunning. No destructive `DROP DATABASE` operation is included.

## SQL concepts demonstrated

The source exercise demonstrates and the cleaned scripts retain:

- Database creation and database selection with `CREATE DATABASE` and `USE`.
- Table creation with typed columns and constraints.
- Primary keys and a foreign-key relationship.
- `INSERT` with explicit column lists.
- Filtering with `WHERE`, comparison operators, `AND`, `OR`/`IN`, and `IS`-compatible nullable columns.
- Sorting with `ORDER BY` and limiting rows with SQL Server `TOP`.
- Duplicate removal with `DISTINCT`.
- Aggregate functions: `AVG`, `MAX`, `MIN`, and `COUNT`.
- Grouping with `GROUP BY` and post-aggregation filtering with `HAVING`.
- Scalar and nested subqueries.
- Aliases and explicit schema qualification through `dbo`.
- Basic data-integrity checks for GPA, age, grade, and fee values.

## Example queries from the source exercise

### Students above a GPA threshold

```sql
SELECT FirstName, LastName, Age, GPA
FROM dbo.Students
WHERE GPA > 3.00;
```

### Average grade by course

```sql
SELECT
    CourseName,
    AVG(CAST(Grade AS DECIMAL(5, 2))) AS [Average Grade]
FROM dbo.Enrollments
GROUP BY CourseName;
```

### Students above the overall average age

```sql
SELECT FirstName, LastName
FROM dbo.Students
WHERE Age >
(
    SELECT AVG(Age)
    FROM dbo.Students
);
```

The complete set of ten source queries is in `sql/02_queries.sql`.

## Validation and limitations

The scripts were reviewed for T-SQL consistency, balanced delimiters, statement ordering, explicit insert columns, key relationships, and preservation of all ten original query objectives. The local environment provides the `sqlcmd` client, but no SQL Server service or connection was available for a live execution test. Therefore, this project does not claim a completed database execution test. Validation should be repeated against the target SQL Server instance.

This is intentionally a compact learning schema. It does not add separate `Courses`, `Semesters`, users, authentication, stored procedures, views, indexes, or application code because those features were not part of the source exercise.

## Screenshot

A placeholder is provided at [`docs/screenshot-placeholder.md`](docs/screenshot-placeholder.md). No image has been added yet.
