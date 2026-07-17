SELECT  SUM(loads.revenue) AS total_revenue, Customers.customer_name
FROM loads
JOIN Customers ON loads.customer_id = Customers.customer_id
GROUP BY Customers.customer_name
Order BY total_revenue DESC;




SELECT AVG  (trips.average_mpg) As average_mpg, trucks.make
FROM Trips 
JOIN Trucks ON trips.truck_id = trucks.truck_id
Group by trucks.truck_id
LIMIT 10;



SELECT   COUNT(trip_id) AS trip_count,
CASE  
    WHEN actual_distance_miles < 200 THEN 'Short Trip'
    WHEN actual_distance_miles BETWEEN 200 AND 500 THEN 'Medium Trip'
    ELSE 'Long Trip'
END AS trip_length_category
FROM trips
GROUP BY trip_length_category


SELECT
    r.route_id,
FROM routes r
LEFT JOIN loads l ON l.route_id = r.route_id
LEFT JOIN trips t ON t.load_id = l.load_id
WHERE t.trip_id IS NULL
ORDER BY r.route_id;



SELECT
    d.driver_id,
    d.first_name,
    d.last_name,
    COUNT(fp.fuel_purchase_id) AS fuel_purchase_count,
    SUM(fp.total_cost) AS total_fuel_cost,
    ROUND(AVG(fp.total_cost), 2) AS avg_cost_per_purchase
FROM drivers d
JOIN fuel_purchases fp ON fp.driver_id = d.driver_id
GROUP BY d.driver_id, d.first_name, d.last_name
HAVING COUNT(fp.fuel_purchase_id) > 20
ORDER BY total_fuel_cost DESC;

