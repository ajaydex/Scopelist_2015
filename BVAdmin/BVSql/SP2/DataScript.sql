SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

BEGIN TRANSACTION

-- Drop constraints from [dbo].[bvc_WorkFlowStep]
ALTER TABLE [dbo].[bvc_WorkFlowStep] DROP CONSTRAINT [FK_bvc_WorkFlowStep_bvc_WorkFlow]

-- Drop constraint FK_bvc_Region_bvc_Country from [dbo].[bvc_Region]
ALTER TABLE [dbo].[bvc_Region] DROP CONSTRAINT [FK_bvc_Region_bvc_Country]

-- Drop constraint FK_bvc_ShippingMethod_CountryRestriction_bvc_Country from [dbo].[bvc_ShippingMethod_CountryRestriction]
ALTER TABLE [dbo].[bvc_ShippingMethod_CountryRestriction] DROP CONSTRAINT [FK_bvc_ShippingMethod_CountryRestriction_bvc_Country]

-- Update row in [dbo].[bvc_WorkFlow]
UPDATE [dbo].[bvc_WorkFlow] SET [Name]=N'Shipping Adjustments' WHERE [bvin]=N'268ff9dc-ae7f-4faf-9944-d1aa15e64852'

-- Update rows in [dbo].[bvc_Country]
UPDATE [dbo].[bvc_Country] SET [ISOCode]=N'HN' WHERE [bvin]=N'6aa3072c-540f-4e07-b203-de21180a94bd'
UPDATE [dbo].[bvc_Country] SET [ISOCode]=N'RS' WHERE [bvin]=N'd5e8ed18-b909-4fcf-b6c6-b7a7e00a28d4'
-- Operation applied to 2 rows out of 9

-- Add rows to [dbo].[bvc_SiteTerm]
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'OrderAlreadyPlaced')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'OrderAlreadyPlaced', N'Order has already been placed, or no cart exists.')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'PasswordAnswer')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PasswordAnswer', N'Password Answer')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'PasswordHint')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PasswordHint', N'Password Hint')
IF NOT EXISTS (SELECT SiteTerm FROM [bvc_SiteTerm] WHERE SiteTerm = 'ValidatorFieldMarker')
	INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ValidatorFieldMarker', N'*')
-- Operation applied to 4 rows out of 4

-- Add rows to [dbo].[bvc_WebAppSetting]
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'BreadCrumbTrailMaxEntries')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BreadCrumbTrailMaxEntries', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'DefaultPlugin')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DefaultPlugin', N'')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'EnableReturns')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableReturns', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleAVSErrorPutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSErrorPutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleAVSFailsPutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSFailsPutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleAVSNotSupportedPutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSNotSupportedPutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleAVSPartialMatchPutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSPartialMatchPutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleCartMinutes')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCartMinutes', N'30')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleCheckoutButtonBackground')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCheckoutButtonBackground', N'Transparent')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleCheckoutButtonSize')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCheckoutButtonSize', N'Large')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleCurrency')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCurrency', N'USD')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleCVNErrorPutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCVNErrorPutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleCVNNoMatchPutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCVNNoMatchPutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleCVNNotAvailablePutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCVNNotAvailablePutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleDebugMode')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDebugMode', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleDefaultShippingAmount')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDefaultShippingAmount', N'1.00')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleDefaultShippingType')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDefaultShippingType', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleDefaultShippingValues')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDefaultShippingValues', N'<?xml version="1.0" encoding="utf-16"?><dictionary></dictionary>')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleMerchantId')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMerchantId', N'')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleMerchantKey')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMerchantKey', N'')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleMinimumAccountDaysOld')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMinimumAccountDaysOld', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GoogleMode')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMode', N'Sandbox')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'GooglePaymentProtectionEligiblePutHold')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GooglePaymentProtectionEligiblePutHold', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'InventoryEnabledNewProductDefault')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryEnabledNewProductDefault', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'InventoryNewProductDefaultMode')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryNewProductDefaultMode', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'MessageBoxErrorTestMode')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MessageBoxErrorTestMode', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'OverrideEmptyChoiceNames')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'OverrideEmptyChoiceNames', N'1')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'ReverseOrderNotes')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ReverseOrderNotes', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'RMANewEmailTemplate')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RMANewEmailTemplate', N'c0cb9492-f4be-4bdb-9ae9-0b14c7bd2cd0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchDisableBlankSearchTerms')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisableBlankSearchTerms', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchFilterDuplicateItems')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchFilterDuplicateItems', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'SearchMaxResults')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchMaxResults', N'100')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'ShippingUPSDiagnostics')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUPSDiagnostics', N'0')
IF NOT EXISTS (SELECT SettingName FROM bvc_WebAppSetting WHERE SettingName = 'ShippingUpsSkipDimensions')
	INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUpsSkipDimensions', N'0')
-- Operation applied to 34 rows out of 34

-- Add row to [dbo].[bvc_EmailTemplate]
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_EmailTemplate] WHERE bvin = 'c0cb9492-f4be-4bdb-9ae9-0b14c7bd2cd0')
	INSERT INTO [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'c0cb9492-f4be-4bdb-9ae9-0b14c7bd2cd0', N'', N'A new return was requested from the store.
	Name: [[RMA.Name]]
	Email: [[RMA.EmailAddress]]
	RMA Number: [[RMA.Number]]
	Order Number: [[RMA.OrderNumber]]', N'New Return Email Template', N'admin@bvcommerce.com', N'', N'', 1, N'New Return Requested', '20070209 15:06:22.000', N'', N'')

-- Add row to [dbo].[bvc_WorkFlow]
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlow] WHERE bvin = '11dc88f5-43f2-44bb-bb86-1141d6aee495')
	INSERT INTO [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'11dc88f5-43f2-44bb-bb86-1141d6aee495', 2, N'Process New Return', 1, '20070227 11:34:00.000')

-- Add rows to [dbo].[bvc_WorkFlowStep]
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlowStep] WHERE bvin = '498c5289-95b1-43de-9db4-261a376c06cf')
	INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'498c5289-95b1-43de-9db4-261a376c06cf', N'09739bec-8974-4c38-b026-f6ca8aed615d', 3, N'c2c432db-ec35-4101-be16-48cbb4951663', N'Start Google Checkout', '20070226 13:11:19.000', N'Start Google Checkout')
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlowStep] WHERE bvin = '4d0e483b-f6a5-4ec6-a9a7-2ef23b93e1b5')
	INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'4d0e483b-f6a5-4ec6-a9a7-2ef23b93e1b5', N'11dc88f5-43f2-44bb-bb86-1141d6aee495', 1, N'e5a9b457-554e-4d31-9c0d-d01d5e0799a3', N'Send RMA Email', '20070227 13:20:01.000', N'Send RMA Email')
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlowStep] WHERE bvin = '578c979b-d0c0-415b-9dd7-f35dcdd8015a')
	INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'578c979b-d0c0-415b-9dd7-f35dcdd8015a', N'09739bec-8974-4c38-b026-f6ca8aed615d', 1, N'56597582-05d0-4b51-bd87-7426a9cf146f', N'Start Paypal Express Checkout', '20061113 10:17:37.000', N'Start Paypal Express Checkout')
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlowStep] WHERE bvin = '655f798f-5ac9-4ff0-9a44-df1f707759fb')
	INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'655f798f-5ac9-4ff0-9a44-df1f707759fb', N'd139a636-04c7-41b9-adca-0533432735bc', 2, N'9e1f141c-e9bf-4df5-801b-35b623dae3a8', N'Google Checkout Send Order Shipped Notification', '20070226 13:11:02.000', N'Google Checkout Send Order Shipped Notification')
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlowStep] WHERE bvin = '9aa450d1-bc94-44a3-8ec7-07b0a39acdc7')
	INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'9aa450d1-bc94-44a3-8ec7-07b0a39acdc7', N'8b95070d-ce9b-4b43-9905-0981fbedd5af', 1, N'b238fec3-3b16-43b3-bba3-80db10a56ec1', N'Initialize Product Price', '20070226 13:11:27.000', N'Initialize Product Price')
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlowStep] WHERE bvin = 'db64c2d4-eb3b-4d85-8ca6-595b64d3e10f')
	INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'db64c2d4-eb3b-4d85-8ca6-595b64d3e10f', N'f9d6b245-8809-4500-bd72-b54618b2d0a7', 1, N'0a91c490-df6c-4f88-9b12-cb65615ab758', N'Google Checkout Send Tracking Information', '20070226 13:11:08.000', N'Google Checkout Send Tracking Information')
IF NOT EXISTS (SELECT bvin FROM [dbo].[bvc_WorkFlowStep] WHERE bvin = 'e39b7e82-6a9b-4b8a-8d42-aca7bba78c1d')
	INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'e39b7e82-6a9b-4b8a-8d42-aca7bba78c1d', N'268ff9dc-ae7f-4faf-9944-d1aa15e64852', 2, N'f3f17478-4d43-43b1-8bcd-89a7eef243a5', N'Apply Product Shipping Modifiers', '20070314 10:02:52.000', N'Apply Product Shipping Modifiers')
-- Operation applied to 7 rows out of 7

-- Add constraints to [dbo].[bvc_WorkFlowStep]
ALTER TABLE [dbo].[bvc_WorkFlowStep] WITH NOCHECK ADD CONSTRAINT [FK_bvc_WorkFlowStep_bvc_WorkFlow] FOREIGN KEY ([WorkFlowBvin]) REFERENCES [dbo].[bvc_WorkFlow] ([bvin])

-- Add constraint FK_bvc_Region_bvc_Country to [dbo].[bvc_Region]
ALTER TABLE [dbo].[bvc_Region] WITH NOCHECK ADD CONSTRAINT [FK_bvc_Region_bvc_Country] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[bvc_Country] ([bvin])

-- Add constraint FK_bvc_ShippingMethod_CountryRestriction_bvc_Country to [dbo].[bvc_ShippingMethod_CountryRestriction]
ALTER TABLE [dbo].[bvc_ShippingMethod_CountryRestriction] WITH NOCHECK ADD CONSTRAINT [FK_bvc_ShippingMethod_CountryRestriction_bvc_Country] FOREIGN KEY ([CountryBvin]) REFERENCES [dbo].[bvc_Country] ([bvin])

COMMIT TRANSACTION
