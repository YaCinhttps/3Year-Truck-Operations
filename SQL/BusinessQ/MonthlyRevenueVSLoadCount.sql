-- Q5: Monthly load volume trend over 3 years
-- name: 05_monthly_load_trend
SELECT
    DATE_TRUNC('month', load_date) AS month,
    COUNT(*) AS load_count,
    SUM(revenue) AS total_revenue
FROM loads
GROUP BY MONTH
ORDER BY month;


 WITH monthly AS (
    SELECT
        DATE_TRUNC('month', load_date) AS month,
        COUNT(*) AS load_count,
        SUM(revenue) AS total_revenue
    FROM loads
    GROUP BY month
)
SELECT
    month,
    load_count,
    total_revenue,
    EXTRACT(DAY FROM (month + INTERVAL '1 month' - INTERVAL '1 day'))::INT AS days_in_month,
    ROUND(load_count / EXTRACT(DAY FROM (month + INTERVAL '1 month' - INTERVAL '1 day')), 2) AS loads_per_day,
    ROUND(total_revenue / EXTRACT(DAY FROM (month + INTERVAL '1 month' - INTERVAL '1 day')), 2) AS revenue_per_day
FROM monthly
ORDER BY month;