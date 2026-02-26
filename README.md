# Hospital Encounters Analysis: Spreadsheets vs  SQL vs Python

## Project description

The goal of this project was to conduct a comparative analysis of medical encounters using three different tools. I examined the effectiveness of each tool for cleaning data, transforming date formats, and calculating key business metrics: number of encounters, total cost, and average appointment duration.

---

## Tools and steps used

### Google Sheets

- Process: CSV import, comma-separated text.
- Data Cleaning: Cleaning date and time formats.
- Calculations: Creating a formula to find the difference between the start and end of a reception (converted to hours).
- Reporting: Creating a Pivot Table.
- Metrics: ```TOTAL_VISITS```, ```SUM of TOTAL_CLAIM_COST```, ```AVERAGE of TOTAL_CLAIM_COST```, ```AVERAGE of DURATION_HOURS```.

<img width="1085" height="217" alt="Знімок екрана 2026-02-26 113319" src="https://github.com/user-attachments/assets/58a32d4a-5e61-44cc-8d06-0d421c7824b4" />

### SQL (MySQL Workbench)

- Technical preparation: Setting up root access via terminal, creating the ```hospital_db``` database.
- ETL: Import ```encounters.csv```. Resolved ISO 8601 format issue by disabling "Safe Update Mode" and using ```REPLACE``` and ```STR_TO_DATE``` functions .
- Transformation: Adding new ```DATETIME``` columns and updating data.
- Analytics: Writing a complex query using ```GROUP BY``` and ```TIMESTAMPDIFF```.

``` SQL
SELECT 
    ENCOUNTERCLASS,
    COUNT(*) AS total_visits,
    ROUND(SUM(TOTAL_CLAIM_COST), 2) AS total_cost,
    ROUND(AVG(TOTAL_CLAIM_COST), 2) AS avg_cost,
    ROUND(AVG(TIMESTAMPDIFF(SECOND, Start_DateTime, Stop_DateTime) / 3600), 2) AS avg_duration_hours
FROM encounters
GROUP BY ENCOUNTERCLASS;
```

<img width="562" height="170" alt="Знімок екрана 2026-02-23 162507" src="https://github.com/user-attachments/assets/563b89b2-2bd5-491c-af93-98ac73bae5cb" />

### Python

- Environment: Google Colaboratory with Google Drive connectivity.
- Cleanup: Using ```pd.to_datetime()``` to automatically recognize complex date formats.
- Manipulation: Creating a vectorized column ```duration_hours```.
- Aggregation: Grouping data via ```.groupby()``` and applying the ```.agg()``` method .

``` Python
import pandas as pd
df['START'] = pd.to_datetime(df['START'])
df['STOP'] = pd.to_datetime(df['STOP'])
df['duration_hours'] = (df['STOP'] - df['START']).dt.total_seconds() / 3600

analysis = df.groupby('ENCOUNTERCLASS').agg({
    'Id': 'count',
    'TOTAL_CLAIM_COST': ['sum', 'mean'],
    'duration_hours': 'mean'
})
```

<img width="820" height="196" alt="Знімок екрана 2026-02-26 113617" src="https://github.com/user-attachments/assets/be04ce8f-aa22-4f5c-ba98-15f21d790606" />

---

## Analysis of results and key findings

### 1. Data validation and accuracy of tools

Conclusion: The use of three independent tools (SQL, Python, Spreadsheet) allowed for a full cross-validation of the results.

Details: The number of visits `total_visits` and total costs `total_cost` are identical in all environments, confirming the integrity of the data after import.

### 2. Efficiency of types of medical care

Conclusion: The most resource-intensive type of admission is *Inpatient*, while *Ambulatory* (outpatient visits) make up the bulk of the appeals.

Key metrics:

*Inpatient*: Highest average cost (~$7,761) and longest duration (~36.8 hours), consistent with the nature of hospitalization.

*Ambulatory*: Highest volume of visits (12,537), generating the highest total revenue (~$36.2 million), despite a low average duration (~9.5 hours).

*Urgentcare* & *Wellness*: Have the shortest duration (15 min / 0.25 h), indicating the standardized and fast nature of these services.

### 3. Technical conclusions (ETL and transformation)

Conclusion: Automation via Python and SQL is significantly more robust for large data sets than manual processing in tables.

Details:

Python’s `pd.to_datetime` function best coped with the non-standard ISO 8601 format without additional text manipulation.

Using SQL allows you to work with data directly on the server, which is critical for security and performance when scaling the project.

### 4. Business insights for the institution

Conclusion: The cost structure shows a significant financial burden on urgent care *Emergency*, where the average cost (~$4,629) is the second highest after *Inpatient* care, although visits last only 1.5 hours on average. This may indicate the high cost of medical procedures in critical conditions.


---

## Repository structure

```Hospital_Encounters_Analysis.sql``` — SQL scripts for transformation and queries.  
```Hospital_Encounters_Analysis.ipynb``` — Jupyter Notebook with full Python processing cycle.  
```Hospital_Encounters_Analysis_formulas_guide.md``` — documentation of formulas and methods for Sheets.  
```encounters.csv``` — dataset for analysis.  
