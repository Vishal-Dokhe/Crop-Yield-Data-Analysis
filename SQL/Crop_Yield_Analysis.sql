CREATE DATABASE crop_yield_db;
CREATE TABLE crop_yield_cleaned (
    Crop VARCHAR(50),
    Crop_Year INT,
    Season VARCHAR(20),
    State VARCHAR(50),
    Area FLOAT,
    Production FLOAT,
    Annual_Rainfall FLOAT,
    Fertilizer FLOAT,
    Pesticide FLOAT,
    Yield FLOAT
);

USE crop_yield_db;

SELECT COUNT(*) FROM crop_yield_cleaned;

SELECT * 
FROM crop_yield_cleaned
LIMIT 10;

DESCRIBE crop_yield_cleaned;

SELECT SUM(production) AS total_production
FROM crop_yield_cleaned;

SELECT ROUND(AVG(yield), 2) AS avg_yield
FROM crop_yield_cleaned;

SELECT SUM(area) AS total_area
FROM crop_yield_cleaned;

SELECT crop, SUM(production) AS total_production
FROM crop_yield_cleaned
GROUP BY crop
ORDER BY total_production DESC
LIMIT 5;

SELECT state,
       ROUND(AVG(yield), 2) AS avg_yield
FROM crop_yield_cleaned
GROUP BY state
ORDER BY avg_yield DESC;

SELECT season,
       ROUND(AVG(yield), 2) AS avg_yield
FROM crop_yield_cleaned
GROUP BY season
ORDER BY avg_yield DESC;

SELECT crop,
       ROUND(SUM(production) / SUM(area), 2) AS production_per_area
FROM crop_yield_cleaned
GROUP BY crop
ORDER BY production_per_area DESC
LIMIT 5;

CREATE OR REPLACE VIEW kpi_summary AS
SELECT 
    SUM(production) AS total_production,
    ROUND(AVG(yield), 2) AS avg_yield,
    SUM(area) AS total_area
FROM crop_yield_cleaned;

SELECT COUNT(DISTINCT crop) AS total_crops
FROM crop_yield_cleaned;

SELECT DISTINCT season
FROM crop_yield_cleaned;

SELECT season, SUM(production) AS total_production
FROM crop_yield_cleaned
GROUP BY season;

SELECT crop_year, SUM(production) AS total_production
FROM crop_yield_cleaned
GROUP BY crop_year
ORDER BY crop_year;

SELECT season, ROUND(AVG(annual_rainfall), 2) AS avg_rainfall
FROM crop_yield_cleaned
GROUP BY season;

SELECT crop, ROUND(AVG(fertilizer), 2) AS avg_fertilizer
FROM crop_yield_cleaned
GROUP BY crop
ORDER BY avg_fertilizer DESC;

SELECT crop, ROUND(AVG(pesticide), 2) AS avg_pesticide
FROM crop_yield_cleaned
GROUP BY crop
ORDER BY avg_pesticide DESC;

SELECT season, ROUND(AVG(yield), 2) AS avg_yield
FROM crop_yield_cleaned
GROUP BY season
ORDER BY avg_yield DESC;

SELECT crop,
       ROUND(SUM(production) / SUM(area), 2) AS production_per_area
FROM crop_yield_cleaned
GROUP BY crop
ORDER BY production_per_area DESC
LIMIT 5;


SELECT state, crop, MAX(total_prod) AS max_production
FROM (
    SELECT state, crop, SUM(production) AS total_prod
    FROM crop_yield_cleaned
    GROUP BY state, crop
) t
GROUP BY state;

SELECT *
FROM crop_yield_cleaned
WHERE yield > (SELECT AVG(yield) FROM crop_yield_cleaned);

SELECT 
    CASE 
        WHEN annual_rainfall < 500 THEN 'Low'
        WHEN annual_rainfall BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'High'
    END AS rainfall_level,
    ROUND(AVG(yield), 2) AS avg_yield
FROM crop_yield_cleaned
GROUP BY rainfall_level;

SELECT crop_year,
       SUM(production) -
       LAG(SUM(production)) OVER (ORDER BY crop_year) AS yoy_change
FROM crop_yield_cleaned
GROUP BY crop_year;

SELECT crop, ROUND(STDDEV(yield), 2) AS yield_variation
FROM crop_yield_cleaned
GROUP BY crop
ORDER BY yield_variation;


SELECT crop, ROUND(STDDEV(yield), 2) AS yield_variation
FROM crop_yield_cleaned
GROUP BY crop
ORDER BY yield_variation;













