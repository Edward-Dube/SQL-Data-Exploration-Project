-- =====================================================
-- Cleaning and transforming raw data
-- =====================================================

-- Create a cleaned table from raw data
CREATE TABLE IF NOT EXISTS layoffs_clean AS
SELECT
    TRIM(company) AS company,
    TRIM(location) AS location,
    TRIM(industry) AS industry,
    CASE WHEN total_laid_off = '' THEN NULL ELSE CAST(total_laid_off AS REAL) END AS total_laid_off,
    CASE WHEN percentage_laid_off = '' THEN NULL ELSE CAST(percentage_laid_off AS REAL) END AS percentage_laid_off,
    date,
    TRIM(stage) AS stage,
    TRIM(country) AS country,
    CASE WHEN funds_raised = '' THEN NULL ELSE CAST(funds_raised AS REAL) END AS funds_raised
FROM layoffs_raw;

-- Optional: remove duplicates
CREATE TABLE IF NOT EXISTS layoffs_clean_dedup AS
SELECT DISTINCT *
FROM layoffs_clean;

-- Replace the clean table with deduped version
DROP TABLE IF EXISTS layoffs_clean;
ALTER TABLE layoffs_clean_dedup RENAME TO layoffs_clean;