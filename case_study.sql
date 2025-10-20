SELECT "Rank", "Name", Platform, "Year", Genre, Publisher, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales
FROM vgsales;

--Which genres contribute the most to global sales?
SELECT Genre, SUM(Global_Sales) AS Total_Global_Sales
FROM vgsales
GROUP BY Genre
ORDER BY Total_Global_Sales DESC;
--Action

--Which platforms generate the highest global sales?
SELECT Platform, SUM(Global_Sales) AS Total_Global_Sales
FROM vgsales
GROUP BY Platform
ORDER BY Total_Global_Sales DESC;
--PS2

--Which publishers are the most successful in terms of global sales?
SELECT Publisher, SUM(Global_Sales) AS Total_Global_Sales
FROM vgsales
GROUP BY Publisher
ORDER BY Total_Global_Sales DESC;
--Nintendo

--How does success vary across regions (North America, Europe, Japan, Others)?
SELECT SUM(Global_Sales) AS Total_Global_Sales
	,SUM(NA_Sales) AS Total_NA_Sales
	,SUM(EU_Sales) AS Total_EU_Sales
	,SUM(JP_Sales) AS Total_JP_Sales
	,SUM(Other_Sales) AS Total_Other_Sales
FROM vgsales
ORDER BY Total_Global_Sales DESC;
--North America


--What are the trends over time in game sales by genre and platform?
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

-- For Genre, mostly Action from 2001 to 2016
--For Platform, over time is 2600, NES, SNES, PS, PS2, Wii, X360, PS3, PS4

--Which platforms are most successful for specific genres?
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
--ps3