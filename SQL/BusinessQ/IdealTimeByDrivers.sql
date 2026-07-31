-- Q16: Idle time efficiency by driver
SELECT
    driver_id,
    COUNT(*) AS trip_count,
    ROUND(AVG(idle_time_hours), 2) AS avg_idle_hours_per_trip
FROM trips
WHERE driver_id IS NOT NULL
GROUP BY driver_id
ORDER BY avg_idle_hours_per_trip ASC;