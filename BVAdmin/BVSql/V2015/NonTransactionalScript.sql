SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

PRINT N'Checking if Full Text Search is installed...'
IF SERVERPROPERTY('IsFullTextInstalled') = 1
BEGIN
	IF DATABASEPROPERTYEX(DB_NAME(), 'IsFulltextEnabled') = 0
	BEGIN
		PRINT N'Enabling full text search'
		EXEC sp_fulltext_database 'enable'
	END
	ELSE
	BEGIN
		PRINT N'Yep, it is! Looks good.'
	END
END
GO
