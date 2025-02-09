-- Exploratory Data Analysis

SELECT *
FROM covid_data_staging;

SELECT MAX(`Total Deaths`)
FROM covid_data_staging;

SELECT *
FROM covid_data_staging
WHERE `Total Deaths` = 1132935;

SELECT MAX(`Total Deaths`), MAX(`Active Cases`)
FROM covid_data_staging;

SELECT Country, SUM(`Total Deaths`)
FROM covid_data_staging
GROUP BY Country
ORDER BY 2 DESC;

SELECT Country, (`Total Recovered` / `Total Cases`) AS percentage_recovered
FROM covid_data_staging;

ALTER TABLE covid_data_staging
ADD COLUMN percentage_recovered DOUBLE AS (`Total Recovered` / `Total Cases`);

SELECT Country, (`Total Deaths` / `Total Cases`) AS percentage_death
FROM covid_data_staging;

ALTER TABLE covid_data_staging
ADD COLUMN percentage_died DOUBLE AS (`Total Deaths` / `Total Cases`);

SELECT *, dense_rank()
OVER (order by percentage_died) AS `dense_rank`
FROM covid_data_staging
WHERE percentage_died IS NOT NULL; 