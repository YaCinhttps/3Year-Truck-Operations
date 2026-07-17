

SELECT
    t.driver_id,
    tr.make,
    SUM(l.revenue) AS total_revenue
FROM trips t
JOIN loads l ON t.load_id = l.load_id
JOIN trucks tr ON t.truck_id = tr.truck_id
GROUP BY t.driver_id, tr.make


WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', load_date) AS month,
        SUM(revenue) AS revenue
    FROM loads
    GROUP BY month
)
SELECT
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS running_total
FROM monthly_revenue
ORDER BY month;





WITH monthly_loads AS (
    SELECT
        DATE_TRUNC('month', load_date) AS month,
        COUNT(*) AS load_count
    FROM loads
    GROUP BY month
)
SELECT
    month,
    load_count,
    LAG(load_count) OVER (ORDER BY month) AS prev_month_count,
    ROUND(
        (load_count - LAG(load_count) OVER (ORDER BY month))::NUMERIC
        / LAG(load_count) OVER (ORDER BY month) * 100, 2
    ) AS pct_change
FROM monthly_loads
ORDER BY month;



SELECT
    customer_id,
    MIN(load_date) AS first_load_date,
    MAX(load_date) AS most_recent_load_date,
    MAX(load_date) - MIN(load_date) AS customer_lifespan_days
FROM loads
GROUP BY customer_id
ORDER BY customer_lifespan_days DESC;

