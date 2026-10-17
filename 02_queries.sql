-- =====================================================
-- Online Course Database
-- Script: 02_queries.sql
-- Engine: Microsoft SQL Server / T-SQL
-- Prerequisite: Run sql/01_setup.sql first.
-- =====================================================

USE Online_Course;
GO

SET NOCOUNT ON;
GO

-- =====================================================
-- Part 1: Filtering and sorting
-- =====================================================

-- Query 1: Retrieve students whose GPA is greater than 3.00.
SELECT FirstName, LastName, Age, GPA
FROM dbo.Students
WHERE GPA > 3.00;

-- Query 2: Find students in Cairo or Giza whose age is greater than 20.
SELECT StudentID, FirstName, LastName, Age, City, GPA
FROM dbo.Students
WHERE City IN ('Cairo', 'Giza')
  AND Age > 20;

-- Query 3: Display unique cities in alphabetical order.
SELECT DISTINCT City
FROM dbo.Students
ORDER BY City;

-- Query 4: Retrieve the three students with the highest GPA.
-- TOP is a SQL Server/T-SQL feature.
SELECT TOP (3)
    StudentID, FirstName, LastName, Age, City, GPA
FROM dbo.Students
ORDER BY GPA DESC, StudentID;

-- =====================================================
-- Part 2: Aggregate functions and grouping
-- =====================================================

-- Query 5: Calculate the average, highest, and lowest GPA.
SELECT
    AVG(GPA) AS [Average GPA],
    MAX(GPA) AS [Highest GPA],
    MIN(GPA) AS [Lowest GPA]
FROM dbo.Students;

-- Query 6: Calculate the average grade for each course.
SELECT
    CourseName,
    AVG(CAST(Grade AS DECIMAL(5, 2))) AS [Average Grade]
FROM dbo.Enrollments
GROUP BY CourseName
ORDER BY CourseName;

-- Query 7: Count enrollments for each course and show courses
-- with more than three enrollments.
SELECT
    CourseName,
    COUNT(*) AS [Number of Enrollments]
FROM dbo.Enrollments
GROUP BY CourseName
HAVING COUNT(*) > 3
ORDER BY CourseName;

-- =====================================================
-- Part 3: Subqueries
-- =====================================================

-- Query 8: Find students whose age is above the average age.
SELECT FirstName, LastName
FROM dbo.Students
WHERE Age >
(
    SELECT AVG(Age)
    FROM dbo.Students
);

-- Query 9: Find students whose GPA is greater than the average
-- GPA of students living in Cairo.
SELECT FirstName, LastName
FROM dbo.Students
WHERE GPA >
(
    SELECT AVG(GPA)
    FROM dbo.Students
    WHERE City = 'Cairo'
);

-- Query 10: Find students with at least one enrollment whose grade
-- is above the average grade across all enrollments.
SELECT FirstName, LastName, GPA
FROM dbo.Students
WHERE StudentID IN
(
    SELECT StudentID
    FROM dbo.Enrollments
    WHERE Grade >
    (
        SELECT AVG(Grade)
        FROM dbo.Enrollments
    )
);
GO
