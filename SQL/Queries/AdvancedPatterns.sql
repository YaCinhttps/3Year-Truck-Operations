WITH customer_rfm AS (
    SELECT
        customer_id,
        CURRENT_DATE - MAX(load_date) AS recency_days,
        COUNT(*) AS frequency,
        SUM(revenue) AS monetary
    FROM loads
    GROUP BY customer_id
),
scored AS (
    SELECT
        customer_id,
        recency_days,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,   -- lower recency = better = higher score
        NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary DESC) AS m_score
    FROM customer_rfm
)
SELECT
    *,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'Recent'
        WHEN r_score <= 2 AND f_score >= 4 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
        ELSE 'Loyal'
    END AS segment
FROM scored
ORDER BY monetary DESC;




WITH driver_quarterly AS (
    SELECT
        t.driver_id,
        DATE_TRUNC('quarter', de.scheduled_datetime) AS quarter,
        ROUND(AVG(CASE WHEN de.on_time_flag THEN 1.0 ELSE 0 END) * 100, 2) AS on_time_rate
    FROM delivery_events de
    JOIN trips t ON t.trip_id = de.trip_id
    WHERE t.driver_id IS NOT NULL
    GROUP BY t.driver_id, quarter
),
with_prev AS (
    SELECT
        driver_id,
        quarter,
        on_time_rate,
        LAG(on_time_rate) OVER (PARTITION BY driver_id ORDER BY quarter) AS prev_quarter_rate
    FROM driver_quarterly
)
SELECT
    driver_id,
    quarter,
    prev_quarter_rate,
    on_time_rate,
    ROUND(on_time_rate - prev_quarter_rate, 2) AS point_change
FROM with_prev
WHERE prev_quarter_rate - on_time_rate > 10
ORDER BY point_change ASC;




WITH driver_cohort AS (
    SELECT
        driver_id,
        DATE_TRUNC('quarter', hire_date) AS cohort_quarter
    FROM drivers
),
driver_monthly_revenue AS (
    SELECT
        t.driver_id,
        DATE_TRUNC('month', t.dispatch_date) AS activity_month,
        SUM(l.revenue) AS monthly_revenue
    FROM trips t
    JOIN loads l ON l.load_id = t.load_id
    GROUP BY t.driver_id, activity_month
),
tenure AS (
    SELECT
        dmr.driver_id,
        dc.cohort_quarter,
        dmr.monthly_revenue,
        (EXTRACT(YEAR FROM dmr.activity_month) - EXTRACT(YEAR FROM dc.cohort_quarter)) * 12
          + (EXTRACT(MONTH FROM dmr.activity_month) - EXTRACT(MONTH FROM dc.cohort_quarter)) AS month_offset
    FROM driver_monthly_revenue dmr
    JOIN driver_cohort dc ON dc.driver_id = dmr.driver_id
)
SELECT
    cohort_quarter,
    month_offset,
    ROUND(AVG(monthly_revenue), 2) AS avg_revenue,
    COUNT(DISTINCT driver_id) AS drivers_in_cohort
FROM tenure
WHERE month_offset BETWEEN 0 AND 5
GROUP BY cohort_quarter, month_offset
ORDER BY cohort_quarter, month_offset;




WITH truck_fuel_stats AS (
    SELECT
        trip_id,
        truck_id,
        fuel_gallons_used,
        AVG(fuel_gallons_used) OVER (PARTITION BY truck_id) AS truck_avg,
        STDDEV(fuel_gallons_used) OVER (PARTITION BY truck_id) AS truck_stddev
    FROM trips
)
SELECT
    trip_id,
    truck_id,
    fuel_gallons_used,
    ROUND(truck_avg, 2) AS truck_avg,
    ROUND(truck_stddev, 2) AS truck_stddev
FROM truck_fuel_stats
WHERE ABS(fuel_gallons_used - truck_avg) > 2 * truck_stddev
ORDER BY truck_id;




WITH truck_purchase_dates AS (
    SELECT DISTINCT truck_id, purchase_date::date AS purchase_date
    FROM fuel_purchases
),
with_gaps AS (
    SELECT
        truck_id,
        purchase_date,
        LAG(purchase_date) OVER (PARTITION BY truck_id ORDER BY purchase_date) AS prev_purchase_date,
        purchase_date - LAG(purchase_date) OVER (PARTITION BY truck_id ORDER BY purchase_date) AS gap_days
    FROM truck_purchase_dates
)
SELECT
    truck_id,
    prev_purchase_date AS gap_start,
    purchase_date AS gap_end,
    gap_days
FROM with_gaps
WHERE gap_days > 7   -- adjust threshold for what counts as "meaningful" downtime
ORDER BY gap_days DESC;





SELECT
    r.destination_state AS market,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 1) AS jan,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 2) AS feb,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 3) AS mar,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 4) AS apr,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 5) AS may,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 6) AS jun,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 7) AS jul,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 8) AS aug,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 9) AS sep,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 10) AS oct,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 11) AS nov,
    SUM(l.revenue) FILTER (WHERE EXTRACT(MONTH FROM l.load_date) = 12) AS dec
FROM loads l
JOIN routes r ON r.route_id = l.route_id
WHERE EXTRACT(YEAR FROM l.load_date) = 2023
GROUP BY r.destination_state
ORDER BY r.destination_state;