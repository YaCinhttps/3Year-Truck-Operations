
SELECT * FROM trucks 
WHERE  acquisition_date < '2022-01-01' 
;


SELECT AVG (Total_cost) AS Average_Cost 
FROM fuel_purchases ;



SELECT  * FROM loads
Order BY revenue 
Limit 10 ;


SELECT COUNT(*) AS Total_Trips, trip_status
FROM trips
GROUP BY trip_status;


SELECT MIN ( actual_distance_miles) AS Min_Distance, MAX(actual_distance_miles) AS Max_Distance
 , AVG(actual_distance_miles) AS Average_Distance
FROM Trips;


SELECT DISTINCT event_type
FROM delivery_events;


