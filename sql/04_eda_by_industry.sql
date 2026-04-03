-- Total layoffs by industry
SELECT industry,
       SUM(total_laid_off) AS total_laid_off,
       AVG(percentage_laid_off) AS avg_percentage
FROM layoffs_clean
GROUP BY industry
ORDER BY total_laid_off DESC;