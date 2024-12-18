--Trigger to update cashbook for vehicle purchases from car dealership
CREATE TRIGGER UpdateCashBookOnVehicleAdd
ON vehicles
AFTER INSERT
AS
BEGIN
    INSERT INTO cash_book (vehicle_id, debited_amount, date)
    SELECT 
        vehicle_id, price, record_date     
    FROM 
        inserted;
END;

----Trigger to update cashbook for vehicle sales from car dealership and update vehicle status as sold
CREATE TRIGGER UpdateCashBookOnVehicleSale
ON sales
AFTER INSERT
AS
BEGIN
    -- Update vehicles table to set status to 'Sold' 
    UPDATE vehicles 
    SET status_id = 'SL' 
    FROM vehicles v
    JOIN inserted i ON v.vehicle_id = i.vehicle_id;

    -- Insert into cash_book table
    INSERT INTO cash_book (vehicle_id, credited_amount, date)
    SELECT 
        vehicle_id, price, sale_date
    FROM 
        inserted;
END;


