-- Step 1: Create Database
DROP DATABASE IF EXISTS customer_chum_db;
CREATE DATABASE customer_chum_db;
USE customer_chum_db;

-- Step 2: Create Table
CREATE TABLE customer_chum (
    CustomerID INT PRIMARY KEY,
    WarehouseToHome INT,
    PreferredOrderCat VARCHAR(50),
    HourSpendOnApp INT,
    Churn VARCHAR(10)
);

-- Step 3: Insert Sample Data
INSERT INTO customer_chum VALUES
(1, 10, 'Laptop', 3, 'Yes'),
(2, 5, 'Mobile', 2, 'No'),
(3, 7, 'Laptop', 4, 'Yes'),
(4, 12, 'Accessories', 1, 'No');

-- Step 4: Disable Safe Mode
SET SQL_SAFE_UPDATES = 0;

-- Step 5: Replace NULL WarehouseToHome with Average
UPDATE customer_chum
SET WarehouseToHome = (
    SELECT avg_value FROM (
        SELECT AVG(WarehouseToHome) AS avg_value FROM customer_chum
    ) AS temp
)
WHERE WarehouseToHome IS NULL;

-- Step 6: Enable Safe Mode Again
SET SQL_SAFE_UPDATES = 1;

-- Step 7: Category Analysis Query
SELECT 
    CASE 
        WHEN WarehouseToHome <= 5 THEN 'Very Close'
        WHEN WarehouseToHome BETWEEN 6 AND 10 THEN 'Moderate'
        ELSE 'Far'
    END AS DistanceCategory,
    COUNT(*) AS TotalCustomers
FROM customer_chum
GROUP BY DistanceCategory;