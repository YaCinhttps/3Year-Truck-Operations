-- Q11: Maintenance cost per mile — older vs newer trucks
-- "Older/newer" defined here as truck age in years from acquisition_date.

WITH truck_miles AS (
    SELECT truck_id, SUM(actual_distance_miles) AS total_miles
    FROM trips
    GROUP BY truck_id
),
truck_maint_cost AS (
    SELECT truck_id, 
    SUM(maintenance_cost) AS total_maint_cost   
    FROM truck_utilization_metrics
    GROUP BY truck_id
)
SELECT
    tr.truck_id,
    tr.acquisition_date,
    ROUND(EXTRACT(YEAR FROM AGE(CURRENT_DATE, tr.acquisition_date)), 1) AS truck_age_years,
    tmc.total_maint_cost,
    tm.total_miles,
    ROUND(tmc.total_maint_cost / NULLIF(tm.total_miles, 0), 4) AS cost_per_mile
FROM trucks tr
JOIN truck_miles tm ON tm.truck_id = tr.truck_id
JOIN truck_maint_cost tmc ON tmc.truck_id = tr.truck_id
ORDER BY cost_per_mile DESC;