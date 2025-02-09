SELECT *
FROM covid_data;

-- Remove Duplicates
-- Standardize the Data
-- Null Values and Blanks
-- Remove any columns

-- Remove Duplicates
CREATE TABLE covid_data_staging
LIKE covid_data;

SELECT *
FROM covid_data_staging;

INSERT covid_data_staging
SELECT *
FROM covid_data;

SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY Country) AS row_num
FROM covid_data_staging;

WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY Country) AS row_num
FROM covid_data_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Standardizing Data
SELECT *
FROM covid_data_staging
WHERE Country = 'Reunion';

UPDATE covid_data_staging
SET Country = 'Reunion'
WHERE Country = 'RÃ©union';

SELECT *
FROM covid_data_staging
WHERE Country = 'Curaçao';

UPDATE covid_data_staging
SET Country = 'Curaçao'
WHERE Country = 'CuraÃ§ao';

SELECT *
FROM covid_data_staging;

-- Null and Blank Values

SELECT * 
FROM covid_data_staging
WHERE `Total Deaths` = 0;

UPDATE covid_data_staging
SET `Total Deaths` = NULL
WHERE `Total Deaths` = 0;

SELECT * 
FROM covid_data_staging
WHERE `Total Deaths` IS NULL;

SELECT * 
FROM covid_data_staging
WHERE `Total Recovered` = 0;

UPDATE covid_data_staging
SET `Total Recovered` = NULL
WHERE `Total Recovered` = 0;

SELECT * 
FROM covid_data_staging
WHERE `Total Recovered` IS NULL;

SELECT * 
FROM covid_data_staging
WHERE `Active Cases` = 0;

UPDATE covid_data_staging
SET `Active Cases` = NULL
WHERE `Active Cases` = 0;

SELECT * 
FROM covid_data_staging
WHERE `Active Cases` IS NULL;

SELECT * 
FROM covid_data_staging
WHERE `Total Test` = 0;

UPDATE covid_data_staging
SET `Total Test` = NULL
WHERE `Total Test` = 0;

SELECT * 
FROM covid_data_staging
WHERE `Total Test` IS NULL;

SELECT * 
FROM covid_data_staging
WHERE `Population` = 0;

UPDATE covid_data_staging
SET `Population` = NULL
WHERE `Population` = 0;

SELECT * 
FROM covid_data_staging
WHERE `Population` IS NULL;

SELECT *
FROM covid_data_staging;

-- Remove Columns
SELECT *
FROM covid_data_staging;

ALTER TABLE covid_data_staging
DROP COLUMN `Serial Number`;

SELECT *
FROM covid_data_staging;