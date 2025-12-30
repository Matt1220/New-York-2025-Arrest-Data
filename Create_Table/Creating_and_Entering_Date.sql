
CREATE TABLE nypd_arrest_data_new (
    ARREST_KEY BIGINT PRIMARY KEY,
    ARREST_DATE DATE,
    PD_CD INT,
    PD_DESC VARCHAR(255),
    KY_CD INT,
    OFNS_DESC VARCHAR(255),
    LAW_CODE VARCHAR(50),
    LAW_CAT_CD VARCHAR(10),
    ARREST_BORO VARCHAR(10),
    ARREST_PRECINCT INT,
    JURISDICTION_CODE INT,
    AGE_GROUP VARCHAR(20),
    PERP_SEX VARCHAR(10),
    PERP_RACE VARCHAR(50),
    X_COORD_CD INT,
    Y_COORD_CD INT,
    Latitude TEXT,
    Longitude TEXT,
    Location TEXT-- PostGIS geometry type
);



COPY nypd_arrest_data_new
FROM 'C:\Users\bosto\Downloads\NYPD_Arrest_Data__Year_to_Date_.csv'
DELIMITER ',' CSV HEADER


