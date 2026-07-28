-- Q8: Seasonal patterns across the 3 years
-- Groups by calendar month number (Jan=1...Dec=12) across all years,


SELECT
    EXTRACT(MONTH FROM load_date) AS month_number,
    EXTRACT(YEAR FROM load_date) AS year,
    COUNT(*) AS load_count,
    SUM(revenue) AS total_revenue
FROM loads
GROUP BY month_number, year
ORDER BY month_number, year;