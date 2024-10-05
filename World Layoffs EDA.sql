-- Exploratory Data Analysis

SELECT *
FROM layoff_staging2;

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoff_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT *
FROM layoff_staging2;

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT stage, SUM(total_laid_off)
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT company, avg(percentage_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT substring(`date`, 1, 7) AS `MONTH`, sum(total_laid_off)
FROM layoff_staging2
WHERE substring(`date`, 1, 7) is not null
group by `MONTH`
order by 1 asc;

WITH Rolling_Total AS
(
SELECT substring(`date`, 1, 7) AS `MONTH`, sum(total_laid_off) AS total_off
FROM layoff_staging2
WHERE substring(`date`, 1, 7) is not null
group by `MONTH`
order by 1 asc
)
select `MONTH`, total_off,
SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;


SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company asc;

WITH Company_Year(company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years is not NULL
)
SELECT *
FROM COMPANY_YEAR_RANK
where Ranking <= 5;


