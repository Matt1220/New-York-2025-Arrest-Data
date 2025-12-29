/*This query returns the location of 5000 with the condition that the arrest 
   has a reported latitude, longitude, and borough. This result will return 5000
   random rows */

SELECT

COUNT(arrest_boro) AS Count_Total,
CASE 
    WHEN arrest_boro = 'B' THEN 'Bronx'
    WHEN arrest_boro = 'K' THEN 'Brooklyn'
    WHEN arrest_boro = 'M' THEN 'Manhattan'
    WHEN arrest_boro = 'Q' THEN 'Queens'
    WHEN arrest_boro = 'S' THEN 'Staten Island'
    ELSE NULL
END AS Borough_Full

FROM 
    nypd_arrest_data_new
GROUP BY 
    Borough_Full
ORDER BY 
    RANDOM()


