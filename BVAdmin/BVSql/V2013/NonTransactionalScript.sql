SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

PRINT N'Checking if Full Text Search is installed'
IF SERVERPROPERTY('IsFullTextInstalled') = 0
BEGIN
	PRINT N'Full Text Search is not installed! Please install this component and re-run this script.'
END
ELSE
BEGIN
	IF CAST(SERVERPROPERTY('productversion') AS NVARCHAR) LIKE '9.%'
	BEGIN
		IF DATABASEPROPERTYEX(DB_NAME(), 'IsFulltextEnabled') = 0
		BEGIN
			PRINT N'Enabling full text search'
			EXEC sp_fulltext_database 'enable'
		END
	END

	IF OBJECTPROPERTY(OBJECT_ID('bvc_Product'), 'TableHasActiveFulltextIndex') = 0
	BEGIN
		PRINT N'Creating full text catalogs'
		CREATE FULLTEXT CATALOG [ft_bvc_Product]
		WITH ACCENT_SENSITIVITY = OFF
		AS DEFAULT
		AUTHORIZATION [dbo]

		PRINT N'Adding full text indexing to tables'
		CREATE FULLTEXT INDEX ON [dbo].[bvc_Product] KEY INDEX [PK_bvc_Product] ON [ft_bvc_Product] WITH CHANGE_TRACKING AUTO
		CREATE FULLTEXT INDEX ON [dbo].[bvc_ProductType] KEY INDEX [PK_ProductType] ON [ft_bvc_Product] WITH CHANGE_TRACKING AUTO

		PRINT N'Adding full text indexing to columns'
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([SKU])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([ProductName])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([MetaKeywords])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([MetaDescription])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([MetaTitle])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([ShortDescription])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([LongDescription])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ADD ([Keywords])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_ProductType] ADD ([ProductTypeName])
		ALTER FULLTEXT INDEX ON [dbo].[bvc_Product] ENABLE
		ALTER FULLTEXT INDEX ON [dbo].[bvc_ProductType] ENABLE
	END
END
GO
