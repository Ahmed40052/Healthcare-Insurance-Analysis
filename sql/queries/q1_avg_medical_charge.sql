-- Business Question 1: What is the average medical charge by smoking status, region, and number of children?
-- Findings:Smokers have much higher average medical charges than non-smokers.
--- Southeast has the highest average charges by region.
--- Medical charges vary across different numbers of children.
---Smoking shows a strong association with higher medical charges.
---------------------------------------------------------------
---- 1. Average medical charges by smoking status
SELECT 
    smoker,
    ROUND(AVG(charges), 2) AS avg_charges,
    COUNT(*) AS count
FROM insurance
GROUP BY smoker;
---------------------------------------
---- 2. Average medical charges by region (sorted descending)
SELECT 
    region,
    ROUND(AVG(charges), 2) AS avg_charges,
    COUNT(*) AS count
FROM insurance
GROUP BY region
ORDER BY avg_charges DESC;
----------------------------------------
---- 3. Average medical charges by number of children
SELECT 
    children,
    ROUND(AVG(charges), 2) AS avg_charges,
    COUNT(*) AS count
FROM insurance
GROUP BY children
ORDER BY children;
----------------------------------------
-- 4. Combined analysis: smoking status + region + number of children
SELECT 
    smoker,region,children,
    ROUND(AVG(charges), 2) AS avg_charges,
    COUNT(*) AS count
FROM insurance
GROUP BY smoker, region, children
ORDER BY smoker, region, children;