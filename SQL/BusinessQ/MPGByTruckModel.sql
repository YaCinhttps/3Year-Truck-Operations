-- Q10: Average MPG by truck make/model + fleet-wide trend over time

SELECT
    tr.make,                       
    ROUND(AVG(t.average_mpg), 2) AS avg_mpg,
    COUNT(t.trip_id) AS trip_count
FROM trucks tr
JOIN trips t ON t.truck_id = tr.truck_id
GROUP BY tr.make
ORDER BY avg_mpg DESC;


SELECT
    DATE_TRUNC('month', dispatch_date) AS month,
    ROUND(AVG(average_mpg), 2) AS avg_fleet_mpg
FROM trips
GROUP BY month
ORDER BY month;