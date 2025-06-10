SELECT *
FROM yahoo_finance_data_staging;

SELECT *
FROM yahoo_finance_data_staging
WHERE YEAR(`Date`) = 2023 and MONTH(`Date`) = 04;

-- To figure out the average number of shares that were shared during the year 2020 is below
SELECT MONTH(`Date`), AVG(`Volume`)
FROM yahoo_finance_data_staging
WHERE YEAR(`Date`) = 2020
GROUP BY MONTH(`Date`);
-- in general, after the pandemic started in 2020 the average trades being made had decreased since march when the pandemic started. 

-- Search for the most and least amount closed per year. 
SELECT YEAR(`Date`), MIN(`Close*`), MAX(`Close*`)
FROM yahoo_finance_data_staging
GROUP BY YEAR(`Date`);
-- 2020 was the year that had the lowest closing price (this was the COVID year). and it looks like 2022 was the year was the highest closing price
-- I think that this was about the point where most people had their vaccines and they were more comfortable with leaving their houses. 

-- It may be interesting to look at the average closing prices per year. 
SELECT YEAR(`Date`), AVG(`Close*`)
FROM yahoo_finance_data_staging
GROUP BY YEAR(`Date`)
ORDER BY YEAR(`Date`);
-- Looking at this it is visible that the average closing price of stocks had decreased. 

-- Calculate total volume of trade across the entire dataset. 
SELECT SUM(`Volume`)
FROM yahoo_finance_data_staging;

-- Analyze monthly trading volume trends to identify seasonal patterns
SELECT YEAR(`Date`), MONTH(`Date`), SUM(`Volume`)
FROM yahoo_finance_data_staging
GROUP BY YEAR(`Date`), MONTH(`Date`)
ORDER BY YEAR(`Date`), MONTH(`Date`);
-- the data is evidently showing that as the year starts the volume traded increases until march where it tends to decrease until the beginning of the year. 

-- Seeing if there are patterns with price around specific times of the year/history (ie. COVID)
SELECT *
FROM yahoo_finance_data_staging
WHERE `Date` BETWEEN '2020-02-15' AND '2020-04-15';

-- Filtering for the TOP 5 highest trading days. 
SELECT `Date`, `Volume`
FROM yahoo_finance_data_staging
ORDER BY `Volume` DESC
LIMIT 5;
