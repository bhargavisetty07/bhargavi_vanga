show databases;
USE `adventure_works`;
#--------------union
SELECT *
FROM factinternetsales

UNION

SELECT *
FROM fact_internet_sales_new;
CREATE TABLE combined_sales AS
SELECT *
FROM factinternetsales

UNION

SELECT *
FROM fact_internet_sales_new;
select* from combined_sales;
select count(productkey) from combined_sales;
#==================
SELECT 
    dimproduct.EnglishProductName, 
    combined_sales.salesAmount
FROM 
    combined_sales
INNER JOIN 
    dimproduct
ON 
    combined_sales.ProductKey = dimproduct.ProductKey;
  #===============================productwisesales  
    SELECT 
    dp.EnglishProductName, 
    ROUND(SUM(cs.SalesAmount), 2) AS Total_Sales
FROM 
    combined_sales cs
LEFT JOIN 
    DimProduct dp
ON 
    cs.ProductKey = dp.ProductKey
WHERE 
    dp.EnglishProductName IS NOT NULL
GROUP BY 
    dp.EnglishProductName
ORDER BY 
    Total_Sales DESC;

    #-----------------------------
    ALTER TABLE dimCustomer
ADD COLUMN CustomerName VARCHAR(255);
SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = 0;
UPDATE dimCustomer
SET CustomerName = CONCAT(FirstName, ' ', COALESCE(MiddleName, ''), ' ', LastName)
WHERE CustomerName IS NULL OR CustomerName = '';
select* from dimcustomer;
#--------------------------------------unitprice, orderquantity, total productcost 
    SELECT 
    s.productkey,
    c.Customerkey,
    c.FirstName,
    c.MiddleName,
    c.LastName,
    CONCAT(c.FirstName, ' ', COALESCE(c.MiddleName, ''), ' ', c.LastName) AS CustomerFullName,
    s.UnitPrice,
    s.orderQuantity,
    (s.orderQuantity * s.UnitPrice) AS Totalproductcost
FROM 
    combined_sales s
JOIN 
    dimcustomer c ON s.Customerkey = c.Customerkey
JOIN 
    dimProduct p ON s.Productkey = p.Productkey;
    #------------------------------------------------convert date
    SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate
FROM combined_Sales;
#-----------------------------year
SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    YEAR(STR_TO_DATE(OrderDateKey, '%Y%m%d')) AS OrderYear
FROM 
    combined_sales;
    #--------------------month number
     SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    MONTH(STR_TO_DATE(OrderDateKey, '%Y%m%d')) AS OrderMonth
FROM 
    combined_sales;
#==========================monthfullname
 SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    MONTHNAME(STR_TO_DATE(OrderDateKey, '%Y%m%d')) AS OrderMonthName
FROM 
    combined_sales;
    #--------------------quarter
     SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    CONCAT('Q', QUARTER(STR_TO_DATE(OrderDateKey, '%Y%m%d'))) AS OrderQuarter
FROM 
    combined_sales;
    #---------------------------------year and month
  SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    YEAR(STR_TO_DATE(OrderDateKey, '%Y%m%d')) AS OrderYear,
    MONTHNAME(STR_TO_DATE(OrderDateKey, '%Y%m%d')) AS OrderMonthName
FROM 
    combined_sales;
    #---------------------------------weekdayno
     SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    DAYOFWEEK(STR_TO_DATE(OrderDateKey, '%Y%m%d')) AS WeekdayNumber
FROM 
    combined_sales;
    #------------------------weekdayname
     SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    DAYNAME(STR_TO_DATE(OrderDateKey, '%Y%m%d')) AS WeekdayName
FROM 
    combined_sales;
    #------------------------financial month
        SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    CASE 
        WHEN MONTH(STR_TO_DATE(OrderDateKey, '%Y%m%d')) >= 4 THEN 
            MONTH(STR_TO_DATE(OrderDateKey, '%Y%m%d')) - 3
        ELSE 
            MONTH(STR_TO_DATE(OrderDateKey, '%Y%m%d')) + 9
    END AS FinancialMonth
FROM 
    combined_sales;
    #--------------------------financial quarter
    SELECT 
    OrderDateKey,
    STR_TO_DATE(OrderDateKey, '%Y%m%d') AS OrderDate,
    CASE 
        WHEN MONTH(STR_TO_DATE(OrderDateKey, '%Y%m%d')) >= 4 THEN 
            CONCAT('Q', CEIL((MONTH(STR_TO_DATE(OrderDateKey, '%Y%m%d')) - 3) / 3))
        ELSE 
            CONCAT('Q', CEIL((MONTH(STR_TO_DATE(OrderDateKey, '%Y%m%d')) + 9) / 3))
    END AS FinancialQuarter
FROM 
    combined_sales;
    #------------------------sales amount
       SELECT 
    OrderDateKey,
    UnitPrice,
    OrderQuantity,
    Discountamount,
    (UnitPrice * OrderQuantity) - Discountamount AS SalesAmount
FROM 
    combined_sales;
    #---------------productcost
      SELECT 
    OrderDateKey,
    Unitprice,
    OrderQuantity,
    (Unitprice * OrderQuantity) AS ProductionCost
FROM 
    combined_sales;
#-----------------------------
SELECT 
    DATE_FORMAT(STR_TO_DATE(CAST(orderDatekey AS CHAR), "%Y%m%d"), "%b") AS FormattedDate, 
    ROUND(SUM(salesamount), 2) AS Total_Sales 
FROM 
    combined_sales
GROUP BY 
    formatteddate;

    #----------------------------------merge products(inner join)
 SELECT 
    p.*,
    sc.*,
    pc.*
FROM dimProduct p
-- Inner join between DimProduct and DimProdSubCategory on productSubCategoryKey
INNER JOIN dimProductSubCategory sc ON p.productSubCategorykey = sc.productSubCategorykey
-- Inner join between DimProdSubCategory and DimProdCategory on productCategoryKey
INNER JOIN dimProductCategory pc ON sc.productCategorykey = pc.productCategorykey;

    #-----------------profit
  select SUM(salesamount - totalproductcost - freight) AS profit
from combined_sales;
    #----countoforders
select count(orderquantity) from combined_sales;
#--------------
select sum(SalesAmount) from combined_sales;


    