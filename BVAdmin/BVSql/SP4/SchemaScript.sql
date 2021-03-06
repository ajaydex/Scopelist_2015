/*
Script created by SQL Compare version 7.1.0 from Red Gate Software Ltd at 11/4/2008 5:02:24 PM
Run this script on (local).bv532 to make it the same as (local).bv54full
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
PRINT N'Dropping foreign keys from [dbo].[bvc_KitPart]'
GO
ALTER TABLE [dbo].[bvc_KitPart] DROP
CONSTRAINT [FK_bvc_KitPart_bvc_KitPartGroup]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping foreign keys from [dbo].[bvc_KitPartGroup]'
GO
ALTER TABLE [dbo].[bvc_KitPartGroup] DROP
CONSTRAINT [FK_bvc_KitPartGroup_bvc_Product]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_KitPartGroup]'
GO
ALTER TABLE [dbo].[bvc_KitPartGroup] DROP CONSTRAINT [PK_bvc_KitPartGroup]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_KitPart] from [dbo].[bvc_KitPart]'
GO
DROP INDEX [IX_bvc_KitPart] ON [dbo].[bvc_KitPart]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_KitPart_Product] from [dbo].[bvc_KitPart]'
GO
DROP INDEX [IX_bvc_KitPart_Product] ON [dbo].[bvc_KitPart]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_KitPartGroup] from [dbo].[bvc_KitPartGroup]'
GO
DROP INDEX [IX_bvc_KitPartGroup] ON [dbo].[bvc_KitPartGroup]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_KitPartGroup_s]'
GO
DROP PROCEDURE [dbo].[bvc_KitPartGroup_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_KitPartGroup_ByProductId_s]'
GO
DROP PROCEDURE [dbo].[bvc_KitPartGroup_ByProductId_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_KitPart_ByGroupID_s]'
GO
DROP PROCEDURE [dbo].[bvc_KitPart_ByGroupID_s]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_KitPartGroup_u]'
GO
DROP PROCEDURE [dbo].[bvc_KitPartGroup_u]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_KitPartGroup_i]'
GO
DROP PROCEDURE [dbo].[bvc_KitPartGroup_i]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_KitPartGroup_d]'
GO
DROP PROCEDURE [dbo].[bvc_KitPartGroup_d]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping [dbo].[bvc_KitPartGroup]'
GO
DROP TABLE [dbo].[bvc_KitPartGroup]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product]'
GO
ALTER TABLE [dbo].[bvc_Product] ADD
[GiftWrapPrice] [numeric] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Product_GiftWrapPrice] DEFAULT ((0.00))
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
PRINT N'Altering [dbo].[bvc_Product_All_s]'
GO







ALTER PROCEDURE [dbo].[bvc_Product_All_s]
@StartRowIndex int = 0,
@MaximumRows int = 9999999
AS

	BEGIN TRY;
		WITH Products AS (SELECT
			ROW_NUMBER() OVER (ORDER BY ProductName) As RowNum,
			bvc_Product.bvin,
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
			bvc_Product.Status,
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
			bvc_Product.LastUpdated,
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
			CustomProperties,			
			GiftWrapPrice		
			FROM bvc_Product 
			WHERE ParentID='')
		
		SELECT *, (SELECT COUNT(*) FROM Products) AS TotalRowCount FROM Products WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
		ORDER BY RowNum
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ByChoiceId_s]'
GO






ALTER PROCEDURE [dbo].[bvc_Product_ByChoiceId_s]

@choiceId varchar(36)

AS
	BEGIN TRY
			SELECT
			a.bvin,
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
			CustomProperties,			
			GiftWrapPrice

			FROM bvc_Product AS a JOIN (SELECT DISTINCT ChoiceId, ParentProductId FROM bvc_ProductChoiceCombinations) AS b ON a.bvin = b.ParentProductId
			WHERE a.ParentId = '' AND b.ChoiceId = @choiceId
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
PRINT N'Creating [dbo].[bvc_KitComponent]'
GO
CREATE TABLE [dbo].[bvc_KitComponent]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_KitComponent_Description] DEFAULT (''),
[GroupBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ComponentType] [int] NOT NULL,
[SmallImage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_KitComponent_SmallImage] DEFAULT (''),
[LargeImage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_KitComponent_LargeImage] DEFAULT (''),
[SortOrder] [int] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_KitPartGroup] on [dbo].[bvc_KitComponent]'
GO
ALTER TABLE [dbo].[bvc_KitComponent] ADD CONSTRAINT [PK_bvc_KitPartGroup] PRIMARY KEY CLUSTERED ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_KitPartGroup] on [dbo].[bvc_KitComponent]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_KitPartGroup] ON [dbo].[bvc_KitComponent] ([GroupBvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_WishList_i]'
GO
ALTER PROCEDURE [dbo].[bvc_WishList_i]	

@bvin varchar(36),
@userId varchar(36),
@ProductBvin varchar(36),
@Quantity int,
@Modifiers nvarchar(max),
@Inputs nvarchar(max)


AS
BEGIN
	BEGIN TRY		
		INSERT INTO bvc_WishList ([bvin],UserId,ProductBvin,Quantity,Modifiers,Inputs) VALUES(@bvin,@UserId,@ProductBvin,@Quantity,@Modifiers,@Inputs)
		RETURN
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
PRINT N'Creating [dbo].[bvc_KitComponent_MoveDown_u]'
GO


CREATE PROCEDURE [dbo].[bvc_KitComponent_MoveDown_u]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @CurrentSortOrder int
		DECLARE @GroupBvin varchar(36)
		DECLARE @targetBvin varchar(36)

		BEGIN TRAN
		SELECT @CurrentSortOrder = SortOrder, @GroupBvin = GroupBvin FROM bvc_KitComponent WHERE bvin = @bvin
		
		SELECT @targetBvin = bvin FROM bvc_KitComponent WHERE SortOrder = @CurrentSortOrder - 1 AND GroupBvin = @GroupBvin

		IF @targetBvin IS NOT NULL
		BEGIN						
			UPDATE bvc_KitComponent SET SortOrder = @CurrentSortOrder WHERE bvin = @targetBvin
			UPDATE bvc_KitComponent SET SortOrder = (@CurrentSortOrder - 1) WHERE bvin = @bvin
		END
		ELSE
		BEGIN
			UPDATE bvc_KitComponent SET SortOrder = @CurrentSortOrder WHERE bvin = @bvin AND GroupBvin = @GroupBvin
		END		
		
		COMMIT

		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ByCrossSellId_Admin_s]'
GO














ALTER PROCEDURE [dbo].[bvc_Product_ByCrossSellId_Admin_s]

@bvin varchar(36)

AS
	BEGIN TRY
			SELECT
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
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,		
			CASE LTRIM(RTRIM(pc.DescriptionOverride))
				WHEN '' THEN p.ShortDescription
				ELSE pc.DescriptionOverride
			END	As ShortDescription,
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
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties,			
			GiftWrapPrice
			
			FROM bvc_Product p JOIN bvc_ProductCrossSell pc ON p.bvin = pc.CrossSellBvin
			WHERE pc.ProductBvin = @bvin
			ORDER BY pc.[Order]


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
PRINT N'Creating [dbo].[bvc_KitComponent_MoveUp_u]'
GO


CREATE PROCEDURE [dbo].[bvc_KitComponent_MoveUp_u]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @CurrentSortOrder int
		DECLARE @GroupBvin varchar(36)
		DECLARE @targetBvin varchar(36)

		BEGIN TRAN
		SELECT @CurrentSortOrder = SortOrder, @GroupBvin = GroupBvin FROM bvc_KitComponent WHERE bvin = @bvin
		
		SELECT @targetBvin = bvin FROM bvc_KitComponent WHERE SortOrder = @CurrentSortOrder + 1 AND GroupBvin = @GroupBvin

		IF @targetBvin IS NOT NULL
		BEGIN						
			UPDATE bvc_KitComponent SET SortOrder = @CurrentSortOrder WHERE bvin = @targetBvin
			UPDATE bvc_KitComponent SET SortOrder = (@CurrentSortOrder + 1) WHERE bvin = @bvin
		END
		ELSE
		BEGIN
			UPDATE bvc_KitComponent SET SortOrder = @CurrentSortOrder WHERE bvin = @bvin AND GroupBvin = @GroupBvin
		END		
		
		COMMIT

		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_KitPart]'
GO
ALTER TABLE [dbo].[bvc_KitPart] ADD
[ComponentBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PriceType] [int] NOT NULL CONSTRAINT [DF_bvc_KitPart_PriceType] DEFAULT ((1)),
[WeightType] [int] NOT NULL CONSTRAINT [DF_bvc_KitPart_WeightType] DEFAULT ((1)),
[IsNull] [bit] NOT NULL CONSTRAINT [DF_bvc_KitPart_IsNull] DEFAULT ((0)),
[IsSelected] [bit] NOT NULL CONSTRAINT [DF_bvc_KitPart_IsSelected] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_KitPart] DROP
COLUMN [GroupBvin]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_KitPart] ALTER COLUMN [ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_KitPart_Product] on [dbo].[bvc_KitPart]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_KitPart_Product] ON [dbo].[bvc_KitPart] ([ProductBvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_KitPart] on [dbo].[bvc_KitPart]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_KitPart] ON [dbo].[bvc_KitPart] ([ComponentBvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ByFile_s]'
GO












ALTER PROCEDURE [dbo].[bvc_Product_ByFile_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvin,
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
		p.LastUpdated,
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
		CustomProperties,		
		GiftWrapPrice
		
		FROM bvc_Product p JOIN bvc_ProductFileXProduct px ON p.bvin = px.ProductID
		WHERE px.ProductFileId = @bvin
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
PRINT N'Creating [dbo].[bvc_KitComponent_u]'
GO
CREATE PROCEDURE [dbo].[bvc_KitComponent_u]

@bvin varchar(36),
@DisplayName nvarchar(512),
@Description nvarchar(max),
@GroupBvin varchar(36) = NULL,
@ComponentType int,
@LargeImage nvarchar(max),
@SmallImage nvarchar(max)

AS
	BEGIN TRY
		UPDATE bvc_KitComponent
		SET
		bvin=@bvin,
		DisplayName=@DisplayName,
		Description=@Description,
		GroupBvin=@GroupBvin,
		ComponentType=@ComponentType,
		LargeImage=@LargeImage,
		SmallImage=@SmallImage,
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
PRINT N'Creating [dbo].[bvc_KitGroup]'
GO
CREATE TABLE [dbo].[bvc_KitGroup]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrder] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_KitGroup] on [dbo].[bvc_KitGroup]'
GO
ALTER TABLE [dbo].[bvc_KitGroup] ADD CONSTRAINT [PK_bvc_KitGroup] PRIMARY KEY CLUSTERED ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_ProductType_ForCategory_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductType_ForCategory_s]

@bvin varchar(36)

AS

BEGIN TRY
	SELECT DISTINCT
		pt.bvin,
		pt.ProductTypeName,
		pt.IsPermanent,
		pt.LastUpdated
	FROM bvc_ProductType AS pt
	JOIN bvc_Product AS p ON p.ProductTypeId = pt.Bvin
	JOIN bvc_ProductXCategory AS pc ON p.Bvin = pc.ProductId
	JOIN bvc_Category As c ON pc.CategoryId = c.Bvin
	WHERE c.Bvin = @bvin	
	ORDER BY ProductTypeName
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
PRINT N'Creating [dbo].[bvc_KitGroup_i]'
GO
CREATE PROCEDURE [dbo].[bvc_KitGroup_i]

@bvin varchar(36),
@DisplayName varchar(255),
@ProductId varchar(36) = NULL,
@SortOrder int OUTPUT

AS
	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_KitGroup WHERE ProductId=@ProductId) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_KitGroup WHERE ProductId=@ProductId)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END
			
			
		INSERT INTO bvc_KitGroup
		(
		bvin,
		DisplayName,		
		ProductId,
		SortOrder,		
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@DisplayName,
		@ProductId,
		@SortOrder,
		GetDate()
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
PRINT N'Altering [dbo].[bvc_Product_ByUpSellId_Admin_s]'
GO














ALTER PROCEDURE [dbo].[bvc_Product_ByUpSellId_Admin_s]

@bvin varchar(36)

AS
	BEGIN TRY
			SELECT
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
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,		
			CASE LTRIM(RTRIM(pu.DescriptionOverride))
				WHEN '' THEN p.ShortDescription
				ELSE pu.DescriptionOverride
			END	As ShortDescription,
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
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties,			
			GiftWrapPrice
			
			FROM bvc_Product p JOIN bvc_ProductUpSell pu ON p.bvin = pu.UpSellBvin
			WHERE pu.ProductBvin = @bvin



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
PRINT N'Creating [dbo].[bvc_Manufacturer_ForCategory_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Manufacturer_ForCategory_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT m.bvin,m.DisplayName,m.EmailAddress,m.Address,m.DropShipEmailTemplateId,m.LastUpdated FROM bvc_Manufacturer AS m
		WHERE m.bvin IN (SELECT DISTINCT m.bvin FROM bvc_Manufacturer AS m
			JOIN bvc_Product AS p ON p.ManufacturerId = m.Bvin
			JOIN bvc_ProductXCategory AS pc ON p.Bvin = pc.ProductId
			JOIN bvc_Category As c ON pc.CategoryId = c.Bvin
			WHERE c.Bvin = @bvin)
			ORDER BY m.DisplayName
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
PRINT N'Creating [dbo].[bvc_KitGroup_s]'
GO
CREATE PROCEDURE [dbo].[bvc_KitGroup_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,DisplayName,ProductId,SortOrder,LastUpdated FROM bvc_KitGroup

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
PRINT N'Creating [dbo].[bvc_KitGroup_u]'
GO
CREATE PROCEDURE [dbo].[bvc_KitGroup_u]

@bvin varchar(36),
@DisplayName varchar(255),
@ProductId varchar(36) = NULL

AS
	BEGIN TRY
		UPDATE bvc_KitGroup
		SET
				
		DisplayName=@DisplayName,
		ProductId=@ProductId,
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
PRINT N'Altering [dbo].[bvc_Product_Children_s]'
GO







ALTER PROCEDURE [dbo].[bvc_Product_Children_s]

@bvin varchar(36)

AS

	BEGIN TRY
			SELECT
			bvin,
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
			bvc_Product.LastUpdated,
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
			CustomProperties,			
			GiftWrapPrice
			
			FROM bvc_Product 
			WHERE ParentID=@bvin
			ORDER BY ProductName

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
PRINT N'Altering [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] ADD
[GiftWrapDetails] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_bvc_LineItem_GiftWrapDetails] DEFAULT (''),
[KitSelections] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_LineItem_KitSelections] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_KitPart_d]'
GO


ALTER PROCEDURE [dbo].[bvc_KitPart_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @SortOrder int
		DECLARE @ComponentBvin varchar(36)

		BEGIN TRAN
		
			SELECT @SortOrder = SortOrder, @ComponentBvin = ComponentBvin FROM bvc_KitPart WHERE bvin = @bvin

			DELETE bvc_KitPart WHERE bvin=@bvin

			UPDATE bvc_KitPart SET SortOrder = SortOrder - 1 WHERE ComponentBvin = @ComponentBvin AND SortOrder > @SortOrder
		COMMIT
		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ByOrder_s]'
GO







ALTER PROCEDURE [dbo].[bvc_Product_ByOrder_s]

@bvin varchar(36)

AS
	BEGIN TRY
			SELECT
			bvin,
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
			CustomProperties,			
			GiftWrapPrice
			
			FROM bvc_Product
			WHERE bvin IN (
			SELECT ProductId FROM bvc_LineItem WHERE OrderBvin=@bvin
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
PRINT N'Altering [dbo].[bvc_LineItem_ByOrderId_s]'
GO





ALTER PROCEDURE [dbo].[bvc_LineItem_ByOrderId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		ProductId,
		Quantity,
		OrderBvin,
		AdjustedPrice,
		BasePrice,
		Discounts,
		ShippingPortion,
		TaxPortion,
		LineTotal,
		CustomProperties,
		QuantityReturned,
		QuantityShipped,
		ProductName,
		ProductSku,
		ProductShortDescription,
		StatusCode,
		StatusName,
		AdditionalDiscount,
		AdminPrice,
		LastUpdated,
		GiftWrapDetails,
		KitSelections

		FROM 
			bvc_LineItem
		WHERE  
			OrderBvin=@bvin ORDER BY [id]
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
PRINT N'Altering [dbo].[bvc_Product_i]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_i]

@bvin varchar(36),
@SKU varchar(50),
@ProductTypeID varchar(36),
@ProductName nvarchar(512),
@ListPrice  numeric(18,10),
@SitePrice  numeric(18,10),
@SiteCost numeric(18,10),
@MetaKeywords  nvarchar(255),
@MetaDescription  nvarchar(255),
@MetaTitle  nvarchar(512),
@TaxExempt  int,
@TaxClass  varchar(36),
@NonShipping  int,
@ShipSeparately  int,
@ShippingMode  int,
@ShippingWeight  numeric(18,10),
@ShippingLength numeric(18,10),
@ShippingWidth numeric(18,10),
@ShippingHeight numeric(18,10),
@Status int,
@ImageFileSmall nvarchar(1000),
@ImageFileMedium nvarchar(1000),
@MinimumQty int,
@ParentID varchar(36),
@VariantDisplayMode int,
@ShortDescription nvarchar(255),
@LongDescription nvarchar(max),
@ManufacturerID varchar(36),
@VendorID varchar(36),
@GiftWrapAllowed int,
@ExtraShipFee numeric(18,10),
@Keywords nvarchar(Max),
@TemplateName nvarchar(512),
@PreContentColumnId varchar(36),
@PostContentColumnId varchar(36),
@RewriteUrl nvarchar(Max),
@SitePriceOverrideText nvarchar(255),
@SpecialProductType int,
@GiftCertificateCodePattern nvarchar(30),
@PreTransformLongDescription nvarchar(max),
@SmallImageAlternateText nvarchar(255),
@MediumImageAlternateText nvarchar(255),
@OutOfStockMode int,
@TrackInventory int = 0,
@CustomProperties nvarchar(max),
@GiftWrapPrice numeric(18,10)

AS
	BEGIN TRY
		INSERT INTO bvc_Product
		(
		bvin,
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
		CustomProperties,		
		GiftWrapPrice
		)
		VALUES
		(
		@bvin,
		@SKU,
		@ProductTypeID,
		@ProductName,
		@ListPrice,
		@SitePrice,
		@SiteCost,
		@MetaKeywords,
		@MetaDescription,
		@MetaTitle,
		@TaxExempt,
		@TaxClass,
		@NonShipping,
		@ShipSeparately,
		@ShippingMode,
		@ShippingWeight,
		@ShippingLength,
		@ShippingWidth,
		@ShippingHeight,
		@Status,
		@ImageFileSmall,
		@ImageFileMedium,
		GetDate(),
		@MinimumQty,
		@ParentID,
		@VariantDisplayMode,
		@ShortDescription,
		@LongDescription,
		@ManufacturerID,
		@VendorID,
		@GiftWrapAllowed,
		@ExtraShipFee,
		GetDate(),
		@Keywords,
		@TemplateName,
		@PreContentColumnId,
		@PostContentColumnId,
		@RewriteUrl,
		@SitePriceOverrideText,
		@SpecialProductType,
		@GiftCertificateCodePattern,
		@PreTransformLongDescription,
		@SmallImageAlternateText,
		@MediumImageAlternateText,
		@TrackInventory,
		@OutOfStockMode,
		@CustomProperties,		
		@GiftWrapPrice
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
PRINT N'Altering [dbo].[bvc_KitPart_i]'
GO
ALTER PROCEDURE [dbo].[bvc_KitPart_i]

@bvin varchar(36),
@ComponentBvin varchar(36) = NULL,
@ProductBvin varchar(36) = NULL,
@Description nvarchar(255),
@Quantity int,
@Weight decimal(18,10),
@Price decimal(18,10),
@PriceType int,
@WeightType int,
@IsNull bit,
@IsSelected bit,
@SortOrder int OUTPUT

AS
	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_KitPart WHERE ComponentBvin=@ComponentBvin) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_KitPart WHERE ComponentBvin=@ComponentBvin)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END
			
			
		INSERT INTO bvc_KitPart
		(
		bvin,
		ComponentBvin,
		SortOrder,
		ProductBvin,
		Description,
		Quantity,
		Weight,
		Price,
		WeightType,
		PriceType,
		[IsNull],
		[IsSelected],
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@ComponentBvin,
		@SortOrder,
		@ProductBvin,
		@Description,
		@Quantity,
		@Weight,
		@Price,
		@WeightType,
		@PriceType,
		@IsNull,
		@IsSelected,
		GetDate()
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
PRINT N'Creating [dbo].[bvc_KitPart_MoveDown_u]'
GO


CREATE PROCEDURE [dbo].[bvc_KitPart_MoveDown_u]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @CurrentSortOrder int
		DECLARE @ComponentBvin varchar(36)
		DECLARE @targetBvin varchar(36)

		BEGIN TRAN
		SELECT @CurrentSortOrder = SortOrder, @ComponentBvin = ComponentBvin FROM bvc_KitPart WHERE bvin = @bvin
		
		SELECT @targetBvin = bvin FROM bvc_KitPart WHERE SortOrder = @CurrentSortOrder - 1 AND ComponentBvin = @ComponentBvin

		IF @targetBvin IS NOT NULL
		BEGIN						
			UPDATE bvc_KitPart SET SortOrder = @CurrentSortOrder WHERE bvin = @targetBvin
			UPDATE bvc_KitPart SET SortOrder = (@CurrentSortOrder - 1) WHERE bvin = @bvin
		END
		ELSE
		BEGIN
			UPDATE bvc_KitPart SET SortOrder = @CurrentSortOrder WHERE bvin = @bvin AND ComponentBvin = @ComponentBvin
		END		
		
		COMMIT

		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_Light_s]'
GO



















ALTER PROCEDURE [dbo].[bvc_Product_Light_s]

@bvin varchar(36)

AS
	
	BEGIN TRY
		SELECT

		bvin,
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
		CustomProperties,		
		GiftWrapPrice

		FROM bvc_Product
		WHERE bvin=@bvin 
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
PRINT N'Creating [dbo].[bvc_KitPart_MoveUp_u]'
GO


CREATE PROCEDURE [dbo].[bvc_KitPart_MoveUp_u]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @CurrentSortOrder int
		DECLARE @ComponentBvin varchar(36)
		DECLARE @targetBvin varchar(36)

		BEGIN TRAN
		SELECT @CurrentSortOrder = SortOrder, @ComponentBvin = ComponentBvin FROM bvc_KitPart WHERE bvin = @bvin
		
		SELECT @targetBvin = bvin FROM bvc_KitPart WHERE SortOrder = @CurrentSortOrder + 1 AND ComponentBvin = @ComponentBvin

		IF @targetBvin IS NOT NULL
		BEGIN						
			UPDATE bvc_KitPart SET SortOrder = @CurrentSortOrder WHERE bvin = @targetBvin
			UPDATE bvc_KitPart SET SortOrder = (@CurrentSortOrder + 1) WHERE bvin = @bvin
		END
		ELSE
		BEGIN
			UPDATE bvc_KitPart SET SortOrder = @CurrentSortOrder WHERE bvin = @bvin AND ComponentBvin = @ComponentBvin
		END		
		
		COMMIT

		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_KitPart_s]'
GO
ALTER PROCEDURE [dbo].[bvc_KitPart_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ComponentBvin,SortOrder,ProductBvin,Description,Quantity,
			Weight,Price,PriceType,WeightType,[IsNull],[IsSelected],LastUpdated FROM bvc_KitPart

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
PRINT N'Altering [dbo].[bvc_KitPart_u]'
GO
ALTER PROCEDURE [dbo].[bvc_KitPart_u]

@bvin varchar(36),
@ComponentBvin varchar(36) = NULL,
@ProductBvin varchar(36) = NULL,
@Description nvarchar(255),
@Quantity int,
@Weight decimal(18,10),
@Price decimal(18,10),
@PriceType int,
@WeightType int,
@IsNull bit,
@IsSelected bit

AS
	BEGIN TRY
		UPDATE bvc_KitPart
		SET
		
		[bvin]=@bvin,
		[ComponentBvin]=@ComponentBvin,
		[ProductBvin]=@ProductBvin,
		[Description]=@Description,
		[Quantity]=@Quantity,
		[Weight]=@Weight,
		[Price]=@Price,
		[PriceType]=@PriceType,
		[WeightType]=@WeightType,
		[IsNull]=@IsNull,
		[IsSelected]=@IsSelected,
		[LastUpdated]=GetDate()
		
		WHERE [bvin]=@bvin
		
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
PRINT N'Altering [dbo].[bvc_WishList_u]'
GO
ALTER PROCEDURE [dbo].[bvc_WishList_u]	

@bvin varchar(36),
@userId varchar(36),
@ProductBvin varchar(36),
@Quantity int,
@Modifiers nvarchar(max),
@Inputs nvarchar(max)
AS
BEGIN
	BEGIN TRY		
		UPDATE bvc_WishList
		SET Userid = @userid,
		ProductBvin = @ProductBvin,
		Quantity = @Quantity,
		Modifiers = @Modifiers,
		Inputs = @Inputs
		WHERE bvin = @bvin		
		RETURN
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
PRINT N'Altering [dbo].[bvc_Product_StoreSearch_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_StoreSearch_s]

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
		--keyword0 is to do whole word matches for keyword1
		DECLARE @Keyword0 nvarchar(100)

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
			bvc_Product.CustomProperties,			
			bvc_Product.GiftWrapPrice '						

		SET @WhereClause = ' FROM bvc_Product WHERE bvc_Product.ParentID = '''' '		
		
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
		
		DECLARE @KeywordsWhereClause nvarchar(4000)

		DECLARE @i int
		
		SET @i = 0			

		WHILE (@i <= 10)
		BEGIN
			DECLARE @Continue bit
			SET @Continue = 0

			IF @i = 0 AND @Keyword1 IS NOT NULL
            BEGIN
				SET @Continue = 1
				--keyword 0 is just keyword1 with spaces				
				SET @Keyword0 = @Keyword1
			END
			
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
				
				IF @i = 0
				BEGIN
					IF @SearchSKU = 1
						SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR SKU = @Keyword0 OR SKU LIKE ''% '' + @Keyword0 + '' %'' OR SKU LIKE @Keyword0 + '' %'' OR SKU LIKE ''% '' + @Keyword0 '						
					IF @SearchProductName = 1
						SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR ProductName = @Keyword0 OR ProductName LIKE ''% '' + @Keyword0 + '' %'' OR ProductName LIKE @Keyword0 + '' %'' OR ProductName LIKE ''% '' + @Keyword0 '						
					IF @SearchMetaDescription = 1
						SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR MetaDescription = @Keyword0 OR MetaDescription LIKE ''% '' + @Keyword0 + '' %'' OR MetaDescription LIKE @Keyword0 + '' %'' OR MetaDescription LIKE ''% '' + @Keyword0 '
					IF @SearchMetaKeywords = 1
						SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR MetaKeywords = @Keyword0 OR MetaKeywords LIKE ''% '' + @Keyword0 + '' %'' OR MetaKeywords LIKE @Keyword0 + '' %'' OR MetaKeywords LIKE ''% '' + @Keyword0 '
					IF @SearchShortDescription = 1
						SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR ShortDescription = @Keyword0 OR ShortDescription LIKE ''% '' + @Keyword0 + '' %'' OR ShortDescription LIKE @Keyword0 + '' %'' OR ShortDescription LIKE ''% '' + @Keyword0 '
					IF @SearchLongDescription = 1
						SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR LongDescription = @Keyword0 OR LongDescription LIKE ''% '' + @Keyword0 + '' %'' OR LongDescription LIKE @Keyword0 + '' %'' OR LongDescription LIKE ''% '' + @Keyword0 '
					IF @SearchKeywords = 1
						SET @KeywordsWhereClause = @KeywordsWhereClause + ' OR Keywords = @Keyword0 OR Keywords LIKE ''% '' + @Keyword0 + '' %'' OR Keywords LIKE @Keyword0 + '' %'' OR Keywords LIKE ''% '' + @Keyword0 '
				END
				ELSE
				BEGIN
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
				END
				

				SET @KeywordsWhereClause = @KeywordsWhereClause + ')'

				IF @i = 0
					SET @Queries = @SelectStatementSql + ', 1 AS Relevance ' + @WhereClause + @KeywordsWhereClause
				ELSE IF @i = 1					
					SET @Queries = @Queries + ' UNION ALL ' + @SelectStatementSql + ', 2 AS Relevance ' + @WhereClause + @KeywordsWhereClause
				ELSE
					SET @Queries = @Queries + ' UNION ALL ' + @SelectStatementSql + ', 3 AS Relevance ' + @WhereClause + @KeywordsWhereClause
			END
			ELSE
			BEGIN
				--all of our continues should be right in a row
				BREAK
			END
			
			SET @i = @i + 1
		END

		-- if queries is empty, which means there are no keywords passed in, then we just need to query out everything
		IF @Queries = ''
		BEGIN
			SET @Queries = @SelectStatementSql + ', 1 AS Relevance ' + @WhereClause
		END

		SET @Queries = ' WITH cte_ProductSearch AS 
		( SELECT *, COUNT(bvin) As KeywordCount FROM (' + @Queries + ') AS KeywordSearch 
        GROUP BY bvin, SKU, ProductName, ProductTypeID, ListPrice, SitePrice, SiteCost, MetaKeywords, MetaDescription, 
          MetaTitle, TaxExempt, TaxClass, NonShipping, ShipSeparately, ShippingMode, ShippingWeight, ShippingLength, 
          ShippingWidth, ShippingHeight, Status, ImageFileSmall, ImageFileMedium, CreationDate, MinimumQty, ParentId, 
          VariantDisplayMode, ShortDescription, LongDescription, ManufacturerId, VendorID, GiftWrapAllowed, ExtraShipFee, 
          LastUpdated, Keywords, TemplateName, PreContentColumnId, PostContentColumnId, RewriteUrl, SitePriceOverrideText, 
          SpecialProductType, GiftCertificateCodePattern, PreTransformLongDescription, SmallImageAlternateText, MediumImageAlternateText, 
          TrackInventory, OutOfStockMode, CustomProperties, GiftWrapPrice, Relevance
        ),
        cte_ActiveResult AS (
			SELECT * FROM cte_ProductSearch AS a WHERE NOT EXISTS (SELECT * FROM cte_ProductSearch AS b WHERE a.bvin = b.bvin AND a.Relevance > b.Relevance) 
			AND (a.Status = 1)),
		cte_ProductResult AS (
			SELECT *, 
			ROW_NUMBER() OVER (ORDER BY '
			
			IF @SortBy = 0
				SET @Queries = @Queries + ' Relevance ASC, KeywordCount DESC, ProductName '
			ELSE IF @SortBy = 1
				SET @Queries = @Queries + ' Relevance ASC, KeywordCount DESC, bvc_Manufacturer.DisplayName '					
			ELSE IF @SortBy = 2
				SET @Queries = @Queries + ' Relevance ASC, KeywordCount DESC, CreationDate '
			ELSE IF @SortBy = 3
				SET @Queries = @Queries + ' Relevance ASC, KeywordCount DESC, SitePrice '
			ELSE IF @SortBy = 4
				SET @Queries = @Queries + ' Relevance ASC, KeywordCount DESC, bvc_Vendor.DisplayName '

			IF @SortOrder = 0
				SET @Queries = @Queries + ' ASC) '
			ELSE
				SET @Queries = @Queries + ' DESC) '

			SET @Queries = @Queries + ' AS RowNum, 
              (SELECT COUNT(*) FROM cte_ActiveResult) As TotalRowCount 
              FROM cte_ActiveResult AS a)		
		SELECT * FROM cte_ProductResult '	

		IF @SortBy = 1 --Sortying by manufacturer, so we need to JOIN
		BEGIN
			SET @Queries = @Queries + ' JOIN bvc_Manufacturer ON cte_ProductResult.ManufacturerId = bvc_Manufacturer.bvin '
		END
		ELSE IF @SortBy = 4 --Sortying by vendor, so we need to JOIN
		BEGIN
			SET @Queries = @Queries + ' JOIN bvc_Vendor ON cte_ProductResult.VendorId = bvc_Vendor.bvin '
		END

		SET @Queries = @Queries + ' WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows) ORDER BY RowNum'		

		DECLARE @ParameterDefinition nvarchar(4000)
		SET @ParameterDefinition = N'@Keyword0 nvarchar(100),
			@Keyword1 nvarchar(100),
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
			@Keyword0,
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
			p.CustomProperties,			
			p.GiftWrapPrice						
			
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
PRINT N'Altering [dbo].[bvc_KitPart_ByParentProductID_s]'
GO
ALTER PROCEDURE [dbo].[bvc_KitPart_ByParentProductID_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ComponentBvin,SortOrder,ProductBvin,Description,Quantity,
			Weight,Price,WeightType,PriceType,[IsNull],[IsSelected],LastUpdated FROM bvc_KitPart
		WHERE ComponentBvin IN (SELECT bvin FROM bvc_KitComponent WHERE GroupBvin=@bvin)
		ORDER BY ComponentBvin,SortOrder

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
PRINT N'Altering [dbo].[bvc_Product_u]'
GO













ALTER PROCEDURE [dbo].[bvc_Product_u]

@bvin varchar(36),
@SKU varchar(50),
@ProductName nvarchar(512),
@ProductTypeID varchar(36),
@ListPrice  numeric(18,10),
@SitePrice  numeric(18,10),
@SiteCost numeric(18,10),
@MetaKeywords  nvarchar(255),
@MetaDescription  nvarchar(255),
@MetaTitle  nvarchar(512),
@TaxExempt  int,
@TaxClass  varchar(36),
@NonShipping  int,
@ShipSeparately  int,
@ShippingMode  int,
@ShippingWeight  numeric(18,10),
@ShippingLength numeric(18,10),
@ShippingWidth numeric(18,10),
@ShippingHeight numeric(18,10),
@Status int,
@ImageFileSmall nvarchar(1000),
@ImageFileMedium nvarchar(1000),
@MinimumQty int,
@ParentID varchar(36),
@VariantDisplayMode int,
@ShortDescription nvarchar(255),
@LongDescription nvarchar(max),
@ManufacturerID varchar(36),
@VendorID varchar(36),
@GiftWrapAllowed int,
@ExtraShipFee numeric(18,10),
@Keywords nvarchar(Max),
@TemplateName nvarchar(512),
@PreContentColumnId varchar(36),
@PostContentColumnId varchar(36),
@RewriteUrl nvarchar(Max),
@SitePriceOverrideText nvarchar(255),
@SpecialProductType int,
@GiftCertificateCodePattern nvarchar(30),
@PreTransformLongDescription nvarchar(max),
@SmallImageAlternateText nvarchar(255),
@MediumImageAlternateText nvarchar(255),
@OutOfStockMode int,
@TrackInventory int = 0,
@CustomProperties nvarchar(max),
@GiftWrapPrice numeric(18,10)

AS
	BEGIN TRY
		UPDATE bvc_Product
		SET
		
		SKU=@SKU,
		ProductName=@ProductName,
		ProductTypeID=@ProductTypeID,
		ListPrice=@ListPrice,
		SitePrice=@SitePrice,
		SiteCost=@SiteCost,
		MetaKeywords=@MetaKeywords,
		MetaDescription=@MetaDescription,
		MetaTitle=@MetaTitle,
		TaxExempt=@TaxExempt,
		TaxClass=@TaxClass,
		NonShipping=@NonShipping,
		ShipSeparately=@ShipSeparately,
		ShippingMode=@ShippingMode,
		ShippingWeight=@ShippingWeight,
		ShippingLength=@ShippingLength,
		ShippingWidth=@ShippingWidth,
		ShippingHeight=@ShippingHeight,
		Status=@Status,
		ImageFileSmall=@ImageFileSmall,
		ImageFileMedium=@ImageFileMedium,
		MinimumQty=@MinimumQty,
		ParentID=@ParentID,
		VariantDisplayMode=@VariantDisplayMode,	
		ShortDescription=@ShortDescription,
		LongDescription=@LongDescription,
		ManufacturerID=@ManufacturerID,
		VendorID=@VendorID,
		GiftWrapAllowed=@GiftWrapAllowed,
		ExtraShipFee=@ExtraShipFee,
		LastUpdated = GetDate(),
		Keywords=@Keywords,
		TemplateName=@TemplateName,
		PreContentColumnId=@PreContentColumnId,
		PostContentColumnId=@PostContentColumnId,
		RewriteUrl=@RewriteUrl,
		SitePriceOverrideText=@SitePriceOverrideText,
		SpecialProductType=@SpecialProductType,
		GiftCertificateCodePattern=@GiftCertificateCodePattern,
		PreTransformLongDescription=@PreTransformLongDescription,
		TrackInventory=@TrackInventory,
		SmallImageAlternateText=@SmallImageAlternateText,
		MediumImageAlternateText=@MediumImageAlternateText,
		OutOfStockMode=@OutOfStockMode,
		CustomProperties=@CustomProperties,		
		GiftWrapPrice=@GiftWrapPrice

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
PRINT N'Altering [dbo].[bvc_LineItem_i]'
GO







ALTER PROCEDURE [dbo].[bvc_LineItem_i]
@bvin varchar(36),
@ProductId nvarchar(36),
@Quantity Decimal(18,4),
@OrderBvin nvarchar(36),
@AdjustedPrice decimal(18,10),
@BasePrice decimal(18,10),
@Discounts decimal(18,10),
@ShippingPortion decimal(18,10),
@TaxPortion decimal(18,10),
@LineTotal decimal(18,10),
@CustomProperties ntext,
@QuantityReturned decimal(18,10),
@QuantityShipped decimal(18,10),
@ProductName nvarchar(255),
@ProductSku nvarchar(50),
@ProductShortDescription nvarchar(512),
@StatusCode varchar(36),
@StatusName nvarchar(255),
@AdditionalDiscount decimal(18, 10),
@AdminPrice decimal(18, 10),
@GiftWrapDetails nvarchar(max),
@KitSelections nvarchar(max)

AS
	BEGIN TRY
		INSERT INTO
		bvc_LineItem
		(
		bvin,
		ProductId,
		Quantity,
		OrderBvin,
		AdjustedPrice,
		BasePrice,
		Discounts,
		ShippingPortion,
		TaxPortion,
		LineTotal,
		CustomProperties,
		QuantityReturned,
		QuantityShipped,
		ProductName,
		ProductSku,
		ProductShortDescription,
		StatusCode,
		StatusName,
		AdditionalDiscount,
		AdminPrice,
		LastUpdated,
		GiftWrapDetails,
		KitSelections
		)
		VALUES
		(
		@bvin,
		@ProductId,
		@Quantity,
		@OrderBvin,
		@AdjustedPrice,
		@BasePrice,
		@Discounts,
		@ShippingPortion,
		@TaxPortion,
		@LineTotal,
		@CustomProperties,
		@QuantityReturned,
		@QuantityShipped,
		@ProductName,
		@ProductSku,
		@ProductShortDescription,
		@StatusCode,
		@StatusName,
		@AdditionalDiscount,
		@AdminPrice,
		GetDate(),
		@GiftWrapDetails,
		@KitSelections
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
PRINT N'Altering [dbo].[bvc_Product_ByCategoryFiltered_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Product_ByCategoryFiltered_s]

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
			p.CustomProperties,			
			p.GiftWrapPrice			
			
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
PRINT N'Creating [dbo].[bvc_KitComponent_d]'
GO


CREATE PROCEDURE [dbo].[bvc_KitComponent_d]

@bvin varchar(36)

AS
	BEGIN TRY			
		DECLARE @SortOrder int
		DECLARE @GroupBvin varchar(36)

		BEGIN TRAN
			DELETE bvc_KitPart WHERE ComponentBvin=@bvin		

			SELECT @SortOrder = SortOrder, @GroupBvin = GroupBvin FROM bvc_KitComponent WHERE bvin = @bvin			

			DELETE bvc_KitComponent WHERE bvin=@bvin		

			UPDATE bvc_KitComponent SET SortOrder = SortOrder - 1 WHERE GroupBvin = @GroupBvin AND SortOrder > @SortOrder
		COMMIT
		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK
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
@ExcludedSpecialProductTypeOne int = NULL,
@ExcludedSpecialProductTypeTwo int = NULL,
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
			CustomProperties,			
			GiftWrapPrice
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
				AND
				(@ExcludedSpecialProductTypeOne IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeOne)
				AND
				(@ExcludedSpecialProductTypeTwo IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeTwo)
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
			CustomProperties,			
			GiftWrapPrice, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId
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
			bvc_Product.CustomProperties,			
			bvc_Product.GiftWrapPrice
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
				AND
				(@ExcludedSpecialProductTypeOne IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeOne)
				AND
				(@ExcludedSpecialProductTypeTwo IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeTwo)
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
			CustomProperties,			
			GiftWrapPrice, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
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
			CustomProperties,			
			GiftWrapPrice
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
				AND
				(@ExcludedSpecialProductTypeOne IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeOne)
				AND
				(@ExcludedSpecialProductTypeTwo IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeTwo)
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
			CustomProperties,		
			GiftWrapPrice, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
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
			CustomProperties,			
			GiftWrapPrice
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
				AND
				(@ExcludedSpecialProductTypeOne IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeOne)
				AND
				(@ExcludedSpecialProductTypeTwo IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeTwo)
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
			CustomProperties,			
			GiftWrapPrice,(SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
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
			bvc_Product.CustomProperties,			
			bvc_Product.GiftWrapPrice
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
				AND
				(@ExcludedSpecialProductTypeOne IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeOne)
				AND
				(@ExcludedSpecialProductTypeTwo IS NULL OR SpecialProductType != @ExcludedSpecialProductTypeTwo)
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
			CustomProperties,			
			GiftWrapPrice, (SELECT COUNT(*) FROM cte_Product) AS TotalRowCount FROM cte_Product AS products LEFT JOIN bvc_ProductChoiceCombinations ON products.bvin = bvc_ProductChoiceCombinations.ProductId 
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
PRINT N'Altering [dbo].[bvc_Product_ByCrossSellId_s]'
GO














ALTER PROCEDURE [dbo].[bvc_Product_ByCrossSellId_s]

@bvin varchar(36)

AS
	BEGIN TRY
			SELECT
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
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,		
			CASE LTRIM(RTRIM(pc.DescriptionOverride))
				WHEN '' THEN p.ShortDescription
				ELSE pc.DescriptionOverride
			END	As ShortDescription,
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
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties,			
			GiftWrapPrice
			
			FROM bvc_Product p JOIN bvc_ProductCrossSell pc ON p.bvin = pc.CrossSellBvin
			WHERE pc.ProductBvin = @bvin AND dbo.bvc_ProductAvailableAndActive(CrossSellBvin, 0) = 1
			AND pc.CrossSellBvin <> @bvin
			ORDER BY pc.[Order]


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
PRINT N'Creating [dbo].[bvc_KitGroup_ByProductId_s]'
GO
CREATE PROCEDURE [dbo].[bvc_KitGroup_ByProductId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,DisplayName,ProductId,SortOrder,LastUpdated FROM bvc_KitGroup

		WHERE ProductId=@bvin
	
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
PRINT N'Altering [dbo].[bvc_LineItem_u]'
GO






ALTER PROCEDURE [dbo].[bvc_LineItem_u]
@bvin varchar(36),
@ProductId nvarchar(36),
@Quantity Decimal(18,4),
@OrderBvin nvarchar(36),
@AdjustedPrice decimal(18,10),
@BasePrice decimal(18,10),
@Discounts decimal(18,10),
@ShippingPortion decimal(18,10),
@TaxPortion decimal(18,10),
@LineTotal decimal(18,10),
@CustomProperties ntext,
@QuantityReturned decimal(18,10),
@QuantityShipped decimal(18,10),
@ProductName nvarchar(255),
@ProductSku nvarchar(50),
@ProductShortDescription nvarchar(512),
@StatusCode varchar(36),
@StatusName nvarchar(255),
@AdditionalDiscount decimal(18,10),
@AdminPrice decimal(18,10),
@GiftWrapDetails nvarchar(max),
@KitSelections nvarchar(max)

AS
	BEGIN TRY
		UPDATE
			bvc_LineItem
		SET
		ProductId=@ProductId,
		Quantity=@Quantity,
		OrderBvin=@OrderBvin,
		AdjustedPrice=@AdjustedPrice,
		BasePrice=@BasePrice,
		Discounts=@Discounts,
		ShippingPortion=@ShippingPortion,
		TaxPortion=@TaxPortion,
		LineTotal=@LineTotal,
		CustomProperties=@CustomProperties,
		QuantityReturned=@QuantityReturned,
		QuantityShipped=@QuantityShipped,
		ProductName=@ProductName,
		ProductSku=@ProductSku,
		ProductShortDescription=@ProductShortDescription,
		StatusCode=@StatusCode,
		StatusName=@StatusName,
		AdditionalDiscount=@AdditionalDiscount,
		AdminPrice=@AdminPrice,
		LastUpdated=GetDate(),
		GiftWrapDetails=@GiftWrapDetails,
		KitSelections=@KitSelections
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
PRINT N'Altering [dbo].[bvc_Product_ByUpSellId_s]'
GO














ALTER PROCEDURE [dbo].[bvc_Product_ByUpSellId_s]

@bvin varchar(36)

AS
	BEGIN TRY
			SELECT
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
			Status,
			ImageFileSmall,
			ImageFileMedium,
			CreationDate,
			MinimumQty,
			ParentID,
			VariantDisplayMode,		
			CASE LTRIM(RTRIM(pu.DescriptionOverride))
				WHEN '' THEN p.ShortDescription
				ELSE pu.DescriptionOverride
			END	As ShortDescription,
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
			SpecialProductType,
			GiftCertificateCodePattern,
			PreTransformLongDescription,
			SmallImageAlternateText,
			MediumImageAlternateText,
			TrackInventory,
			OutOfStockMode,
			CustomProperties,			
			GiftWrapPrice
			
			FROM bvc_Product p JOIN bvc_ProductUpSell pu ON p.bvin = pu.UpSellBvin
			WHERE pu.ProductBvin = @bvin AND dbo.bvc_ProductAvailableAndActive(p.Bvin, 0) = 1



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
PRINT N'Altering [dbo].[bvc_LineItem_s]'
GO

ALTER PROCEDURE [dbo].[bvc_LineItem_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 

		bvin,
		ProductId,
		Quantity,
		OrderBvin,
		AdjustedPrice,
		BasePrice,
		Discounts,
		ShippingPortion,
		TaxPortion,
		LineTotal,
		CustomProperties,
		QuantityReturned,
		QuantityShipped,
		ProductName,
		ProductSku,
		ProductShortDescription,
		StatusCode,
		StatusName,
		AdditionalDiscount,
		AdminPrice,
		LastUpdated,
		GiftWrapDetails,
		KitSelections
		FROM 
			bvc_LineItem
		WHERE 
			bvin=@bvin
		
		EXEC bvc_LineItemInput_ByLineItem_s @bvin		
		EXEC bvc_LineItemModifier_ByLineItem_s @bvin
		
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
PRINT N'Altering [dbo].[bvc_WishList_s]'
GO

ALTER PROCEDURE [dbo].[bvc_WishList_s]	
	@bvin varchar(36)	
AS
BEGIN
	BEGIN TRY
		SELECT bvc_WishList.bvin,bvc_WishList.UserId,bvc_WishList.ProductBvin,bvc_WishList.Quantity,bvc_WishList.Modifiers,bvc_WishList.Inputs
		FROM bvc_WishList 
		JOIN bvc_Product 
		on 
		bvc_WishList.ProductBvin = bvc_Product.bvin 
		WHERE 
		bvc_WishList.Bvin = @bvin AND dbo.bvc_ProductAvailableAndActive(bvc_Product.bvin, 0) = 1
		RETURN
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
PRINT N'Creating [dbo].[bvc_KitComponent_ByGroupId_s]'
GO

CREATE PROCEDURE [dbo].[bvc_KitComponent_ByGroupId_s]

@Bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,DisplayName,[Description],GroupBvin,ComponentType,LargeImage,SmallImage,SortOrder,LastUpdated FROM bvc_KitComponent
		WHERE GroupBvin=@Bvin
		Order By SortOrder

		exec bvc_KitPart_ByParentProductID_s @bvin
				
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
PRINT N'Altering [dbo].[bvc_Product_d]'
GO








ALTER PROCEDURE [dbo].[bvc_Product_d]

@bvin varchar(36),
@deleteProductChoices bit = 1

AS

BEGIN
	DECLARE @Ids Table (
		ProductId varchar(36)
	)

	DECLARE @currbvin varchar(36)

	BEGIN TRY
	
		BEGIN TRANSACTION
		
			/* Kit Part and Groups */
			DELETE bvc_KitPart WHERE ProductBvin=@bvin
			DELETE bvc_KitPart WHERE ComponentBvin IN (SELECT bvin FROM bvc_KitComponent WHERE GroupBvin IN (SELECT bvin FROM bvc_KitGroup WHERE ProductId = @bvin))
			DELETE bvc_KitComponent WHERE GroupBvin IN (SELECT bvin FROM bvc_KitGroup WHERE ProductId = @bvin)
			DELETE bvc_KitGroup WHERE ProductId = @bvin

			DELETE bvc_WishList WHERE ProductBvin=@bvin
			DELETE bvc_ProductFileXProduct WHERE ProductID=@bvin
			DELETE bvc_ProductReview WHERE ProductBvin=@bvin
			DELETE bvc_ProductVolumeDiscounts WHERE ProductID=@bvin
			DELETE bvc_ProductImage WHERE ProductID=@bvin
			DELETE bvc_ProductXCategory WHERE ProductID=@bvin
			DELETE bvc_ProductCrossSell WHERE ProductBvin = @bvin
			DELETE bvc_ProductUpSell WHERE ProductBvin = @bvin
			DELETE bvc_ProductUpSell WHERE UpSellBvin = @bvin
			DELETE bvc_ProductCrossSell WHERE CrossSellBvin = @bvin
			DELETE bvc_ProductPropertyValue WHERE ProductBvin = @bvin
			DELETE bvc_CustomUrl WHERE SystemData = @bvin 
			
			/*DELETE bvc_ProductPropertyValue WHERE ProductID=@bvin*/
			DELETE bvc_SaleXProduct WHERE ProductID=@bvin

			EXEC bvc_ProductInventory_ByProductId_d @bvin
			DELETE bvc_ProductImage WHERE ProductID IN (SELECT bvin FROM bvc_Product WHERE ParentID=@bvin)
			
			/*DELETE bvc_ProductPropertyValue WHERE ProductID IN (SELECT bvin FROM bvc_Product WHERE ParentID=@bvin)*/
			DELETE bvc_Product WHERE ParentID=@bvin
			DELETE bvc_Product WHERE bvin=@bvin
			DELETE FROM bvc_ProductChoiceInputOrder WHERE ProductId = @bvin
			
			--declare cursor for use below			
			DECLARE bvin_cursor CURSOR LOCAL
				FOR SELECT * FROM @Ids

			IF @deleteProductChoices = 1
			BEGIN
				--delete out all of our product choices
				INSERT INTO @Ids SELECT DISTINCT bvin FROM bvc_ProductChoices WHERE ProductId = @bvin						
				OPEN bvin_cursor
				FETCH NEXT FROM bvin_cursor	INTO @currbvin

				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC bvc_ProductChoice_d @currbvin
					FETCH NEXT FROM bvin_cursor	INTO @currbvin
				END
				CLOSE bvin_cursor
			END

			--delete out all of our product inputs
			DELETE FROM @Ids
			INSERT INTO @Ids SELECT DISTINCT bvin FROM bvc_ProductInputs WHERE ProductId = @bvin			
			OPEN bvin_cursor
			FETCH NEXT FROM bvin_cursor	INTO @currbvin

			WHILE @@FETCH_STATUS = 0
			BEGIN
				EXEC bvc_ProductInput_d @currbvin
				FETCH NEXT FROM bvin_cursor	INTO @currbvin
			END
			CLOSE bvin_cursor

			--delete out all of our product modifiers
			DELETE FROM @Ids
			INSERT INTO @Ids SELECT DISTINCT bvin FROM bvc_ProductModifier WHERE ProductId = @bvin			
			OPEN bvin_cursor
			FETCH NEXT FROM bvin_cursor	INTO @currbvin

			WHILE @@FETCH_STATUS = 0
			BEGIN
				EXEC bvc_ProductModifier_d @currbvin
				FETCH NEXT FROM bvin_cursor	INTO @currbvin
			END
			CLOSE bvin_cursor
			DEALLOCATE bvin_cursor

			DELETE FROM bvc_ProductXChoice WHERE ProductId = @bvin
			DELETE FROM bvc_ProductXInput WHERE ProductId = @bvin
			DELETE FROM bvc_ProductXModifier WHERE ProductId = @bvin
	
		COMMIT

		--this was placed outside of the transaction because we could potentially be deleting 
		--many rows and there was too much potential for deadlock. It is very important that these rows
		--get deleted, but not crucial.
		DECLARE lineitem_cursor CURSOR LOCAL
			FOR SELECT * FROM @Ids

		DELETE FROM @Ids
		INSERT INTO @Ids SELECT DISTINCT a.bvin FROM bvc_LineItem AS a JOIN bvc_Order AS b ON a.OrderBvin = b.bvin WHERE a.ProductId = @bvin AND b.IsPlaced = 0
		OPEN lineitem_cursor
		FETCH NEXT FROM lineitem_cursor	INTO @currbvin

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC bvc_LineItem_d @currbvin
			FETCH NEXT FROM lineitem_cursor	INTO @currbvin
		END

		CLOSE lineitem_cursor
		DEALLOCATE lineitem_cursor
		
	END TRY
	BEGIN CATCH		
		--cursor cleanup
		IF CURSOR_STATUS('local', 'bvin_cursor') > -1
			CLOSE bvin_cursor

		IF CURSOR_STATUS('local', 'lineitem_cursor') > -1
			CLOSE lineitem_cursor
		
		IF CURSOR_STATUS('local', 'bvin_cursor') = -1
			DEALLOCATE bvin_cursor

		IF CURSOR_STATUS('local', 'lineitem_cursor') = -1
			DEALLOCATE lineitem_cursor		
		
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		
	
		EXEC bvc_EventLog_SQL_i
		RETURN 0
	END CATCH

END

RETURN







































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_WishList_d]'
GO

ALTER PROCEDURE [dbo].[bvc_WishList_d]	
	@bvin varchar(36)	
AS
BEGIN
	BEGIN TRY    
		DELETE FROM bvc_WishList
		WHERE	bvin = @bvin
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
PRINT N'Creating [dbo].[bvc_KitComponent_i]'
GO
CREATE PROCEDURE [dbo].[bvc_KitComponent_i]

@bvin varchar(36),
@DisplayName nvarchar(512),
@Description nvarchar(max),
@GroupBvin varchar(36) = NULL,
@ComponentType int,
@LargeImage nvarchar(max),
@SmallImage nvarchar(max),
@SortOrder int OUTPUT

AS
	BEGIN TRY

	IF (Select Count(bvin) FROM bvc_KitComponent WHERE GroupBvin=@GroupBvin) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_KitComponent WHERE GroupBvin=@GroupBvin)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END

		INSERT INTO bvc_KitComponent
		(
		bvin,
		DisplayName,
		[Description],
		GroupBvin,
		ComponentType,
		SortOrder,
		LargeImage,
		SmallImage,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@DisplayName,
		@Description,
		@GroupBvin,
		@ComponentType,
		@SortOrder,
		@LargeImage,
		@SmallImage,
		GetDate()
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
PRINT N'Creating [dbo].[bvc_KitPart_ByComponentID_s]'
GO
CREATE PROCEDURE [dbo].[bvc_KitPart_ByComponentID_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ComponentBvin,SortOrder,ProductBvin,Description,
			Quantity,Weight,Price,WeightType,PriceType,[IsNull],[IsSelected],LastUpdated FROM bvc_KitPart
		WHERE ComponentBvin=@bvin
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
PRINT N'Creating [dbo].[bvc_KitGroup_d]'
GO


CREATE PROCEDURE [dbo].[bvc_KitGroup_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @SortOrder int
		DECLARE @ProductBvin varchar(36)

		BEGIN TRAN
		
			SELECT @SortOrder = SortOrder, @ProductBvin = ProductId FROM bvc_KitGroup WHERE bvin = @bvin

			DELETE bvc_KitGroup WHERE bvin=@bvin

			UPDATE bvc_KitGroup SET SortOrder = SortOrder - 1 WHERE ProductId = @ProductBvin AND SortOrder > @SortOrder
		COMMIT
		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_KitComponent_s]'
GO


CREATE PROCEDURE [dbo].[bvc_KitComponent_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,DisplayName,[Description],GroupBvin,ComponentType,LargeImage,SmallImage,SortOrder,LastUpdated FROM bvc_KitComponent
		WHERE bvin=@bvin
		
		EXEC bvc_KitPart_ByComponentID_s @bvin
		
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
PRINT N'Altering [dbo].[bvc_Product_s]'
GO



















ALTER PROCEDURE [dbo].[bvc_Product_s]

@bvin varchar(36)

AS
	
	BEGIN TRY
		SELECT

		bvin,
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
		CustomProperties,		
		GiftWrapPrice

		FROM bvc_Product
		WHERE bvin=@bvin 
			
		EXEC bvc_ProductChoice_ByProduct_s @bvin
		EXEC bvc_ProductChoiceCombinations_ForProduct_s @bvin
		EXEC bvc_ProductInput_ByProduct_s @bvin
		EXEC bvc_ProductImageByProduct_s @bvin
		EXEC bvc_ProductReview_ByProductBvin_s @bvin	
		EXEC bvc_ProductModifier_ByProduct_s @bvin

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
PRINT N'Creating [dbo].[bvc_ListItems]'
GO
CREATE TABLE [dbo].[bvc_ListItems]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[listbvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[productbvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[qtydesired] [int] NULL,
[qtyreceived] [int] NULL,
[priority] [int] NULL,
[inputs] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiers] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_Lists]'
GO
CREATE TABLE [dbo].[bvc_Lists]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[userbvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[listtype] [int] NULL,
[listname] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[listdate] [datetime] NULL,
[listcity] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[liststate] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[listcountry] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marriagerole] [int] NULL,
[coregrole] [int] NULL,
[bridesfirstname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[brideslastname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[groomsfirstname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[groomslastname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[babyname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[babygender] [int] NULL,
[relateddate] [bit] NULL,
[publiclist] [bit] NULL,
[defaultlist] [bit] NULL
)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_KitPart]'
GO
ALTER TABLE [dbo].[bvc_KitPart] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_KitPart_bvc_KitPartGroup] FOREIGN KEY ([ComponentBvin]) REFERENCES [dbo].[bvc_KitComponent] ([bvin]),
CONSTRAINT [FK_bvc_KitPart_bvc_Product] FOREIGN KEY ([ProductBvin]) REFERENCES [dbo].[bvc_Product] ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_KitComponent]'
GO
ALTER TABLE [dbo].[bvc_KitComponent] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_KitComponent_bvc_KitGroup] FOREIGN KEY ([GroupBvin]) REFERENCES [dbo].[bvc_KitGroup] ([bvin])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_KitGroup]'
GO
ALTER TABLE [dbo].[bvc_KitGroup] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_KitGroup_bvc_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[bvc_Product] ([bvin])
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
