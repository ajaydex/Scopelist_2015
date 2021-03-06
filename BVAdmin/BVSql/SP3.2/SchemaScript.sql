/*
Script created by SQL Compare version 6.0.0 from Red Gate Software Ltd at 1/17/2008 10:15:54 AM
Run this script on SQL003.bvc5SP31ChangeScripts to make it the same as SQL003.Bvc5SP32ChangeScripts
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
				a.ProductID, SUM(a.Quantity) AS "Total Ordered"
				FROM 
				(					
					SELECT 
						CASE p.ParentId
							WHEN '' THEN p.bvin
							ELSE p.ParentId
						END AS ProductID, 
						Quantity
					FROM bvc_LineItem l
					JOIN bvc_Order o on l.OrderBvin = o.bvin
					JOIN bvc_Product p ON p.bvin = l.ProductId
					WHERE o.IsPlaced = 1 AND dbo.bvc_ProductAvailableAndActive(ProductID, 0) = 1
					AND	OrderBvin IN
					(SELECT OrderBvin
						FROM bvc_LineItem
						WHERE ProductID IN (SELECT bvin FROM bvc_Product WHERE ParentId = @bvin))
				) AS a
				GROUP BY a.ProductID
				ORDER BY SUM(a.Quantity) DESC
		END
		ELSE
		BEGIN
			SELECT TOP(@MaxResults)
				a.ProductID, SUM(a.Quantity) AS "Total Ordered"
				FROM 
				(
					SELECT 
						CASE p.ParentId
							WHEN '' THEN p.bvin
							ELSE p.ParentId
						END AS ProductID, 
						Quantity
					FROM bvc_LineItem l
					JOIN bvc_Order o on l.OrderBvin = o.bvin 
					JOIN bvc_Product p ON p.bvin = l.ProductId
					WHERE o.IsPlaced = 1 AND dbo.bvc_ProductAvailableAndActive(ProductID, 0) = 1
					AND	OrderBvin IN
					(SELECT OrderBvin
						FROM bvc_LineItem
						WHERE ProductID = @bvin)
				) AS a
				GROUP BY a.ProductID
				ORDER BY SUM(a.Quantity) DESC			
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
