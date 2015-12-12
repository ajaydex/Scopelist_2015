SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
PRINT N'Dropping index [IX_Product_ManufacturerId] from [dbo].[bvc_Product]'
GO
DROP INDEX [IX_Product_ManufacturerId] ON [dbo].[bvc_Product]
GO
PRINT N'Dropping index [IX_Product_ProductName] from [dbo].[bvc_Product]'
GO
DROP INDEX [IX_Product_ProductName] ON [dbo].[bvc_Product]
GO
PRINT N'Dropping index [IX_Product_Status] from [dbo].[bvc_Product]'
GO
DROP INDEX [IX_Product_Status] ON [dbo].[bvc_Product]
GO
PRINT N'Dropping index [IX_Product_VendorId] from [dbo].[bvc_Product]'
GO
DROP INDEX [IX_Product_VendorId] ON [dbo].[bvc_Product]
GO
PRINT N'Altering [dbo].[bvc_User]'
GO
ALTER TABLE [dbo].[bvc_User] ADD
[PasswordLastSet] [datetime] NOT NULL CONSTRAINT [DF_bvc_User_PasswordLastSet] DEFAULT (((1)/(1))/(1900)),
[PasswordLastThree] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_User_PasswordLastThree] DEFAULT ('')
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
PRINT N'Altering [dbo].[bvc_OrderPayment]'
GO
ALTER TABLE [dbo].[bvc_OrderPayment] ADD
[EncryptionKeyId] [bigint] NOT NULL CONSTRAINT [DF_bvc_OrderPayment_EncryptionKeyId] DEFAULT ((0))
GO
ALTER TABLE [dbo].[bvc_OrderPayment] ALTER COLUMN [creditCardNumber] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
ALTER TABLE [dbo].[bvc_OrderPayment] ALTER COLUMN [giftCertificateNumber] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
GO
PRINT N'Altering [dbo].[bvc_OrderPayment_ByThirdPartyTransactionId_s]'
GO






ALTER PROCEDURE [dbo].[bvc_OrderPayment_ByThirdPartyTransactionId_s]
@ThirdPartyTransId nvarchar(100)

AS
	BEGIN TRY
		SELECT 
		bvin, 
		LastUpdated, 
		AmountAuthorized, 
		AmountCharged, 
		AmountRefunded, 
		AuditDate, 
		CheckNumber, 
		CreditCardExpMonth, 
		CreditCardExpYear, 
		CreditCardHolder, 
		CreditCardNumber, 
		CreditCardType, 
		GiftCertificateNumber, 
		Note, 
		OrderID, 
		PaymentMethodId, 
		PaymentMethodName, 
		PurchaseOrderNumber, 
		TransactionReferenceNumber, 
		TransactionResponseCode,
		CustomProperties,
		ThirdPartyOrderId,
		ThirdPartyTransId,
		EncryptionKeyId

		FROM bvc_OrderPayment
			  WHERE  ThirdPartyTransId = @ThirdPartyTransId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















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
			PasswordLastSet, PasswordLastThree
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Affiliate ON bvc_UserXContact.ContactId = bvc_Affiliate.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END



















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
			PasswordLastSet, PasswordLastThree
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Affiliate ON bvc_UserXContact.ContactId = bvc_Affiliate.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END


















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
			PasswordLastSet, PasswordLastThree
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Manufacturer ON bvc_UserXContact.ContactId = bvc_Manufacturer.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END


















GO
PRINT N'Altering [dbo].[bvc_OrderPayment_i]'
GO






ALTER PROCEDURE [dbo].[bvc_OrderPayment_i]
@bvin varchar(36),
@AmountAuthorized decimal(18,10), 
@AmountCharged decimal(18,10), 
@AmountRefunded decimal(18,10), 
@AuditDate dateTime, 
@CheckNumber nvarchar(50), 
@CreditCardExpMonth int, 
@CreditCardExpYear int, 
@CreditCardHolder nvarchar(50), 
@CreditCardNumber nvarchar(1024), 
@CreditCardType nvarchar(50), 
@GiftCertificateNumber nvarchar(1024), 
@Note  nvarchar(max), 
@OrderID varchar(36), 
@PaymentMethodId varchar(36), 
@PaymentMethodName nvarchar(255), 
@PurchaseOrderNumber nvarchar(50), 
@TransactionReferenceNumber nvarchar(50), 
@TransactionResponseCode nvarchar(50),
@CustomProperties ntext,
@ThirdPartyOrderId nvarchar(100),
@ThirdPartyTransId nvarchar(100),
@EncryptionKeyId bigint

AS	
	BEGIN TRY
		INSERT INTO
		bvc_OrderPayment
		(
		bvin, 
		LastUpdated, 
		AmountAuthorized, 
		AmountCharged, 
		AmountRefunded, 
		AuditDate, 
		CheckNumber, 
		CreditCardExpMonth, 
		CreditCardExpYear, 
		CreditCardHolder, 
		CreditCardNumber, 
		CreditCardType, 
		GiftCertificateNumber, 
		Note, 
		OrderID, 
		PaymentMethodId, 
		PaymentMethodName, 
		PurchaseOrderNumber, 
		TransactionReferenceNumber, 
		TransactionResponseCode,
		CustomProperties,
		ThirdPartyOrderId,
		ThirdPartyTransId,
		EncryptionKeyId
		)
			VALUES
			(
		@bvin, 
		GetDate(), 
		@AmountAuthorized, 
		@AmountCharged, 
		@AmountRefunded, 
		@AuditDate, 
		@CheckNumber, 
		@CreditCardExpMonth, 
		@CreditCardExpYear, 
		@CreditCardHolder, 
		@CreditCardNumber, 
		@CreditCardType, 
		@GiftCertificateNumber, 
		@Note, 
		@OrderID, 
		@PaymentMethodId, 
		@PaymentMethodName, 
		@PurchaseOrderNumber, 
		@TransactionReferenceNumber, 
		@TransactionResponseCode,
		@CustomProperties,
		@ThirdPartyOrderId,
		@ThirdPartyTransId,
		@EncryptionKeyId
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
GO
PRINT N'Altering [dbo].[bvc_OrderPayment_s]'
GO






ALTER PROCEDURE [dbo].[bvc_OrderPayment_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin, 
		LastUpdated, 
		AmountAuthorized, 
		AmountCharged, 
		AmountRefunded, 
		AuditDate, 
		CheckNumber, 
		CreditCardExpMonth, 
		CreditCardExpYear, 
		CreditCardHolder, 
		CreditCardNumber, 
		CreditCardType, 
		GiftCertificateNumber, 
		Note, 
		OrderID, 
		PaymentMethodId, 
		PaymentMethodName, 
		PurchaseOrderNumber, 
		TransactionReferenceNumber, 
		TransactionResponseCode,
		CustomProperties,
		ThirdPartyOrderId,
		ThirdPartyTransId,
		EncryptionKeyId

		FROM bvc_OrderPayment
			  WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














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
			PasswordLastSet, PasswordLastThree
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Vendor ON bvc_UserXContact.ContactId = bvc_Vendor.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END


















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
PRINT N'Altering [dbo].[bvc_OrderPayment_u]'
GO





ALTER PROCEDURE [dbo].[bvc_OrderPayment_u]
@bvin varchar(36),
@AmountAuthorized decimal(18,10), 
@AmountCharged decimal(18,10), 
@AmountRefunded decimal(18,10), 
@AuditDate dateTime, 
@CheckNumber nvarchar(50), 
@CreditCardExpMonth int, 
@CreditCardExpYear int, 
@CreditCardHolder nvarchar(50), 
@CreditCardNumber nvarchar(1024), 
@CreditCardType nvarchar(50), 
@GiftCertificateNumber nvarchar(1024), 
@Note  nvarchar(max), 
@OrderID varchar(36), 
@PaymentMethodId varchar(36), 
@PaymentMethodName nvarchar(255), 
@PurchaseOrderNumber nvarchar(50), 
@TransactionReferenceNumber nvarchar(50), 
@TransactionResponseCode nvarchar(50),
@CustomProperties ntext,
@ThirdPartyOrderId nvarchar(100),
@ThirdPartyTransId nvarchar(100),
@EncryptionKeyId bigint

AS
	BEGIN TRY
		UPDATE
			bvc_OrderPayment
		SET
		bvin = @bvin, 
		LastUpdated = GetDate(), 
		AmountAuthorized = @AmountAuthorized, 
		AmountCharged = @AmountCharged, 
		AmountRefunded = @AmountRefunded, 
		AuditDate = @AuditDate, 
		CheckNumber = @CheckNumber, 
		CreditCardExpMonth = @CreditCardExpMonth, 
		CreditCardExpYear = @CreditCardExpYear, 
		CreditCardHolder = @CreditCardHolder, 
		CreditCardNumber = @CreditCardNumber, 
		CreditCardType = @CreditCardType, 
		GiftCertificateNumber = @GiftCertificateNumber, 
		Note = @Note, 
		OrderID = @OrderID, 
		PaymentMethodId = @PaymentMethodId, 
		PaymentMethodName = @PaymentMethodName, 
		PurchaseOrderNumber = @PurchaseOrderNumber, 
		TransactionReferenceNumber = @TransactionReferenceNumber, 
		TransactionResponseCode = @TransactionResponseCode,
		CustomProperties=@CustomProperties,
		ThirdPartyOrderId=@ThirdPartyOrderId,
		ThirdPartyTransId=@ThirdPartyTransId,
		EncryptionKeyId=@EncryptionKeyId

		WHERE
			bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















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
			PasswordLastSet, PasswordLastThree
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
@PasswordLastThree nvarchar(1024)

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
		PasswordLastThree
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
		@PasswordLastThree
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















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
			PasswordLastSet, PasswordLastThree
		FROM bvc_User
		WHERE bvin Not IN (SELECT UserID FROM bvc_UserXRole WHERE RoleID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END















GO
PRINT N'Altering [dbo].[bvc_UserAccount_All_s]'
GO









ALTER PROCEDURE [dbo].[bvc_UserAccount_All_s]

AS

BEGIN TRY
	SELECT bvin,[UserName],[Password],[Firstname],[LastName],Salt,TaxExempt,
			Email,CreationDate,LastLoginDate,PasswordHint,Comment,AddressBook,
			LastUpdated,PasswordAnswer,PasswordFormat,Locked,LockedUntil,FailedLoginCount,BillingAddress,ShippingAddress,PricingGroup,CustomQuestionAnswers,
			PasswordLastSet, PasswordLastThree
			
	FROM bvc_User
	ORDER BY [UserName],[LastName],[FirstName]

	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH


















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
@PasswordLastThree nvarchar(1024)


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
		PasswordLastThree = @PasswordLastThree
		
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_Audit]'
GO
CREATE TABLE [dbo].[bvc_Audit]
(
[id] [bigint] NOT NULL IDENTITY(1, 1),
[TimeStampUtc] [datetime] NOT NULL,
[SourceModule] [int] NOT NULL,
[ShortName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Audit_UserId] DEFAULT (''),
[UserIdText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Audit_UserIdTest] DEFAULT (''),
[Severity] [int] NOT NULL CONSTRAINT [DF_bvc_Audit_Severity] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_bvc_Audit] on [dbo].[bvc_Audit]'
GO
ALTER TABLE [dbo].[bvc_Audit] ADD CONSTRAINT [PK_bvc_Audit] PRIMARY KEY CLUSTERED  ([id])
GO
PRINT N'Creating [dbo].[bvc_Audit_d]'
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[bvc_Audit_d]	
AS
BEGIN	
	Declare @removebefore DateTime
	Select @removebefore = DateAdd(yy,-1,GetUTCDate())
			
	Delete bvc_Audit where TimeStampUtc < @removebefore	
	
END
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
			PasswordLastSet, PasswordLastThree
			
		FROM bvc_User
		WHERE 
			(username = @UserName OR @UserName IS NULL) 
			AND (firstname = @FirstName OR @FirstName IS NULL) 
			AND (lastname = @LastName OR @LastName IS NULL) 
			AND (email = @Email OR @Email IS NULL))

		SELECT *, (SELECT COUNT(*) FROM UserAccounts) AS TotalRowCount FROM UserAccounts
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END
















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
		PasswordLastSet, PasswordLastThree
		FROM bvc_User Where bvin=@bvin

		exec bvc_Address_ByUserId_s @bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_OrderPayment_WithOldEncryption_s]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderPayment_WithOldEncryption_s]

@CurrentKey bigint

AS
	BEGIN TRY
		SELECT 
		bvin, 
		LastUpdated, 
		AmountAuthorized, 
		AmountCharged, 
		AmountRefunded, 
		AuditDate, 
		CheckNumber, 
		CreditCardExpMonth, 
		CreditCardExpYear, 
		CreditCardHolder, 
		CreditCardNumber, 
		CreditCardType, 
		GiftCertificateNumber, 
		Note, 
		OrderID, 
		PaymentMethodId, 
		PaymentMethodName, 
		PurchaseOrderNumber, 
		TransactionReferenceNumber, 
		TransactionResponseCode,
		CustomProperties,
		ThirdPartyOrderId,
		ThirdPartyTransId,
		EncryptionKeyId

		FROM bvc_OrderPayment
			  WHERE  EncryptionKeyId <> @CurrentKey ORDER BY [auditDate], [id]
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















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
			PasswordLastSet, PasswordLastThree
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Manufacturer ON bvc_UserXContact.ContactId = bvc_Manufacturer.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END



















GO
PRINT N'Altering [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]'
GO









ALTER PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]

@StartDate datetime = NULL,
@EndDate datetime = NULL

AS
	BEGIN TRY
		SELECT 
		p.SKU,
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
		GROUP BY p.bvin,p.sku, p.ProductName		
		ORDER BY SUM(l.Quantity) DESC
      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















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
			PasswordLastSet, PasswordLastThree
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXRole WHERE RoleID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END















GO
PRINT N'Altering [dbo].[bvc_OrderPayment_ByOrderId_s]'
GO








ALTER PROCEDURE [dbo].[bvc_OrderPayment_ByOrderId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin, 
		LastUpdated, 
		AmountAuthorized, 
		AmountCharged, 
		AmountRefunded, 
		AuditDate, 
		CheckNumber, 
		CreditCardExpMonth, 
		CreditCardExpYear, 
		CreditCardHolder, 
		CreditCardNumber, 
		CreditCardType, 
		GiftCertificateNumber, 
		Note, 
		OrderID, 
		PaymentMethodId, 
		PaymentMethodName, 
		PurchaseOrderNumber, 
		TransactionReferenceNumber, 
		TransactionResponseCode,
		CustomProperties,
		ThirdPartyOrderId,
		ThirdPartyTransId,
		EncryptionKeyId

		FROM bvc_OrderPayment
			  WHERE  OrderID=@bvin ORDER BY [auditDate], [id]
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















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
			PasswordLastSet, PasswordLastThree
			
		FROM bvc_User
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Vendor ON bvc_UserXContact.ContactId = bvc_Vendor.bvin WHERE ContactID=@bvin)
		ORDER BY [UserName],[LastName],[FirstName]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END

GO
PRINT N'Creating index [IX_Product_ManufacturerId] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_ManufacturerId] ON [dbo].[bvc_Product] ([ManufacturerID])
GO
PRINT N'Creating index [IX_Product_ProductName] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_ProductName] ON [dbo].[bvc_Product] ([ProductName])
GO
PRINT N'Creating index [IX_Product_Status] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_Status] ON [dbo].[bvc_Product] ([Status], [bvin])
GO
PRINT N'Creating index [IX_Product_VendorId] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_VendorId] ON [dbo].[bvc_Product] ([VendorID])
GO

