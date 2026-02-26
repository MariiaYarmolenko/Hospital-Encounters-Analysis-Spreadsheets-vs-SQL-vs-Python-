# Google Sheets Formula and Techniques Guide

### Converting Duration to Hours

Since spreadsheets count time as a fraction of a day (where 1 = 24 hours), the formula used to get the pure number of hours is:
- **Formula:** `=(STOP - START) * 24`
- **Cell Format:** `Number` (to see decimals, e.g. 9.48).

### Cleaning ISO dates

To remove `T` and `Z` characters from text:
- `=ARRAYFORMULA(IF(B2:B="", "", VALUE(SUBSTITUTE(SUBSTITUTE(B2:B, "T", " "), "Z", ""))))`
