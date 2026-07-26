-- ==================================
-- RETAIL SALES ANALYSIS
-- ==================================
-- Purpose: Analyze revenue trends, product performance, and sales patterns

-- ==================================
-- Overall Churn KPI
-- ==================================
SELECT 
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers, 
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`;

-- ==================================
-- Contract & Payment Behavior: Contract Type
-- ==================================
SELECT
  Contract, 
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`
GROUP BY Contract
ORDER BY churn_rate DESC;

-- ==================================
-- Contract & Payment Behavior: Payment Method
-- ==================================
SELECT 
 `Payment Method`, 
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`
GROUP BY `Payment Method`
ORDER BY churn_rate DESC;

-- ==================================
-- Demographics: Gender
-- ==================================
SELECT 
  Gender, 
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers, 
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`
GROUP BY Gender;

-- ==================================
-- Demographics: Senior Citizen
-- ==================================
SELECT 
  `Senior Citizen`,
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers, 
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`
GROUP BY `Senior Citizen`;

-- ==================================
-- High-Risk Customer Profile
-- ==================================
SELECT 
  Contract, 
  `Payment Method`,
  `Internet Service`,
  CASE 
    WHEN `Tenure Months` <= 12 THEN 'New'
    WHEN `Tenure Months` <= 48 THEN 'Mid'
    ELSE 'Long-term'
  END AS tenure_group,
  COUNT(*) AS customers,
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`
GROUP BY Contract, `Payment Method`, `Internet Service`, tenure_group
ORDER BY churn_rate DESC;

-- ==================================
-- Services Impact
-- ==================================
SELECT 
  `Tech Support`,
  COUNT(*) AS total_customers, 
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`
GROUP BY `Tech Support`;

-- ==================================
-- Tenure: Customer Loyalty
-- ==================================
SELECT 
  CASE
    WHEN `Tenure Months` BETWEEN 0 AND 12 THEN '0-1 year'
    WHEN `Tenure Months` BETWEEN 13 AND 24 THEN '1-2 years'
    WHEN `Tenure Months` BETWEEN 25 AND 48 THEN '2-4 years'
    ELSE '4+ years'
  END AS tenure_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(SUM(CASE WHEN `Churn Label` = TRUE THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate
FROM `customer-churn-project-500405.Churn_Project.customers`
GROUP BY tenure_group
ORDER BY churn_rate DESC;

-- ==================================
-- Master Query: Customer Churn Analysis
-- ==================================
SELECT
  CustomerID, 
  Gender,
  `Senior Citizen`, 
  Partner,
  Dependents,
  `Phone Service`,
  `Internet Service`,
  `Online Security`,
  `Online Backup`,
  `Device Protection`,
  `Tech Support`,
  `Streaming TV`,
  `Streaming Movies`,
  Contract, 
  `Paperless Billing`,
  `Payment Method`,
  `Monthly Charges`,
  `Total Charges`,
  `Tenure Months`,
  `Churn Label`,
  `Churn Value`,
  `Churn Score`,
  CLTV,
  `Churn Reason`,

  CASE 
    WHEN `Churn Label` = TRUE THEN 'Churned'
    ELSE 'Active'
  END AS customer_status,

  CASE 
    WHEN `Tenure Months` <= 12 THEN '0-12 Months'
    WHEN `Tenure Months` <= 24 THEN '13-24 Months'
    WHEN `Tenure Months` <= 48 THEN '25-48 Months'
    ELSE '48+ Months'
  END AS tenure_group,

  CASE
    WHEN `Monthly Charges` < 35 THEN 'Low'
    WHEN `Monthly Charges` BETWEEN 35 AND 70 THEN 'Medium'
    ELSE 'High'
  END AS charge_group

FROM `customer-churn-project-500405.Churn_Project.customers`;
