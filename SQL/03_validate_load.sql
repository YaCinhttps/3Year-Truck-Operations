-- Row count sanity check against source CSVs

SELECT 'drivers' AS table_name, COUNT(*) AS loaded_rows, 150 AS expected_rows FROM drivers
UNION ALL
SELECT 'trucks' AS table_name, COUNT(*) AS loaded_rows, 120 AS expected_rows FROM trucks
UNION ALL
SELECT 'trailers' AS table_name, COUNT(*) AS loaded_rows, 180 AS expected_rows FROM trailers
UNION ALL
SELECT 'customers' AS table_name, COUNT(*) AS loaded_rows, 200 AS expected_rows FROM customers
UNION ALL
SELECT 'facilities' AS table_name, COUNT(*) AS loaded_rows, 50 AS expected_rows FROM facilities
UNION ALL
SELECT 'routes' AS table_name, COUNT(*) AS loaded_rows, 58 AS expected_rows FROM routes
UNION ALL
SELECT 'loads' AS table_name, COUNT(*) AS loaded_rows, 85410 AS expected_rows FROM loads
UNION ALL
SELECT 'trips' AS table_name, COUNT(*) AS loaded_rows, 85410 AS expected_rows FROM trips
UNION ALL
SELECT 'fuel_purchases' AS table_name, COUNT(*) AS loaded_rows, 196442 AS expected_rows FROM fuel_purchases
UNION ALL
SELECT 'maintenance_records' AS table_name, COUNT(*) AS loaded_rows, 2920 AS expected_rows FROM maintenance_records
UNION ALL
SELECT 'delivery_events' AS table_name, COUNT(*) AS loaded_rows, 170820 AS expected_rows FROM delivery_events
UNION ALL
SELECT 'safety_incidents' AS table_name, COUNT(*) AS loaded_rows, 170 AS expected_rows FROM safety_incidents
UNION ALL
SELECT 'driver_monthly_metrics' AS table_name, COUNT(*) AS loaded_rows, 4464 AS expected_rows FROM driver_monthly_metrics
UNION ALL
SELECT 'truck_utilization_metrics' AS table_name, COUNT(*) AS loaded_rows, 3312 AS expected_rows FROM truck_utilization_metrics
;

-- FK orphan check (should return 0 rows for each)
SELECT 'loads.customer_id' AS relationship, COUNT(*) AS orphans
FROM loads c LEFT JOIN customers p ON c.customer_id = p.customer_id
WHERE c.customer_id IS NOT NULL AND p.customer_id IS NULL;

SELECT 'loads.route_id' AS relationship, COUNT(*) AS orphans
FROM loads c LEFT JOIN routes p ON c.route_id = p.route_id
WHERE c.route_id IS NOT NULL AND p.route_id IS NULL;

SELECT 'trips.load_id' AS relationship, COUNT(*) AS orphans
FROM trips c LEFT JOIN loads p ON c.load_id = p.load_id
WHERE c.load_id IS NOT NULL AND p.load_id IS NULL;

SELECT 'trips.driver_id' AS relationship, COUNT(*) AS orphans
FROM trips c LEFT JOIN drivers p ON c.driver_id = p.driver_id
WHERE c.driver_id IS NOT NULL AND p.driver_id IS NULL;

SELECT 'trips.truck_id' AS relationship, COUNT(*) AS orphans
FROM trips c LEFT JOIN trucks p ON c.truck_id = p.truck_id
WHERE c.truck_id IS NOT NULL AND p.truck_id IS NULL;

SELECT 'trips.trailer_id' AS relationship, COUNT(*) AS orphans
FROM trips c LEFT JOIN trailers p ON c.trailer_id = p.trailer_id
WHERE c.trailer_id IS NOT NULL AND p.trailer_id IS NULL;

SELECT 'fuel_purchases.trip_id' AS relationship, COUNT(*) AS orphans
FROM fuel_purchases c LEFT JOIN trips p ON c.trip_id = p.trip_id
WHERE c.trip_id IS NOT NULL AND p.trip_id IS NULL;

SELECT 'fuel_purchases.truck_id' AS relationship, COUNT(*) AS orphans
FROM fuel_purchases c LEFT JOIN trucks p ON c.truck_id = p.truck_id
WHERE c.truck_id IS NOT NULL AND p.truck_id IS NULL;

SELECT 'fuel_purchases.driver_id' AS relationship, COUNT(*) AS orphans
FROM fuel_purchases c LEFT JOIN drivers p ON c.driver_id = p.driver_id
WHERE c.driver_id IS NOT NULL AND p.driver_id IS NULL;

SELECT 'maintenance_records.truck_id' AS relationship, COUNT(*) AS orphans
FROM maintenance_records c LEFT JOIN trucks p ON c.truck_id = p.truck_id
WHERE c.truck_id IS NOT NULL AND p.truck_id IS NULL;

SELECT 'delivery_events.load_id' AS relationship, COUNT(*) AS orphans
FROM delivery_events c LEFT JOIN loads p ON c.load_id = p.load_id
WHERE c.load_id IS NOT NULL AND p.load_id IS NULL;

SELECT 'delivery_events.trip_id' AS relationship, COUNT(*) AS orphans
FROM delivery_events c LEFT JOIN trips p ON c.trip_id = p.trip_id
WHERE c.trip_id IS NOT NULL AND p.trip_id IS NULL;

SELECT 'delivery_events.facility_id' AS relationship, COUNT(*) AS orphans
FROM delivery_events c LEFT JOIN facilities p ON c.facility_id = p.facility_id
WHERE c.facility_id IS NOT NULL AND p.facility_id IS NULL;

SELECT 'safety_incidents.trip_id' AS relationship, COUNT(*) AS orphans
FROM safety_incidents c LEFT JOIN trips p ON c.trip_id = p.trip_id
WHERE c.trip_id IS NOT NULL AND p.trip_id IS NULL;

SELECT 'safety_incidents.truck_id' AS relationship, COUNT(*) AS orphans
FROM safety_incidents c LEFT JOIN trucks p ON c.truck_id = p.truck_id
WHERE c.truck_id IS NOT NULL AND p.truck_id IS NULL;

SELECT 'safety_incidents.driver_id' AS relationship, COUNT(*) AS orphans
FROM safety_incidents c LEFT JOIN drivers p ON c.driver_id = p.driver_id
WHERE c.driver_id IS NOT NULL AND p.driver_id IS NULL;

SELECT 'driver_monthly_metrics.driver_id' AS relationship, COUNT(*) AS orphans
FROM driver_monthly_metrics c LEFT JOIN drivers p ON c.driver_id = p.driver_id
WHERE c.driver_id IS NOT NULL AND p.driver_id IS NULL;

SELECT 'truck_utilization_metrics.truck_id' AS relationship, COUNT(*) AS orphans
FROM truck_utilization_metrics c LEFT JOIN trucks p ON c.truck_id = p.truck_id
WHERE c.truck_id IS NOT NULL AND p.truck_id IS NULL;
