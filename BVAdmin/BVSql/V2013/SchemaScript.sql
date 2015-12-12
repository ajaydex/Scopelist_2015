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
PRINT N'Dropping Develisys BVC 5 Toolkit procs'
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Category_Trail_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Category_Trail_s]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Category_ByCustomUrl_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Category_ByCustomUrl_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Category_ByCustomPage_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Category_ByCustomPage_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Product_TopSellers_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Product_TopSellers_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Product_TopSellers_ByCategory_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Product_TopSellers_ByCategory_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_ProductReview_Latest_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_ProductReview_Latest_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_CartCleanup_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_CartCleanup_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_ProductType_TopSellers_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_ProductType_TopSellers_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Manufacturer_TopSellers_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Manufacturer_TopSellers_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_UserAccount_DuplicateEmail_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_UserAccount_DuplicateEmail_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Order_MergeAnonymous_u]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Order_MergeAnonymous_u]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_UserAccount_ByEmail_All_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_UserAccount_ByEmail_All_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Product_SuggestedItems_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Product_SuggestedItems_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_Product_SearchEngine_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[bvc_Product_SearchEngine_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_ByCode_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_ByCode_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_ByCountry_d]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_ByCountry_d]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_ByCountry_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_ByCountry_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_Count_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_Count_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_d]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_d]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_i]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_i]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_s]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_s]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCode_u]') AND type in (N'P', N'PC'))
DROP PROC [dbo].[tos_PostalCode_u]
GO



PRINT N'Dropping constraints from [dbo].[bvc_CustomPage]'
GO
ALTER TABLE [dbo].[bvc_CustomPage] DROP CONSTRAINT [DF_bvc_CustomPage_MetaDescription]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_CustomPage]'
GO
ALTER TABLE [dbo].[bvc_CustomPage] DROP CONSTRAINT [DF_bvc_CustomPage_MetaKeywords]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping constraints from [dbo].[bvc_User]'
GO
ALTER TABLE [dbo].[bvc_User] DROP CONSTRAINT [DF_bvc_User_PasswordLastThree]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_bvc_Product_sku] from [dbo].[bvc_Product]'
GO
DROP INDEX [IX_bvc_Product_sku] ON [dbo].[bvc_Product]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Dropping index [IX_Product_ProductName] from [dbo].[bvc_Product]'
GO
DROP INDEX [IX_Product_ProductName] ON [dbo].[bvc_Product]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductReview]'
GO
ALTER TABLE [dbo].[bvc_ProductReview] ADD
[UserName] [nvarchar] (151) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductReview_UserName] DEFAULT (N''),
[UserEmail] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductReview_UserEmail] DEFAULT (N'')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_ProductReview_Latest_s]'
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_User]'
GO
ALTER TABLE [dbo].[bvc_User] ADD
[CustomProperties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_User_CustomProperties] DEFAULT (N'')
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
			PasswordLastSet, PasswordLastThree, CustomProperties
			
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
PRINT N'Creating [dbo].[bvc_UrlRedirect]'
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_UrlRedirect]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[bvc_UrlRedirect]
	(
	[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RequestedUrl] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RedirectToUrl] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RedirectType] [int] NOT NULL,
	[SystemData] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[StatusCode] [int] NOT NULL,
	[IsRegex] [int] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[CreationDate] [datetime] NOT NULL
	)

	PRINT N'Creating primary key [PK_bvc_UrlRedirect] on [dbo].[bvc_UrlRedirect]'
	ALTER TABLE [dbo].[bvc_UrlRedirect] ADD CONSTRAINT [PK_bvc_UrlRedirect] PRIMARY KEY CLUSTERED  ([bvin])
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END






GO
PRINT N'Creating [dbo].[tos_PostalCodes]'
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tos_PostalCodes]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[tos_PostalCodes]
	(
	  [bvin] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	  [CountryBvin] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	  [Code] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	  [Latitude] [decimal](18, 10) NOT NULL,
	  [Longitude] [decimal](18, 10) NOT NULL,
	  [RegionBvin] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	  [City] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	  [LastUpdated] [datetime] NOT NULL
	)
	ALTER TABLE [dbo].[tos_PostalCodes] ADD CONSTRAINT [PK_tos_PostalCodes] PRIMARY KEY NONCLUSTERED ([bvin] ASC)
	CREATE UNIQUE CLUSTERED INDEX [IX_tos_PostalCodes] ON [dbo].[tos_PostalCodes]
	(
	 [CountryBvin] ASC,
	 [Code] ASC
	) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
END









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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints]'
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[bvc_LoyaltyPoints]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[bvc_LoyaltyPoints]
	(
	[id] [int] NOT NULL IDENTITY(1, 1),
	[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrderId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PointsType] [int] NOT NULL,
	[PointsAdjustment] [int] NOT NULL,
	[PointsRemaining] [int] NOT NULL,
	[Expires] [int] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[CustomProperties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastUpdated] [datetime] NOT NULL
	)
	ALTER TABLE [dbo].[bvc_LoyaltyPoints] ADD CONSTRAINT [K_bvc_LoyaltyPoints] UNIQUE CLUSTERED  ([id])
	PRINT N'Creating primary key [PK_bvc_LoyaltyPoints] on [dbo].[bvc_LoyaltyPoints]'
	ALTER TABLE [dbo].[bvc_LoyaltyPoints] ADD CONSTRAINT [PK_bvc_LoyaltyPoints] PRIMARY KEY NONCLUSTERED  ([bvin])
END
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_s]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_s]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_ByCriteria_s]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_ByCriteria_s]
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

END TRY
BEGIN CATCH
	EXEC bvc_EventLog_SQL_i
END CATCH

GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_i]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_i]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_u]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_u]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_d]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_d]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_ByUserId_d]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_ByUserId_d]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_ByOrderId_d]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_ByOrderId_d]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_LoyaltyPoints_Available_ByUser_s]'
GO

CREATE PROCEDURE [dbo].[bvc_LoyaltyPoints_Available_ByUser_s]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_Category]'
GO
ALTER TABLE [dbo].[bvc_Category] ADD
[CustomProperties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Category_CustomProperties] DEFAULT (N''),
[ShortDescription] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Category_ShortDescription] DEFAULT (N'')
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
				p.ManufacturerId
			FROM bvc_LineItem AS li
			JOIN bvc_Product AS p ON li.ProductId = p.bvin
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
PRINT N'Altering [dbo].[bvc_ProductReview_ByProductBvin_s]'
GO









ALTER PROCEDURE [dbo].[bvc_ProductReview_ByProductBvin_s]

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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
				li.ProductId AS ProductID,
				SUM(li.Quantity) AS Quantity
			FROM bvc_LineItem AS li
			JOIN bvc_ProductXCategory AS pxc ON li.ProductId = pxc.ProductId
			WHERE
				li.OrderBvin IN (
					SELECT	o.bvin
					FROM	bvc_Order AS o
					WHERE	o.IsPlaced = 1
							AND (o.TimeOfOrder >= @StartDate OR @StartDate IS NULL)
							AND (o.TimeOfOrder <= @EndDate OR @EndDate IS NULL)
				)
				AND (pxc.CategoryId = @CategoryID)
			GROUP BY li.ProductId
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
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
				l.ProductId AS ProductID,
				SUM(l.Quantity) AS Quantity
			FROM bvc_LineItem AS l
			WHERE
				l.OrderBvin IN (
					SELECT	o.bvin
					FROM	bvc_Order AS o
					WHERE	o.IsPlaced = 1
							AND (o.TimeOfOrder >= @StartDate OR @StartDate IS NULL)
							AND (o.TimeOfOrder <= @EndDate OR @EndDate IS NULL)
				)
			GROUP BY l.ProductId
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
PRINT N'Creating [dbo].[bvc_UserAccount_ByEmail_All_s]'
GO

CREATE PROC [dbo].[bvc_UserAccount_ByEmail_All_s]
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
			CustomProperties
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
							AND p.SpecialProductType = ''' + @SpecialProductTypeTwo + ''')'
						ELSE
							')'
					END
				WHEN (@SpecialProductTypeTwo IS NOT NULL) THEN '
					AND p.SpecialProductType = ''' + @SpecialProductTypeTwo + ''''
				ELSE
					''
			END +
			
			CASE
				WHEN (@CategoryId IS NOT NULL) THEN '
					AND EXISTS (SELECT CategoryId, ProductId FROM bvc_ProductXCategory WHERE ProductId = p.bvin AND (CategoryId =''' + @CategoryID + ''')'
				ELSE
					''
			END +
			
			CASE
				WHEN (@NotCategoryId IS NOT NULL) THEN '
					AND NOT EXISTS (SELECT CategoryId, ProductId FROM bvc_ProductXCategory WHERE ProductId = p.bvin AND (CategoryId =''' + @NotCategoryId + ''')'
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
	--INSERT INTO bvc_Audit(TimeStampUtc, SourceModule, ShortName, Description, UserId, UserIdText, Severity)
	--VALUES(GETUTCDATE(), 8, 'Site Search Engine', @SQL, '', '', 1)
	
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
		WHERE bvin IN (SELECT UserID FROM bvc_UserXContact JOIN bvc_Affiliate ON bvc_UserXContact.ContactId = bvc_Affiliate.bvin WHERE ContactID=@bvin)
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
			PasswordLastSet, PasswordLastThree, CustomProperties
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
			PasswordLastSet, PasswordLastThree, CustomProperties
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
		PasswordLastSet, PasswordLastThree, CustomProperties
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
			PasswordLastSet, PasswordLastThree, CustomProperties
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
			PasswordLastSet, PasswordLastThree, CustomProperties
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
@CustomProperties nvarchar(Max)

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
		CustomProperties
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
			PasswordLastSet, PasswordLastThree, CustomProperties
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
PRINT N'Altering [dbo].[bvc_CustomPage]'
GO
ALTER TABLE [dbo].[bvc_CustomPage] ADD
[MetaTitle] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_MetaTitle] DEFAULT (N''),
[TemplateName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_TemplateName] DEFAULT (N''),
[PreContentColumnId] [nvarchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_PreContentColumnId] DEFAULT (N''),
[PostContentColumnId] [nvarchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_PostContentColumnId] DEFAULT (N'')
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
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
		o.LastUpdated

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
			PasswordLastSet, PasswordLastThree, CustomProperties
			
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
@CustomProperties nvarchar(Max)


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
		CustomProperties = @CustomProperties
		
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
			PasswordLastSet, PasswordLastThree, CustomProperties
			
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductReview_s]'
GO





ALTER PROCEDURE [dbo].[bvc_ProductReview_s]
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
		PasswordLastSet, PasswordLastThree, CustomProperties
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
PRINT N'Altering [dbo].[bvc_Product_SuggestedItems]'
GO
ALTER PROCEDURE [dbo].[bvc_Product_SuggestedItems]

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
			PasswordLastSet, PasswordLastThree, CustomProperties
			
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_CustomPage_All_s]'
GO



ALTER PROCEDURE [dbo].[bvc_CustomPage_All_s]

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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductReview_i]'
GO





ALTER PROCEDURE [dbo].[bvc_ProductReview_i]
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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating [dbo].[bvc_CustomPage_d]'
GO





ALTER PROCEDURE [dbo].[bvc_CustomPage_d]

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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductReviewNotApproved_s]'
GO






ALTER PROCEDURE [dbo].[bvc_ProductReviewNotApproved_s]

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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Altering [dbo].[bvc_ProductReview_u]'
GO




ALTER PROCEDURE [dbo].[bvc_ProductReview_u]
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
			PasswordLastSet, PasswordLastThree, CustomProperties
			
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
PRINT N'Altering [dbo].[bvc_UserAccount_d]'
GO




ALTER PROCEDURE [dbo].[bvc_UserAccount_d]

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
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_bvc_Product_sku] on [dbo].[bvc_Product]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_Product_sku] ON [dbo].[bvc_Product] ([SKU])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Creating index [IX_Product_ProductName] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_ProductName] ON [dbo].[bvc_Product] ([ProductName])
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_CustomPage]'
GO
ALTER TABLE [dbo].[bvc_CustomPage] ADD CONSTRAINT [DF_bvc_CustomPage_MetaDescription] DEFAULT (N'') FOR [MetaDescription]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
ALTER TABLE [dbo].[bvc_CustomPage] ADD CONSTRAINT [DF_bvc_CustomPage_MetaKeywords] DEFAULT (N'') FOR [MetaKeywords]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding constraints to [dbo].[bvc_User]'
GO
ALTER TABLE [dbo].[bvc_User] ADD CONSTRAINT [DF_bvc_User_PasswordLastThree] DEFAULT (N'') FOR [PasswordLastThree]
GO
IF @@ERROR<>0 AND @@TRANCOUNT>0 ROLLBACK TRANSACTION
GO
IF @@TRANCOUNT=0 BEGIN INSERT INTO #tmpErrors (Error) SELECT 1 BEGIN TRANSACTION END
GO
PRINT N'Adding foreign keys to [dbo].[bvc_LoyaltyPoints]'
GO
ALTER TABLE [dbo].[bvc_LoyaltyPoints] WITH NOCHECK  ADD CONSTRAINT [FK_bvc_LoyaltyPoints_bvc_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[bvc_User] ([bvin])
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
