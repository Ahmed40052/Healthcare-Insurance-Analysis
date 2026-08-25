-- verify.sql
-- Sanity checks after importing data into the Insurance table.

USE HealthcareInsuranceAnalysis;
GO

-- Total row count (expected: 1337 after removing the 1 duplicate row during cleaning)
SELECT COUNT(*) AS TotalRows
FROM dbo.Insurance;
GO

-- Basic sanity check on ranges and categories
SELECT
    MIN(age) AS MinAge,
    MAX(age) AS MaxAge,
    MIN(bmi) AS MinBMI,
    MAX(bmi) AS MaxBMI,
    AVG(charges) AS AvgCharges,
    SUM(CASE WHEN smoker = 'yes' THEN 1 ELSE 0 END) AS SmokerCount,
    SUM(CASE WHEN smoker = 'no' THEN 1 ELSE 0 END) AS NonSmokerCount
FROM dbo.Insurance;
GO

-- Preview first 10 rows
SELECT TOP 10 *
FROM dbo.Insurance;
GO

-- Check distinct values in categorical columns (should match: 
-- sex: female/male | smoker: yes/no | region: 4 regions)
SELECT DISTINCT sex FROM dbo.Insurance;
GO

SELECT DISTINCT smoker FROM dbo.Insurance;
GO

SELECT DISTINCT region FROM dbo.Insurance;
GO
