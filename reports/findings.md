## Q4: BMI Category vs Average Charges (Diagnostic)

### BMI Category Only

| BMI Category | Mean Charges | Median Charges | Count |
|---|---|---|---|
| Underweight | $8,657.62 | $6,640.54 | 21 |
| Normal | $10,435.44 | $8,604.15 | 226 |
| Overweight | $10,997.80 | $8,659.38 | 386 |
| Obese | $15,580.70 | $10,003.65 | 704 |

### Smoker Status Only

| Smoker | Mean Charges | Median Charges | Count |
|---|---|---|---|
| No | $8,440.66 | $7,345.73 | 1,063 |
| Yes | $32,050.23 | $34,456.35 | 274 |

### BMI Category x Smoker (Key Combination)

| BMI Category | Smoker | Mean Charges | Median Charges | Count |
|---|---|---|---|---|
| Underweight | No | $5,485.06 | $4,249.32 | 16 |
| Underweight | Yes | $18,809.82 | $15,006.58 | 5 |
| Normal | No | $7,734.65 | $6,669.48 | 176 |
| Normal | Yes | $19,942.22 | $19,479.90 | 50 |
| Overweight | No | $8,226.09 | $7,046.72 | 311 |
| Overweight | Yes | $22,491.18 | $21,348.71 | 75 |
| **Obese** | **No** | **$8,866.16** | $8,100.09 | 560 |
| **Obese** | **Yes** | **$41,692.81** | $40,918.31 | 144 |

**Finding:** Obese smokers average **$41,692.81** in charges — **4.70x** higher than obese non-smokers ($8,866.16). Smoking status changes the cost picture far more dramatically than BMI category alone. This is the clearest cost driver identified in the dataset.

### Correlation (Age, BMI, Charges)

| | age | bmi | charges |
|---|---|---|---|
| age | 1.000 | 0.109 | 0.298 |
| bmi | 0.109 | 1.000 | 0.198 |
| charges | 0.298 | 0.198 | 1.000 |

**Finding:** Age and BMI show only weak correlation with charges individually (0.298 and 0.198). Neither explains cost well on its own — smoking status is the dominant factor.

### Charges by Age Group

| Age Group | Avg BMI | Avg Charges |
|---|---|---|
| 18-29 | 29.85 | $9,200.62 |
| 30-39 | 30.44 | $11,738.78 |
| 40-49 | 30.71 | $14,399.20 |
| 50-59 | 31.51 | $16,495.23 |
| 60+ | 32.02 | $21,248.02 |

**Finding:** Average charges more than double from the youngest to oldest age group, while average BMI rises only slightly across the same groups.

### Outlier Analysis (IQR Method)

- Q1: $4,746.34, Q3: $16,657.72, IQR: $11,911.37
- Upper bound: $34,524.78
- **Number of outliers: 139** (10.4% of patients)

**Finding:** Among the 139 high-cost outliers, **97.8% are smokers** and **96.4% are classified as Obese**. These are not data errors — they represent a real, identifiable high-cost population segment (obese smokers).

### Bottom Line

Smoking status — especially combined with obesity — is the dominant driver of medical costs in this dataset, far outweighing age or BMI alone.
