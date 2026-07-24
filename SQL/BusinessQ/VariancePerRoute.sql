WITH route_actuals AS (
    SELECT
        r.route_id,
        r.origin_city,
        r.destination_city,
        r.base_rate_per_mile,
        r.fuel_surcharge_rate,
        SUM(l.revenue) AS total_revenue,
        SUM(t.actual_distance_miles) AS total_actual_miles
    FROM routes r
    JOIN loads l ON l.route_id = r.route_id
    JOIN trips t ON t.load_id = l.load_id
    GROUP BY r.route_id, r.origin_city, r.destination_city,
             r.base_rate_per_mile, r.fuel_surcharge_rate
)
SELECT
    route_id,
    origin_city,
    destination_city,
    base_rate_per_mile,
    fuel_surcharge_rate,
    ROUND(total_revenue / NULLIF(total_actual_miles, 0), 2) AS actual_revenue_per_mile,
    ROUND((total_revenue / NULLIF(total_actual_miles, 0)) - base_rate_per_mile, 2) AS variance_per_mile,
    ROUND(
        (((total_revenue / NULLIF(total_actual_miles, 0)) - base_rate_per_mile)
        / NULLIF(base_rate_per_mile, 0)) * 100, 2
    ) AS variance_pct,
    ROUND(fuel_surcharge_rate * 100, 2) AS fuel_surcharge_pct
FROM route_actuals
ORDER BY variance_pct;