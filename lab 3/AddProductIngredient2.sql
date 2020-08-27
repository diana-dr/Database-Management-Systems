USE BREWERY
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE dbo.AddProductIngredient2
	@name varchar(50),
	@price int,
	@expDate date,
	@typeID int,
	@iname varchar(50),
	@quantity int
AS 
BEGIN
	SET NOCOUNT ON;

	declare @ingredient int
	execute @ingredient = AddIngredient @iname
	if (@ingredient <> 1)
	begin
		declare @product int
		execute @product = AddProduct @name, @price, @expDate, @typeID
		if (@product <> 1)
			execute AddNewEntry @quatity
	end
END