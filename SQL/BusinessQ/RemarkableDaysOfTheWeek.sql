SELECT
    TO_CHAR(load_date, 'Day') AS weekday,
    EXTRACT(ISODOW FROM load_date) AS weekday_num,
    COUNT(*) AS load_count,
    SUM(revenue) AS total_revenue,
    ROUND(AVG(revenue), 2) AS avg_revenue_per_load
FROM loads
GROUP BY weekday, weekday_num
ORDER BY weekday_num;