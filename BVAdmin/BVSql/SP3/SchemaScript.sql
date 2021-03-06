/*
Script created by SQL Compare version 6.0.0 from Red Gate Software Ltd at 11/28/2007 5:35:03 PM
Run this script on SQL003.BVC5SP2_ChangeScripts to make it the same as SQL003.BVC5SP3_ChangeScripts
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
PRINT N'Altering [dbo].[bvc_EventLog_SQL_i]'
GO










ALTER PROCEDURE [dbo].[bvc_EventLog_SQL_i]
AS
	
	DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT 
        @ErrorMessage = 'procedure: ' + ERROR_PROCEDURE() + ' line: ' + CAST(ERROR_LINE() AS varchar(8)) + ' ' + ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),		
        @ErrorState = ERROR_STATE();

	IF @ErrorState = 0
	BEGIN
		SET @ErrorState = 1
	END

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );

--	INSERT INTO
--	bvc_EventLog (bvin,EventTime,Source,Message,severity,LastUpdated)
--	VALUES(NewID(),GetDate(),ERROR_PROCEDURE() + ' line:' + CAST(ERROR_LINE() AS varchar(8)),CAST(ERROR_NUMBER() AS varchar(8)) + ' ' + CAST(ERROR_STATE() AS varchar(8)) +
--	' ' + ERROR_MESSAGE(), ERROR_SEVERITY(),GetDate())	

	RETURN

























GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Country]'
GO
ALTER TABLE [dbo].[bvc_Country] ADD
[PostalCodeValidationRegex] [nvarchar] (255) COLLATE Latin1_General_CI_AS NOT NULL CONSTRAINT [DF_bvc_Country_PostalCodeValidationRegex] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Country_All_s]'
GO


ALTER PROCEDURE [dbo].[bvc_Country_All_s]

AS

	BEGIN TRY
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,PostalCodeValidationRegex,LastUpdated
		FROM bvc_Country ORDER BY DisplayName

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Country_ByISOCode_s]'
GO




ALTER PROCEDURE [dbo].[bvc_Country_ByISOCode_s]

@ISOCode nvarchar(50)

AS
	
	BEGIN TRY
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,PostalCodeValidationRegex,LastUpdated
		FROM bvc_Country
		WHERE ISOCode=@ISOCode OR ISOAlpha3=@ISOCode OR ISONumeric=@ISOCode ORDER BY DisplayName

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Country_i]'
GO

ALTER PROCEDURE [dbo].[bvc_Country_i]

@bvin varchar(36),
@CultureCode varchar(36),
@DisplayName nvarchar(100),
@Active int = 1,
@ISOCode nvarchar(2),
@ISOAlpha3 nvarchar(3),
@ISONumeric nvarchar(3),
@PostalCodeValidationRegex nvarchar(255)

AS
	
	BEGIN TRY
		INSERT INTO
		bvc_Country
		(bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,PostalCodeValidationRegex,LastUpdated)
		 VALUES(@bvin,@CultureCode,@DisplayName,@Active,@ISOCode,@ISOAlpha3,@ISONumeric,@PostalCodeValidationRegex,GetDate())

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Country_u]'
GO

ALTER PROCEDURE [dbo].[bvc_Country_u]

@bvin varchar(36),
@CultureCode varchar(36),
@DisplayName nvarchar(100),
@Active int,
@ISOCode nvarchar(2),
@ISOAlpha3 nvarchar(3),
@ISONumeric nvarchar(3),
@PostalCodeValidationRegex nvarchar(255)

AS
	
	BEGIN TRY
		UPDATE bvc_Country 
		SET 
		
		CultureCode=@CultureCode,
		DisplayName=@DisplayName,
		Active=@Active,
		ISOCode=@ISOCode,
		ISOAlpha3=@ISOAlpha3,
		ISONumeric=@ISONumeric,
		PostalCodeValidationRegex=@PostalCodeValidationRegex,
		LastUpdated=GetDate()
		
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] ADD
[ReorderPoint] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_ProductInventory_ReorderPoint] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_ProductInventory] ADD
[QuantityAvailableForSale] AS ([QuantityAvailable]-[QuantityOutOfStockPoint]) PERSISTED,
[ReorderLevel] AS ([QuantityAvailable]-[ReorderPoint]) PERSISTED
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory_All_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInventory_All_s] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT
		bvin, 
		ProductBvin,
		QuantityAvailable,
		QuantityOutOfStockPoint,
		ReorderPoint,
		QuantityReserved,
		Status,		
		LastUpdated 
		FROM bvc_ProductInventory	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory_ByProductId_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInventory_ByProductId_s] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
    
		SELECT
		bvin, 
		ProductBvin,
		QuantityAvailable,
		QuantityOutOfStockPoint,
		ReorderPoint,
		QuantityReserved,
		Status,		
		LastUpdated 
		FROM bvc_ProductInventory
		WHERE ProductBvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory_i]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInventory_i] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36), 
	@ProductBvin varchar(36),	
	@QuantityAvailable decimal(18,10),
	@QuantityOutOfStockPoint decimal(18,10),
	@QuantityReserved decimal(18,10),	
	@Status int,
	@ReorderPoint decimal(18,10)

AS
BEGIN

	BEGIN TRY
		DELETE FROM bvc_ProductInventory WHERE productBvin = @ProductBvin	

		INSERT INTO bvc_ProductInventory
		(
		bvin, 
		ProductBvin,
		QuantityAvailable,
		QuantityOutOfStockPoint,
		QuantityReserved,
		Status,
		ReorderPoint,	
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@ProductBvin,
		@QuantityAvailable,
		@QuantityOutOfStockPoint,
		@QuantityReserved,
		@Status,
		@ReorderPoint,		
		GetDate()
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
    
END
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Reset_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Oct 2007
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Reset_u] 
AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = 0,
		QuantityAvailable= 0,
		[Status] = 0,
		LastUpdated=GetDate()		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_ProductInventory_ResetProduct_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Oct 2007
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_ResetProduct_u] 

	@ProductBvin varchar(36)	

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = 0,
		QuantityAvailable= 0,
		[Status] = 0,
		LastUpdated=GetDate()
		WHERE ProductBvin = @ProductBvin OR ProductBvin IN (SELECT bvin FROM bvc_Product WHERE ParentId = @ProductBvin)		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_OrderPackage]'
GO
ALTER TABLE [dbo].[bvc_OrderPackage] ALTER COLUMN [TimeInTransit] [bigint] NOT NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInventory_s] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		-- Insert statements for procedure here
		SELECT
		bvin, 
		ProductBvin,
		QuantityAvailable,
		QuantityOutOfStockPoint,
		ReorderPoint,
		QuantityReserved,
		Status,		
		LastUpdated 
		FROM bvc_ProductInventory
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ShippingMethod_FindCountries_s]'
GO

ALTER PROCEDURE [dbo].[bvc_ShippingMethod_FindCountries_s]

@bvin varchar(36)

AS
	BEGIN TRY

		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,PostalCodeValidationRegex,LastUpdated
		FROM bvc_Country
		WHERE 

		(bvin NOT IN
		(SELECT CountryBvin FROM bvc_ShippingMethod_CountryRestriction WHERE ShippingMethodBvin=@bvin)
		) 			
		AND Active=1

		ORDER BY DisplayName
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ShippingMethod_FindNotCountries_s]'
GO

ALTER PROCEDURE [dbo].[bvc_ShippingMethod_FindNotCountries_s]

@bvin varchar(36)

AS
	BEGIN TRY

		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,PostalCodeValidationRegex,LastUpdated
		FROM bvc_Country
		WHERE 

		(bvin IN
		(SELECT CountryBvin FROM bvc_ShippingMethod_CountryRestriction WHERE ShippingMethodBvin=@bvin)
		) ORDER BY DisplayName
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInventory_u] 
	@bvin varchar(36), 
	@ProductBvin varchar(36),
	@QuantityAvailable decimal(18,10),
	@QuantityOutOfStockPoint decimal(18,10),
	@QuantityReserved decimal(18,10),	
	@Status int,
	@ReorderPoint decimal(18,10)
AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET
		bvin=@bvin,
		ProductBvin=@ProductBvin,
		QuantityAvailable=@QuantityAvailable,
		QuantityOutOfStockPoint=@QuantityOutOfStockPoint,
		QuantityReserved=@QuantityReserved,
		Status=@Status,
		LastUpdated=GetDate(),
		ReorderPoint=@ReorderPoint
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
		IF (SELECT [Status] FROM bvc_Product WHERE Bvin = @ProductBvin) = 0
		BEGIN
			SET @status = 0
		END
		ELSE IF 1 = ANY (SELECT [Status] FROM bvc_Product WHERE ParentId = @ProductBvin)
		BEGIN
			SET @status = 1
		END
		ELSE
		BEGIN
			SET @status = 0
		END

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
				SELECT @quantityAvailableForSale = SUM(b.QuantityAvailableForSale) FROM bvc_Product AS a LEFT JOIN bvc_ProductInventory AS b ON a.bvin = b.ProductBvin WHERE a.ParentId = @ProductBvin AND b.QuantityAvailableForSale > 0
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
PRINT N'Creating [dbo].[bvc_Product_ByCategoryFiltered_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Product_ByCategoryFiltered_s]

@bvin varchar(36),
@ManufacturerId varchar(36) = null,
@ProductTypeId varchar(36) = null,
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@DisplaySortOrder int = 0

AS
	BEGIN TRY;
			
			WITH products AS (SELECT
			RowNum = 
				CASE 
					WHEN @DisplaySortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 2 THEN ROW_NUMBER() OVER (ORDER BY ProductName)
					WHEN @DisplaySortOrder = 3 THEN ROW_NUMBER() OVER (ORDER BY SitePrice)
					WHEN @DisplaySortOrder = 4 THEN ROW_NUMBER() OVER (ORDER BY SitePrice DESC)					
					WHEN @DisplaySortOrder = 5 THEN ROW_NUMBER() OVER (ORDER BY m.DisplayName, ProductName)
					ELSE ROW_NUMBER() OVER (ORDER BY SortOrder)
				END,			
			p.bvin,
			SKU,
			ProductTypeID,
			ProductName,
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			p.Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,		
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			p.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			px.SortOrder,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			p.OutOfStockMode,
			p.CustomProperties			
			
			FROM bvc_Product p JOIN bvc_ProductXCategory px ON p.bvin = px.ProductID 
			LEFT JOIN bvc_ProductInventory AS bpi ON p.bvin = bpi.ProductBvin			
			LEFT JOIN bvc_Manufacturer AS m ON p.ManufacturerId = m.Bvin			
			WHERE p.ParentID=''
			AND px.CategoryID = @bvin
			AND (@ProductTypeId IS NULL OR (p.ProductTypeId = @ProductTypeId))
			AND (@ManufacturerId IS NULL OR (p.ManufacturerId = @ManufacturerId))
			AND p.Status = 1			
			AND (dbo.bvc_ProductAvailableAndActive(p.bvin, 0) = 1)
			)
			
			SELECT *, (SELECT COUNT(*) FROM products) AS TotalRowCount FROM products WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductType_d]'
GO





ALTER PROCEDURE [dbo].[bvc_ProductType_d]

@bvin as varchar(36)

AS

	BEGIN TRY
		BEGIN TRAN
			UPDATE bvc_Product SET ProductTypeId = '' WHERE ProductTypeId = @bvin
			DELETE FROM bvc_ProductTypeXProductProperty Where ProductTypeBvin=@bvin
			DELETE FROM bvc_ProductType WHERE bvin=@bvin
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN








GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category]'
GO
ALTER TABLE [dbo].[bvc_Category] ADD
[CustomerChangeableSortOrder] [bit] NOT NULL CONSTRAINT [DF_bvc_Category_CustomerChangeableSortOrder] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_Product_IsAvailable_s]'
GO



















CREATE PROCEDURE [dbo].[bvc_Product_IsAvailable_s]

@bvin varchar(36)

AS
	
	BEGIN TRY
		SELECT dbo.bvc_ProductAvailableAndActive(@bvin, 0) AS Available	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	

	RETURN
































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Affiliate_Filter_s]'
GO







ALTER PROCEDURE [dbo].[bvc_Affiliate_Filter_s]

@filter varchar(Max),
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS
	BEGIN TRY;
		IF @filter = '%#DISABLED#%'
		BEGIN;
			WITH Affiliates AS (SELECT 
				ROW_NUMBER() OVER (ORDER BY DisplayName) As RowNum,
				ReferralID, DisplayName,Address,CommissionAmount,
				CommissionType,ReferralDays, TaxID, DriversLicenseNumber,
				WebSiteURL,StyleSheet,bvin, Enabled, Notes, LastUpdated
			FROM bvc_Affiliate 
			WHERE Enabled = 0)

			SELECT *, (SELECT COUNT(*) FROM Affiliates) AS TotalRowCount FROM Affiliates
				WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
				ORDER BY RowNum			
		END
		ELSE
		BEGIN;
			WITH Affiliates AS (SELECT 
				ROW_NUMBER() OVER (ORDER BY DisplayName) As RowNum,
				ReferralID, DisplayName,Address,CommissionAmount,
				CommissionType,ReferralDays, TaxID, DriversLicenseNumber,
				WebSiteURL,StyleSheet,bvin, Enabled, Notes, LastUpdated
			FROM bvc_Affiliate 
			WHERE (ReferralID LIKE @filter) OR 
				(DisplayName LIKE @filter) OR
				(Address LIKE @filter) OR		
				(TaxID LIKE @filter) OR 
				(DriversLicenseNumber LIKE @filter) OR
				(WebSiteURL LIKE @filter))

			SELECT *, (SELECT COUNT(*) FROM Affiliates) AS TotalRowCount FROM Affiliates
				WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
				ORDER BY RowNum
		END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN

















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]'
GO









ALTER PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]

@StartDate datetime = NULL,
@EndDate datetime = NULL

AS
	BEGIN TRY
		SELECT 
		p.bvin,
		p.ProductName,
		SUM(l.Quantity) AS "Total Ordered"	
		FROM
		bvc_LineItem l
		JOIN bvc_Product p ON l.productID = p.bvin
		WHERE 
			l.OrderBvin IN 
			(
			SELECT bvin FROM bvc_Order 
			WHERE
			IsPlaced = 1 AND 			
			(TimeOfOrder >= @StartDate OR @StartDate IS NULL)
			AND			
			(TimeOfOrder <= @EndDate OR @EndDate IS NULL)
			)
		GROUP BY p.bvin, p.ProductName		
		ORDER BY SUM(l.Quantity) DESC
      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ProductsOrderedCount_s]'
GO









ALTER PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_s]

@StartDate datetime = NULL,
@EndDate datetime = NULL,
@MaxRows bigint = 1000
AS
	BEGIN TRY
		SELECT TOP (@MaxRows)
		p.bvin,
		p.ProductName,
		SUM(l.Quantity) AS "Total Ordered"	
		FROM
		bvc_LineItem l
		JOIN bvc_Product p ON l.productID = p.bvin
		WHERE 
			l.OrderBvin IN 
			(
			SELECT bvin FROM bvc_Order 
			WHERE
			IsPlaced = 1 AND
			(TimeOfOrder >= @StartDate OR @StartDate IS NULL)
			AND			
			(TimeOfOrder <= @EndDate OR @EndDate IS NULL)
			)
			AND dbo.bvc_ProductAvailableAndActive(ProductID, 0) = 1
		GROUP BY p.bvin, p.ProductName		
		ORDER BY SUM(l.Quantity) DESC
      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH























GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_Product_StoreSearch_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_StoreSearch_s]

@Keyword1 nvarchar(100) = NULL,
@Keyword2 nvarchar(100) = NULL,
@Keyword3 nvarchar(100) = NULL,
@Keyword4 nvarchar(100) = NULL,
@Keyword5 nvarchar(100) = NULL,
@Keyword6 nvarchar(100) = NULL,
@Keyword7 nvarchar(100) = NULL,
@Keyword8 nvarchar(100) = NULL,
@Keyword9 nvarchar(100) = NULL,
@Keyword10 nvarchar(100) = NULL,
@SortBy int = 0,
@SortOrder int = 0,
@CategoryId varchar(36) = NULL,
@ManufacturerId varchar(36) = NULL,
@VendorId varchar(36) = NULL,
@MinPrice decimal = NULL,
@MaxPrice decimal = NULL,
@Property1 varchar(36) = NULL,
@Property2 varchar(36) = NULL,
@Property3 varchar(36) = NULL,
@Property4 varchar(36) = NULL,
@Property5 varchar(36) = NULL,
@Property6 varchar(36) = NULL,
@Property7 varchar(36) = NULL,
@Property8 varchar(36) = NULL,
@Property9 varchar(36) = NULL,
@Property10 varchar(36) = NULL,
@PropertyValue1 nvarchar(Max) = NULL,
@PropertyValue2 nvarchar(Max) = NULL,
@PropertyValue3 nvarchar(Max) = NULL,
@PropertyValue4 nvarchar(Max) = NULL,
@PropertyValue5 nvarchar(Max) = NULL,
@PropertyValue6 nvarchar(Max) = NULL,
@PropertyValue7 nvarchar(Max) = NULL,
@PropertyValue8 nvarchar(Max) = NULL,
@PropertyValue9 nvarchar(Max) = NULL,
@PropertyValue10 nvarchar(Max) = NULL,
@SearchSKU bit = 1,
@SearchProductName bit = 1,
@SearchMetaDescription bit = 1,
@SearchMetaKeywords bit = 1,
@SearchShortDescription bit = 1,
@SearchLongDescription bit = 1,
@SearchKeywords bit = 1,
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS
	BEGIN TRY					
		DECLARE @SelectStatementSql nvarchar(4000)
		DECLARE @WhereClause nvarchar(4000)		
		DECLARE @Sql nvarchar(4000)

		DECLARE @Queries nvarchar(MAX)
		SET @Queries = N''

		SET @SelectStatementSql = 'SELECT 
			bvc_Product.bvin,
			bvc_Product.SKU,
			bvc_Product.ProductName,			
			bvc_Product.ProductTypeID,			
			bvc_Product.ListPrice,
			bvc_Product.SitePrice,
			bvc_Product.SiteCost,
			bvc_Product.MetaKeywords,
			bvc_Product.MetaDescription,
			bvc_Product.MetaTitle,
			bvc_Product.TaxExempt,
			bvc_Product.TaxClass,
			bvc_Product.NonShipping,
			bvc_Product.ShipSeparately,
			bvc_Product.ShippingMode,
			bvc_Product.ShippingWeight,
			bvc_Product.ShippingLength,
			bvc_Product.ShippingWidth,
			bvc_Product.ShippingHeight,
			bvc_Product.Status,
			bvc_Product.ImageFileSmall,
			bvc_Product.ImageFileMedium,
			bvc_Product.CreationDate,
			bvc_Product.MinimumQty,
			bvc_Product.ParentID,
			bvc_Product.VariantDisplayMode,	
			bvc_Product.ShortDescription,
			bvc_Product.LongDescription,
			bvc_Product.ManufacturerID,
			bvc_Product.VendorID,
			bvc_Product.GiftWrapAllowed,
			bvc_Product.ExtraShipFee,
			bvc_Product.LastUpdated,
			bvc_Product.Keywords,
			bvc_Product.TemplateName,
			bvc_Product.PreContentColumnId,
			bvc_Product.PostContentColumnId,
			bvc_Product.RewriteUrl,
			bvc_Product.SitePriceOverrideText,
			bvc_Product.SpecialProductType,
			bvc_Product.GiftCertificateCodePattern,
			bvc_Product.PreTransformLongDescription,
			bvc_Product.SmallImageAlternateText,
			bvc_Product.MediumImageAlternateText,
			bvc_Product.TrackInventory,
			bvc_Product.OutOfStockMode,
			bvc_Product.CustomProperties FROM bvc_Product '						

		SET @WhereClause = ' WHERE bvc_Product.ParentID = '''' '		
		
		IF @CategoryId IS NOT NULL
		BEGIN
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@CategoryID) '
		END

		IF @ManufacturerId IS NOT NULL
		BEGIN
			SET @WhereClause = @WhereClause + ' AND ManufacturerId = @ManufacturerId '
		END			

		IF @VendorId IS NOT NULL
		BEGIN
			SET @WhereClause = @WhereClause + ' AND VendorId = @VendorId '
		END						

		IF @MinPrice IS NOT NULL
		BEGIN
			SET @WhereClause = @WhereClause + ' AND SitePrice >= @MinPrice '
		END

		IF @MaxPrice IS NOT NULL
		BEGIN
			SET @WhereClause = @WhereClause + ' AND SitePrice <= @MaxPrice '
		END

		IF @Property1 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property1 AND PropertyValue=@PropertyValue1) '
		IF @Property2 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property2 AND PropertyValue=@PropertyValue2) '
		IF @Property3 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property3 AND PropertyValue=@PropertyValue3) '
		IF @Property4 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property4 AND PropertyValue=@PropertyValue4) '
		IF @Property5 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property5 AND PropertyValue=@PropertyValue5) '
		IF @Property6 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property6 AND PropertyValue=@PropertyValue6) '
		IF @Property7 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property7 AND PropertyValue=@PropertyValue7) '
		IF @Property8 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property8 AND PropertyValue=@PropertyValue8) '
		IF @Property9 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property9 AND PropertyValue=@PropertyValue9) '
		IF @Property10 IS NOT NULL
			SET @WhereClause = @WhereClause + ' AND EXISTS (Select * FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property10 AND PropertyValue=@PropertyValue10) '
		
		DECLARE @KeywordsWhereClause nvarchar(1000)

		DECLARE @i int
		SET @i = 1
		WHILE (@i <= 10)
		BEGIN
			DECLARE @Continue bit
			SET @Continue = 0
			
			IF @i = 1 AND @Keyword1 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword1 = '%' + @Keyword1 + '%'				
			END

			IF @i = 2 AND @Keyword2 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword2 = '%' + @Keyword2 + '%'				
			END

			IF @i = 3 AND @Keyword3 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword3 = '%' + @Keyword3 + '%'				
			END

			IF @i = 4 AND @Keyword4 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword4 = '%' + @Keyword4 + '%'				
			END

			IF @i = 5 AND @Keyword5 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword5 = '%' + @Keyword5 + '%'				
			END

			IF @i = 6 AND @Keyword6 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword6 = '%' + @Keyword6 + '%'				
			END

			IF @i = 7 AND @Keyword7 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword7 = '%' + @Keyword7 + '%'				
			END

			IF @i = 8 AND @Keyword8 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword8 = '%' + @Keyword8 + '%'				
			END

			IF @i = 9 AND @Keyword9 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword9 = '%' + @Keyword9 + '%'				
			END

			IF @i = 10 AND @Keyword10 IS NOT NULL
			BEGIN				
				SET @Continue = 1
				SET @Keyword10 = '%' + @Keyword10 + '%'				
			END

			IF @Continue = 1
			BEGIN
				DECLARE @Num nvarchar(2)
				SET @Num = CONVERT(nvarchar, @i)
				SET @KeywordsWhereClause = ' AND ( 1=0 '			
				
				IF @SearchSKU = 1
					SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR SKU LIKE @Keyword' + @Num
				IF @SearchProductName = 1
					SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR ProductName LIKE @Keyword' + @Num
				IF @SearchMetaDescription = 1
					SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR MetaDescription LIKE @Keyword' + @Num
				IF @SearchMetaKeywords = 1
					SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR MetaKeywords LIKE @Keyword' + @Num
				IF @SearchShortDescription = 1
					SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR ShortDescription LIKE @Keyword' + @Num
				IF @SearchLongDescription = 1
					SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR LongDescription LIKE @Keyword' + @Num
				IF @SearchKeywords = 1
					SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR Keywords LIKE @Keyword' + @Num

				SET @KeywordsWhereClause = @KeywordsWhereClause + ')'

				IF @i = 1
					SET @Queries = @SelectStatementSql + @WhereClause + @KeywordsWhereClause
				ELSE
					SET @Queries = @Queries + ' UNION ' + @SelectStatementSql + @WhereClause + @KeywordsWhereClause
			END
			ELSE
			BEGIN
				--all of our continues should be right in a row
				BREAK
			END
			
			SET @i = @i + 1
		END

		SET @Queries = ' WITH cte_ProductSearch AS 
		( ' + @Queries + '),
		cte_ProductResult AS (
			SELECT *, 
			ROW_NUMBER() OVER (ORDER BY '
			
			IF @SortBy = 0
				SET @Queries = @Queries + ' ProductName '
			ELSE IF @SortBy = 1
				SET @Queries = @Queries + ' bvc_Manufacturer.DisplayName '					
			ELSE IF @SortBy = 2
				SET @Queries = @Queries + ' CreationDate '
			ELSE IF @SortBy = 3
				SET @Queries = @Queries + ' SitePrice '
			ELSE IF @SortBy = 4
				SET @Queries = @Queries + ' bvc_Vendor.DisplayName '

			IF @SortOrder = 0
				SET @Queries = @Queries + ' ASC) '
			ELSE
				SET @Queries = @Queries + ' DESC) '

			SET @Queries = @Queries + ' AS RowNum, (SELECT COUNT(*) FROM cte_ProductSearch) As TotalRowCount FROM cte_ProductSearch)
		SELECT * FROM cte_ProductResult '

		IF @SortBy = 1 --Sortying by manufacturer, so we need to JOIN
		BEGIN
			SET @Queries = @Queries + ' JOIN bvc_Manufacturer ON cte_ProductResult.ManufactuerId = bvc_Manufacturer.bvin '
		END
		ELSE IF @SortBy = 4 --Sortying by vendor, so we need to JOIN
		BEGIN
			SET @Queries = @Queries + ' JOIN bvc_Vendor ON cte_ProductResult.VendorId = bvc_Vendor.bvin '
		END

		SET @Queries = @Queries + ' WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)'


		DECLARE @ParameterDefinition nvarchar(4000)
		SET @ParameterDefinition = N'@Keyword1 nvarchar(100),
			@Keyword2 nvarchar(100),
			@Keyword3 nvarchar(100),
			@Keyword4 nvarchar(100),
			@Keyword5 nvarchar(100),
			@Keyword6 nvarchar(100),
			@Keyword7 nvarchar(100),
			@Keyword8 nvarchar(100),
			@Keyword9 nvarchar(100),
			@Keyword10 nvarchar(100),
			@SortBy int,
			@SortOrder int,
			@CategoryId varchar(36),
			@ManufacturerId varchar(36),
			@VendorId varchar(36),
			@MinPrice decimal,
			@MaxPrice decimal,
			@Property1 varchar(36),
			@Property2 varchar(36),
			@Property3 varchar(36),
			@Property4 varchar(36),
			@Property5 varchar(36),
			@Property6 varchar(36),
			@Property7 varchar(36),
			@Property8 varchar(36),
			@Property9 varchar(36),
			@Property10 varchar(36),
			@PropertyValue1 nvarchar(Max),
			@PropertyValue2 nvarchar(Max),
			@PropertyValue3 nvarchar(Max),
			@PropertyValue4 nvarchar(Max),
			@PropertyValue5 nvarchar(Max),
			@PropertyValue6 nvarchar(Max),
			@PropertyValue7 nvarchar(Max),
			@PropertyValue8 nvarchar(Max),
			@PropertyValue9 nvarchar(Max),
			@PropertyValue10 nvarchar(Max),
			@StartRowIndex int = 0,
			@MaximumRows int = 9999999'

		EXEC sp_executesql @Queries, 
			@ParameterDefinition,
			@Keyword1,
			@Keyword2,
			@Keyword3,
			@Keyword4,
			@Keyword5,
			@Keyword6,
			@Keyword7,
			@Keyword8,
			@Keyword9,
			@Keyword10,
			@SortBy,
			@SortOrder,
			@CategoryId,
			@ManufacturerId,
			@VendorId,
			@MinPrice,
			@MaxPrice,
			@Property1,
			@Property2,
			@Property3,
			@Property4,
			@Property5,
			@Property6,
			@Property7,
			@Property8,
			@Property9,
			@Property10,
			@PropertyValue1,
			@PropertyValue2,
			@PropertyValue3,
			@PropertyValue4,
			@PropertyValue5,
			@PropertyValue6,
			@PropertyValue7,
			@PropertyValue8,
			@PropertyValue9,
			@PropertyValue10,
			@StartRowIndex,
			@MaximumRows
			        
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_Sql_i
	END CATCH






GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_SuggestedItems]'
GO
ALTER PROCEDURE [dbo].[bvc_Product_SuggestedItems]

@MaxResults bigint,
@bvin varchar(36)

AS

	BEGIN TRY		
		IF EXISTS(SELECT * FROM bvc_Product WHERE ParentId = @bvin)
		BEGIN
			SELECT TOP(@MaxResults)
				ProductID, SUM(Quantity) AS "Total Ordered"
				FROM bvc_LineItem l
				JOIN bvc_Order o on l.OrderBvin = o.bvin 
				WHERE o.IsPlaced = 1 AND dbo.bvc_ProductAvailableAndActive(ProductID, 0) = 1
				AND	OrderBvin IN
				(SELECT OrderBvin
					FROM bvc_LineItem
					WHERE ProductID IN (SELECT bvin FROM bvc_Product WHERE ParentId = @bvin))
				GROUP BY ProductID
				ORDER BY SUM(Quantity) DESC
		END
		ELSE
		BEGIN
			SELECT TOP(@MaxResults)
				ProductID, SUM(Quantity) AS "Total Ordered"
				FROM bvc_LineItem l
				JOIN bvc_Order o on l.OrderBvin = o.bvin 
				WHERE o.IsPlaced = 1 AND dbo.bvc_ProductAvailableAndActive(ProductID, 0) = 1
				AND	OrderBvin IN
				(SELECT OrderBvin
					FROM bvc_LineItem
					WHERE ProductID = @bvin)
				GROUP BY ProductID
				ORDER BY SUM(Quantity) DESC
		END		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_All_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Category_All_s]

@bvin varchar(36) = '-1',
@StartRowIndex int = 0,
@MaximumRows int = 9999999
AS
	BEGIN TRY

		IF @bvin <> '-1'
		BEGIN
			
			WITH Categories AS (SELECT
			ROW_NUMBER() OVER (ORDER BY SortOrder) As RowNum,
			bvin,
			[Name],
			[Description],
			ParentID,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			LatestProductCount,
			BannerImageURL,
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category
			WHERE ParentID=@bvin)			
					
			SELECT *, (SELECT COUNT(*) FROM Categories) AS TotalRowCount FROM Categories WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum

									
		END
		ELSE
		BEGIN
			WITH Categories AS (SELECT
			ROW_NUMBER() OVER (ORDER BY SortOrder) As RowNum,
			bvin,
			[Name],
			[Description],
			ParentID,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			LatestProductCount,
			BannerImageURL,
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category)
			
			SELECT *, (SELECT COUNT(*) FROM Categories) AS TotalRowCount FROM Categories WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum			
		END

		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_AllVisible_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Category_AllVisible_s]

@bvin varchar(36) = '-1',
@StartRowIndex int = 1,
@MaximumRows int = 9999999
AS
	BEGIN TRY

		IF @bvin <> '-1'
		BEGIN
			
			WITH Categories AS (SELECT
			ROW_NUMBER() OVER (ORDER BY SortOrder) As RowNum,
			bvin,
			[Name],
			[Description],
			ParentID,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			LatestProductCount,
			BannerImageURL,
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category
			WHERE ParentID=@bvin And Hidden = 0)
					
			SELECT *, (SELECT COUNT(*) FROM Categories) AS TotalRowCount FROM Categories WHERE RowNum BETWEEN @StartRowIndex and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum

									
		END
		ELSE
		BEGIN
			WITH Categories AS (SELECT
			ROW_NUMBER() OVER (ORDER BY SortOrder) As RowNum,
			bvin,
			[Name],
			[Description],
			ParentID,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			LatestProductCount,
			BannerImageURL,
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category
			WHERE Hidden = 0)
			
			SELECT *, (SELECT COUNT(*) FROM Categories) AS TotalRowCount FROM Categories WHERE RowNum BETWEEN @StartRowIndex and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum			
		END

		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_ByType_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Category_ByType_s]

@type int

AS
	BEGIN TRY
		SELECT
		bvin,
		[Name],
		[Description],
		ParentID,
		SortOrder,
		MetaKeywords,
		MetaDescription,
		ImageURL,
		SourceType,
		DisplaySortOrder,
		MetaTitle,
		LatestProductCount,
		BannerImageURL,
		CustomPageURL,
		CustomPageNewWindow,
		MenuOffImageURL,
		MenuOnImageURL,
		ShowInTopMenu,
		Hidden,
		LastUpdated,
		TemplateName,
		PostContentColumnId,
		PreContentColumnId,
		RewriteUrl,
		ShowTitle,
		Criteria,
		CustomPageId,
		PreTransformDescription,
		Keywords,
		CustomerChangeableSortOrder

		 FROM bvc_Category
		WHERE SourceType = @type
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_ForMenu_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Category_ForMenu_s]

AS
	BEGIN TRY
		SELECT

		bvin,
		[Name],
		[Description],
		ParentID,
		SortOrder,
		MetaKeywords,
		MetaDescription,
		ImageURL,
		SourceType,
		DisplaySortOrder,
		MetaTitle,
		LatestProductCount,
		BannerImageURL,
		CustomPageURL,
		CustomPageNewWindow,
		MenuOffImageURL,
		MenuOnImageURL,
		ShowInTopMenu,
		Hidden,
		LastUpdated,
		TemplateName,
		PostContentColumnId,
		PreContentColumnId,
		RewriteUrl,
		ShowTitle,
		Criteria,
		CustomPageId,
		PreTransformDescription,
		Keywords,
		CustomerChangeableSortOrder

		FROM bvc_Category
		WHERE ParentID = '0' AND Hidden = 0 AND ShowInTopMenu = 1
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_i]'
GO
ALTER PROCEDURE [dbo].[bvc_Category_i]

@bvin varchar(36),
@Name nvarchar(255),
@Description ntext,
@ParentID varchar(36),
@SortOrder int,
@MetaTitle nvarchar(512),
@MetaKeywords nvarchar(255),
@MetaDescription nvarchar(255),
@ImageURL nvarchar(512),
@BannerImageURL nvarchar(512),
@SourceType int,
@DisplaySortOrder int,
@LatestProductCount int,
@CustomPageURL nvarchar(1000),
@CustomPageNewWindow int,
@MenuOffImageURL nvarchar(1000),
@MenuOnImageURL nvarchar(1000),
@ShowInTopMenu int,
@Hidden int,
@TemplateName nvarchar(512),
@PostContentColumnId varchar(36),
@PreContentColumnId varchar(36),
@RewriteUrl nvarchar(Max),
@ShowTitle int,
@Criteria nvarchar(Max),
@CustomPageId varchar(36),
@PreTransformDescription ntext,
@Keywords nvarchar(Max),
@CustomerChangeableSortOrder bit

AS

	BEGIN TRY
	
		IF (SELECT Count(bvin) FROM bvc_Category WHERE ParentID=@ParentID) > 0
			BEGIN
				SET @SortOrder = (SELECT
				Max(SortOrder)
				FROM bvc_Category
				WHERE ParentID=@ParentID)+1
			END
		ELSE
			BEGIN
				SET @SortOrder = 1
			END

		INSERT INTO
		bvc_Category
		(
		bvin,
		[Name],
		[Description],
		ParentID,
		SortOrder,
		MetaTitle,
		MetaKeywords,
		MetaDescription,
		ImageURL,
		BannerImageURL,
		SourceType,
		DisplaySortOrder,
		LatestProductCount,
		CustomPageURL,
		CustomPageNewWindow,
		MenuOffImageURL,
		MenuOnImageURL,
		ShowInTopMenu,
		Hidden,
		LastUpdated,
		TemplateName,
		PostContentColumnId,
		PreContentColumnId,
		RewriteUrl,
		ShowTitle,
		Criteria,
		CustomPageId,
		PreTransformDescription,
		Keywords,
		CustomerChangeableSortOrder
		)
		VALUES
		(
		@bvin,
		@Name,
		@Description,
		@ParentID,
		@SortOrder,
		@MetaTitle,
		@MetaKeywords,
		@MetaDescription,
		@ImageURL,
		@BannerImageURL,
		@SourceType,
		@DisplaySortOrder,
		@LatestProductCount,
		@CustomPageURL,
		@CustomPageNewWindow,
		@MenuOffImageURL,
		@MenuOnImageURL,
		@ShowInTopMenu,
		@Hidden,
		GetDate(),
		@TemplateName,
		@PostContentColumnId,
		@PreContentColumnId,
		@RewriteUrl,
		@ShowTitle,
		@Criteria,
		@CustomPageId,
		@PreTransformDescription,
		@Keywords,
		@CustomerChangeableSortOrder
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_Neighbors_s]'
GO
ALTER  PROCEDURE [dbo].[bvc_Category_Neighbors_s]
@bvin varchar(36)

AS

	BEGIN TRY
			DECLARE @parentId as varchar(36)
			SET @parentId = (Select ParentId FROM bvc_Category WHERE bvin=@bvin)
			Print @parentId

			SELECT 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category
			WHERE parentId IN (SELECT ParentID FROM bvc_Category WHERE bvin=@parentId)
			ORDER BY SortOrder


		IF @bvin = '0'
		   BEGIN
			/* Select Peers */
			SELECT 
		[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category WHERE ParentID=@bvin ORDER BY SortOrder

			/* Select Children */
			SELECT TOP 0 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category WHERE ParentID='-1' ORDER BY SortOrder

		   END
		ELSE
		   BEGIN
			/* Select Peers */
			SELECT 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category
			WHERE ParentID=(Select ParentID FROM bvc_Category WHERE bvin=@bvin)
			ORDER BY SortOrder

			/* Select Children */
			SELECT 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category WHERE ParentID=@bvin ORDER BY SortOrder
			END

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Category_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		[Name],
		[Description],
		bvin,
		ParentID,
		/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
		ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
		WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
		(SELECT '0') as ItemCount,
		SortOrder,
		MetaKeywords,
		MetaDescription,
		ImageURL,
		SourceType,
		DisplaySortOrder,
		MetaTitle,
		BannerImageURL,
		LatestProductCount,	
		CustomPageURL,
		CustomPageNewWindow,
		MenuOffImageURL,
		MenuOnImageURL,	
		ShowInTopMenu,
		Hidden,
		LastUpdated,
		TemplateName,
		PostContentColumnId,
		PreContentColumnId,
		RewriteUrl,
		ShowTitle,
		Criteria,
		CustomPageId,
		PreTransformDescription,
		Keywords,
		CustomerChangeableSortOrder

		FROM
		bvc_Category
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_u]'
GO
ALTER PROCEDURE [dbo].[bvc_Category_u]

@bvin varchar(36),
@Name nvarchar(255),
@Description ntext,
@ParentID varchar(36),
@SortOrder int,
@MetaTitle nvarchar(512),
@MetaKeywords nvarchar(255),
@MetaDescription nvarchar(255),
@ImageURL nvarchar(512),
@BannerImageURL nvarchar(512),
@SourceType int,
@DisplaySortOrder int,
@LatestProductCount int,
@CustomPageURL nvarchar(1000),
@CustomPageNewWindow int,
@MenuOffImageURL nvarchar(1000),
@MenuOnImageURL nvarchar(1000),
@ShowInTopMenu int,
@Hidden int,
@TemplateName nvarchar(512),
@PostContentColumnId varchar(36),
@PreContentColumnId varchar(36),
@RewriteUrl nvarchar(Max),
@ShowTitle int,
@Criteria nvarchar(Max),
@CustomPageId nvarchar(36),
@PreTransformDescription ntext,
@Keywords nvarchar(Max),
@CustomerChangeableSortOrder bit

AS
	BEGIN TRY
		UPDATE
		bvc_Category
		SET
		[Name]=@Name,
		[Description]=@Description,
		ParentID=@ParentID,
		SortOrder=@SortOrder,
		MetaKeywords=@MetaKeywords,
		MetaDescription=@MetaDescription,
		ImageURL=@ImageURL,
		BannerImageURL=@BannerImageURL,
		SourceType=@SourceType,
		DisplaySortOrder=@DisplaySortOrder,
		MetaTitle=@MetaTitle,
		LatestProductCount=@LatestProductCount,
		CustomPageURL=@CustomPageURL,
		CustomPageNewWindow=@CustomPageNewWindow,
		MenuOffImageURL=@MenuOffImageURL,
		MenuOnImageURL=@MenuOnImageURL,
		ShowInTopMenu=@ShowInTopMenu,
		Hidden=@Hidden,
		LastUpdated=GetDate(),
		TemplateName=@TemplateName,
		PostContentColumnId=@PostContentColumnId,
		PreContentColumnId=@PreContentColumnId,
		RewriteUrl=@RewriteUrl,
		ShowTitle=@ShowTitle,
		Criteria=@Criteria,
		CustomPageId=@CustomPageId,
		PreTransformDescription=@PreTransformDescription,
		Keywords=@Keywords,
		CustomerChangeableSortOrder=@CustomerChangeableSortOrder

		 WHERE
		 bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category_VisibleNeighbors_s]'
GO
ALTER  PROCEDURE [dbo].[bvc_Category_VisibleNeighbors_s]
@bvin varchar(36)

AS

	BEGIN TRY
			DECLARE @parentId as varchar(36)
			SET @parentId = (Select ParentId FROM bvc_Category WHERE bvin=@bvin)
			Print @parentId

			SELECT 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category
			WHERE parentId IN (SELECT ParentID FROM bvc_Category WHERE bvin=@parentId) ANd Hidden = 0
			ORDER BY SortOrder


		IF @bvin = '0'
		   BEGIN
			/* Select Peers */
			SELECT 
		[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category WHERE ParentID=@bvin ORDER BY SortOrder

			/* Select Children */
			SELECT TOP 0 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category WHERE ParentID='-1' ORDER BY SortOrder

		   END
		ELSE
		   BEGIN
			/* Select Peers */
			SELECT 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category
			WHERE ParentID=(Select ParentID FROM bvc_Category WHERE bvin=@bvin)
			ORDER BY SortOrder

			/* Select Children */
			SELECT 
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) as ItemCount*/
			(SELECT '0') as ItemCount,
			SortOrder,
			MetaKeywords,
			MetaDescription,
			ImageURL,
			SourceType,
			DisplaySortOrder,
			MetaTitle,
			BannerImageURL,
			LatestProductCount,	
			CustomPageURL,
			CustomPageNewWindow,
			MenuOffImageURL,
			MenuOnImageURL,	
			ShowInTopMenu,
			Hidden,
			LastUpdated,
			TemplateName,
			PostContentColumnId,
			PreContentColumnId,
			RewriteUrl,
			ShowTitle,
			Criteria,
			CustomPageId,
			PreTransformDescription,
			Keywords,
			CustomerChangeableSortOrder
			FROM bvc_Category WHERE ParentID=@bvin ORDER BY SortOrder
			END

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Country_Active_s]'
GO


ALTER PROCEDURE [dbo].[bvc_Country_Active_s]

AS

	BEGIN TRY
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,PostalCodeValidationRegex,LastUpdated 
		FROM bvc_Country WHERE Active=1 
		ORDER BY DisplayName

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Country_s]'
GO




ALTER PROCEDURE [dbo].[bvc_Country_s]

@bvin varchar(36)

AS
	
	BEGIN TRY
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,PostalCodeValidationRegex,LastUpdated
		FROM bvc_Country
		WHERE bvin=@bvin ORDER BY DisplayName

		/* Select Regions for Country Too */
		exec bvc_Region_ByCountry_s @bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory_UpdateParent_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInventory_UpdateParent_u] 

	@ProductBvin varchar(36)

AS
BEGIN
	
	BEGIN TRY
		DECLARE @ParentBvin varchar(36)
		SET @ParentBvin = (SELECT ParentID FROM bvc_Product WHERE bvin=@ProductBVIN)

		IF @ParentBvin <> '' 
			BEGIN
								
				DECLARE @Available decimal(18,10)
				DECLARE @Reserved decimal(18,10)
				DECLARE @Status int
				DECLARE @OutOfStockMode int
								
				SET @Available = (SELECT SUM(QuantityAvailableForSale) FROM bvc_ProductInventory WHERE ProductBvin IN (SELECT bvin FROM bvc_Product WHERE ParentId=@ParentBvin))
				SET @Reserved = (SELECT SUM(QuantityReserved) FROM bvc_ProductInventory WHERE ProductBvin IN (SELECT bvin FROM bvc_Product WHERE ParentId=@ParentBvin))

				-- Set Out of Stock Mode to Parent Selection --
				SET @OutOfStockMode = (SELECT OutOfStockMode FROM bvc_Product WHERE Bvin = @ParentBvin)

				IF @Available > @Reserved 
					SET @Status = 1
				ELSE
					BEGIN
						--remove from store
						IF (@OutOfStockMode = 0)						
							SET @Status = 0
						--leave on store
						ELSE IF (@OutOfStockMode = 1)
							SET @Status = 1
						--out of stock allow orders
						ELSE IF (@OutOfStockMode = 2)
							SET @Status = 1
						--out of stock disallow orders
						ELSE IF (@OutOfStockMode = 3)
							SET @Status = 0
					END

				UPDATE bvc_ProductInventory
				SET 
				QuantityAvailable=@Available,
				QuantityReserved=@Reserved,
				QuantityOutOfStockPoint = 0,
				Status=@Status
				WHERE ProductBvin=@ParentBvin
				
			END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END


















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInventory_AllLowStock_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInventory_AllLowStock_s] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT
		a.bvin, 
		a.ProductBvin,
		a.QuantityAvailable,
		a.QuantityOutOfStockPoint,
		a.ReorderPoint,
		a.QuantityReserved,
		a.Status,		
		a.LastUpdated 
		FROM bvc_ProductInventory AS a JOIN bvc_Product AS b ON a.ProductBvin = b.bvin
		WHERE a.ReorderLevel <= 0 AND b.TrackInventory = 1
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_EventLog_i]'
GO







ALTER PROCEDURE [dbo].[bvc_EventLog_i]
@bvin varchar(36),
@EventTime datetime,
@Source nvarchar(250),
@Message nvarchar(max),
@Severity int
AS
	BEGIN TRY
		INSERT INTO
		bvc_EventLog (bvin,EventTime,Source,Message,severity,LastUpdated)
		VALUES(@bvin,@EventTime,@Source,@Message,@Severity,GetDate())

		exec bvc_EventLog_Limit_d

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ByCategory_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Product_ByCategory_s]

@bvin varchar(36),
@ignoreInventory bit = 0,
@showInactive bit = 1,
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@DisplaySortOrder int = 0

AS
	BEGIN TRY;
			
			WITH products AS (SELECT
			RowNum = 
				CASE 
					WHEN @DisplaySortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 2 THEN ROW_NUMBER() OVER (ORDER BY ProductName)
					WHEN @DisplaySortOrder = 3 THEN ROW_NUMBER() OVER (ORDER BY SitePrice)
					WHEN @DisplaySortOrder = 4 THEN ROW_NUMBER() OVER (ORDER BY SitePrice DESC)					
					WHEN @DisplaySortOrder = 5 THEN ROW_NUMBER() OVER (ORDER BY m.DisplayName, ProductName)
					ELSE ROW_NUMBER() OVER (ORDER BY SortOrder)
				END,			
			p.bvin,
			SKU,
			ProductTypeID,
			ProductName,
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			p.Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,		
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			p.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			px.SortOrder,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			p.OutOfStockMode,
			p.CustomProperties			
			
			FROM bvc_Product p JOIN bvc_ProductXCategory px ON p.bvin = px.ProductID 
			LEFT JOIN bvc_ProductInventory AS bpi ON p.bvin = bpi.ProductBvin			
			LEFT JOIN bvc_Manufacturer AS m ON p.ManufacturerId = m.Bvin
			WHERE p.ParentID=''
			AND px.CategoryID = @bvin			
			AND ((@showInactive = 1) OR (dbo.bvc_ProductAvailableAndActive(p.bvin, @ignoreInventory) = 1)))
			
			SELECT *, (SELECT COUNT(*) FROM products) AS TotalRowCount FROM products WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_GiftCertificate_All_s]'
GO






ALTER PROCEDURE [dbo].[bvc_GiftCertificate_All_s]
@StartRowIndex int = 0,
@MaximumRows int = 9999999
AS
	BEGIN TRY;
		WITH GiftCertificates AS 
		(SELECT
		ROW_NUMBER() OVER (ORDER BY DateIssued DESC) As RowNum, 
		bvin,
		LineItemId,
		CertificateCode,
		DateIssued,
		OriginalAmount,
		CurrentAmount,
		AssociatedProductId,
		LastUpdated
		FROM bvc_GiftCertificate)
		SELECT *, (SELECT COUNT(*) FROM GiftCertificates) AS TotalRowCount FROM GiftCertificates
		WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
		ORDER BY RowNum
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ByCriteria_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_ByCriteria_s]

@Keyword nvarchar(Max) = NULL,
@ManufacturerId varchar(36) = NULL,
@VendorId varchar(36) = NULL,
@ParentId varchar(36) = NULL,
@Status int = NULL,
@InventoryStatus int = NULL,
@ProductTypeId varchar(36) = NULL,
@CategoryId varchar(36) = NULL,
@MinPrice decimal = NULL,
@MaxPrice decimal = NULL,
@CreatedAfter datetime = NULL,
@NotCategoryId varchar(36) = NULL,
@SortBy int = 0,
@SortOrder int = 0,
@LastXItems int = 9999999,
@SharedChoicesXml xml = NULL,
@SpecialProductTypeOne int = NULL,
@SpecialProductTypeTwo int = NULL,
@Property1 varchar(36) = NULL,
@Property2 varchar(36) = NULL,
@Property3 varchar(36) = NULL,
@Property4 varchar(36) = NULL,
@Property5 varchar(36) = NULL,
@Property6 varchar(36) = NULL,
@Property7 varchar(36) = NULL,
@Property8 varchar(36) = NULL,
@Property9 varchar(36) = NULL,
@Property10 varchar(36) = NULL,
@PropertyValue1 nvarchar(Max) = NULL,
@PropertyValue2 nvarchar(Max) = NULL,
@PropertyValue3 nvarchar(Max) = NULL,
@PropertyValue4 nvarchar(Max) = NULL,
@PropertyValue5 nvarchar(Max) = NULL,
@PropertyValue6 nvarchar(Max) = NULL,
@PropertyValue7 nvarchar(Max) = NULL,
@PropertyValue8 nvarchar(Max) = NULL,
@PropertyValue9 nvarchar(Max) = NULL,
@PropertyValue10 nvarchar(Max) = NULL,
@StartRowIndex int = 0,
@MaximumRows int = 9999999,
@DisplayInactive bit

AS
	BEGIN TRY			
		IF @SortBy = 0
		BEGIN			
			WITH cte_Product AS 
			(SELECT
			RowNum = 
				CASE 
					WHEN @SortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY ProductName ASC)
					WHEN @SortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY ProductName DESC)
				END,			
			RANK() OVER (ORDER BY id DESC) AS rank, 	
			bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties
			FROM bvc_Product 	
			WHERE
				(	@Keyword IS NULL OR
					SKU like @Keyword OR 
					ProductName LIKE @Keyword OR
					MetaDescription LIKE @Keyword OR
					MetaKeywords LIKE @Keyword OR
					ShortDescription LIKE @Keyword OR
					LongDescription LIKE @Keyword OR
					Keywords LIKE @Keyword)
				AND
				(@ManufacturerId IS NULL OR ManufacturerID=@ManufacturerId)
				AND
				(@VendorId IS NULL OR VendorId = @VendorId)
				AND
				(@ParentId IS NULL OR ParentId = @ParentId)
				AND
				(@Status IS NULL OR Status = @Status)
				AND
				((@InventoryStatus IS NULL) OR (TrackInventory = 0 AND @InventoryStatus = 1) OR (TrackInventory = 1 AND EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)) OR (TrackInventory = 1 AND @InventoryStatus = 0 AND NOT EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)))
				AND
				(@ProductTypeId IS NULL OR ProductTypeId = @ProductTypeId)
				AND
				(@CategoryId IS NULL OR EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@CategoryID))
				AND
				(@NotCategoryId IS NULL OR NOT EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@NotCategoryID))
				AND
				(@MinPrice IS NULL OR SitePrice >= @MinPrice)
				AND
				(@MaxPrice IS NULL OR SitePrice <= @MaxPrice)
				AND
				(@CreatedAfter IS NULL OR CreationDate >= @CreatedAfter)
				AND
				(@SpecialProductTypeOne IS NULL OR SpecialProductType = @SpecialProductTypeOne OR SpecialProductType = @SpecialProductTypeTwo)
				/* Property Code */
				AND
				(@Property1 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property1 AND PropertyValue=@PropertyValue1))
				AND
				(@Property2 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property2 AND PropertyValue=@PropertyValue2))
				AND
				(@Property3 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property3 AND PropertyValue=@PropertyValue3))
				AND
				(@Property4 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property4 AND PropertyValue=@PropertyValue4))
				AND
				(@Property5 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property5 AND PropertyValue=@PropertyValue5))
				AND
				(@Property6 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property6 AND PropertyValue=@PropertyValue6))
				AND
				(@Property7 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property7 AND PropertyValue=@PropertyValue7))
				AND
				(@Property8 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property8 AND PropertyValue=@PropertyValue8))
				AND
				(@Property9 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property9 AND PropertyValue=@PropertyValue9))
				AND
				(@Property10 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property10 AND PropertyValue=@PropertyValue10))
				AND
				(@DisplayInactive = 1 OR Status = 1))

			SELECT DISTINCT rownum,
			products.bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			products.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory, 
			OutOfStockMode,
			CustomProperties, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId
			WHERE Rank <= @LastXItems AND 
				((bvc_ProductChoiceCombinations.ChoiceId IN 
				(SELECT T.c.value('ProductChoiceId[1]', 'VARCHAR(36)') As ChoiceId				
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL) AND
				((bvc_ProductChoiceCombinations.ChoiceOptionId IN 
				(SELECT T.c.value('ChoiceOptionId[1]', 'VARCHAR(36)') As ChoiceOptionId
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL)
				AND RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		END
		ELSE IF @SortBy = 1
		BEGIN
			WITH cte_Product AS
			(SELECT
			RowNum = 
				CASE 
					WHEN @SortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY bvc_Manufacturer.DisplayName ASC, ProductName ASC)
					WHEN @SortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY bvc_Manufacturer.DisplayName DESC, ProductName ASC)
				END,
			RANK() OVER (ORDER BY id DESC) AS rank, 	 	
			bvc_Product.bvin,
			bvc_Product.SKU,
			bvc_Product.ProductName,
			bvc_Product.ProductTypeID,			
			bvc_Product.ListPrice,
			bvc_Product.SitePrice,
			bvc_Product.SiteCost,
			bvc_Product.MetaKeywords,
			bvc_Product.MetaDescription,
			bvc_Product.MetaTitle,
			bvc_Product.TaxExempt,
			bvc_Product.TaxClass,
			bvc_Product.NonShipping,
			bvc_Product.ShipSeparately,
			bvc_Product.ShippingMode,
			bvc_Product.ShippingWeight,
			bvc_Product.ShippingLength,
			bvc_Product.ShippingWidth,
			bvc_Product.ShippingHeight,
			bvc_Product.Status,
			bvc_Product.ImageFileSmall,
			bvc_Product.ImageFileMedium,
			bvc_Product.CreationDate,
			bvc_Product.MinimumQty,
			bvc_Product.ParentID,
			bvc_Product.VariantDisplayMode,	
			bvc_Product.ShortDescription,
			bvc_Product.LongDescription,
			bvc_Product.ManufacturerID,
			bvc_Product.VendorID,
			bvc_Product.GiftWrapAllowed,
			bvc_Product.ExtraShipFee,
			bvc_Product.LastUpdated,
			bvc_Product.Keywords,
			bvc_Product.TemplateName,
			bvc_Product.PreContentColumnId,
			bvc_Product.PostContentColumnId,
			bvc_Product.RewriteUrl,
			bvc_Product.SitePriceOverrideText,
			bvc_Product.SpecialProductType,
			bvc_Product.GiftCertificateCodePattern,
			bvc_Product.PreTransformLongDescription,
			bvc_Product.SmallImageAlternateText,
			bvc_Product.MediumImageAlternateText,
			bvc_Product.TrackInventory,
			bvc_Product.OutOfStockMode,
			bvc_Product.CustomProperties
			FROM bvc_Product
			JOIN bvc_Manufacturer ON bvc_Product.ManufacturerId = bvc_Manufacturer.bvin 	
			WHERE
				(	@Keyword IS NULL OR
					SKU like @Keyword OR 
					ProductName LIKE @Keyword OR
					MetaDescription LIKE @Keyword OR
					MetaKeywords LIKE @Keyword OR
					ShortDescription LIKE @Keyword OR
					LongDescription LIKE @Keyword OR
					Keywords LIKE @Keyword)
				AND
				(@ManufacturerId IS NULL OR ManufacturerID=@ManufacturerId)
				AND
				(@VendorId IS NULL OR VendorId = @VendorId)
				AND
				(@ParentId IS NULL OR ParentId = @ParentId)
				AND
				(@Status IS NULL OR Status = @Status)
				AND
				((@InventoryStatus IS NULL) OR (TrackInventory = 0 AND @InventoryStatus = 1) OR (TrackInventory = 1 AND EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)) OR (TrackInventory = 1 AND @InventoryStatus = 0 AND NOT EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)))
				AND
				(@ProductTypeId IS NULL OR ProductTypeId = @ProductTypeId)
				AND
				(@CategoryId IS NULL OR EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvc_Product.bvin AND CategoryId=@CategoryID))
				AND
				(@NotCategoryId IS NULL OR NOT EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvc_Product.bvin AND CategoryId=@NotCategoryID))
				AND
				(@MinPrice IS NULL OR SitePrice >= @MinPrice)
				AND
				(@MaxPrice IS NULL OR SitePrice <= @MaxPrice)
				AND
				(@CreatedAfter IS NULL OR CreationDate >= @CreatedAfter)
				AND
				(@SpecialProductTypeOne IS NULL OR SpecialProductType = @SpecialProductTypeOne OR SpecialProductType = @SpecialProductTypeTwo)
				/* Property Code */				
				AND
				(@Property1 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property1 AND PropertyValue=@PropertyValue1))
				AND
				(@Property2 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property2 AND PropertyValue=@PropertyValue2))
				AND
				(@Property3 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property3 AND PropertyValue=@PropertyValue3))
				AND
				(@Property4 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property4 AND PropertyValue=@PropertyValue4))
				AND
				(@Property5 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property5 AND PropertyValue=@PropertyValue5))
				AND
				(@Property6 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property6 AND PropertyValue=@PropertyValue6))
				AND
				(@Property7 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property7 AND PropertyValue=@PropertyValue7))
				AND
				(@Property8 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property8 AND PropertyValue=@PropertyValue8))
				AND
				(@Property9 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property9 AND PropertyValue=@PropertyValue9))
				AND
				(@Property10 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property10 AND PropertyValue=@PropertyValue10))
				AND
				(@DisplayInactive = 1 OR Status = 1))				


			SELECT DISTINCT rownum,
			products.bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			products.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory, 
			OutOfStockMode,
			CustomProperties, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
			WHERE Rank <= @LastXItems AND 
				((bvc_ProductChoiceCombinations.ChoiceId IN 
				(SELECT T.c.value('ProductChoiceId[1]', 'VARCHAR(36)') As ChoiceId				
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL) AND
				((bvc_ProductChoiceCombinations.ChoiceOptionId IN 
				(SELECT T.c.value('ChoiceOptionId[1]', 'VARCHAR(36)') As ChoiceOptionId
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL)
				AND RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		END
		ELSE IF @SortBy = 2
		BEGIN
			WITH cte_Product AS 
			(SELECT 
			RowNum = 
				CASE 
					WHEN @SortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY CreationDate ASC, ProductName ASC)
					WHEN @SortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY CreationDate DESC, ProductName ASC)
				END,
			RANK() OVER (ORDER BY id DESC) AS rank,
			bvin,
			SKU,
			ProductName,
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties
			FROM bvc_Product 	
			WHERE
				(	@Keyword IS NULL OR
					SKU like @Keyword OR 
					ProductName LIKE @Keyword OR
					MetaDescription LIKE @Keyword OR
					MetaKeywords LIKE @Keyword OR
					ShortDescription LIKE @Keyword OR
					LongDescription LIKE @Keyword OR
					Keywords LIKE @Keyword)
				AND
				(@ManufacturerId IS NULL OR ManufacturerID=@ManufacturerId)
				AND
				(@VendorId IS NULL OR VendorId = @VendorId)
				AND
				(@ParentId IS NULL OR ParentId = @ParentId)
				AND
				(@Status IS NULL OR Status = @Status)
				AND
				((@InventoryStatus IS NULL) OR (TrackInventory = 0 AND @InventoryStatus = 1) OR (TrackInventory = 1 AND EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)) OR (TrackInventory = 1 AND @InventoryStatus = 0 AND NOT EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)))
				AND
				(@ProductTypeId IS NULL OR ProductTypeId = @ProductTypeId)
				AND
				(@CategoryId IS NULL OR EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@CategoryID))
				AND
				(@NotCategoryId IS NULL OR NOT EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@NotCategoryID))
				AND
				(@MinPrice IS NULL OR SitePrice >= @MinPrice)
				AND
				(@MaxPrice IS NULL OR SitePrice <= @MaxPrice)
				AND
				(@CreatedAfter IS NULL OR CreationDate >= @CreatedAfter)
				AND
				(@SpecialProductTypeOne IS NULL OR SpecialProductType = @SpecialProductTypeOne OR SpecialProductType = @SpecialProductTypeTwo)
				/* Property Code */
				AND
				(@Property1 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property1 AND PropertyValue=@PropertyValue1))
				AND
				(@Property2 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property2 AND PropertyValue=@PropertyValue2))
				AND
				(@Property3 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property3 AND PropertyValue=@PropertyValue3))
				AND
				(@Property4 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property4 AND PropertyValue=@PropertyValue4))
				AND
				(@Property5 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property5 AND PropertyValue=@PropertyValue5))
				AND
				(@Property6 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property6 AND PropertyValue=@PropertyValue6))
				AND
				(@Property7 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property7 AND PropertyValue=@PropertyValue7))
				AND
				(@Property8 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property8 AND PropertyValue=@PropertyValue8))
				AND
				(@Property9 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property9 AND PropertyValue=@PropertyValue9))
				AND
				(@Property10 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property10 AND PropertyValue=@PropertyValue10))
				AND
				(@DisplayInactive = 1 OR Status = 1))
				
			SELECT DISTINCT rownum,
			products.bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			products.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
			WHERE Rank <= @LastXItems AND 
				((bvc_ProductChoiceCombinations.ChoiceId IN 
				(SELECT T.c.value('ProductChoiceId[1]', 'VARCHAR(36)') As ChoiceId				
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL) AND
				((bvc_ProductChoiceCombinations.ChoiceOptionId IN 
				(SELECT T.c.value('ChoiceOptionId[1]', 'VARCHAR(36)') As ChoiceOptionId
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL)
				AND RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		END
		ELSE IF @SortBy = 3
		BEGIN
			WITH cte_Product AS
			(SELECT
			RowNum = 
				CASE 
					WHEN @SortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY SitePrice ASC, ProductName ASC)
					WHEN @SortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY SitePrice DESC, ProductName ASC)
				END,
			RANK() OVER (ORDER BY id DESC) AS rank, 	
			bvin,
			SKU,
			ProductName,
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties
			FROM bvc_Product 	
			WHERE
				(	@Keyword IS NULL OR
					SKU like @Keyword OR 
					ProductName LIKE @Keyword OR
					MetaDescription LIKE @Keyword OR
					MetaKeywords LIKE @Keyword OR
					ShortDescription LIKE @Keyword OR
					LongDescription LIKE @Keyword OR
					Keywords LIKE @Keyword)
				AND
				(@ManufacturerId IS NULL OR ManufacturerID=@ManufacturerId)
				AND
				(@VendorId IS NULL OR VendorId = @VendorId)
				AND
				(@ParentId IS NULL OR ParentId = @ParentId)
				AND
				(@Status IS NULL OR Status = @Status)
				AND
				((@InventoryStatus IS NULL) OR (TrackInventory = 0 AND @InventoryStatus = 1) OR (TrackInventory = 1 AND EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)) OR (TrackInventory = 1 AND @InventoryStatus = 0 AND NOT EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)))
				AND
				(@ProductTypeId IS NULL OR ProductTypeId = @ProductTypeId)
				AND
				(@CategoryId IS NULL OR EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@CategoryID))
				AND
				(@NotCategoryId IS NULL OR NOT EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvin AND CategoryId=@NotCategoryID))
				AND
				(@MinPrice IS NULL OR SitePrice >= @MinPrice)
				AND
				(@MaxPrice IS NULL OR SitePrice <= @MaxPrice)
				AND
				(@CreatedAfter IS NULL OR CreationDate >= @CreatedAfter)
				AND
				(@SpecialProductTypeOne IS NULL OR SpecialProductType = @SpecialProductTypeOne OR SpecialProductType = @SpecialProductTypeTwo)
				/* Property Code */
				AND
				(@Property1 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property1 AND PropertyValue=@PropertyValue1))
				AND
				(@Property2 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property2 AND PropertyValue=@PropertyValue2))
				AND
				(@Property3 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property3 AND PropertyValue=@PropertyValue3))
				AND
				(@Property4 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property4 AND PropertyValue=@PropertyValue4))
				AND
				(@Property5 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property5 AND PropertyValue=@PropertyValue5))
				AND
				(@Property6 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property6 AND PropertyValue=@PropertyValue6))
				AND
				(@Property7 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property7 AND PropertyValue=@PropertyValue7))
				AND
				(@Property8 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property8 AND PropertyValue=@PropertyValue8))
				AND
				(@Property9 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property9 AND PropertyValue=@PropertyValue9))
				AND
				(@Property10 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=@Property10 AND PropertyValue=@PropertyValue10))
				AND
				(@DisplayInactive = 1 OR Status = 1))
				

			SELECT DISTINCT rownum,
			products.bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			products.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory, 
			OutOfStockMode, 
			CustomProperties,(SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
			WHERE Rank <= @LastXItems AND 
				((bvc_ProductChoiceCombinations.ChoiceId IN 
				(SELECT T.c.value('ProductChoiceId[1]', 'VARCHAR(36)') As ChoiceId				
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL) AND
				((bvc_ProductChoiceCombinations.ChoiceOptionId IN 
				(SELECT T.c.value('ChoiceOptionId[1]', 'VARCHAR(36)') As ChoiceOptionId
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL)
				AND RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		END
		ELSE IF @SortBy = 4
		BEGIN
			WITH cte_Product AS
			(SELECT			
			RowNum = 
				CASE 
					WHEN @SortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY bvc_Vendor.DisplayName ASC, ProductName ASC)
					WHEN @SortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY bvc_Vendor.DisplayName DESC, ProductName ASC)
				END,
			RANK() OVER (ORDER BY id DESC) AS rank,
			bvc_Product.bvin,
			bvc_Product.SKU,
			bvc_Product.ProductName,
			bvc_Product.ProductTypeID,			
			bvc_Product.ListPrice,
			bvc_Product.SitePrice,
			bvc_Product.SiteCost,
			bvc_Product.MetaKeywords,
			bvc_Product.MetaDescription,
			bvc_Product.MetaTitle,
			bvc_Product.TaxExempt,
			bvc_Product.TaxClass,
			bvc_Product.NonShipping,
			bvc_Product.ShipSeparately,
			bvc_Product.ShippingMode,
			bvc_Product.ShippingWeight,
			bvc_Product.ShippingLength,
			bvc_Product.ShippingWidth,
			bvc_Product.ShippingHeight,
			bvc_Product.Status,
			bvc_Product.ImageFileSmall,
			bvc_Product.ImageFileMedium,
			bvc_Product.CreationDate,
			bvc_Product.MinimumQty,
			bvc_Product.ParentID,
			bvc_Product.VariantDisplayMode,	
			bvc_Product.ShortDescription,
			bvc_Product.LongDescription,
			bvc_Product.ManufacturerID,
			bvc_Product.VendorID,
			bvc_Product.GiftWrapAllowed,
			bvc_Product.ExtraShipFee,
			bvc_Product.LastUpdated,
			bvc_Product.Keywords,
			bvc_Product.TemplateName,
			bvc_Product.PreContentColumnId,
			bvc_Product.PostContentColumnId,
			bvc_Product.RewriteUrl,
			bvc_Product.SitePriceOverrideText,
			bvc_Product.SpecialProductType,
			bvc_Product.GiftCertificateCodePattern,
			bvc_Product.PreTransformLongDescription,
			bvc_Product.SmallImageAlternateText,
			bvc_Product.MediumImageAlternateText,
			bvc_Product.TrackInventory,
			bvc_Product.OutOfStockMode,
			bvc_Product.CustomProperties
			FROM bvc_Product
			JOIN bvc_Vendor ON bvc_Product.VendorId = bvc_Vendor.bvin
			WHERE
				(	@Keyword IS NULL OR
					SKU like @Keyword OR 
					ProductName LIKE @Keyword OR
					MetaDescription LIKE @Keyword OR
					MetaKeywords LIKE @Keyword OR
					ShortDescription LIKE @Keyword OR
					LongDescription LIKE @Keyword OR
					Keywords LIKE @Keyword)
				AND
				(@ManufacturerId IS NULL OR ManufacturerID=@ManufacturerId)
				AND
				(@VendorId IS NULL OR VendorId = @VendorId)
				AND
				(@ParentId IS NULL OR ParentId = @ParentId)
				AND
				(@Status IS NULL OR Status = @Status)
				AND
				((@InventoryStatus IS NULL) OR (TrackInventory = 0 AND @InventoryStatus = 1) OR (TrackInventory = 1 AND EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)) OR (TrackInventory = 1 AND @InventoryStatus = 0 AND NOT EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status = @InventoryStatus AND ProductBvin = bvin)))
				AND
				(@ProductTypeId IS NULL OR ProductTypeId = @ProductTypeId)
				AND
				(@CategoryId IS NULL OR EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvc_Product.bvin AND CategoryId=@CategoryID))
				AND
				(@NotCategoryId IS NULL OR NOT EXISTS (Select CategoryId,ProductId FROM bvc_ProductXCategory WHERE ProductId=bvc_Product.bvin AND CategoryId=@NotCategoryID))
				AND
				(@MinPrice IS NULL OR SitePrice >= @MinPrice)
				AND
				(@MaxPrice IS NULL OR SitePrice <= @MaxPrice)
				AND
				(@CreatedAfter IS NULL OR CreationDate >= @CreatedAfter)
				AND
				(@SpecialProductTypeOne IS NULL OR SpecialProductType = @SpecialProductTypeOne OR SpecialProductType = @SpecialProductTypeTwo)
				/* Property Code */
				AND
				(@Property1 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property1 AND PropertyValue=@PropertyValue1))
				AND
				(@Property2 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property2 AND PropertyValue=@PropertyValue2))
				AND
				(@Property3 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property3 AND PropertyValue=@PropertyValue3))
				AND
				(@Property4 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property4 AND PropertyValue=@PropertyValue4))
				AND
				(@Property5 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property5 AND PropertyValue=@PropertyValue5))
				AND
				(@Property6 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property6 AND PropertyValue=@PropertyValue6))
				AND
				(@Property7 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property7 AND PropertyValue=@PropertyValue7))
				AND
				(@Property8 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property8 AND PropertyValue=@PropertyValue8))
				AND
				(@Property9 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property9 AND PropertyValue=@PropertyValue9))
				AND
				(@Property10 IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvc_Product.bvin AND PropertyBvin=@Property10 AND PropertyValue=@PropertyValue10))
				AND
				(@DisplayInactive = 1 OR Status = 1))
								
						
			SELECT DISTINCT rownum,
			products.bvin,
			SKU,
			ProductName,			
			ProductTypeID,			
			ListPrice,
			SitePrice,
			SiteCost,
			MetaKeywords,
			MetaDescription,
			MetaTitle,
			TaxExempt,
			TaxClass,
			NonShipping,
			ShipSeparately,
			ShippingMode,
			ShippingWeight,
			ShippingLength,
			ShippingWidth,
			ShippingHeight,
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,	
			ShortDescription,
			LongDescription,
			ManufacturerID,
			VendorID,
			GiftWrapAllowed,
			ExtraShipFee,
			products.LastUpdated,
			Keywords,
			TemplateName,
			PreContentColumnId,
			PostContentColumnId,
			RewriteUrl,
			SitePriceOverrideText,
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode, 
			CustomProperties, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
			WHERE Rank <= @LastXItems AND 
				((bvc_ProductChoiceCombinations.ChoiceId IN 
				(SELECT T.c.value('ProductChoiceId[1]', 'VARCHAR(36)') As ChoiceId				
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL) AND
				((bvc_ProductChoiceCombinations.ChoiceOptionId IN 
				(SELECT T.c.value('ChoiceOptionId[1]', 'VARCHAR(36)') As ChoiceOptionId
					FROM @SharedChoicesXml.nodes('/ArrayOfProductChoiceAndChoiceOptionPair/ProductChoiceAndChoiceOptionPair') T(c))) OR @SharedChoicesXml IS NULL)
				AND RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		END				
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_Sql_i
	END CATCH






GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_BySkuAll_s]'
GO











ALTER PROCEDURE [dbo].[bvc_Product_BySkuAll_s]

@bvin varchar(50)

AS
	BEGIN TRY
		DECLARE @ProductBvin varchar(50)
		SET @ProductBvin = (Select bvin FROM bvc_Product WHERE sku=@bvin)
		EXEC bvc_Product_s @ProductBvin
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

























GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_LineItem_ByOrderId_d]'
GO





ALTER PROCEDURE [dbo].[bvc_LineItem_ByOrderId_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_LineItemModifier WHERE LineItemBvin IN (SELECT bvin FROM bvc_LineItem WHERE OrderBvin = @bvin)
		DELETE FROM bvc_LineItemInput WHERE LineItemBvin IN (SELECT bvin FROM bvc_LineItem WHERE OrderBvin = @bvin)
		DELETE FROM bvc_LineItem WHERE OrderBvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_BySku_s]'
GO











ALTER PROCEDURE [dbo].[bvc_Product_BySku_s]

@bvin varchar(50)

AS
	BEGIN TRY
		DECLARE @ProductBvin varchar(50)
		SET @ProductBvin = (Select bvin FROM bvc_Product WHERE sku=@bvin AND parentID='')
		EXEC bvc_Product_s @ProductBvin
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
























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
