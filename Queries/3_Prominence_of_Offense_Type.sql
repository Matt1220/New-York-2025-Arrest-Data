
-- This query finds the top ten most common crime types in 2025

SELECT 
    PD_DESC AS Crime_Type,
    COUNT(arrest_key) AS Crime_Count
FROM 
    nypd_arrest_data_new
GROUP BY    
    Crime_Type
ORDER BY
    Crime_Count DESC
LIMIT 10
