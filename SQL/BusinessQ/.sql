WITH truck_utilization AS (
    SELECT truck_id, COUNT(*) AS trip_count, SUM(actual_distance_miles) AS total_miles
    FROM trips
    GROUP BY truck_id
),
truck_maint AS (
    SELECT truck_id, COUNT(*) AS maint_count, SUM(Total_Cost) AS total_maint_cost
    FROM maintenance_records
    GROUP BY truck_id
)
SELECT
    tu.truck_id,
    tu.trip_count,
    tu.total_miles,
    tm.maint_count,
    tm.total_maint_cost
FROM truck_utilization tu
JOIN truck_maint tm ON tm.truck_id = tu.truck_id
ORDER BY tu.total_miles DESC;