SELECT
    r.destination_state AS market,   -- [ASSUMED] no confirmed "market" column; using destination_state as proxy
    COUNT(l.load_id) AS load_count,
    SUM(l.revenue) AS total_revenue,
    ROUND(SUM(l.revenue) * 100.0 / SUM(SUM(l.revenue)) OVER (), 2) AS pct_of_total
FROM loads l
JOIN routes r ON r.route_id = l.route_id
GROUP BY r.destination_state
ORDER BY total_revenue DESC;



