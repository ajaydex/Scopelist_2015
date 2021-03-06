/*
Script created by SQL Compare version 6.0.0 from Red Gate Software Ltd at 12/19/2007 3:23:22 PM
Run this script on SQL003.Bvc5SP3ChangeScripts to make it the same as SQL003.Bvc5Sp31ChangeScripts
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
			bvc_Product.CustomProperties '						

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
          TrackInventory, OutOfStockMode, CustomProperties, Relevance
        ),
        cte_ActiveResult AS (
			SELECT * FROM cte_ProductSearch AS a WHERE NOT EXISTS (SELECT * FROM cte_ProductSearch AS b WHERE a.bvin = b.bvin AND a.Relevance > b.Relevance) 
			AND (dbo.bvc_ProductAvailableAndActive(a.bvin, 0) = 1)),
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
