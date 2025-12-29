
-- This query returns the number of arrest made during each months of 2025 (Excluding December)
-- I had to format the date to make it proper and extract the month using the EXTRACT command 


WITH month_temp AS (
    SELECT 
        arrest_key,
        EXTRACT(MONTH FROM (arrest_date::DATE)) AS Month
    FROM 
        nypd_arrest_data_new
    ORDER BY 
    Month
)
SELECT 
    COUNT(arrest_key) AS Crime_Count,
    CASE month_temp.Month
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
        ELSE 'Blank'
    END AS Month_Name
FROM 
    month_temp
GROUP BY 
    month_temp.Month

