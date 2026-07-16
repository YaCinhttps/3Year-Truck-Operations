-- Auto-generated from cleaned CSVs. Review VARCHAR/NUMERIC sizing before running.

DROP TABLE IF EXISTS drivers CASCADE;
CREATE TABLE drivers (
    driver_id VARCHAR(26),
    first_name VARCHAR(28),
    last_name VARCHAR(28),
    hire_date DATE,
    termination_date DATE,
    license_number VARCHAR(32),
    license_state VARCHAR(14),
    date_of_birth DATE,
    home_terminal VARCHAR(38),
    employment_status VARCHAR(30),
    cdl_class VARCHAR(12),
    years_experience INTEGER,
    PRIMARY KEY (driver_id)
);

DROP TABLE IF EXISTS trucks CASCADE;
CREATE TABLE trucks (
    truck_id VARCHAR(26),
    unit_number INTEGER,
    make VARCHAR(36),
    model_year INTEGER,
    vin VARCHAR(46),
    acquisition_date DATE,
    acquisition_mileage INTEGER,
    fuel_type VARCHAR(22),
    tank_capacity_gallons INTSEGER,
    status VARCHAR(32),
    home_terminal VARCHAR(38),
    PRIMARY KEY (truck_id)
);

DROP TABLE IF EXISTS trailers CASCADE;
CREATE TABLE trailers (
    trailer_id VARCHAR(26),
    trailer_number INTEGER,
    trailer_type VARCHAR(34),
    length_feet INTEGER,
    model_year INTEGER,
    vin VARCHAR(46),
    acquisition_date DATE,
    status VARCHAR(22),
    current_location VARCHAR(38),
    PRIMARY KEY (trailer_id)
);

DROP TABLE IF EXISTS customers CASCADE;
CREATE TABLE customers (
    customer_id VARCHAR(28),
    customer_name VARCHAR(60),
    customer_type VARCHAR(28),
    credit_terms_days INTEGER,
    primary_freight_type VARCHAR(38),
    account_status VARCHAR(26),
    contract_start_date DATE,
    annual_revenue_potential INTEGER,
    PRIMARY KEY (customer_id)
);

DROP TABLE IF EXISTS facilities CASCADE;
CREATE TABLE facilities (
    facility_id VARCHAR(26),
    facility_name VARCHAR(74),
    facility_type VARCHAR(48),
    city VARCHAR(38),
    state VARCHAR(14),
    latitude NUMERIC(12,2),
    longitude NUMERIC(12,2),
    dock_doors INTEGER,
    operating_hours VARCHAR(26),
    PRIMARY KEY (facility_id)
);

DROP TABLE IF EXISTS routes CASCADE;
CREATE TABLE routes (
    route_id VARCHAR(26),
    origin_city VARCHAR(34),
    origin_state VARCHAR(14),
    destination_city VARCHAR(34),
    destination_state VARCHAR(14),
    typical_distance_miles INTEGER,
    base_rate_per_mile NUMERIC(12,2),
    fuel_surcharge_rate NUMERIC(12,2),
    typical_transit_days INTEGER,
    PRIMARY KEY (route_id)
);

DROP TABLE IF EXISTS loads CASCADE;
CREATE TABLE loads (
    load_id VARCHAR(34),
    customer_id VARCHAR(28),
    route_id VARCHAR(26),
    load_date DATE,
    load_type VARCHAR(34),
    weight_lbs INTEGER,
    pieces INTEGER,
    revenue NUMERIC(12,2),
    fuel_surcharge NUMERIC(12,2),
    accessorial_charges INTEGER,
    load_status VARCHAR(28),
    booking_type VARCHAR(28),
    PRIMARY KEY (load_id)
);

DROP TABLE IF EXISTS trips CASCADE;
CREATE TABLE trips (
    trip_id VARCHAR(34),
    load_id VARCHAR(34),
    driver_id VARCHAR(26),
    truck_id VARCHAR(26),
    trailer_id VARCHAR(26),
    dispatch_date DATE,
    actual_distance_miles INTEGER,
    actual_duration_hours NUMERIC(12,2),
    fuel_gallons_used NUMERIC(12,2),
    average_mpg NUMERIC(12,2),
    idle_time_hours NUMERIC(12,2),
    trip_status VARCHAR(28),
    PRIMARY KEY (trip_id)
);

DROP TABLE IF EXISTS fuel_purchases CASCADE;
CREATE TABLE fuel_purchases (
    fuel_purchase_id VARCHAR(34),
    trip_id VARCHAR(34),
    truck_id VARCHAR(26),
    driver_id VARCHAR(26),
    purchase_date DATE,
    location_city VARCHAR(38),
    location_state VARCHAR(14),
    gallons NUMERIC(12,2),
    price_per_gallon NUMERIC(12,2),
    total_cost NUMERIC(12,2),
    fuel_card_number VARCHAR(26),
    PRIMARY KEY (fuel_purchase_id)
);

DROP TABLE IF EXISTS maintenance_records CASCADE;
CREATE TABLE maintenance_records (
    maintenance_id VARCHAR(36),
    truck_id VARCHAR(26),
    maintenance_date DATE,
    maintenance_type VARCHAR(34),
    odometer_reading INTEGER,
    labor_hours NUMERIC(12,2),
    labor_cost NUMERIC(12,2),
    parts_cost NUMERIC(12,2),
    total_cost NUMERIC(12,2),
    facility_location VARCHAR(38),
    downtime_hours NUMERIC(12,2),
    service_description VARCHAR(54),
    PRIMARY KEY (maintenance_id)
);

DROP TABLE IF EXISTS delivery_events CASCADE;
CREATE TABLE delivery_events (
    event_id VARCHAR(32),
    load_id VARCHAR(34),
    trip_id VARCHAR(34),
    event_type VARCHAR(26),
    facility_id VARCHAR(26),
    scheduled_datetime TIMESTAMP,
    actual_datetime TIMESTAMP,
    detention_minutes INTEGER,
    on_time_flag BOOLEAN,
    location_city VARCHAR(34),
    location_state VARCHAR(14),
    PRIMARY KEY (event_id)
);

DROP TABLE IF EXISTS safety_incidents CASCADE;
CREATE TABLE safety_incidents (
    incident_id VARCHAR(32),
    trip_id VARCHAR(34),
    truck_id VARCHAR(26),
    driver_id VARCHAR(26),
    incident_date DATE,
    incident_type VARCHAR(46),
    location_city VARCHAR(38),
    location_state VARCHAR(14),
    at_fault_flag BOOLEAN,
    injury_flag BOOLEAN,
    vehicle_damage_cost NUMERIC(12,2),
    cargo_damage_cost NUMERIC(12,2),
    claim_amount NUMERIC(12,2),
    preventable_flag BOOLEAN,
    description VARCHAR(90),
    PRIMARY KEY (incident_id)
);

DROP TABLE IF EXISTS driver_monthly_metrics CASCADE;
CREATE TABLE driver_monthly_metrics (
    driver_id VARCHAR(26),
    month DATE,
    trips_completed INTEGER,
    total_miles INTEGER,
    total_revenue NUMERIC(12,2),
    average_mpg NUMERIC(12,2),
    total_fuel_gallons NUMERIC(12,2),
    on_time_delivery_rate NUMERIC(12,2),
    average_idle_hours NUMERIC(12,2),
    PRIMARY KEY (driver_id, month)
);

DROP TABLE IF EXISTS truck_utilization_metrics CASCADE;
CREATE TABLE truck_utilization_metrics (
    truck_id VARCHAR(26),
    month DATE,
    trips_completed INTEGER,
    total_miles INTEGER,
    total_revenue NUMERIC(12,2),
    average_mpg NUMERIC(12,2),
    maintenance_events INTEGER,
    maintenance_cost NUMERIC(12,2),
    downtime_hours NUMERIC(12,2),
    utilization_rate NUMERIC(12,2),
    PRIMARY KEY (truck_id, month)
);

-- Foreign key constraints
ALTER TABLE loads ADD CONSTRAINT fk_loads_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE loads ADD CONSTRAINT fk_loads_route_id FOREIGN KEY (route_id) REFERENCES routes(route_id);
ALTER TABLE trips ADD CONSTRAINT fk_trips_load_id FOREIGN KEY (load_id) REFERENCES loads(load_id);
ALTER TABLE trips ADD CONSTRAINT fk_trips_driver_id FOREIGN KEY (driver_id) REFERENCES drivers(driver_id);
ALTER TABLE trips ADD CONSTRAINT fk_trips_truck_id FOREIGN KEY (truck_id) REFERENCES trucks(truck_id);
ALTER TABLE trips ADD CONSTRAINT fk_trips_trailer_id FOREIGN KEY (trailer_id) REFERENCES trailers(trailer_id);
ALTER TABLE fuel_purchases ADD CONSTRAINT fk_fuel_purchases_trip_id FOREIGN KEY (trip_id) REFERENCES trips(trip_id);
ALTER TABLE fuel_purchases ADD CONSTRAINT fk_fuel_purchases_truck_id FOREIGN KEY (truck_id) REFERENCES trucks(truck_id);
ALTER TABLE fuel_purchases ADD CONSTRAINT fk_fuel_purchases_driver_id FOREIGN KEY (driver_id) REFERENCES drivers(driver_id);
ALTER TABLE maintenance_records ADD CONSTRAINT fk_maintenance_records_truck_id FOREIGN KEY (truck_id) REFERENCES trucks(truck_id);
ALTER TABLE delivery_events ADD CONSTRAINT fk_delivery_events_load_id FOREIGN KEY (load_id) REFERENCES loads(load_id);
ALTER TABLE delivery_events ADD CONSTRAINT fk_delivery_events_trip_id FOREIGN KEY (trip_id) REFERENCES trips(trip_id);
ALTER TABLE delivery_events ADD CONSTRAINT fk_delivery_events_facility_id FOREIGN KEY (facility_id) REFERENCES facilities(facility_id);
ALTER TABLE safety_incidents ADD CONSTRAINT fk_safety_incidents_trip_id FOREIGN KEY (trip_id) REFERENCES trips(trip_id);
ALTER TABLE safety_incidents ADD CONSTRAINT fk_safety_incidents_truck_id FOREIGN KEY (truck_id) REFERENCES trucks(truck_id);
ALTER TABLE safety_incidents ADD CONSTRAINT fk_safety_incidents_driver_id FOREIGN KEY (driver_id) REFERENCES drivers(driver_id);
ALTER TABLE driver_monthly_metrics ADD CONSTRAINT fk_driver_monthly_metrics_driver_id FOREIGN KEY (driver_id) REFERENCES drivers(driver_id);
ALTER TABLE truck_utilization_metrics ADD CONSTRAINT fk_truck_utilization_metrics_truck_id FOREIGN KEY (truck_id) REFERENCES trucks(truck_id);

-- Indexes on FK columns for join performance
CREATE INDEX idx_loads_customer_id ON loads(customer_id);
CREATE INDEX idx_loads_route_id ON loads(route_id);
CREATE INDEX idx_trips_load_id ON trips(load_id);
CREATE INDEX idx_trips_driver_id ON trips(driver_id);
CREATE INDEX idx_trips_truck_id ON trips(truck_id);
CREATE INDEX idx_trips_trailer_id ON trips(trailer_id);
CREATE INDEX idx_fuel_purchases_trip_id ON fuel_purchases(trip_id);
CREATE INDEX idx_fuel_purchases_truck_id ON fuel_purchases(truck_id);
CREATE INDEX idx_fuel_purchases_driver_id ON fuel_purchases(driver_id);
CREATE INDEX idx_maintenance_records_truck_id ON maintenance_records(truck_id);
CREATE INDEX idx_delivery_events_load_id ON delivery_events(load_id);
CREATE INDEX idx_delivery_events_trip_id ON delivery_events(trip_id);
CREATE INDEX idx_delivery_events_facility_id ON delivery_events(facility_id);
CREATE INDEX idx_safety_incidents_trip_id ON safety_incidents(trip_id);
CREATE INDEX idx_safety_incidents_truck_id ON safety_incidents(truck_id);
CREATE INDEX idx_safety_incidents_driver_id ON safety_incidents(driver_id);
CREATE INDEX idx_driver_monthly_metrics_driver_id ON driver_monthly_metrics(driver_id);
CREATE INDEX idx_truck_utilization_metrics_truck_id ON truck_utilization_metrics(truck_id);