
#====1
select* from invoice_1.invoice;
SELECT 
    COUNT(Invoice_number) AS NumberOfInvoices
FROM 
    Invoice_1.invoice;
    SELECT 
    Account_Executive, 
    COUNT(Invoice_number) AS NumberOfInvoices
FROM 
    Invoice_1.invoice
GROUP BY 
    Account_Executive
    LIMIT 0, 1000;
    #====2
USE `insurance project`;
SHOW DATABASES;
SELECT DISTINCT YEAR(Meeting_Date) AS Year
FROM Meeting
WHERE YEAR(Meeting_Date) IN (2019, 2020);
DESCRIBE Meeting;
SELECT 
    YEAR(STR_TO_DATE(Meeting_Date, '%d-%m-%Y')) AS Year,
    COUNT(*) AS NumberOfMeetings
FROM 
    Meeting
WHERE 
    YEAR(STR_TO_DATE(Meeting_Date, '%d-%m-%Y')) IN (2019, 2020)
GROUP BY 
    YEAR(STR_TO_DATE(Meeting_Date, '%d-%m-%Y'))
ORDER BY 
    Year; 
    #--------4
    WITH FunnelStages AS (
    SELECT
        Stage,
        SUM(Revenue_amount) AS TotalRevenue
    FROM opportunity
    GROUP BY Stage
),
RankedStages AS (
    SELECT
        Stage,
        TotalRevenue,
        ROW_NUMBER() OVER (ORDER BY FIELD(Stage,  'Qualify opportunity', 'negotiate', 'propose solution')) AS StageRank
    FROM FunnelStages
)
SELECT
    Stage,
    TotalRevenue,
    StageRank,
    LAG(TotalRevenue) OVER (ORDER BY StageRank) AS PreviousStageRevenue,
    TotalRevenue - COALESCE(LAG(TotalRevenue) OVER (ORDER BY StageRank), 0) AS RevenueChange
FROM RankedStages
ORDER BY StageRank;
#--------5
    SELECT Account_Executive, COUNT(*) AS NumberOfMeetings
FROM Meeting
GROUP BY Account_Executive;
#--------------6
USE `insurance project`;
show tables;
select* from opportunity;
SELECT Opportunity_Name, Revenue_amount
FROM Opportunity
ORDER BY Revenue_amount DESC
LIMIT 4;
DESCRIBE Opportunity;