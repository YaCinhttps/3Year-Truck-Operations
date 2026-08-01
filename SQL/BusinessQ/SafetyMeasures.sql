-- Q17: Overall incident rate per million miles
SELECT
    COUNT(DISTINCT si.incident_id) AS total_incidents,
    SUM(t.actual_distance_miles) AS total_miles,
    ROUND(
        COUNT(DISTINCT si.incident_id)::NUMERIC
        / NULLIF(SUM(t.actual_distance_miles), 0) * 1000000, 3
    ) AS incidents_per_million_miles
FROM trips t
LEFT JOIN safety_incidents si ON si.trip_id = t.trip_id;
 
-- Q18: Incident concentration by driver
SELECT
    d.driver_id,
    COUNT(DISTINCT si.incident_id) AS incident_count,
    COUNT(DISTINCT t.trip_id) AS total_trips,
    ROUND(COUNT(DISTINCT si.incident_id)::NUMERIC / NULLIF(COUNT(DISTINCT t.trip_id), 0) * 1000, 3) AS incident_rate_per_1000_trips
FROM drivers d
JOIN trips t ON t.driver_id = d.driver_id
LEFT JOIN safety_incidents si ON si.driver_id = d.driver_id
GROUP BY d.driver_id
HAVING COUNT(DISTINCT si.incident_id) > 0
ORDER BY incident_rate_per_1000_trips DESC;
 
-- Q19: Preventable incident rate by driver tenure bucket
WITH incident_tenure AS (
    SELECT
        si.incident_id,
        si.preventable_flag,
        EXTRACT(YEAR FROM AGE(si.incident_date, d.hire_date)) AS tenure_years_at_incident
    FROM safety_incidents si
    JOIN drivers d ON d.driver_id = si.driver_id
)
SELECT
    CASE
        WHEN tenure_years_at_incident < 1 THEN 'Under 1 year'
        WHEN tenure_years_at_incident BETWEEN 1 AND 3 THEN '1-3 years'
        ELSE '3+ years'
    END AS tenure_bucket,
    COUNT(*) AS total_incidents,
    ROUND(SUM(CASE WHEN preventable_flag THEN 1 ELSE 0 END)::NUMERIC / COUNT(*) * 100, 2) AS preventable_pct
FROM incident_tenure
GROUP BY tenure_bucket
ORDER BY tenure_bucket;
 
-- Q20: Recent maintenance vs safety incidents
-- "Recent maintenance" defined here as maintenance within 30 days
-- before the incident. Adjust the interval to test other definitions.

SELECT
    si.incident_id,
    si.truck_id,
    si.incident_date,
    MAX(mr.maintenance_date) FILTER (
        WHERE mr.maintenance_date <= si.incident_date
    ) AS last_maintenance_before_incident,
    si.incident_date - MAX(mr.maintenance_date) FILTER (
        WHERE mr.maintenance_date <= si.incident_date
    ) AS days_since_maintenance
FROM safety_incidents si
LEFT JOIN maintenance_records mr ON mr.truck_id = si.truck_id
GROUP BY si.incident_id, si.truck_id, si.incident_date
ORDER BY days_since_maintenance ASC NULLS LAST;