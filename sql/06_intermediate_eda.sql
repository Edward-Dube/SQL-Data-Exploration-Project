-- =========================================
-- Percentage of layoffs by industry
-- =========================================
SELECT 
    industry,
    SUM(total_laid_off) AS total_laid_off,
    ROUND(100.0 * SUM(total_laid_off) / (SELECT SUM(total_laid_off) FROM layoffs_clean), 2) AS pct_of_total
FROM layoffs_clean
GROUP BY industry
ORDER BY total_laid_off DESC;

-- =========================================
-- Top 10% Companies by Layoffs (Window Function)
-- =========================================
WITH ranked AS (
    SELECT 
        company,
        total_laid_off,
        PERCENT_RANK() OVER (ORDER BY total_laid_off DESC) AS pct_rank
    FROM layoffs_clean
    WHERE total_laid_off IS NOT NULL
)
SELECT company, total_laid_off, pct_rank
FROM ranked
WHERE pct_rank >= 0.9
ORDER BY total_laid_off DESC;

-- =========================================
-- Average layoffs per company stage
-- =========================================
SELECT 
    stage,
    AVG(total_laid_off) AS avg_laid_off,
    COUNT(*) AS num_companies
FROM layoffs_clean
GROUP BY stage
ORDER BY avg_laid_off DESC;

-- =========================================
-- Layoffs by country with percentage
-- =========================================
SELECT 
    country,
    SUM(total_laid_off) AS total_laid_off,
    ROUND(100.0 * SUM(total_laid_off) / (SELECT SUM(total_laid_off) FROM layoffs_clean), 2) AS pct_of_total
FROM layoffs_clean
GROUP BY country
ORDER BY total_laid_off DESC;

-- =========================================
-- Top Industries by Average Layoffs per Company
-- Shows which industries have the largest layoffs on average per company
-- =========================================
SELECT 
    industry,
    AVG(total_laid_off) AS avg_laid_off,
    COUNT(*) AS num_companies
FROM layoffs_clean
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY avg_laid_off DESC
LIMIT 5;

-- =========================================
-- Cumulative Layoffs by Industry
-- Shows running total of layoffs by industry (highest to lowest)
-- =========================================
SELECT 
    industry,
    SUM(total_laid_off) AS total_laid_off,
    SUM(SUM(total_laid_off)) OVER (ORDER BY SUM(total_laid_off) DESC) AS cumulative_laid_off
FROM layoffs_clean
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY total_laid_off DESC;

-- =========================================
-- Average layoffs by stage and country
-- Shows which combination of stage & country had the highest average layoffs
-- =========================================
SELECT 
    country,
    stage,
    AVG(total_laid_off) AS avg_laid_off,
    COUNT(*) AS num_companies
FROM layoffs_clean
WHERE total_laid_off IS NOT NULL
GROUP BY country, stage
ORDER BY avg_laid_off DESC
LIMIT 10;

-- =========================================
-- Companies above 75th percentile in layoffs
-- Shows high-impact companies
-- =========================================
WITH ranked AS (
    SELECT 
        company,
        total_laid_off,
        PERCENT_RANK() OVER (ORDER BY total_laid_off DESC) AS pct_rank
    FROM layoffs_clean
    WHERE total_laid_off IS NOT NULL
)
SELECT company, total_laid_off, pct_rank
FROM ranked
WHERE pct_rank >= 0.75
ORDER BY total_laid_off DESC;