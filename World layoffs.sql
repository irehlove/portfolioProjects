SELECT *
FROM layoffs;

-- 1. remove duplicates
-- 2. standardize data
-- 3. null values or blank values
-- 4. remove any columns

CREATE TABLE layoff_staging
Like layoffs;

SELECT *
FROM layoff_staging;

INSERT layoff_staging
SELECT *
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, industry, total_laid_off, `date`) AS row_num
FROM layoff_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, industry, total_laid_off, `date`) AS row_num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;


CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL, 
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoff_staging;

SELECT *
FROM layoff_staging2;

INSERT INTO layoff_staging2
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company, industry, total_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_staging;

DELETE
FROM layoff_staging2
WHERE row_num > 1;

SELECT *
FROM layoff_staging2
WHERE row_num > 1;

SELECT *
FROM layoff_staging2;


-- standardizing data

SELECT company, TRIM(company)
FROM layoff_staging2;

UPDATE layoff_staging2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoff_staging2
ORDER BY 1;

SELECT *
FROM layoff_staging2;


UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoff_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
ORDER BY 1;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT *
FROM layoff_staging2;


SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoff_staging2;

UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoff_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoff_staging2;

-- Removing null values

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoff_staging2
WHERE industry IS NULL
OR industry  = '';

SELECT *
FROM layoff_staging2
WHERE company LIKE 'Bally%';

SELECT t1.industry, t2.industry
FROM layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
	on t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT *
FROM layoff_staging2;


-- removing columns
SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoff_staging2;

ALTER TABLE layoff_staging2
DROP COLUMN row_num;