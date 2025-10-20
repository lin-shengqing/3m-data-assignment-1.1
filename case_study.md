# Video Game Sales Analysis

## Dataset

You will be working with the following dataset: [Video Game Sales](https://www.kaggle.com/datasets/gregorut/videogamesales?resource=download)

📦 **Dataset Download Instructions**
1. Download the dataset ZIP file from the above link.
2. After downloading: Unzip the file to access vgsales.csv. Note the full file path to vgsales.csv — you'll need it in the next step.

🔍 **Challenge: Load the Data into DuckDB**
Using DBeaver and your DuckDB connection, how would you load the vgsales.csv file into a table so you can begin querying it?

## Business Question
How can game developers and publishers optimize their strategy to maximize global sales by understanding the performance of different game genres, platforms, and publishers?

*To answer the above question, use the following SQL queries to explore the dataset and address the following questions:*

Which genres contribute the most to global sales?

SQL:
```sql
SELECT Genre, SUM(Global_Sales) AS Total_Global_Sales
FROM vgsales
GROUP BY Genre
ORDER BY Total_Global_Sales DESC;
```
Findings:
```findings
Action
```
Which platforms generate the highest global sales?

SQL:
```sql
SELECT Platform, SUM(Global_Sales) AS Total_Global_Sales
FROM vgsales
GROUP BY Platform
ORDER BY Total_Global_Sales DESC;
```
Findings:
```findings
PS2
```
Which publishers are the most successful in terms of global sales?

SQL:
```sql
SELECT Publisher, SUM(Global_Sales) AS Total_Global_Sales
FROM vgsales
GROUP BY Publisher
ORDER BY Total_Global_Sales DESC;
```
Findings:
```findings
Nintendo
```
How does success vary across regions (North America, Europe, Japan, Others)?

SQL:
```sql
SELECT SUM(Global_Sales) AS Total_Global_Sales
	,SUM(NA_Sales) AS Total_NA_Sales
	,SUM(EU_Sales) AS Total_EU_Sales
	,SUM(JP_Sales) AS Total_JP_Sales
	,SUM(Other_Sales) AS Total_Other_Sales
FROM vgsales
ORDER BY Total_Global_Sales DESC;
```
Findings:
```findings
North America
```
What are the trends over time in game sales by genre and platform?

SQL:
```sql
WITH 
    base AS (
        SELECT year, genre,
            SUM(global_sales) total_sales
        FROM vgsales 
        GROUP BY year, genre
    )
SELECT 
    base.year, base.genre, base.total_sales
FROM base
    JOIN (
        SELECT year,
            MAX(total_sales) max_sales
        FROM base
        GROUP BY 
            year
    ) max ON base.year=max.year
        AND base.total_sales=max.max_sales
ORDER BY 
    base.year;

WITH 
    base AS (
        SELECT year, platform,
            SUM(global_sales) total_sales
        FROM vgsales 
        GROUP BY year, platform
    )
SELECT 
    base.year, base.platform, base.total_sales
FROM base
    JOIN (
        SELECT 
            year,
            MAX(total_sales) max_sales
        FROM base
        GROUP BY year
    ) max ON base.year=max.year
        AND base.total_sales=max.max_sales
ORDER BY 
    base.year;
```
Findings:
```findings
For Genre, mostly Action from 2001 to 2016
For Platform, over time is 2600, NES, SNES, PS, PS2, Wii, X360, PS3, PS4
```
Which platforms are most successful for specific genres?

SQL:
```sql
WITH 
    base AS (
		SELECT Genre, Platform
			, SUM(Global_Sales) AS Total_Global_Sales
			,ROW_NUMBER() OVER (PARTITION BY genre ORDER BY SUM(global_sales) DESC) rank
		FROM vgsales
		GROUP BY Genre, Platform
)
SELECT * FROM base WHERE rank < 4
ORDER BY Genre, rank;
```
Findings:
```findings
PS3
```
## Deliverables:
- SQL Queries: Provide all the SQL queries you used to answer the business questions.
- Summary of Findings: For each question, summarise your key findings and recommendations based on your analysis.

## Submission

- Submit the GitHub URL of your assignment to NTU black board.
- Should you reference the work of your classmate(s) or online resources, give them credit by adding either the name of your classmate or URL.
