/*
Script created by SQL Compare version 7.1.0 from Red Gate Software Ltd at 4/13/2009 1:00:04 PM
Run this script on (local).bvc5sp4 to make it the same as (local).CommerceMain
Please back up your database before running this script
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
IF EXISTS (SELECT * FROM tempdb..sysobjects WHERE id=OBJECT_ID('tempdb..#tmpErrors')) DROP TABLE #tmpErrors
GO
CREATE TABLE #tmpErrors (Error int)
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
BEGIN TRANSACTION
GO
PRINT N'Altering [dbo].[bvc_ProductAvailableAndActive]'
GO

ALTER FUNCTION [dbo].[bvc_ProductAvailableAndActive] 
(	
	@ProductBvin varchar(36),
	@IgnoreInventory bit = 0
)
RETURNS bit
AS
BEGIN
	DECLARE @Result bit

	DECLARE @status int
	DECLARE @trackInventory int
	DECLARE @quantityAvailableForSale decimal(18, 10)
	DECLARE @outOfStockMode int
	DECLARE @specialProductType int
	DECLARE @children int

	SET @children = (SELECT COUNT(*) FROM bvc_Product WHERE ParentId = @ProductBvin)

	IF @children > 0
	BEGIN				
		SELECT @status = [Status] FROM bvc_Product WHERE Bvin = @ProductBvin		
		IF @status != 0
		BEGIN
			IF 0 = ANY (SELECT TrackInventory FROM bvc_Product WHERE ParentId = @ProductBvin)
			BEGIN
				SET @trackInventory = 0
			END
			ELSE
			BEGIN
				SET @trackInventory = 1
			END
			
			IF @trackInventory = 1
			BEGIN
				SELECT @outOfStockMode = OutOfStockMode, @specialProductType = SpecialProductType FROM bvc_Product WHERE bvin = @ProductBvin
				SELECT @quantityAvailableForSale = SUM(b.QuantityAvailableForSale) FROM bvc_Product AS a LEFT JOIN bvc_ProductInventory AS b ON a.bvin = b.ProductBvin WHERE a.ParentId = @ProductBvin AND b.QuantityAvailableForSale >= 0
			END
		END
	END
	ELSE
	BEGIN
		SELECT @status = a.Status, @trackInventory = a.TrackInventory, @quantityAvailableForSale = b.QuantityAvailableForSale, @outOfStockMode = a.OutOfStockMode, @specialProductType = a.SpecialProductType FROM bvc_Product AS a LEFT JOIN bvc_ProductInventory AS b ON a.bvin = b.ProductBvin WHERE a.bvin = @ProductBvin
	END	

	IF @status = 0 OR @status IS NULL
	BEGIN
		SET @Result = 0
	END
	ELSE
	BEGIN
		--Is this a gift certificate type?
		IF (@specialProductType = 1) OR (@specialProductType = 2)
		BEGIN
			SET @Result = 1
			RETURN @Result
		END

		IF (@IgnoreInventory = 1)
		BEGIN
			SET @Result = 1
		END
		ELSE
		BEGIN
			IF (SELECT SettingValue FROM bvc_WebAppSetting WHERE SettingName = 'DisableInventory') = 1
			BEGIN
				SET @Result = 1
			END
			ELSE
			BEGIN
				IF @trackInventory = 0
				BEGIN
					SET @Result = 1
				END
				ELSE
				BEGIN
					IF @quantityAvailableForSale <= 0
					BEGIN
						--0 = Remove From Store
						--1 = Leave On Store
						--2 = OutOfStock Allow Orders
						--3 = OutOfStock Disallow Orders
						SET @Result = CASE @outOfStockMode
							WHEN 0 THEN 0
							WHEN 1 THEN 1
							WHEN 2 THEN 1
							WHEN 3 THEN 1
						END				
					END
					ELSE IF @quantityAvailableForSale > 0
					BEGIN
						SET @Result = 1
					END
					ELSE IF @quantityAvailableForSale IS NULL
					BEGIN
						SET @Result = 0
					END					
				END
			END		
		END		
	END
	
	RETURN @Result
END
GO





IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
IF EXISTS (SELECT * FROM #tmpErrors) ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT>0 BEGIN
PRINT 'The database update succeeded'
COMMIT TRANSACTION
END
ELSE PRINT 'The database update failed'
GO
DROP TABLE #tmpErrors
GO

