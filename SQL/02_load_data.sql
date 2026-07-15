-- COPY commands. Column order matches the CSV header exactly.
-- Update the file path below to your actual clean CSV location.

COPY drivers (driver_id, first_name, last_name, hire_date, termination_date, license_number, license_state, date_of_birth, home_terminal, employment_status, cdl_class, years_experience)
FROM 'C:/Projects/3Year Truck Operations/data/clean/drivers_clean.csv'
DELIMITER ',' CSV HEADER;

COPY trucks (truck_id, unit_number, make, model_year, vin, acquisition_date, acquisition_mileage, fuel_type, tank_capacity_gallons, status, home_terminal)
FROM 'C:/Projects/3Year Truck Operations/data/clean/trucks_clean.csv'
DELIMITER ',' CSV HEADER;

COPY trailers (trailer_id, trailer_number, trailer_type, length_feet, model_year, vin, acquisition_date, status, current_location)
FROM 'C:/Projects/3Year Truck Operations/data/clean/trailers_clean.csv'
DELIMITER ',' CSV HEADER;

COPY customers (customer_id, customer_name, customer_type, credit_terms_days, primary_freight_type, account_status, contract_start_date, annual_revenue_potential)
FROM 'C:/Projects/3Year Truck Operations/data/clean/customers_clean.csv'
DELIMITER ',' CSV HEADER;

COPY facilities (facility_id, facility_name, facility_type, city, state, latitude, longitude, dock_doors, operating_hours)
FROM 'C:/Projects/3Year Truck Operations/data/clean/facilities_clean.csv'
DELIMITER ',' CSV HEADER;

COPY routes (route_id, origin_city, origin_state, destination_city, destination_state, typical_distance_miles, base_rate_per_mile, fuel_surcharge_rate, typical_transit_days)
FROM 'C:/Projects/3Year Truck Operations/data/clean/routes_clean.csv'
DELIMITER ',' CSV HEADER;

COPY loads (load_id, customer_id, route_id, load_date, load_type, weight_lbs, pieces, revenue, fuel_surcharge, accessorial_charges, load_status, booking_type)
FROM 'C:/Projects/3Year Truck Operations/data/clean/loads_clean.csv'
DELIMITER ',' CSV HEADER;

COPY trips (trip_id, load_id, driver_id, truck_id, trailer_id, dispatch_date, actual_distance_miles, actual_duration_hours, fuel_gallons_used, average_mpg, idle_time_hours, trip_status)
FROM 'C:/Projects/3Year Truck Operations/data/clean/trips_clean.csv'
DELIMITER ',' CSV HEADER;

COPY fuel_purchases (fuel_purchase_id, trip_id, truck_id, driver_id, purchase_date, location_city, location_state, gallons, price_per_gallon, total_cost, fuel_card_number)
FROM 'C:/Projects/3Year Truck Operations/data/clean/fuel_purchases_clean.csv'
DELIMITER ',' CSV HEADER;

COPY maintenance_records (maintenance_id, truck_id, maintenance_date, maintenance_type, odometer_reading, labor_hours, labor_cost, parts_cost, total_cost, facility_location, downtime_hours, service_description)
FROM 'C:/Projects/3Year Truck Operations/data/clean/maintenance_records_clean.csv'
DELIMITER ',' CSV HEADER;

COPY delivery_events (event_id, load_id, trip_id, event_type, facility_id, scheduled_datetime, actual_datetime, detention_minutes, on_time_flag, location_city, location_state)
FROM 'C:/Projects/3Year Truck Operations/data/clean/delivery_events_clean.csv'
DELIMITER ',' CSV HEADER;

COPY safety_incidents (incident_id, trip_id, truck_id, driver_id, incident_date, incident_type, location_city, location_state, at_fault_flag, injury_flag, vehicle_damage_cost, cargo_damage_cost, claim_amount, preventable_flag, description)
FROM 'C:/Projects/3Year Truck Operations/data/clean/safety_incidents_clean.csv'
DELIMITER ',' CSV HEADER;

COPY driver_monthly_metrics (driver_id, month, trips_completed, total_miles, total_revenue, average_mpg, total_fuel_gallons, on_time_delivery_rate, average_idle_hours)
FROM 'C:/Projects/3Year Truck Operations/data/clean/driver_monthly_metrics_clean.csv'
DELIMITER ',' CSV HEADER;

COPY truck_utilization_metrics (truck_id, month, trips_completed, total_miles, total_revenue, average_mpg, maintenance_events, maintenance_cost, downtime_hours, utilization_rate)
FROM 'C:/Projects/3Year Truck Operations/data/clean/truck_utilization_metrics_clean.csv'
DELIMITER ',' CSV HEADER;
