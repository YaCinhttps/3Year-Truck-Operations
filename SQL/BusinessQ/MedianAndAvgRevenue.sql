-- Q7: Basket size distribution (median, quartiles, outliers)
SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) AS q1,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY revenue) AS median,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) AS q3,
    MIN(revenue) AS min_revenue,
    MAX(revenue) AS max_revenue,
    ROUND(AVG(revenue), 2) AS avg_revenue
FROM loads;