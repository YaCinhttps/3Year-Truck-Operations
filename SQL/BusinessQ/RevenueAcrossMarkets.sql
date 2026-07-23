
-- Q1 
SELECT
    r.destination_state AS market,   
    COUNT(l.load_id) AS load_count,
    SUM(l.revenue) AS total_revenue,
    ROUND(SUM(l.revenue) * 100.0 / SUM(SUM(l.revenue)) OVER (), 2) AS pct_of_total
FROM loads l
JOIN routes r ON r.route_id = l.route_id
GROUP BY r.destination_state
ORDER BY total_revenue DESC;

-- Follow-up to Q1: is the OR vs WA revenue/load gap driven by
-- longer routes, higher per-mile rates, or both?
SELECT
    r.destination_state AS market,
    COUNT(DISTINCT r.route_id) AS route_count,
    ROUND(AVG(r.base_rate_per_mile), 3) AS avg_base_rate_per_mile,
    ROUND(AVG(r.typical_distance_miles), 1) AS avg_typical_distance_miles,
    ROUND(AVG(t.actual_distance_miles), 1) AS avg_actual_distance_miles,
    ROUND(SUM(l.revenue) / NULLIF(SUM(t.actual_distance_miles), 0), 2) AS actual_revenue_per_mile
FROM routes r
JOIN loads l ON l.route_id = r.route_id
JOIN trips t ON t.load_id = l.load_id
GROUP BY r.destination_state
ORDER BY actual_revenue_per_mile DESC;