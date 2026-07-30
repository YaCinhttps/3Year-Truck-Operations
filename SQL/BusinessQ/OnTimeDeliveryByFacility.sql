-- Q13: On-time delivery rate overall and by facility
SELECT
    facility_id,
    COUNT(*) AS total_events,
    SUM(CASE WHEN on_time_flag THEN 1 ELSE 0 END) AS on_time_events,
    ROUND(SUM(CASE WHEN on_time_flag THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100, 2) AS on_time_pct
FROM delivery_events
GROUP BY facility_id
ORDER BY on_time_pct ASC;
 
