USE BREWERY
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE dbo.AddProduct
	@name varchar(50),
	@price int,
	@expDate date,
	@typeID int
AS
BEGIN
	SET NOCOUNT ON;

	 begin tran
		begin try

			if dbo.checkFormatName(@name) = 0
			begin
				RAISERROR('Name is invalid', 14, 1)				
			end

			if dbo.checkFormatNumber(@price) = 0
			begin
				RAISERROR('Price is invalid', 14, 1)				
			end

			if dbo.checkFormatDate(@expDate) = 0
			begin
				RAISERROR('Expiration Date is invalid', 14, 1)				
			end

			if dbo.checkFormatNumber(@typeID) = 0
			begin
				RAISERROR('Type ID is not a number', 14, 1)				
			end 

			insert into Product values(@name, @price, @expDate, @typeID)
			print 'Insert product completed'
			commit tran
			select 'Transaction committed'
		end try

		begin catch
			rollback tran
			select 'Product transaction rollbacked'
			return 1
		end catch
		return 0
	end
