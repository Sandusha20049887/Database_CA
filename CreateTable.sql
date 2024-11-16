create database car_dealership_grp7;
use car_dealership_grp7;
--creating tables

CREATE TABLE roles (
    role_id VARCHAR(10) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

CREATE TABLE branches (
    branch_id VARCHAR(5) PRIMARY KEY,
    branch_name VARCHAR(50) NOT NULL,
    branch_address VARCHAR(500),
    phone VARCHAR(15)
);

CREATE TABLE make (
    make_id INT PRIMARY KEY,
    make VARCHAR(50) NOT NULL
);

CREATE TABLE status (
    status_id VARCHAR(2) PRIMARY KEY,
    status_description VARCHAR(20) NOT NULL
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(500),
    registered_date DATE
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    role_id VARCHAR(10) NOT NULL,
    branch_id VARCHAR(5) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    joined_date DATE,
	FOREIGN KEY (role_id) REFERENCES roles(role_id),
	FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);


CREATE TABLE model (
    model_id INT PRIMARY KEY,
    make_id INT NOT NULL,
    model VARCHAR(50) NOT NULL,
	FOREIGN KEY (make_id) REFERENCES make(make_id),
);

CREATE TABLE vehicles (
    vehicle_id VARCHAR(7) PRIMARY KEY,
    status_id VARCHAR(2),
    employee_id INT,
    model_id INT,
    vin VARCHAR(10) UNIQUE NOT NULL,
    manfac_year INT,
    price DECIMAL(10,2),
    specifications XML,
    record_date DATE,
	FOREIGN KEY (status_id) REFERENCES status(status_id),
	FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
	FOREIGN KEY (model_id) REFERENCES model(model_id)
);

CREATE TABLE sales (
    sales_id INT PRIMARY KEY,
    customer_id INT,
    vehicle_id VARCHAR(7),
    employee_id INT,
    sale_date DATE,
    price DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
	FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE service_records (
    service_id INT PRIMARY KEY,
    vehicle_id VARCHAR(7),
    branch_id VARCHAR(5),
    service_date DATE,
    cost DECIMAL(10,2),
    service_details XML,
	FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
	FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE media (
    media_id INT PRIMARY KEY,
    vehicle_id VARCHAR(7),
    media_path VARCHAR(500),
	FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

CREATE TABLE cash_book (
    cash_book_id INT PRIMARY KEY,
    vehicle_id VARCHAR(7),
    debited_amount DECIMAL(10,2),
    credited_amount DECIMAL(10,2),
    transaction_date DATE,
	FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);
