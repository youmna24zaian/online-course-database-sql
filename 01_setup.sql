-- =====================================================
-- Online Course Database
-- Script: 01_setup.sql
-- Engine: Microsoft SQL Server / T-SQL
-- Purpose: Create the database, schema, and sample data.
-- =====================================================

-- Create the database only when it does not already exist.
-- CREATE DATABASE and USE are SQL Server statements; this is not SQLite syntax.
IF DB_ID(N'Online_Course') IS NULL
BEGIN
    -- Dynamic SQL keeps CREATE DATABASE as the only statement in its batch.
    EXEC(N'CREATE DATABASE Online_Course');
END;
GO

USE Online_Course;
GO

SET NOCOUNT ON;
GO

-- =====================================================
-- Schema
-- =====================================================

-- Students stores one row per learner.
CREATE TABLE dbo.Students
(
    StudentID INT NOT NULL,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Age INT NULL,
    City VARCHAR(30) NULL,
    GPA DECIMAL(3, 2) NULL,

    CONSTRAINT PK_Students PRIMARY KEY (StudentID),
    CONSTRAINT CK_Students_Age CHECK (Age IS NULL OR Age BETWEEN 0 AND 120),
    CONSTRAINT CK_Students_GPA CHECK (GPA IS NULL OR GPA BETWEEN 0.00 AND 4.00)
);
GO

-- Enrollments stores the courses taken by students.
CREATE TABLE dbo.Enrollments
(
    EnrollmentID INT NOT NULL,
    StudentID INT NOT NULL,
    CourseName VARCHAR(50) NOT NULL,
    Grade INT NULL,
    Fee DECIMAL(8, 2) NULL,
    Semester VARCHAR(20) NULL,

    CONSTRAINT PK_Enrollments PRIMARY KEY (EnrollmentID),
    CONSTRAINT FK_Enrollments_Students
        FOREIGN KEY (StudentID) REFERENCES dbo.Students(StudentID),
    CONSTRAINT CK_Enrollments_Grade CHECK (Grade IS NULL OR Grade BETWEEN 0 AND 100),
    CONSTRAINT CK_Enrollments_Fee CHECK (Fee IS NULL OR Fee >= 0)
);
GO

-- =====================================================
-- Sample data
-- =====================================================

-- Sample student records from the original exercise.
INSERT INTO dbo.Students
    (StudentID, FirstName, LastName, Age, City, GPA)
VALUES
    (1, 'Ahmed', 'Ali', 20, 'Cairo', 3.40),
    (2, 'Sara', 'Hassan', 22, 'Alexandria', 3.80),
    (3, 'Omar', 'Khaled', 19, 'Cairo', 2.90),
    (4, 'Mona', 'Samir', 23, 'Giza', 3.60),
    (5, 'Youssef', 'Adel', 21, 'Cairo', 3.10),
    (6, 'Nour', 'Mohamed', 24, 'Giza', 3.90),
    (7, 'Karim', 'Mostafa', 20, 'Alexandria', 2.70),
    (8, 'Laila', 'Tarek', 22, 'Cairo', 3.50),
    (9, 'Hany', 'Wael', 25, 'Mansoura', 2.80),
    (10, 'Reem', 'Ashraf', 21, 'Giza', 3.70);

-- Sample enrollment records from the original exercise.
INSERT INTO dbo.Enrollments
    (EnrollmentID, StudentID, CourseName, Grade, Fee, Semester)
VALUES
    (101, 1, 'Database', 85, 1200.00, 'Fall'),
    (102, 2, 'Database', 95, 1200.00, 'Fall'),
    (103, 3, 'Programming', 70, 1000.00, 'Fall'),
    (104, 1, 'Programming', 90, 1000.00, 'Spring'),
    (105, 4, 'AI', 88, 1500.00, 'Spring'),
    (106, 5, 'Database', 78, 1200.00, 'Fall'),
    (107, 6, 'AI', 97, 1500.00, 'Spring'),
    (108, 7, 'Programming', 65, 1000.00, 'Fall'),
    (109, 8, 'Database', 91, 1200.00, 'Spring'),
    (110, 2, 'AI', 93, 1500.00, 'Spring'),
    (111, 9, 'Database', 68, 1200.00, 'Fall'),
    (112, 10, 'Programming', 89, 1000.00, 'Spring'),
    (113, 5, 'AI', 82, 1500.00, 'Spring'),
    (114, 8, 'Programming', 87, 1000.00, 'Fall'),
    (115, 4, 'Database', 84, 1200.00, 'Fall');
GO
