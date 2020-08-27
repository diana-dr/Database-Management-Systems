USE BREWERY
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE dbo.AddIngredient
	@name varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	 begin tran
		begin try

			if dbo.checkFormatName(@name) = 0
			begin
				RAISERROR('Name is invalid', 14, 1)				
			end

			insert into Ingredients values(@name)
			print 'Insert ingredient completed'
			commit tran
			select 'Transaction committed'
		end try

		begin catch
			rollback tran
			select 'Ingredient transaction rollbacked'
			return 1
		end catch
		return 0
	end
END