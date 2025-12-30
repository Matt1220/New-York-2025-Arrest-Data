-- This Query find which race is involved in the most amount of arrest


SELECT 
    COUNT(arrest_key) AS Crime_Total,
    PERP_Race AS Race
FROM nypd_arrest_data_new
WHERE
    perp_race IS NOT NULL AND UPPER(PERP_RACE) <> 'UNKNOWN'
GROUP BY 
    Race
ORDER BY 
    Crime_Total DESC


