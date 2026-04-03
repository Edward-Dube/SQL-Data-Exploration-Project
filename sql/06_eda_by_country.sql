SELECT country,
       SUM(total_laid_off) AS total_laid_off,
       AVG(percentage_laid_off) AS avg_percentage
FROM layoffs_clean
GROUP BY country
ORDER BY total_laid_off DESC;