-- Insert records for roles
INSERT INTO roles (role_id, role) VALUES
('R001', 'Manager'),
('R002', 'Sales Executive'),
('R003', 'Mechanic'),
('R004', 'Receptionist'),
('R005', 'Accountant');

--Insert records for branches
INSERT INTO branches (branch_id, branch_name, address, phone) VALUES
('B001', 'Central Branch', '123 Main St, Dublin, Ireland', '+35312345678'),
('B002', 'South Branch', '456 South Rd, Cork, Ireland', '+35323456789'),
('B003', 'West Branch', '789 West St, Galway, Ireland', '+35334567890'),
('B004', 'North Branch', '101 North Ave, Belfast, Ireland', '+44234567890'),
('B005', 'East Branch', '202 East Blvd, Wexford, Ireland', '+35345678901');

--Insert records for make
INSERT INTO make (make) VALUES
('Toyota'),
('Honda'),
('Ford'),
('BMW'),
('Tesla');

--Insert records for model
INSERT INTO model (make_id, model) VALUES
(1, 'Corolla'),
(2, 'Civic'),
(3, 'Mustang'),
(4, 'X5'),
(5, 'Model 3');


--Insert records for status
INSERT INTO status (status_id, status) VALUES
('AV', 'Available'),
('SL', 'Sold'),
('RS', 'Reserved');

--Insert records for customers
INSERT INTO customers (first_name, last_name, email, phone, address, registered_date) VALUES
('John', 'Doe', 'john.doe@example.com', '+353876543210', 'Apartment 101, Dublin, Ireland', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '+353876543211', '56 Cork Rd, Cork, Ireland', '2023-03-10'),
('Michael', 'Brown', 'michael.brown@example.com', '+353876543212', '12 Galway St, Galway, Ireland', '2023-05-20'),
('Emily', 'Davis', 'emily.davis@example.com', '+353876543213', '89 Wexford Ave, Wexford, Ireland', '2023-07-05'),
('Sarah', 'Wilson', 'sarah.wilson@example.com', '+353876543214', '23 Belfast Lane, Belfast, Ireland', '2023-09-01');

--Insert records for employees
INSERT INTO employees (role_id, branch_id, first_name, last_name, email, phone, joined_date) VALUES
('R001', 'B001', 'Alice', 'Johnson', 'alice.johnson@company.com', '+353876543215', '2020-01-10'),
('R002', 'B001', 'Bob', 'Miller', 'bob.miller@company.com', '+353876543216', '2021-03-15'),
('R003', 'B002', 'Charlie', 'Anderson', 'charlie.anderson@company.com', '+353876543217', '2022-05-20'),
('R002', 'B003', 'Diana', 'Moore', 'diana.moore@company.com', '+353876543218', '2021-07-30'),
('R003', 'B004', 'Edward', 'Taylor', 'edward.taylor@company.com', '+353876543219', '2019-11-25');

--Insert records for vehicles
INSERT INTO vehicles (vehicle_id, status_id, employee_id, model_id, vin, year, price, specifications, record_date) VALUES
('VH001', 'AV', 2, 2, 'VIN1234567', 2022, 25000.00, 
'<specifications>
    <engine>
        <type>V6</type>
        <displacement>3.5L</displacement>
        <horsepower>280</horsepower>
        <transmission>Automatic</transmission>
    </engine>
    <features>
        <feature>Lane Departure Warning</feature>
        <feature>Automatic Emergency Braking</feature>
        <feature>Leather Seats</feature>
        <feature>Dual-Zone Climate Control</feature>
    </features>
</specifications>', 
'2023-01-01'),

('VH002', 'SL', 2, 4, 'VIN2345678', 2021, 22000.00, 
'<specifications>
    <engine>
        <type>I4</type>
        <displacement>2.0L</displacement>
        <horsepower>158</horsepower>
        <transmission>CVT</transmission>
    </engine>
    <features>
        <feature>Apple CarPlay</feature>
        <feature>Adaptive Cruise Control</feature>
        <feature>Heated Seats</feature>
        <feature>Backup Camera</feature>
    </features>
</specifications>', 
'2023-02-15'),

('VH003', 'AV', 4, 4, 'VIN3456789', 2023, 55000.00, 
'<specifications>
    <engine>
        <type>V8</type>
        <displacement>5.0L</displacement>
        <horsepower>450</horsepower>
        <transmission>Manual</transmission>
    </engine>
    <features>
        <feature>Performance Suspension</feature>
        <feature>Navigation System</feature>
        <feature>Premium Audio</feature>
        <feature>Keyless Entry</feature>
    </features>
</specifications>', 
'2023-03-10'),

('VH004', 'RS', 4, 4, 'VIN4567890', 2020, 70000.00, 
'<specifications>
    <engine>
        <type>Inline-6</type>
        <displacement>3.0L</displacement>
        <horsepower>335</horsepower>
        <transmission>Automatic</transmission>
    </engine>
    <features>
        <feature>Panoramic Sunroof</feature>
        <feature>Heads-Up Display</feature>
        <feature>Ventilated Seats</feature>
        <feature>Blind Spot Monitoring</feature>
    </features>
</specifications>', 
'2023-04-20'),

('VH005', 'SL', 2, 2, 'VIN5678901', 2023, 35000.00, 
'<specifications>
    <engine>
        <type>Electric</type>
        <displacement>None</displacement>
        <horsepower>283</horsepower>
        <transmission>Direct Drive</transmission>
    </engine>
    <features>
        <feature>Autopilot</feature>
        <feature>Wireless Charging</feature>
        <feature>360-Degree Camera</feature>
        <feature>Heated Steering Wheel</feature>
    </features>
</specifications>', 
'2023-05-25');

--Insert records to sales table
INSERT INTO sales (customer_id, vehicle_id, employee_id, sale_date, price) VALUES
(1, 'VH002', 2, '2023-06-10', 22000.00),
(2, 'VH005', 2, '2023-09-10', 35000.00),
(3, 'VH004', 4, '2023-08-01', 70000.00);

--Insert records to service_records table
INSERT INTO service_records (vehicle_id, branch_id, service_date, cost, service_details) VALUES
('VH001', 'B002', '2023-03-01', 100.00, 
'<serviceDetails>
    <services>
        <service>
            <type>Oil Change</type>
            <parts>
                <part>
                    <name>Oil Filter</name>
                    <cost>15.99</cost>
                </part>
                <part>
                    <name>Synthetic Oil</name>
                    <cost>45.99</cost>
                </part>
            </parts>
        </service>
    </services>
    <technician>
        <id>3</id>
        <notes>Regular maintenance completed</notes>
    </technician>
</serviceDetails>'),

('VH003', 'B002', '2023-04-10', 250.00, 
'<serviceDetails>
    <services>
        <service>
            <type>Tire Replacement</type>
            <parts>
                <part>
                    <name>Front Tire</name>
                    <cost>120.00</cost>
                </part>
                <part>
                    <name>Rear Tire</name>
                    <cost>120.00</cost>
                </part>
            </parts>
        </service>
    </services>
    <technician>
        <id>3</id>
        <notes>Tires replaced and balanced</notes>
    </technician>
</serviceDetails>'),

('VH004', 'B004', '2023-05-20', 300.00, 
'<serviceDetails>
    <services>
        <service>
            <type>Engine Diagnostics</type>
            <parts>
                <part>
                    <name>Spark Plugs</name>
                    <cost>60.00</cost>
                </part>
                <part>
                    <name>Engine Oil</name>
                    <cost>50.00</cost>
                </part>
            </parts>
        </service>
    </services>
    <technician>
        <id>5</id>
        <notes>Engine performance restored</notes>
    </technician>
</serviceDetails>'),

('VH005', 'B004', '2023-06-15', 180.00, 
'<serviceDetails>
    <services>
        <service>
            <type>Brake Replacement</type>
            <parts>
                <part>
                    <name>Front Brake Pads</name>
                    <cost>90.00</cost>
                </part>
                <part>
                    <name>Rear Brake Pads</name>
                    <cost>80.00</cost>
                </part>
            </parts>
        </service>
    </services>
    <technician>
        <id>5</id>
        <notes>Brakes replaced and tested</notes>
    </technician>
</serviceDetails>');

--Insert recored to service_records table
INSERT INTO media (vehicle_id, media_path) VALUES
('VH001', '/media/VH001_front.jpg'),
('VH002', '/media/VH002_side.jpg'),
('VH003', '/media/VH003_rear.jpg'),
('VH004', '/media/VH004_interior.jpg');

--Insert recored to cash_book table
INSERT INTO cash_book (vehicle_id, debited_amount, credited_amount, date) VALUES
('VH001', 18000.00, 0.00, '2023-01-01'),
('VH002', 20000.00, 0.00, '2023-02-01'),
('VH003', 45000.00, 0.00, '2023-03-10'),
('VH004', 65000.00, 0.00, '2023-04-20'),
('VH005', 30000.00, 0.00, '2023-05-01'),
('VH002', 0.00, 22000.00, '2023-06-10'),
('VH005', 0.00, 35000.00, '2023-09-10');
