-- 1) create a view to get all the vehicles
CREATE VIEW all_vehicles AS
SELECT vehicle_id,status.status_id,status.status_description,employee_id,manfac_year,price,specifications,record_date,model.model_id,model,make.make_id,make
FROM vehicles
INNER JOIN model 
ON vehicles.model_id = model.model_id
INNER JOIN make
ON model.make_id = make.make_id
INNER JOIN status
ON vehicles.status_id = status.status_id;

-- drop all_vehicles view
DROP VIEW all_vehicles;


-- 2) view to get total sales and no of vehicles sold by employees
CREATE VIEW employee_sales AS
SELECT 
    sales.employee_id,
	COUNT(sales.vehicle_id) AS vehicles_sold,
	SUM(sales.Price) AS total_sales
FROM 
    sales
INNER JOIN 
    employees ON employees.employee_id = sales.employee_id
GROUP BY sales.employee_id

-- drop employee_sales view
DROP VIEW employee_sales