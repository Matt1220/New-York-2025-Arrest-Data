--This query returns data about how many crimes are done by each sex in a particular age range


SELECT
    COUNT(arrest_key) AS Crime_Total,
    AGE_GROUP AS Age,
    PERP_SEX AS Sex 
FROM nypd_arrest_data_new
WHERE 
    AGE_GROUP IS NOT NULL AND PERP_SEX IS NOT NULL
GROUP BY 
    Age, Sex
ORDER BY 
    Crime_Total DESC