SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
PRINT N'Creating [dbo].[bvc_EventLog_SQL_i]'
GO


CREATE PROCEDURE [dbo].[bvc_EventLog_SQL_i]
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
PRINT N'Creating [dbo].[bvc_ProductChoice_RemoveFromProduct_d ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/26/2006
-- Description:	Removes a shared input from a product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_RemoveFromProduct_d ]	
	@productId varchar(36),
	@choiceId varchar(36)
AS
BEGIN
	BEGIN TRY	
		DELETE FROM bvc_ProductXChoice WHERE ChoiceId = @choiceId AND ProductId = @productId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN
END




















GO
PRINT N'Creating [dbo].[bvc_PrintTemplate_s]'
GO

CREATE PROCEDURE [dbo].[bvc_PrintTemplate_s]

@bvin varchar(36)

AS
		
	BEGIN TRY
		SELECT 
		bvin,
		DisplayName,
		Body,
		RepeatingSection,
		SystemTemplate,
		LastUpdated
		FROM bvc_PrintTemplate
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_MailingListMember_d_ByEmail_ListID]'
GO



CREATE PROCEDURE [dbo].[bvc_MailingListMember_d_ByEmail_ListID]

@EmailAddress nvarchar(255),
@ListID varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_MailingListMember 
		WHERE EmailAddress=@EmailAddress AND ListID=@ListID
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_i]'
GO







CREATE PROCEDURE [dbo].[bvc_GiftCertificate_i]
@bvin varchar(36),
@LineItemId varchar(36),
@CertificateCode nvarchar(50),
@DateIssued Datetime,
@OriginalAmount numeric(18,10),
@AssociatedProductId varchar(36),
@CodeAlreadyInUse bit OUTPUT

AS
	BEGIN TRY
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
		SELECT CertificateCode FROM bvc_GiftCertificate WHERE CertificateCode = @CertificateCode
		IF @@ROWCOUNT = 0
		BEGIN 			
			SET @CodeAlreadyInUse = 0
			INSERT INTO bvc_GiftCertificate (bvin, LineItemId, CertificateCode, DateIssued, OriginalAmount, CurrentAmount, AssociatedProductId, LastUpdated)
			VALUES (@bvin, @LineItemId, @CertificateCode, @DateIssued, @OriginalAmount, @OriginalAmount, @AssociatedProductId, GetDate())			
		END
		ELSE
		BEGIN
			SET @CodeAlreadyInUse = 1
			RETURN 0
		END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION		
		EXEC bvc_EventLog_SQL_i						
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_SearchQuery_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,QueryPhrase,ShopperID,LastUpdated
		FROM
			bvc_SearchQuery
		WHERE
			bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ComponentSettings_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSettings_s]

@ComponentID varchar(36)

AS
	
	BEGIN TRY
		SELECT SettingName,SettingValue,ComponentID,DeveloperId,ComponentType,ComponentSubType FROM bvc_ComponentSetting WHERE
		ComponentID=@ComponentID
		ORDER BY SettingName

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_WebAppSetting_s]'
GO


CREATE PROCEDURE [dbo].[bvc_WebAppSetting_s]

@SettingName nvarchar(255)

AS
	BEGIN TRY
		SELECT SettingName,SettingValue FROM bvc_WebAppSetting WHERE
		SettingName=@SettingName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductChoiceCombination_d ]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/16/2006
-- Description:	Deletes a Product Choice Combination
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceCombination_d ]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			DELETE FROM bvc_ProductChoiceCombinations WHERE ProductId = @bvin

			EXEC bvc_Product_d @bvin
		COMMIT
	END TRY
	BEGIN CATCH
		IF XACT_STATE() != 0
			ROLLBACK TRANSACTION

		EXEC bvc_EventLog_SQL_i
	END CATCH
END






















GO
PRINT N'Creating [dbo].[bvc_PrintTemplate_u]'
GO

CREATE PROCEDURE [dbo].[bvc_PrintTemplate_u]

@bvin varchar(36),
@DisplayName nvarchar(Max),
@Body nvarchar(Max),
@RepeatingSection nvarchar(Max),
@SystemTemplate int

AS
	BEGIN TRY
		UPDATE bvc_PrintTemplate
		SET
		DisplayName=@DisplayName,
		Body=@Body,
		RepeatingSection=@RepeatingSection,
		SystemTemplate=@SystemTemplate,
		LastUpdated=GetDate()
		WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_OrderNote_i]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderNote_i]

@bvin varchar(36),
@OrderId varchar(36),
@AuditDate datetime,
@Note nvarchar(max),
@NoteType int

AS
	BEGIN TRY
		INSERT INTO
		bvc_OrderNote
		(
		bvin,
		OrderId,
		AuditDate,
		Note,
		NoteType,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@OrderId,
		@AuditDate,
		@Note,
		@NoteType,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RMAItem_u]'
GO












CREATE PROCEDURE [dbo].[bvc_RMAItem_u]
@bvin varchar(36),
@RMABvin varchar(36),
@LineItemBvin varchar(36),
@ItemDescription nvarchar(max),
@ItemName nvarchar(512),
@Note nvarchar(max),
@Reason nvarchar(Max),
@Replace bit,
@Quantity int,
@QuantityReceived int,
@QuantityReturnedToInventory int

AS
	BEGIN TRY
		UPDATE
		bvc_RMAItem
		SET
		RMABvin = @RMABvin,
		LineItemBvin = @LineItemBvin,
		ItemDescription = @ItemDescription,
		ItemName = @ItemName,
		Note = @Note,
		Reason = @Reason,
		[Replace] = @Replace,
		Quantity = @Quantity,
		QuantityReceived = @QuantityReceived,
		QuantityReturnedToInventory = @QuantityReturnedToInventory,
		LastUpdated = GetDate()
		WHERE
		bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





























GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_IncAmt_u]'
GO





CREATE PROCEDURE [dbo].[bvc_GiftCertificate_IncAmt_u]
@bvin varchar(36),
@amount numeric(18, 10),
@finalValue numeric(18, 10) OUTPUT,
@succeeded bit OUTPUT
AS
	-- we keep the @DateIssued And @OriginalAmount variables to ease the programming, but we don't let them change on updates
	BEGIN TRY
		DECLARE @CurrentAmount numeric(18, 10)
		DECLARE @IssueAmount numeric(18, 10)
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
			SET @CurrentAmount = (SELECT CurrentAmount FROM bvc_GiftCertificate WHERE bvin = @bvin);
			SET @IssueAmount = (SELECT OriginalAmount FROM bvc_GiftCertificate WHERE bvin = @bvin);
			IF (@CurrentAmount + @amount) <= @IssueAmount
			BEGIN
				UPDATE bvc_GiftCertificate SET CurrentAmount = (CurrentAmount + @amount), LastUpdated = GetDate() WHERE bvin = @bvin
				SET @finalValue = (SELECT CurrentAmount FROM bvc_GiftCertificate WHERE bvin = @bvin)	
				SET @succeeded = 1
			END
			ELSE
			BEGIN
				SET @finalValue = @CurrentAmount	
				SET @succeeded = 0
			END			
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_MailingListMember_i]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingListMember_i]

@bvin varchar(36),
@listID varchar(36),
@EmailAddress nvarchar(255),
@FirstName nvarchar(255),
@LastName nvarchar(255)

AS
	BEGIN TRY
		DECLARE @COUNT INT
		SET @COUNT = (SELECT COUNT(*) FROM bvc_MailingListMember WHERE EmailAddress = @EmailAddress AND ListID = @listID)
		IF (@COUNT = 0 AND @EmailAddress != '')
		BEGIN
			INSERT INTO bvc_MailingListMember (bvin,ListID,EmailAddress,FirstName,LastName,LastUpdated) 
				VALUES(@bvin,@ListID,@EmailAddress,@FirstName,@LastName,GetDate())
		END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN












GO
PRINT N'Creating [dbo].[bvc_OrderNote_s]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderNote_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		OrderId,
		AuditDate,
		Note,
		NoteType,
		LastUpdated 
		FROM bvc_OrderNote
		  WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell_d]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductCrossSell_d] 
	
	@bvin varchar(36)

AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductCrossSell WHERE Bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END






GO
PRINT N'Creating [dbo].[bvc_WebAppSetting_u]'
GO


CREATE PROCEDURE [dbo].[bvc_WebAppSetting_u]

@SettingName nvarchar(255),
@SettingValue text

AS

	BEGIN TRY
		DECLARE @c int
		SET @c = ( SELECT COUNT(SettingName) FROM bvc_WebAppSetting WHERE SettingName=@SettingName)

		if @c < 1
			INSERT INTO bvc_WebAppSetting(SettingName,SettingValue) VALUES (@SettingName,@SettingValue)
		ELSE
			UPDATE bvc_WebAppSetting SET SettingValue=@SettingValue WHERE SettingName=@SettingName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductReview_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductReview_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_ProductReview WHERE bvin=@bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_MailingListMember_s]'
GO

CREATE PROCEDURE [dbo].[bvc_MailingListMember_s]
	@bvin varchar(36)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT bvin,ListID,EmailAddress,FirstName,LastName,LastUpdated
		FROM bvc_MailingListMember
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_s]'
GO





CREATE PROCEDURE [dbo].[bvc_GiftCertificate_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		LineItemId,
		CertificateCode,
		DateIssued,
		OriginalAmount,
		CurrentAmount,
		AssociatedProductId,
		LastUpdated
		FROM bvc_GiftCertificate
		  WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_Address_ByUserId_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Address_ByUserId_s]	
	@bvin varchar(36)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT 
		Bvin,
		NickName,
		FirstName,
		MiddleInitial,
		LastName,
		Company,
		Line1,
		Line2,
		Line3,
		City,
		RegionBvin,
		RegionName,
		PostalCode,
		CountryBvin,
		CountryName,
		CountyBvin,
		CountyName,
		Phone,
		Fax,
		WebSiteUrl,
		LastUpdated,
		UserBvin
		FROM
		bvc_Address 
		WHERE UserBvin=@bvin
		ORDER BY [id]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END









GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell_i]'
GO




-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductCrossSell_i] 
	
	@bvin varchar(36),
	@ProductBvin varchar(36),
	@CrossSellBvin varchar(36),
	@order int,
	@descriptionOverride nvarchar(512)

AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_ProductCrossSell (Bvin, ProductBvin, CrossSellBvin, [Order], DescriptionOverride, LastUpdated) 
			VALUES(@bvin, @ProductBvin, @CrossSellBvin, @order, @descriptionOverride, GETDATE())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END








GO
PRINT N'Creating [dbo].[bvc_ProductReview_i]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductReview_i]
@bvin varchar(36),
@Approved int,
@Description nvarchar(max),
@Karma int,
@ProductBvin varchar(36),
@Rating int,
@ReviewDate dateTime,
@UserID varchar(36),
@UserName nvarchar(151),
@UserEmail nvarchar(100)

AS
	BEGIN TRY
		INSERT INTO
		bvc_ProductReview
		(
		bvin,
		LastUpdated,
		Approved, 
		Description, 
		Karma,
		ProductBvin,
		Rating, 
		ReviewDate, 
		UserID,
		UserName,
		UserEmail
		)
			VALUES
			(
		@bvin, 
		GetDate(),
		@Approved, 
		@Description, 
		@Karma,
		@ProductBvin,
		@Rating, 
		@ReviewDate, 
		@UserID,
		@UserName,
		@UserEmail
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_OrderNote_u]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderNote_u]

@bvin varchar(36),
@OrderId varchar(36),
@AuditDate datetime,
@Note nvarchar(max),
@NoteType int

AS
	BEGIN TRY
		UPDATE
			bvc_OrderNote
		SET
		OrderId=@OrderId,
		AuditDate=@AuditDate,
		Note=@Note,
		NoteType=@NoteType,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_MailingListMember_u]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingListMember_u]

@bvin varchar(36),
@listID varchar(36),
@EmailAddress nvarchar(255),
@FirstName nvarchar(255),
@LastName nvarchar(255)

AS

	BEGIN TRY
		UPDATE bvc_MailingListMember
		SET
		
		bvin=@bvin,
		ListID=@ListID,
		EmailAddress=@EmailAddress,
		FirstName=@FirstName,
		LastName=@LastName,
		LastUpdated=GetDate()
			
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_WebAppSettings_s]'
GO


CREATE PROCEDURE [dbo].[bvc_WebAppSettings_s]

AS
	BEGIN TRY
		SELECT SettingName,SettingValue FROM bvc_WebAppSetting
		ORDER BY SettingName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_u]'
GO






CREATE PROCEDURE [dbo].[bvc_GiftCertificate_u]
@bvin varchar(36),
@LineItemId varchar(36),
@CertificateCode nvarchar(50),
@DateIssued Datetime,
@OriginalAmount numeric(18,10),
@AssociatedProductId varchar(36)

AS
	-- we keep the @DateIssued And @OriginalAmount variables to ease the programming, but we don't let them change on updates
	BEGIN TRY
		UPDATE bvc_GiftCertificate SET bvin = @bvin, LineItemId = @LineItemId, DateIssued = @DateIssued, CertificateCode = @CertificateCode, AssociatedProductId = @AssociatedProductId WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_ByCountryAndRegion_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ShippingMethod_ByCountryAndRegion_s]
@CountryBvin varchar(36),
@RegionBvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		Adjustment,
		AdjustmentType,
		[Name],
		ShippingProviderId,
		LastUpdated
		FROM bvc_ShippingMethod
		  WHERE  
			bvin NOT IN (SELECT ShippingMethodBvin FROM bvc_ShippingMethod_CountryRestriction WHERE CountryBvin=@CountryBvin)
			AND
			bvin NOT IN (SELECT ShippingMethodBvin FROM bvc_ShippingMethod_RegionRestriction WHERE RegionBvin=@RegionBvin)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell_u]'
GO




-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductCrossSell_u] 
	
	@bvin varchar(36),
	@ProductBvin varchar(36),
	@CrossSellBvin varchar(36),
	@order int,
	@descriptionOverride nvarchar(512)

AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductCrossSell SET Bvin = @bvin, ProductBvin = @ProductBvin, 
			CrossSellBvin = @CrossSellBvin, [Order] = @order, DescriptionOverride = @descriptionOverride, LastUpdated = GETDATE() WHERE Bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END








GO
PRINT N'Creating [dbo].[bvc_Address_d]'
GO


CREATE PROCEDURE [dbo].[bvc_Address_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_Address WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN











GO
PRINT N'Creating [dbo].[bvc_Address_i]'
GO


CREATE PROCEDURE [dbo].[bvc_Address_i]

@bvin varchar(36),
@NickName nvarchar(255),
@FirstName nvarchar(255),
@MiddleInitial nvarchar(1),
@Lastname nvarchar(255),
@Company nvarchar(255),
@Line1 nvarchar(255),
@Line2 nvarchar(255),
@Line3 nvarchar(255),
@City nvarchar(255),
@RegionBvin varchar(36),
@RegionName nvarchar(255),
@PostalCode nvarchar(50),
@CountryBvin varchar(36),
@CountryName nvarchar(255),
@CountyBvin varchar(36),
@CountyName nvarchar(255),
@Phone nvarchar(50),
@Fax nvarchar(50),
@WebSiteURL nvarchar(255),
@UserBvin varchar(36)

AS
	BEGIN TRY
		Insert Into bvc_Address
		(
		Bvin,
		NickName,
		FirstName,
		MiddleInitial,
		LastName,
		Company,
		Line1,
		Line2,
		Line3,
		City,
		RegionBvin,
		RegionName,
		PostalCode,
		CountryBvin,
		CountryName,
		CountyBvin,
		CountyName,
		Phone,
		Fax,
		WebSiteUrl,
		LastUpdated,
		UserBvin
		)
		VALUES
		(
		@Bvin,
		@NickName,
		@FirstName,
		@MiddleInitial,
		@LastName,
		@Company,
		@Line1,
		@Line2,
		@Line3,
		@City,
		@RegionBvin,
		@RegionName,
		@PostalCode,
		@CountryBvin,
		@CountryName,
		@CountyBvin,
		@CountyName,
		@Phone,
		@Fax,
		@WebSiteUrl,
		GetDate(),
		@UserBvin
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH	
	
	RETURN









GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_CountryRestriction_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ShippingMethod_CountryRestriction_d]
	@ShippingMethodBvin varchar(36),
	@CountryBvin varchar(36)

AS

	BEGIN TRY
		DELETE FROM bvc_ShippingMethod_CountryRestriction 
		WHERE ShippingMethodBvin=@ShippingMethodBvin AND CountryBvin=@CountryBvin

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN





















GO
PRINT N'Creating [dbo].[bvc_ProductReview_u]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductReview_u]
@bvin varchar(36),
@Approved int,
@Description nvarchar(max),
@Karma int,
@ProductBvin varchar(36),
@Rating int,
@ReviewDate dateTime,
@UserID varchar(36),
@UserName nvarchar(151),
@UserEmail nvarchar(100)

AS
	BEGIN TRY
		UPDATE
			bvc_ProductReview
		SET
			bvin = @bvin,
			LastUpdated = GetDate(),
			Approved = @Approved,
			Description = @Description,
			Karma = @Karma,
			ProductBvin = @ProductBvin,
			Rating = @Rating,
			ReviewDate = @ReviewDate,
			UserID = @UserID,
			UserName = @UserName,
			UserEmail = @UserEmail
		WHERE
			bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductFile_ByBvinAndProductBvin_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductFile_ByBvinAndProductBvin_s]

@bvin varchar(36),
@ProductBvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvc_ProductFile.bvin,bvc_ProductFileXProduct.ProductID,bvc_ProductFileXProduct.AvailableMinutes,bvc_ProductFileXProduct.MaxDownloads,bvc_ProductFile.[FileName],bvc_ProductFile.ShortDescription,bvc_ProductFileXProduct.LastUpdated
		FROM bvc_ProductFile LEFT JOIN bvc_ProductFileXProduct ON bvc_ProductFile.bvin = bvc_ProductFileXProduct.ProductFileId
		WHERE bvin=@bvin And bvc_ProductFileXProduct.ProductId = @ProductBvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_Address_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Address_s]
	
	@bvin varchar(36)

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT 
		Bvin,
		NickName,
		FirstName,
		MiddleInitial,
		LastName,
		Company,
		Line1,
		Line2,
		Line3,
		City,
		RegionBvin,
		RegionName,
		PostalCode,
		CountryBvin,
		CountryName,
		CountyBvin,
		CountyName,
		Phone,
		Fax,
		WebSiteUrl,
		LastUpdated,
		UserBvin
		FROM
		bvc_Address
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END









GO
PRINT N'Creating [dbo].[bvc_Manufacturer_Filter_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Manufacturer_Filter_s]

@filter nvarchar(Max),
@StartRowIndex int = 0,
@MaximumRows int = 9999999

AS
	BEGIN TRY;
		WITH manufacturers AS
		(SELECT ROW_NUMBER() OVER (ORDER BY DisplayName, EmailAddress) As RowNum,
			bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated FROM bvc_Manufacturer
		WHERE (DisplayName LIKE @filter) OR (EmailAddress LIKE @filter) OR
			(Address LIKE @filter))		
		SELECT *, (SELECT COUNT(*) FROM manufacturers) AS TotalRowCount FROM manufacturers
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_CountryRestriction_i]'
GO






CREATE PROCEDURE [dbo].[bvc_ShippingMethod_CountryRestriction_i]
	@ShippingMethodBvin varchar(36),
	@CountryBvin varchar(36)

AS

	BEGIN TRY
		INSERT INTO bvc_ShippingMethod_CountryRestriction (ShippingMethodBvin, CountryBvin)
		VALUES (@ShippingMethodBvin, @CountryBvin)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN





















GO
PRINT N'Creating [dbo].[bvc_ProductReviewKarma_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductReviewKarma_u] 

@Bvin varchar(36),
@KarmaModifier int = 0

AS
	BEGIN TRY
		UPDATE bvc_ProductReview
		SET
		Karma=Karma+@KarmaModifier
		WHERE
		Bvin=@Bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_ProductFile_Count_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_Count_s]
	
AS
	BEGIN TRY
		SELECT
		COUNT(*) As FileCount
		FROM bvc_ProductFile
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ContentBlock_i]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_i]

@bvin varchar(36),
@ColumnID varchar(36),
@SortOrder int,
@ControlName nvarchar(512)

AS
	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_ContentBlock WHERE ColumnID=@ColumnID) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_ContentBlock WHERE ColumnID=@ColumnID)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END
			
			
		INSERT INTO bvc_ContentBlock
		(
		bvin,
		ColumnID,
		SortOrder,
		ControlName,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@ColumnID,
		@SortOrder,
		@ControlName,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Address_u]'
GO



CREATE PROCEDURE [dbo].[bvc_Address_u]
	
@bvin varchar(36),
@NickName nvarchar(255),
@FirstName nvarchar(255),
@MiddleInitial nvarchar(1),
@Lastname nvarchar(255),
@Company nvarchar(255),
@Line1 nvarchar(255),
@Line2 nvarchar(255),
@Line3 nvarchar(255),
@City nvarchar(255),
@RegionBvin varchar(36),
@RegionName nvarchar(255),
@PostalCode nvarchar(50),
@CountryBvin varchar(36),
@CountryName nvarchar(255),
@CountyBvin varchar(36),
@CountyName nvarchar(255),
@Phone nvarchar(50),
@Fax nvarchar(50),
@WebSiteURL nvarchar(255),
@UserBvin varchar(36)

AS
BEGIN
	
	BEGIN TRY
		UPDATE bvc_Address
		SET
		Bvin=@Bvin,
		NickName=@NickName,
		FirstName=@FirstName,
		MiddleInitial=@MiddleInitial,
		LastName=@LastName,
		Company=@Company,
		Line1=@Line1,
		Line2=@Line2,
		Line3=@Line3,
		City=@City,
		RegionBvin=@RegionBvin,
		RegionName=@RegionName,
		PostalCode=@PostalCode,
		CountryBvin=@CountryBvin,
		CountryName=@CountryName,
		CountyBvin=@CountyBvin,
		CountyName=@CountyName,
		Phone=@Phone,
		Fax=@Fax,
		WebSiteUrl=@WebSiteUrl,
		LastUpdated=GetDate(),
		UserBvin=@UserBvin
		WHERE
		bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END










GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ShippingMethod_d]

@bvin varchar(36)

AS
	BEGIN TRY

		DELETE FROM bvc_ShippingMethod_CountryRestriction WHERE ShippingMethodBvin = @bvin

		DELETE FROM bvc_ShippingMethod_RegionRestriction WHERE ShippingMethodBvin = @bvin

		DELETE FROM bvc_ShippingMethod WHERE bvin=@bvin 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductFile_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_d]

@bvin varchar(36)

AS
	
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM bvc_ProductFileXProduct WHERE ProductFileId = @bvin	
			DELETE FROM bvc_ProductFile WHERE bvin=@bvin
		COMMIT TRANSACTION
		RETURN
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Region_d]'
GO



CREATE PROCEDURE [dbo].[bvc_Region_d]

@bvin varchar(36)

AS

	BEGIN TRY
		/*DELETE bvc_ShipMethodXRegion WHERE RegionID=@bvin*/

		DELETE bvc_County WHERE RegionID=@bvin

		DELETE bvc_Region WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Manufacturer_i]'
GO


CREATE PROCEDURE [dbo].[bvc_Manufacturer_i]
@bvin varchar(36),
@DisplayName nvarchar(255),
@EmailAddress nvarchar(255),
@Address ntext,
@DropShipEmailTemplateId varchar(36)

AS
	BEGIN TRY
		INSERT INTO
		bvc_Manufacturer
		(bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated)
		VALUES
		(@bvin,@DisplayName,@EmailAddress,@Address,@DropShipEmailTemplateId,GetDate())

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductChoiceCombination_i ]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/10/2006
-- Description:	Inserts a Product Choice Combination
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceCombination_i ]
	@bvin varchar(36), 
	@choiceId varchar(36),
	@choiceOptionId varchar(36),
	@productId varchar(36),
	@parentProductId varchar(36),
	@available bit
AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_ProductChoiceCombinations (bvin, ChoiceId, ChoiceOptionId, ProductId, ParentProductId, Available, LastUpdated) VALUES (@bvin, @choiceId, @choiceOptionId, @productId, @parentProductId, @available, GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



















GO
PRINT N'Creating [dbo].[bvc_ContentBlock_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ColumnID,SortOrder,ControlName,LastUpdated FROM bvc_ContentBlock
		WHERE bvin=@bvin
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductFile_i]'
GO






CREATE PROCEDURE [dbo].[bvc_ProductFile_i]

	@bvin varchar(36),
	@ProductID varchar(36),
	@AvailableMinutes int,
	@MaxDownloads int,
	@FileName nvarchar(100),
	@ShortDescription nvarchar(100)

AS
	DECLARE @count int

	SELECT @count = COUNT(*) FROM bvc_ProductFile WHERE bvin = @bvin

	BEGIN TRY
		BEGIN TRANSACTION
			IF @count = 0
			BEGIN
				INSERT INTO bvc_ProductFile (bvin, [FileName], ShortDescription, LastUpdated) VALUES (@bvin, @FileName, @ShortDescription, GetDate())
			END
		
			IF @ProductId != ''
			BEGIN
				INSERT INTO bvc_ProductFileXProduct (ProductFileId, ProductId, AvailableMinutes, MaxDownloads, LastUpdated)
					VALUES (@bvin, @ProductID, @AvailableMinutes, @MaxDownloads, GetDate())
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN
















GO
PRINT N'Creating [dbo].[bvc_Manufacturer_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Manufacturer_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated FROM bvc_Manufacturer
			WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Region_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Region_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,[Name],Abbreviation,CountryID,LastUpdated
		FROM bvc_Region WHERE bvin=@bvin

		exec bvc_County_ByRegion_s @bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ContentBlock_SortOrder_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_SortOrder_u]

@bvin varchar(36),
@SortOrder int

AS

	BEGIN TRY
		UPDATE bvc_ContentBlock
		SET
		SortOrder=@SortOrder,LastUpdated=GetDate()
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	












GO
PRINT N'Creating [dbo].[bvc_ProductChoiceCombinations_ForProduct_s]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/15/2006
-- Description:	Finds a Product Choice combination for a particular product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceCombinations_ForProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT a.bvin, ChoiceId, ChoiceOptionId, ProductId, ParentProductId, Available FROM bvc_ProductChoiceCombinations AS a JOIN bvc_ProductChoiceOptions AS b ON a.ChoiceOptionId = b.Bvin WHERE ParentProductId = @bvin ORDER BY ProductId, ChoiceId, b.[Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




















GO
PRINT N'Creating [dbo].[bvc_ProductFile_ProductCount_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_ProductCount_s]
@bvin varchar(36)	
AS

	BEGIN TRY	
		SELECT
		COUNT(*) As ProductCount
		FROM bvc_ProductFileXProduct
		WHERE ProductFileId = @bvin
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Manufacturer_u]'
GO


CREATE PROCEDURE [dbo].[bvc_Manufacturer_u]
@bvin varchar(36),
@DisplayName nvarchar(255),
@EmailAddress nvarchar(255),
@Address ntext,
@DropShipEmailTemplateId varchar(36)

AS
	BEGIN TRY
		UPDATE
			bvc_Manufacturer
		SET
		DisplayName=@DisplayName,
		EmailAddress=@EmailAddress,
		Address=@Address,
		DropShipEmailTemplateId=@DropShipEmailTemplateId,
		LastUpdated=GetDate()
		
		WHERE
		bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ContentBlock_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_u]

@bvin varchar(36),
@ColumnID varchar(36),
@SortOrder int,
@ControlName nvarchar(512)

AS
	BEGIN TRY
		UPDATE bvc_ContentBlock
		SET
		
		bvin=@bvin,
		ColumnID=@ColumnID,
		SortOrder=@SortOrder,
		ControlName=@ControlName,
		LastUpdated=GetDate()
		
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_MailingList_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingList_All_s]

AS
	BEGIN TRY	
		SELECT bvin,[Name],Private,LastUpdated FROM bvc_MailingList ORDER BY [Name]
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductFile_RemoveProduct_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_RemoveProduct_d]

@FileBvin varchar(36),
@ProductBvin varchar(36)

AS
	
	BEGIN TRY
		DELETE FROM bvc_ProductFileXProduct WHERE ProductFileId = @FileBvin	AND ProductId = @ProductBvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_MailingList_CheckMembership_s]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingList_CheckMembership_s]

@bvin varchar(36),
@EmailAddress nvarchar(255)

AS
	BEGIN TRY
		SELECT Count(EmailAddress) as MembershipCount FROM bvc_MailingListMember
		WHERE ListID=@bvin AND EmailAddress=@EmailAddress
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductFile_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductFile_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvc_ProductFile.bvin,bvc_ProductFileXProduct.ProductID,bvc_ProductFileXProduct.AvailableMinutes,bvc_ProductFileXProduct.MaxDownloads,bvc_ProductFile.[FileName],bvc_ProductFile.ShortDescription,bvc_ProductFileXProduct.LastUpdated
		FROM bvc_ProductFile LEFT JOIN bvc_ProductFileXProduct ON bvc_ProductFile.bvin = bvc_ProductFileXProduct.ProductFileId
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_DropShipNotification_d]'
GO




CREATE PROCEDURE [dbo].[bvc_DropShipNotification_d]
@bvin varchar(36)
AS
	
	BEGIN TRY
		DELETE FROM bvc_DropShipNotification WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN







GO
PRINT N'Creating [dbo].[bvc_MailingList_s]'
GO



CREATE PROCEDURE [dbo].[bvc_MailingList_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,[Name],Private,LastUpdated FROM bvc_MailingList WHERE bvin=@bvin

		EXEC bvc_MailingListMember_ByListID_s @bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductFile_u]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductFile_u]

@bvin varchar(36),
@ProductID varchar(36),
@AvailableMinutes int,
@MaxDownloads int,
@FileName nvarchar(100),
@ShortDescription nvarchar(100)

AS

	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE bvc_ProductFile
			SET
			bvin=@bvin,
			FileName=@FileName,
			ShortDescription=@ShortDescription,
			LastUpdated=GetDate()
			WHERE
			bvin=@bvin

			IF @ProductId != ''
			BEGIN
				UPDATE bvc_ProductFileXProduct
				SET
				AvailableMinutes=@AvailableMinutes,
				MaxDownloads=@MaxDownloads,
				LastUpdated=GetDate()		
				WHERE
				ProductFileId = @bvin And ProductId = @ProductId

				IF @@ROWCOUNT = 0
				BEGIN
					INSERT INTO bvc_ProductFileXProduct
					(ProductFileId, ProductId, AvailableMinutes, MaxDownloads, LastUpdated)
					VALUES (@bvin, @ProductId, @AvailableMinutes, @MaxDownloads, GetDate())
				END
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH	

	RETURN

























GO
PRINT N'Creating [dbo].[bvc_DropShipNotification_i]'
GO




CREATE PROCEDURE [dbo].[bvc_DropShipNotification_i]
@bvin varchar(36),
@OrderBvin varchar(36),
@TimeOfRequest datetime,
@Processed bit
AS
	
	BEGIN TRY
		INSERT INTO bvc_DropShipNotification
		(
			bvin,
			OrderBvin,
			TimeOfRequest,
			Processed,
			LastUpdated
		)
		VALUES
		(
			@bvin,
			@OrderBvin,
			@TimeOfRequest,
			@Processed,
			GetDate()
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN







GO
PRINT N'Creating [dbo].[bvc_Offer_HighestOrderByPriority_s]'
GO














CREATE PROCEDURE [dbo].[bvc_Offer_HighestOrderByPriority_s]
	@priority tinyint
AS

DECLARE @returnValue tinyint
	BEGIN TRY	
		SET @returnValue = (SELECT COALESCE(MAX([Order]),1) FROM bvc_Offers WHERE Priority = @priority)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN @returnValue























GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell_ByProduct_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductCrossSell_ByProduct_s] 
	
	@bvin varchar(36)
	
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ProductBvin, CrossSellBvin, [Order], DescriptionOverride, LastUpdated FROM bvc_ProductCrossSell WHERE ProductBvin = @bvin ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END









GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_i]'
GO




CREATE PROCEDURE [dbo].[bvc_ShippingMethod_i]

@bvin varchar(36),
@Adjustment Decimal(18,10),
@AdjustmentType int,
@Name nvarchar(255),
@ShippingProviderId varchar(36)

AS
	BEGIN TRY
		INSERT INTO
		bvc_ShippingMethod
		(
		bvin,
		Adjustment,
		AdjustmentType,
		[Name],
		ShippingProviderId,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@Adjustment,
		@AdjustmentType,
		@Name,
		@ShippingProviderId,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductType_Exists_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_Exists_s]

@ProductTypeName nvarchar(512)

AS
	BEGIN TRY
		SELECT 
			bvin,
			ProductTypeName,
			IsPermanent,
			LastUpdated

		FROM bvc_ProductType

		WHERE ProductTypeName=@ProductTypeName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i	
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_DropShipNotification_s]'
GO




CREATE PROCEDURE [dbo].[bvc_DropShipNotification_s]
@bvin varchar(36)
AS
	
	BEGIN TRY
		SELECT bvin, OrderBvin, TimeOfRequest, Processed, LastUpdated FROM bvc_DropShipNotification WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN







GO
PRINT N'Creating [dbo].[bvc_ProductFileByFilenameAndDescription_s]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductFileByFilenameAndDescription_s]

@fileName nvarchar(100),
@shortDescription nvarchar(100)

AS
	BEGIN TRY
		SELECT
		bvc_ProductFile.bvin
		FROM bvc_ProductFile WHERE FileName = @fileName AND ShortDescription = @shortDescription

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















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
PRINT N'Creating [dbo].[bvc_ShippingMethod_RegionRestriction_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ShippingMethod_RegionRestriction_d]
	@ShippingMethodBvin varchar(36),
	@RegionBvin varchar(36)

AS

	BEGIN TRY
		DELETE FROM bvc_ShippingMethod_RegionRestriction 
		WHERE ShippingMethodBvin=@ShippingMethodBvin AND RegionBvin=@RegionBvin

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN





















GO
PRINT N'Creating [dbo].[bvc_Offer_i]'
GO












CREATE PROCEDURE [dbo].[bvc_Offer_i]
	@bvin varchar(36),
	@name nvarchar(50),
	@startDate datetime,
	@endDate datetime,
	@offerType nvarchar(50),
	@requiresCouponCode bit,
    @generateUniquePromotionalCodes bit,
    @promotionalCode varchar(36),
    @useType int,
    @useTimes int,
    @cantBeCombined bit,
	@enabled bit,
	@order int,
	@priority tinyint

AS
	BEGIN TRY
		EXEC @order = bvc_Offer_HighestOrderByPriority_s @priority;
		SET @order = @order + 1;
	
		INSERT INTO bvc_Offers (bvin, [Name], StartDate, EndDate, OfferType, 
			RequiresCouponCode, GenerateUniquePromotionalCodes, PromotionalCode, 
			UseType, UseTimes, CantBeCombined, Enabled, [Order], Priority, LastUpdated)
		VALUES (@bvin, @name, @startDate, @endDate, @offerType, @requiresCouponCode,
			@generateUniquePromotionalCodes, @promotionalCode, @useType, @useTimes, 
			@cantBeCombined, @enabled, @order, @priority, GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN



























GO
PRINT N'Creating [dbo].[bvc_ContentColumn_i]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentColumn_i]
@bvin varchar(36),
@DisplayName nvarchar(512),
@SystemColumn int = 0

AS
	BEGIN TRY
		INSERT INTO bvc_ContentColumn
		(
		bvin,
		DisplayName,
		SystemColumn,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@DisplayName,
		@SystemColumn,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_DropShipNotification_u]'
GO




CREATE PROCEDURE [dbo].[bvc_DropShipNotification_u]
@bvin varchar(36),
@OrderBvin varchar(36),
@TimeOfRequest datetime,
@Processed bit
AS
	
	BEGIN TRY
		UPDATE bvc_DropShipNotification SET OrderBvin = @OrderBvin,
			TimeOfRequest = @TimeOfRequest,
			Processed = @Processed,
			LastUpdated = GetDate()
		WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN







GO
PRINT N'Creating [dbo].[bvc_Manufacturer_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Manufacturer_All_s]
AS
	BEGIN TRY
		SELECT bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated FROM bvc_Manufacturer
		ORDER BY DisplayName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_RegionRestriction_i]'
GO






CREATE PROCEDURE [dbo].[bvc_ShippingMethod_RegionRestriction_i]
	@ShippingMethodBvin varchar(36),
	@RegionBvin varchar(36)

AS

	BEGIN TRY
		INSERT INTO bvc_ShippingMethod_RegionRestriction (ShippingMethodBvin, RegionBvin)
		VALUES (@ShippingMethodBvin, @RegionBvin)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN





















GO
PRINT N'Creating [dbo].[bvc_ProductFileByProduct_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductFileByProduct_s]

@bvin varchar(36)

AS
	BEGIN TRY	
		SELECT
		bvc_ProductFile.bvin,bvc_ProductFileXProduct.ProductID,bvc_ProductFileXProduct.AvailableMinutes,
		bvc_ProductFileXProduct.MaxDownloads,bvc_ProductFile.[FileName],
		bvc_ProductFile.ShortDescription,bvc_ProductFileXProduct.LastUpdated
		FROM bvc_ProductFile JOIN bvc_ProductFileXProduct ON bvc_ProductFile.bvin = bvc_ProductFileXProduct.ProductFileId
		WHERE bvc_ProductFileXProduct.ProductID=@bvin ORDER BY ShortDescription

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_ProductFile_AddProduct_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductFile_AddProduct_i]

@FileBvin varchar(36),
@ProductBvin varchar(36),
@AvailableMinutes int,
@MaxDownloads int

AS
	
	BEGIN TRY
		INSERT INTO bvc_ProductFileXProduct(ProductFileId, ProductId, AvailableMinutes, MaxDownloads, LastUpdated)
			VALUES(@FileBvin, @ProductBvin, @AvailableMinutes, @MaxDownloads, GetDate())
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















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
PRINT N'Creating [dbo].[bvc_Offer_Priority_u]'
GO













CREATE PROCEDURE [dbo].[bvc_Offer_Priority_u]
	@componentName As nvarchar(50),
	@priority As tinyint

AS
	BEGIN TRY
		UPDATE bvc_Offers Set Priority = @priority WHERE [OfferType] = @componentName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN



























GO
PRINT N'Creating [dbo].[bvc_Manufacturer_ByUserID_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Manufacturer_ByUserID_s]

@UserId varchar(36)

AS
	BEGIN TRY
		SELECT 
			bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated
		FROM bvc_Manufacturer JOIN bvc_UserXContact ON bvc_Manufacturer.bvin = bvc_UserXContact.ContactId
		WHERE bvc_UserXContact.UserId = @UserId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN



















GO
PRINT N'Creating [dbo].[bvc_RoleXRolePermission_d]'
GO



CREATE PROCEDURE [dbo].[bvc_RoleXRolePermission_d]

		@RoleID varchar(36),
		@PermissionID varchar(36)
AS

	BEGIN TRY	
		DELETE FROM bvc_RoleXRolePermission WHERE RoleID=@RoleID AND PermissionID=@PermissionID
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductFile_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductFile_All_s]
@StartRowIndex int = 0,
@MaximumRows int = 9999999
AS
	BEGIN TRY;
		WITH files As
		(SELECT 
			ROW_NUMBER() OVER (ORDER BY FileName) As RowNum,
			bvin, [FileName], ShortDescription
		FROM bvc_ProductFile)

		SELECT *, (SELECT COUNT(*) FROM files) AS TotalRowCount FROM files
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		
		RETURN	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ShippingMethod_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		Adjustment,
		AdjustmentType,
		[Name],
		ShippingProviderId,
		LastUpdated
		FROM bvc_ShippingMethod
		  WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Offer_s]'
GO













CREATE PROCEDURE [dbo].[bvc_Offer_s]
	@bvin varchar(36)
AS
	BEGIN TRY
		SELECT bvin, [Name], StartDate, EndDate, OfferType, RequiresCouponCode, GenerateUniquePromotionalCodes, PromotionalCode, 
			UseType, UseTimes, CantBeCombined, Enabled, [Order], Priority, LastUpdated FROM bvc_Offers WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN






















GO
PRINT N'Creating [dbo].[bvc_ContentBlock_ByColumnID_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentBlock_ByColumnID_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ColumnID,SortOrder,ControlName,LastUpdated FROM bvc_ContentBlock
		WHERE ColumnID=@bvin
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










GO
PRINT N'Creating [dbo].[bvc_ProductType_i]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductType_i]
@bvin varchar(36),
@ProductTypeName nvarchar(512),
@IsPermanent bit

AS
	
	BEGIN TRY
		INSERT INTO bvc_ProductType
		(
			bvin,
			ProductTypeName,
			IsPermanent,
			LastUpdated
		)
		VALUES
		(
			@bvin,
			@ProductTypeName,
			@IsPermanent,
			GetDate()
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN






GO
PRINT N'Creating [dbo].[bvc_ContentColumn_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentColumn_u]

@bvin varchar(36),
@DisplayName nvarchar(512),
@SystemColumn int = 0

AS
	BEGIN TRY
		UPDATE bvc_ContentColumn
		SET
		bvin=@bvin,
		DisplayName=@DisplayName,
		SystemColumn=@SystemColumn,
		LastUpdated=GetDate()
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ShippingMethod_u]

@bvin varchar(36),
@Adjustment Decimal(18,10),
@AdjustmentType int,
@Name nvarchar(255),
@ShippingProviderId varchar(36)

AS
	BEGIN TRY
		UPDATE
			bvc_ShippingMethod
		SET
		bvin=@bvin,
		Adjustment=@Adjustment,
		AdjustmentType=@AdjustmentType,
		[Name]=@Name,
		ShippingProviderId=@ShippingProviderId,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_RoleXRolePermission_i]'
GO



CREATE PROCEDURE [dbo].[bvc_RoleXRolePermission_i]

		@RoleID varchar(36),
		@PermissionID varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_RoleXRolePermission WHERE RoleID=@RoleID AND PermissionID=@PermissionID

		INSERT INTO bvc_RoleXRolePermission
		(RoleID,PermissionID)
		VALUES
		(@RoleID,@PermissionID)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













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
PRINT N'Creating [dbo].[bvc_ProductFilter_ByName_s]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/28/2006
-- Description:	Finds a Product Filter by name
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductFilter_ByName_s]
	@name nvarchar(300),
	@page nvarchar(1000)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, FilterName, Criteria, Page, LastUpdated FROM bvc_ProductFilter WHERE FilterName = @name And Page = @page
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_Offer_u]'
GO












CREATE PROCEDURE [dbo].[bvc_Offer_u]
	@bvin varchar(36),
	@name nvarchar(50),
	@startDate datetime,
	@endDate datetime,
	@offerType nvarchar(50),
	@requiresCouponCode bit,
    @generateUniquePromotionalCodes bit,
    @promotionalCode varchar(36),
    @useType int,
    @useTimes int,
    @cantBeCombined bit,
	@enabled bit,
	@order int,
	@priority tinyint

AS
	BEGIN TRY
		UPDATE bvc_Offers Set bvin = @bvin, Name = @name, StartDate = @startDate, EndDate = @endDate, 
			OfferType = @offerType, RequiresCouponCode = @requiresCouponCode, GenerateUniquePromotionalCodes = @generateUniquePromotionalCodes, 
			PromotionalCode = @promotionalCode, UseType = @useType, UseTimes = @useTimes, CantBeCombined = @cantBeCombined, 
			Enabled = @enabled, [Order] = @order, Priority = @priority, LastUpdated = GetDate() WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN



























GO
PRINT N'Creating [dbo].[bvc_Offer_All_s]'
GO












CREATE PROCEDURE [dbo].[bvc_Offer_All_s]
	
AS
	BEGIN TRY
		SELECT bvin, [Name], StartDate, EndDate, OfferType, RequiresCouponCode, GenerateUniquePromotionalCodes, PromotionalCode, 
			UseType, UseTimes, CantBeCombined, Enabled, [Order], Priority, LastUpdated FROM bvc_Offers ORDER BY Priority, [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN





















GO
PRINT N'Creating [dbo].[bvc_ProductFilter_d ]'
GO




-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/28/2006
-- Description:	Deletes a Product Filter
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductFilter_d ]
	@bvin varchar(36) 
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductFilter WHERE bvin = @bvin
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




























GO
PRINT N'Creating [dbo].[bvc_ContentColumn_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ContentColumn_All_s]

AS
	BEGIN TRY
		SELECT bvin,DisplayName,SystemColumn,LastUpdated FROM bvc_ContentColumn
		ORDER BY DisplayName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
Return











GO
PRINT N'Creating [dbo].[bvc_ContentColumn_ByName_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ContentColumn_ByName_s]

@DisplayName nvarchar(512),
@columnBvin varchar(36) = ''

AS
	BEGIN TRY
		SELECT bvin,DisplayName,SystemColumn,LastUpdated FROM bvc_ContentColumn
		WHERE DisplayName=@DisplayName
		
		SET @columnBvin = (Select bvin FROM bvc_ContentColumn WHERE DisplayName=@DisplayName)
			
		EXEC bvc_ContentBlock_ByColumnID_s @columnBvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











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
PRINT N'Creating [dbo].[bvc_ProductModifier_RemoveFromProduct_d ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/26/2006
-- Description:	Removes a shared modifier from a product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_RemoveFromProduct_d ]	
	@productId varchar(36),
	@modifierId varchar(36)
AS
BEGIN
	BEGIN TRY	
		DELETE FROM bvc_ProductXModifier WHERE ModifierId = @modifierId AND ProductId = @productId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN
END





















GO
PRINT N'Creating [dbo].[bvc_Sale_AllValid_s]'
GO





CREATE PROCEDURE [dbo].[bvc_Sale_AllValid_s]

AS

	BEGIN TRY
		SELECT bvin, [Name], SaleType, DiscountType, AllowSaleBelowCost, Amount, 
			StartDate, EndDate, LastUpdated FROM bvc_Sale WHERE	EndDate >= GetDate()
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN




















GO
PRINT N'Creating [dbo].[bvc_ContentColumn_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ContentColumn_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,DisplayName,SystemColumn,LastUpdated FROM bvc_ContentColumn
		WHERE bvin=@bvin
		
		EXEC bvc_ContentBlock_ByColumnID_s @bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	













GO
PRINT N'Creating [dbo].[bvc_ProductFilter_i ]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/28/2006
-- Description:	Inserts a Product Filter
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductFilter_i ]
	@bvin varchar(36), 
	@name nvarchar(300),
	@criteria nvarchar(max),
	@page nvarchar(1000)
AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_ProductFilter (bvin, FilterName, Criteria, Page, LastUpdated) VALUES (@bvin, @name, @criteria, @page, GetDate())		
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_ProductFilter_All_s]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/28/2006
-- Description:	Finds a Product Filter by page
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductFilter_All_s]
	@page nvarchar(1000)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, FilterName, Criteria, Page, LastUpdated FROM bvc_ProductFilter WHERE Page = @page ORDER BY FilterName
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_Sale_All_s]'
GO






CREATE PROCEDURE [dbo].[bvc_Sale_All_s]

AS

	BEGIN TRY
		SELECT bvin, [Name], SaleType, DiscountType, AllowSaleBelowCost, Amount, 
			StartDate, EndDate, LastUpdated FROM bvc_Sale
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN





















GO
PRINT N'Creating [dbo].[bvc_ProductFilter_s]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/28/2006
-- Description:	Finds a Product Filter
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductFilter_s]
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, FilterName, Criteria, Page, LastUpdated FROM bvc_ProductFilter WHERE bvin = @bvin
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_ProductType_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_s]

@bvin varchar(36)

AS

	BEGIN TRY
		SELECT 
		bvin,
		ProductTypeName,
		IsPermanent,
		LastUpdated

		FROM bvc_ProductType

		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_Sale_i]'
GO









CREATE PROCEDURE [dbo].[bvc_Sale_i]
	@bvin varchar(36),
	@name nvarchar(100),
	@saleType int,
	@discountType int,
	@allowSaleBelowCost bit,
	@amount decimal(18,10),
	@startDate datetime,
	@endDate datetime

AS
	
	BEGIN TRY
		INSERT INTO bvc_Sale (bvin, [Name], SaleType, DiscountType, AllowSaleBelowCost, Amount, StartDate, EndDate, LastUpdated)
			VALUES (@bvin, @name, @saleType, @discountType, @allowSaleBelowCost, @amount, @startDate, @endDate, GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN
























GO
PRINT N'Creating [dbo].[bvc_ProductFilter_u]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/28/2006
-- Description:	Updates a Product Filter
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductFilter_u]
	@bvin varchar(36), 
	@name nvarchar(300),
	@criteria nvarchar(max),
	@page nvarchar(1000)
AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductFilter SET bvin = @bvin, FilterName = @name, Criteria = @criteria, Page = @page, LastUpdated = GetDate() WHERE bvin = @bvin
	END TRY
	BEGIN CATCH		
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



























GO
PRINT N'Creating [dbo].[bvc_ProductType_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_u]

@bvin  varchar(36),
@ProductTypeName nvarchar(512),
@IsPermanent bit

AS

	BEGIN TRY
		UPDATE bvc_ProductType

		SET
		ProductTypeName=@ProductTypeName,
		IsPermanent=@IsPermanent,
		LastUpdated = GetDate()
		WHERE [bvin]=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






GO
PRINT N'Creating [dbo].[bvc_Sale_s]'
GO





CREATE PROCEDURE [dbo].[bvc_Sale_s]
	@bvin varchar(36)
AS

	BEGIN TRY
		SELECT bvin, [Name], SaleType, DiscountType, AllowSaleBelowCost, Amount, 
			StartDate, EndDate, LastUpdated FROM bvc_Sale WHERE	bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN




















GO
PRINT N'Creating [dbo].[bvc_Region_ByCountry_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Region_ByCountry_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,[Name],Abbreviation,CountryID,LastUpdated
		FROM bvc_Region
		WHERE (CountryID=@bvin) ORDER BY [Name]

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Sale_u]'
GO








CREATE PROCEDURE [dbo].[bvc_Sale_u]
	@bvin varchar(36),
	@name nvarchar(100),
	@saleType int,
	@discountType int,
	@allowSaleBelowCost bit,
	@amount decimal(18,10),
	@startDate datetime,
	@endDate datetime

AS

	BEGIN TRY
		UPDATE bvc_Sale Set bvin = @bvin, Name = @name, SaleType = @saleType, DiscountType = @discountType, AllowSaleBelowCost = @allowSaleBelowCost,
			Amount = @amount, StartDate = @startDate, EndDate = @endDate, LastUpdated = GetDate() WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN























GO
PRINT N'Creating [dbo].[bvc_ProductModifierOption_ByBvin_s ]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/15/2006
-- Description:	Loads a particular product modifier
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifierOption_ByBvin_s ]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ModifierId, Name, [Order], CostAdjustment, PriceAdjustment, ShippingAdjustment, WeightAdjustment, IsDefault, [Null], LastUpdated From bvc_ProductModifierOption WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END





















GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_ByOrderBvin_d]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderCoupon_ByOrderBvin_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_OrderCoupon WHERE OrderBvin=@bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_SaleXCategory_BySaleId_d]'
GO







CREATE PROCEDURE [dbo].[bvc_SaleXCategory_BySaleId_d]
	@saleId varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_SaleXCategory WHERE SaleId = @saleId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN






















GO
PRINT N'Creating [dbo].[bvc_SearchQuery_All_d]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_All_d]

AS

	BEGIN TRY
		DELETE FROM bvc_SearchQuery 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductModifierOption_ByModifierBvin_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds all modifier options for a particular choice
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifierOption_ByModifierBvin_s ]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ModifierId, Name, [Order], CostAdjustment, PriceAdjustment, ShippingAdjustment, WeightAdjustment, IsDefault, [Null], LastUpdated FROM bvc_ProductModifierOption WHERE ModifierId = @bvin ORDER BY [ORDER]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




















GO
PRINT N'Creating [dbo].[bvc_SaleXCategory_BySaleId_s]'
GO







CREATE PROCEDURE [dbo].[bvc_SaleXCategory_BySaleId_s]
	@saleId varchar(36)
AS

	BEGIN TRY
		SELECT CategoryId FROM bvc_SaleXCategory WHERE SaleId = @saleId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN






















GO
PRINT N'Creating [dbo].[bvc_ProductUpSell_ByProduct_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductUpSell_ByProduct_s] 
	
	@bvin varchar(36)
	
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ProductBvin, UpSellBvin, [Order], DescriptionOverride, LastUpdated FROM bvc_ProductUpSell WHERE ProductBvin = @bvin ORDER BY [Order]	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END









GO
PRINT N'Creating [dbo].[bvc_ProductModifierOption_d]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Deletes a Product Modifier
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifierOption_d]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductModifierOption WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END














GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ShippingMethod_All_s]

AS
	BEGIN TRY
		SELECT 
		bvin,
		Adjustment,
		AdjustmentType,
		[Name],
		ShippingProviderId,
		LastUpdated
		FROM bvc_ShippingMethod
		Order By [Name]
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_Policy_i]'
GO
CREATE PROCEDURE [dbo].[bvc_Policy_i]

@bvin varchar(36),
@Title nvarchar(Max),
@SystemPolicy int

AS
	BEGIN TRY
		INSERT INTO bvc_Policy
		(
		bvin,
		Title,
		SystemPolicy,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@Title,
		@SystemPolicy,
		GetDate()
		)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










GO
PRINT N'Creating [dbo].[bvc_County_d]'
GO

-- =============================================
-- Author:		Marcus McConnell
-- Create date: 10/11/2005
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_County_d] 
	@bvin varchar(36)	
AS
BEGIN
	BEGIN TRY
		DELETE bvc_County where bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END












GO
PRINT N'Creating [dbo].[bvc_AffiliateReferral_ByCriteria_s]'
GO








CREATE PROCEDURE [dbo].[bvc_AffiliateReferral_ByCriteria_s]

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
PRINT N'Creating [dbo].[bvc_SaleXCategory_i]'
GO






CREATE PROCEDURE [dbo].[bvc_SaleXCategory_i]
	@saleId varchar(36),
	@categoryId varchar(36)

AS

	BEGIN TRY
		INSERT INTO bvc_SaleXCategory (SaleId, CategoryId)
		VALUES (@saleId, @categoryId)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN





















GO
PRINT N'Creating [dbo].[bvc_ProductModifierOption_i ]'
GO






-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Inserts a Product Choice
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifierOption_i ]	
	@bvin varchar(36), 
	@ModifierId varchar(36),
	@Name nvarchar(255),
	@order int,
	@CostAdjustment numeric(18, 10),
    @PriceAdjustment numeric(18, 10),
    @ShippingAdjustment numeric(18, 10),
    @WeightAdjustment numeric(18, 10),
	@IsDefault bit,
	@Null bit
AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_ProductModifierOption(bvin, ModifierId, Name, [Order], CostAdjustment, PriceAdjustment, 
			ShippingAdjustment, WeightAdjustment, IsDefault, [Null], LastUpdated) VALUES(@bvin, @ModifierId, @Name, @order, 
			@CostAdjustment, @PriceAdjustment, @ShippingAdjustment, @WeightAdjustment, @IsDefault, @Null, GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



















GO
PRINT N'Creating [dbo].[bvc_ProductUpSell_ByProductId_d]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductUpSell_ByProductId_d] 
	
	@bvin varchar(36)

AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductUpSell WHERE ProductBvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END







GO
PRINT N'Creating [dbo].[bvc_County_i]'
GO
-- =============================================
-- Author:		Marcus McConnell
-- Create date: 10/11/2005
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_County_i] 
	
	@bvin varchar(36),
	@Name nvarchar(Max),
	@RegionID varchar(36)

AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_County
		(bvin,[Name],RegionID,LastUpdated)
		VALUES
		(@bvin,@Name,@RegionID,GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_ProductModifierOption_u ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Updates a Product Modifier Option
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifierOption_u ]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36), 
	@ModifierId varchar(36),
	@Name nvarchar(255),
	@order int,
	@CostAdjustment numeric(18, 10),
    @PriceAdjustment numeric(18, 10),
    @ShippingAdjustment numeric(18, 10),
    @WeightAdjustment numeric(18, 10),
	@IsDefault bit,
	@Null bit
AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductModifierOption SET ModifierId = @ModifierId, Name = @Name, [Order] = @order, CostAdjustment = @CostAdjustment, 
			PriceAdjustment = @PriceAdjustment, ShippingAdjustment = @ShippingAdjustment, WeightAdjustment = @WeightAdjustment, IsDefault = @IsDefault,
			[Null] = @Null, LastUpdated = GetDate() WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




















GO
PRINT N'Creating [dbo].[bvc_SaleXProduct_BySaleId_d]'
GO







CREATE PROCEDURE [dbo].[bvc_SaleXProduct_BySaleId_d]
	@saleId varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_SaleXProduct WHERE SaleId = @saleId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN






















GO
PRINT N'Creating [dbo].[bvc_AffiliateReferral_i]'
GO







CREATE PROCEDURE [dbo].[bvc_AffiliateReferral_i]

@AffiliateId varchar(36),
@ReferrerUrl nvarchar(1000),
@TimeOfReferral datetime = null

AS
	BEGIN TRY
		IF @TimeOfReferral IS NULL
		BEGIN
			SET @TimeOfReferral = GetDate()
		END
		INSERT INTO bvc_AffiliateReferral (id, AffId, ReferrerUrl, TimeOfReferral)
			VALUES (NewId(), @AffiliateId, @ReferrerUrl, @TimeOfReferral)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_Policy_u]'
GO

CREATE PROCEDURE [dbo].[bvc_Policy_u]

@bvin varchar(36),
@Title nvarchar(Max),
@SystemPolicy int

AS
	BEGIN TRY
		Update bvc_Policy
		SET
		bvin=@bvin,
		Title=@Title,
		SystemPolicy=@SystemPolicy,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_ByOrderBvin_s]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderCoupon_ByOrderBvin_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		CouponCode,
		OrderBvin,
		LastUpdated 
		FROM bvc_OrderCoupon
		WHERE  OrderBvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Policy_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Policy_All_s]

AS
	BEGIN TRY
		SELECT bvin,Title,SystemPolicy,LastUpdated 
		FROM bvc_Policy
		ORDER BY Title
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_SiteTerm_d]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_d]

@SiteTerm nvarchar(500)

AS
	BEGIN TRY
		DELETE FROM bvc_SiteTerm WHERE SiteTerm=@SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN 







GO
PRINT N'Creating [dbo].[bvc_Region_i]'
GO

CREATE PROCEDURE [dbo].[bvc_Region_i]

@bvin varchar(36),
@Name nvarchar(100),
@Abbreviation varchar(36),
@CountryID varchar(36)

AS
	BEGIN TRY
		INSERT INTO bvc_Region
		(bvin,[Name],Abbreviation,CountryID,LastUpdated)
		VALUES(@bvin,@Name,@Abbreviation,@CountryID,GetDate())

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_ProductUpSell_Count_Admin_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/17/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductUpSell_Count_Admin_s] 
	
	@bvin varchar(36)
	
AS
BEGIN
	BEGIN TRY
		SELECT COUNT(*) As [Count] FROM bvc_ProductUpSell WHERE ProductBvin = @bvin	
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END










GO
PRINT N'Creating [dbo].[bvc_OrderNote_ByOrderId_s]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderNote_ByOrderId_s]

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
PRINT N'Creating [dbo].[bvc_ProductChoiceCombination_s ]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/10/2006
-- Description:	Finds a Product Choice Combination
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceCombination_s ]
	@bvin varchar(36) 	
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ChoiceId, ChoiceOptionId, ProductId, ParentProductId, Available, LastUpdated FROM bvc_ProductChoiceCombinations WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




















GO
PRINT N'Creating [dbo].[bvc_Fraud_ByCriteria_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Fraud_ByCriteria_s]

@RuleValue nvarchar(Max) = NULL,
@RuleType int = NULL

AS
	BEGIN TRY			
			SELECT bvin,RuleType,RuleValue,LastUpdated
			FROM bvc_Fraud
			WHERE
				(RuleValue = @RuleValue OR @RuleValue is NULL)
				AND
				(RuleType = @RuleType OR @RuleType IS NULL)
			RETURN		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_Sql_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_Policy_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Policy_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,Title,SystemPolicy,LastUpdated 
		FROM bvc_Policy
		WHERE bvin=@bvin

		exec bvc_PolicyBlock_ByPolicyId_s @bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_UserXContact_d]'
GO



CREATE PROCEDURE [dbo].[bvc_UserXContact_d]
@UserID varchar(36),
@ContactID varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_UserXContact WHERE
		UserID=@UserID AND ContactID=@ContactID

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_SiteTerm_i]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_i]

@SiteTerm nvarchar(255),
@SiteTermValue nvarchar(500)

AS
	BEGIN TRY
		INSERT INTO bvc_SiteTerm (SiteTerm,SiteTermValue)
			VALUES (@SiteTerm,@SiteTermValue)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN 






GO
PRINT N'Creating [dbo].[bvc_ComponentSetting_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSetting_i]

@ComponentID varchar(36),
@SettingName nvarchar(100),
@SettingValue text,
@DeveloperId nvarchar(15),
@ComponentType nvarchar(25),
@ComponentSubType nvarchar(25)

AS
	BEGIN TRY

		DELETE bvc_ComponentSetting WHERE ComponentID=@ComponentID
		AND SettingName = @SettingName

		INSERT INTO bvc_ComponentSetting
		(ComponentID,SettingName,SettingValue,DeveloperId,ComponentType,ComponentSubType)
		VALUES
		(@ComponentID,@SettingName,@SettingValue,@DeveloperId,@ComponentType,@ComponentSubType)
	
	RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_SiteTerm_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_All_s]

AS
	
	BEGIN TRY
		SELECT SiteTerm,SiteTermValue FROM bvc_SiteTerm
		ORDER BY SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN







GO
PRINT N'Creating [dbo].[bvc_County_s]'
GO

-- =============================================
-- Author:		Marcus McConnell
-- Create date: 10/11/2005
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_County_s] 
	
	@bvin varchar(36)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT bvin,[Name],RegionID,LastUpdated FROM bvc_County WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END












GO
PRINT N'Creating [dbo].[bvc_AuthenticationToken_i]'
GO


CREATE PROCEDURE [dbo].[bvc_AuthenticationToken_i]

@bvin varchar(36),
@UserBvin varchar(36),
@ExpirationDate datetime

AS
	BEGIN TRY
		Insert Into bvc_AuthenticationToken
		(
		Bvin,
		UserBvin,
		ExpirationDate,
		LastUpdated
		)
		VALUES
		(
		@Bvin,
		@UserBvin,
		@ExpirationDate,
		GetDate()
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH	
	
	RETURN









GO
PRINT N'Creating [dbo].[bvc_SaleXProduct_BySaleId_s]'
GO







CREATE PROCEDURE [dbo].[bvc_SaleXProduct_BySaleId_s]
	@saleId varchar(36)
AS

	BEGIN TRY
		SELECT ProductId FROM bvc_SaleXProduct WHERE SaleId = @saleId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN






















GO
PRINT N'Creating [dbo].[bvc_County_ByRegion_s]'
GO
-- =============================================
-- Author:		Marcus McConnell
-- Create date: 10/11/2005
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_County_ByRegion_s]

@bvin varchar(36)

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
	
		SELECT bvin,[Name],RegionID,LastUpdated
		FROM bvc_County
		WHERE RegionID=@bvin
		ORDER BY [Name],bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_Fraud_ByBvin_s]'
GO




CREATE PROCEDURE [dbo].[bvc_Fraud_ByBvin_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,RuleType,RuleValue,LastUpdated 
		FROM bvc_Fraud
		WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_UserXContact_i]'
GO

CREATE PROCEDURE [dbo].[bvc_UserXContact_i]
@UserID varchar(36),
@ContactID varchar(36)


AS
	BEGIN TRY
		INSERT INTO bvc_UserXContact
		(UserID,ContactID)
		VALUES
		(
		@UserID,
		@ContactID)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Fraud_ByRule_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Fraud_ByRule_s]
	
@RuleType int

AS
	BEGIN TRY
		SELECT bvin, RuleType, RuleValue, LastUpdated 
		FROM bvc_Fraud 
		WHERE 
		RuleType = @RuleType
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN








GO
PRINT N'Creating [dbo].[bvc_ProductChoiceCombination_u ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/20/2006
-- Description:	Updates a Product Choice Combination
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceCombination_u ]
	@bvin varchar(36), 
	@choiceId varchar(36),
	@choiceOptionId varchar(36),
	@productId varchar(36),
	@parentProductId varchar(36),
	@available bit
AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductChoiceCombinations SET Available = @available, LastUpdated = GetDate() WHERE productId = @productId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END























GO
PRINT N'Creating [dbo].[bvc_ProductUpSell_d]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductUpSell_d] 
	
	@bvin varchar(36)

AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductUpSell WHERE Bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END






GO
PRINT N'Creating [dbo].[bvc_SiteTerm_s]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_s]

@SiteTerm nvarchar(255)

AS

	BEGIN TRY
		SELECT SiteTerm,SiteTermValue FROM bvc_SiteTerm WHERE
		SiteTerm=@SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	RETURN





GO
PRINT N'Creating [dbo].[bvc_County_u]'
GO
-- =============================================
-- Author:		Marcus McConnell
-- Create date: 10/11/2005
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_County_u] 
	
@bvin varchar(36),
@Name nvarchar(Max),
@RegionID varchar(36)

AS
BEGIN
	BEGIN TRY
		UPDATE bvc_County
		SET
		bvin=@bvin,
		[Name]=@Name,
		RegionID=@RegionID,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_SaleXProduct_i]'
GO






CREATE PROCEDURE [dbo].[bvc_SaleXProduct_i]
	@saleId varchar(36),
	@productId varchar(36)

AS
	BEGIN TRY
		INSERT INTO bvc_SaleXProduct (SaleId, ProductId)
		VALUES (@saleId, @productId)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
RETURN





















GO
PRINT N'Creating [dbo].[bvc_ComponentSetting_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSetting_s]

@ComponentID varchar(36),
@SettingName nvarchar(100)

AS
	
BEGIN TRY
	SELECT SettingValue,ComponentID,SettingName,DeveloperId,ComponentType,ComponentSubType FROM bvc_ComponentSetting WHERE
	ComponentID=@ComponentID and
	SettingName =@SettingName

	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH













GO
PRINT N'Creating [dbo].[bvc_PriceGroup_All_s]'
GO






CREATE PROCEDURE [dbo].[bvc_PriceGroup_All_s]
AS
	BEGIN TRY
		SELECT bvin, Name, PricingType, AdjustmentAmount, LastUpdated FROM bvc_PriceGroup		 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_AuthenticationToken_s]'
GO


CREATE PROCEDURE [dbo].[bvc_AuthenticationToken_s]
	
	@bvin varchar(36)

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT 
		Bvin,
		UserBvin,
		ExpirationDate,
		LastUpdated
		FROM
		bvc_AuthenticationToken
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END









GO
PRINT N'Creating [dbo].[bvc_Region_u]'
GO



CREATE PROCEDURE [dbo].[bvc_Region_u]

@bvin varchar(36),
@Name nvarchar(100),
@Abbreviation varchar(36),
@CountryID varchar(36)

AS
	BEGIN TRY
		UPDATE bvc_Region
		SET
		bvin=@bvin,
		[Name]=@Name,
		Abbreviation=@Abbreviation,
		CountryID=@CountryID,
		LastUpdated=GetDate()
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_All_s]'
GO






CREATE PROCEDURE [dbo].[bvc_GiftCertificate_All_s]
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
PRINT N'Creating [dbo].[bvc_UserXRole_d]'
GO


CREATE PROCEDURE [dbo].[bvc_UserXRole_d]
@UserID varchar(36),
@RoleID varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_UserXRole WHERE
		UserID=@UserID AND RoleID=@RoleID

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Fraud_d]'
GO


CREATE PROCEDURE [dbo].[bvc_Fraud_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE bvc_Fraud WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_SaleXProductType_BySaleId_d]'
GO








CREATE PROCEDURE [dbo].[bvc_SaleXProductType_BySaleId_d]
	@saleId varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_SaleXProductType WHERE SaleId = @saleId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN























GO
PRINT N'Creating [dbo].[bvc_TaxClass_d]'
GO

CREATE PROCEDURE [dbo].[bvc_TaxClass_d] 
	@bvin varchar(36)	
AS
BEGIN

	BEGIN TRY
		DELETE FROM bvc_TaxClass where bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END












GO
PRINT N'Creating [dbo].[bvc_ProductUpSell_i]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductUpSell_i] 
	
	@bvin varchar(36),
	@ProductBvin varchar(36),
	@UpSellBvin varchar(36),
	@order int,
	@descriptionOverride nvarchar(512)

AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_ProductUpSell (Bvin, ProductBvin, UpSellBvin, [Order], DescriptionOverride, LastUpdated) 
			VALUES(@bvin, @ProductBvin, @UpSellBvin, @order, @descriptionOverride, GETDATE())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END







GO
PRINT N'Creating [dbo].[bvc_SiteTerm_u]'
GO


CREATE PROCEDURE [dbo].[bvc_SiteTerm_u]

@SiteTerm nvarchar(255),
@SiteTermValue nvarchar(500)

AS
	BEGIN TRY
		UPDATE bvc_SiteTerm SET SiteTermValue=@SiteTermValue WHERE SiteTerm=@SiteTerm
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
		
	RETURN 





GO
PRINT N'Creating [dbo].[bvc_PrintTemplate_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_PrintTemplate_All_s]
	
AS
	BEGIN TRY
		SELECT 
		bvin,
		DisplayName,
		Body,
		RepeatingSection,
		SystemTemplate,
		LastUpdated
		FROM bvc_PrintTemplate
		ORDER BY DisplayName
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_ByCouponCode_d]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderCoupon_ByCouponCode_d]

@OrderBvin varchar(36),
@CouponCode nvarchar(50)

AS
	BEGIN TRY
		DELETE bvc_OrderCoupon 
		WHERE
			OrderBvin=@OrderBvin	
			AND
			CouponCode=@CouponCode
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductChoiceOption_ByBvin_s ]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/15/2006
-- Description:	Loads a particular product choice
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceOption_ByBvin_s ]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ProductChoiceId, ProductChoiceName, [Order], [default], [null] From bvc_ProductChoiceOptions WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




















GO
PRINT N'Creating [dbo].[bvc_Address_ByUserID_d]'
GO

CREATE PROCEDURE [dbo].[bvc_Address_ByUserID_d] 

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE bvc_Address WHERE UserBvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN










GO
PRINT N'Creating [dbo].[bvc_AuthenticationToken_u]'
GO



CREATE PROCEDURE [dbo].[bvc_AuthenticationToken_u]
	
@bvin varchar(36),
@UserBvin varchar(36),
@ExpirationDate datetime

AS
BEGIN
	
	BEGIN TRY
		UPDATE bvc_AuthenticationToken
		SET
		Bvin=@Bvin,
		UserBvin=@UserBvin,
		ExpirationDate=@ExpirationDate,	
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END










GO
PRINT N'Creating [dbo].[bvc_Fraud_Full_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Fraud_Full_s]

@EmailAddress nvarchar(max) = NULL,
@IPAddress nvarchar(max) = NULL,
@DomainName nvarchar(max) = NULL,
@PhoneNumber nvarchar(max) = NULL,
@CreditCardNumber nvarchar(max) = NULL

AS
	BEGIN TRY			
			SELECT Count(bvin) as FraudCountIP FROM bvc_Fraud 			
			WHERE
			(RuleValue=@IPAddress AND RuleType=1)		

			SELECT Count(bvin) as FraudCountDomain FROM bvc_Fraud 			
			WHERE
			(RuleValue=@DomainName AND RuleType=2)

			SELECT Count(bvin) as FraudCountEmail FROM bvc_Fraud 			
			WHERE
			(RuleValue=@EmailAddress AND RuleType=3)

			SELECT Count(bvin) as FraudCountPhone FROM bvc_Fraud 			
			WHERE
			(RuleValue=@PhoneNumber AND RuleType=4)	

			SELECT Count(bvin) as FraudCountCreditCard FROM bvc_Fraud 			
			WHERE
			(RuleValue=@CreditCardNumber AND RuleType=5)		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_Sql_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_SaleXProductType_BySaleId_s]'
GO








CREATE PROCEDURE [dbo].[bvc_SaleXProductType_BySaleId_s]
	@saleId varchar(36)
AS
	BEGIN TRY
		SELECT ProductTypeId FROM bvc_SaleXProductType WHERE SaleId = @saleId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN























GO
PRINT N'Creating [dbo].[bvc_ProductChoiceOption_ByChoiceBvin_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds all choice options for a particular choice
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceOption_ByChoiceBvin_s ]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT bvin, ProductChoiceId, ProductChoiceName, [Order], [default], [null] FROM bvc_ProductChoiceOptions WHERE ProductChoiceId = @bvin ORDER BY [ORDER]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



















GO
PRINT N'Creating [dbo].[bvc_UserXRole_i]'
GO

CREATE PROCEDURE [dbo].[bvc_UserXRole_i]
@UserID varchar(36),
@RoleID varchar(36)


AS
	BEGIN TRY
		INSERT INTO bvc_UserXRole
		(UserID,RoleID)
		VALUES
		(
		@UserID,
		@RoleID)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductUpSell_u]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductUpSell_u] 
	
	@bvin varchar(36),
	@ProductBvin varchar(36),
	@UpSellBvin varchar(36),
	@order int,
	@descriptionOverride nvarchar(512)

AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductUpSell SET Bvin = @bvin, ProductBvin = @ProductBvin, 
			UpSellBvin = @UpSellBvin, [Order] = @order, DescriptionOverride = @descriptionOverride, LastUpdated = GETDATE() WHERE Bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END







GO
PRINT N'Creating [dbo].[bvc_Fraud_i]'
GO

CREATE PROCEDURE [dbo].[bvc_Fraud_i]

@bvin varchar(36),
@RuleType Int,
@RuleValue nvarchar(255)

AS
	BEGIN TRY
		INSERT INTO
		bvc_Fraud
		(bvin,RuleType,RuleValue,LastUpdated)
		VALUES
		(@bvin,@RuleType,@RuleValue,GetDate())
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH







GO
PRINT N'Creating [dbo].[bvc_SaleXProductType_i]'
GO







CREATE PROCEDURE [dbo].[bvc_SaleXProductType_i]
	@saleId varchar(36),
	@productTypeId varchar(36)

AS

	BEGIN TRY
		INSERT INTO bvc_SaleXProductType (SaleId, ProductTypeId)
		VALUES (@saleId, @productTypeId)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN






















GO
PRINT N'Creating [dbo].[bvc_ProductInput_RemoveFromProduct_d ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/26/2006
-- Description:	Removes a shared input from a product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_RemoveFromProduct_d ]	
	@productId varchar(36),
	@inputId varchar(36)
AS
BEGIN
	BEGIN TRY	
		DELETE FROM bvc_ProductXInput WHERE InputId = @inputId AND ProductId = @productId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN
END



















GO
PRINT N'Creating [dbo].[bvc_ProductChoiceOption_d]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Deletes a Product Choice
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceOption_d]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductChoiceOptions WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END













GO
PRINT N'Creating [dbo].[bvc_Vendor_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Vendor_All_s]
AS
	BEGIN TRY	
		SELECT bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated FROM bvc_Vendor
		ORDER BY DisplayName
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_MailingList_d]'
GO



CREATE PROCEDURE [dbo].[bvc_MailingList_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE bvc_MailingListMember WHERE ListID=@bvin
		DELETE bvc_MailingList WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Fraud_RuleApplies_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Fraud_RuleApplies_s]
	
@IPAddress nvarchar(15),
@DomainName nvarchar(255),
@EmailAddress nvarchar(255),
@PhoneNumber nvarchar(255),
@CreditCardNumber nvarchar(255)

AS
	BEGIN TRY		
		SELECT bvin, RuleType, RuleValue, LastUpdated 
		
		FROM bvc_Fraud 
		
		WHERE 
		(RuleType = 1 AND RuleValue=@IPAddress)			
		OR
		(RuleType = 2 AND RuleValue=@DomainName)
		OR
		(RuleType = 3 AND RuleValue=@EmailAddress)
		OR
		(RuleType = 4 AND RuleValue=@PhoneNumber)
		OR
		(RuleType = 5 AND RuleValue=@CreditCardNumber)
				
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN








GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_d]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderCoupon_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_OrderCoupon WHERE bvin=@bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductType_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_All_s]

AS

BEGIN TRY
	SELECT 
		bvin,
		ProductTypeName,
		IsPermanent,
		LastUpdated
	FROM bvc_ProductType
	ORDER BY ProductTypeName
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_ProductChoiceOption_i ]'
GO






-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Inserts a Product Choice
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceOption_i ]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36), 
	@productChoiceId varchar(36),
	@productChoiceName nvarchar(255),
	@order int,
	@default bit,
	@null bit
AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_ProductChoiceOptions(bvin, ProductChoiceId, ProductChoiceName, [Order], [default], [null], LastUpdated) VALUES(@bvin, @productChoiceId, @productChoiceName, @order, @default, @null, GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END


















GO
PRINT N'Creating [dbo].[bvc_SearchQuery_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_All_s]

@MaxResults bigint

AS
	BEGIN TRY
		SELECT Top (@MaxResults)
		bvin,QueryPhrase,ShopperID,LastUpdated
		FROM bvc_SearchQuery ORDER BY QueryPhrase
			
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_MailingList_i]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingList_i]

@bvin varchar(36),
@Name nvarchar(255),
@IsPrivate int

AS
	BEGIN TRY
		INSERT INTO bvc_MailingList 
		(bvin,[Name],Private,LastUpdated) 
		VALUES
		(@bvin,@Name,@IsPrivate,GetDate())
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Fraud_s]'
GO




CREATE PROCEDURE [dbo].[bvc_Fraud_s]


AS
	BEGIN TRY
		SELECT bvin,RuleType,RuleValue,LastUpdated 
		FROM bvc_Fraud

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Vendor_ByUserID_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Vendor_ByUserID_s]

@UserId varchar(36)

AS
	BEGIN TRY
		SELECT 
			bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated
		FROM bvc_Vendor JOIN bvc_UserXContact ON bvc_Vendor.bvin = bvc_UserXContact.ContactId
		WHERE bvc_UserXContact.UserId = @UserId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN



















GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_i]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderCoupon_i]

@bvin varchar(36),
@CouponCode nvarchar(50),
@OrderBvin varchar(36)

AS
	BEGIN TRY
		INSERT INTO
		bvc_OrderCoupon
		(
		bvin,
		CouponCode,
		OrderBvin,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@CouponCode,
		@OrderBvin,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_AffiliateReferral_ByAffiliate_d]'
GO







CREATE PROCEDURE [dbo].[bvc_AffiliateReferral_ByAffiliate_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_AffiliateReferral WHERE AffId=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















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
PRINT N'Creating [dbo].[bvc_PriceGroup_i]'
GO






CREATE PROCEDURE [dbo].[bvc_PriceGroup_i]

@bvin varchar(36),
@Name nvarchar(255),
@PricingType int,
@AdjustmentAmount numeric(18,10)

AS
	BEGIN TRY
		INSERT INTO	bvc_PriceGroup
		(
		bvin,
		Name,
		PricingType,
		AdjustmentAmount,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@Name,
		@PricingType,
		@AdjustmentAmount,
		GetDate()
		)
		 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_SearchQuery_ByDate_d]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_ByDate_d]

@DeleteDate as DateTime

AS

	BEGIN TRY
		DELETE FROM bvc_SearchQuery 
		WHERE LastUpdated <= @DeleteDate
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductChoiceOption_u ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Updates a Product Choice Option
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceOption_u ]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36), 
	@productChoiceId varchar(36),
	@productChoiceName nvarchar(255),
	@order int,
	@default bit,
	@null bit
AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductChoiceOptions SET ProductChoiceId = @productChoiceId, ProductChoiceName = @productChoiceName, [Order] = @order, [default] = @default, [null] = @null, LastUpdated = GetDate() WHERE bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



















GO
PRINT N'Creating [dbo].[bvc_Fraud_u]'
GO
CREATE PROCEDURE [dbo].[bvc_Fraud_u]

@bvin varchar(36),
@RuleType Int,
@RuleValue nvarchar(255)

AS
	BEGIN TRY
		UPDATE
			bvc_Fraud
		SET
		RuleType=@RuleType,
		RuleValue=@RuleValue,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH







GO
PRINT N'Creating [dbo].[bvc_MailingList_Public_s]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingList_Public_s]

AS
	BEGIN TRY
		SELECT bvin,[Name],Private,LastUpdated FROM bvc_MailingList WHERE Private=0 ORDER BY [Name]
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_s]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderCoupon_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		CouponCode,
		OrderBvin,
		LastUpdated 
		FROM bvc_OrderCoupon
		  WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_SearchQuery_ByQueryPhrase_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_ByQueryPhrase_s]

@QueryPhrase nvarchar(Max)

AS
	BEGIN TRY
		SELECT bvin,QueryPhrase,ShopperID,LastUpdated FROM bvc_SearchQuery
		WHERE QueryPhrase=@QueryPhrase
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











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
PRINT N'Creating [dbo].[bvc_PriceGroup_s]'
GO






CREATE PROCEDURE [dbo].[bvc_PriceGroup_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin, Name, PricingType, AdjustmentAmount, LastUpdated FROM bvc_PriceGroup 
		WHERE bvin = @bvin
		 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_MailingListMember_ByListID_s]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingListMember_ByListID_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT Bvin,ListID,EmailAddress,FirstName,LastName,LastUpdated FROM bvc_MailingListMember WHERE ListID=@bvin
		ORDER BY EmailAddress,LastName,FirstName

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_u]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderCoupon_u]

@bvin varchar(36),
@CouponCode nvarchar(50),
@OrderBvin varchar(36)

AS
	BEGIN TRY
		UPDATE
			bvc_OrderCoupon
		SET
		CouponCode=@CouponCode,
		OrderBvin=@OrderBvin,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Vendor_Filter_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Vendor_Filter_s]

	@filter nvarchar(Max),
	@StartRowIndex int = 0,
	@MaximumRows int = 9999999
AS
	BEGIN TRY;
		WITH Vendors AS
		(SELECT 
		ROW_NUMBER() OVER (ORDER BY DisplayName, EmailAddress) As RowNum,
		bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated FROM bvc_Vendor	  
		WHERE (DisplayName LIKE @filter) OR (EmailAddress LIKE @filter) OR
			(Address LIKE @filter))

		SELECT *, (SELECT COUNT(*) FROM Vendors) AS TotalRowCount FROM Vendors
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_PriceGroup_u]'
GO






CREATE PROCEDURE [dbo].[bvc_PriceGroup_u]

@bvin varchar(36),
@Name nvarchar(255),
@PricingType int,
@AdjustmentAmount numeric(18,10)

AS
	BEGIN TRY
		UPDATE bvc_PriceGroup SET Name = @Name, PricingType = @PricingType, AdjustmentAmount = @AdjustmentAmount, LastUpdated = GetDate()
		WHERE bvin = @bvin
		 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_ByCertificateCode_s]'
GO





CREATE PROCEDURE [dbo].[bvc_GiftCertificate_ByCertificateCode_s]
@CertificateCode varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		LineItemId,
		CertificateCode,
		DateIssued,
		OriginalAmount,
		CurrentAmount,
		AssociatedProductId,
		LastUpdated
		FROM bvc_GiftCertificate
		  WHERE  CertificateCode=@CertificateCode
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_SearchQuery_ByShopperID_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_ByShopperID_s]
	
	@bvin varchar(36)
AS

	BEGIN TRY
		SELECT bvin,QueryPhrase,ShopperID,LastUpdated FROM bvc_SearchQuery
		WHERE shopperID=@bvin ORDER BY LastUpdated DESC
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RMAItem_ByRMABvin_s]'
GO












CREATE PROCEDURE [dbo].[bvc_RMAItem_ByRMABvin_s]
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
		FROM bvc_RMAItem WHERE RMABvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



































GO
PRINT N'Creating [dbo].[bvc_TaxClass_i]'
GO

CREATE PROCEDURE [dbo].[bvc_TaxClass_i]

@Bvin varchar(36),
@DisplayName nvarchar(255)

AS
	BEGIN TRY
		Insert Into bvc_TaxClass
		(
		Bvin,
		DisplayName,
		LastUpdated
		)
		VALUES
		(
		@Bvin,
		@DisplayName,
		GetDate()
		)	
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_MailingList_u]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingList_u]

@bvin varchar(36),
@Name nvarchar(255),
@IsPrivate int

AS
	BEGIN TRY
		UPDATE bvc_MailingList 
		SET 
		[Name]=@Name,
		Private=@IsPrivate,
		LastUpdated=GetDate()
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_AuthenticationToken_d]'
GO


CREATE PROCEDURE [dbo].[bvc_AuthenticationToken_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_AuthenticationToken WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN











GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValue_ClearAll_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyValue_ClearAll_d]

@ProductBvin varchar(36)

AS

	BEGIN TRY		
		DELETE FROM bvc_ProductPropertyValue WHERE ProductBvin=@ProductBvin			
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH







GO
PRINT N'Creating [dbo].[bvc_Vendor_i]'
GO


CREATE PROCEDURE [dbo].[bvc_Vendor_i]
@bvin varchar(36),
@DisplayName nvarchar(255),
@EmailAddress nvarchar(255),
@Address ntext,
@DropShipEmailTemplateId varchar(36)

AS
	BEGIN TRY
		INSERT INTO
		bvc_Vendor
		(bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated)
		VALUES
		(@bvin,@DisplayName,@EmailAddress,@Address,@DropShipEmailTemplateId,GetDate())
		

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_ByLineItem_s]'
GO





CREATE PROCEDURE [dbo].[bvc_GiftCertificate_ByLineItem_s]
@LineItemId varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		LineItemId,
		CertificateCode,
		DateIssued,
		OriginalAmount,
		CurrentAmount,
		AssociatedProductId,
		LastUpdated
		FROM bvc_GiftCertificate
		  WHERE  LineItemId=@LineItemId
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_TaxClass_s]'
GO



CREATE PROCEDURE [dbo].[bvc_TaxClass_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT Bvin, DisplayName, LastUpdated
		FROM
		bvc_TaxClass
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_SearchQuery_d]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_d]

@bvin varchar(36)
AS
	BEGIN TRY
		DELETE FROM bvc_SearchQuery WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RMAItem_d]'
GO












CREATE PROCEDURE [dbo].[bvc_RMAItem_d]
@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM
		bvc_RMAItem
		WHERE
		bvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH























GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValue_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyValue_s]

@ProductBvin varchar(36),
@PropertyBvin varchar(36)

AS

BEGIN TRY
	SELECT ProductBvin,PropertyBvin,PropertyValue 
	FROM bvc_ProductPropertyValue 
	WHERE ProductBvin=@ProductBvin 
	AND PropertyBvin=@PropertyBvin
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH






GO
PRINT N'Creating [dbo].[bvc_PrintTemplate_d]'
GO
CREATE PROCEDURE [dbo].[bvc_PrintTemplate_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_PrintTemplate WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Vendor_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Vendor_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,DisplayName,EmailAddress,Address,DropShipEmailTemplateId,LastUpdated FROM bvc_Vendor
		  WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_d]'
GO




CREATE PROCEDURE [dbo].[bvc_GiftCertificate_d]
@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_GiftCertificate
		  WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_RMAItem_i]'
GO












CREATE PROCEDURE [dbo].[bvc_RMAItem_i]
@bvin varchar(36),
@RMABvin varchar(36),
@LineItemBvin varchar(36),
@ItemDescription nvarchar(max),
@ItemName nvarchar(512),
@Note nvarchar(max),
@Reason nvarchar(Max),
@Replace bit,
@Quantity int,
@QuantityReceived int,
@QuantityReturnedToInventory int

AS
	BEGIN TRY
		INSERT INTO
		bvc_RMAItem
		(
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
		)
		VALUES
		(
		@bvin,
		@RMABvin,
		@LineItemBvin,
		@ItemDescription,
		@ItemName,
		@Note,
		@Reason,
		@Replace,
		@Quantity,
		@QuantityReceived,
		@QuantityReturnedToInventory,
		GetDate()	
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





























GO
PRINT N'Creating [dbo].[bvc_TaxClass_u]'
GO

CREATE PROCEDURE [dbo].[bvc_TaxClass_u]

@Bvin varchar(36),
@DisplayName nvarchar(255)

AS
	BEGIN TRY
		Update bvc_TaxClass
		Set	Bvin=@Bvin,
		DisplayName=@DisplayName
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_SearchQuery_i]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_i]

@bvin varchar(36),
@QueryPhrase nvarchar(Max),
@ShopperID varchar(36)

AS

	BEGIN TRY			
		INSERT INTO
		bvc_SearchQuery
		(
		bvin,
		QueryPhrase,
		ShopperID,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@QueryPhrase,
		@ShopperID,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell_ByProductId_d]'
GO



-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/13/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductCrossSell_ByProductId_d] 
	
	@bvin varchar(36)

AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductCrossSell WHERE ProductBvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END







GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValue_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyValue_u]

@ProductBvin varchar(36),
@PropertyBvin varchar(36),
@PropertyValue nvarchar(max)

AS

	BEGIN TRY		
		DELETE FROM bvc_ProductPropertyValue WHERE ProductBvin=@ProductBvin AND PropertyBvin=@PropertyBvin
		
		INSERT INTO bvc_ProductPropertyValue 
		(ProductBvin,PropertyBvin,PropertyValue) 
		VALUES (@ProductBvin,@PropertyBvin,@PropertyValue)

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






GO
PRINT N'Creating [dbo].[bvc_MailingListMember_d]'
GO


CREATE PROCEDURE [dbo].[bvc_MailingListMember_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_MailingListMember WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN











GO
PRINT N'Creating [dbo].[bvc_PrintTemplate_i]'
GO

CREATE PROCEDURE [dbo].[bvc_PrintTemplate_i]

@bvin varchar(36),
@DisplayName nvarchar(Max),
@Body nvarchar(Max),
@RepeatingSection nvarchar(Max),
@SystemTemplate int
	
AS
	BEGIN TRY
		INSERT INTO bvc_PrintTemplate
		(
		bvin,
		DisplayName,
		Body,
		RepeatingSection,
		SystemTemplate,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@DisplayName,
		@Body,
		@RepeatingSection,
		@SystemTemplate,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ComponentSettings_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSettings_All_s]

AS
	
BEGIN TRY
	SELECT SettingValue,ComponentID,SettingName,DeveloperId,ComponentType,ComponentSubType FROM bvc_ComponentSetting

	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH














GO
PRINT N'Creating [dbo].[bvc_GiftCertificate_DecAmt_u]'
GO


CREATE PROCEDURE [dbo].[bvc_GiftCertificate_DecAmt_u]
@bvin varchar(36),
@amount numeric(18, 10),
@finalValue numeric(18, 10) OUTPUT,
@succeeded bit OUTPUT
AS
	-- we keep the @DateIssued And @OriginalAmount variables to ease the programming, but we don't let them change on updates
	BEGIN TRY
		DECLARE @CurrentAmount numeric(18, 10)
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		BEGIN TRANSACTION
			SET @CurrentAmount = (SELECT CurrentAmount FROM bvc_GiftCertificate WHERE bvin = @bvin);
			IF @CurrentAmount - @amount >= 0
			BEGIN
				UPDATE bvc_GiftCertificate SET CurrentAmount = (CurrentAmount - @amount), LastUpdated = GetDate() WHERE bvin = @bvin
				SET @finalValue = (SELECT CurrentAmount FROM bvc_GiftCertificate WHERE bvin = @bvin)
				SET @succeeded = 1
			END
			ELSE
			BEGIN
				SET @finalValue = @CurrentAmount
				SET @succeeded = 0
			END			
		COMMIT TRANSACTION		
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @finalValue = @CurrentAmount
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_SearchQuery_Report_s]'
GO
CREATE PROCEDURE [dbo].[bvc_SearchQuery_Report_s]

AS
	BEGIN TRY
		SELECT DISTINCT	
		QueryPhrase, Count(*) as QueryCount FROM bvc_SearchQuery
		Group By QueryPhrase
		ORDER BY QueryCount DESC		
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Vendor_u]'
GO


CREATE PROCEDURE [dbo].[bvc_Vendor_u]
@bvin varchar(36),
@DisplayName nvarchar(255),
@EmailAddress nvarchar(255),
@Address ntext,
@DropShipEmailTemplateId varchar(36)

AS
	BEGIN TRY
		UPDATE
			bvc_Vendor
		SET
		DisplayName=@DisplayName,
		EmailAddress=@EmailAddress,
		Address=@Address,
		DropShipEmailTemplateId=@DropShipEmailTemplateId,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_TaxClasses_s]'
GO




CREATE PROCEDURE [dbo].[bvc_TaxClasses_s]

AS
	BEGIN TRY
		SELECT Bvin, DisplayName, LastUpdated
		FROM
		bvc_TaxClass
		ORDER BY DisplayName
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_RMAItem_s]'
GO












CREATE PROCEDURE [dbo].[bvc_RMAItem_s]
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
		FROM bvc_RMAItem WHERE Bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




































GO
PRINT N'Creating [dbo].[bvc_OrderNote_d]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderNote_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_OrderNote WHERE bvin=@bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell_Count_Admin_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/17/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductCrossSell_Count_Admin_s] 
	
	@bvin varchar(36)
	
AS
BEGIN
	BEGIN TRY
		SELECT COUNT(*) As [Count] FROM bvc_ProductCrossSell WHERE ProductBvin = @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END











GO
PRINT N'Creating [dbo].[bvc_CustomPage_u]'
GO



CREATE PROCEDURE [dbo].[bvc_CustomPage_u]

@bvin varchar(36),
@Name nvarchar(255),
@MenuName nvarchar(100),
@Content ntext,
@ShowInTopMenu int = 0,
@ShowInBottomMenu int = 1,
@PreTransformContent ntext,
@MetaDescription nvarchar(255),
@MetaKeywords nvarchar(255),
@MetaTitle nvarchar(512),
@TemplateName nvarchar(512),
@PreContentColumnId nvarchar(36),
@PostContentColumnId nvarchar(36)


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
		LastUpdated=GetDate(),
		MetaTitle=@MetaTitle,
		TemplateName=@TemplateName,
		PreContentColumnId=@PreContentColumnId,
		PostContentColumnId=@PostContentColumnId
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_CartCleanup_d]'
GO






CREATE PROCEDURE [dbo].[bvc_CartCleanup_d]

@OlderThanDate datetime

AS
BEGIN TRY

	BEGIN TRANSACTION
		DECLARE @CartIds Table (
			CartId varchar(36) COLLATE SQL_Latin1_General_CP1_CI_AS
		)

		--declare cursor for use below
		DECLARE @currbvin varchar(36)
		DECLARE bvin_cartcursor CURSOR LOCAL
			FOR SELECT * FROM @CartIds

		--delete out all of our product choices
		INSERT INTO @CartIds SELECT DISTINCT bvin FROM bvc_Order WHERE TimeOfOrder < @OlderThanDate AND IsPlaced = 0
		OPEN bvin_cartcursor
		FETCH NEXT FROM bvin_cartcursor	INTO @currbvin

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC bvc_Order_d @currbvin
			FETCH NEXT FROM bvin_cartcursor	INTO @currbvin
		END
		CLOSE bvin_cartcursor		
		DEALLOCATE bvin_cartcursor
	COMMIT
END TRY
BEGIN CATCH
	IF CURSOR_STATUS('local', 'bvin_cartcursor') > -1
		CLOSE bvin_cartcursor	

	IF CURSOR_STATUS('local', 'bvin_cartcursor') = -1
		DEALLOCATE bvin_cartcursor

	IF XACT_STATE() <> 0
		ROLLBACK TRANSACTION
	EXEC bvc_EventLog_SQL_i
	RETURN 0
END CATCH

RETURN 
	


















GO
PRINT N'Creating [dbo].[bvc_Category_ForMenu_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_ForMenu_s]

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
		CustomerChangeableSortOrder,
		ShortDescription,
		CustomProperties
		FROM bvc_Category
		WHERE ParentID = '0' AND Hidden = 0 AND ShowInTopMenu = 1
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

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
PRINT N'Creating [dbo].[bvc_ProductInventory_i]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_i] 
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
PRINT N'Creating [dbo].[bvc_WorkFlowStep_u]'
GO


CREATE PROCEDURE [dbo].[bvc_WorkFlowStep_u]

@bvin varchar(36),
@WorkFlowBvin varchar(36),
@SortOrder int,
@ControlName nvarchar(512),
@DisplayName nvarchar(512),
@StepName nvarchar(512)

AS
	BEGIN TRY
		UPDATE bvc_WorkFlowStep
		SET
		
		bvin=@bvin,
		@WorkFlowBvin=@WorkFlowBvin,
		SortOrder=@SortOrder,
		ControlName=@ControlName,
		DisplayName=@DisplayName,
		StepName=@StepName,
		LastUpdated=GetDate()
		
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductXCategory_d]
@CategoryID varchar(36),
@ProductID varchar(36)
AS
	BEGIN TRY
		DELETE FROM bvc_ProductXCategory
		WHERE CategoryID=@CategoryID
		AND ProductID=@ProductID

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductChoice_s ]'
GO






-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a product choice by bvin
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_s ]
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
PRINT N'Creating [dbo].[bvc_ProductInventory_Reserve_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Reserve_u] 

	@ProductBvin varchar(36),
	@Quantity decimal(18,10)

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved + @Quantity,
		QuantityAvailable= QuantityAvailable - @Quantity,
		LastUpdated=GetDate()
		WHERE ProductBvin=@ProductBvin

		exec bvc_ProductInventory_UpdateParent_u @ProductBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_Category_i]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_i]

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
@CustomerChangeableSortOrder bit,
@ShortDescription nvarchar(512),
@CustomProperties nvarchar(Max)

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
		CustomerChangeableSortOrder,
		ShortDescription,
		CustomProperties
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
		@CustomerChangeableSortOrder,
		@ShortDescription,
		@CustomProperties
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_UserAccount_All_s]'
GO









CREATE PROCEDURE [dbo].[bvc_UserAccount_All_s]

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
PRINT N'Creating [dbo].[bvc_CustomUrl_AllPublic_S]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_AllPublic_S]

AS
	BEGIN TRY
		SELECT bvin,RequestedUrl,RedirectToUrl,SystemUrl,SystemData,LastUpdated
		FROM bvc_CustomUrl
		WHERE SystemUrl=0
		ORDER By RequestedUrl
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_d_all]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductXCategory_d_all]
@ProductID varchar(36)
AS
	BEGIN TRY
		DELETE FROM bvc_ProductXCategory
		WHERE ProductID=@ProductID
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_ByCountry_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ShippingMethod_ByCountry_s]
@CountryBvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		Adjustment,
		AdjustmentType,
		[Name],
		ShippingProviderId,
		LastUpdated
		FROM bvc_ShippingMethod
		  WHERE  
			bvin NOT IN (SELECT ShippingMethodBvin FROM bvc_ShippingMethod_CountryRestriction WHERE CountryBvin=@CountryBvin)
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_d]'
GO

Create PROCEDURE [dbo].[bvc_ContactUsQuestion_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_ContactUsQuestions WHERE bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_ProductChoice_SharedByProduct_s ]'
GO










-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/25/2006
-- Description:	Finds shared product choices on a per product basis
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_SharedByProduct_s ]
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
PRINT N'Creating [dbo].[bvc_LineItemModifier_i]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItemModifier_i]
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
PRINT N'Creating [dbo].[bvc_Category_Neighbors_s]'
GO
CREATE  PROCEDURE [dbo].[bvc_Category_Neighbors_s]
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
			FROM bvc_Category WHERE ParentID=@bvin ORDER BY SortOrder
			END

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_Product_All_s]'
GO







CREATE PROCEDURE [dbo].[bvc_Product_All_s]
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
PRINT N'Creating [dbo].[bvc_CustomUrl_BySystemData_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_BySystemData_s]
	
@bvin varchar(36)

AS
	BEGIN TRY	
		SELECT bvin,RequestedUrl,RedirectToUrl,SystemUrl,SystemData,LastUpdated
		FROM bvc_CustomUrl
		WHERE SystemData=@bvin
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_i]'
GO








CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_i]

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
PRINT N'Creating [dbo].[bvc_ProductXCategory_i]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductXCategory_i]
@CategoryID varchar(36),
@ProductID varchar(36),
@SortOrder int = 1,
@CurrentCount int = 0
AS
	BEGIN TRY
		SET @CurrentCount = (SELECT Count(CategoryID) as c FROM bvc_ProductXCategory WHERE CategoryID=@CategoryID) 
		IF @CurrentCount > 0
			BEGIN
				SET @SortOrder =  (Select Max(SortOrder) as MaxSort FROM bvc_ProductXCategory WHERE CategoryID=@CategoryID)
				SET @SortOrder = @SortOrder + 1
			END
		ELSE
			SET @SortOrder =  1
			
		INSERT INTO
		bvc_ProductXCategory
		(ProductID,CategoryID, SortOrder)
		VALUES(@ProductID,@CategoryID,@SortOrder)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










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
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_s]'
GO









CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_ContactUsQuestions WHERE bvin = @bvin ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductChoice_u ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/14/2006
-- Description:	Updates a Product Choice
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_u ]
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
PRINT N'Creating [dbo].[bvc_UserAccount_ByCriteria_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_ByCriteria_s]
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
PRINT N'Creating [dbo].[bvc_OrderPackage_ByOrderId_s]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderPackage_ByOrderId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin, 
		Description, 
		Width, 
		Height, 
		Length, 
		SizeUnits, 
		Weight, 
		WeightUnits, 
		OrderId, 
		ShippingProviderId, 
		ShippingProviderServiceCode, 
		HasShipped, 
		TrackingNumber, 
		ShipDate, 
		TimeInTransit, 
		EstimatedShippingCost, 
		Items, 
		CustomProperties,
		LastUpdated

		FROM bvc_OrderPackage
		  WHERE  OrderId=@bvin ORDER BY LastUpdated Desc
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_Role_i]'
GO


CREATE PROCEDURE [dbo].[bvc_Role_i]

@bvin varchar(36),
@RoleName nvarchar(255)

AS

	BEGIN TRY
		INSERT INTO bvc_Role 
		(
		bvin,
		RoleName,
		LastUpdated
		) 
		VALUES 
		(
		@bvin,
		@RoleName,
		GetDate()
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_LineItemModifier_u]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItemModifier_u]
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
PRINT N'Creating [dbo].[bvc_ProductReview_s]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductReview_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
			r.bvin,
			r.LastUpdated,
			r.Approved, 
			r.Description,
			r.ProductBvin,
			r.Karma, 
			r.Rating, 
			r.ReviewDate, 
			r.UserID,
			r.UserName,
			r.UserEmail,
			p.ProductName

		FROM bvc_ProductReview r
		JOIN 
		bvc_Product p on r.ProductBvin = p.bvin
		WHERE  r.bvin=@bvin



		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH







GO
PRINT N'Creating [dbo].[bvc_CustomUrl_d]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductReview_Latest_s]
	@MinimumRating integer,
	@IgnoreBadKarma integer,
	@IgnoreAnonymousReviews int,
	@CategoryId nvarchar(36),
	@Moderate integer,
	@MaxRows int = 1000
AS

	BEGIN TRY
		SELECT TOP (@MaxRows) 
			pr.bvin, 
			pr.lastUpdated, 
			pr.Approved,
			pr.[Description],
			pr.Karma,
			pr.ReviewDate,
			pr.Rating,
			pr.UserID,
			pr.ProductBvin,
			pr.UserName,
			pr.UserEmail,
			p.ProductName
		FROM bvc_ProductReview AS pr
		JOIN bvc_Product AS p ON p.bvin = pr.ProductBvin
		WHERE
			(@Moderate = 0 OR Approved = 1)
			AND Rating >= @MinimumRating
			AND (@IgnoreBadKarma = 0 OR Karma >= 0)
			AND (@IgnoreAnonymousReviews = 0 OR UserID <> '0')
			AND (@CategoryId = '' OR ProductBvin IN (
					SELECT ProductId
					FROM bvc_ProductXCategory
					WHERE CategoryId = @CategoryId))
		ORDER BY ReviewDate DESC

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_CustomUrl_d]'
GO
CREATE PROCEDURE [dbo].[bvc_CustomUrl_d]
	
@bvin varchar(36)

AS
	BEGIN TRY
		DELETE bvc_CustomUrl WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_u]

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
PRINT N'Creating [dbo].[bvc_Category_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_s]
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
		CustomerChangeableSortOrder,
		ShortDescription,
		CustomProperties
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
PRINT N'Creating [dbo].[bvc_Role_NotInUser_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Role_NotInUser_s]

	@bvin varchar(36)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		
	BEGIN TRY
		SELECT bvin,RoleName,SystemRole,LastUpdated FROM 
		bvc_Role 
		WHERE bvin NOT IN (SELECT RoleID FROM bvc_UserXRole WHERE UserID=@bvin)
		ORDER By RoleName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END












GO
PRINT N'Creating [dbo].[bvc_WishList_d]'
GO

CREATE PROCEDURE [dbo].[bvc_WishList_d]	
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
PRINT N'Creating [dbo].[bvc_UserAccount_s]'
GO







CREATE PROCEDURE [dbo].[bvc_UserAccount_s]

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
PRINT N'Creating [dbo].[bvc_ProductInventory_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_s] 
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
PRINT N'Creating [dbo].[bvc_Manufacturer_d]'
GO


CREATE PROCEDURE [dbo].[bvc_Manufacturer_d]

@bvin varchar(36)

AS
	BEGIN TRY
		UPDATE bvc_Product SET ManufacturerID='' WHERE ManufacturerID=@bvin

		DELETE FROM bvc_UserXContact WHERE ContactId = @bvin

		DELETE bvc_Manufacturer WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_SortOrder_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductXCategory_SortOrder_u]

@CategoryId varchar(36),
@ProductId varchar(36),
@SortOrder int

AS

	BEGIN TRY
		UPDATE bvc_ProductXCategory
		SET
		SortOrder=@SortOrder
		WHERE CategoryID=@CategoryId AND ProductId=@ProductId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	












GO
PRINT N'Creating [dbo].[bvc_OrderPackage_d]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderPackage_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_OrderPackage WHERE bvin=@bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductChoiceAndOptionPairs_ByProductCombinationBvin_s ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 5/2/2006
-- Description:	Finds the list of choice and choice option ids for a combination
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoiceAndOptionPairs_ByProductCombinationBvin_s ]
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
PRINT N'Creating [dbo].[bvc_CustomUrl_i]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_i]

@bvin varchar(36),
@RequestedUrl nvarchar(Max),
@RedirectToUrl nvarchar(Max),
@SystemUrl int,
@SystemData varchar(36)

AS
	BEGIN TRY
		INSERT INTO bvc_CustomUrl
		(
		bvin,
		RequestedUrl,
		RedirectToUrl,
		SystemUrl,
		SystemData,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@RequestedUrl,
		@RedirectToUrl,
		@SystemUrl,
		@SystemData,
		GetDate()
		)
		
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
PRINT N'Creating [dbo].[bvc_LineItemStatusCode_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_LineItemStatusCode_All_s]

AS
	BEGIN TRY
		SELECT bvin,SortOrder,StatusName,SystemCode,LastUpdated
		FROM bvc_LineItemStatusCode
		ORDER BY SortOrder
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_UserAccount_ByManufacturerID_s]'
GO






CREATE PROCEDURE [dbo].[bvc_UserAccount_ByManufacturerID_s]

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
PRINT N'Creating [dbo].[bvc_ContentBlock_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ContentBlock_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE bvc_ComponentSettingList WHERE componentID=@bvin

		DELETE bvc_ComponentSetting WHERE componentID=@bvin

		DELETE bvc_ContentBlock WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Category_u]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_u]

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
@CustomerChangeableSortOrder bit,
@ShortDescription nvarchar(512),
@CustomProperties nvarchar(Max)

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
		CustomerChangeableSortOrder=@CustomerChangeableSortOrder,
		ShortDescription=@ShortDescription,
		CustomProperties=@CustomProperties
		 WHERE
		 bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_ProductInventory_SetAvailableQuantity_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_SetAvailableQuantity_u] 

	@ProductBvin varchar(36),
	@Quantity decimal(18,10)

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityAvailable=@Quantity,
		LastUpdated=GetDate()
		WHERE ProductBvin=@ProductBvin

		exec bvc_ProductInventory_UpdateParent_u @ProductBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
END














GO
PRINT N'Creating [dbo].[bvc_Role_u]'
GO
CREATE PROCEDURE [dbo].[bvc_Role_u]

@bvin varchar(36),
@RoleName nvarchar(255)

AS
	BEGIN TRY
		UPDATE bvc_Role
		SET
		RoleName=@RoleName,
		LastUpdated=GetDate()
		WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_LineItemStatusCode_d]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItemStatusCode_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_LineItemStatusCode WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Product_ByChoiceId_s]'
GO






CREATE PROCEDURE [dbo].[bvc_Product_ByChoiceId_s]

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
PRINT N'Creating [dbo].[bvc_OrderPackage_i]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderPackage_i]

@bvin varchar(36),
@Description nvarchar(Max), 
@Width decimal(18,4), 
@Height decimal(18,4), 
@Length decimal(18,4), 
@SizeUnits int, 
@Weight decimal(18,4), 
@WeightUnits int, 
@OrderId varchar(36), 
@ShippingProviderId varchar(36), 
@ShippingProviderServiceCode nvarchar(255), 
@HasShipped int, 
@TrackingNumber nvarchar(255), 
@ShipDate DateTime, 
@TimeInTransit int, 
@EstimatedShippingCost decimal(18,10), 
@Items nvarchar(Max),
@CustomProperties ntext = ''

AS
	BEGIN TRY
		INSERT INTO
		bvc_OrderPackage
		(
		bvin, 
		Description, 
		Width, 
		Height, 
		Length, 
		SizeUnits, 
		Weight, 
		WeightUnits, 
		OrderId, 
		ShippingProviderId, 
		ShippingProviderServiceCode, 
		HasShipped, 
		TrackingNumber, 
		ShipDate, 
		TimeInTransit, 
		EstimatedShippingCost, 
		Items, 
		CustomProperties,
		LastUpdated
		)
		VALUES
		(
		@bvin, 
		@Description, 
		@Width, 
		@Height, 
		@Length, 
		@SizeUnits, 
		@Weight, 
		@WeightUnits, 
		@OrderId, 
		@ShippingProviderId, 
		@ShippingProviderServiceCode, 
		@HasShipped, 
		@TrackingNumber, 
		@ShipDate, 
		@TimeInTransit, 
		@EstimatedShippingCost, 
		@Items, 
		@CustomProperties,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_Category_VisibleNeighbors_s]'
GO
CREATE  PROCEDURE [dbo].[bvc_Category_VisibleNeighbors_s]
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
			FROM bvc_Category WHERE ParentID=@bvin ORDER BY SortOrder
			END

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

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
PRINT N'Creating [dbo].[bvc_CustomUrl_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_s]
	
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,RequestedUrl,RedirectToUrl,SystemUrl,SystemData,LastUpdated
		FROM bvc_CustomUrl
		WHERE bvin=@bvin
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_WishList_i]'
GO
CREATE PROCEDURE [dbo].[bvc_WishList_i]	

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
PRINT N'Creating [dbo].[bvc_UserAccount_ByName_s]'
GO





CREATE PROCEDURE [dbo].[bvc_UserAccount_ByName_s]

@UserName nvarchar(255)

AS

	BEGIN TRY
		Declare @bvin varchar(36)
		SET @bvin = (SELECT bvin FROM bvc_User WHERE UserName=@UserName)
		
		exec bvc_UserAccount_s @bvin


		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Ship_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Ship_u] 

	@ProductBvin varchar(36),
	@Quantity decimal(18,10)

AS
BEGIN

	BEGIN TRY	
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved - @Quantity,
		LastUpdated=GetDate()
		WHERE ProductBvin=@ProductBvin

		exec bvc_ProductInventory_UpdateParent_u @ProductBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_ProductReviewNotApproved_s]'
GO






CREATE PROCEDURE [dbo].[bvc_ProductReviewNotApproved_s]

AS
	BEGIN TRY
		SELECT 
		bvc_ProductReview.bvin,
		bvc_ProductReview.LastUpdated,
		bvc_ProductReview.Approved, 
		bvc_ProductReview.Description,
		bvc_ProductReview.ProductBvin,
		bvc_ProductReview.Karma, 
		bvc_ProductReview.Rating, 
		bvc_ProductReview.ReviewDate, 
		bvc_ProductReview.UserID,
		bvc_ProductReview.UserName,
		bvc_ProductReview.UserEmail,
		bvc_Product.ProductName

		FROM bvc_ProductReview JOIN bvc_Product ON bvc_ProductReview.ProductBvin = bvc_Product.bvin
		WHERE  Approved = 0
		Order BY ReviewDate ASC

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_OrderPackage_s]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderPackage_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin, 
		Description, 
		Width, 
		Height, 
		Length, 
		SizeUnits, 
		Weight, 
		WeightUnits, 
		OrderId, 
		ShippingProviderId, 
		ShippingProviderServiceCode, 
		HasShipped, 
		TrackingNumber, 
		ShipDate, 
		TimeInTransit, 
		EstimatedShippingCost, 
		Items, 
		CustomProperties,
		LastUpdated
		FROM bvc_OrderPackage
		  WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_LineItemStatusCode_i]'
GO



CREATE PROCEDURE [dbo].[bvc_LineItemStatusCode_i]

@bvin varchar(36),
@SortOrder int,
@StatusName nvarchar(Max),
@SystemCode int

AS

	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_LineItemStatusCode) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_LineItemStatusCode)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END

		INSERT INTO
		bvc_LineItemStatusCode
		(
		bvin,
		SortOrder,
		StatusName,
		SystemCode,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@SortOrder,
		@StatusName,
		@SystemCode,
		GetDate()
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













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
PRINT N'Creating [dbo].[bvc_CustomUrl_u]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrl_u]

@bvin varchar(36),
@RequestedUrl nvarchar(Max),
@RedirectToUrl nvarchar(Max),
@SystemUrl int,
@SystemData varchar(36)

AS
	BEGIN TRY
		UPDATE bvc_CustomUrl
		SET
		bvin=@bvin,
		RequestedUrl=@RequestedUrl,
		RedirectToUrl=@RedirectToUrl,
		SystemUrl=@SystemUrl,
		SystemData=@SystemData,
		LastUpdated=GetDate()
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ComponentSetting_ByComponentID_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSetting_ByComponentID_d]

@bvin varchar(36)
	AS
		BEGIN TRY
			DELETE FROM bvc_ComponentSetting WHERE ComponentID=@bvin
			DELETE FROM bvc_ComponentSettingList WHERE ComponentId=@bvin
		END TRY
		BEGIN CATCH
			EXEC bvc_EventLog_SQL_i
		END CATCH

	RETURN













GO
PRINT N'Creating [dbo].[bvc_Affiliate_all_s]'
GO






CREATE PROCEDURE [dbo].[bvc_Affiliate_all_s]

AS
	BEGIN TRY
		SELECT 
		ReferralID, DisplayName,Address,CommissionAmount,CommissionType,
		ReferralDays,TaxID,DriversLicenseNumber,WebSiteURL,StyleSheet,
		bvin, Enabled, Notes, LastUpdated
		FROM bvc_Affiliate ORDER BY DisplayName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN















GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_FindCountries_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ShippingMethod_FindCountries_s]

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
PRINT N'Creating [dbo].[bvc_UserAccount_ByRoleID_s]'
GO





CREATE PROCEDURE [dbo].[bvc_UserAccount_ByRoleID_s]

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
PRINT N'Creating [dbo].[bvc_ProductInventory_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_u] 
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
PRINT N'Creating [dbo].[bvc_WorkFlow_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_WorkFlow_All_s] 

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT bvin,ContextType,[Name],SystemWorkFlow,LastUpdated
		FROM bvc_WorkFlow
		ORDER By [Name]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END















GO
PRINT N'Creating [dbo].[bvc_Product_ByCrossSellId_Admin_s]'
GO














CREATE PROCEDURE [dbo].[bvc_Product_ByCrossSellId_Admin_s]

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
PRINT N'Creating [dbo].[bvc_OrderPackage_u]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderPackage_u]

@bvin varchar(36),
@Description nvarchar(Max), 
@Width decimal(18,4), 
@Height decimal(18,4), 
@Length decimal(18,4), 
@SizeUnits int, 
@Weight decimal(18,4), 
@WeightUnits int, 
@OrderId varchar(36), 
@ShippingProviderId varchar(36), 
@ShippingProviderServiceCode nvarchar(255), 
@HasShipped int, 
@TrackingNumber nvarchar(255), 
@ShipDate DateTime, 
@TimeInTransit int, 
@EstimatedShippingCost decimal(18,10), 
@Items nvarchar(Max),
@CustomProperties ntext = ''

AS
	BEGIN TRY
		UPDATE
			bvc_OrderPackage
		SET
		bvin=@bvin, 
		Description=@Description, 
		Width=@Width, 
		Height=@Height, 
		Length=@Length, 
		SizeUnits=@SizeUnits, 
		Weight=@Weight, 
		WeightUnits=@WeightUnits, 
		OrderId=@OrderId, 
		ShippingProviderId=@ShippingProviderId, 
		ShippingProviderServiceCode=@ShippingProviderServiceCode, 
		HasShipped=@HasShipped, 
		TrackingNumber=@TrackingNumber, 
		ShipDate=@ShipDate, 
		TimeInTransit=@TimeInTransit, 
		EstimatedShippingCost=@EstimatedShippingCost, 
		Items=@Items, 
		CustomProperties=@CustomProperties,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














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
PRINT N'Creating [dbo].[bvc_CustomUrlByRedirectToUrl_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrlByRedirectToUrl_s]

@RedirectToUrl nvarchar(Max)

AS
	BEGIN TRY
		SELECT bvin,RequestedUrl,RedirectToUrl,SystemUrl,SystemData,LastUpdated 
		FROM bvc_CustomUrl
		WHERE RedirectToUrl=@RedirectToUrl
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_WorkFlowStep_ByWorkFlowId_s]'
GO


CREATE PROCEDURE [dbo].[bvc_WorkFlowStep_ByWorkFlowId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,WorkFlowBvin,SortOrder,ControlName,DisplayName,StepName,LastUpdated FROM bvc_WorkFlowStep
		WHERE WorkFlowBvin=@bvin
		ORDER BY SortOrder
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Affiliate_ByReferralID_s]'
GO







CREATE PROCEDURE [dbo].[bvc_Affiliate_ByReferralID_s]

@id varchar(36)

AS
	BEGIN TRY
		SELECT 
			ReferralID, DisplayName,Address,CommissionAmount,
			CommissionType,ReferralDays, TaxID, DriversLicenseNumber,
			WebSiteURL,StyleSheet,bvin, Enabled, Notes, LastUpdated
		FROM bvc_Affiliate 
		WHERE  ReferralID=@id
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN















GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_FindNotCountries_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ShippingMethod_FindNotCountries_s]

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
PRINT N'Creating [dbo].[bvc_RMA_All_s]'
GO












CREATE PROCEDURE [dbo].[bvc_RMA_All_s]
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
PRINT N'Creating [dbo].[bvc_UserAccount_ByVendorID_s]'
GO






CREATE PROCEDURE [dbo].[bvc_UserAccount_ByVendorID_s]

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
PRINT N'Creating [dbo].[bvc_ProductInventory_Unreserve_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Unreserve_u] 

	@ProductBvin varchar(36),
	@Quantity decimal(18,10)

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved - @Quantity,
		QuantityAvailable= QuantityAvailable + @Quantity,
		LastUpdated=GetDate()
		WHERE ProductBvin=@ProductBvin

		DECLARE @CurrQuantity decimal(18,10)
		SET @CurrQuantity = (SELECT QuantityReserved FROM bvc_ProductInventory WHERE ProductBvin = @ProductBvin)

		IF @CurrQuantity < 0
		BEGIN			
			UPDATE bvc_ProductInventory
			SET	
			QuantityReserved = 0,
			QuantityAvailable= QuantityAvailable - ABS(@CurrQuantity),
			LastUpdated=GetDate()
			WHERE ProductBvin=@ProductBvin
		END

		EXEC bvc_ProductInventory_UpdateParent_u @ProductBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
END















GO
PRINT N'Creating [dbo].[bvc_CustomUrlByRequestedUrl_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CustomUrlByRequestedUrl_s]

@RequestedUrl nvarchar(Max)

AS
	BEGIN TRY
		SELECT bvin,RequestedUrl,RedirectToUrl,SystemUrl,SystemData,LastUpdated 
		FROM bvc_CustomUrl
		WHERE RequestedUrl=@RequestedUrl
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_RolePermission_d]'
GO

CREATE PROCEDURE [dbo].[bvc_RolePermission_d]

	@bvin varchar(36)

AS
BEGIN

	BEGIN TRY	
		DELETE bvc_RoleXRolePermission WHERE PermissionID=@bvin
		DELETE bvc_RolePermission WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_WorkFlow_d]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_WorkFlow_d] 
	@bvin varchar(36)
AS
BEGIN

	BEGIN TRY
		DELETE bvc_ComponentSettingList WHERE componentID IN (
		SELECT bvin FROM bvc_WorkFlowStep WHERE WorkFlowBvin=@bvin)

		DELETE bvc_ComponentSetting WHERE componentID IN (
		SELECT bvin FROM bvc_WorkFlowStep WHERE WorkFlowBvin=@bvin)

		DELETE bvc_WorkFlowStep WHERE WorkFlowBvin=@bvin	

		DELETE FROM bvc_WorkFlow WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END












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
PRINT N'Creating [dbo].[bvc_ShippingMethod_FindNotRegions_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ShippingMethod_FindNotRegions_s]

@bvin varchar(36)

AS
	BEGIN TRY

		SELECT bvin,[Name],Abbreviation,CountryID,LastUpdated
		FROM bvc_Region
		WHERE 

		(bvin IN 
		(SELECT RegionBvin FROM bvc_ShippingMethod_RegionRestriction WHERE ShippingMethodBvin=@bvin) 
		AND CountryID NOT IN
		(SELECT CountryBvin FROM bvc_ShippingMethod_CountryRestriction WHERE ShippingMethodBvin=@bvin)
		AND CountryID IN (SELECT bvin FROM bvc_Country WHERE bvin=CountryID and Active=1)
		) 
		
		ORDER BY [Name]
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_RMA_d]'
GO






CREATE PROCEDURE [dbo].[bvc_RMA_d]

@bvin varchar(36)

AS
BEGIN TRY

	BEGIN TRANSACTION

		DELETE FROM bvc_RMAItem WHERE RMABvin=@bvin 		
		DELETE FROM bvc_RMA WHERE bvin=@bvin

		
		
	COMMIT
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0
		ROLLBACK TRANSACTION
	EXEC bvc_EventLog_SQL_i
	RETURN 0
END CATCH

RETURN 
	



















GO
PRINT N'Creating [dbo].[bvc_Affiliate_ByUserID_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Affiliate_ByUserID_s]

@UserId varchar(36)

AS
	BEGIN TRY
		SELECT 
			ReferralID, DisplayName,Address,CommissionAmount,
			CommissionType,ReferralDays, TaxID, DriversLicenseNumber,
			WebSiteURL,StyleSheet,bvin, Enabled, Notes, LastUpdated
		FROM bvc_Affiliate JOIN bvc_UserXContact ON bvc_Affiliate.bvin = bvc_UserXContact.ContactId
		WHERE bvc_UserXContact.UserId = @UserId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN

















GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Unship_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Unship_u] 

	@ProductBvin varchar(36),
	@Quantity decimal(18,10)

AS
BEGIN

	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityReserved = QuantityReserved + @Quantity,
		LastUpdated=GetDate()
		WHERE ProductBvin=@ProductBvin

		exec bvc_ProductInventory_UpdateParent_u @ProductBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_RolePermission_i]'
GO

CREATE PROCEDURE [dbo].[bvc_RolePermission_i]

	@bvin varchar(36),
	@Name nvarchar(Max),
	@SystemPermission int
AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_RolePermission
		(
		bvin,
		[Name],
		SystemPermission,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@Name,
		@SystemPermission,
		GetDate()
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_ProductType_Count_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_Count_s]

@ProductTypeBvin varchar(36)

AS

	BEGIN TRY
		SELECT COUNT(bvin) AS ProductTypeCount FROM bvc_Product WHERE ProductTypeID=@ProductTypeBvin AND ParentID=-1
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





GO
PRINT N'Creating [dbo].[bvc_OrderPayment_ByThirdPartyTransactionId_s]'
GO






CREATE PROCEDURE [dbo].[bvc_OrderPayment_ByThirdPartyTransactionId_s]
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
PRINT N'Creating [dbo].[bvc_WorkFlow_s]'
GO




CREATE PROCEDURE [dbo].[bvc_WorkFlow_s] 

	@bvin varchar(36)

AS
BEGIN
	SET NOCOUNT ON;

    BEGIN TRY
		SELECT bvin,ContextType,[Name],SystemWorkFlow,LastUpdated 
		FROM bvc_WorkFlow
		WHERE bvin=@bvin

		EXEC bvc_WorkFlowStep_ByWorkFlowID_s @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


END















GO
PRINT N'Creating [dbo].[bvc_Product_ByFile_s]'
GO












CREATE PROCEDURE [dbo].[bvc_Product_ByFile_s]

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
PRINT N'Creating [dbo].[bvc_Offer_d]'
GO









CREATE PROCEDURE [dbo].[bvc_Offer_d]
	@bvin varchar(36)	
AS

	BEGIN TRANSACTION
	BEGIN TRY
		DELETE bvc_ComponentSettingList WHERE componentID=@bvin			
		DELETE bvc_ComponentSetting WHERE componentID=@bvin
		DELETE FROM bvc_Offers WHERE bvin = @bvin
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION			
		EXEC bvc_EventLog_SQL_i
	END CATCH

	

RETURN

























GO
PRINT N'Creating [dbo].[bvc_ProductChoices_ForProduct_s]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Finds a Product Choice for a particular product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoices_ForProduct_s]
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
PRINT N'Creating [dbo].[bvc_ShippingMethod_FindRegions_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ShippingMethod_FindRegions_s]

@bvin varchar(36)

AS
	BEGIN TRY

		SELECT bvin,[Name],Abbreviation,CountryID,LastUpdated
		FROM bvc_Region
		WHERE 
		(bvin NOT IN 
		(SELECT RegionBvin FROM bvc_ShippingMethod_RegionRestriction WHERE ShippingMethodBvin=@bvin) 
		AND CountryID NOT IN
		(SELECT CountryBvin FROM bvc_ShippingMethod_CountryRestriction WHERE ShippingMethodBvin=@bvin)
		AND CountryID IN (SELECT bvin FROM bvc_Country WHERE bvin=CountryID and Active=1)
		) 
		
		ORDER BY [Name]
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_RolePermission_NotInRoleID_s]'
GO



CREATE PROCEDURE [dbo].[bvc_RolePermission_NotInRoleID_s]
	
	@bvin varchar(36)

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT bvin,[Name],SystemPermission,LastUpdated
		FROM bvc_RolePermission
		WHERE bvin NOT IN (SELECT PermissionID FROM bvc_RoleXRolePermission WHERE RoleID=@bvin)
		ORDER BY [Name]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














GO
PRINT N'Creating [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_ExcludeAffiliateId_s]

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
PRINT N'Creating [dbo].[bvc_OrderPayment_d]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderPayment_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_OrderPayment WHERE bvin=@bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductCount_ByCategory_s]'
GO











CREATE PROCEDURE [dbo].[bvc_ProductCount_ByCategory_s]

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
PRINT N'Creating [dbo].[bvc_ProductType_d]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductType_d]

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
PRINT N'Creating [dbo].[bvc_Affiliate_Filter_s]'
GO







CREATE PROCEDURE [dbo].[bvc_Affiliate_Filter_s]

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
PRINT N'Creating [dbo].[bvc_ContentColumn_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ContentColumn_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE bvc_ComponentSettingList WHERE componentID IN (
		SELECT bvin FROM bvc_ContentBlock WHERE ColumnID=@bvin)

		DELETE bvc_ComponentSetting WHERE componentID IN (
		SELECT bvin FROM bvc_ContentBlock WHERE ColumnID=@bvin)

		DELETE bvc_ContentBlock WHERE ColumnID=@bvin
		
		DELETE bvc_ContentColumn WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell_Count_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/17/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductCrossSell_Count_s] 
	
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
PRINT N'Creating [dbo].[bvc_UserAccount_ExcludeManufacturerId_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_ExcludeManufacturerId_s]

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
PRINT N'Creating [dbo].[bvc_OrderPayment_i]'
GO






CREATE PROCEDURE [dbo].[bvc_OrderPayment_i]
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
PRINT N'Creating [dbo].[bvc_RolePermission_s]'
GO

CREATE PROCEDURE [dbo].[bvc_RolePermission_s]
	@bvin varchar(36)
AS
BEGIN	
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT bvin,[Name],SystemPermission,LastUpdated FROM bvc_RolePermission WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestion_All_s]'
GO








CREATE PROCEDURE [dbo].[bvc_ContactUsQuestion_All_s]

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_ContactUsQuestions ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_Role_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Role_All_s] AS

	BEGIN TRY
		SELECT bvin,RoleName,SystemRole,LastUpdated FROM bvc_Role ORDER BY RoleName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Role_ByUserID_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Role_ByUserID_s]

	@bvin varchar(36)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		SELECT bvin,RoleName,SystemRole,LastUpdated FROM 
		bvc_Role 
		WHERE bvin IN (SELECT RoleID FROM bvc_UserXRole WHERE UserID=@bvin)
		ORDER By RoleName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END












GO
PRINT N'Creating [dbo].[bvc_Affiliate_i]'
GO






CREATE PROCEDURE [dbo].[bvc_Affiliate_i]

@bvin varchar(36),
@ReferralID nvarchar(Max),
@DisplayName nvarchar(255),
@Address ntext,
@CommissionAmount numeric(18,10),
@CommissionType int,
@ReferralDays int,
@TaxID nvarchar(100),
@DriversLicenseNumber nvarchar(100),
@WebSiteURL nvarchar(1000),
@StyleSheet nvarchar(1000),
@Enabled bit,
@Notes nvarchar(Max)

AS
	BEGIN TRY
		INSERT INTO	bvc_Affiliate
		(
		ReferralID,
		DisplayName,
		Address,
		CommissionAmount,
		CommissionType,
		ReferralDays,
		TaxID,
		DriversLicenseNumber,
		WebSiteURL,
		StyleSheet,
		bvin, 
		Enabled,
		Notes,
		LastUpdated
		)
		VALUES
		(
		@ReferralID,
		@DisplayName,
		@Address, 
		@CommissionAmount,
		@CommissionType,
		@ReferralDays,
		@TaxID,
		@DriversLicenseNumber,
		@WebSiteURL,
		@StyleSheet,
		@bvin,
		@Enabled,
		@Notes,
		GetDate()
		)
		 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_OrderPayment_s]'
GO






CREATE PROCEDURE [dbo].[bvc_OrderPayment_s]
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
PRINT N'Creating [dbo].[bvc_Role_d]'
GO




CREATE PROCEDURE [dbo].[bvc_Role_d]

@bvin varchar(36)

AS

	BEGIN TRY
		DELETE FROM bvc_UserXRole WHERE RoleID=@bvin
		DELETE FROM bvc_RoleXRolePermission WHERE RoleID=@bvin
		DELETE FROM bvc_Role WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_UserAccount_ExcludeVendorId_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_ExcludeVendorId_s]

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
PRINT N'Creating [dbo].[bvc_RolePermission_u]'
GO

CREATE PROCEDURE [dbo].[bvc_RolePermission_u]

	@bvin varchar(36),
	@Name nvarchar(Max),
	@SystemPermission int

AS
BEGIN
	BEGIN TRY
		UPDATE bvc_RolePermission
		SET
		[Name]=@Name,
		SystemPermission=@SystemPermission,
		LastUpdated=GetDate()
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











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
PRINT N'Creating [dbo].[bvc_ProductModifier_CountByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 8/11/2006
-- Description:	Gets count of inputs for product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_CountByProduct_s]
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
PRINT N'Creating [dbo].[bvc_Affiliate_s]'
GO







CREATE PROCEDURE [dbo].[bvc_Affiliate_s]

@bvin varchar(50)

AS
	BEGIN TRY
		SELECT 
			ReferralID, DisplayName,Address,CommissionAmount,
			CommissionType,ReferralDays, TaxID, DriversLicenseNumber,
			WebSiteURL,StyleSheet,bvin, Enabled, Notes, LastUpdated
		FROM bvc_Affiliate 
		WHERE  bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN















GO
PRINT N'Creating [dbo].[bvc_OrderPayment_u]'
GO





CREATE PROCEDURE [dbo].[bvc_OrderPayment_u]
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
PRINT N'Creating [dbo].[bvc_UserAccount_Filter_s]'
GO




CREATE PROCEDURE [dbo].[bvc_UserAccount_Filter_s]
	
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
PRINT N'Creating [dbo].[bvc_EmailTemplate_d]'
GO
CREATE PROCEDURE [dbo].[bvc_EmailTemplate_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_EmailTemplate WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RolePermission_ByRoleID_s]'
GO



CREATE PROCEDURE [dbo].[bvc_RolePermission_ByRoleID_s]
	
	@bvin varchar(36)

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		IF @bvin = '36CC0F07-2DE4-4d25-BF60-C80BC0214F09'
			BEGIN
				SELECT bvin,[Name],SystemPermission,LastUpdated
				FROM bvc_RolePermission
				ORDER By [Name]
			END
		ELSE
			BEGIN
				SELECT bvin,[Name],SystemPermission,LastUpdated
				FROM bvc_RolePermission
				WHERE bvin IN (SELECT PermissionID FROM bvc_RoleXRolePermission WHERE RoleID=@bvin)
				ORDER BY [Name]
			END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END













GO
PRINT N'Creating [dbo].[bvc_Product_BySharedChoice_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_BySharedChoice_s]
	@SharedChoiceId nvarchar(36),
	@SharedChoiceType int
AS
	
BEGIN TRY
	SELECT *
	FROM bvc_Product AS p 
	WHERE
		(
			-- choice
			@SharedChoiceType = 1
			AND (p.bvin IN (SELECT pxc.ProductId FROM bvc_ProductXChoice AS pxc WHERE pxc.ChoiceId = @SharedChoiceId))
		)
		
		OR (
			-- modifier
			@SharedChoiceType = 3 
			AND (p.bvin IN (SELECT pxm.ProductId FROM bvc_ProductXModifier AS pxm WHERE pxm.ModifierId = @SharedChoiceId))
		)
		
		OR (
			-- input
			@SharedChoiceType = 2 
			AND (p.bvin IN (SELECT pxi.ProductId FROM bvc_ProductXInput AS pxi WHERE pxi.InputId = @SharedChoiceId))
		)		
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

RETURN













GO
PRINT N'Creating [dbo].[bvc_Product_ByUpSellId_Admin_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_ByUpSellId_Admin_s]

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
PRINT N'Creating [dbo].[bvc_ProductModifier_i ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Inserts a Product Modifier
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_i ]
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
PRINT N'Creating [dbo].[bvc_RolePermission_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_RolePermission_All_s] 
	
AS
BEGIN
	SET NOCOUNT ON;

    BEGIN TRY
		SELECT bvin,[Name],SystemPermission,LastUpdated
		FROM bvc_RolePermission
		ORDER BY SystemPermission Desc, [Name] Asc
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END











GO
PRINT N'Creating [dbo].[bvc_Affiliate_u]'
GO








CREATE PROCEDURE [dbo].[bvc_Affiliate_u]

@bvin varchar(36),
@ReferralID nvarchar(Max),
@DisplayName nvarchar(255),
@Address ntext,
@CommissionAmount numeric(18,10),
@CommissionType int,
@ReferralDays int,
@TaxID nvarchar(100),
@DriversLicenseNumber nvarchar(100),
@WebSiteURL nvarchar(1000),
@StyleSheet nvarchar(1000),
@Enabled bit,
@Notes nvarchar(Max)

AS
	BEGIN TRY
		Update
		bvc_Affiliate
		SET
		ReferralID=@ReferralID,
		DisplayName=@DisplayName,
		Address=@Address,
		CommissionAmount=@CommissionAmount,
		CommissionType=@CommissionType,
		ReferralDays=@ReferralDays,
		TaxID=@TaxID,
		DriversLicenseNumber=@DriversLicenseNumber,
		WebSiteURL=@WebSiteURL,
		StyleSheet=@StyleSheet,
		Enabled=@Enabled,
		Notes=@Notes,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_d]'
GO

CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_OrderStatusCode WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_UserAccount_i]'
GO






CREATE PROCEDURE [dbo].[bvc_UserAccount_i]

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
PRINT N'Creating [dbo].[bvc_EmailTemplate_i]'
GO

CREATE PROCEDURE [dbo].[bvc_EmailTemplate_i]

@bvin varchar(36),
@DisplayName nvarchar(Max),
@From nvarchar(Max),
@Subject nvarchar(Max),
@Body ntext,
@BodyPlainText ntext,
@RepeatingSection ntext,
@RepeatingSectionPlainText ntext,
@SendInPlainText int,
@BodyPreTransform ntext,
@RepeatingSectionPreTransform ntext
	
AS
	BEGIN TRY
		INSERT INTO bvc_EmailTemplate
		(
		bvin,
		DisplayName,
		[From],
		Subject,
		Body,
		BodyPlainText,
		RepeatingSection,
		RepeatingSectionPlainText,
		SendInPlainText,
		BodyPreTransform,
		RepeatingSectionPreTransform,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@DisplayName,
		@From,
		@Subject,
		@Body,
		@BodyPlainText,
		@RepeatingSection,
		@RepeatingSectionPlainText,
		@SendInPlainText,
		@BodyPreTransform,
		@RepeatingSectionPreTransform,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductType_Properties_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductType_Properties_s]

@bvin varchar(36)

AS

	BEGIN TRY
		SELECT 
		bvin,
		PropertyName,
		DisplayName,
		DisplayOnSite,
		DisplayToDropShipper,
		TypeCode,
		DefaultValue,
		CultureCode,
		SortOrder,
		LastUpdated

		FROM bvc_ProductProperty pp 
		JOIN bvc_ProductTypeXProductProperty ptp 
		ON pp.bvin = ptp.ProductPropertyBvin

		WHERE ptp.ProductTypeBvin=@bvin

		ORDER BY ptp.SortOrder ASC
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_Country_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Country_All_s]

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
PRINT N'Creating [dbo].[bvc_UserAccount_NotInRole_s]'
GO





CREATE PROCEDURE [dbo].[bvc_UserAccount_NotInRole_s]

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
PRINT N'Creating [dbo].[bvc_OrderStatusCode_i]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_i]

@bvin varchar(36),
@SortOrder int,
@StatusName nvarchar(Max),
@SystemCode int

AS

	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_OrderStatusCode) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_OrderStatusCode)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END

		INSERT INTO
		bvc_OrderStatusCode
		(
		bvin,
		SortOrder,
		StatusName,
		SystemCode,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@SortOrder,
		@StatusName,
		@SystemCode,
		GetDate()
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductType_Property_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductType_Property_u]

@ProductTypeBvin varchar(36),
@ProductPropertyBvin varchar(36),
@SortOrder int

AS
	BEGIN TRY
		UPDATE bvc_ProductTypeXProductProperty
		
		SET
		SortOrder=@SortOrder

		WHERE ProductTypeBvin=@ProductTypeBvin
		AND ProductPropertyBvin=@ProductPropertyBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_EmailTemplate_s]'
GO

CREATE PROCEDURE [dbo].[bvc_EmailTemplate_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		DisplayName,
		[From],
		Subject,
		Body,
		BodyPlainText,
		RepeatingSection,
		RepeatingSectionPlainText,
		SendInPlainText,
		BodyPreTransform,
		RepeatingSectionPreTransform,
		LastUpdated
		FROM bvc_EmailTemplate
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Order_ByCriteria_s]'
GO













CREATE PROCEDURE [dbo].[bvc_Order_ByCriteria_s]

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
PRINT N'Creating [dbo].[bvc_Country_Active_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Country_Active_s]

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
PRINT N'Creating [dbo].[bvc_Product_Categories_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_Categories_s] 

@bvin varchar(36)

AS
  BEGIN TRY
	SELECT *
	FROM bvc_Category 
		WHERE (bvin  IN 
			(SELECT CategoryID FROM bvc_ProductXCategory WHERE ProductID=@bvin)) 
		ORDER BY [Name]
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
PRINT N'Creating [dbo].[bvc_Country_ByISOCode_s]'
GO




CREATE PROCEDURE [dbo].[bvc_Country_ByISOCode_s]

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
PRINT N'Creating [dbo].[bvc_AffiliateQuestion_d]'
GO
CREATE PROCEDURE [dbo].[bvc_AffiliateQuestion_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_AffiliateQuestions WHERE bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH







GO
PRINT N'Creating [dbo].[bvc_ProductModifier_s ]'
GO






-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a product modifier by bvin
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_s ]
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
PRINT N'Creating [dbo].[bvc_Order_ByCoupon_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Order_ByCoupon_s]

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
PRINT N'Creating [dbo].[bvc_OrderStatusCode_s]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		SortOrder,
		StatusName,
		SystemCode,
		LastUpdated
		FROM bvc_OrderStatusCode
		WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Sale_d]'
GO







CREATE PROCEDURE [dbo].[bvc_Sale_d]
	@bvin varchar(36)	
AS

	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM bvc_SaleXProduct WHERE SaleId = @bvin
			DELETE FROM bvc_SaleXCategory WHERE SaleId = @bvin
			DELETE FROM bvc_SaleXProductType WHERE SaleId = @bvin
			DELETE FROM bvc_Sale WHERE bvin = @bvin
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN






















GO
PRINT N'Creating [dbo].[bvc_Product_Children_s]'
GO







CREATE PROCEDURE [dbo].[bvc_Product_Children_s]

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
PRINT N'Creating [dbo].[bvc_EmailTemplate_u]'
GO

CREATE PROCEDURE [dbo].[bvc_EmailTemplate_u]

@bvin varchar(36),
@DisplayName nvarchar(Max),
@From nvarchar(Max),
@Subject nvarchar(Max),
@Body ntext,
@BodyPlainText ntext,
@RepeatingSection ntext,
@RepeatingSectionPlainText ntext,
@SendInPlainText int,
@BodyPreTransform ntext,
@RepeatingSectionPreTransform ntext

AS
	BEGIN TRY
		UPDATE bvc_EmailTemplate	
		SET
		DisplayName=@DisplayName,
		[From]=@From,
		Subject=@Subject,
		Body=@Body,
		BodyPlainText=@BodyPlainText,
		RepeatingSection=@RepeatingSection,
		RepeatingSectionPlainText=@RepeatingSectionPlainText,
		SendInPlainText=@SendInPlaintext,
		BodyPreTransform=@BodyPreTransform,
		RepeatingSectionPreTransform=@RepeatingSectionPreTransform,
		LastUpdated=GetDate()
		
		WHERE bvin=@bvin
		
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_AffiliateQuestion_i]'
GO







CREATE PROCEDURE [dbo].[bvc_AffiliateQuestion_i]

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
PRINT N'Creating [dbo].[bvc_Country_d]'
GO


CREATE PROCEDURE [dbo].[bvc_Country_d]

@bvin varchar(36)

AS
	
	BEGIN TRY

		DELETE FROM bvc_ShippingMethod_CountryRestriction WHERE CountryBvin = @bvin

		DELETE FROM bvc_ShippingMethod_RegionRestriction WHERE RegionBvin IN
			(SELECT bvin FROM bvc_Region WHERE CountryID=@bvin)

		DELETE bvc_County WHERE RegionID IN
			(SELECT bvin FROM bvc_Region WHERE CountryID=@bvin)
			
		DELETE FROM bvc_Region WHERE CountryID=@bvin

		DELETE FROM bvc_Country WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_UserAccount_u]'
GO






CREATE PROCEDURE [dbo].[bvc_UserAccount_u]

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
PRINT N'Creating [dbo].[bvc_ProductModifier_SharedByProduct_s ]'
GO










-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/25/2006
-- Description:	Finds shared product modifiers on a per product basis
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_SharedByProduct_s ]
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
PRINT N'Creating [dbo].[bvc_Country_i]'
GO

CREATE PROCEDURE [dbo].[bvc_Country_i]

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
PRINT N'Creating [dbo].[bvc_ProductImage_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductImage_d]

@bvin varchar(36)

AS

	BEGIN TRY
		DELETE FROM bvc_ProductImage WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_SortOrder_u]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_SortOrder_u]

@bvin varchar(36),
@SortOrder int

AS
	BEGIN TRY
		UPDATE bvc_OrderStatusCode SET SortOrder=@SortOrder,LastUpdated=GetDate() WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Country_s]'
GO




CREATE PROCEDURE [dbo].[bvc_Country_s]

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
PRINT N'Creating [dbo].[bvc_KitPart_d]'
GO


CREATE PROCEDURE [dbo].[bvc_KitPart_d]

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
PRINT N'Creating [dbo].[bvc_Order_ByUser_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Order_ByUser_s]

@bvin varchar(36)

AS

	BEGIN TRY
		SELECT * FROM bvc_Order	WHERE  
		UserID=@bvin AND IsPlaced = 1
		ORDER BY TimeOfOrder DESC

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_AffiliateQuestion_s]'
GO








CREATE PROCEDURE [dbo].[bvc_AffiliateQuestion_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_AffiliateQuestions WHERE bvin = @bvin ORDER BY [Order] 
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_ProductModifier_u ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/14/2006
-- Description:	Updates a Product Modifier
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_u ]
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
PRINT N'Creating [dbo].[bvc_ProductInput_AllShared_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds all shared inputs
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_AllShared_s ]
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
PRINT N'Creating [dbo].[bvc_ProductTypeProperty_d]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductTypeProperty_d]

@ProductTypeBvin varchar(36),
@ProductPropertyBvin varchar(36)

 AS
	BEGIN TRY
		DELETE FROM bvc_ProductTypeXProductProperty

		WHERE
		ProductTypeBvin=@ProductTypeBvin AND
		ProductPropertyBvin=@ProductPropertyBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode_u]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_u]

@bvin varchar(36),
@SortOrder int,
@StatusName nvarchar(Max),
@SystemCode int

AS
	BEGIN TRY
		UPDATE bvc_OrderStatusCode
		SET 
		bvin=@bvin,
		SortOrder=@SortOrder,
		StatusName=@StatusName,
		SystemCode=@SystemCode,	
		LastUpdated=GetDate()
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Order_s]'
GO






CREATE PROCEDURE [dbo].[bvc_Order_s]
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
PRINT N'Creating [dbo].[bvc_Product_i]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_i]

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
PRINT N'Creating [dbo].[bvc_EventLog_All_s]'
GO


CREATE PROCEDURE [dbo].[bvc_EventLog_All_s]

AS
	BEGIN TRY
		SELECT bvin,EventTime,Source,Message,Severity,LastUpdated
		FROM bvc_EventLog
		ORDER BY EventTime DESC

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductImage_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductImage_i]

@bvin varchar(36),
@ProductID varchar(36),
@FileName nvarchar(Max),
@Caption nvarchar(Max),
@AlternateText nvarchar(Max),
@SortOrder int

AS
	BEGIN TRY
		
		IF (SELECT COUNT(ProductId) FROM bvc_ProductImage WHERE ProductId = @ProductId) > 0
			BEGIN
				SET @SortOrder = (SELECT Max(SortOrder) FROM bvc_ProductImage WHERE ProductId = @ProductId) + 1
			END
		ELSE
			BEGIN
				SET @SortOrder = 0
			END

		INSERT INTO bvc_ProductImage
		(
		bvin,ProductID,[FileName],Caption,AlternateText,SortOrder,LastUpdated
		)
		VALUES
		(
		@bvin,@ProductID,@FileName,@Caption,@AlternateText,@SortOrder,GetDate()
		)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_ProductInput_ByProduct_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/23/2006
-- Description:	Finds all Product Inputs for a particular product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_ByProduct_s]
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
PRINT N'Creating [dbo].[bvc_KitPart_i]'
GO
CREATE PROCEDURE [dbo].[bvc_KitPart_i]

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
PRINT N'Creating [dbo].[bvc_Order_UserTotals_s]'
GO





CREATE PROCEDURE [dbo].[bvc_Order_UserTotals_s]

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
PRINT N'Creating [dbo].[bvc_AffiliateQuestion_u]'
GO
CREATE PROCEDURE [dbo].[bvc_AffiliateQuestion_u]

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
PRINT N'Creating [dbo].[bvc_EventLog_ByCriteria_s]'
GO


CREATE PROCEDURE [dbo].[bvc_EventLog_ByCriteria_s]

@Severity int

AS
	BEGIN TRY

		IF @Severity = 3

		SELECT bvin,EventTime,Source,Message,Severity,LastUpdated
		FROM bvc_EventLog
		WHERE Severity >= 3
		ORDER BY EventTime DESC

ELSE

		SELECT bvin,EventTime,Source,Message,Severity,LastUpdated
		FROM bvc_EventLog
		WHERE Severity = @Severity
		ORDER BY EventTime DESC

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Country_u]'
GO

CREATE PROCEDURE [dbo].[bvc_Country_u]

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
PRINT N'Creating [dbo].[bvc_CreditCardType_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CreditCardType_All_s]

AS
	BEGIN TRY
		SELECT 
			Code,LongName,Active
		FROM bvc_CreditCardType
		ORDER BY LongName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN















GO
PRINT N'Creating [dbo].[bvc_UserQuestion_d]'
GO
CREATE PROCEDURE [dbo].[bvc_UserQuestion_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_UserQuestions WHERE bvin = @bvin		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_ProductTypeProperty_i]'
GO





CREATE PROCEDURE [dbo].[bvc_ProductTypeProperty_i]

@ProductTypeBvin varchar(36),
@ProductPropertyBvin varchar(36),
@SortOrder int


 AS
	BEGIN TRY
		INSERT INTO bvc_ProductTypeXProductProperty 
		(ProductTypeBvin,ProductPropertyBvin,SortOrder)

		VALUES (@ProductTypeBvin,@ProductPropertyBvin,@SortOrder)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


RETURN







GO
PRINT N'Creating [dbo].[bvc_ProductImage_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductImage_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ProductID,[FileName],Caption,AlternateText,SortOrder,LastUpdated
		FROM bvc_ProductImage
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductInventory_Adjust_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_Adjust_u] 

	@ProductBvin varchar(36),
	@Adjustment decimal(18,10)

AS
BEGIN
	BEGIN TRY
		UPDATE bvc_ProductInventory
		SET	
		QuantityAvailable=QuantityAvailable + @Adjustment,
		LastUpdated=GetDate()
		WHERE ProductBvin=@ProductBvin

		exec bvc_ProductInventory_UpdateParent_u @ProductBvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END














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
PRINT N'Creating [dbo].[bvc_EventLog_d]'
GO







CREATE PROCEDURE [dbo].[bvc_EventLog_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_EventLog WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Order_i]'
GO














CREATE PROCEDURE [dbo].[bvc_Order_i]
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
PRINT N'Creating [dbo].[bvc_CustomPage_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_CustomPage_All_s]

AS
	BEGIN TRY
		SELECT bvin,[Name],[Content],MenuName,ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated,MetaTitle,TemplateName,PreContentColumnId,PostContentColumnId
		FROM
		bvc_Custompage ORDER BY [Name]

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





















GO
PRINT N'Creating [dbo].[bvc_UserQuestion_i]'
GO







CREATE PROCEDURE [dbo].[bvc_UserQuestion_i]

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
PRINT N'Creating [dbo].[bvc_CustomUrl_All_S]'
GO


CREATE PROCEDURE [dbo].[bvc_CustomUrl_All_S]
@StartRowIndex int = 0,
@MaximumRows int = 9999999
AS
	BEGIN TRY;
		WITH Urls AS
		(SELECT 
		ROW_NUMBER() OVER (ORDER BY RequestedUrl) As RowNum,
		bvin,RequestedUrl,RedirectToUrl,SystemUrl,SystemData,LastUpdated
		FROM bvc_CustomUrl)
		
		SELECT *, (SELECT COUNT(*) FROM Urls) AS TotalRowCount FROM Urls
			WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_ProductImage_u]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductImage_u]

@bvin varchar(36),
@ProductID varchar(36),
@FileName nvarchar(Max),
@Caption nvarchar(Max),
@AlternateText nvarchar(Max),
@SortOrder int

AS
	BEGIN TRY
		UPDATE bvc_ProductImage
		SET
		bvin=@bvin,
		ProductID=@ProductID,
		[FileName]=@FileName,
		Caption=@Caption,
		AlternateText=@AlternateText,
		SortOrder=@SortOrder,
		LastUpdated=GetDate()
		
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Product_Light_s]'
GO



















CREATE PROCEDURE [dbo].[bvc_Product_Light_s]

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
PRINT N'Creating [dbo].[bvc_Order_MaxOrderNumber_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Order_MaxOrderNumber_s]

AS
	BEGIN TRY
		SELECT 
		Max(OrderNumber) as MaxOrderNumber
		FROM bvc_Order

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



























GO
PRINT N'Creating [dbo].[bvc_ProductModifier_AllShared_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a shared product modifier by bvin
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_AllShared_s ]
AS

	BEGIN TRY
		SELECT bvin, [Name], DisplayName, ProductId, Shared, Type, Required, 0 As [Order] FROM bvc_ProductModifier WHERE Shared = 1 ORDER BY Name
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


























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
PRINT N'Creating [dbo].[bvc_EventLog_Limit_d]'
GO

CREATE PROCEDURE [dbo].[bvc_EventLog_Limit_d]

	@MaxRows int = 1000

AS
BEGIN
				
		WITH E AS
		(
		SELECT ROW_NUMBER() OVER (ORDER BY LastUpdated DESC) as RowNum, 
			bvin
		FROM bvc_EventLog
		) 

		DELETE FROM E WHERE 
		RowNum > @MaxRows
END



GO
PRINT N'Creating [dbo].[bvc_ProductModifier_ByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Finds a Product Modifier for a particular product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_ByProduct_s]
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
PRINT N'Creating [dbo].[bvc_EmailTemplate_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_EmailTemplate_All_s]
	
AS
	BEGIN TRY
		SELECT 
		bvin,
		DisplayName,
		[From],
		Subject,
		Body,
		BodyPlainText,
		RepeatingSection,
		RepeatingSectionPlainText,
		SendInPlainText,
		BodyPreTransform,
		RepeatingSectionPreTransform,
		LastUpdated
		FROM bvc_EmailTemplate
		ORDER BY DisplayName
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_UserQuestion_s]'
GO








CREATE PROCEDURE [dbo].[bvc_UserQuestion_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_UserQuestions WHERE bvin = @bvin ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_ProductImageByProduct_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductImageByProduct_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ProductID,[FileName],Caption,AlternateText,SortOrder,LastUpdated
		FROM bvc_ProductImage
		WHERE ProductID=@bvin
		ORDER BY SortOrder
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductModifier_d ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Deletes a Product Modifier
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductModifier_d ]	
	@bvin varchar(36)
AS
BEGIN			
	BEGIN TRY		
		BEGIN TRANSACTION
		DELETE FROM bvc_ComponentSettingList WHERE componentID=@bvin			
		DELETE FROM bvc_ComponentSetting WHERE componentID=@bvin
		
		DELETE FROM bvc_ProductXModifier WHERE ModifierId = @bvin		
		DELETE FROM bvc_ProductModifierOption WHERE ModifierId = @bvin
		DELETE FROM bvc_ProductModifier WHERE bvin = @bvin
		DELETE FROM bvc_ProductChoiceInputOrder WHERE ChoiceInputId = @bvin
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION

		EXEC bvc_EventLog_SQL_i
	END CATCH	
END






















GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_ByPolicyId_s]'
GO



CREATE PROCEDURE [dbo].[bvc_PolicyBlock_ByPolicyId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,[Name],[Description],PolicyID,SortOrder,LastUpdated,DescriptionPreTransform
		FROM bvc_PolicyBlock
		WHERE PolicyID=@bvin ORDER BY SortOrder
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Order_Range_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Order_Range_s]

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
PRINT N'Creating [dbo].[bvc_OrderStatusCode_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderStatusCode_All_s]

AS
	BEGIN TRY
		SELECT bvin,SortOrder,StatusName,SystemCode,LastUpdated
		FROM bvc_OrderStatusCode
		ORDER BY SortOrder
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]'
GO









CREATE PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_Admin_s]

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
PRINT N'Creating [dbo].[bvc_KitPart_s]'
GO
CREATE PROCEDURE [dbo].[bvc_KitPart_s]

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
PRINT N'Creating [dbo].[bvc_EventLog_All_d]'
GO


CREATE PROCEDURE [dbo].[bvc_EventLog_All_d]

AS
	BEGIN TRY
		DELETE FROM bvc_EventLog
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN



















GO
PRINT N'Creating [dbo].[bvc_UserQuestion_u]'
GO
CREATE PROCEDURE [dbo].[bvc_UserQuestion_u]

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
PRINT N'Creating [dbo].[bvc_OrderPayment_ByOrderId_s]'
GO








CREATE PROCEDURE [dbo].[bvc_OrderPayment_ByOrderId_s]

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
PRINT N'Creating [dbo].[bvc_Policy_d]'
GO
CREATE PROCEDURE [dbo].[bvc_Policy_d]
	
	@bvin varchar(36)
	
AS
	BEGIN TRY
		DELETE bvc_PolicyBlock WHERE policyID=@bvin
		DELETE bvc_Policy WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_d]'
GO

CREATE PROCEDURE [dbo].[bvc_PolicyBlock_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_PolicyBlock WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_EventLog_i]'
GO







CREATE PROCEDURE [dbo].[bvc_EventLog_i]
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
PRINT N'Creating [dbo].[bvc_KitPart_u]'
GO
CREATE PROCEDURE [dbo].[bvc_KitPart_u]

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
PRINT N'Creating [dbo].[bvc_Product_ByOrder_s]'
GO







CREATE PROCEDURE [dbo].[bvc_Product_ByOrder_s]

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
PRINT N'Creating [dbo].[bvc_LineItemStatusCode_s]'
GO


CREATE PROCEDURE [dbo].[bvc_LineItemStatusCode_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,
		SortOrder,
		StatusName,
		SystemCode,
		LastUpdated
		FROM bvc_LineItemStatusCode
		WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_LineItem_ByOrderId_s]'
GO





CREATE PROCEDURE [dbo].[bvc_LineItem_ByOrderId_s]

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
PRINT N'Creating [dbo].[bvc_ProductChoice_ByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Finds a Product Choice for a particular product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_ByProduct_s]
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
PRINT N'Creating [dbo].[bvc_ProductProperty_Exists_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_Exists_s]

@PropertyName nvarchar(512)

AS
	BEGIN TRY
		SELECT 
			bvin,
			PropertyName,
			DisplayName,
			DisplayOnSite,
			DisplayToDropShipper,
			TypeCode,
			DefaultValue,
			CultureCode,
			LastUpdated

		FROM bvc_ProductProperty

		WHERE PropertyName=@PropertyName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





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
PRINT N'Creating [dbo].[bvc_ProductProperty_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_All_s]

AS

	BEGIN TRY
		SELECT 
			bvin,
			PropertyName,
			DisplayName,
			DisplayOnSite,
			DisplayToDropShipper,
			TypeCode,
			DefaultValue,
			CultureCode,
			LastUpdated

		FROM bvc_ProductProperty

		ORDER BY PropertyName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_i]'
GO



CREATE PROCEDURE [dbo].[bvc_PolicyBlock_i]

@bvin varchar(36),
@Name nvarchar(255),
@Description ntext,
@PolicyID varchar(36),
@SortOrder int,
@DescriptionPreTransform ntext

AS
	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_PolicyBlock WHERE PolicyId=@PolicyId) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_PolicyBlock WHERE PolicyId=@PolicyId)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END

		INSERT INTO
		bvc_PolicyBlock
		(bvin,[Name],[Description],PolicyID,SortOrder,LastUpdated,DescriptionPreTransform)
		VALUES(@bvin,@Name,@Description,@PolicyID,@SortOrder,GetDate(),@DescriptionPreTransform)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Order_u]'
GO

CREATE PROCEDURE [dbo].[bvc_Order_u]
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
PRINT N'Creating [dbo].[bvc_LineItemStatusCode_SortOrder_u]'
GO


CREATE PROCEDURE [dbo].[bvc_LineItemStatusCode_SortOrder_u]

@bvin varchar(36),
@SortOrder int

AS
	BEGIN TRY
		UPDATE bvc_LineItemStatusCode SET SortOrder=@SortOrder,LastUpdated=GetDate() WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_Tax_ByCriteria_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Tax_ByCriteria_s]

@RegionBvin varchar(36) = NULL,
@PostalCode nvarchar(50) = NULL,
@CountryBvin varchar(36) = NULL,
@CountyBvin varchar(36) = NULL,
@TaxClass varchar(36) = NULL

AS
	BEGIN TRY
		SELECT Bvin, RegionBvin, PostalCode, CountryBvin, CountyBvin, TaxClass, Rate, ApplyToShipping, LastUpdated
		FROM
		bvc_Tax
		WHERE 
		(RegionBvin = @RegionBvin)
		OR
		(PostalCode = @PostalCode)
		OR
		(CountryBvin = @CountryBvin)
		OR
		(CountyBvin = @CountyBvin)
		OR
		(TaxClass = @TaxClass)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH






















GO
PRINT N'Creating [dbo].[bvc_ProductProperty_i]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_i]
@bvin varchar(36),
@PropertyName nvarchar(512),
@DisplayName nvarchar(512),
@DisplayOnSite int,
@DisplayToDropShipper int,
@TypeCode int,
@DefaultValue nvarchar(max),
@CultureCode nvarchar(10)

AS
	BEGIN TRY
		INSERT INTO bvc_ProductProperty
		(bvin, PropertyName,DisplayName,DisplayOnSite,DisplayToDropShipper,TypeCode,DefaultValue,
		CultureCode, LastUpdated)
		VALUES (@bvin, @PropertyName,@DisplayName,@DisplayOnSite,@DisplayToDropShipper,@TypeCode,
		@DefaultValue,@CultureCode, GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	
	RETURN





GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_s]'
GO


CREATE PROCEDURE [dbo].[bvc_PolicyBlock_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,[Name],Description,PolicyID,SortOrder,LastUpdated,DescriptionPreTransform
		FROM bvc_PolicyBlock
		WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_ProductInput_CountByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 8/11/2006
-- Description:	Gets count of inputs for product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_CountByProduct_s]
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		SELECT COUNT(*) As Count From bvc_ProductInputs As a JOIN bvc_ProductXInput As b ON a.bvin = b.InputId WHERE @bvin = b.ProductId
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END




























GO
PRINT N'Creating [dbo].[bvc_LineItemStatusCode_u]'
GO


CREATE PROCEDURE [dbo].[bvc_LineItemStatusCode_u]

@bvin varchar(36),
@SortOrder int,
@StatusName nvarchar(Max),
@SystemCode int

AS
	BEGIN TRY
		UPDATE bvc_LineItemStatusCode
		SET 
		bvin=@bvin,
		SortOrder=@SortOrder,
		StatusName=@StatusName,
		SystemCode=@SystemCode,	
		LastUpdated=GetDate()
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_ProductInput_d ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/23/2006
-- Description:	Deletes a Product Input
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_d ]	
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		DELETE FROM bvc_ComponentSettingList WHERE componentID=@bvin			
		DELETE FROM bvc_ComponentSetting WHERE componentID=@bvin
		DELETE FROM bvc_ProductInputs WHERE bvin = @bvin
		DELETE FROM bvc_ProductChoiceInputOrder WHERE ChoiceInputId = @bvin
		DELETE FROM bvc_ProductXInput WHERE InputId = @bvin
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN
END



















GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_All_s]

AS
BEGIN TRY
	SELECT 
	bvin,ComponentID,DeveloperId,ComponentType,
	ComponentSubType,ListName,SortOrder,
	Setting1,Setting2,Setting3,Setting4,Setting5,
	Setting6,Setting7,Setting8,Setting9,Setting10,
	LastUpdated 
	FROM bvc_ComponentSettingList
	ORDER By ComponentId,SortOrder
	
	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH











GO
PRINT N'Creating [dbo].[bvc_LineItemModifier_ByLineItem_d]'
GO





CREATE PROCEDURE [dbo].[bvc_LineItemModifier_ByLineItem_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_LineItemModifier WHERE LineItemBvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_ProductProperty_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_s]

@bvin varchar(36)

AS

BEGIN TRY
	SELECT 
		bvin,
		PropertyName,
		DisplayName,
		DisplayOnSite,
		DisplayToDropShipper,
		TypeCode,
		DefaultValue,
		CultureCode,
		LastUpdated
	FROM bvc_ProductProperty
	WHERE bvin=@bvin
	
	SELECT
		bvin,
		PropertyBvin,
		ChoiceName,
		SortOrder,
		LastUpdated
	FROM bvc_ProductPropertyChoice
	WHERE PropertyBvin = @bvin
	ORDER BY SortOrder
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_ProductReview_ByProductBvin_s]'
GO









CREATE PROCEDURE [dbo].[bvc_ProductReview_ByProductBvin_s]

@bvin varchar(36),
@moderate int = 0

AS

	BEGIN TRY
		IF @moderate = 1
			BEGIN
			SELECT 
			r.bvin,
			r.LastUpdated,
			r.Approved, 
			r.Description, 
			r.Karma,
			r.ProductBvin, 
			r.Rating, 
			r.ReviewDate, 
			r.UserID,
			r.UserName,
			r.UserEmail,
			p.ProductName
			FROM bvc_ProductReview r
			JOIN bvc_Product p on r.ProductBvin = p.bvin
			WHERE r.ProductBvin = @bvin
			ORDER BY r.Karma DESC, r.ReviewDate DESC
			END
		ELSE
			BEGIN
			SELECT 
			r.bvin,
			r.LastUpdated,
			r.Approved, 
			r.Description, 
			r.Karma,
			r.ProductBvin, 
			r.Rating, 
			r.ReviewDate, 
			r.UserID,
			r.UserName,
			r.UserEmail,
			p.ProductName
			FROM bvc_ProductReview r
			JOIN bvc_Product p on r.ProductBvin = p.bvin
			WHERE r.ProductBvin = @bvin AND r.Approved = 1 
			ORDER BY r.Karma DESC, r.ReviewDate DESC
			END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_LineItemInput_ByLineItem_d]'
GO





CREATE PROCEDURE [dbo].[bvc_LineItemInput_ByLineItem_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_LineItemInput WHERE LineItemBvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_PolicyBlock_SortOrder_u]'
GO


CREATE PROCEDURE [dbo].[bvc_PolicyBlock_SortOrder_u]

@bvin varchar(36),
@SortOrder int

AS
	BEGIN TRY
		UPDATE bvc_PolicyBlock SET SortOrder=@SortOrder,LastUpdated=GetDate() WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_CreditCardType_AllActive_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CreditCardType_AllActive_s]

AS
	BEGIN TRY
		SELECT 
			Code,LongName,Active
		FROM bvc_CreditCardType
		WHERE Active=1
		ORDER BY LongName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN















GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_ByComponentId_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_ByComponentId_s]

@bvin varchar(36)

AS
BEGIN TRY
	SELECT 
	bvin,ComponentID,DeveloperId,ComponentType,
	ComponentSubType,ListName,SortOrder,
	Setting1,Setting2,Setting3,Setting4,Setting5,
	Setting6,Setting7,Setting8,Setting9,Setting10,
	LastUpdated 
	FROM bvc_ComponentSettingList
	WHERE ComponentId = @bvin
	ORDER By ListName, SortOrder
	
	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH












GO
PRINT N'Creating [dbo].[bvc_UserAccount_ByAffiliateID_s]'
GO






CREATE PROCEDURE [dbo].[bvc_UserAccount_ByAffiliateID_s]

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
PRINT N'Creating [dbo].[bvc_ProductProperty_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_u]

@bvin varchar(36),
@PropertyName nvarchar(512),
@DisplayName nvarchar(512),
@DisplayOnSite int,
@DisplayToDropShipper int,
@TypeCode int,
@DefaultValue nvarchar(max),
@CultureCode nvarchar(10)

AS
	BEGIN TRY
			UPDATE bvc_ProductProperty
			
			SET
			PropertyName=@PropertyName,
			DisplayName=@DisplayName,
			DisplayOnSite=@DisplayOnSite,
			DisplayToDropShipper=@DisplayToDropShipper,
			TypeCode=@TypeCode,
			DefaultValue=@DefaultValue,
			CultureCode=@CultureCode,
			LastUpdated=GetDate()
			WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	RETURN





GO
PRINT N'Creating [dbo].[bvc_ProductInput_i ]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/23/2006
-- Description:	Inserts a Product Input
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_i ]
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
PRINT N'Creating [dbo].[bvc_ComponentSettingList_ByListName_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_ByListName_d]

@componentID varchar(36),
@listName nvarchar(Max)

AS
	
BEGIN TRY
	DELETE FROM bvc_ComponentSettingList WHERE ComponentId = @componentId AND ListName = @listName	
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

		
RETURN












GO
PRINT N'Creating [dbo].[bvc_Product_ByCategory_s]'
GO


CREATE PROCEDURE [dbo].[bvc_Product_ByCategory_s]

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
					WHEN @DisplaySortOrder = 6 THEN ROW_NUMBER() OVER (ORDER BY CreationDate DESC)
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
			--LEFT JOIN bvc_ProductInventory AS bpi ON p.bvin = bpi.ProductBvin			
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
PRINT N'Creating [dbo].[bvc_PolicyBlock_u]'
GO


CREATE PROCEDURE [dbo].[bvc_PolicyBlock_u]

@bvin varchar(36),
@Name nvarchar(255),
@PolicyID varchar(36),
@Description ntext,
@DescriptionPreTransform ntext,
@SortOrder int

AS
	BEGIN TRY
		UPDATE bvc_PolicyBlock
		SET [Name]=@Name,
		[Description]=@Description,
		DescriptionPreTransform=@DescriptionPreTransform,
		PolicyID=@PolicyID,
		SortOrder=@SortOrder,
		LastUpdated=GetDate()
		
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_CreditCardType_d]'
GO




CREATE PROCEDURE [dbo].[bvc_CreditCardType_d]

@code nvarchar(50)

AS
	
	BEGIN TRY
		DELETE FROM bvc_CreditCardType WHERE code=@code

		RETURN 
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_WorkFlow_i]'
GO




-- =============================================
-- Author:		BV Software
-- =============================================
CREATE PROCEDURE [dbo].[bvc_WorkFlow_i] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36),
	@ContextType int, 
	@Name nvarchar(255),
	@SystemWorkFlow int
AS
BEGIN
	BEGIN TRY
		INSERT INTO bvc_WorkFlow
		(
		bvin,
		ContextType,
		[Name],
		SystemWorkFlow,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@ContextType,
		@Name,
		@SystemWorkFlow,
		GetDate()
		)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
		
END















GO
PRINT N'Creating [dbo].[bvc_KitPart_ByParentProductID_s]'
GO
CREATE PROCEDURE [dbo].[bvc_KitPart_ByParentProductID_s]

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
PRINT N'Creating [dbo].[bvc_Product_u]'
GO













CREATE PROCEDURE [dbo].[bvc_Product_u]

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
PRINT N'Creating [dbo].[bvc_RMA_i]'
GO












CREATE PROCEDURE [dbo].[bvc_RMA_i]
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
PRINT N'Creating [dbo].[bvc_UserAccount_ByEmail_s]'
GO






CREATE PROCEDURE [dbo].[bvc_UserAccount_ByEmail_s]

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
PRINT N'Creating [dbo].[bvc_LineItem_i]'
GO







CREATE PROCEDURE [dbo].[bvc_LineItem_i]
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
PRINT N'Creating [dbo].[bvc_Tax_d]'
GO

CREATE PROCEDURE [dbo].[bvc_Tax_d] 
	@bvin varchar(36)	
AS
BEGIN

	BEGIN TRY
		DELETE FROM bvc_Tax where bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END












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
					WHEN @DisplaySortOrder = 6 THEN ROW_NUMBER() OVER (ORDER BY CreationDate DESC)
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
			--LEFT JOIN bvc_ProductInventory AS bpi ON p.bvin = bpi.ProductBvin			
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
PRINT N'Creating [dbo].[bvc_ProductPropertyByProductType_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyByProductType_s]

@bvin varchar(36)

AS

BEGIN TRY
	SELECT 
		bvin,
		PropertyName,
		DisplayName,
		DisplayOnSite,
		DisplayToDropShipper,
		TypeCode,
		DefaultValue,
		CultureCode,
		LastUpdated,
		b.SortOrder
	FROM bvc_ProductProperty AS a JOIN bvc_ProductTypeXProductProperty AS b ON a.bvin = b.ProductPropertyBvin
	WHERE b.ProductTypeBvin = @bvin
	ORDER BY b.SortOrder
		
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_CreditCardType_i]'
GO

CREATE PROCEDURE [dbo].[bvc_CreditCardType_i]

@Code nvarchar(50),
@LongName nvarchar(Max),
@Active int

AS
	BEGIN TRY
		INSERT INTO	
		bvc_CreditCardType
		(
		Code,
		LongName,
		Active
		)
		VALUES
		(
		@Code,
		@LongName,
		@Active
		)
		 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














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
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_d]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_d]

@bvin varchar(36)

AS

	BEGIN TRY
		DELETE FROM bvc_ProductVolumeDiscounts WHERE
		bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductInput_s ]'
GO








-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/24/2006
-- Description:	Finds a product input by bvin
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_s ]
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
PRINT N'Creating [dbo].[bvc_ComponentSettingList_ByListName_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_ByListName_s]

@componentID varchar(36),
@ListName nvarchar(Max)

AS
BEGIN TRY	
	IF @ListName = '' 
		BEGIN
			SELECT 
			bvin,ComponentID,DeveloperId,ComponentType,
			ComponentSubType,ListName,SortOrder,
			Setting1,Setting2,Setting3,Setting4,Setting5,
			Setting6,Setting7,Setting8,Setting9,Setting10,
			LastUpdated 
			FROM bvc_ComponentSettingList
			WHERE ComponentID=@ComponentID
			ORDER BY ListName,SortOrder
		END
	ELSE
		BEGIN
			SELECT 
			bvin,ComponentID,DeveloperId,ComponentType,
			ComponentSubType,ListName,SortOrder,
			Setting1,Setting2,Setting3,Setting4,Setting5,
			Setting6,Setting7,Setting8,Setting9,Setting10,
			LastUpdated 
			FROM bvc_ComponentSettingList
			WHERE ComponentID=@ComponentID AND ListName=@ListName
			ORDER BY SortOrder
		END
			
	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH












GO
PRINT N'Creating [dbo].[bvc_Product_ByCriteria_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_ByCriteria_s]

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
PRINT N'Creating [dbo].[bvc_Product_UniqueSku_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_UniqueSku_s] 
	@sku nvarchar(50),
	@bvin varchar(36)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT Count(*) FROM bvc_Product WHERE Sku = @sku AND bvin != @bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END



GO
PRINT N'Creating [dbo].[bvc_Tax_i]'
GO


CREATE PROCEDURE [dbo].[bvc_Tax_i]

@Bvin varchar(36),
@RegionBvin varchar(36),
@PostalCode nvarchar(50),
@CountryBvin varchar(36),
@CountyBvin varchar(36),
@TaxClass varchar(36),
@Rate decimal(18,10),
@ApplyToShipping bit

AS
	BEGIN TRY
		Insert Into bvc_Tax
		(
		Bvin,
		RegionBvin,
		PostalCode,
		CountryBvin,
		CountyBvin,
		TaxClass,
		Rate,
		ApplyToShipping,
		LastUpdated
		)
		VALUES
		(
		@Bvin,
		@RegionBvin,
		@PostalCode,
		@CountryBvin,
		@CountyBvin,
		@TaxClass,
		@Rate,
		@ApplyToShipping,
		GetDate()
		)	
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_RMA_s]'
GO












CREATE PROCEDURE [dbo].[bvc_RMA_s]
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
PRINT N'Creating [dbo].[bvc_LineItemModifier_ByLineItem_s]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItemModifier_ByLineItem_s]
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
PRINT N'Creating [dbo].[bvc_ProductPropertyChoice_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoice_d]

@bvin as varchar(36)

 AS
	BEGIN TRY
		DELETE FROM bvc_ProductPropertyChoice WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_CreditCardType_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CreditCardType_s]

@Code nvarchar(50)

AS
	BEGIN TRY
		SELECT 
			Code,LongName,Active
		FROM bvc_CreditCardType
		WHERE  Code=@Code
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

RETURN















GO
PRINT N'Creating [dbo].[bvc_Product_ByCrossSellId_s]'
GO














CREATE PROCEDURE [dbo].[bvc_Product_ByCrossSellId_s]

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
PRINT N'Creating [dbo].[bvc_LineItemInput_ByLineItem_s]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItemInput_ByLineItem_s]
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
PRINT N'Creating [dbo].[bvc_PriceGroup_d]'
GO






CREATE PROCEDURE [dbo].[bvc_PriceGroup_d]

@bvin varchar(36)

AS
	BEGIN TRY
		UPDATE bvc_User SET PricingGroup = '' WHERE PricingGroup = @bvin
		DELETE FROM bvc_PriceGroup WHERE bvin = @bvin
		 
		RETURN

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















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
PRINT N'Creating [dbo].[bvc_Category_All_d]'
GO

CREATE PROCEDURE [dbo].[bvc_Category_All_d]

AS
	BEGIN TRY

		DELETE FROM bvc_ProductXCategory 

		DELETE FROM bvc_SaleXCategory 

		DELETE FROM bvc_CustomUrl 

		UPDATE bvc_Category SET ParentId=''

		DELETE FROM bvc_Category

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_ProductInput_u ]'
GO









-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/23/2006
-- Description:	Updates a Product Input
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInput_u ]
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
PRINT N'Creating [dbo].[bvc_ComponentSettingList_d]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_d]

@bvin varchar(36)

AS

	BEGIN TRY
		DELETE bvc_ComponentSettingList WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_UserAccount_d]'
GO



CREATE PROCEDURE [dbo].[bvc_UserAccount_d]

@bvin varchar(36)

AS

	BEGIN TRY

		BEGIN TRANSACTION


			DELETE FROM bvc_WishList WHERE UserId=@bvin
			--SELECT @err = @@error IF @err <> 0 BEGIN ROLLBACK TRANSACTION RETURN @err END

			DELETE FROM bvc_AuthenticationToken WHERE UserBvin=@bvin
			--SELECT @err = @@error IF @err <> 0 BEGIN ROLLBACK TRANSACTION RETURN @err END

			exec bvc_LoyaltyPoints_ByUserId_d @bvin

			exec bvc_Address_ByUserId_d @bvin
					
			DELETE FROM bvc_UserXRole WHERE UserID=@bvin	

			DELETE FROM bvc_UserXContact WHERE UserId=@bvin

			DELETE FROM bvc_User WHERE bvin=@bvin
			
	   COMMIT

	   RETURN 
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Tax_s]'
GO



CREATE PROCEDURE [dbo].[bvc_Tax_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT Bvin, RegionBvin, PostalCode, CountryBvin, CountyBvin, TaxClass, Rate, ApplyToShipping, LastUpdated
		FROM
		bvc_Tax
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH




















GO
PRINT N'Creating [dbo].[bvc_WorkFlow_u]'
GO

CREATE PROCEDURE [dbo].[bvc_WorkFlow_u] 
	@bvin varchar(36), 
	@ContextType int,
	@Name nvarchar(255),
	@SystemWorkFlow int
AS
BEGIN

	BEGIN TRY
		UPDATE bvc_WorkFlow
		SET
		bvin=@bvin,
		ContextType=@ContextType,
		[Name]=@Name,
		SystemWorkFlow=@SystemWorkFlow,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

END















GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_i]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_i]

@bvin varchar(36),
@ProductID varchar(36),
@Qty int,
@DiscountType int,
@Amount numeric(18,10)

AS

	BEGIN TRY
		INSERT INTO bvc_ProductVolumeDiscounts
		(bvin,ProductID,Qty,Amount,DiscountType,LastUpdated)
		VALUES
		(@bvin,@ProductID,@Qty,@Amount,@DiscountType,GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoice_i]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoice_i]

@bvin varchar(36),
@ProductPropertyBvin varchar(36),
@ChoiceName nvarchar(512),
@SortOrder int


 AS
	BEGIN TRY
		INSERT INTO bvc_ProductPropertyChoice 
		(bvin,PropertyBvin,ChoiceName,SortOrder,LastUpdated)

		VALUES (@bvin,@ProductPropertyBvin,@ChoiceName,@SortOrder,GetDate())
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


RETURN





GO
PRINT N'Creating [dbo].[bvc_CreditCardType_u]'
GO

CREATE PROCEDURE [dbo].[bvc_CreditCardType_u]

@Code nvarchar(50),
@LongName nvarchar(Max),
@Active int

AS
	BEGIN TRY
		Update
		bvc_CreditCardType
		SET
		LongName=@LongName,
		Active=@Active
		WHERE
		code=@Code
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_RMA_u]'
GO












CREATE PROCEDURE [dbo].[bvc_RMA_u]
@bvin varchar(36),
@OrderBvin varchar(36),
@Name nvarchar(150),
@EmailAddress nvarchar(150),
@PhoneNumber nvarchar(30),
@Comments nvarchar(Max),
@Status int,
@AdministratorRequest bit

AS
	BEGIN TRY
		UPDATE
		bvc_RMA
		SET
		OrderBvin = @OrderBvin,
		[Name] = @Name,
		EmailAddress = @EmailAddress,
		PhoneNumber = @PhoneNumber,
		Comments = @Comments,
		Status = @Status,
		LastUpdated = GetDate()
		WHERE bvin = @bvin
		AND (Status = 0 OR @AdministratorRequest = 1)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


























GO
PRINT N'Creating [dbo].[bvc_ProductChoice_AllShared_s ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 4/24/2006
-- Description:	Finds a product input by bvin
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_AllShared_s ]
AS

	BEGIN TRY
		SELECT bvin, ChoiceName, ChoiceDisplayName, ProductId, SharedChoice, ChoiceType, 0 As [Order] FROM bvc_ProductChoices WHERE SharedChoice = 1 ORDER BY ChoiceName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
























GO
PRINT N'Creating [dbo].[bvc_Product_s]'
GO



















CREATE PROCEDURE [dbo].[bvc_Product_s]

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
PRINT N'Creating [dbo].[bvc_LineItem_u]'
GO






CREATE PROCEDURE [dbo].[bvc_LineItem_u]
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
PRINT N'Creating [dbo].[bvc_ProductInventory_UpdateParent_u]'
GO

-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_UpdateParent_u] 

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
PRINT N'Creating [dbo].[bvc_Product_BySkuAll_s]'
GO











CREATE PROCEDURE [dbo].[bvc_Product_BySkuAll_s]

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
PRINT N'Creating [dbo].[bvc_Category_All_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_All_s]

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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
			FROM bvc_Category)
			
			SELECT *, (SELECT COUNT(*) FROM Categories) AS TotalRowCount FROM Categories WHERE RowNum BETWEEN (@StartRowIndex + 1) and (@StartRowIndex + @MaximumRows)
			ORDER BY RowNum			
		END

		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_Tax_u]'
GO


CREATE PROCEDURE [dbo].[bvc_Tax_u]

@Bvin varchar(36),
@RegionBvin varchar(36),
@PostalCode nvarchar(50),
@CountryBvin varchar(36),
@CountyBvin varchar(36),
@TaxClass varchar(36),
@Rate decimal(18,10),
@ApplyToShipping bit

AS
	BEGIN TRY
		Update bvc_Tax
		Set
		Bvin=@Bvin,
		RegionBvin=@RegionBvin,
		PostalCode=@PostalCode,
		CountryBvin=@CountryBvin,
		CountyBvin=@CountyBvin,
		TaxClass=@TaxClass,
		Rate=@Rate,
		ApplyToShipping=@ApplyToShipping,
		LastUpdated=GetDate()
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_i]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_i]

@bvin varchar(36),
@ComponentID varchar(36),
@DeveloperId nvarchar(15),
@ComponentType nvarchar(25),
@ComponentSubType nvarchar(25),
@ListName nvarchar(255),
@SortOrder int,
@Setting1 nvarchar(Max),
@Setting2 nvarchar(Max),
@Setting3 nvarchar(Max),
@Setting4 nvarchar(Max),
@Setting5 nvarchar(Max),
@Setting6 nvarchar(Max),
@Setting7 nvarchar(Max),
@Setting8 nvarchar(Max),
@Setting9 nvarchar(Max),
@Setting10 nvarchar(Max)

AS

	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_ComponentSettingList WHERE ComponentID=@ComponentID AND ListName=@ListName) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_ComponentSettingList WHERE ComponentID=@ComponentID AND ListName=@ListName)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END
			
			
		INSERT INTO bvc_ComponentSettingList
		(
		bvin,
		ComponentID,
		DeveloperId,
		ComponentType,
		ComponentSubType,
		ListName,	
		SortOrder,	
		Setting1,
		Setting2,
		Setting3,
		Setting4,
		Setting5,
		Setting6,
		Setting7,
		Setting8,
		Setting9,
		Setting10,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@ComponentID,
		@DeveloperId,
		@ComponentType,
		@ComponentSubType,
		@ListName,	
		@SortOrder,	
		@Setting1,
		@Setting2,
		@Setting3,
		@Setting4,
		@Setting5,
		@Setting6,
		@Setting7,
		@Setting8,
		@Setting9,
		@Setting10,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_Product_ByUpSellId_s]'
GO














CREATE PROCEDURE [dbo].[bvc_Product_ByUpSellId_s]

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
PRINT N'Creating [dbo].[bvc_Vendor_d]'
GO


CREATE PROCEDURE [dbo].[bvc_Vendor_d]

@bvin varchar(36)

AS
	BEGIN TRY

		UPDATE bvc_Product SET VendorID=0 WHERE VendorID=@bvin

		DELETE FROM bvc_UserXContact WHERE ContactId = @bvin

		DELETE bvc_Vendor WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoice_u]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoice_u]

@bvin varchar(36),
@ProductPropertyBvin varchar(36),
@ChoiceName nvarchar(512),
@SortOrder int

AS
	BEGIN TRY
		UPDATE bvc_ProductPropertyChoice		
		SET
		PropertyBvin=@ProductPropertyBvin,
		ChoiceName=@ChoiceName,
		SortOrder=@SortOrder,
		LastUpdated=GetDate()		
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_AffiliateQuestion_All_s]'
GO







CREATE PROCEDURE [dbo].[bvc_AffiliateQuestion_All_s]

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_AffiliateQuestions ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ProductID,Qty,DiscountType,Amount,LastUpdated
		FROM bvc_ProductVolumeDiscounts
		WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ProductInventory_All_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_All_s] 

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
PRINT N'Creating [dbo].[bvc_LineItem_d]'
GO



CREATE PROCEDURE [dbo].[bvc_LineItem_d]

@bvin varchar(36)

AS
	BEGIN TRY
		EXEC bvc_LineItemInput_ByLineItem_d @bvin
		EXEC bvc_LineItemModifier_ByLineItem_d @bvin		
		DELETE FROM bvc_LineItem WHERE bvin=@bvin 		

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_Category_AllProducts_d]'
GO









CREATE PROCEDURE [dbo].[bvc_Category_AllProducts_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_ProductXCategory WHERE CategoryID=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
RETURN

















GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoicesForProperty_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductPropertyChoicesForProperty_s]

@bvin as varchar(36)

AS
	BEGIN TRY
		SELECT bvin,PropertyBvin,ChoiceName,SortOrder,LastUpdated

		FROM bvc_ProductPropertyChoice

		WHERE PropertyBvin=@bvin

		ORDER By SortOrder
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
		bvin,ComponentID,DeveloperId,ComponentType,ComponentSubType,ListName,SortOrder,
		Setting1,Setting2,Setting3,Setting4,Setting5,
		Setting6,Setting7,Setting8,Setting9,Setting10,
		LastUpdated 
		FROM bvc_ComponentSettingList
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_UserQuestion_All_s]'
GO







CREATE PROCEDURE [dbo].[bvc_UserQuestion_All_s]

AS
	BEGIN TRY
		SELECT bvin, QuestionName, QuestionType, [Values], [Order], LastUpdated FROM bvc_UserQuestions ORDER BY [Order]
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

















GO
PRINT N'Creating [dbo].[bvc_CustomPage_ByShowInBottomMenu_s]'
GO




CREATE PROCEDURE [dbo].[bvc_CustomPage_ByShowInBottomMenu_s]

AS
	BEGIN TRY
		SELECT
		bvin,[Name],[Content],MenuName,ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated,MetaTitle,TemplateName,PreContentColumnId,PostContentColumnId
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
PRINT N'Creating [dbo].[bvc_WorkFlowStep_d]'
GO


CREATE PROCEDURE [dbo].[bvc_WorkFlowStep_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE bvc_ComponentSettingList WHERE componentID=@bvin
		DELETE bvc_ComponentSetting WHERE componentID=@bvin
		DELETE bvc_WorkFlowStep WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













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
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts_u]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscounts_u]

@bvin varchar(36),
@Qty int,
@DiscountType int,
@Amount numeric(18,10),
@ProductID varchar(36)

AS

	BEGIN TRY
		UPDATE bvc_ProductVolumeDiscounts
		SET
		Qty=@Qty,
		DiscountType=@DiscountType,
		Amount=@Amount,
		ProductID=@ProductID,
		LastUpdated=GetDate()
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Product_ProductsOrderedCount_s]'
GO









CREATE PROCEDURE [dbo].[bvc_Product_ProductsOrderedCount_s]

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
PRINT N'Creating [dbo].[bvc_ProductChoice_CountByProduct_s]'
GO














-- =============================================
-- Author:		Justin Etheredge
-- Create date: 8/11/2006
-- Description:	Gets count of choices for product
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_CountByProduct_s]
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
PRINT N'Creating [dbo].[bvc_ProductInventory_AllLowStock_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_AllLowStock_s] 

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
PRINT N'Creating [dbo].[bvc_Category_AllVisible_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_AllVisible_s]

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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
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
PRINT N'Creating [dbo].[bvc_OrderCoupon_UseTimesByStore_s]'
GO


CREATE PROCEDURE [dbo].[bvc_OrderCoupon_UseTimesByStore_s]

@couponCode nvarchar(50)

AS
	BEGIN TRY
		SELECT COUNT(*) As [Count] FROM bvc_Order JOIN bvc_OrderCoupon ON OrderBvin = bvc_Order.Bvin WHERE bvc_OrderCoupon.CouponCode = @couponCode AND bvc_Order.IsPlaced = 1
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH














GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_SortOrder_u]'
GO
CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_SortOrder_u]

@bvin varchar(36),
@SortOrder int

AS

	BEGIN TRY
		UPDATE bvc_ComponentSettingList
		SET
		SortOrder=@SortOrder,LastUpdated=GetDate()
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	












GO
PRINT N'Creating [dbo].[bvc_ProductUpSell_Count_s]'
GO





-- =============================================
-- Author:		Justin Etheredge
-- Create date: 04/17/2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductUpSell_Count_s] 
	
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
PRINT N'Creating [dbo].[bvc_CustomPage_d]'
GO


CREATE PROCEDURE [dbo].[bvc_CustomPage_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_CustomPage WHERE bvin=@bvin
		DELETE FROM bvc_CustomUrl WHERE SystemData=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



















GO
PRINT N'Creating [dbo].[bvc_WorkFlowStep_i]'
GO


CREATE PROCEDURE [dbo].[bvc_WorkFlowStep_i]

@bvin varchar(36),
@WorkFlowBvin varchar(36),
@SortOrder int,
@ControlName nvarchar(512),
@DisplayName nvarchar(512),
@StepName nvarchar(512)

AS

	BEGIN TRY
		IF (Select Count(bvin) FROM bvc_WorkFlowStep WHERE WorkFlowBvin=@WorkFlowBvin) > 0
			BEGIN
			SET @SortOrder = (Select Max(SortOrder) FROM bvc_WorkFlowStep WHERE WorkFlowBvin=@WorkFlowBvin)+1
			END
		ELSE
			BEGIN
			SET @SortOrder = 1
			END
			
			
		INSERT INTO bvc_WorkFlowStep
		(
		bvin,
		WorkFlowBvin,
		SortOrder,
		ControlName,
		DisplayName,
		StepName,
		LastUpdated
		)
		VALUES
		(
		@bvin,
		@WorkFlowBvin,
		@SortOrder,
		@ControlName,
		@DisplayName,
		@StepName,
		GetDate()
		)
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_Product_SuggestedItems]'
GO
CREATE PROCEDURE [dbo].[bvc_Product_SuggestedItems]

@MaxResults bigint,
@bvin varchar(36)

AS

	BEGIN TRY		
		--IF EXISTS(SELECT * FROM bvc_Product WHERE ParentId = @bvin)
		--BEGIN
		--	SELECT TOP(@MaxResults)
		--		a.ProductID, SUM(a.Quantity) AS "Total Ordered"
		--		FROM 
		--		(					
		--			SELECT 
		--				CASE p.ParentId
		--					WHEN '' THEN p.bvin
		--					ELSE p.ParentId
		--				END AS ProductID, 
		--				Quantity
		--			FROM bvc_LineItem l
		--			JOIN bvc_Order o on l.OrderBvin = o.bvin
		--			JOIN bvc_Product p ON p.bvin = l.ProductId
		--			WHERE o.IsPlaced = 1 AND dbo.bvc_ProductAvailableAndActive(ProductID, 0) = 1
		--			AND	OrderBvin IN
		--			(SELECT OrderBvin
		--				FROM bvc_LineItem
		--				WHERE ProductID IN (SELECT bvin FROM bvc_Product WHERE ParentId = @bvin))
		--		) AS a
		--		GROUP BY a.ProductID
		--		ORDER BY SUM(a.Quantity) DESC
		--END
		--ELSE
		--BEGIN
		--	SELECT TOP(@MaxResults)
		--		a.ProductID, SUM(a.Quantity) AS "Total Ordered"
		--		FROM 
		--		(
		--			SELECT 
		--				CASE p.ParentId
		--					WHEN '' THEN p.bvin
		--					ELSE p.ParentId
		--				END AS ProductID, 
		--				Quantity
		--			FROM bvc_LineItem l
		--			JOIN bvc_Order o on l.OrderBvin = o.bvin 
		--			JOIN bvc_Product p ON p.bvin = l.ProductId
		--			WHERE o.IsPlaced = 1 AND dbo.bvc_ProductAvailableAndActive(ProductID, 0) = 1
		--			AND	OrderBvin IN
		--			(SELECT OrderBvin
		--				FROM bvc_LineItem
		--				WHERE ProductID = @bvin)
		--		) AS a
		--		GROUP BY a.ProductID
		--		ORDER BY SUM(a.Quantity) DESC			
		--END
		
		DECLARE @parentBvin AS VARCHAR(36)
		SET @parentBvin = (SELECT ParentID FROM bvc_Product WHERE bvin = @bvin)
		IF @parentBvin = '' SET @parentBvin = @bvin
			
		SELECT TOP(@MaxResults)
			tbl.ProductID, 
			SUM(tbl.Quantity) AS "Total Ordered"
			FROM (
				SELECT 
					CASE p.ParentId
						WHEN '' THEN p.bvin
						ELSE p.ParentId
					END AS ProductID, 
					Quantity
				FROM bvc_LineItem AS l
				JOIN bvc_Product AS p ON p.bvin = l.ProductId
				WHERE
					l.ProductId <> @bvin
					AND	OrderBvin IN (
						SELECT OrderBvin
						FROM bvc_LineItem AS li
						JOIN bvc_Order AS o on li.OrderBvin = o.bvin 
						WHERE 
							o.IsPlaced = 1
							AND li.ProductID = @bvin
					)
			) AS tbl
		GROUP BY tbl.ProductID
		ORDER BY "Total Ordered" DESC
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscountsByProduct_s]'
GO


CREATE PROCEDURE [dbo].[bvc_ProductVolumeDiscountsByProduct_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ProductID,Qty,DiscountType,Amount,LastUpdated
		FROM bvc_ProductVolumeDiscounts
		WHERE ProductID=@bvin
		ORDER BY Qty ASC
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_LineItem_s]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItem_s]
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
PRINT N'Creating [dbo].[bvc_LineItemInput_i]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItemInput_i]
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
PRINT N'Creating [dbo].[bvc_ProductInventory_ByProductId_d]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_ByProductId_d] 
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductInventory WHERE ProductBvin IN (SELECT bvin FROM bvc_Product WHERE ParentId = @bvin)
		DELETE FROM bvc_ProductInventory WHERE ProductBvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END












GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList_u]'
GO

CREATE PROCEDURE [dbo].[bvc_ComponentSettingList_u]

@bvin varchar(36),
@ComponentID varchar(36),
@DeveloperId nvarchar(15),
@ComponentType nvarchar(25),
@ComponentSubType nvarchar(25),
@ListName nvarchar(255),
@SortOrder int,
@Setting1 nvarchar(Max),
@Setting2 nvarchar(Max),
@Setting3 nvarchar(Max),
@Setting4 nvarchar(Max),
@Setting5 nvarchar(Max),
@Setting6 nvarchar(Max),
@Setting7 nvarchar(Max),
@Setting8 nvarchar(Max),
@Setting9 nvarchar(Max),
@Setting10 nvarchar(Max)

AS
	
	BEGIN TRY
		UPDATE bvc_ComponentSettingList
		SET
		
		bvin=@bvin,
		ComponentID=@ComponentID,
		DeveloperId=@DeveloperId,
		ComponentType=@ComponentType,
		ComponentSubType=@ComponentSubType,
		SortOrder=@SortOrder,
		ListName=@ListName,
		Setting1=@Setting1,
		Setting2=@Setting2,
		Setting3=@Setting3,
		Setting4=@Setting4,
		Setting5=@Setting5,
		Setting6=@Setting6,
		Setting7=@Setting7,
		Setting8=@Setting8,
		Setting9=@Setting9,
		Setting10=@Setting10,
		LastUpdated=GetDate()
		
		WHERE bvin=@bvin
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_WishList_ForUser_s]'
GO

CREATE PROCEDURE [dbo].[bvc_WishList_ForUser_s]
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
PRINT N'Creating [dbo].[bvc_Category_ByType_s]'
GO
CREATE PROCEDURE [dbo].[bvc_Category_ByType_s]

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
		CustomerChangeableSortOrder,
		ShortDescription,
		CustomProperties
		FROM bvc_Category
		WHERE SourceType = @type
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

GO
PRINT N'Creating [dbo].[bvc_OrderCoupon_UseTimesByUserId_s]'
GO



CREATE PROCEDURE [dbo].[bvc_OrderCoupon_UseTimesByUserId_s]

@userid nvarchar(100),
@couponCode nvarchar(50)

AS
	BEGIN TRY
		SELECT COUNT(*) As [Count] FROM bvc_Order JOIN bvc_OrderCoupon ON OrderBvin = bvc_Order.Bvin WHERE UserId = @userid AND bvc_OrderCoupon.CouponCode = @couponCode AND bvc_Order.IsPlaced = 1
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH















GO
PRINT N'Creating [dbo].[bvc_WorkFlowStep_s]'
GO


CREATE PROCEDURE [dbo].[bvc_WorkFlowStep_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,WorkFlowBvin,SortOrder,ControlName,DisplayName,StepName,LastUpdated 
		FROM bvc_WorkFlowStep
		WHERE bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH













GO
PRINT N'Creating [dbo].[bvc_WishList_s]'
GO

CREATE PROCEDURE [dbo].[bvc_WishList_s]	
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
PRINT N'Creating [dbo].[bvc_CustomPage_i]'
GO



CREATE PROCEDURE [dbo].[bvc_CustomPage_i]

@bvin varchar(36),
@Name nvarchar(255),
@MenuName nvarchar(100),
@Content ntext,
@ShowInTopMenu int = 0,
@ShowInBottomMenu int = 1,
@PreTransformContent ntext,
@MetaDescription nvarchar(255),
@MetaKeywords nvarchar(255),
@MetaTitle nvarchar(512),
@TemplateName nvarchar(512),
@PreContentColumnId nvarchar(36),
@PostContentColumnId nvarchar(36)

AS
	BEGIN TRY
		INSERT INTO
		bvc_CustomPage
		(bvin,[Name],MenuName,[Content],
		ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated,MetaTitle,TemplateName,PreContentColumnId,PostContentColumnId)

		VALUES(@bvin,@Name,@MenuName,@Content,
		@ShowInTopMenu,@ShowInBottomMenu,@PreTransformContent,@MetaDescription,@MetaKeywords,GetDate(),@MetaTitle,@TemplateName,@PreContentColumnId,@PostContentColumnId)

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH












GO
PRINT N'Creating [dbo].[bvc_WorkFlow_ByName_s]'
GO



CREATE PROCEDURE [dbo].[bvc_WorkFlow_ByName_s] 

	@Name nvarchar(255)

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @bvin varchar(36)
		SET @bvin = (SELECT bvin from bvc_WorkFlow WHERE [name]=@name)

    	SELECT bvin,ContextType,[Name],SystemWorkFlow,LastUpdated 
		FROM bvc_WorkFlow
		WHERE [Name]=@Name

		EXEC bvc_WorkFlowStep_ByWorkFlowID_s @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END
















GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscountsByQtyForProduct_s]'
GO



CREATE  PROCEDURE [dbo].[bvc_ProductVolumeDiscountsByQtyForProduct_s]

@ProductID varchar(36),
@Qty int

AS

	BEGIN TRY
		SELECT TOP 1  bvin,ProductID,Qty,DiscountType,Amount,LastUpdated
		FROM bvc_ProductVolumeDiscounts
		WHERE ProductID=@ProductID
		AND Qty <= @Qty
		ORDER BY Qty Desc
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_Role_s]'
GO




CREATE PROCEDURE [dbo].[bvc_Role_s]

@bvin varchar(36)

AS

	BEGIN TRY
		SELECT bvin,RoleName,SystemRole,LastUpdated FROM bvc_Role WHERE bvin=@bvin
		exec bvc_RolePermission_ByRoleID_s @bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


















GO
PRINT N'Creating [dbo].[bvc_ProductChoice_i ]'
GO


-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Inserts a Product Choice Group
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_i ]
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
PRINT N'Creating [dbo].[bvc_ProductInventory_ByProductId_s]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_ByProductId_s] 
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
PRINT N'Creating [dbo].[bvc_Order_d]'
GO






CREATE PROCEDURE [dbo].[bvc_Order_d]

@bvin varchar(36)

AS
BEGIN TRY

	BEGIN TRANSACTION

		exec bvc_OrderCoupon_ByOrderBvin_d @bvin
		
		DELETE FROM bvc_OrderPayment WHERE OrderId = @bvin
		DELETE FROM bvc_OrderPackage WHERE OrderId = @bvin
		DELETE FROM bvc_OrderNote WHERE OrderId=@bvin
		DELETE FROM bvc_OrderCoupon WHERE OrderBvin=@bvin
		DELETE FROM bvc_DropShipNotification WHERE OrderBvin = @bvin				
		EXEC bvc_LineItem_ByOrderId_d @bvin
				
		DELETE bvc_Order WHERE bvin=@bvin
		
	COMMIT
END TRY
BEGIN CATCH
	IF XACT_STATE() <> 0
		ROLLBACK TRANSACTION
	EXEC bvc_EventLog_SQL_i
	RETURN 0
END CATCH

RETURN 
	




















GO
PRINT N'Creating [dbo].[bvc_LineItemInput_u]'
GO

CREATE PROCEDURE [dbo].[bvc_LineItemInput_u]
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
PRINT N'Creating [dbo].[bvc_CustomPage_s]'
GO




CREATE PROCEDURE [dbo].[bvc_CustomPage_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT
		bvin,[Name],[Content],MenuName,ShowInTopMenu,ShowInBottomMenu,PreTransformContent,MetaDescription,MetaKeywords,LastUpdated,MetaTitle,TemplateName,PreContentColumnId,PostContentColumnId
		FROM
		bvc_CustomPage
		WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH





















GO
PRINT N'Creating [dbo].[bvc_Product_d]'
GO








CREATE PROCEDURE [dbo].[bvc_Product_d]

@bvin varchar(36),
@deleteProductChoices bit = 1

AS

BEGIN
	DECLARE @Ids Table (
		ProductId varchar(36) COLLATE SQL_Latin1_General_CP1_CI_AS
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
PRINT N'Creating [dbo].[bvc_Category_d]'
GO








CREATE PROCEDURE [dbo].[bvc_Category_d]

@bvin varchar(36)

AS
	BEGIN TRY

		DELETE FROM bvc_ProductXCategory WHERE CategoryID=@bvin

		DELETE FROM bvc_SaleXCategory WHERE CategoryID=@bvin

		DELETE FROM bvc_CustomUrl WHERE SystemData=@bvin

		DELETE FROM bvc_Category WHERE bvin=@bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
















GO
PRINT N'Creating [dbo].[bvc_WorkFlowStep_SortOrder_u]'
GO
CREATE PROCEDURE [dbo].[bvc_WorkFlowStep_SortOrder_u]

@bvin varchar(36),
@SortOrder int

AS

	BEGIN TRY
		UPDATE bvc_WorkFlowStep
		SET
		SortOrder=@SortOrder,LastUpdated=GetDate()
		WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	












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
PRINT N'Creating [dbo].[bvc_ProductInventory_d]'
GO
-- =============================================
-- Author:		BV Software
-- Create date: Jan 2006
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductInventory_d] 
	-- Add the parameters for the stored procedure here
	@bvin varchar(36)
AS
BEGIN
	BEGIN TRY
		DELETE FROM bvc_ProductInventory WHERE bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END











GO
PRINT N'Creating [dbo].[bvc_Affiliate_d]'
GO




CREATE PROCEDURE [dbo].[bvc_Affiliate_d]

@bvin varchar(50)

AS	
	BEGIN TRY
		BEGIN TRANSACTION

		EXEC bvc_AffiliateReferral_ByAffiliate_d @bvin

		DELETE FROM bvc_UserXContact WHERE ContactId = @bvin

		DELETE bvc_Affiliate WHERE bvin=@bvin			
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH

   RETURN 











GO
PRINT N'Creating [dbo].[bvc_ProductXCategory_ByCategory_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductXCategory_ByCategory_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT categoryId,productId,SortOrder
		FROM bvc_ProductXCategory
		WHERE categoryId=@bvin
		ORDER BY SortOrder

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH











GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValues_ForProduct_s]'
GO
CREATE PROCEDURE [dbo].[bvc_ProductPropertyValues_ForProduct_s]
(
@ProductBvin varchar(36),
@TypeBvin varchar(36)
)
AS
	BEGIN
	
	BEGIN TRY
		SET @TypeBvin = (SELECT ProductTypeId FROM bvc_Product Where [Bvin]=@ProductBvin)
		
		SELECT ProductBvin,PropertyBvin,PropertyValue FROM bvc_ProductPropertyValue WHERE
		ProductBvin=@ProductBvin AND
		PropertyBvin IN (SELECT ProductPropertyBvin FROM bvc_ProductTypeXProductProperty WHERE ProductTypeBvin = @TypeBvin)
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
	
	
	END
	/* SET NOCOUNT ON */
	RETURN



GO
PRINT N'Creating [dbo].[bvc_Product_BySku_s]'
GO











CREATE PROCEDURE [dbo].[bvc_Product_BySku_s]

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
PRINT N'Creating [dbo].[bvc_ProductChoice_d ]'
GO







-- =============================================
-- Author:		Justin Etheredge
-- Create date: 3/3/2006
-- Description:	Deletes a Product Choice Group
-- =============================================
CREATE PROCEDURE [dbo].[bvc_ProductChoice_d ]	
	@bvin varchar(36)
AS
BEGIN
	DECLARE @ProductIds Table (
		ProductId varchar(36) COLLATE SQL_Latin1_General_CP1_CI_AS
	)
	
	BEGIN TRANSACTION

	BEGIN TRY		
		INSERT INTO @ProductIds SELECT DISTINCT ProductId FROM bvc_ProductChoiceCombinations WHERE ChoiceId = @bvin
		--declare cursor for use below
		DECLARE @currbvin varchar(36)
		DECLARE ProductChoice_d CURSOR LOCAL
			FOR SELECT * FROM @ProductIds		

		OPEN ProductChoice_d
		FETCH NEXT FROM ProductChoice_d	INTO @currbvin
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC bvc_Product_d 
				@bvin = @currbvin, 
				@deleteProductChoices = 0
			FETCH NEXT FROM ProductChoice_d	INTO @currbvin
		END
		CLOSE ProductChoice_d
		DEALLOCATE ProductChoice_d

		DELETE FROM bvc_ComponentSettingList WHERE componentID=@bvin			
		DELETE FROM bvc_ComponentSetting WHERE componentID=@bvin

		DELETE FROM bvc_ProductChoiceCombinations WHERE ProductId IN (SELECT ProductId FROM @ProductIds)
		DELETE FROM bvc_ProductXChoice WHERE ChoiceId = @bvin		
		DELETE FROM bvc_ProductChoiceOptions WHERE ProductChoiceId = @bvin
		DELETE FROM bvc_ProductChoices WHERE bvin = @bvin
		DELETE FROM bvc_ProductChoiceInputOrder WHERE ChoiceInputId = @bvin
	
		
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		--cursor cleanup
		IF CURSOR_STATUS('local', 'ProductChoice_d') > -1
			CLOSE ProductChoice_d
		
		IF CURSOR_STATUS('local', 'ProductChoice_d') = -1
			DEALLOCATE ProductChoice_d
			
		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION

		EXEC bvc_EventLog_SQL_i
	END CATCH	
END
























GO
PRINT N'Creating [dbo].[bvc_Taxes_s]'
GO




CREATE PROCEDURE [dbo].[bvc_Taxes_s]

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
PRINT N'Creating [dbo].[bvc_Product_All_d]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_All_d]

AS

BEGIN
	DECLARE @err int

	DECLARE @Ids2 Table (
		ProductId varchar(36) COLLATE SQL_Latin1_General_CP1_CI_AS
	)

	BEGIN TRY
	
		BEGIN TRANSACTION
						
			--declare cursor for use below
			DECLARE @currbvinproduct varchar(36)
			DECLARE bvinproduct_cursor CURSOR LOCAL
				FOR SELECT * FROM @Ids2
			
			BEGIN
				--delete out all of our product choices
				INSERT INTO @Ids2 SELECT DISTINCT bvin FROM bvc_Product WHERE ParentId=''
				OPEN bvinproduct_cursor
				FETCH NEXT FROM bvinproduct_cursor	INTO @currbvinproduct
		
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC bvc_Product_d @currbvinproduct, 1
					FETCH NEXT FROM bvinproduct_cursor	INTO @currbvinproduct
				END
				CLOSE bvinproduct_cursor
				DEALLOCATE bvinproduct_cursor

				DELETE bvc_ProductChoiceInputOrder
				DELETE bvc_ProductPropertyValue
				DELETE bvc_ProductCrossSell
				DELETE bvc_ProductUpSell
				DELETE bvc_ProductChoiceCombinations
				DELETE bvc_ProductChoiceOptions
				DELETE bvc_ProductChoices
				DELETE bvc_ProductFile
				DELETE bvc_ProductModifierOption
				DELETE bvc_ProductModifier				
				DELETE bvc_ProductInputs
				


			END
					
			COMMIT
	END TRY

	BEGIN CATCH
		--cursor cleanup
		IF CURSOR_STATUS('local', 'bvinproduct_cursor') > -1
			CLOSE bvinproduct_cursor
		
		IF CURSOR_STATUS('local', 'bvinproduct_cursor') = -1
			DEALLOCATE bvinproduct_cursor

		IF XACT_STATE() <> 0
			ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
		RETURN 0
	END CATCH

END

RETURN




GO
PRINT N'Creating [dbo].[bvc_RolePermission_ByUserID_s]'
GO


CREATE PROCEDURE [dbo].[bvc_RolePermission_ByUserID_s]

	@bvin varchar(36)

AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY	
		IF EXISTS(SELECT UserId FROM bvc_UserXRole WHERE UserId=@bvin AND RoleId='36CC0F07-2DE4-4d25-BF60-C80BC0214F09')
			BEGIN
				SELECT bvin,[Name],SystemPermission,LastUpdated 
				FROM bvc_RolePermission
				ORDER BY [Name]
			END
		ELSE
			BEGIN
				SELECT bvin,[Name],SystemPermission,LastUpdated 
				FROM bvc_RolePermission
				WHERE bvin IN (
						SELECT PermissionID FROM bvc_RoleXRolePermission WHERE RoleID IN
							(
							SELECT RoleID FROM bvc_UserXRole WHERE UserID=@bvin
							)
						)
			END
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH
END












GO
PRINT N'Creating [dbo].[bvc_ProductType_Available_Properties_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ProductType_Available_Properties_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT 
			bvin,
			PropertyName,
			DisplayName,
			DisplayOnSite,
			DisplayToDropShipper,
			TypeCode,
			DefaultValue,
			CultureCode,
			LastUpdated

		FROM bvc_ProductProperty

		WHERE bvin NOT IN (SELECT ProductPropertyBvin FROM bvc_ProductTypeXProductProperty WHERE ProductTypeBvin=@bvin) 

		ORDER BY PropertyName
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN






GO
PRINT N'Creating [dbo].[bvc_Order_ByLineItemStatus_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Order_ByLineItemStatus_s]

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
PRINT N'Creating [dbo].[bvc_LineItem_ByOrderId_d]'
GO





CREATE PROCEDURE [dbo].[bvc_LineItem_ByOrderId_d]

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
PRINT N'Creating [dbo].[bvc_ProductProperty_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ProductProperty_d]

@bvin as varchar(36)

AS

	BEGIN TRY
		DELETE FROM bvc_ProductPropertyChoice WHERE PropertyBvin=@bvin
		DELETE FROM bvc_ProductTypeXProductProperty Where ProductPropertyBvin=@bvin
		DELETE FROM bvc_ProductPropertyValue WHERE PropertyBvin=@bvin
		DELETE FROM bvc_ProductProperty WHERE Bvin=@bvin
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH

	RETURN





GO
PRINT N'Creating [dbo].[bvc_ShoppingCart_d]'
GO





CREATE PROCEDURE [dbo].[bvc_ShoppingCart_d]

@bvin varchar(36)

AS
	BEGIN TRY
		BEGIN TRANSACTION
			DELETE FROM bvc_ShoppingCartItem WHERE ShoppingCartBvin=@bvin 
			DELETE bvc_ShoppingCart WHERE bvin=@bvin
		COMMIT TRANSACTION

		RETURN 
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		EXEC bvc_EventLog_SQL_i
	END CATCH
	











GO
PRINT N'Creating [dbo].[bvc_ShoppingCart_i]'
GO



CREATE PROCEDURE [dbo].[bvc_ShoppingCart_i]
@bvin varchar(36)

AS
	BEGIN TRY
		INSERT INTO
		bvc_ShoppingCart
		(bvin,LastUpdated)
		VALUES
		(@bvin,GetDate())
	
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ShoppingCartItem_ByShoppingCartId_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ShoppingCartItem_ByShoppingCartId_s]

@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ProductId,Quantity,ShoppingCartBvin,LastUpdated FROM bvc_ShoppingCartItem
			WHERE  ShoppingCartBvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ShoppingCart_u]'
GO


CREATE PROCEDURE [dbo].[bvc_ShoppingCart_u]
@bvin varchar(36)

AS
	BEGIN TRY	
		UPDATE
			bvc_ShoppingCart
		SET
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ShoppingCartItem_d]'
GO



CREATE PROCEDURE [dbo].[bvc_ShoppingCartItem_d]

@bvin varchar(36)

AS
	BEGIN TRY
		DELETE FROM bvc_ShoppingCartItem WHERE bvin=@bvin 
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ShoppingCartItem_i]'
GO



CREATE PROCEDURE [dbo].[bvc_ShoppingCartItem_i]
@bvin varchar(36),
@ProductId nvarchar(36),
@Quantity Decimal(18,4),
@ShoppingCartBvin nvarchar(36)

AS
	BEGIN TRY
		INSERT INTO
		bvc_ShoppingCartItem
		(bvin,ProductId,Quantity,ShoppingCartBvin,LastUpdated)
		VALUES
		(@bvin,@ProductId,@Quantity,@ShoppingCartBvin,GetDate())
		
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH








GO
PRINT N'Creating [dbo].[bvc_ShoppingCartItem_s]'
GO



CREATE PROCEDURE [dbo].[bvc_ShoppingCartItem_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,ProductId,Quantity,ShoppingCartBvin,LastUpdated FROM bvc_ShoppingCartItem
			WHERE  bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ShoppingCartItem_u]'
GO


CREATE PROCEDURE [dbo].[bvc_ShoppingCartItem_u]
@bvin varchar(36),
@ProductId nvarchar(36),
@Quantity Decimal(18,4),
@ShoppingCartBvin nvarchar(36)

AS
	BEGIN TRY
		UPDATE
			bvc_ShoppingCartItem
		SET
		ProductId=@ProductId,
		Quantity=@Quantity,
		ShoppingCartBvin=@ShoppingCartBvin,
		LastUpdated=GetDate()
		WHERE
		bvin=@bvin
		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH









GO
PRINT N'Creating [dbo].[bvc_ShoppingCart_s]'
GO




CREATE PROCEDURE [dbo].[bvc_ShoppingCart_s]
@bvin varchar(36)

AS
	BEGIN TRY
		SELECT bvin,LastUpdated FROM bvc_ShoppingCart
			WHERE  bvin=@bvin

		exec bvc_ShoppingCartItem_ByShoppingCartId_s @bvin

		RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH










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
PRINT N'Creating [dbo].[bvc_Category_Trail_s]'
GO

CREATE PROC [dbo].[bvc_Category_Trail_s]
	@bvin VARCHAR(36)

AS

BEGIN TRY
	;WITH CategoryTrail AS (
		-- anchor query         
		SELECT
			[Name],
			[Description],
			bvin,
			ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) AS ItemCount*/
			(SELECT '0') AS ItemCount,
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
		FROM bvc_Category
		WHERE bvin = @bvin    
		
		UNION ALL
		
		-- recursive query
		SELECT 
			c.[Name],
			c.[Description],
			c.bvin,
			c.ParentID,
			/*(Select Count(ProductID) FROM  bvc_ProductXCategory join bvc_Product
			ON bvc_ProductXCategory.ProductID = bvc_Product.Bvin
			WHERE CategoryID=@bvin AND bvc_Product.Status=1) AS c.ItemCount*/
			(SELECT '0') AS ItemCount,
			c.SortOrder,
			c.MetaKeywords,
			c.MetaDescription,
			c.ImageURL,
			c.SourceType,
			c.DisplaySortOrder,
			c.MetaTitle,
			c.BannerImageURL,
			c.LatestProductCount,	
			c.CustomPageURL,
			c.CustomPageNewWindow,
			c.MenuOffImageURL,
			c.MenuOnImageURL,	
			c.ShowInTopMenu,
			c.Hidden,
			c.LastUpdated,
			c.TemplateName,
			c.PostContentColumnId,
			c.PreContentColumnId,
			c.RewriteUrl,
			c.ShowTitle,
			c.Criteria,
			c.CustomPageId,
			c.PreTransformDescription,
			c.Keywords,
			c.CustomerChangeableSortOrder,
			c.ShortDescription,
			c.CustomProperties
		FROM bvc_Category AS c
		INNER JOIN CategoryTrail ON CategoryTrail.ParentID = c.bvin
	)
	SELECT * FROM CategoryTrail

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH



GO
PRINT N'Creating [dbo].[bvc_Category_ByCustomUrl_s]'
GO

CREATE PROC [dbo].[bvc_Category_ByCustomUrl_s]
	@CustomPageURL nvarchar(512)
AS

BEGIN TRY
	-- if @CustomPageURL is blank or ends with a '/', look for URL's with and without 'default.aspx'
	IF LEN(@CustomPageURL) = 0 OR SUBSTRING(@CustomPageURL, LEN(@CustomPageURL), 1) = '/' 
	BEGIN
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
		FROM bvc_Category
		WHERE
			SourceType = 2
			AND (
				CustomPageURL = @CustomPageURL
				OR CustomPageURL = '/' + @CustomPageURL
				OR CustomPageURL = @CustomPageURL + 'default.aspx'
				OR CustomPageURL = '/' + @CustomPageURL + 'default.aspx')
		RETURN
	END

	ELSE
	BEGIN
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
			CustomerChangeableSortOrder,
			ShortDescription,
			CustomProperties
		FROM bvc_Category
		WHERE
			SourceType = 2
			AND (
				CustomPageURL = @CustomPageURL
				OR CustomPageURL = '/' + @CustomPageURL)
		RETURN
	END
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH



GO
PRINT N'Creating [dbo].[bvc_Category_ByCustomPage_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Category_ByCustomPage_s]
	@CustomPageId varchar(36)
AS

BEGIN TRY
	SELECT
		[Name],
		[Description],
		bvin,
		ParentID,
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
		CustomerChangeableSortOrder,
		ShortDescription,
		CustomProperties
	FROM bvc_Category
	WHERE
		SourceType = 3
		AND CustomPageId = @CustomPageId
	RETURN
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
PRINT N'Creating [dbo].[bvc_Product_TopSellers_ByCategory_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_TopSellers_ByCategory_s]
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
PRINT N'Creating [dbo].[bvc_Product_TopSellers_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_TopSellers_s]
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
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_s]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_s
	@bvin varchar(36)

AS

BEGIN TRY
	
	SELECT *
	FROM bvc_LoyaltyPoints
	WHERE bvin = @bvin

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_ByCriteria_s]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_ByCriteria_s
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
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_i]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_i
	@bvin varchar(36),
	@UserId varchar(36),
	@OrderId varchar(36),
	@PointsType int,
	@PointsAdjustment int,
	@PointsRemaining int,
	@Expires int,
	@ExpirationDate datetime,
	@CustomProperties nvarchar(max),
	@CreationDate datetime,
	@LastUpdated datetime

AS

BEGIN TRY
	
	INSERT INTO bvc_LoyaltyPoints(
		bvin,
		UserId,
		OrderId,
		PointsType,
		PointsAdjustment,
		PointsRemaining,
		Expires,
		ExpirationDate,
		CustomProperties,
		CreationDate,
		LastUpdated
	)
	VALUES(
		@bvin,
		@UserId,
		@OrderId,
		@PointsType,
		@PointsAdjustment,
		@PointsRemaining,
		@Expires,
		@ExpirationDate,
		@CustomProperties,
		@CreationDate,
		@LastUpdated
	)

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_u]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_u
	@bvin varchar(36),
	@UserId varchar(36),
	@OrderId varchar(36),
	@PointsType int,
	@PointsAdjustment int,
	@PointsRemaining int,
	@Expires int,
	@ExpirationDate datetime,
	@CustomProperties nvarchar(max),
	@CreationDate datetime,
	@LastUpdated datetime
AS

BEGIN TRY
	
	UPDATE bvc_LoyaltyPoints
	SET
		UserId = @UserId,
		OrderId = @OrderId,
		PointsType = @PointsType,
		PointsAdjustment = @PointsAdjustment,
		PointsRemaining = @PointsRemaining,
		Expires = @Expires,
		ExpirationDate = @ExpirationDate,
		CustomProperties = @CustomProperties,
		CreationDate = @CreationDate,
		LastUpdated = @LastUpdated
	WHERE bvin = @bvin

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_d]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_d
	@bvin varchar(36)
AS

BEGIN TRY
	
	DELETE
	FROM bvc_LoyaltyPoints
	WHERE bvin = @bvin

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_ByUserId_d]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_ByUserId_d
	@bvin varchar(36)
AS

BEGIN TRY
	
	DELETE
	FROM bvc_LoyaltyPoints
	WHERE UserId = @bvin

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_ByOrderId_d]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_ByOrderId_d
	@bvin varchar(36)
AS

BEGIN TRY
	
	DELETE
	FROM bvc_LoyaltyPoints
	WHERE OrderId = @bvin

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_Available_ByUser_s]'
GO

CREATE PROCEDURE bvc_LoyaltyPoints_Available_ByUser_s
	@bvin varchar(36)
AS

BEGIN TRY
	
	SELECT SUM(PointsAdjustment) AS PointsAdjustment
	FROM bvc_LoyaltyPoints
	WHERE 
		UserId = @bvin
		AND ExpirationDate > GETDATE()
	
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH
GO


GO
PRINT N'Creating [dbo].[bvc_CartCleanup_s]'
GO

CREATE PROCEDURE [dbo].[bvc_CartCleanup_s]
	@OlderThanDate DATETIME = NULL

AS

BEGIN TRY
	IF @OlderThanDate IS NULL
	BEGIN
		SET @OlderThanDate = (
			SELECT DATEADD(d, -1 * CONVERT(INTEGER, SettingValue), GETDATE())
			FROM bvc_WebAppSetting
			WHERE SettingName = 'CartCleanupDaysOld'
		)
	END

	SELECT bvin
	FROM bvc_Order
	WHERE
		IsPlaced = 0
		AND TimeOfOrder < @OlderThanDate
END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH


GO
PRINT N'Creating [dbo].[bvc_ProductType_TopSellers_s]'
GO

CREATE PROCEDURE [dbo].[bvc_ProductType_TopSellers_s]
	@StartDate datetime = NULL,
	@EndDate datetime = NULL
AS

	BEGIN TRY
		
		SELECT
			ProductTypeName,
			SUM(LineQuantity) AS Quantity, 
			SUM(LineTotal) AS Total
		FROM (
			SELECT	
				li.Quantity AS LineQuantity,
				li.LineTotal,
				pt.Bvin AS ProductTypeId,
				CASE WHEN pt.ProductTypeName IS NULL AND p.bvin IS NULL THEN '[DELETED PRODUCTS]' WHEN pt.ProductTypeName IS NULL THEN 'Generic' ELSE pt.ProductTypeName END AS ProductTypeName
			FROM	bvc_LineItem AS li
			LEFT JOIN bvc_Product AS p ON li.ProductId = p.Bvin
			LEFT JOIN bvc_ProductType AS pt ON p.ProductTypeId = pt.Bvin
			JOIN bvc_Order AS o ON li.OrderBvin = o.Bvin
			WHERE	
				(@StartDate IS NULL OR o.TimeOfOrder >= @StartDate) 
				AND (@EndDate IS NULL OR o.TimeOfOrder <= @EndDate)
				AND	o.IsPlaced = 1
		) AS tbl
		GROUP BY ProductTypeId, ProductTypeName
		ORDER BY Total DESC

      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_Manufacturer_TopSellers_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Manufacturer_TopSellers_s]
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
PRINT N'Creating [dbo].[bvc_UserAccount_DuplicateEmail_s]'
GO

CREATE PROCEDURE [dbo].[bvc_UserAccount_DuplicateEmail_s]
AS

	BEGIN TRY
		
		SELECT Email
		FROM (
			SELECT Email, COUNT(*) AS Cnt
			FROM bvc_User
			WHERE Email <> ''''
			GROUP BY Email	
		) AS tbl
		WHERE Cnt > 1
		ORDER BY Email

      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_Order_MergeAnonymous_u]'
GO

CREATE PROCEDURE [dbo].[bvc_Order_MergeAnonymous_u]
	@SourceEmail nvarchar(100) = NULL,
	@DestinationUserBvin nvarchar(36) = NULL

AS

	BEGIN TRY
		
		IF @SourceEmail IS NULL AND @DestinationUserBvin IS NULL
		BEGIN
			UPDATE o
			SET
				o.UserId = u.bvin
			FROM bvc_Order AS o
			JOIN bvc_User AS u ON u.Email = o.UserEmail
			WHERE
				o.UserId = ''
				AND o.UserEmail <> ''
		END
		
		ELSE IF LEN(@SourceEmail) > 0 AND LEN(@DestinationUserBvin) > 0
		BEGIN
			UPDATE bvc_Order
			SET
				UserId = @DestinationUserBvin
			WHERE
				UserId = ''
				AND UserEmail = @SourceEmail
		END

      RETURN
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UserAccount_ByEmail_All_s]'
GO

CREATE PROCEDURE [dbo].[bvc_UserAccount_ByEmail_All_s]
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
PRINT N'Creating [dbo].[bvc_UrlRedirect_ByRequestedUrl_s]'
GO



CREATE PROCEDURE [dbo].[bvc_UrlRedirect_ByRequestedUrl_s]
	@RequestedUrl nvarchar(2000)
AS

	BEGIN TRY

		SELECT * 
		FROM bvc_UrlRedirect 
		WHERE RequestedUrl = @RequestedUrl
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_s]'
GO



CREATE PROCEDURE [dbo].[bvc_UrlRedirect_s]
	@bvin varchar(36)
AS

	BEGIN TRY
		
		SELECT * 
		FROM bvc_UrlRedirect 
		WHERE bvin = @bvin
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_All_s]'
GO



CREATE PROCEDURE [dbo].[bvc_UrlRedirect_All_s]
AS

	BEGIN TRY

		SELECT * 
		FROM bvc_UrlRedirect
		ORDER BY RequestedUrl
			
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_FindAllRegex_s]'
GO



CREATE PROCEDURE [dbo].[bvc_UrlRedirect_FindAllRegex_s]

AS

	BEGIN TRY

		SELECT * 
		FROM bvc_UrlRedirect 
		WHERE IsRegex = 1
		ORDER BY RequestedUrl

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_i]'
GO



CREATE PROCEDURE [dbo].[bvc_UrlRedirect_i]
	@bvin varchar(36),
	@RequestedUrl nvarchar(2000),
	@RedirectToUrl nvarchar(2000),
	@RedirectType int,
	@SystemData varchar(36),
	@StatusCode int,
	@IsRegex int
AS
	
	BEGIN TRY
		
		-- update old redirects for a given Product, Category or Custom Page to point to the new URL
		IF @SystemData <> ''
		BEGIN
			UPDATE bvc_UrlRedirect
			SET RedirectToUrl = @RedirectToUrl
			WHERE 
				SystemData = @SystemData 
				AND RedirectType = @RedirectType
		END
		-- update any other redirects
		ELSE
		BEGIN
			UPDATE bvc_UrlRedirect
			SET RedirectToUrl = @RedirectToUrl
			WHERE 
				RedirectToUrl = @RequestedUrl
		END

		--insert redirect
		INSERT INTO bvc_UrlRedirect (
			bvin, 
			RequestedUrl, 
			RedirectToUrl, 
			RedirectType, 
			SystemData, 
			StatusCode, 
			IsRegex, 
			CreationDate,
			LastUpdated)
		VALUES (
			@bvin, 
			@RequestedUrl, 
			@RedirectToUrl, 
			@RedirectType, 
			@SystemData, 
			@StatusCode, 
			@IsRegex, 
			GETDATE(),
			GETDATE())
		RETURN
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_u]'
GO



CREATE PROCEDURE [dbo].[bvc_UrlRedirect_u]
	@bvin varchar(36),
	@RequestedUrl nvarchar(2000),
	@RedirectToUrl nvarchar(2000),
	@RedirectType int,
	@SystemData varchar(36),
	@StatusCode int,
	@IsRegex int
AS

	BEGIN TRY
		
		-- update old redirects for a given Product, Category or Custom Page to point to the new URL
		IF @SystemData <> ''
		BEGIN
			UPDATE bvc_UrlRedirect
			SET RedirectToUrl = @RedirectToUrl
			WHERE 
				SystemData = @SystemData 
				AND RedirectType = @RedirectType
		END
		-- update any other redirects
		ELSE
		BEGIN
			UPDATE bvc_UrlRedirect
			SET RedirectToUrl = @RedirectToUrl
			WHERE 
				RedirectToUrl = @RequestedUrl
		END

		-- update redirect
		UPDATE bvc_UrlRedirect
		SET 
			RequestedUrl = @RequestedURL,
			RedirectToUrl = @RedirectToURL,
			RedirectType = @RedirectType,
			SystemData = @SystemData,
			StatusCode = @StatusCode,
			IsRegex = @IsRegex,
			LastUpdated = GETDATE()
		WHERE bvin = @bvin
		
		RETURN
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_d]'
GO




CREATE PROCEDURE [dbo].[bvc_UrlRedirect_d]
	@bvin varchar(36)
AS

	BEGIN TRY

	   DELETE 
	   FROM bvc_UrlRedirect 
	   WHERE bvin = @bvin

	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_ByType_s]'
GO



CREATE PROCEDURE [dbo].[bvc_UrlRedirect_ByType_s]
	@RedirectType int
AS

	BEGIN TRY
		
		SELECT * 
		FROM bvc_UrlRedirect 
		WHERE RedirectType = @RedirectType
		ORDER BY RequestedUrl
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH


GO
PRINT N'Creating [dbo].[bvc_UrlRedirect_ByRedirectToUrl_s]'
GO


CREATE PROCEDURE [dbo].[bvc_UrlRedirect_ByRedirectToUrl_s]
	@RedirectToUrl nvarchar(2000)
AS

	BEGIN TRY

		SELECT * 
		FROM bvc_UrlRedirect 
		WHERE RedirectToUrl = @RedirectToUrl
		
	END TRY
	BEGIN CATCH
		EXEC bvc_EventLog_SQL_i
	END CATCH



GO
PRINT N'Creating [dbo].[bvc_Product_SearchEngine_s]'
GO

CREATE PROCEDURE [dbo].[bvc_Product_SearchEngine_s]
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
PRINT N'Creating [dbo].[tos_PostalCode_ByCode_s]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_ByCode_s] 
  @CountryBvin varchar(36), 
  @Code varchar(50)
AS
BEGIN TRY
  SET NOCOUNT ON;
  SELECT
    [bvin], [City], [Code], [CountryBvin], [Latitude], [Longitude], [RegionBvin], [LastUpdated]
  FROM
    tos_PostalCodes
  WHERE
    [CountryBvin] = @CountryBvin AND [Code] = @Code;
  RETURN;
END TRY
BEGIN CATCH
  EXEC bvc_EventLog_SQL_i
END CATCH
GO
PRINT N'Creating [dbo].[tos_PostalCode_ByCountry_d]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_ByCountry_d] 
  @CountryBvin varchar(36)
AS
BEGIN TRY
  SET NOCOUNT OFF;
  DELETE 
    TOP (5000) -- Limit the number of deletes to avoid timeout
  FROM
    tos_PostalCodes 
  WHERE 
    [CountryBvin] = @CountryBvin;
  RETURN;
END TRY
BEGIN CATCH
  EXEC bvc_EventLog_SQL_i
END CATCH
GO
PRINT N'Creating [dbo].[tos_PostalCode_ByCountry_s]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_ByCountry_s] 
  @bvin varchar(36)
AS
BEGIN TRY
  SET NOCOUNT ON;
  SELECT
    [bvin], [City], [Code], [CountryBvin], [Latitude], [Longitude], [RegionBvin], [LastUpdated]
  FROM
    tos_PostalCodes
  WHERE
    [CountryBvin] = @bvin;
  RETURN;
END TRY
BEGIN CATCH
  EXEC bvc_EventLog_SQL_i
END CATCH
GO
PRINT N'Creating [dbo].[tos_PostalCode_Count_s]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_Count_s] 
AS
BEGIN TRY
  SET NOCOUNT ON;
  SELECT
    [CountryBvin], Count(*) AS [Count]
  FROM
    tos_PostalCodes
  GROUP BY [CountryBvin]
  RETURN;
END TRY
BEGIN CATCH
  EXEC bvc_EventLog_SQL_i
END CATCH
GO
PRINT N'Creating [dbo].[tos_PostalCode_d]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_d] 
  @bvin varchar(36) = ''
AS
BEGIN TRY
  SET NOCOUNT OFF;
  DELETE tos_PostalCodes WHERE [bvin] = @bvin;
  RETURN;
END TRY
BEGIN CATCH
  EXEC bvc_EventLog_SQL_i
END CATCH
GO
PRINT N'Creating [dbo].[tos_PostalCode_i]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_i] 
  @bvin varchar(36), 
  @City nvarchar(MAX) = '',
  @Code varchar(50),
  @CountryBvin varchar(36),
  @Latitude decimal(18, 10),
  @Longitude decimal(18, 10),
  @RegionBvin varchar(36) = ''
AS
BEGIN TRY
  SET NOCOUNT OFF;
  INSERT INTO tos_PostalCodes
    ([bvin],[City],[Code],[CountryBvin],[Latitude],[Longitude],[RegionBvin],[LastUpdated])
  VALUES
    (@bvin, @City, @Code, @CountryBvin, @Latitude, @Longitude, @RegionBvin, GetDate());
  RETURN;
END TRY
BEGIN CATCH
  EXEC bvc_EventLog_SQL_i
END CATCH
GO
PRINT N'Creating [dbo].[tos_PostalCode_s]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_s] 
  @bvin varchar(36) = ''
AS
BEGIN TRY
  SET NOCOUNT ON;
  SELECT
    [bvin], [City], [Code], [CountryBvin], [Latitude], [Longitude], [RegionBvin], [LastUpdated]
  FROM
    tos_PostalCodes
  WHERE
    [bvin] = @bvin;
  RETURN;
END TRY
BEGIN CATCH
  EXEC bvc_EventLog_SQL_i
END CATCH
GO
PRINT N'Creating [dbo].[tos_PostalCode_u]'
GO
CREATE PROCEDURE [dbo].[tos_PostalCode_u] 
  @bvin varchar(36), 
  @City nvarchar(MAX) = '',
  @Code varchar(50),
  @CountryBvin varchar(36),
  @Latitude decimal(18, 10),
  @Longitude decimal(18, 10),
  @RegionBvin varchar(36) = ''
AS
BEGIN TRY
  SET NOCOUNT OFF;
  DECLARE @bvintest varchar(36)
  SELECT @bvintest = [bvin] FROM [dbo].[tos_PostalCodes] WHERE ([Code] = @Code AND [CountryBvin ] = @CountryBvin)
  IF @bvintest IS NULL
    BEGIN
      IF @bvin = '' SET @bvin = CONVERT(varchar(36), NEWID())
      INSERT INTO [dbo].[tos_PostalCodes]
        ([bvin],
        [City],
        [Code],
        [CountryBvin],
        [Latitude],
        [Longitude],
        [RegionBvin],
        [LastUpdated])
      VALUES
        (@bvin, 
        @City, 
        @Code, 
        @CountryBvin, 
        @Latitude, 
        @Longitude, 
        @RegionBvin, 
        GetDate())
    END
  ELSE
    BEGIN
      SET @bvin = @bvintest
      UPDATE [dbo].[tos_PostalCodes]
        SET
          [City] = @City,
          [Code] = @Code,
          [CountryBvin] = @CountryBvin,
          [Latitude] = @Latitude,
          [Longitude] = @Longitude,
          [RegionBvin] = @RegionBvin,
          [LastUpdated] = GetDate()
        WHERE
          [bvin] = @bvin
    END
  SELECT @bvin AS 'bvin'
END TRY
BEGIN CATCH
  EXEC [dbo].[bvc_EventLog_SQL_i]
END CATCH

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
