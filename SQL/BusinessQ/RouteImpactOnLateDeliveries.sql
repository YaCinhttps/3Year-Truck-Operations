-- Q15: Trip volume by route vs on-time performance
-- name: 15_route_volume_vs_on_time
SELECT
    l.route_id,
    COUNT(DISTINCT t.trip_id) AS trip_volume,
    ROUND(AVG(CASE WHEN de.on_time_flag THEN 1.0 ELSE 0 END) * 100, 2) AS on_time_pct
FROM trips t
JOIN loads l ON l.load_id = t.load_id
JOIN delivery_events de ON de.trip_id = t.trip_id
GROUP BY l.route_id
ORDER BY trip_volume DESC;