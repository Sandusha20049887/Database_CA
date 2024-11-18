-- 1) create a view to get all the vehicles
CREATE VIEW all_vehicles AS
SELECT vehicle_id,status.status_id,status.status,employee_id,year,price,specifications,record_date,model.model_id,model,make.make_id,make
FROM vehicles
INNER JOIN model 
ON vehicles.model_id = model.model_id
INNER JOIN make
ON model.make_id = make.make_id
INNER JOIN status
ON vehicles.status_id = status.status_id;

-- drop all_vehicles view
DROP VIEW all_vehicles;

------------------------------------------------------------------
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

------------------------------------------------------------------------------------------
-- 3) View all service details with all the information including parts, technician,branch
CREATE VIEW vehicle_service_details AS
SELECT
    sr.vehicle_id AS VehicleID,
    sr.branch_id AS BranchID,
	b.branch_name AS BranchName,
    sr.service_date AS ServiceDate,
	sr.cost AS TotalCost,
    ServiceDetail.value('(type)[1]', 'VARCHAR(100)') AS ServiceType,
    PartDetail.value('(name)[1]', 'VARCHAR(100)') AS PartName,
    PartDetail.value('(cost)[1]', 'DECIMAL(10,2)') AS PartCost,
    TechnicianDetail.value('(id)[1]', 'INT') AS TechnicianID,
	e.first_name+' '+e.last_name AS TechnicianName,
    TechnicianDetail.value('(notes)[1]', 'VARCHAR(255)') AS TechnicianNotes
FROM 
    service_records sr
CROSS APPLY 
    service_details.nodes('/serviceDetails/service') AS ServiceNode(ServiceDetail)
CROSS APPLY 
    ServiceDetail.nodes('parts/part') AS PartNode(PartDetail)
CROSS APPLY 
    service_details.nodes('/serviceDetails/technician') AS TechnicianNode(TechnicianDetail)

JOIN employees e ON e.employee_id = TechnicianDetail.value('(id)[1]', 'INT')
JOIN branches b ON b.branch_id = sr.branch_id;



