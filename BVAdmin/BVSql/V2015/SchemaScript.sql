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




IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Order]'
GO
ALTER TABLE [dbo].[bvc_Order] ADD
[SalesPersonId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_SalesPersonId] DEFAULT (N'')
GO




IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_User]'
GO
ALTER TABLE [dbo].[bvc_User] ADD
[IsSalesPerson] [int] NOT NULL CONSTRAINT [DF_bvc_User_IsSalesPerson] DEFAULT (N'0')
GO



IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_Category_LatestProductCount_u]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_LatestProductCount_u]

AS

	BEGIN TRY
		UPDATE bvc_Category
		SET LatestProductCount = (
			SELECT COUNT(*) 
			FROM bvc_ProductXCategory AS pxc
			JOIN bvc_Product AS p ON p.bvin = pxc.ProductId
			WHERE 
				pxc.CategoryId = bvc_Category.bvin
				AND dbo.bvc_ProductAvailableAndActive(p.bvin, 0) = 1)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO




IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Order_ByCoupon_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Order_ByCoupon_s]

@CouponCode nvarchar(50),
@StartDate datetime = null,
@EndDate datetime = null

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
		o.LastUpdated,
		SalesPersonId

	FROM bvc_Order o 
	LEFT OUTER JOIN bvc_OrderCoupon oc ON o.bvin=oc.OrderBvin
	WHERE 
		CouponCode = @CouponCode 
		AND PaymentStatus=3
		AND (
			(@StartDate IS NULL OR TimeOfOrder >= @StartDate)
			AND
			(@EndDate IS NULL OR TimeOfOrder <= @EndDate)
		)

	ORDER BY [ID] DESC
	
	RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

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
@SalesPersonId nvarchar(36) = NULL,
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
		LastUpdated,
		SalesPersonId
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
			(OrderNumber = @OrderNumber OR @OrderNumber IS NULL)
			AND
			(SalesPersonId = @SalesPersonId OR @SalesPersonId IS NULL)
			)
		
		SELECT *, (SELECT COUNT(*) FROM Orders) AS TotalRowCount FROM Orders
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
			OPTION (RECOMPILE)
		RETURN		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

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
		LastUpdated,
		SalesPersonId
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




IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Order_ByThirdPartyOrderId_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Order_ByThirdPartyOrderId_s]

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
		o.LastUpdated,
		SalesPersonId

	FROM bvc_Order o 
	WHERE ThirdPartyOrderId = @ThirdPartyOrderId	
	
	RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

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
@ThirdPartyOrderId nvarchar(50),
@SalesPersonId varchar(36)

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
		LastUpdated,
		SalesPersonId
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
		GetDate(),
		@SalesPersonId
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

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
		LastUpdated,
		SalesPersonId
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
		LastUpdated,
		SalesPersonId
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
@ThirdPartyOrderId nvarchar(50),
@SalesPersonId varchar(36)

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
			TimeOfOrder=@TimeOfOrder,
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
			LastUpdated=GetDate(),
			SalesPersonId=@SalesPersonId
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
			LastUpdated=GetDate(),
			SalesPersonId=@SalesPersonId
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
PRINT N'Altering [dbo].[bvc_ProductModifier_AllShared_s]'
GO
-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a shared product modifier by bvin
-- =============================================
ALTER PROCEDURE [dbo].[bvc_ProductModifier_AllShared_s]
AS
	BEGIN TRY
		SELECT bvin, [Name], DisplayName, ProductId, Shared, Type, Required, 0 As [Order] FROM bvc_ProductModifier WHERE Shared = 1 ORDER BY Name
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

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
	BEGIN TRY
		SELECT bvin, ChoiceName, ChoiceDisplayName, ProductId, SharedChoice, ChoiceType, 0 As [Order] FROM bvc_ProductChoices WHERE SharedChoice = 1 ORDER BY ChoiceName
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
@ShortDescription nvarchar(512),
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
@ShortDescription nvarchar(512),
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
PRINT N'Altering [dbo].[bvc_Product_TopSellers_ByCategory_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Product_TopSellers_ByCategory_s]
	@CategoryID NVARCHAR(36) = NULL,
	@StartDate DATETIME = NULL,
	@EndDate DATETIME = NULL,
	@MaximumRows INT = 1000

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
		FROM (
			SELECT TOP(@MaximumRows)
				(CASE p.ParentID
					WHEN '' THEN p.bvin
					ELSE p.ParentID
				END) AS ProductID,
				SUM(li.Quantity) AS Quantity
			FROM bvc_LineItem AS li
			JOIN bvc_ProductXCategory AS pxc ON li.ProductId = pxc.ProductId
			INNER JOIN bvc_Product as p ON li.ProductId = p.bvin
			WHERE
				li.OrderBvin IN (
					SELECT	o.bvin
					FROM	bvc_Order AS o
					WHERE	o.IsPlaced = 1
							AND (o.TimeOfOrder >= @StartDate OR @StartDate IS NULL)
							AND (o.TimeOfOrder <= @EndDate OR @EndDate IS NULL)
				)
				AND (pxc.CategoryId = @CategoryID)
			GROUP BY (CASE p.ParentID
					WHEN '' THEN p.bvin
					ELSE p.ParentID
				END)
			ORDER BY SUM(li.Quantity) DESC
		) AS tbl
		JOIN bvc_Product AS p ON p.bvin = tbl.ProductID
		
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
PRINT N'Altering [dbo].[bvc_Product_TopSellers_s]'
GO
ALTER PROCEDURE [dbo].[bvc_Product_TopSellers_s]
	@StartDate DATETIME = NULL,
	@EndDate DATETIME = NULL,
	@MaximumRows INT = 1000
	
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
		FROM (
			SELECT TOP(@MaximumRows)
				(CASE p.ParentID
					WHEN '' THEN p.bvin
					ELSE p.ParentID
				END) AS ProductID,
				SUM(l.Quantity) AS Quantity
			FROM bvc_LineItem AS l
			INNER JOIN bvc_Product as p ON l.ProductId = p.bvin
			WHERE
				l.OrderBvin IN (
					SELECT	o.bvin
					FROM	bvc_Order AS o
					WHERE	o.IsPlaced = 1
							AND (o.TimeOfOrder >= @StartDate OR @StartDate IS NULL)
							AND (o.TimeOfOrder <= @EndDate OR @EndDate IS NULL)
				)
			GROUP BY (CASE p.ParentID
					WHEN '' THEN p.bvin
					ELSE p.ParentID
				END)
			ORDER BY SUM(l.Quantity) DESC
		) AS tbl
		JOIN bvc_Product AS p ON p.bvin = tbl.ProductID
		
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
				IF @Available IS NOT NULL AND @Reserved IS NOT NULL
				BEGIN
					UPDATE bvc_ProductInventory
					SET 
					QuantityAvailable=@Available,
					QuantityReserved=@Reserved,
					QuantityOutOfStockPoint = 0,
					Status=@Status
					WHERE ProductBvin=@ParentBvin
				END
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
PRINT N'Creating [dbo].[bvc_Category_All_Light_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_All_Light_s]

@bvin varchar(36) = '-1',
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS
	BEGIN TRY

		IF @bvin <> '-1'
		BEGIN
			
			SELECT
				bvin,
				[Name],
				'' AS [Description],
				ParentID,
				SortOrder,
				'' AS MetaKeywords,
				'' AS MetaDescription,
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
				'' AS PostContentColumnId,
				'' AS PreContentColumnId,
				RewriteUrl,
				ShowTitle,
				'' AS Criteria,
				CustomPageId,
				'' AS PreTransformDescription,
				'' AS Keywords,
				CustomerChangeableSortOrder,
				NULL AS CustomProperties,
				ShortDescription
			FROM bvc_Category
			WHERE ParentID = @bvin
			ORDER BY SortOrder
		END
		ELSE
		BEGIN
			SELECT
				bvin,
				[Name],
				'' AS [Description],
				ParentID,
				SortOrder,
				'' AS MetaKeywords,
				'' AS MetaDescription,
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
				'' AS PostContentColumnId,
				'' AS PreContentColumnId,
				RewriteUrl,
				ShowTitle,
				'' AS Criteria,
				CustomPageId,
				'' AS PreTransformDescription,
				'' AS Keywords,
				CustomerChangeableSortOrder,
				NULL AS CustomProperties,
				ShortDescription
			FROM bvc_Category
			ORDER BY SortOrder
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
PRINT N'Altering [dbo].[bvc_UserAccount_ByAffiliateID_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByAffiliateID_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_All_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_All_s]

AS

	BEGIN TRY
		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
				Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
				LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
				PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
			
		FROM bvc_User
		ORDER BY [UserName],[LastName],[FirstName]

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
PRINT N'Altering [dbo].[bvc_UserAccount_ByAffiliateID_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByAffiliateID_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_ByCriteria_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByCriteria_s]
@FirstName nvarchar(50) = NULL,
@LastName nvarchar(100) = NULL,
@Email nvarchar(100) = NULL,
@UserName nvarchar(100) = NULL,
@StartRowIndex int = 0,
@MaximumRows int = 9999999


AS

BEGIN

	BEGIN TRY
		SET NOCOUNT ON;
		
		WITH UserAccounts AS
		(SELECT ROW_NUMBER() OVER (ORDER BY LastName, FirstName, UserName) As RowNum,
			bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
			
		FROM bvc_User
		WHERE 
			(username = @UserName OR @UserName IS NULL) 
			AND (firstname = @FirstName OR @FirstName IS NULL) 
			AND (lastname = @LastName OR @LastName IS NULL) 
			AND (email = @Email OR @Email IS NULL))

		SELECT *, (SELECT COUNT(*) FROM UserAccounts) AS TotalRowCount FROM UserAccounts
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
			OPTION (RECOMPILE)
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
PRINT N'Altering [dbo].[bvc_UserAccount_ByEmail_All_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByEmail_All_s]
	@Email NVARCHAR(100)
	
AS

	BEGIN TRY
		SELECT 
			bvin,
			[UserName],
			[Password],
			[Firstname],
			[LastName],
			Salt,
			TaxExempt,
			Email,
			CreationDate,
			LastLoginDate,
			PasswordHint,
			Comment,
			AddressBook,
			LastUpdated,
			PasswordAnswer,
			PasswordFormat,
			Locked,
			LockedUntil,
			FailedLoginCount,
			BillingAddress,
			ShippingAddress,
			PricingGroup,
			CustomQuestionAnswers,
			PasswordLastSet,
			PasswordLastThree,
			CustomProperties,
			IsSalesPerson
		FROM bvc_User
		WHERE Email = @Email

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
PRINT N'Altering [dbo].[bvc_UserAccount_ByEmail_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByEmail_s]

@UserEmail nvarchar(100)

AS
	BEGIN TRY
		--Declare @bvin varchar(36)
		--SET @bvin = (SELECT bvin FROM bvc_User WHERE Email=@UserEmail)
		
		--exec bvc_UserAccount_s @bvin

		SELECT TOP 1 bvin,[UserName],[Password],[Firstname],[LastName],Salt,
		TaxExempt,Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,LastUpdated,
		PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
		PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
		FROM bvc_User 
		WHERE Email = @UserEmail

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
PRINT N'Altering [dbo].[bvc_UserAccount_ByManufacturerID_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByManufacturerID_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY		
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Manufacturer ON bvc_UserXContact.ContactId = bvc_Manufacturer.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_ByRoleID_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByRoleID_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXRole WHERE RoleID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_ByVendorID_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ByVendorID_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY		
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Vendor ON bvc_UserXContact.ContactId = bvc_Vendor.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY		
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Affiliate ON bvc_UserXContact.ContactId = bvc_Affiliate.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_ExcludeManufacturerId_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ExcludeManufacturerId_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY		
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Manufacturer ON bvc_UserXContact.ContactId = bvc_Manufacturer.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_ExcludeVendorId_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_ExcludeVendorId_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Vendor ON bvc_UserXContact.ContactId = bvc_Vendor.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_Filter_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_Filter_s]
	
@filter nvarchar(max),
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS

BEGIN

	BEGIN TRY
		SET NOCOUNT ON;
		
		WITH UserAccounts AS
		(SELECT ROW_NUMBER() OVER (ORDER BY LastName, FirstName, UserName) As RowNum,
			bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
		FROM bvc_User
		WHERE (username LIKE @filter) OR (firstname LIKE @filter) OR
			(lastname LIKE @filter) OR (email LIKE @filter) OR
			(AddressBook LIKE @filter) OR (BillingAddress LIKE @filter)
			OR (ShippingAddress LIKE @filter))

		SELECT *, (SELECT COUNT(*) FROM UserAccounts) AS TotalRowCount FROM UserAccounts
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
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
PRINT N'Altering [dbo].[bvc_UserAccount_i]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_i]

@bvin varchar(36),
@Username nvarchar(100),
@Password varchar(36),
@FirstName varchar(36),
@LastName nvarchar(100),
@Salt varchar(36),
@TaxExempt int,
@Email nvarchar(100),
@CreationDate datetime,
@LastLoginDate datetime,
@PasswordHint nvarchar(Max),
@Comment ntext,
@AddressBook ntext,
@PasswordAnswer nvarchar(Max),
@PasswordFormat int,
@Locked int,
@LockedUntil datetime,
@FailedLoginCount int,
@BillingAddress nvarchar(Max),
@ShippingAddress nvarchar(Max),
@PricingGroup varchar(36),
@CustomQuestionAnswers nvarchar(Max),
@PasswordLastSet DateTime,
@PasswordLastThree nvarchar(1024),
@CustomProperties nvarchar(Max),
@IsSalesPerson int

AS

	BEGIN TRY
		INSERT INTO bvc_User
		(bvin,
		[UserName],
		[Password],
		[FirstName],
		[LastName],
		Salt,
		TaxExempt,
		Email,
		CreationDate,
		LastLoginDate,
		PasswordHint,
		Comment,
		AddressBook,
		LastUpdated,
		PasswordAnswer,
		PasswordFormat,
		Locked,
		LockedUntil,
		FailedLoginCount,
		BillingAddress,
		ShippingAddress,
		PricingGroup,
		CustomQuestionAnswers,
		PasswordLastSet,
		PasswordLastThree,
		CustomProperties,
		IsSalesPerson
		)
		
		VALUES
		(@bvin,
		@UserName,
		@Password,
		@FirstName,
		@LastName,
		@Salt,
		@TaxExempt,
		@Email,
		@CreationDate,
		@LastLoginDate,
		@PasswordHint,
		@Comment,
		@AddressBook,
		GetDate(),
		@PasswordAnswer,
		@PasswordFormat,
		@Locked,
		@LockedUntil,
		@FailedLoginCount,
		@BillingAddress,
		@ShippingAddress,
		@PricingGroup,
		@CustomQuestionAnswers,
		@PasswordLastSet,
		@PasswordLastThree,
		@CustomProperties,
		@IsSalesPerson
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
PRINT N'Altering [dbo].[bvc_UserAccount_NotInRole_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_NotInRole_s]

	@bvin varchar(36)

AS

BEGIN

	BEGIN TRY
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXRole WHERE RoleID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Altering [dbo].[bvc_UserAccount_s]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_s]

@bvin varchar(36)

AS
	BEGIN TRY	
		SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,
		TaxExempt,Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,LastUpdated,
		PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
		PasswordLastSet, PasswordLastThree, CustomProperties, IsSalesPerson
		FROM bvc_User Where bvin=@bvin

		exec bvc_Address_ByUserId_s @bvin

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
PRINT N'Altering [dbo].[bvc_UserAccount_u]'
GO
ALTER PROCEDURE [dbo].[bvc_UserAccount_u]

@bvin varchar(36),
@UserName nvarchar(100),
@Password varchar(36),
@FirstName varchar(36),
@LastName nvarchar(100),
@Salt varchar(36),
@TaxExempt int,
@Email nvarchar(100),
@CreationDate datetime,
@LastLoginDate datetime,
@PasswordHint nvarchar(Max),
@Comment ntext,
@AddressBook ntext,
@PasswordAnswer nvarchar(Max),
@PasswordFormat int,
@Locked int,
@LockedUntil datetime,
@FailedLoginCount int,
@BillingAddress nvarchar(Max),
@ShippingAddress nvarchar(Max),
@PricingGroup varchar(36),
@CustomQuestionAnswers nvarchar(Max),
@PasswordLastSet DateTime,
@PasswordLastThree nvarchar(1024),
@CustomProperties nvarchar(Max),
@IsSalesPerson int

AS
	BEGIN TRY
		UPDATE bvc_User
		SET 
		[UserName]=@Username,
		[Password]=@Password,
		[FirstName]=@FirstName,
		Salt=@Salt,
		[LastName]=@LastName,
		TaxExempt=@TaxExempt,
		Email=@Email,
		CreationDate = @CreationDate,
		LastLoginDate=@LastLoginDate,
		PasswordHint=@PasswordHint,
		Comment=@Comment,
		AddressBook=@AddressBook,
		LastUpdated=GetDate(),
		PasswordAnswer=@PasswordAnswer,
		PasswordFormat=@PasswordFormat,
		Locked=@Locked,
		LockedUntil=@LockedUntil,
		FailedLoginCount=@FailedLoginCount,
		BillingAddress=@BillingAddress,
		ShippingAddress=@ShippingAddress,
		PricingGroup=@PricingGroup,
		CustomQuestionAnswers=@CustomQuestionAnswers,
		PasswordLastSet = @PasswordLastSet,
		PasswordLastThree = @PasswordLastThree,
		CustomProperties = @CustomProperties, 
		IsSalesPerson = @IsSalesPerson
		
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
PRINT N'Creating [dbo].[bvc_UserAccount_AllSalesPeople_s]'
GO
CREATE PROCEDURE [dbo].[bvc_UserAccount_AllSalesPeople_s]

AS

BEGIN

	BEGIN TRY
		SELECT 
			bvin,
			[UserName],
			[Password],
			[Firstname],
			[LastName],
			Salt,
			TaxExempt,
			Email,
			CreationDate,
			LastLoginDate,
			PasswordHint,
			Comment,
			AddressBook,
			LastUpdated,
			PasswordAnswer,
			PasswordFormat,
			Locked,
			LockedUntil,
			FailedLoginCount,
			BillingAddress,
			ShippingAddress,
			PricingGroup,
			CustomQuestionAnswers,
			PasswordLastSet,
			PasswordLastThree, 
			CustomProperties,
			IsSalesPerson
		FROM bvc_User
		WHERE IsSalesPerson = 1
		ORDER BY [UserName],[LastName],[FirstName]
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
PRINT N'Creating [dbo].[bvc_AffiliateReferral_Count_ByCriteria_s]'
GO
CREATE PROCEDURE [dbo].[bvc_AffiliateReferral_Count_ByCriteria_s]

@AffiliateId varchar(36),
@StartDate datetime,
@EndDate datetime

AS
	BEGIN TRY
		SELECT COUNT(*) 
		FROM bvc_AffiliateReferral 
		WHERE 
			(Affid = @AffiliateId OR @AffiliateId IS NULL)
			AND (TimeOfReferral > @StartDate OR @StartDate IS NULL)
			AND (TimeOfReferral < @EndDate OR @EndDate IS NULL)
		OPTION (RECOMPILE)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO



IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Manufacturer_TopSellers_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Manufacturer_TopSellers_s]
	@StartDate datetime = NULL,
	@EndDate datetime = NULL
AS

	BEGIN TRY
		
		SELECT
			DisplayName,
			SUM(LineQuantity) AS Quantity, 
			SUM(LineTotal) AS Total
		FROM (
			SELECT	
				li.Quantity AS LineQuantity,
				li.LineTotal,
				COALESCE(p2.ManufacturerId, p.ManufacturerId) AS ManufacturerId
			FROM bvc_LineItem AS li
			JOIN bvc_Product AS p ON li.ProductId = p.bvin
			LEFT JOIN bvc_Product AS p2 ON p.ParentID = p2.bvin
			JOIN bvc_Order AS o ON li.OrderBvin = o.Bvin
			WHERE	
				(@StartDate IS NULL OR o.TimeOfOrder >= @StartDate) 
				AND (@EndDate IS NULL OR o.TimeOfOrder <= @EndDate)
				AND	o.IsPlaced = 1
		) AS tbl
		JOIN bvc_Manufacturer AS m ON m.bvin = ManufacturerId
		GROUP BY ManufacturerId, m.DisplayName
		ORDER BY Total DESC

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
PRINT N'Altering [dbo].[bvc_Order_UserTotals_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Order_UserTotals_s]
@StartDate datetime = NULL,
@EndDate datetime = NULL

AS

	BEGIN TRY
      SELECT 
            o.UserID,
			o.UserEmail,
            Sum(o.GrandTotal) as Total,
            u.FirstName,
            u.LastName,
            u.UserName,
			u.Email
      FROM bvc_Order o JOIN bvc_User u on o.UserId = u.bvin
      WHERE o.PaymentStatus = 3 AND (
			(@StartDate IS NULL OR TimeOfOrder >= @StartDate)
			AND
			(@EndDate IS NULL OR TimeOfOrder <= @EndDate)
		)
      GROUP BY o.UserID,u.Firstname,u.LastName,u.UserName,o.UserEmail,u.Email
      ORDER BY Total DESC
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
PRINT N'Creating [dbo].[bvc_Product_Count_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_Count_s]

AS

BEGIN

	SELECT COUNT(*) AS NumberOfProducts 
	FROM bvc_Product WITH(NOLOCK) 
	WHERE ParentID = ''

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
		IF @ParentBvin = ''
			SET @ParentBvin = @ProductBvin

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
				IF @Available IS NOT NULL AND @Reserved IS NOT NULL
				BEGIN
					UPDATE bvc_ProductInventory
					SET 
					QuantityAvailable=@Available,
					QuantityReserved=@Reserved,
					QuantityOutOfStockPoint = 0,
					Status=@Status
					WHERE ProductBvin=@ParentBvin
				END
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

		exec bvc_ProductInventory_UpdateParent_u @ProductBvin
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
PRINT N'Creating [dbo].[bvc_AuthenticationToken_Expired_d]'
GO

CREATE PROCEDURE [dbo].[bvc_AuthenticationToken_Expired_d]

@DaysExpired int = 7

AS

	BEGIN TRY
		DELETE
		FROM bvc_AuthenticationToken 
		WHERE ExpirationDate < DATEADD(D, -1 * @DaysExpired, GETDATE())
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
PRINT N'Altering [dbo].[bvc_Product_SearchEngine_s]'
GO

ALTER PROCEDURE [dbo].[bvc_Product_SearchEngine_s]
	@keyword nvarchar(1024) = NULL,
	@SortBy int = -1,
	@SortOrder int = -1,
	@Status int = NULL,
	@ParentId varchar(36) = NULL,
	@InventoryStatus int = NULL,
	@ProductTypeId varchar(36) = NULL,
	@CategoryId varchar(36) = NULL,
	@NotCategoryId varchar(36) = NULL,
	@ManufacturerId varchar(36) = NULL,
	@VendorId varchar(36) = NULL,
	@MinPrice decimal = NULL,
	@MaxPrice decimal = NULL,
	@CreatedAfter datetime = NULL,
	@LastXItems int = 9999999,
	@SpecialProductTypeOne varchar(36) = NULL,
	@SpecialProductTypeTwo varchar(36) = NULL,
	@ExcludedSpecialProductTypeOne varchar(36) = NULL,
	@ExcludedSpecialProductTypeTwo varchar(36) = NULL,
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
	@SearchProductTypeName bit = 1,
	@SearchMetaDescription bit = 1,
	@SearchMetaKeywords bit = 1,
	@SearchShortDescription bit = 1,
	@SearchMetaTitle bit = 1,
	@SearchLongDescription bit = 1,
	@SearchKeywords bit = 1,
	@SkuWeight decimal = 1.0,
	@ProductNameWeight decimal = 1.0,
	@ProductTypeNameWeight decimal = 1.0,
	@MetaKeywordsWeight decimal = 1.0,
	@MetaDescriptionWeight decimal = 1.0,
	@MetaTitleWeight decimal = 1.0,
	@ShortDescriptionWeight decimal = 1.0,
	@LongDescriptionWeight decimal = 1.0,
	@KeywordsWeight decimal = 1.0,
	@MinimumRank decimal(3,2) = 0.0,
	@MaximumIndexRows int = 32000000, 
	@StartRowIndex int = 0,
	@MaximumRows int = 9999999

AS

BEGIN TRY

	DECLARE @keywordAnd NVARCHAR(2048)
	DECLARE @keywordAndWildcard NVARCHAR(2048)
	DECLARE @keywordOr NVARCHAR(2048)
	DECLARE @keywordOrWildcard NVARCHAR(2048)
	DECLARE @searchChoiceProducts INT
	
	SET @keyword = REPLACE(@keyword, '''', '''''')
	SET @keywordAnd = RTRIM(REPLACE(REPLACE(@keyword, ' ', ' AND '), '"', ' '))
	SET @keywordAndWildcard = '"' + REPLACE(@keywordAnd, ' AND ', '*" AND "') + '*"'
	SET @keywordOr = RTRIM(REPLACE(REPLACE(@keyword, ' ', ' OR '), '"', ' '))
	SET @keywordOrWildcard = '"' + REPLACE(@keywordOr, ' OR ', '*" OR "') + '*"'
	SET @searchChoiceProducts = 
		CASE 
			WHEN @ParentId IS NULL THEN
				0	-- search ALL products
			WHEN LEN(@ParentId) > 0 THEN
				1	-- search choice products
			ELSE
				-1	-- search parent products
		END
	
	
	-- build custom properties WHERE clause
	DECLARE @PropertyWhereClause NVARCHAR(MAX)
	SET @PropertyWhereClause = ''

	IF @Property1 IS NOT  NULL
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property1 + '''AND PropertyValue=''' + @PropertyValue1 + ''') '
	IF @Property2 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property2 + '''AND PropertyValue=''' + @PropertyValue2 + ''') '
	END
	IF @Property3 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property3 + '''AND PropertyValue=''' + @PropertyValue3 + ''') '
	END
	IF @Property4 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property4 + '''AND PropertyValue=''' + @PropertyValue4 + ''') '
	END
	IF @Property5 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property5 + '''AND PropertyValue=''' + @PropertyValue5 + ''') '
	END
	IF @Property6 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property6 + '''AND PropertyValue=''' + @PropertyValue6 + ''') '
	END
	IF @Property7 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property7 + '''AND PropertyValue=''' + @PropertyValue7 + ''') '
	END
	IF @Property8 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property8 + '''AND PropertyValue=''' + @PropertyValue8 + ''') '
	END
	IF @Property9 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property9 + '''AND PropertyValue=''' + @PropertyValue9 + ''') '
	END
	IF @Property10 IS NOT  NULL
	BEGIN
		IF LEN(@PropertyWhereClause) > 0
			SET @PropertyWhereClause = @PropertyWhereClause + ' AND '
		SET @PropertyWhereClause = @PropertyWhereClause + ' EXISTS (Select ProductBvin FROM bvc_ProductPropertyValue WHERE ProductBvin=bvin AND PropertyBvin=''' + @Property10 + '''AND PropertyValue=''' + @PropertyValue10 + ''') '
	END
		
	
	DECLARE	@Search_SQL NVARCHAR(MAX)
	SET @Search_SQL = ''
	
	DECLARE @SQL NVARCHAR(MAX)
	SET @SQL = '
		;WITH
		cte_SkuSearch([KEY], [RANK]) AS (
			/*-- CONTAINSTABLE
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY], 
					[RANK]
				FROM CONTAINSTABLE(bvc_Product, Sku, ''' + @keywordAndWildcard + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END
				END + '
			) AS tbl
			GROUP BY [KEY]
			*/
			/*-- LIKE (rank determined by closest match of @keyword length to Sku length) */
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY], 
					CAST(LEN(''' + @keyword + ''') * 2 - LEN(p.Sku) + 50 AS DECIMAL) AS [RANK]
				FROM bvc_Product AS p
				WHERE
					p.Sku LIKE ''%' + @keyword + '%''' + 
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						AND p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END
					WHEN @searchChoiceProducts > 0 THEN '
						AND p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END
				END + '
			) AS tbl
			GROUP BY [KEY]
			/*ORDER BY [RANK] DESC*/
		),'
	SET @SQL = @SQL + '
		cte_ProductNameSearch([KEY], [RANK]) AS (
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY], 
					[RANK]
				FROM FREETEXTTABLE(bvc_Product, ProductName, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END
				END + '
			) AS tbl
			GROUP BY [KEY]
		),'
	SET @SQL = @SQL + '
		cte_ProductTypeNameSearch([KEY], [RANK]) AS (
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT p.bvin AS [KEY], [RANK]
				FROM FREETEXTTABLE(bvc_ProductType, ProductTypeName, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.ProductTypeId = [KEY]
				WHERE p.ParentId = ''''
			) AS tbl
			GROUP BY [KEY]
		),'
	SET @SQL = @SQL + '
		cte_MetaKeywordsSearch([KEY], [RANK]) AS (
			/*-- FREETEXTTABLE
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY], 
					[RANK]
				FROM FREETEXTTABLE(bvc_Product, MetaKeywords, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
			*/
			/*-- CONTAINSTABLE (OR) */
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY], 
					[RANK]
				FROM CONTAINSTABLE(bvc_Product, MetaKeywords, ''' + @keywordOr + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
		),'
	SET @SQL = @SQL + '
		cte_MetaDescriptionSearch([KEY], [RANK]) AS (
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY],
					[RANK]
				FROM FREETEXTTABLE(bvc_Product, MetaDescription, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
		),'
	SET @SQL = @SQL + '
		cte_MetaTitleSearch([KEY], [RANK]) AS (
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT  
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY], 
					[RANK]
				FROM FREETEXTTABLE(bvc_Product, MetaTitle, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
		),'
	SET @SQL = @SQL + '
		cte_ShortDescriptionSearch([KEY], [RANK]) AS (
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY],
					[RANK]
				FROM FREETEXTTABLE(bvc_Product, ShortDescription, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
		),'
	SET @SQL = @SQL + '
		cte_LongDescriptionSearch([KEY], [RANK]) AS (
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY],
					[RANK]
				FROM FREETEXTTABLE(bvc_Product, LongDescription, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
		),'
	SET @SQL = @SQL + '
		cte_KeywordsSearch([KEY], [RANK]) AS (
			/*-- FREETEXTTABLE
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY],
					[RANK]
				FROM FREETEXTTABLE(bvc_Product, Keywords, ''' + @keyword + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
			*/			
			/*-- CONTAINSTABLE (OR) */
			SELECT [KEY], MAX([RANK])
			FROM (
				SELECT 
					CASE
						WHEN p.ParentId = '''' THEN
							p.bvin
						ELSE
							p.ParentId
					END AS [KEY],
					[RANK]
				FROM CONTAINSTABLE(bvc_Product, Keywords, ''' + @keywordOr + ''', ' + CAST(@maximumIndexRows AS NVARCHAR(36)) + ')
				JOIN bvc_Product AS p ON p.bvin = [KEY]' +
				CASE
					WHEN @searchChoiceProducts < 0 THEN '
						WHERE p.ParentId = ''''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					WHEN @searchChoiceProducts > 0 THEN '
						WHERE p.ParentId = ''' + @ParentId + '''
						'
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' AND ' + @PropertyWhereClause ELSE '' END 
					ELSE
						''
						+ 
						CASE WHEN LEN(@PropertyWhereClause) > 0 THEN ' WHERE ' + @PropertyWhereClause ELSE '' END 
				END + '
			) AS tbl
			GROUP BY [KEY]
		),'
			
	SET @SQL = @SQL + @Search_SQL + '
		cte_SearchResults AS (
			SELECT 
				[KEY], 
				aggregateRank, 
				ROW_NUMBER() OVER (ORDER BY ' + 
				CASE 
					WHEN (@SortBy = 0) THEN
						CASE 
							WHEN (@SortOrder = 0) THEN 'p.ProductName ASC' 
							WHEN (@SortOrder = 1) THEN 'p.ProductName DESC' 
						END
					WHEN (@SortBy = 1) THEN 
						'(CASE WHEN m.bvin IS NULL THEN 0 ELSE 1 END) DESC, m.DisplayName ASC, p.ProductName ASC'
					WHEN (@SortBy = 2) THEN
						'p.CreationDate DESC'
					WHEN (@SortBy = 3) THEN 
						CASE 
							WHEN (@SortOrder = 0) THEN 'p.SitePrice ASC, p.ProductName ASC' 
							WHEN (@SortOrder = 1) THEN 'p.SitePrice DESC, p.ProductName ASC' 
						END
					WHEN (@SortBy = 4) THEN
						'(CASE WHEN v.bvin IS NULL THEN 0 ELSE 1 END) DESC, v.DisplayName ASC, p.ProductName ASC'
					ELSE
						'aggregateRank DESC'
				END + '
				) AS RowNum,
				p.bvin,
				p.Sku,
				p.ProductName,			
				p.ProductTypeID,			
				p.ListPrice,
				p.SitePrice,
				p.SiteCost,
				p.MetaKeywords,
				p.MetaDescription,
				p.MetaTitle,
				p.TaxExempt,
				p.TaxClass,
				p.NonShipping,
				p.ShipSeparately,
				p.ShippingMode,
				p.ShippingWeight,
				p.ShippingLength,
				p.ShippingWidth,
				p.ShippingHeight,
				p.[Status],
				p.ImageFileSmall,
				p.ImageFileMedium,
				p.CreationDate,
				p.MinimumQty,
				p.ParentId,
				p.VariantDisplayMode,	
				p.ShortDescription,
				p.LongDescription,
				p.ManufacturerID,
				p.VendorID,
				p.GiftWrapAllowed,
				p.ExtraShipFee,
				p.LastUpdated,
				p.Keywords,
				p.TemplateName,
				p.PreContentColumnId,
				p.PostContentColumnId,
				p.RewriteUrl,
				p.SitePriceOverrideText,
				p.SpecialProductType,
				p.GiftCertificateCodePattern,
				p.PreTransformLongDescription,
				p.SmallImageAlternateText,
				p.MediumImageAlternateText,
				p.TrackInventory,
				p.OutOfStockMode,
				p.CustomProperties,			
				p.GiftWrapPrice
			FROM (
				SELECT
					[KEY], 
					SUM(normalizedRank) AS aggregateRank
				FROM (
				'
			
	SET @Search_SQL = @Search_SQL +
					-- Sku
					CASE
						WHEN @SearchSKU = 1 THEN '
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT COUNT(*) FROM cte_SkuSearch) > 0 THEN
										CAST((SELECT MAX([RANK]) FROM cte_SkuSearch) AS DECIMAL)
									ELSE
										1.0
								END) * ' + CAST(@SkuWeight AS NVARCHAR(12)) + ') AS normalizedRank
							FROM cte_SkuSearch
							'
						ELSE
							''
					END
					
	SET @Search_SQL = @Search_SQL +
					-- ProductName
					CASE
						WHEN @SearchProductName = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
						
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_ProductNameSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_ProductNameSearch)
									ELSE
										1
								END) * ' + CAST(@ProductNameWeight AS NVARCHAR(12)) + ') AS normalizedRank
							FROM cte_ProductNameSearch
							'
						ELSE
							''
					END
	
	SET @Search_SQL = @Search_SQL +
					-- ProductTypeName
					CASE
						WHEN @SearchProductTypeName = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
						
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_ProductTypeNameSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_ProductTypeNameSearch)
									ELSE
										1
								END) * ' + CAST(@ProductTypeNameWeight AS NVARCHAR(12)) + ') AS normalizedRank
							FROM cte_ProductTypeNameSearch
							'
						ELSE
							''
					END
					
	SET @Search_SQL = @Search_SQL +
					-- MetaKeywords
					CASE
						WHEN @SearchMetaKeywords = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
							
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_MetaKeywordsSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_MetaKeywordsSearch)
									ELSE
										1
								END) * ' + CAST(@MetaKeywordsWeight AS NVARCHAR(12)) + ') AS normalizedRank
							FROM cte_MetaKeywordsSearch
							'
						ELSE
							''
					END
					
	SET @Search_SQL = @Search_SQL +
					-- MetaDescription
					CASE
						WHEN @SearchMetaDescription = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
							
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_MetaDescriptionSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_MetaDescriptionSearch)
									ELSE
										1
								END) * ' + CAST(@MetaDescriptionWeight AS NVARCHAR(12)) + ') AS normalizedRank
								FROM cte_MetaDescriptionSearch
							'
						ELSE
							''
					END
					
	SET @Search_SQL = @Search_SQL +
					-- MetaTitle
					CASE
						WHEN @SearchMetaTitle = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
							
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_MetaTitleSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_MetaTitleSearch)
									ELSE
										1
								END) * ' + CAST(@MetaTitleWeight AS NVARCHAR(12)) + ') AS normalizedRank
							FROM cte_MetaTitleSearch
							'
						ELSE
							''
					END
					
	SET @Search_SQL = @Search_SQL +	
					-- ShortDescription
					CASE
						WHEN @SearchShortDescription = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
							
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_ShortDescriptionSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_ShortDescriptionSearch)
									ELSE
										1
								END) * ' + CAST(@ShortDescriptionWeight AS NVARCHAR(12)) + ') AS normalizedRank
							FROM cte_ShortDescriptionSearch
							'
						ELSE
							''
					END
					
	SET @Search_SQL = @Search_SQL +	
					-- LongDescription
					CASE
						WHEN @SearchLongDescription = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
							
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_LongDescriptionSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_LongDescriptionSearch)
									ELSE
										1
								END) * ' + CAST(@LongDescriptionWeight AS NVARCHAR(12)) + ') AS normalizedRank
								FROM cte_LongDescriptionSearch
							'
						ELSE
							''
					END
					
	SET @Search_SQL = @Search_SQL +
					-- Keywords
					CASE
						WHEN @SearchKeywords = 1 THEN 
							CASE
								WHEN LEN(@Search_SQL) > 0 THEN '
									UNION ALL
									'
								ELSE
									''
							END + '
							
							SELECT [KEY], (CAST([RANK] AS DECIMAL) / (
								CASE 
									WHEN (SELECT MAX([RANK]) FROM cte_KeywordsSearch) > 0 THEN
										(SELECT MAX([RANK]) FROM cte_KeywordsSearch)
									ELSE
										1
								END) * ' + CAST(@KeywordsWeight AS NVARCHAR(12)) + ') AS normalizedRank
								FROM cte_KeywordsSearch
							'
						ELSE
							''
					END
					
	SET @SQL = @SQL + @Search_SQL + '
				) as aggregateSearch
				GROUP BY [KEY]
			) AS aggregateSearchResults
			JOIN bvc_Product AS p ON p.bvin = [KEY]' + 
			CASE 
				WHEN (@SortBy = 1) THEN '
					LEFT OUTER JOIN bvc_Manufacturer AS m ON p.ManufacturerId = m.bvin
					'
				WHEN (@SortBy = 4) THEN '
					LEFT OUTER JOIN bvc_Vendor AS v ON p.VendorId = v.bvin
					'
				ELSE
					''
			END + '
			WHERE
				aggregateRank >= ' + CAST(@MinimumRank AS NVARCHAR(12)) + 
			
			CASE 
				WHEN (@ParentId IS NOT NULL) THEN '
					AND ParentId = ''' + @ParentId + ''''
				ELSE
					''
			END +
			
			CASE 
				WHEN (@Status IS NOT NULL) THEN '
					AND Status = ' + CAST(@Status AS NVARCHAR(1))
				ELSE
					''
			END +
			
			CASE
				WHEN (@InventoryStatus IS NOT NULL) THEN '
					AND (
						(p.TrackInventory = 0 AND ' + CAST(@InventoryStatus AS NVARCHAR(1)) + ' = 1) 
						OR (p.TrackInventory = 1 AND EXISTS (SELECT ProductBvin FROM bvc_ProductInventory WHERE [Status] = ' + CAST(@InventoryStatus AS NVARCHAR(1)) + ' AND ProductBvin = p.bvin))
						OR (p.TrackInventory = 1 AND ' + CAST(@InventoryStatus AS NVARCHAR(1)) + ' = 0 AND NOT EXISTS (SELECT ProductBvin FROM bvc_ProductInventory WHERE [Status] = ' + CAST(@InventoryStatus AS NVARCHAR(1)) + ' AND ProductBvin = p.bvin))
					)
					'
				ELSE
					''
			END +
			
			CASE
				WHEN (@ProductTypeId IS NOT NULL) THEN '
					AND p.ProductTypeId = ''' + @ProductTypeId + ''''
				ELSE
					''
			END +
			
			CASE
				WHEN (@SpecialProductTypeOne IS NOT NULL) THEN '
					AND (p.SpecialProductType = ''' + @SpecialProductTypeOne + '''' +
					CASE 
						WHEN (@SpecialProductTypeTwo IS NOT NULL) THEN '
							OR p.SpecialProductType = ''' + @SpecialProductTypeTwo + ''')'
						ELSE
							')'
					END
				WHEN (@SpecialProductTypeTwo IS NOT NULL) THEN '
					AND p.SpecialProductType = ''' + @SpecialProductTypeTwo + ''''
				ELSE
					''
			END +
			
			CASE
				WHEN (@ExcludedSpecialProductTypeOne IS NOT NULL) THEN '
					AND (p.SpecialProductType <> ''' + @ExcludedSpecialProductTypeOne + '''' +
					CASE 
						WHEN (@ExcludedSpecialProductTypeTwo IS NOT NULL) THEN '
							AND p.SpecialProductType <> ''' + @ExcludedSpecialProductTypeTwo + ''')'
						ELSE
							')'
					END
				WHEN (@ExcludedSpecialProductTypeTwo IS NOT NULL) THEN '
					AND p.SpecialProductType <> ''' + @ExcludedSpecialProductTypeTwo + ''''
				ELSE
					''
			END +
			
			CASE
				WHEN (@CategoryId IS NOT NULL) THEN '
					AND EXISTS (SELECT CategoryId, ProductId FROM bvc_ProductXCategory WHERE ProductId = p.bvin AND (CategoryId =''' + @CategoryID + '''))'
				ELSE
					''
			END +
			
			CASE
				WHEN (@NotCategoryId IS NOT NULL) THEN '
					AND NOT EXISTS (SELECT CategoryId, ProductId FROM bvc_ProductXCategory WHERE ProductId = p.bvin AND (CategoryId =''' + @NotCategoryId + '''))'
				ELSE
					''
			END +
			
			CASE
				WHEN (@ManufacturerId IS NOT NULL) THEN '
					AND p.ManufacturerId = ''' + @ManufacturerId + ''''
				ELSE
					''
			END +
			
			CASE
				WHEN (@VendorId IS NOT NULL) THEN '
					AND p.VendorId = ''' + @VendorId + ''''
				ELSE
					''
			END +
			
			CASE
				WHEN (@MinPrice IS NOT NULL) THEN '
					AND p.SitePrice >= ' + CAST(@MinPrice AS NVARCHAR(12))
				ELSE
					''
			END +
			
			CASE
				WHEN (@MaxPrice IS NOT NULL) THEN '
					AND p.SitePrice <= ' + CAST(@MaxPrice AS NVARCHAR(12))
				ELSE
					''
			END +
			
			CASE
				WHEN (@CreatedAfter IS NOT NULL) THEN '
					AND p.CreationDate >= ''' + CAST(@CreatedAfter AS NVARCHAR(36)) + ''''
				ELSE
					''
			END + '
		)
		SELECT *, (SELECT COUNT(*) FROM cte_SearchResults) AS TotalRowCount
		FROM cte_SearchResults
		WHERE
			RowNum <= ' + CAST(@LastXItems AS NVARCHAR(36)) + '
			AND RowNum BETWEEN (' + CAST(@StartRowIndex AS NVARCHAR(36)) + ' + 1) AND (' + CAST(@StartRowIndex AS NVARCHAR(36)) + ' + ' + CAST(@MaximumRows AS NVARCHAR(36)) + ')
		ORDER BY RowNum
	'
	
	-- Uncomment the lines below to debug search query
	-- INSERT INTO bvc_Audit(TimeStampUtc, SourceModule, ShortName, Description, UserId, UserIdText, Severity)
	-- VALUES(GETUTCDATE(), 8, 'Site Search Engine', @SQL, '', '', 1)
	
	EXEC(@SQL)

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_Sql_i
END CATCH

GO



IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_AffiliateReferral_ByCriteria_s]'
GO
ALTER PROCEDURE [dbo].[bvc_AffiliateReferral_ByCriteria_s]

@AffiliateId varchar(36),
@StartDate datetime,
@EndDate datetime

AS
	BEGIN TRY
		SELECT id, AffId, ReferrerUrl, TimeOfReferral FROM bvc_AffiliateReferral 
		WHERE 
		(Affid = @AffiliateId OR @AffiliateId IS NULL)
		AND
		(TimeOfReferral > @StartDate OR @StartDate IS NULL)
		AND
		(TimeOfReferral < @EndDate OR @EndDate IS NULL)
		OPTION (RECOMPILE)
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
@MinPrice decimal(18,10) = NULL,
@MaxPrice decimal(18,10) = NULL,
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
			OPTION (RECOMPILE)
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
			OPTION (RECOMPILE)
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
			OPTION (RECOMPILE)
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
			OPTION (RECOMPILE)
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
			OPTION (RECOMPILE)
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
PRINT N'Altering [dbo].[bvc_LoyaltyPoints_ByCriteria_s]'
GO
ALTER PROCEDURE bvc_LoyaltyPoints_ByCriteria_s

	@UserId varchar(36) = NULL,
	@OrderId varchar(36) = NULL,
	@PointsType int = NULL,
	@PointsAdjustmentStart int = NULL,
	@PointsAdjustmentEnd int = NULL,
	@PointsRemainingStart int = NULL,
	@PointsRemainingEnd int = NULL,
	@Expires int = NULL,
	@ExpirationDateStart datetime = NULL,
	@ExpirationDateEnd datetime = NULL,
	@CreationDateStart datetime = NULL,
	@CreationDateEnd datetime = NULL

AS

	BEGIN TRY
	
		SELECT *
		FROM bvc_LoyaltyPoints
		WHERE 
			(@UserId IS NULL OR UserId = @UserId)
			AND (@OrderId IS NULL OR OrderId = @OrderId)
			AND (@PointsType IS NULL OR PointsType = @PointsType)
			AND (
					(@PointsAdjustmentStart IS NULL OR PointsAdjustment >= @PointsAdjustmentStart)
					AND
					(@PointsAdjustmentEnd IS NULL OR PointsAdjustment <= @PointsAdjustmentEnd)
				)
			AND (
					(@PointsRemainingStart IS NULL OR PointsRemaining >= @PointsRemainingStart)
					AND
					(@PointsRemainingEnd IS NULL OR PointsRemaining <= @PointsRemainingEnd)
				)
			AND (@Expires IS NULL OR Expires = @Expires)
			AND (
					(@ExpirationDateStart IS NULL OR ExpirationDate >= @ExpirationDateStart)
					AND
					(@ExpirationDateEnd IS NULL OR ExpirationDate <= @ExpirationDateEnd)
				)
			AND (
					(@CreationDateStart IS NULL OR CreationDate >= @CreationDateStart)
					AND
					(@CreationDateEnd IS NULL OR CreationDate <= @CreationDateEnd)
				)
		OPTION (RECOMPILE)
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