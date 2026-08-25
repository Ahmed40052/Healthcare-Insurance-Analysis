-- Business Question 2: How do regions rank by average charges?
-- Finding: Southeast has the highest average charges (~$14,735), 
-- notably higher than the other three regions which are relatively close to each other.

SELECT 
    region,
    AVG(charges) AS avg_charges,
    COUNT(*) AS num_patients
FROM Insurance
GROUP BY region
ORDER BY avg_charges DESC;