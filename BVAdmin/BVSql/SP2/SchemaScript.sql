/*
Script created by SQL Compare version 5.2.0.32 from Red Gate Software Ltd at 4/12/2007 11:17:59 AM
Run this script on DEV003.Bvc5750 to make it the same as DEV003.Bvc5944
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
PRINT N'Dropping constraints from [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] DROP CONSTRAINT [PK_bvc_WishList]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
PRINT N'Creating [dbo].[bvc_RMAItem_ByLineItemBvin_s]'
GO












CREATE PROCEDURE [dbo].[bvc_RMAItem_ByLineItemBvin_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvin,
		RMABvin,
		LineItemBvin,
		ItemDescription,
		ItemName,
		Note,
		Reason,
		[Replace],
		Quantity,
		QuantityReceived,
		QuantityReturnedToInventory,
		LastUpdated
		FROM bvc_RMAItem WHERE LineItemBvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product]'
GO
ALTER TABLE [dbo].[bvc_Product] ADD
[SmallImageAlternateText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Product_SmallImageAlternateText] DEFAULT (''),
[MediumImageAlternateText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Product_MediumImageAlternateText] DEFAULT (''),
[OutOfStockMode] [int] NOT NULL CONSTRAINT [DF_bvc_Product_OutOfStockMode] DEFAULT ((0)),
[CustomProperties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Product_ManufacturerId] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_ManufacturerId] ON [dbo].[bvc_Product] ([ManufacturerID]) WITH (ALLOW_PAGE_LOCKS=OFF)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Product_ProductName] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_ProductName] ON [dbo].[bvc_Product] ([ProductName]) WITH (ALLOW_PAGE_LOCKS=OFF)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Product_Status] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_Status] ON [dbo].[bvc_Product] ([Status], [bvin]) WITH (ALLOW_PAGE_LOCKS=OFF)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Product_VendorId] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_VendorId] ON [dbo].[bvc_Product] ([VendorID]) WITH (ALLOW_PAGE_LOCKS=OFF)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_LineItemModifier]'
GO
ALTER TABLE [dbo].[bvc_LineItemModifier] ADD
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_LineItemModifier_Order] DEFAULT ((-1))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_LineItemModifier_ByLineItem_s]'
GO

ALTER PROCEDURE [dbo].[bvc_LineItemModifier_ByLineItem_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvin,
		LineItemBvin,
		ModifierBvin,
		ModifierName,
		ModifierValue,
		DisplayToCustomer,
		[Order],
		LastUpdated
		FROM 
			bvc_LineItemModifier
		WHERE 
			LineItemBvin=@bvin
		ORDER BY [Order]
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
PRINT N'Altering [dbo].[bvc_Country]'
GO
ALTER TABLE [dbo].[bvc_Country] ADD
[ISOAlpha3] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Country_ISOAlpha3] DEFAULT (''),
[ISONumeric] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Country_ISONumeric] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Order]'
GO
ALTER TABLE [dbo].[bvc_Order] ADD
[ThirdPartyOrderId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_ThirdPartyOrderId] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductChoices]'
GO
ALTER TABLE [dbo].[bvc_ProductChoices] ADD
[ChoiceName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductChoices_ChoiceName] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_ProductChoices] ALTER COLUMN [ChoiceDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductChoice_u ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/14/2006
-- Description:	Updates a Product Choice
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoice_u ]
	@bvin varchar(36), 
	@choiceName nvarchar(255),
	@choiceDisplayName nvarchar(255),
	@sharedChoice bit,
	@parentProductId varchar(36),
	@choiceType nvarchar(max),
	@sortOrder int
AS
BEGIN
	BEGIN TRY				
		BEGIN TRANSACTION			
			IF @sharedChoice = 1
				UPDATE bvc_ProductChoices SET ChoiceName = @choiceName, ChoiceDisplayName = @choiceDisplayName, SharedChoice = @sharedChoice, ProductId = '', ChoiceType = @choiceType, LastUpdated = GetDate() Where Bvin = @bvin
			ELSE
				UPDATE bvc_ProductChoices SET ChoiceName = @choiceName, ChoiceDisplayName = @choiceDisplayName, SharedChoice = @sharedChoice, ProductId = @parentProductId, ChoiceType = @choiceType, LastUpdated = GetDate() Where Bvin = @bvin
			
			UPDATE bvc_ProductChoiceInputOrder SET [Order] = @sortOrder, LastUpdated = GetDate() WHERE ChoiceInputId = @bvin AND ProductId = @parentProductId
			--if this is a shared item then we don't know whether or not the input order has already been inserted
			IF (@@ROWCOUNT = 0) AND (@sharedChoice = 1)
			BEGIN			
				INSERT INTO bvc_ProductChoiceInputOrder (ProductId, ChoiceInputId, [Order], LastUpdated) VALUES (@parentProductId, @bvin, @sortOrder, GetDate())
			END

			UPDATE bvc_ProductXChoice SET ProductId = @parentProductId, ChoiceId = @bvin, LastUpdated = GetDate() WHERE ChoiceId = @bvin AND ProductId = @parentProductId
			--if this is a shared item then we don't know whether or not the choice cross product has already been inserted
			IF (@@ROWCOUNT = 0) AND (@sharedChoice = 1)
			BEGIN			
				INSERT INTO bvc_ProductXChoice (ProductId, ChoiceId, LastUpdated) VALUES (@parentProductId, @bvin, GetDate())
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END





























GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_CustomPage]'
GO
ALTER TABLE [dbo].[bvc_CustomPage] ADD
[MetaDescription] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_MetaDescription] DEFAULT (''),
[MetaKeywords] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_MetaKeywords] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserQuestions]'
GO
ALTER TABLE [dbo].[bvc_UserQuestions] ADD
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_UserQuestions_Order] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserQuestion_s]'
GO








ALTER PROCEDURE [dbo].[bvc_UserQuestion_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_UserQuestions WHERE bvin = @bvin ORDER BY [Order]
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
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,LastUpdated
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
PRINT N'Altering [dbo].[bvc_Order_ByCoupon_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Order_ByCoupon_s]

@CouponCode nvarchar(50)

AS
	BEGIN TRY

	SELECT 
		o.bvin,
		FraudScore,
		GrandTotal,
		OrderNumber,
		AffiliateId,
		UserId,
		BillingAddress,
		PaymentStatus,
		ShippingStatus,
		HandlingTotal,
		ShippingTotal,
		SubTotal,
		TaxTotal,
		TaxTotal2,
		Instructions,
		TimeOfOrder,
		IsPlaced,
		ShippingAddress,
		ShippingDiscounts,
		OrderDiscounts,
		CustomProperties,
		ShippingMethodId,
		ShippingMethodDisplayName,
		ShippingProviderId,
		ShippingProviderServiceCode,
		StatusCode,
		StatusName,
		UserEmail,
		GiftCertificates,
		LastProductAdded,
		ThirdPartyOrderId,
		o.LastUpdated

	FROM bvc_Order o LEFT OUTER JOIN bvc_OrderCoupon oc ON o.bvin=oc.OrderBvin

	WHERE CouponCode=@CouponCode AND PaymentStatus=3

	ORDER BY [ID] DESC
	
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
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,LastUpdated 
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
PRINT N'Altering [dbo].[bvc_ProductInputs]'
GO
ALTER TABLE [dbo].[bvc_ProductInputs] ADD
[InputDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductInputs_InputDisplayName] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_ProductInputs] ALTER COLUMN [InputName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInput_ByProduct_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/23/2006
-- Description:	Finds all Product Inputs for a particular product
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInput_ByProduct_s]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT ProdInputs.bvin, ProdInputs.InputName, ProdInputs.InputDisplayName, ProdXInput.ProductId, ProdInputs.SharedInput, 
		ProdInputs.InputType, ProdInputs.DefaultValue, ProdChoiceInputOrder.[Order] FROM bvc_ProductInputs AS ProdInputs 
		JOIN bvc_ProductXInput As ProdXInput ON ProdInputs.Bvin = ProdXInput.InputId
		JOIN bvc_ProductChoiceInputOrder AS ProdChoiceInputOrder ON ProdInputs.bvin = ProdChoiceInputOrder.ChoiceInputId 
		AND ProdXInput.ProductId = ProdChoiceInputOrder.ProductId  
		WHERE ProdXInput.ProductId = @bvin 
		ORDER BY ProdChoiceInputOrder.[Order]
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
PRINT N'Altering [dbo].[bvc_Country_All_s]'
GO


ALTER PROCEDURE [dbo].[bvc_Country_All_s]

AS

	BEGIN TRY
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,LastUpdated
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
PRINT N'Altering [dbo].[bvc_ProductModifier]'
GO
ALTER TABLE [dbo].[bvc_ProductModifier] ADD
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductModifier_Name] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_ProductModifier] ALTER COLUMN [Displayname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductModifier_ByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Finds a Product Modifier for a particular product
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_ByProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT a.bvin, a.[Name], a.DisplayName, a.ProductId, a.Shared, a.[Type], a.Required, a.LastUpdated, c.[Order] FROM bvc_ProductModifier AS a 
			JOIN bvc_ProductXModifier AS b ON a.bvin = b.ModifierId 
			JOIN bvc_ProductChoiceInputOrder AS c ON a.bvin = c.ChoiceInputId AND b.ProductId = c.ProductId WHERE b.ProductId = @bvin
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
				
				SET @Available = (SELECT SUM(QuantityAvailable-QuantityOutOfStockPoint) FROM bvc_ProductInventory WHERE ProductBvin IN (SELECT bvin FROM bvc_Product WHERE ParentId=@ParentBvin))
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
PRINT N'Altering [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] ADD
[AdminPrice] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_AdminPrice] DEFAULT ((-1))
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
		CustomProperties
		
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
PRINT N'Altering [dbo].[bvc_ProductModifier_u ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/14/2006
-- Description:	Updates a Product Modifier
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_u ]
	@bvin varchar(36), 
	@Name nvarchar(255),
	@DisplayName nvarchar(255),
	@Shared bit,
	@ProductId varchar(36),
	@Type nvarchar(max),
	@SortOrder int,
	@Required bit
AS
BEGIN
	BEGIN TRY				
		BEGIN TRANSACTION			
			IF @Shared = 1
				UPDATE bvc_ProductModifier SET [Name] = @Name, DisplayName = @DisplayName, Shared = @Shared, ProductId = '', [Type] = @Type, Required = @Required, LastUpdated = GetDate() Where Bvin = @bvin
			ELSE
				UPDATE bvc_ProductModifier SET [Name] = @Name, DisplayName = @DisplayName, Shared = @Shared, ProductId = @ProductId, [Type] = @Type, Required = @Required, LastUpdated = GetDate() Where Bvin = @bvin
			
			UPDATE bvc_ProductChoiceInputOrder SET [Order] = @sortOrder, LastUpdated = GetDate() WHERE ChoiceInputId = @bvin AND ProductId = @ProductId
			--if this is a shared item then we don't know whether or not the input order has already been inserted
			IF (@@ROWCOUNT = 0) AND (@Shared = 1)
			BEGIN			
				INSERT INTO bvc_ProductChoiceInputOrder (ProductId, ChoiceInputId, [Order], LastUpdated) VALUES (@ProductId, @bvin, @sortOrder, GetDate())
			END

			UPDATE bvc_ProductXModifier SET ProductId = @ProductId, ModifierId = @bvin, LastUpdated = GetDate() WHERE ModifierId = @bvin AND ProductId = @ProductId
			--if this is a shared item then we don't know whether or not the choice cross product has already been inserted
			IF (@@ROWCOUNT = 0) AND (@Shared = 1)
			BEGIN			
				INSERT INTO bvc_ProductXModifier (ProductId, ModifierId, LastUpdated) VALUES (@ProductId, @bvin, GetDate())
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END
































GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductInput_i ]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/23/2006
-- Description:	Inserts a Product Input
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInput_i ]
	@bvin varchar(36), 
	@inputName nvarchar(255),
	@inputDisplayName nvarchar(255),
	@productId varchar(36),
	@sharedInput bit,
	@inputType nvarchar(max),
	@sortOrder int,
	@defaultValue nvarchar(max)
AS
BEGIN
	
	BEGIN TRY
		IF @sharedInput = 1
			SET @productId = '';

		BEGIN TRAN
			INSERT INTO bvc_ProductInputs (bvin, InputName, InputDisplayName, ProductId, SharedInput, InputType, DefaultValue, LastUpdated) Values(@bvin, @inputName, @inputDisplayName, @productId, @sharedInput, @inputType, @defaultValue, GetDate())
			
			if @sharedInput = 0 
				INSERT INTO bvc_ProductXInput (ProductId, InputId, LastUpdated) VALUES (@productId, @bvin, GetDate())

			--if it is shared then we won't have an order yet
			if @sharedInput = 0
				INSERT INTO bvc_ProductChoiceInputOrder (ProductId, ChoiceInputId, [Order], LastUpdated) VALUES (@productId, @bvin, @sortOrder, GetDate())
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH		
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION			
		EXEC bvc_EventLog_SQL_i
	END CATCH
END

























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
			CustomProperties
			
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
PRINT N'Altering [dbo].[bvc_Order_ByLineItemStatus_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Order_ByLineItemStatus_s]

@StatusCode varchar(36)

AS
	
	BEGIN TRY;
		SELECT 
		bvin,
		FraudScore,
		GrandTotal,
		OrderNumber,
		AffiliateId,
		UserId,
		BillingAddress,
		PaymentStatus,
		ShippingStatus,
		HandlingTotal,
		ShippingTotal,
		SubTotal,
		TaxTotal,
		TaxTotal2,
		Instructions,
		TimeOfOrder,
		IsPlaced,
		ShippingAddress,
		ShippingDiscounts,
		OrderDiscounts,
		CustomProperties,
		ShippingMethodId,
		ShippingMethodDisplayName,
		ShippingProviderId,
		ShippingProviderServiceCode,
		StatusCode,
		StatusName,
		UserEmail,
		GiftCertificates,
		LastProductAdded,
		ThirdPartyOrderId,
		LastUpdated 
		FROM bvc_Order

		WHERE
			IsPlaced = 1
			AND			
			(bvin IN (SELECT DISTINCT OrderBvin FROM bvc_LineItem WHERE StatusCode=@StatusCode))
			AND StatusCode <> '09D7305D-BD95-48d2-A025-16ADC827582A'

		ORDER By OrderNumber Desc
				
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
PRINT N'Altering [dbo].[bvc_Order_Range_s]'
GO


ALTER PROCEDURE [dbo].[bvc_Order_Range_s]

@StartOrderNumber int,
@EndOrderNumber int

AS
	BEGIN TRY
		SELECT 
		bvin,
		FraudScore,
		GrandTotal,
		OrderNumber,
		AffiliateId,
		UserId,
		BillingAddress,
		PaymentStatus,
		ShippingStatus,
		HandlingTotal,
		ShippingTotal,
		SubTotal,
		TaxTotal,
		TaxTotal2,
		Instructions,
		TimeOfOrder,
		IsPlaced,
		ShippingAddress,
		ShippingDiscounts,
		OrderDiscounts,
		CustomProperties,
		ShippingMethodId,
		ShippingMethodDisplayName,
		ShippingProviderId,
		ShippingProviderServiceCode,
		StatusCode,
		StatusName,
		UserEmail,
		GiftCertificates,
		LastProductAdded,
		ThirdPartyOrderId,		
		LastUpdated 
		FROM bvc_Order

		WHERE		
			OrderNumber >= @StartOrderNumber
			AND
			OrderNumber <= @EndOrderNumber
			And
			IsPlaced = 1		
			ORDER BY [id]	
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
		CustomProperties

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
PRINT N'Altering [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] ADD
[UserId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_WishList_UserId] DEFAULT (''),
[Quantity] [int] NOT NULL CONSTRAINT [DF_bvc_WishList_Quantity] DEFAULT ((1)),
[Modifiers] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_WishList_Modifiers] DEFAULT (''),
[Inputs] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_WishList_Inputs] DEFAULT ('')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating primary key [PK_bvc_WishList_1] on [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] ADD CONSTRAINT [PK_bvc_WishList_1] PRIMARY KEY CLUSTERED  ([bvin])
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
	BEGIN TRY
		DELETE FROM bvc_WishList WHERE bvin=@bvin
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

		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,LastUpdated
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
			CustomProperties
			
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
PRINT N'Altering [dbo].[bvc_LineItemInput]'
GO
ALTER TABLE [dbo].[bvc_LineItemInput] ADD
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_LineItemInput_Order] DEFAULT ((-1))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_CustomPage_i]'
GO



ALTER PROCEDURE [dbo].[bvc_CustomPage_i]

@bvin varchar(36),
@Name nvarchar(255),
@MenuName nvarchar(100),
@Content ntext,
@ShowInTopMenu int = 0,
@ShowInBottomMenu int = 1,
@PreTransformContent ntext,
@MetaDescription nvarchar(255),
@MetaKeywords nvarchar(255)

AS
	BEGIN TRY
		INSERT INTO
		bvc_CustomPage
		(bvin,[Name],MenuName,[Content],
		ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated)

		VALUES(@bvin,@Name,@MenuName,@Content,
		@ShowInTopMenu,@ShowInBottomMenu,@PreTransformContent,@MetaDescription,@MetaKeywords,GetDate())

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
PRINT N'Altering [dbo].[bvc_LineItemInput_i]'
GO

ALTER PROCEDURE [dbo].[bvc_LineItemInput_i]
@bvin varchar(36),
@LineItemBvin varchar(36),
@InputBvin varchar(36),
@InputName nvarchar(max),
@InputValue nvarchar(max),
@InputDisplayValue nvarchar(max),
@InputAdminDisplayValue nvarchar(max),
@DisplayToCustomer bit,
@Order int

AS
	BEGIN TRY
		INSERT INTO	bvc_LineItemInput (bvin, LineItemBvin, InputBvin, InputName, InputValue, InputDisplayValue, InputAdminDisplayValue, DisplayToCustomer, [Order], LastUpdated)
			VALUES (@bvin, @LineItemBvin, @InputBvin, @InputName, @InputValue, @InputDisplayValue, @InputAdminDisplayValue, @DisplayToCustomer, @Order, GetDate())
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
PRINT N'Altering [dbo].[bvc_RMA]'
GO
ALTER TABLE [dbo].[bvc_RMA] ADD
[DateOfReturn] [datetime] NOT NULL CONSTRAINT [DF_bvc_RMA_DateOfReturn] DEFAULT ('01/01/2000')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_OrderNote_ByOrderId_s]'
GO

ALTER PROCEDURE [dbo].[bvc_OrderNote_ByOrderId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @val nvarchar(max)
		SET @val = (SELECT SettingValue FROM bvc_WebAppSetting WHERE SettingName = 'ReverseOrderNotes')
		IF @val IS NULL
			SET @val = '0'

		IF @val = '0'
		BEGIN	
			SELECT 
			bvin,
			OrderId,
			AuditDate,
			Note,
			NoteType,
			LastUpdated 
			FROM bvc_OrderNote
				WHERE  OrderId=@bvin ORDER BY AuditDate
			RETURN
		END
		ELSE
		BEGIN
			SELECT 
			bvin,
			OrderId,
			AuditDate,
			Note,
			NoteType,
			LastUpdated 
			FROM bvc_OrderNote
				WHERE  OrderId=@bvin ORDER BY AuditDate DESC
			RETURN
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
PRINT N'Altering [dbo].[bvc_LineItemInput_ByLineItem_s]'
GO

ALTER PROCEDURE [dbo].[bvc_LineItemInput_ByLineItem_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvin,
		LineItemBvin,
		InputBvin,
		InputName,
		InputValue,
		InputDisplayValue,
		InputAdminDisplayValue,
		DisplayToCustomer,
		[Order], 
		LastUpdated
		FROM 
			bvc_LineItemInput
		WHERE 
			LineItemBvin=@bvin
		ORDER BY [Order]
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
			CustomProperties
			
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
PRINT N'Altering [dbo].[bvc_ProductInput_u ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/23/2006
-- Description:	Updates a Product Input
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInput_u ]
	@bvin varchar(36), 
	@inputName nvarchar(255),
	@inputDisplayName nvarchar(255),
	@productId varchar(36),
	@sharedInput bit,
	@inputType nvarchar(max),
	@sortOrder int,
	@defaultValue nvarchar(max)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			IF @sharedInput = 1
			BEGIN
				UPDATE bvc_ProductInputs SET InputName = @inputName, InputDisplayName = @inputDisplayName, ProductId = '', SharedInput = @sharedInput, InputType = @inputType, DefaultValue = @defaultValue, LastUpdated = GetDate() WHERE Bvin = @bvin
				UPDATE bvc_ProductXInput SET ProductId = @productId, InputId = @bvin, LastUpdated = GetDate() WHERE ProductId = @productId AND InputId = @bvin
				if (@@ROWCOUNT = 0)
					INSERT INTO bvc_ProductXInput (ProductId, InputId, LastUpdated) VALUES (@productId, @bvin, GetDate())
			END
			ELSE
			BEGIN
				UPDATE bvc_ProductInputs SET InputName = @inputName, InputDisplayName = @inputDisplayName, ProductId = @productId, SharedInput = @sharedInput, InputType = @inputType, DefaultValue = @defaultValue, LastUpdated = GetDate() WHERE Bvin = @bvin
				UPDATE bvc_ProductXInput SET ProductId = @productId, InputId = @bvin, LastUpdated = GetDate() WHERE ProductId = @productId AND InputId = @bvin
			END
			
			UPDATE bvc_ProductChoiceInputOrder SET [Order] = @sortOrder, LastUpdated = GetDate() WHERE ChoiceInputId = @bvin AND ProductId = @productId
			--if this is a shared item then we don't know whether or not the input order has already been inserted
			IF (@@ROWCOUNT = 0) AND (@sharedInput = 1)
			BEGIN
				INSERT INTO bvc_ProductChoiceInputOrder (ProductId, ChoiceInputId, [Order], LastUpdated) VALUES (@productId, @bvin, @sortOrder, GetDate())
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductChoice_ByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Finds a Product Choice for a particular product
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoice_ByProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT DISTINCT ProdChoice.Bvin AS ProductChoiceBvin, ProdChoiceOpt.Bvin AS ProductChoiceOptionBvin, ProdChoice.ChoiceName, ProdChoice.ChoiceDisplayName, 
		ProdChoice.SharedChoice, ProdChoiceOpt.ProductChoiceName, ProdChoiceOpt.[Order] As ProductChoiceOptionOrder, 
		ProdChoiceOpt.[default] As ProductChoiceDefault, ProdChoiceOpt.[null] As ProductChoiceNull, ProdChoice.ChoiceType, 
		ProdChoiceInputOrder.[Order] As ProductChoiceOrder FROM bvc_ProductXChoice AS ProdXChoice JOIN 
		bvc_ProductChoices AS ProdChoice ON ProdXChoice.ChoiceId = ProdChoice.bvin JOIN bvc_ProductChoiceOptions AS 
		ProdChoiceOpt ON ProdChoice.Bvin = ProdChoiceOpt.ProductChoiceId JOIN bvc_ProductChoiceInputOrder AS 
		ProdChoiceInputOrder ON ProdChoiceInputOrder.ProductId = ProdXChoice.ProductId AND ProdChoiceInputOrder.ChoiceInputId = ProdChoice.bvin 
		WHERE ProdXChoice.ProductId = @bvin ORDER BY /*ProdChoice.Bvin,*/ ProdChoiceInputOrder.[Order], ProdChoiceOpt.[Order]
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
@AdminPrice decimal(18,10)

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
		LastUpdated=GetDate()
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
@AdminPrice decimal(18, 10)

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
		LastUpdated
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
PRINT N'Creating [dbo].[bvc_Order_ByThirdPartyOrderId_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Order_ByThirdPartyOrderId_s]

@ThirdPartyOrderId nvarchar(50)

AS
	BEGIN TRY

	SELECT 
		o.bvin,
		FraudScore,
		GrandTotal,
		OrderNumber,
		AffiliateId,
		UserId,
		BillingAddress,
		PaymentStatus,
		ShippingStatus,
		HandlingTotal,
		ShippingTotal,
		SubTotal,
		TaxTotal,
		TaxTotal2,
		Instructions,
		TimeOfOrder,
		IsPlaced,
		ShippingAddress,
		ShippingDiscounts,
		OrderDiscounts,
		CustomProperties,
		ShippingMethodId,
		ShippingMethodDisplayName,
		ShippingProviderId,
		ShippingProviderServiceCode,
		StatusCode,
		StatusName,
		UserEmail,
		GiftCertificates,
		LastProductAdded,
		ThirdPartyOrderId,
		o.LastUpdated

	FROM bvc_Order o 
	WHERE ThirdPartyOrderId = @ThirdPartyOrderId	
	
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
PRINT N'Altering [dbo].[bvc_Taxes_s]'
GO




ALTER PROCEDURE [dbo].[bvc_Taxes_s]

AS
	BEGIN TRY
		SELECT t.Bvin, t.RegionBvin, t.PostalCode, t.CountryBvin, t.CountyBvin, t.TaxClass, t.Rate, t.LastUpdated, t.ApplyToShipping		
		FROM
		bvc_Tax AS t
		LEFT JOIN bvc_Country AS c ON c.Bvin = t.CountryBvin
		LEFT JOIN bvc_Region AS r ON r.Bvin = t.RegionBvin
		LEFT JOIN bvc_County AS co ON co.Bvin = t.CountyBvin
		ORDER BY c.DisplayName, r.Name, co.Name, t.PostalCode

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
		LastUpdated
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
			CustomProperties

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
PRINT N'Altering [dbo].[bvc_LineItemInput_u]'
GO

ALTER PROCEDURE [dbo].[bvc_LineItemInput_u]
@bvin varchar(36),
@LineItemBvin varchar(36),
@InputBvin varchar(36),
@InputName nvarchar(max),
@InputValue nvarchar(max),
@InputDisplayValue nvarchar(max),
@InputAdminDisplayValue nvarchar(max),
@DisplayToCustomer bit,
@Order int

AS
	BEGIN TRY
		UPDATE bvc_LineItemInput SET bvin = @bvin, LineItemBvin = @LineItemBvin, InputBvin = @InputBvin, InputName = @InputName,
		InputValue = @InputValue, InputDisplayValue = @InputDisplayValue, InputAdminDisplayValue = @InputAdminDisplayValue, 
		DisplayToCustomer = @DisplayToCustomer, [Order] = @Order, LastUpdated = GetDate() WHERE bvin = @bvin
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
PRINT N'Altering [dbo].[bvc_CustomPage_All_s]'
GO



ALTER PROCEDURE [dbo].[bvc_CustomPage_All_s]

AS
	BEGIN TRY
		SELECT bvin,[Name],[Content],MenuName,ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated
		FROM
		bvc_Custompage ORDER BY [Name]

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
			CustomProperties
			
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
PRINT N'Altering [dbo].[bvc_ProductModifier_SharedByProduct_s ]'
GO










-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/25/2006
-- Description:	Finds shared product modifiers on a per product basis
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_SharedByProduct_s ]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT DISTINCT b.bvin, b.[Name], b.DisplayName, b.ProductId, b.Shared, b.Type, b.Required, 0 As [Order] FROM bvc_ProductXModifier AS a JOIN bvc_ProductModifier AS b ON a.ModifierId = b.bvin WHERE a.ProductId = @bvin AND b.Shared = 1
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
PRINT N'Altering [dbo].[bvc_ProductChoice_AllShared_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a product input by bvin
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoice_AllShared_s ]
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ChoiceName, ChoiceDisplayName, ProductId, SharedChoice, ChoiceType, 0 As [Order] FROM bvc_ProductChoices WHERE SharedChoice = 1 ORDER BY ChoiceDisplayName
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
PRINT N'Altering [dbo].[bvc_AffiliateQuestions]'
GO
ALTER TABLE [dbo].[bvc_AffiliateQuestions] ADD
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_AffiliateQuestions_Order] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_AffiliateQuestion_i]'
GO







ALTER PROCEDURE [dbo].[bvc_AffiliateQuestion_i]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int

AS
	BEGIN TRY
		SET @Order = (SELECT MAX([Order]) FROM bvc_AffiliateQuestions)
		IF @Order IS NULL
			SET @Order = 0
		SET @Order = @Order + 1

		INSERT INTO	bvc_AffiliateQuestions
		(
		bvin,
		QuestionName,
		QuestionType,
		[Values],
		[Order],
		LastUpdated)
		VALUES(
		@bvin,
		@QuestionName,
		@QuestionType,
		@Values,
		@Order,
		GetDate()
		) 

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_CustomPage_ByShowInBottomMenu_s]'
GO




ALTER PROCEDURE [dbo].[bvc_CustomPage_ByShowInBottomMenu_s]

AS
	BEGIN TRY
		SELECT
		bvin,[Name],[Content],MenuName,ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated
		FROM
		bvc_CustomPage
		WHERE ShowInBottomMenu = 1
		ORDER BY [Name]

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
			Keywords
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
			Keywords
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
PRINT N'Altering [dbo].[bvc_CustomPage_s]'
GO




ALTER PROCEDURE [dbo].[bvc_CustomPage_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvin,[Name],[Content],MenuName,ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated
		FROM
		bvc_CustomPage
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
PRINT N'Altering [dbo].[bvc_ContactUsQuestions]'
GO
ALTER TABLE [dbo].[bvc_ContactUsQuestions] ADD
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_ContactUsQuestions_Order] DEFAULT ((0))
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ContactUsQuestion_u]'
GO

ALTER PROCEDURE [dbo].[bvc_ContactUsQuestion_u]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int

AS
	BEGIN TRY
		UPDATE bvc_ContactUsQuestions SET bvin = @bvin, QuestionName = @QuestionName, QuestionType = @QuestionType, 
			[Values] = @Values, [Order] = @Order, LastUpdated = GetDate() WHERE bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductChoice_CountByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 8/11/2006
-- Description:	Gets count of choices for product
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoice_CountByProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT COUNT(*) As Count From bvc_ProductChoices As a JOIN bvc_ProductXChoice As b ON a.bvin = b.ChoiceId WHERE b.ProductId = @bvin 
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

		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,LastUpdated
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
PRINT N'Altering [dbo].[bvc_UserQuestion_All_s]'
GO







ALTER PROCEDURE [dbo].[bvc_UserQuestion_All_s]

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_UserQuestions ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_UserQuestion_u]'
GO
ALTER PROCEDURE [dbo].[bvc_UserQuestion_u]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int

AS
	BEGIN TRY
		UPDATE bvc_UserQuestions SET bvin = @bvin, QuestionName = @QuestionName, QuestionType = @QuestionType, 
			[Values] = @Values, [Order] = @Order, LastUpdated = GetDate() WHERE bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Order_u]'
GO

ALTER PROCEDURE [dbo].[bvc_Order_u]
@bvin varchar(36),
@FraudScore decimal(18,2),
@GrandTotal decimal(18,10),
@OrderNumber nvarchar(50) = '',
@AffiliateId varchar(36),
@UserId varchar(36),
@BillingAddress ntext,
@PaymentStatus int,
@ShippingStatus int,
@HandlingTotal decimal(18,10),
@ShippingTotal decimal(18,10),
@SubTotal decimal(18,10),
@TaxTotal decimal(18,10),
@TaxTotal2 decimal(18,10),
@Instructions nvarchar(max),
@IsPlaced int,
@ShippingAddress ntext,
@ShippingDiscounts decimal(18,10),
@OrderDiscounts decimal(18,10),
@CustomProperties ntext,
@ShippingMethodId varchar(36),
@ShippingMethodDisplayName nvarchar(255),
@ShippingProviderId varchar(36),
@ShippingProviderServiceCode nvarchar(255),
@StatusCode varchar(36),
@StatusName nvarchar(255),
@UserEmail nvarchar(100),
@GiftCertificates nvarchar(max),
@TimeOfOrder datetime = null,
@LastProductAdded varchar(36),
@ThirdPartyOrderId nvarchar(50)

AS
	BEGIN TRY
		IF @TimeOfOrder = null 
		BEGIN
			Set @TimeOfOrder = GetDate()
		END

		DECLARE @Placed AS int
		SET @Placed = (SELECT IsPlaced FROM bvc_Order WHERE bvin = @bvin)

		IF (@Placed = 0) AND (@IsPlaced = 1)				
		BEGIN
			UPDATE
			bvc_Order
			SET
			TimeOfOrder=GetDate(),
			FraudScore=@FraudScore,
			GrandTotal=@GrandTotal,
			OrderNumber=@OrderNumber,
			AffiliateId=@AffiliateId,
			UserId=@UserId,
			BillingAddress=@BillingAddress,
			PaymentStatus=@PaymentStatus,
			ShippingStatus=@ShippingStatus,
			HandlingTotal=@HandlingTotal,
			ShippingTotal=@ShippingTotal,
			SubTotal=@SubTotal,
			TaxTotal=@TaxTotal,
			TaxTotal2=@TaxTotal2,
			Instructions=@Instructions,
			IsPlaced=@IsPlaced,
			ShippingAddress=@ShippingAddress,
			ShippingDiscounts=@ShippingDiscounts,
			OrderDiscounts=@OrderDiscounts,
			CustomProperties=@CustomProperties,
			ShippingMethodId=@ShippingMethodId,
			ShippingMethodDisplayName=@ShippingMethodDisplayName,
			ShippingProviderId=@ShippingProviderId,
			ShippingProviderServiceCode=@ShippingProviderServiceCode,
			StatusCode=@StatusCode,
			StatusName=@StatusName,
			UserEmail=@UserEmail,
			GiftCertificates=@GiftCertificates,
			LastProductAdded=@LastProductAdded,
			ThirdPartyOrderId=@ThirdPartyOrderId,
			LastUpdated=GetDate()
			WHERE
			bvin=@bvin
		END
		ELSE
		BEGIN
			UPDATE
			bvc_Order
			SET
			FraudScore=@FraudScore,
			GrandTotal=@GrandTotal,
			OrderNumber=@OrderNumber,
			AffiliateId=@AffiliateId,
			UserId=@UserId,
			BillingAddress=@BillingAddress,
			PaymentStatus=@PaymentStatus,
			ShippingStatus=@ShippingStatus,
			HandlingTotal=@HandlingTotal,
			ShippingTotal=@ShippingTotal,
			SubTotal=@SubTotal,
			TaxTotal=@TaxTotal,
			TaxTotal2=@TaxTotal2,
			Instructions=@Instructions,
			IsPlaced=@IsPlaced,
			ShippingAddress=@ShippingAddress,
			ShippingDiscounts=@ShippingDiscounts,
			OrderDiscounts=@OrderDiscounts,
			CustomProperties=@CustomProperties,
			ShippingMethodId=@ShippingMethodId,
			ShippingMethodDisplayName=@ShippingMethodDisplayName,
			ShippingProviderId=@ShippingProviderId,
			ShippingProviderServiceCode=@ShippingProviderServiceCode,
			StatusCode=@StatusCode,
			StatusName=@StatusName,
			UserEmail=@UserEmail,
			GiftCertificates=@GiftCertificates,
			LastProductAdded=@LastProductAdded,
			ThirdPartyOrderId=@ThirdPartyOrderId,
			LastUpdated=GetDate()
			WHERE
			bvin=@bvin
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
		a.QuantityReserved,
		a.Status,		
		a.LastUpdated 
		FROM bvc_ProductInventory AS a JOIN bvc_Product AS b ON a.ProductBvin = b.bvin
		WHERE a.QuantityAvailable <= a.QuantityOutOfStockPoint AND b.TrackInventory = 1
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
@CustomProperties nvarchar(max)

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
		CustomProperties
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
		@CustomProperties
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
@CustomProperties nvarchar(max)



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
		CustomProperties=@CustomProperties

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
PRINT N'Altering [dbo].[bvc_ProductChoice_i ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Inserts a Product Choice Group
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoice_i ]
	@bvin varchar(36), 
	@choiceName nvarchar(255),
	@choiceDisplayName nvarchar(255),
	@sharedChoice bit,
	@parentProductId varchar(36),
	@choiceType nvarchar(max),
	@sortOrder int
AS
BEGIN
	BEGIN TRY
		if @sharedChoice = 1
			SET @parentProductId = ''
		BEGIN TRANSACTION
			INSERT INTO bvc_ProductChoices (bvin, ChoiceName, ChoiceDisplayName, ProductId, SharedChoice, ChoiceType, LastUpdated) VALUES (@bvin, @choiceName, @choiceDisplayName, @parentProductId, @sharedChoice, @choiceType, GetDate())

			--if it is shared we won't have an order yet
			IF @sharedChoice = 0
			BEGIN
				INSERT INTO bvc_ProductChoiceInputOrder (ProductId, ChoiceInputId, [Order], LastUpdated) VALUES (@parentProductId, @bvin, @sortOrder, GetDate())
				INSERT INTO bvc_ProductXChoice (ProductId, ChoiceId, LastUpdated) VALUES (@parentProductId, @bvin, GetDate())
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ContactUsQuestion_All_s]'
GO








ALTER PROCEDURE [dbo].[bvc_ContactUsQuestion_All_s]

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_ContactUsQuestions ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_WishList_u]'
GO
CREATE PROCEDURE [dbo].[bvc_WishList_u]

@bvin varchar(36),
@userId varchar(36),
@ProductBvin varchar(36),
@Quantity int,
@Modifiers nvarchar(max),
@Inputs nvarchar(max)

AS
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







GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductModifier_CountByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 8/11/2006
-- Description:	Gets count of inputs for product
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_CountByProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT COUNT(*) As Count From bvc_ProductModifier As a JOIN bvc_ProductXModifier As b ON a.bvin = b.ModifierId WHERE @bvin = b.ProductId
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
PRINT N'Altering [dbo].[bvc_AffiliateQuestion_All_s]'
GO







ALTER PROCEDURE [dbo].[bvc_AffiliateQuestion_All_s]

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_AffiliateQuestions ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductModifier_s ]'
GO






-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a product modifier by bvin
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_s ]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, [Name], DisplayName, ProductId, Shared, [Type], Required, 0 As [Order] FROM bvc_ProductModifier WHERE bvin = @bvin
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
PRINT N'Altering [dbo].[bvc_ProductChoices_ForProduct_s]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Finds a Product Choice for a particular product
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoices_ForProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT DISTINCT ProdChoice.Bvin AS ProductChoiceBvin, ProdChoiceOpt.Bvin AS ProductChoiceOptionBvin, ProdChoice.ChoiceName, ProdChoice.ChoiceDisplayName, ProdChoiceOpt.ProductChoiceName, ProdChoiceOpt.[Order] As ProductChoiceOrder, ProdChoice.ChoiceType, ProdChoiceOpt.[default] As ProductChoiceDefault FROM bvc_ProductChoiceCombinations AS ProdCombo JOIN bvc_ProductChoices AS ProdChoice ON ProdCombo.ChoiceId = ProdChoice.bvin JOIN bvc_ProductChoiceOptions AS ProdChoiceOpt ON ProdChoice.Bvin = ProdChoiceOpt.ProductChoiceId WHERE ParentProductId = @bvin ORDER BY ProdChoice.Bvin, ProdChoiceOpt.[Order]
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
PRINT N'Altering [dbo].[bvc_Country_s]'
GO




ALTER PROCEDURE [dbo].[bvc_Country_s]

@bvin varchar(36)

AS
	
	BEGIN TRY
		SELECT bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,LastUpdated
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
PRINT N'Altering [dbo].[bvc_LineItemModifier_u]'
GO

ALTER PROCEDURE [dbo].[bvc_LineItemModifier_u]
@bvin varchar(36),
@LineItemBvin varchar(36),
@ModifierBvin varchar(36),
@ModifierName nvarchar(max),
@ModifierValue nvarchar(max),
@DisplayToCustomer bit,
@Order int

AS
	BEGIN TRY
		UPDATE bvc_LineItemModifier SET bvin = @bvin, LineItemBvin = @LineItemBvin, ModifierBvin = @ModifierBvin, ModifierName = @ModifierName,
		ModifierValue = @ModifierValue, DisplayToCustomer = @DisplayToCustomer, [Order] = @Order, LastUpdated = GetDate() WHERE bvin = @bvin
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
		LastUpdated 

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
	@Status int

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
PRINT N'Altering [dbo].[bvc_AffiliateQuestion_s]'
GO








ALTER PROCEDURE [dbo].[bvc_AffiliateQuestion_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_AffiliateQuestions WHERE bvin = @bvin ORDER BY [Order] 
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
	@Status int
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
		LastUpdated=GetDate()
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
PRINT N'Altering [dbo].[bvc_ProductChoiceAndOptionPairs_ByProductCombinationBvin_s ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 5/2/2006
-- Description:	Finds the list of choice and choice option ids for a combination
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoiceAndOptionPairs_ByProductCombinationBvin_s ]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT a.ChoiceId, a.ChoiceOptionId, b.ChoiceName, b.ChoiceDisplayName, c.ProductChoiceName From bvc_ProductChoiceCombinations AS a 
			JOIN bvc_ProductChoices AS b ON a.ChoiceId = b.bvin 
			JOIN bvc_ProductChoiceOptions AS c ON a.ChoiceOptionId = c.bvin 
			JOIN bvc_ProductChoiceInputOrder AS d ON a.ParentProductId = d.ProductId AND a.ChoiceId = d.ChoiceInputId
			WHERE a.ProductId = @bvin
			ORDER BY d.[Order]
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
PRINT N'Altering [dbo].[bvc_Country_i]'
GO

ALTER PROCEDURE [dbo].[bvc_Country_i]

@bvin varchar(36),
@CultureCode varchar(36),
@DisplayName nvarchar(100),
@Active int = 1,
@ISOCode nvarchar(2),
@ISOAlpha3 nvarchar(3),
@ISONumeric nvarchar(3)

AS
	
	BEGIN TRY
		INSERT INTO
		bvc_Country
		(bvin,CultureCode,DisplayName,Active,ISOCode,ISOAlpha3,ISONumeric,LastUpdated)
		 VALUES(@bvin,@CultureCode,@DisplayName,@Active,@ISOCode,@ISOAlpha3,@ISONumeric,GetDate())

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
PRINT N'Altering [dbo].[bvc_ProductInput_AllShared_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds all shared inputs
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInput_AllShared_s ]
AS
BEGIN
	BEGIN TRY
		SELECT bvin, InputName, InputDisplayName, ProductId, SharedInput, InputType, DefaultValue, 0 As [Order], LastUpdated FROM bvc_ProductInputs WHERE SharedInput = 1 ORDER BY InputName
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
			CustomProperties		
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
PRINT N'Altering [dbo].[bvc_AffiliateQuestion_u]'
GO
ALTER PROCEDURE [dbo].[bvc_AffiliateQuestion_u]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int

AS
	BEGIN TRY
		UPDATE bvc_AffiliateQuestions SET bvin = @bvin, QuestionName = @QuestionName, QuestionType = @QuestionType, 
			[Values] = @Values, [Order] = @Order, LastUpdated = GetDate() WHERE bvin = @bvin		
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
@ISONumeric nvarchar(3)

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
PRINT N'Altering [dbo].[bvc_ProductChoice_s ]'
GO






-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a product choice by bvin
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoice_s ]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ChoiceName, ChoiceDisplayName, ProductId, SharedChoice, ChoiceType, 0 As [Order] FROM bvc_ProductChoices WHERE bvin = @bvin
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
PRINT N'Altering [dbo].[bvc_ProductInput_s ]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/24/2006
-- Description:	Finds a product input by bvin
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductInput_s ]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, InputName, InputDisplayName, ProductId, SharedInput, InputType, DefaultValue, 0 As [Order], LastUpdated FROM bvc_ProductInputs WHERE bvin = @bvin
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
PRINT N'Altering [dbo].[bvc_LineItemModifier_i]'
GO

ALTER PROCEDURE [dbo].[bvc_LineItemModifier_i]
@bvin varchar(36),
@LineItemBvin varchar(36),
@ModifierBvin varchar(36),
@ModifierName nvarchar(max),
@ModifierValue nvarchar(max),
@DisplayToCustomer bit,
@Order int

AS
	BEGIN TRY
		INSERT INTO	bvc_LineItemModifier (bvin, LineItemBvin, ModifierBvin, ModifierName, ModifierValue, DisplayToCustomer, [Order], LastUpdated)
		VALUES (@bvin, @LineItemBvin, @ModifierBvin, @ModifierName, @ModifierValue, @DisplayToCustomer, @Order, GetDate())
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
PRINT N'Altering [dbo].[bvc_UserQuestion_i]'
GO







ALTER PROCEDURE [dbo].[bvc_UserQuestion_i]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int

AS
	BEGIN TRY
		SET @Order = (SELECT MAX([Order]) FROM bvc_UserQuestions)
		IF @Order IS NULL
			SET @Order = 0
		SET @Order = @Order + 1

		INSERT INTO	bvc_UserQuestions
		(
		bvin,
		QuestionName,
		QuestionType,
		[Values],
		[Order],
		LastUpdated)
		VALUES(
		@bvin,
		@QuestionName,
		@QuestionType,
		@Values,
		@Order,
		GetDate()
		) 

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ContactUsQuestion_i]'
GO








ALTER PROCEDURE [dbo].[bvc_ContactUsQuestion_i]

@bvin varchar(36),
@QuestionName nvarchar(50),
@QuestionType int,
@Values nvarchar(max),
@Order int

AS
	BEGIN TRY
		SET @Order = (SELECT MAX([Order]) FROM bvc_ContactUsQuestions)
		IF @Order IS NULL
			SET @Order = 0
		SET @Order = @Order + 1

		INSERT INTO	bvc_ContactUsQuestions
		(
		bvin,
		QuestionName,
		QuestionType,
		[Values],
		[Order],
		LastUpdated)
		VALUES(
		@bvin,
		@QuestionName,
		@QuestionType,
		@Values,
		@Order,
		GetDate()
		) 

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductChoice_SharedByProduct_s ]'
GO










-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/25/2006
-- Description:	Finds shared product choices on a per product basis
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductChoice_SharedByProduct_s ]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT DISTINCT b.bvin, b.ChoiceName, b.ChoiceDisplayName, b.ProductId, b.SharedChoice, b.ChoiceType, 0 As [Order] FROM bvc_ProductXChoice AS a JOIN bvc_ProductChoices AS b ON a.ChoiceId = b.bvin WHERE a.ProductId = @bvin AND b.SharedChoice = 1
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
PRINT N'Altering [dbo].[bvc_CustomPage_u]'
GO



ALTER PROCEDURE [dbo].[bvc_CustomPage_u]

@bvin varchar(36),
@Name nvarchar(255),
@MenuName nvarchar(100),
@Content ntext,
@ShowInTopMenu int = 0,
@ShowInBottomMenu int = 1,
@PreTransformContent ntext,
@MetaDescription nvarchar(255),
@MetaKeywords nvarchar(255)


AS
	BEGIN TRY
		UPDATE
		bvc_CustomPage
		SET	
		[Name]=@Name,
		MenuName=@MenuName,
		[Content]=@Content,
		ShowInTopMenu=@ShowInTopMenu,
		ShowInBottomMenu=@ShowInBottomMenu,
		PreTransformContent=@PreTransformContent,
		MetaDescription=@MetaDescription,
		MetaKeywords=@MetaKeywords,
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
PRINT N'Altering [dbo].[bvc_ContactUsQuestion_s]'
GO









ALTER PROCEDURE [dbo].[bvc_ContactUsQuestion_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_ContactUsQuestions WHERE bvin = @bvin ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Order_i]'
GO














ALTER PROCEDURE [dbo].[bvc_Order_i]
@bvin varchar(36),
@FraudScore decimal(18,2),
@GrandTotal decimal(18,10),
@OrderNumber nvarchar(50) = '',
@AffiliateId varchar(36),
@UserId varchar(36),
@BillingAddress ntext,
@PaymentStatus int,
@ShippingStatus int,
@HandlingTotal decimal(18,10),
@ShippingTotal decimal(18,10),
@SubTotal decimal(18,10),
@TaxTotal decimal(18,10),
@TaxTotal2 decimal(18,10),
@Instructions nvarchar(max),
@IsPlaced int,
@ShippingAddress ntext,
@ShippingDiscounts decimal(18,10),
@OrderDiscounts decimal(18,10),
@CustomProperties ntext,
@ShippingMethodId varchar(36),
@ShippingMethodDisplayName nvarchar(255),
@ShippingProviderId varchar(36),
@ShippingProviderServiceCode nvarchar(255),
@StatusCode varchar(36),
@StatusName nvarchar(255),
@UserEmail nvarchar(100),
@GiftCertificates nvarchar(max),
@TimeOfOrder datetime = null,
@LastProductAdded varchar(36),
@ThirdPartyOrderId nvarchar(50)

AS
	BEGIN TRY
		IF @TimeOfOrder = null 
		BEGIN
			Set @TimeOfOrder = GetDate()
		END

		INSERT INTO
		bvc_Order
		(
		bvin,
		FraudScore,
		GrandTotal,
		OrderNumber,
		AffiliateId,
		UserId,
		BillingAddress,
		PaymentStatus,
		ShippingStatus,
		HandlingTotal,
		ShippingTotal,
		SubTotal,
		TaxTotal,
		TaxTotal2,
		Instructions,
		TimeOfOrder,
		IsPlaced,
		ShippingAddress,
		ShippingDiscounts,
		OrderDiscounts,
		CustomProperties,
		ShippingMethodId,
		ShippingMethodDisplayName,
		ShippingProviderId,
		ShippingProviderServiceCode,
		StatusCode,
		StatusName,
		UserEmail,
		GiftCertificates,
		LastProductAdded,
		ThirdPartyOrderId,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@FraudScore,
		@GrandTotal,
		@OrderNumber,
		@AffiliateId,
		@UserId,
		@BillingAddress,
		@PaymentStatus,
		@ShippingStatus,
		@HandlingTotal,
		@ShippingTotal,
		@SubTotal,
		@TaxTotal,
		@TaxTotal2,
		@Instructions,
		@TimeOfOrder,
		@IsPlaced,
		@ShippingAddress,
		@ShippingDiscounts,
		@OrderDiscounts,
		@CustomProperties,
		@ShippingMethodId,
		@ShippingMethodDisplayName,
		@ShippingProviderId,
		@ShippingProviderServiceCode,
		@StatusCode,
		@StatusName,
		@UserEmail,
		@GiftCertificates,
		@LastProductAdded,
		@ThirdPartyOrderId,
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
PRINT N'Altering [dbo].[bvc_RMA_All_s]'
GO












ALTER PROCEDURE [dbo].[bvc_RMA_All_s]
@Status int = -1,
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS
	BEGIN TRY;
		WITH RMAs AS
		(SELECT 
		ROW_NUMBER() OVER (ORDER BY Number) As RowNum,
		bvin,
		OrderBvin,
		[Name],
		Number,
		EmailAddress,
		PhoneNumber,
		Comments,
		Status,
		DateOfReturn,
		LastUpdated
		FROM bvc_RMA 
		WHERE (Status = @Status OR (@Status = -1 And Status != 0)))
		-- we don't want to return 0's since they are not submitted

		SELECT *, (SELECT COUNT(*) FROM RMAs) AS TotalRowCount FROM RMAs 
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
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
PRINT N'Altering [dbo].[bvc_ProductModifier_AllShared_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a shared product modifier by bvin
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_AllShared_s ]
AS
BEGIN
	BEGIN TRY
		SELECT bvin, [Name], DisplayName, ProductId, Shared, Type, Required, 0 As [Order] FROM bvc_ProductModifier WHERE Shared = 1 ORDER BY DisplayName
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
PRINT N'Altering [dbo].[bvc_Order_s]'
GO






ALTER PROCEDURE [dbo].[bvc_Order_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		FraudScore,
		GrandTotal,
		OrderNumber,
		AffiliateId,
		UserId,
		BillingAddress,
		PaymentStatus,
		ShippingStatus,
		HandlingTotal,
		ShippingTotal,
		SubTotal,
		TaxTotal,
		TaxTotal2,
		Instructions,
		TimeOfOrder,
		IsPlaced,
		ShippingAddress,
		ShippingDiscounts,
		OrderDiscounts,
		CustomProperties,
		ShippingMethodId,
		ShippingMethodDisplayName,
		ShippingProviderId,
		ShippingProviderServiceCode,
		StatusName,
		StatusCode,
		UserEmail,
		GiftCertificates,
		LastProductAdded,
		ThirdPartyOrderId,
		LastUpdated 
		FROM bvc_Order
		WHERE  bvin=@bvin

		-- Load Line Items
		exec bvc_LineItem_ByOrderId_s @bvin

		-- Load Associated Store Products
		exec bvc_Product_ByOrder_s @bvin

		-- Load Notes
		exec bvc_OrderNote_ByOrderId_s @bvin

		-- Load Order Payments
		exec bvc_OrderPayment_ByOrderId_s @bvin

		-- Load Order Coupons
		exec bvc_OrderCoupon_ByOrderBvin_s @bvin

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
PRINT N'Altering [dbo].[bvc_ProductModifier_i ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Inserts a Product Modifier
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_i ]
	@bvin varchar(36), 
	@Name nvarchar(255),
	@DisplayName nvarchar(255),
	@Shared bit,
	@ProductId varchar(36),
	@Type nvarchar(max),
	@sortOrder int,
	@required bit
AS
BEGIN
	BEGIN TRY
		if @Shared = 1
			SET @ProductId = ''
		BEGIN TRANSACTION
			INSERT INTO bvc_ProductModifier (bvin, [Name], DisplayName, ProductId, Shared, Type, Required, LastUpdated) VALUES (@bvin, @Name, @DisplayName, @ProductId, @Shared, @Type, @Required, GetDate())

			--if it is shared we won't have an order yet
			IF @Shared = 0
			BEGIN
				INSERT INTO bvc_ProductChoiceInputOrder (ProductId, ChoiceInputId, [Order], LastUpdated) VALUES (@ProductId, @bvin, @sortOrder, GetDate())
				INSERT INTO bvc_ProductXModifier (ProductId, ModifierId, LastUpdated) VALUES (@ProductId, @bvin, GetDate())
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION		

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
	DECLARE @inventoryStatus int
	DECLARE @outOfStockMode int
	
	SELECT @status = a.Status, @trackInventory = a.TrackInventory, @inventoryStatus = b.Status, @outOfStockMode = a.OutOfStockMode FROM bvc_Product AS a LEFT JOIN bvc_ProductInventory AS b ON a.bvin = b.ProductBvin WHERE a.bvin = @ProductBvin

	IF @status = 0 OR @status IS NULL
	BEGIN
		SET @Result = 0
	END
	ELSE
	BEGIN
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
					IF @inventoryStatus = 0
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
					ELSE IF @inventoryStatus = 1
					BEGIN
						SET @Result = 1
					END
					ELSE IF @inventoryStatus IS NULL
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
PRINT N'Altering [dbo].[bvc_ProductCrossSell_Count_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/17/2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductCrossSell_Count_s] 
	
	@bvin varchar(36)
	
AS
BEGIN
	BEGIN TRY
		SELECT COUNT(*) As [Count] FROM bvc_ProductCrossSell WHERE ProductBvin = @bvin AND dbo.bvc_ProductAvailableAndActive(CrossSellBvin, 0) = 1
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
			CustomProperties
			
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
			CustomProperties
			
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
	BEGIN TRY		
		INSERT INTO bvc_WishList ([bvin],UserId,ProductBvin,Quantity,Modifiers,Inputs) VALUES(@bvin,@UserId,@ProductBvin,@Quantity,@Modifiers,@Inputs)
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
PRINT N'Altering [dbo].[bvc_RMA_i]'
GO












ALTER PROCEDURE [dbo].[bvc_RMA_i]
@bvin varchar(36),
@OrderBvin varchar(36),
@Name nvarchar(150),
@EmailAddress nvarchar(150),
@PhoneNumber nvarchar(30),
@Comments nvarchar(Max),
@Status int,
@Number int OUTPUT

AS
	BEGIN TRY
		INSERT INTO
		bvc_RMA
		(
		bvin,
		OrderBvin,
		[Name],
		EmailAddress,
		PhoneNumber,
		Comments,
		Status,
		DateOfReturn,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@OrderBvin,
		@Name,
		@EmailAddress,
		@PhoneNumber,
		@Comments,
		@Status,
		GetDate(),
		GetDate()	
		)
		IF @@ROWCOUNT > 0
			SET @Number = (SELECT Number FROM bvc_RMA WHERE bvin = @bvin)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



























GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductCount_ByCategory_s]'
GO











ALTER PROCEDURE [dbo].[bvc_ProductCount_ByCategory_s]

@bvin varchar(36)

AS
	BEGIN TRY			
		SELECT
		Count(*) As [Count]			
		FROM bvc_Product p JOIN bvc_ProductXCategory px ON p.bvin = px.ProductID
		WHERE p.ParentID=''
		AND px.CategoryID = @bvin			
		AND dbo.bvc_ProductAvailableAndActive(px.ProductId, 0) = 1
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
PRINT N'Altering [dbo].[bvc_RMA_s]'
GO












ALTER PROCEDURE [dbo].[bvc_RMA_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		OrderBvin,
		[Name],
		Number,
		EmailAddress,
		PhoneNumber,
		Comments,
		Status,
		DateOfReturn,
		LastUpdated
		FROM bvc_RMA WHERE bvin = @bvin				
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
		CustomProperties

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
PRINT N'Altering [dbo].[bvc_Product_SuggestedItems]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_SuggestedItems]

@MaxResults bigint,
@bvin varchar(36)

AS

	BEGIN TRY
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
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductUpSell_Count_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/17/2006
-- Description:	
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductUpSell_Count_s] 
	
	@bvin varchar(36)
	
AS
BEGIN
	BEGIN TRY
		SELECT COUNT(*) As [Count] FROM bvc_ProductUpSell WHERE ProductBvin = @bvin AND dbo.bvc_ProductAvailableAndActive(UpSellBvin, 0) = 1	
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
PRINT N'Creating [dbo].[bvc_WishList_s]'
GO

CREATE PROCEDURE [dbo].[bvc_WishList_s]

@bvin varchar(36)

AS
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








GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Product_ProductsOrderedCount_s]'
GO









ALTER PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_s]

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
PRINT N'Altering [dbo].[bvc_WishList_ForUser_s]'
GO

ALTER PROCEDURE [dbo].[bvc_WishList_ForUser_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvc_WishList.bvin,bvc_WishList.UserId,bvc_WishList.ProductBvin,bvc_WishList.Quantity,bvc_WishList.Modifiers,bvc_WishList.Inputs
		FROM bvc_WishList 
		JOIN bvc_Product 
		on 
		bvc_WishList.ProductBvin = bvc_Product.bvin 
		WHERE 
		bvc_WishList.UserId = @bvin AND dbo.bvc_ProductAvailableAndActive(bvc_Product.bvin, 0) = 1
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
PRINT N'Creating [dbo].[bvc_Product_BySkuAll_s]'
GO











CREATE PROCEDURE [dbo].[bvc_Product_BySkuAll_s]

@bvin varchar(36)

AS
	BEGIN TRY
		DECLARE @ProductBvin varchar(36)
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
PRINT N'Altering [dbo].[bvc_Product_ByCategory_s]'
GO


ALTER PROCEDURE [dbo].[bvc_Product_ByCategory_s]

@bvin varchar(36),
@ignoreInventory bit = 0,
@showInactive bit = 1,
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS
	BEGIN TRY
			DECLARE @DisplaySortOrder int
			SET @DisplaySortOrder = (SELECT DisplaySortOrder FROM bvc_Category WHERE Bvin = @bvin);

			WITH products AS (SELECT
			RowNum = 
				CASE 
					WHEN @DisplaySortOrder = 0 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 1 THEN ROW_NUMBER() OVER (ORDER BY SortOrder)
					WHEN @DisplaySortOrder = 2 THEN ROW_NUMBER() OVER (ORDER BY ProductName)
					WHEN @DisplaySortOrder = 3 THEN ROW_NUMBER() OVER (ORDER BY SitePrice)
					WHEN @DisplaySortOrder = 4 THEN ROW_NUMBER() OVER (ORDER BY SitePrice DESC)
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
			
			FROM bvc_Product p JOIN bvc_ProductXCategory px ON p.bvin = px.ProductID LEFT JOIN bvc_ProductInventory AS bpi ON p.bvin = bpi.ProductBvin
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
				(@InventoryStatus IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status=@InventoryStatus))
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
				(@InventoryStatus IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status=@InventoryStatus))
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
				(@InventoryStatus IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status=@InventoryStatus))
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
				(@InventoryStatus IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status=@InventoryStatus))
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
				(@InventoryStatus IS NULL OR EXISTS (Select ProductBvin FROM bvc_ProductInventory WHERE Status=@InventoryStatus))
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
PRINT N'Altering [dbo].[bvc_Order_ByCriteria_s]'
GO













ALTER PROCEDURE [dbo].[bvc_Order_ByCriteria_s]

@Keyword nvarchar(Max) = NULL,
@StatusCode varchar(36) = NULL,
@PaymentStatus int = NULL,
@ShippingStatus int = NULL,
@StartDate datetime = NULL,
@EndDate datetime = NULL,
@IsPlaced int = NULL,
@AffiliateId varchar(36) = NULL,
@OrderNumber nvarchar(50) = NULL,
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS
	
	BEGIN TRY;
		WITH Orders AS
		(SELECT
		ROW_NUMBER() OVER (ORDER BY TimeOfOrder DESC) As RowNum, 
		bvin,
		FraudScore,
		GrandTotal,
		OrderNumber,
		AffiliateId,
		UserId,
		BillingAddress,
		PaymentStatus,
		ShippingStatus,
		HandlingTotal,
		ShippingTotal,
		SubTotal,
		TaxTotal,
		TaxTotal2,
		Instructions,
		TimeOfOrder,
		IsPlaced,
		ShippingAddress,
		ShippingDiscounts,
		OrderDiscounts,
		CustomProperties,
		ShippingMethodId,
		ShippingMethodDisplayName,
		ShippingProviderId,
		ShippingProviderServiceCode,
		StatusCode,
		StatusName,
		UserEmail,
		GiftCertificates,
		LastProductAdded,
		ThirdPartyOrderId,
		LastUpdated 
		FROM bvc_Order

		WHERE
			(IsPlaced = @IsPlaced OR @IsPlaced IS NULL)
			AND
			(
			OrderNumber LIKE @Keyword OR 
			BillingAddress LIKE @Keyword OR
			ShippingAddress LIKE @Keyword OR
			GrandTotal LIKE @Keyword OR
			UserEmail LIKE @Keyword OR 
			@Keyword is NULL
			)
			AND
			(StatusCode=@StatusCode OR @StatusCode IS NULL)
			AND
			(PaymentStatus=@PaymentStatus OR @PaymentStatus IS NULL)
			AND
			(ShippingStatus = @ShippingStatus OR @ShippingStatus IS NULL)
			AND
			(
				(TimeOfOrder >= @StartDate OR @StartDate IS NULL)
				AND
				(TimeOfOrder <= @EndDate OR @EndDate IS NULL)
			)
			AND
			(AffiliateId = @AffiliateId OR @AffiliateId IS NULL)
			AND
			(OrderNumber = @OrderNumber OR @OrderNumber IS NULL))
		
		SELECT *, (SELECT COUNT(*) FROM Orders) AS TotalRowCount FROM Orders
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		RETURN		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










































GO

UPDATE bvc_WishList SET UserId = Bvin, Bvin = NEWID() WHERE UserId = ''
GO

IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_RMAItem_LineItemBvin] on [dbo].[bvc_RMAItem]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_RMAItem_LineItemBvin] ON [dbo].[bvc_RMAItem] ([LineItemBvin]) WITH (ALLOW_PAGE_LOCKS=OFF)
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_ProductChoices]'
GO
ALTER TABLE [dbo].[bvc_ProductChoices] ADD CONSTRAINT [DF_bvc_ProductChoices_ChoiceDisplayName] DEFAULT ('') FOR [ChoiceDisplayName]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_ProductInputs]'
GO
ALTER TABLE [dbo].[bvc_ProductInputs] ADD CONSTRAINT [DF_bvc_ProductInputs_InputName] DEFAULT ('') FOR [InputName]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_ProductModifier]'
GO
ALTER TABLE [dbo].[bvc_ProductModifier] ADD CONSTRAINT [DF_bvc_ProductModifier_Displayname] DEFAULT ('') FOR [Displayname]
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
