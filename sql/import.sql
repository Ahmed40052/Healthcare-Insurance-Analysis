-- import.sql
-- Loads insurance_clean.csv into the Insurance table.
--
-- IMPORTANT: Change the @CSV_PATH value below to match the file location
-- on YOUR OWN machine before running this script.

USE HealthcareInsuranceAnalysis;
GO

-- Clear any existing rows before a fresh import (safe re-run)
TRUNCATE TABLE dbo.Insurance;
GO

-- ============================================================
-- EDIT THIS PATH to match your local machine before running:
-- ============================================================
-- Example:
-- D:\NTI_Tasks_Data_Analysis\Project\healthcare-insurance-analysis\data\processed\insurance_clean.csv

BULK INSERT dbo.Insurance
FROM 'C:\Users\ebtih\OneDrive\Desktop\git\healthcare project\Healthcare-Insurance-Analysis\data\processed\insurance_clean.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

-- Confirm the import worked
SELECT COUNT(*) AS TotalRows FROM dbo.Insurance;
GO

SELECT TOP 10 * FROM dbo.Insurance;
GO

-- ============================================================
-- TROUBLESHOOTING NOTES (in case you hit errors)
-- ============================================================
--
-- Error: "Cannot obtain the required interface (IID_IColumnsInfo) ..."
--   Fix: Enable Ad Hoc Distributed Queries first:
--     sp_configure 'show advanced options', 1; RECONFIGURE;
--     sp_configure 'Ad Hoc Distributed Queries', 1; RECONFIGURE;
--
-- Error: "could not be opened ... being used by another process"
--   Fix: Close any program that has the CSV file open (Excel, editors, etc.)
--
-- Error: "Bulk load data conversion error ... column 2 (age)"
--   Cause: The CSV file was saved with a UTF-8 BOM, which shifts the first column.
--   Fix: Re-save the CSV from Python without a BOM:
--     df.to_csv('insurance_clean.csv', index=False, encoding='utf-8')
--   Then make sure ROWTERMINATOR = '0x0a' and CODEPAGE = '65001' are set (as above).
--
-- Error: "(0 rows affected)" with no error message
--   Cause: Usually a ROWTERMINATOR mismatch (file uses LF, not CRLF).
--   Fix: Try ROWTERMINATOR = '0x0a' instead of '0x0d0a', or vice versa.
