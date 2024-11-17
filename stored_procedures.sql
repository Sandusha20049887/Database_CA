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