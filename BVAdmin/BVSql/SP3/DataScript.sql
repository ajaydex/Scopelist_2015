SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

BEGIN TRANSACTION

-- Add 14 rows to [dbo].[bvc_SiteTerm]
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'CouponDoesNotApply')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CouponDoesNotApply', N'Coupon code does not apply to this order.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ErrorPageContentTextCategory')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageContentTextCategory', N'An error occurred while trying to find the specified category.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ErrorPageContentTextGeneric')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageContentTextGeneric', N'An error occurred while trying to find the specified page.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ErrorPageContentTextProduct')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageContentTextProduct', N'An error occurred while trying to find the specified product.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ErrorPageHeaderTextCategory')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageHeaderTextCategory', N'Error finding category')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ErrorPageHeaderTextGeneric')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageHeaderTextGeneric', N'Error finding page')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ErrorPageHeaderTextProduct')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageHeaderTextProduct', N'Error finding product')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'GoogleCheckoutCustomerError')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'GoogleCheckoutCustomerError', N'')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'PaypalCheckoutCustomerError')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PaypalCheckoutCustomerError', N'')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'PrivateStoreNewUser')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PrivateStoreNewUser', N'Need an account? Contact us.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ProductCombinationNotAvailable')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductCombinationNotAvailable', N'Currently selected product is not available.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ProductNotAvailable')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductNotAvailable', N'%ProductName% is not available.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ShippingUnknown')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ShippingUnknown', N'To Be Determined. Contact Store for Details')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'SortOrder')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'SortOrder', N'Sort Order')

-- Add 12 rows to [dbo].[bvc_WebAppSetting]
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchDisplayImages')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisplayImages', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchDisplayPrice')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisplayPrice', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchDisplaySku')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisplaySku', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchEnabledKeywords')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledKeywords', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchEnabledLongDescription')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledLongDescription', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchEnabledMetaDescription')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledMetaDescription', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchEnabledMetaKeywords')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledMetaKeywords', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchEnabledProductName')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledProductName', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchEnabledShortDescription')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledShortDescription', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchEnabledSKU')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledSKU', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchItemsPerPage')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchItemsPerPage', N'9')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchItemsPerRow')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchItemsPerRow', N'3')

-- Add 1 row to [dbo].[bvc_RolePermission]
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_RolePermission] WHERE bvin = '403F3109-1A6D-48D6-8753-91EA59A8A318')
	INSERT INTO [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES ('403F3109-1A6D-48D6-8753-91EA59A8A318', N'Plug-ins - View', 1, '20071004 00:00:00.000')

COMMIT TRANSACTION