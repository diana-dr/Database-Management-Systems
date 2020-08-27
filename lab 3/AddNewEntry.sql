USE BREWERY
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE dbo.AddNewEntry
	@quantity int
AS
BEGIN

	SET NOCOUNT ON;

    begin tran
		begin try
			if dbo.checkFormatNumber(@quantity) = 0
			begin
				RAISERROR('Quatity is invalid', 14, 1)				
			end

			declare @productID int
			set @productID = (select IDENT_CURRENT('Product'))
			declare @ingredientID int
			set @ingredientID = (select IDENT_CURRENT('Ingredients'))
			insert into product_ingredients values (@productID, @ingredientID, @quantity)
			print 'Insert entry completed'
			commit tran
			select 'Transaction committed'
		end try

		begin catch
			rollback tran
			select 'entry transaction rollbacked'
		end catch
	end