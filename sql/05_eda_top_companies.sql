-- Companies with the largest layoffs
SELECT company, total_laid_off, percentage_laid_off
FROM layoffs_clean
WHERE total_laid_off IS NOT NULL
ORDER BY total_laid_off DESC
LIMIT 10;