USE BREWERY
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE dbo.AddProductIngredient
	@name varchar(50),
	@price int,
	@expDate date,
	@typeID int,
	@iname varchar(50),
	@quantity int
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

			if dbo.checkFormatName(@iname) = 0
			begin
				RAISERROR('Name is invalid', 14, 1)				
			end

			if dbo.checkFormatNumber(@quantity) = 0
			begin
				RAISERROR('Quantity is invalid', 14, 1)				
			end

			insert into Product values (@name, @price, @expDate, @typeID)
			print 'Insert product completed'
			insert into Ingredients values (@iname)
			print 'Insert ingredient completed'
			declare @productID int
			set @productID = (select IDENT_CURRENT('Product'))
			declare @ingredientID int
			set @ingredientID = (select IDENT_CURRENT('Ingredients'))
			insert into product_ingredients values(@productID, @ingredientID, @quantity)
			print 'Insert product ingredient completed'
			commit tran
			select 'Transaction committed'
		end try

		begin catch
			rollback tran
			select 'Ingredient transaction rollbacked'
			print ERROR_MESSAGE()
		end catch
	end