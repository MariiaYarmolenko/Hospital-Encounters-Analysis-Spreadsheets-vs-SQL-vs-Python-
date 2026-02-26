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
- Metrics: ~ TOTAL_VISITS, 'SUM of TOTAL_CLAIM_COST' , 'AVERAGE of TOTAL_CLAIM_COST' , 'AVERAGE of DURATION_HOURS'.

<img width="1085" height="217" alt="Знімок екрана 2026-02-26 113319" src="https://github.com/user-attachments/assets/58a32d4a-5e61-44cc-8d06-0d421c7824b4" />

### SQL (MySQL Workbench)

- Technical preparation: Setting up root access via terminal, creating the 'hospital_db' database.
- ETL: Import 'encounters.csv' . Resolved ISO 8601 format issue by disabling "Safe Update Mode" and using 'REPLACE' and 'STR_TO_DATE' functions .
- Transformation: Adding new 'DATETIME' columns and updating data.
- Analytics: Writing a complex query using 'GROUP BY' and 'TIMESTAMPDIFF' .

<img width="562" height="170" alt="Знімок екрана 2026-02-23 162507" src="https://github.com/user-attachments/assets/563b89b2-2bd5-491c-af93-98ac73bae5cb" />

### Python

- Environment: Google Colaboratory with Google Drive connectivity.
- Cleanup: Using 'pd.to_datetime()' to automatically recognize complex date formats.
- Manipulation: Creating a vectorized column 'duration_hours' .
- Aggregation: Grouping data via '.groupby()' and applying the '.agg()' method .

<img width="820" height="196" alt="Знімок екрана 2026-02-26 113617" src="https://github.com/user-attachments/assets/be04ce8f-aa22-4f5c-ba98-15f21d790606" />

---

## Conclusions

- Validation: All three tools produced identical results, confirming the correctness of the calculations.
- Flexibility: Python (Pandas) proved to be the fastest at handling complex date formats.
- Scalability: SQL is best suited for storing large amounts of data, while Sheets is ideal for instant visualization.

---

## Repository structure

'analysis.sql' — SQL scripts for transformation and queries.
'analysis.ipynb' — Jupyter Notebook with full Python processing cycle.
'formulas_guide.md' — documentation of formulas and methods for Sheets.
'encounters.csv' — dataset for analysis.
