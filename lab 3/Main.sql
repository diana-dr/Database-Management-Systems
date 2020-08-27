USE BREWERY
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE dbo.main
AS
BEGIN
	SET NOCOUNT ON;

	execute AddProductIngredient 'product1', 10, '2020-10-10', 6, 'ingredient1', 191
	execute AddProductIngredient 'product2', 11, '2020-10-11', 7, 10, 191
	execute AddProductIngredient2 'product5', 14, '20201014', 9, 'ingredient1', '191'
	execute AddProductIngredient2 'product6', 15, '2020-10-15', 10, 'ingredient1', 191

END