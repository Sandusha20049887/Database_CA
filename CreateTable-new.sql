
create database car_dealership_new;

use car_dealership_new;
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
    make_id INT IDENTITY(1,1) PRIMARY KEY,
    make VARCHAR(50) NOT NULL
);

CREATE TABLE status (
    status_id VARCHAR(2) PRIMARY KEY,
    status_description VARCHAR(20) 
);

CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(500),
    registered_date DATE
);

CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    role_id VARCHAR(10) NOT NULL,
    branch_id VARCHAR(5) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15),
    joined_date DATE,
	CONSTRAINT Employees_Roles_Fk FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE,
	CONSTRAINT Employees_Branches_Fk FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON DELETE CASCADE
);


CREATE TABLE model (
    model_id INT IDENTITY(1,1) PRIMARY KEY,
    make_id INT NOT NULL,
    model VARCHAR(50) NOT NULL,
	CONSTRAINT Model_Make_FK FOREIGN KEY (make_id) REFERENCES make(make_id)
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
	CONSTRAINT Vehicles_Status_Fk FOREIGN KEY (status_id) REFERENCES status(status_id) ON DELETE CASCADE,
	CONSTRAINT Vehicles_Employees_Fk FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
	CONSTRAINT Vehicles_Model_Fk FOREIGN KEY (model_id) REFERENCES model(model_id) ON DELETE CASCADE
);

CREATE TABLE sales (
    sales_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    vehicle_id VARCHAR(7),
    employee_id INT,
    sale_date DATE,
    price DECIMAL(10,2),
	CONSTRAINT FK_Sales_Customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
	CONSTRAINT FK_Sales_Vehicles FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE NO ACTION,
	CONSTRAINT FK_Sales_Employees FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE service_records (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    vehicle_id VARCHAR(7),
    branch_id VARCHAR(5),
    service_date DATE,
    cost DECIMAL(10,2),
    service_details XML,
	CONSTRAINT ServiceRecords_Vehicles_Fk FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
	CONSTRAINT ServiceRecords_Branches_Fk FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON DELETE NO ACTION
);

CREATE TABLE media (
    media_id INT IDENTITY(1,1) PRIMARY KEY,
    vehicle_id VARCHAR(7),
    media_path VARCHAR(500),
	CONSTRAINT Media_Vehicles_Fk FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE
);

CREATE TABLE cash_book (
    cash_book_id INT IDENTITY(1,1) PRIMARY KEY,
    vehicle_id VARCHAR(7),
    debited_amount DECIMAL(10,2) DEFAULT 0.00,
    credited_amount DECIMAL(10,2) DEFAULT 0.00,
    transaction_date DATE,
	CONSTRAINT CashBook_Vehicles_Fk FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE
);

