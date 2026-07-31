-- name: 14_detention_vs_on_time
SELECT
    on_time_flag,
    COUNT(*) AS event_count,
    ROUND(AVG(detention_minutes), 2) AS avg_detention_minutes
FROM delivery_events
GROUP BY on_time_flag;