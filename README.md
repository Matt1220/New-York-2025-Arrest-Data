# Introduction
- Focusing on crime data from NYC for the first half of 2025 (January - September), this project seeks to uncover patterns revolving around the 150,000+ arrest that have occurred so far this year. Differences in gender, sex, and age when it comes to official police arrest are just some of the areas of interest for this study.  

** SQL Queries Utilized - Check Out Here: [Queries Folder](/Queries/)


# Background
- Driven by my interest in Crime Analytics, I decided to engage in this project to understand the true nature of arrest made by police in NYC.

- I decided on NYC because I was always interested in living there as a kid. On the news I saw stories about how crime was unfolding in this beautiful city and I wanted to get a deeper understanding into who was involved, and where was it mostly occurring. 

- In my quest, I answered a few vital questions that could help me understand.

1. How have arrest trended over the last few months?
2. Which borough was the hotspot for official police arrest?
3. Which offense type was most prominent within these arrest?
4. How did age and sex differ within these reports?
5. How did race differ within these reports?
6. Which offense was most prominent among each race?


# Tools I Used
For this project, I utilized different tools to gather data, hold the data in a database, query it to gather insights, and visualize it.

- **SQL** - This was used in order to gather the data to answer the questions listed above
- **Excel** - Excel was utilized to create a dashboard with visualizations in order to better understand my findings. I used Excel Power Query, pivot tables, and pivot charts to do this.
- **PostgreSQL** - This was the database management tool that I chose to use to hold all the data.
-  **Git and GitHub** - This was used to help share my SQL queries, and keep track of my project's progress.
- **"NYC.gov"** - Was the website where I obtained the arrest data.


# The Analysis
Each query for this project targeted a specific question about certain aspects of arrest made in NYC for the first half of 2025.

### 1. Arrest Trends Through Each Month
In order to see how the count of arrest varied from January to September, I extracted the month from each arrest, and from there used a case statement to turn the month number into the name. I also used a COUNT to find how many occurrences of each month happened within the dataset. After, I grouped by month name to find how many arrest occurred for each month.

```sql

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

```

### 2. Arrest Count By Each Borough 
To see a total arrest count for each of the five NYC boroughs, I first select a count of the boroughs. Then, I changed each borough from the initialized letter to the actual name in order to make it easier to read. Then, I grouped by the borough name to find how many arrest were counted for in each of the five boroughs.

```sql

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

```

### 3. Prominence of Offesnse Type  
This query was created in order to see which were the top 10 most popular crime types. To do this, I simply selected each crime type, and counted how many rows were associated with each one. Then, I ordered them in descending order to see the most popular one at the top, and finally limited the output to ten to see the top 10 crime types with the most arrest associated with them. 

```sql

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

```

### 4. Age and Sex 
With this, I wanted to see total arrest count for both age and sex. I first selected a COUNT of the arrest and grouped that count by both age and sex. Then I outputted them in descending order to see which groups are involved in the most amount of arrest. I also included a WHERE statement to exclude any arrest where the age group or sex was 'UNKNOWN'.

```sql

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

```

### Race 
This query seeked to see which race was responsible for the most amount of arrest within this data set by selecting a COUNT of each arrest and grouping them based on each race. I included a WHERE statement to not include cases where the race was 'UNKNOWN'

```sql

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

```

### Race_2
The was used to understand which crime type was most associated with each race. This was found using a CTE that pulls a COUNT of crime and groups that count based on the crime type and the race. Then, another CTE takes the output from the previous table and uses the ROW_NUMBER window function to partition by each race, and then order them in descending order. Finally, we take this output and select only the rows where the ROW_NUMBER = 1. This only returns the rows race, and crime type that have the highest count.

```sql

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

```
# What I learned

### Query Crafting
- I learned how to utilize basic and intermediate SQL commands to gather insights and pull information from large data sets. Aggregations, CASE Statements, GROUP BYs, ORDER BYs, LIMITs, etc.
### Visualization Creation
- I learned how to use Excel power query and pivot tables in order to input csv files and create pivot charts to use visualizations to better understand our information.
### Database Setup
- I learned how to create and initialized databases in order to store and organize information.

# Conclusions

### Insights

**1. Arrest Trends Through Each Month**

From January to September, the arrest count was pretty consistent for each month with a slight decrease in February, followed by an increase in March, and then another decrease in June. The total count for each month stayed around the 22,000 - 25,000 range.

**2. Arrest Count by Each Borough**

The total crime count for each borough showed that Brooklyn has a noticeable increase in arrest rate compared to the others. On top of that, Staten Island contributed to the least amount of arrest by a wide margin. Between Staten Island and Brooklyn, there is a difference of around 51,000 arrest. As the visualization shows, Brooklyn is marked with a red Hot Spot in the middle to indicate its high count in arrest, while Staten Island has no marking at all, indicating its very low count in arrest.

**3. Prominence of Offense Type**

Third degree Assault has the highest total count of arrest with around 24,000. Following that is Petit Larceny, Theft, Second degree Assault, Traffic Misdemeanor, Possession of a controlled Substance, Public Administration, Robbery in Open Areas, Grand Larceny, and Menacing. 

**4. Age and Sex**

Males are substantially more involved in arrest then women for every age group. The age group that is most involved with criminal activity is 25-44. Age seemed to have a "bell curve" like characteristic to it as arrest would increase as the individual got older. However, after 44 years old, arrest would consistently decrease as the individual aged.

**5. Race**

Of the total arrest, the Black population made up a majority of them, around 48%. After that, was the White Hispanic population, followed by White, Black Hispanic, Asian/Pacific Islander, and finally, American Indian/Alaskan Native.

**6. Race_2**

It is clear from this data that Third Degree Assault seems to be a very prominent crime type as it is the highest among multiple races including Black, White Hispanic, Black Hispanic, Asian/Pacific Islander, and American Indian/Alaskan Native. The only race where Third Degree Assault was not the most popular crime, was for the White population whose most prominent crime that led to an arrest was Petit Larceny.


### Final Thoughts

Engaging in this project allowed me to learn a ton about different software programs and tools used by analyst. I now know how to use SQL on an intermediate level, and I understand the interworkings of powerful Excel tools like Power Query. This project also gave me great insights into how data is manipulated in order to answer any question imaginable. For most companies now, data is their most vital asset, and this project allowed me to understand why. Making informed business decisions and predictions becomes much easier when you have the information needed to help guide those decisions. 
