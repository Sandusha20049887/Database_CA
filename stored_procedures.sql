-- 1) create sp to get vehicle details with different vehicle statuses
CREATE PROCEDURE SelectAllVehiclesWithMakeModelDetails @Status varchar(2)
AS
BEGIN
    SELECT * FROM all_vehicles
	WHERE all_vehicles.status_id = @Status;
END;
GO


-- execute the SelectAllVehiclesWithMakeModelDetails sp
EXEC SelectAllVehiclesWithMakeModelDetails @Status = 'SL'; -- can pass 'SL - for sold, AV - for available, RS - for reserved'

-- drop the SelectAllVehiclesWithMakeModelDetails sp
DROP PROCEDURE SelectAllVehiclesWithMakeModelDetails;


-- 2) create sp to get sales details and commission earned 
-- by each employee having certain number of sold vehicles
-- allowing to pass the percentage of commission to be calculated
CREATE PROCEDURE SelectCommissionAndSalesDetails @MinVehiclesSold varchar(2),@CommissionRate DECIMAL(5, 2)
AS
BEGIN
    SELECT employee_sales.employee_id,employee_sales.vehicles_sold,employee_sales.total_sales,dbo.CalculateCommission(employee_sales.total_sales,@CommissionRate) AS commission
	FROM employee_sales
	GROUP BY employee_sales.employee_id,employee_sales.vehicles_sold,employee_sales.total_sales
	HAVING employee_sales.vehicles_sold >= @MinVehiclesSold
END;
GO

-- execute the SelectCommissionAndSalesDetails sp
EXEC SelectCommissionAndSalesDetails @MinVehiclesSold = 2,@CommissionRate=0.05;

-- drop the SelectAllVehiclesWithMakeModelDetails sp
DROP PROCEDURE SelectAllVehiclesWithMakeModelDetails;

---------------------------------------------------------------------------------------
-- 3) create sp to get revenue earned from specific date range

CREATE PROCEDURE GetRevenueByDateRange
	@FromDate DATE,
	@ToDate DATE
AS
BEGIN
	SELECT
	SUM(cb.credited_amount) - SUM(cb.debited_amount) AS revenue
	FROM cash_book cb
	WHERE date BETWEEN @FromDate AND @ToDate
END;

-- execute the GetRevenueByDateRange sp
EXEC GetRevenueByDateRange @FromDate = '2023-05-01', @ToDate = '2023-12-01' 

---------------------------------------------------------------------------------------
------------ Developing XML with appropriate elements using relational fields ----------
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
-- 1) create sp to get vehicle details and specifications with service records as an xml 
CREATE PROCEDURE VehicleDetailsWithServiceRecordsXML @VehicleId varchar(7)
AS
BEGIN
	SELECT 
        v.vehicle_id AS VehicleID,
        v.vin AS VIN,
        v.year AS ManufactureYear,
        v.price AS Price,
        s.status AS Status,
        v.specifications AS Specifications,
		(
			SELECT 
			sr.service_id AS ServiceId,
			sr.branch_id AS Branch,
			sr.cost AS TotalCost, 
			sr.service_date AS ServicedDate, 
			sr.service_details AS ServiceInfo
			FROM service_records sr 
			WHERE sr.vehicle_id = v.vehicle_id 
			FOR XML PATH('Service'), TYPE 
		) AS Services
    FROM vehicles v
    JOIN status s ON v.status_id = s.status_id
	WHERE v.vehicle_id = @VehicleId
    FOR XML PATH('Vehicle'), TYPE
END;
-- execute the VehicleDetailsWithServiceRecordsXML 
EXEC VehicleDetailsWithServiceRecordsXML @VehicleId = 'VH001';

-------------------------------------------------------------------------------------------------------------------------------
-- 2) create sp to get vehicle service history for a selected vehicle or all vehicles with xml data as well as other data types
--    with filters branchid, techinicianid, vehicle id

CREATE PROCEDURE VehicleFullServiceHistory @VehicleId varchar(7) = NULL, @BranchId varchar(5) = NULL, @TechnicianId INT = NULL
AS
BEGIN
	SELECT *
	FROM vehicle_service_details
	WHERE VehicleID = @VehicleId OR @VehicleId IS NULL
	AND BranchID = @BranchId OR @BranchId IS NULL
	AND TechnicianID = @TechnicianId OR @TechnicianId IS NULL
END;

-- execute the VehicleFullServiceHistory 
-- View all the records 
EXEC VehicleFullServiceHistory;
-- filter by vehcile ID
EXEC VehicleFullServiceHistory @VehicleId = 'VH001';
-- filter by branch ID
EXEC VehicleFullServiceHistory @BranchId = 'B004';
-- filter by Technician ID
EXEC VehicleFullServiceHistory @TechnicianId = '3';
-- filter by vehicle and branch
EXEC VehicleFullServiceHistory @VehicleId = 'VH001', @BranchId = 'B004';

--------------------------------------------------------------------------------------------------------------------------
-- 3) SP to modify data in service records -> service details
--    Insert Part by modifying the xml

CREATE PROCEDURE InsertPartToServiceDetails
    @ServiceId INT,
    @PartName NVARCHAR(100),
    @PartCost DECIMAL(10, 2)
AS
BEGIN
    -- Declare variables to hold service_details
    DECLARE @serviceDetails XML;

    -- Retrieve the relevant service record
    SELECT 
        @serviceDetails = service_details
    FROM 
        service_records
    WHERE 
        service_id = @ServiceId;

    -- Add a new part to the XML
    SET @serviceDetails.modify('
        insert <part>
            <name>{sql:variable("@PartName")}</name>
            <cost>{sql:variable("@PartCost")}</cost>
        </part>
        as last into (/serviceDetails/service/parts)[1]
    ');

    -- Update the service_details column in the table
    UPDATE service_records
    SET service_details = @serviceDetails
    WHERE service_id = @ServiceId;
END;

-- exec the InsertPartToServiceDetail
exec InsertPartToServiceDetails @ServiceId = 5,@PartName = 'A/C Filter',@PartCost = 34.50 

--------------------------------------------------------------------------------------------
-- 4) SP to search on service records table to get the vehicles which are using a specific part

CREATE PROCEDURE GetVehiclesByPartUsed
    @PartName NVARCHAR(100)
AS
BEGIN
    SELECT 
        sr.vehicle_id,
		v.vin,
		v.year,
		mk.make,
		m.model,
        sr.branch_id,
        sr.service_date,
        part.value('(name/text())[1]', 'NVARCHAR(100)') AS part_name,
        part.value('(cost/text())[1]', 'DECIMAL(10, 2)') AS part_cost
    FROM 
        service_records sr
	JOIN vehicles v ON v.vehicle_id = sr.vehicle_id
	JOIN model m ON m.model_id = v.model_id
	JOIN make mk ON mk.make_id = m.make_id
    CROSS APPLY 
        sr.service_details.nodes('/serviceDetails/service/parts/part') AS PartsNode(part)
    WHERE 
        part.value('(name/text())[1]', 'NVARCHAR(100)') = @PartName
END;

-- exec the GetVehiclesByPartUsed
exec GetVehiclesByPartUsed @PartName = 'A/C Filter'