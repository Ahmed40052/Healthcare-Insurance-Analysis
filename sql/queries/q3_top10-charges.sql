
---patients above the top 10% in charges  
SELECT TOP 10 PERCENT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges
FROM Insurance
ORDER BY charges DESC;
----common characteristics
SELECT 
    smoker,
    AVG(age) AS avg_age,
    AVG(bmi) AS avg_bmi,
    AVG(children) AS avg_children,
    COUNT(*) AS patients
FROM (
    SELECT TOP 10 PERCENT
        age, sex, bmi, children, smoker, charges
    FROM Insurance
    ORDER BY charges DESC
) AS Top10
GROUP BY smoker;