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






