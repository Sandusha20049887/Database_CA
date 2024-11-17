-- define a function to calculate commission passing total sales amd commission rate
CREATE FUNCTION dbo.CalculateCommission (@TotalSales DECIMAL(18, 2), @CommissionRate DECIMAL(5, 2))
RETURNS DECIMAL(18, 2)
AS
BEGIN
    RETURN @TotalSales * @CommissionRate;
END;
GO


drop function dbo.CalculateCommission