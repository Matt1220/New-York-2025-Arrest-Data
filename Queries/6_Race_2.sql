-- This query shows which crime is most prominant amongst each race 



WITH race_crime_type AS (
    SELECT 

    perp_race as race,
    pd_desc as crime_type,
    COUNT(arrest_key) AS Total_Count

    FROM nypd_arrest_data_new

    GROUP BY 
    perp_race, pd_desc
    ORDER BY 
    Total_Count DESC
), 

Race_Crime_Type_Sorted AS (
    SELECT 
        total_count,
        race,
        crime_type,
        ROW_NUMBER () OVER (PARTITION BY race ORDER BY total_count DESC) AS Grouped_Crimes

    FROM race_crime_type
)

Select 
    race,
    crime_type,
    total_count
FROM Race_Crime_Type_Sorted
WHERE Grouped_Crimes = 1 
ORDER BY 
    total_count DESC
