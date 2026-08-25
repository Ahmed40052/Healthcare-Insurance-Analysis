-- Business Question 4: How do BMI categories compare in average charges?
-- Combined with smoker status to reveal the strongest cost driver
-- Finding: Obese + smoker patients have avg charges ~4.7x higher than obese non-smokers

SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,
    smoker,
    ROUND(AVG(charges), 2) AS avg_charges,
    COUNT(*) AS num_patients
FROM insurance
GROUP BY
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END,
    smoker
ORDER BY bmi_category, smoker;