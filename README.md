# Healthcare Insurance Analysis

## Project Story

This project analyzes 1,337 cleaned healthcare-insurance records to understand what drives medical charges. The discussion follows the team's presentation order: regional cost patterns and high-cost patients first, BMI and regional risk factors second, demographic drivers third, and the Power BI dashboard last.

### Main business findings

- The Southeast has the highest average charges: **$14,735.41**.
- The top 10% of charges are overwhelmingly associated with smokers.
- Smoking combined with obesity creates the highest-cost segment.
- The Southeast combines high charges, the highest smoker rate, and above-average BMI.
- Age increases charges gradually, while number of children has no consistent linear effect.
- The apparent gender gap disappears after controlling for smoking status.

---

## Presenter 1: Regional Cost and High-Cost Patients

### 1. How do regions rank by average charges?

We compared average charges and patient counts by region using Excel and Python. Both methods produced the same results.

| Region | Average Charges | Patients |
|---|---:|---:|
| **Southeast** | **$14,735.41** | 364 |
| Northeast | $13,406.38 | 324 |
| Northwest | $12,450.84 | 324 |
| Southwest | $12,346.94 | 325 |
<img width="1860" height="1024" alt="Q2_avg_charges_by_region" src="https://github.com/user-attachments/assets/a64c34c7-218f-477d-92a0-e989288b6671" />

**Conclusion:** The Southeast is the most expensive region, but the difference is better explained by its risk-factor mix than by geography alone.

### 2. Which patients fall above the top 10% in charges, and what do they have in common?

The top 10% group has a very clear profile:

- **97.8% are smokers**
- Average BMI: **35.65**
- Average age: **41.78**
- The Southeast is the largest represented region

```sql
SELECT TOP 10 PERCENT
    age,
    sex,
    bmi,
    children,
    smoker,
    region,
    charges
FROM Insurance_clean
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
    FROM Insurance_clean
    ORDER BY charges DESC
) AS Top10
GROUP BY smoker;
```

<img width="2036" height="1323" alt="Q3_top10_charges" src="https://github.com/user-attachments/assets/40844d9c-cd15-4c9d-b06f-4361a70973b2" />


**Conclusion:** The most expensive patients are identifiable high-risk cases, mainly smokers with elevated BMI. This segment should be prioritized for prevention and risk monitoring.

---

## Presenter 2: BMI and Regional Risk Factors

### 3. How do different BMI categories compare in average charges?

| BMI Category | Non-Smoker Average | Smoker Average | Increase |
|---|---:|---:|---:|
| Underweight | $5,485.06 | $18,809.82 | x3.4 |
| Normal | $7,734.65 | $19,942.22 | x2.6 |
| Overweight | $8,226.09 | $22,491.18 | x2.7 |
| **Obese** | **$8,866.16** | **$41,692.81** | **x4.7** |

![BMI category versus average charges](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/bmi_categories.png)

**Conclusion:** BMI alone has a limited effect, but obese smokers are by far the most expensive group.

### 4. What is the smoker rate by region, and does the highest smoker rate match the highest average charges?

Yes. The Southeast has the highest smoker rate at approximately **25%**, compared with approximately **17.8%–20.7%** in the other regions. It is also the region with the highest average charges.

![Average charges versus smoker rate by region](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/region_smoker.png)

**Conclusion:** The regional cost gap is strongly connected to smoker mix.

### 5. What is the average BMI by region, and is there a region with above-average BMI and charges?

| Region | Average BMI |
|---|---:|
| Northeast | 29.17 |
| Northwest | 29.20 |
| **Southeast** | **33.36** |
| Southwest | 30.60 |

![Average BMI by region](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/bmi_region.png)

**Conclusion:** The Southeast is the clearest double-risk region because it combines above-average BMI with above-average charges.

---

## Presenter 3: Additional Cost Drivers

### 6. What is the average medical charge by smoking status, region, and number of children?

- Smokers: **$32,050.23** average charges
- Non-smokers: **$8,440.66** average charges
- Smokers pay approximately **3.8x more** on average
- Number of children varies by group but shows no consistent linear relationship with charges

```sql
SELECT
    smoker, region, children,
    ROUND(AVG(charges), 2) AS avg_charges,
    COUNT(*) AS count
FROM insurance
GROUP BY smoker, region, children
ORDER BY smoker, region, children;
```

**Conclusion:** Smoking status is much more important than family size as a cost driver.

### 7. Do charges increase steadily with age, or jump after a threshold?

| Age Group | Average Charges |
|---|---:|
| 18–29 | $9,200.62 |
| 30–39 | $11,738.78 |
| 40–49 | $14,399.20 |
| 50–59 | $16,495.23 |
| 60+ | **$21,248.02** |

![Average charges by age group](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/age.png)

**Conclusion:** Charges rise gradually with age. Smoking remains the stronger explanation for the largest cost jumps.

### 8. Is there a cost difference between males and females after controlling for smoking?

- Raw male average: **$13,975.00**
- Raw female average: **$12,569.58**
- After controlling for smoking, the apparent gender difference disappears.

![Average charges by gender and smoker status](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/gender.png)

**Conclusion:** The raw gender difference is mainly caused by different smoking-rate distributions, not gender itself.

---

## Presenter 4: Power BI Dashboard

The Power BI dashboard brings the eight analysis questions together in one visual management view. It lets the audience compare regional charges, smoker status, BMI, age, gender, and high-cost patients without moving between separate reports.

### Dashboard walkthrough

1. **Headline KPIs:** total patients, average charges, and the overall cost level.
2. **Regional comparison:** Southeast appears as the highest-charge region.
3. **Smoking analysis:** the dashboard shows the large gap between smokers and non-smokers.
4. **BMI analysis:** the obese-smoker segment is visible as the highest-risk combination.
5. **Demographic analysis:** age and gender can be reviewed while keeping smoking status in context.
6. **Interactive filtering:** region, smoker status, age group, and BMI category can be selected to update the charge profile.

![Power BI Dashboard](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/dashboard/dashboard_screenshots/dashboard.png)

Power BI file: [`dashboard/dashboard.pbix`](https://github.com/Ahmed40052/Healthcare-Insurance-Analysis/blob/main/dashboard/dashboard.pbix)

---

---

## Diagnostic Analytics

The diagnostic work validates the main findings through additional comparisons and outlier analysis:

- 139 high-cost patients were identified, representing 10.4% of the sample.
- **97.8%** of these outliers are smokers.
- **96.4%** are obese.
- Smoking has a stronger relationship with charges than age or BMI alone.

![Outlier analysis by BMI](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/outliers_bmi.png)

**Diagnostic conclusion:** The cost pattern is robust. Smoking and obesity are the primary risk combination, age is secondary, and gender is not an independent driver.

---

## Final Business Takeaway

**Medical costs are driven primarily by smoking, especially when combined with obesity. The Southeast is the highest-risk region because it combines high charges, the highest smoker rate, and above-average BMI. The recommended focus is targeted prevention and risk management for this segment rather than broad pricing changes for every customer.**

## Project Resources

- Data: [`data/processed/insurance_clean.csv`](data/processed/insurance_clean.csv)
- SQL queries: [`sql/queries/`](sql/queries/)
- Notebooks: [`notebooks/`](notebooks/)
- Reports and visuals: [`reports/`](reports/)
- Dashboard: [`dashboard/`](dashboard/)

---

## Detailed Methodology and Validation

The following notes preserve the detailed work from the three original team documents. They explain how each result was produced, how it was checked, and which project files contain the code, workbook, or chart.

### Question 1: Regional average charges

The regional analysis started with an Excel PivotTable. The `region` field was placed in Rows and `charges` was placed in Values using **Average**, not Sum. The result was independently reproduced in Python with pandas `groupby`. The figures matched exactly, confirming that the PivotTable calculation was reliable.

The team then investigated why the Southeast was more expensive. A numeric `is_smoker` helper field was created: 1 for `smoker = yes` and 0 otherwise. Averaging this field gives the smoker percentage. A second PivotTable compared average charges and average smoker rate by region, and a combo PivotChart displayed the two measures together.

During the first chart attempt, an unwanted `(blank)` category appeared because the source data contained an empty row. The empty rows were removed and the PivotTable was refreshed.

Files:

- SQL query: [`sql/queries/q2_avg_charges_by_region.sql`](sql/queries/q2_avg_charges_by_region.sql)
- Python notebook: [`notebooks/Q2_avg_charges_by_region.ipynb`](notebooks/Q2_avg_charges_by_region.ipynb)
- Excel workbook: [`reports/Alyaa/Q4_region_chargers_vs_smoker_rate/region_charges_vs_smoker_rate.xlsx`](<reports/Alyaa/Q4_region_chargers_vs_smoker_rate/region_charges_vs_smoker_rate.xlsx>)
- Chart: [`reports/readme_charts/region_charges.jpg`](reports/readme_charts/region_charges.jpg)

### Question 2: Patients above the top 10% in charges

The top-decile SQL query selects the highest 10% of charges and returns age, sex, BMI, children, smoker status, region, and charges. A second query groups the selected patients by smoking status and calculates average age, average BMI, average children, and patient count. This identifies common characteristics instead of treating the top-cost patients as unrelated individual outliers.

The supporting Excel analysis converts the continuous `charges` field into discrete ranges such as `00K-05K`, `05K-10K`, and higher brackets. A PivotTable counts smokers and non-smokers within each range, and a horizontal stacked bar chart makes the distribution visible. Non-smokers are concentrated below 15K, while smokers are absent from the lowest tiers and spread through the most expensive tiers.

Files:

- SQL query: [`sql/queries/top10-charges.sql`](sql/queries/top10-charges.sql)
- Python notebook: [`notebooks/Q1.ipynb`](notebooks/Q1.ipynb)
- Excel workbook: [`reports/Ebtihal/q6_Charges distribution by smoker status/q6_Charges distribution by smoker status.xlsx`](<reports/Ebtihal/q6_Charges distribution by smoker status/q6_Charges distribution by smoker status.xlsx>)
- Chart: [`reports/readme_charts/charge_distribution.png`](reports/readme_charts/charge_distribution.png)

![Charge distribution by smoker status](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/charge_distribution.png)

### Question 3: BMI categories and smoking interaction

The continuous BMI field was bucketed into four WHO-style categories: Underweight below 18.5, Normal from 18.5 to 24.9, Overweight from 25 to 29.9, and Obese at 30 or above. The categories were implemented twice: with SQL Server `CASE WHEN` and with Python pandas `pd.cut`.

The analysis first calculated average charges by BMI category alone. It then added smoker status to the grouping. This second step revealed that BMI alone changes average charges only modestly, while BMI combined with smoking produces a dramatic difference. The diagnostic work also compared means and medians to check whether the high obese-smoker average was caused only by a few extreme observations.

One SQL Server issue occurred during development: SQL Server does not allow a `SELECT` alias to be used directly in `GROUP BY`, so the complete `CASE WHEN` expression had to be repeated in the grouping clause.

Files:

- SQL queries: [`sql/queries/q4_bmi_category_avg_charges.sql`](sql/queries/q4_bmi_category_avg_charges.sql) and [`sql/queries/bmi_smoker.sql`](sql/queries/bmi_smoker.sql)
- Diagnostic notebook: [`notebooks/diagnostic_analysis_bmi_smoker_age.ipynb`](notebooks/diagnostic_analysis_bmi_smoker_age.ipynb)
- Excel workbook: [`reports/Alyaa/Q3_BMI category vs. average charges/BMI category vs. average charges.xlsx`](<reports/Alyaa/Q3_BMI category vs. average charges/BMI category vs. average charges.xlsx>)
- Chart: [`reports/readme_charts/bmi_categories.png`](reports/readme_charts/bmi_categories.png)

### Question 4: Smoker rate by region

The regional smoker-rate analysis reused the `is_smoker` concept. In Excel, an `IF` formula created a numeric helper column. In Python, a lambda function checked whether `smoker == 'yes'`. The two independent calculations matched.

Because average charges are measured in dollars and smoker rate is a percentage, putting both on one ordinary axis makes one measure unreadable. The team therefore used a combo chart with columns for charges and a line on a secondary axis for smoker rate. This makes it possible to compare the direction of the two measures at a glance.

Files:

- Python notebook: [`notebooks/region_charges_smoker_rate.ipynb`](notebooks/region_charges_smoker_rate.ipynb)
- Excel workbook: [`reports/Alyaa/Q4_region_chargers_vs_smoker_rate/region_charges_vs_smoker_rate.xlsx`](<reports/Alyaa/Q4_region_chargers_vs_smoker_rate/region_charges_vs_smoker_rate.xlsx>)
- Chart: [`reports/readme_charts/region_smoker.png`](reports/readme_charts/region_smoker.png)

### Question 5: Average BMI by region

The analysis calculated the overall average BMI and overall average charges, then calculated both measures for every region. Regional values were compared against the overall values to identify regions that were above average on both dimensions. The Southeast was the only region meeting both conditions.

The result was cross-checked in Python and presented as a horizontal bar chart, which makes differences between the four regions easy to compare.

Files:

- Python notebook: [`notebooks/avg_region_bmi_analysis.ipynb.ipynb`](notebooks/avg_region_bmi_analysis.ipynb.ipynb)
- Excel workbook: [`reports/Alyaa/Q5_avg_bmi_by_region/avg_bmi_by_region.xlsx`](<reports/Alyaa/Q5_avg_bmi_by_region/avg_bmi_by_region.xlsx>)
- Chart: [`reports/readme_charts/bmi_region.png`](reports/readme_charts/bmi_region.png)

### Question 6: Charges by smoking status, region, and children

The demographic exploratory analysis loaded the cleaned CSV with pandas and grouped the data separately by smoking status, region, and number of children. It then grouped by all three dimensions simultaneously. A `COUNT` column was included with every average because some smoker-region-children combinations contain very few records and could otherwise look more reliable than they are.

The SQL version includes separate queries for smoking status, region, number of children, and the combined grouping. The results show that smokers average $32,050.23 compared with $8,440.66 for non-smokers, while the children analysis varies between groups without a consistent linear trend.

Files:

- SQL query: [`sql/queries/avg_medical_charge.sql`](sql/queries/avg_medical_charge.sql)
- Python notebook: [`notebooks/Q1.ipynb`](notebooks/Q1.ipynb)
- Supporting documentation: [`Q1_charge_distribution_by_smoker_status.md`](Q1_charge_distribution_by_smoker_status.md)

### Question 7: Age and charges

The age analysis first calculated average charges for each individual age. It then created age bands and assigned every record to an Age Group before calculating the average charge for each band. Python used pandas, matplotlib, and seaborn to create the trend visualizations.

The Excel version used PivotTables and `AVERAGEIF`/`AVERAGEIFS` formulas, followed by a line chart. A companion scatter plot colored observations by smoking status showed that non-smoker costs increase gradually with age, while smokers remain much more expensive at every age. This is why age is considered a secondary driver rather than the cause of the largest cost jumps.

Files:

- Python notebook: [`reports/Ebtihal/q7_Average Medical Charge_ excel_python/Average Charges.ipynb`](<reports/Ebtihal/q7_Average Medical Charge_ excel_python/Average Charges.ipynb>)
- Excel workbook: [`reports/Ebtihal/q7_Average Medical Charge_ excel_python/Average Charges.xlsx`](<reports/Ebtihal/q7_Average Medical Charge_ excel_python/Average Charges.xlsx>)
- Age chart: [`reports/readme_charts/age.png`](reports/readme_charts/age.png)
- Python smoker comparison chart: [`reports/readme_charts/age_smoker_python.png`](reports/readme_charts/age_smoker_python.png)
- Excel smoker comparison chart: [`reports/readme_charts/age_smoker_excel.png`](reports/readme_charts/age_smoker_excel.png)

![Charges by age and smoker status](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/age_smoker_python.png)

![Excel charges by age and smoker status](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/age_smoker_excel.png)

### Question 8: Gender and smoking

The gender analysis calculated average charges by sex, then repeated the calculation by both sex and smoker status. Python used pandas, matplotlib, and seaborn. Excel used a PivotTable with `sex` in Rows and `smoker` in Columns, followed by a clustered column chart.

The raw data makes males appear more expensive on average ($13,975.00 versus $12,569.58). Once smoker status is included, the apparent difference disappears. The original analysis therefore concludes that the raw gender gap is caused by smoking-rate distribution, not by gender itself.

Files:

- Python notebook: [`reports/Ebtihal/q8_Gender Analysis_ excel_python/Gender_Analysis.ipynb`](<reports/Ebtihal/q8_Gender Analysis_ excel_python/Gender_Analysis.ipynb>)
- Excel workbook: [`reports/Ebtihal/q8_Gender Analysis_ excel_python/Gender Analysis.xlsx`](<reports/Ebtihal/q8_Gender Analysis_ excel_python/Gender Analysis.xlsx>)
- Excel chart: [`reports/readme_charts/gender.png`](reports/readme_charts/gender.png)
- Python chart: [`reports/readme_charts/gender_python.png`](reports/readme_charts/gender_python.png)

![Python gender analysis](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/gender_python.png)

### Diagnostic analytics

The diagnostic work combines regional trends, BMI, smoking, age, gender, and outlier analysis. It loaded the cleaned data, created numeric smoker-rate fields, compared regional averages with overall averages, plotted age against charges by smoker status, and plotted gender against charges by smoker status.

Outlier review identified 139 high-cost patients, representing 10.4% of the sample. Of those cases, 97.8% are smokers and 96.4% are obese. The outliers are therefore not treated as data errors; they represent a real high-risk segment in the dataset.

Files:

- Diagnostic notebook: [`notebooks/diagnostic_analysis_bmi_smoker_age.ipynb`](notebooks/diagnostic_analysis_bmi_smoker_age.ipynb)
- BMI outlier chart: [`reports/readme_charts/outliers_bmi.png`](reports/readme_charts/outliers_bmi.png)
- Smoking outlier chart: [`reports/readme_charts/outliers_smoker.png`](reports/readme_charts/outliers_smoker.png)

![Outlier boxplot by smoking status](https://raw.githubusercontent.com/Ahmed40052/Healthcare-Insurance-Analysis/main/reports/readme_charts/outliers_smoker.png)

### Reproducibility note

The project intentionally uses more than one tool for important findings. SQL provides grouped and ranked queries, Python notebooks provide repeatable calculations and diagnostic plots, and Excel provides PivotTables and presentation charts. When the same values were calculated in two tools, the results were compared to reduce the chance of a formula, filtering, or PivotTable error.
