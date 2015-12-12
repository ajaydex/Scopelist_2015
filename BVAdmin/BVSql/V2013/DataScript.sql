SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO

UPDATE [dbo].[bvc_ComponentSetting] SET [SettingValue] = N'http://www.bvcommerce.com/remoteapi/1/news/latest.xml' WHERE [ComponentID] = N'022256cc-c09f-40b1-971c-f515b47361bc' AND [SettingName] = N'FeedUrl'
UPDATE [dbo].[bvc_ComponentSettingList] SET [Setting2] = N'http://www.bvcommerce.com/forums/' WHERE [bvin] = '0671f93a-0053-4ad3-b57d-b166452fa72e' AND  [ComponentID] = N'0db42f98-f61b-466e-b4fa-12cf20311837'
UPDATE [dbo].[bvc_ComponentSettingList] SET [Setting2] = N'http://www.bvcommerce.com/forums/' WHERE [bvin] = 'b5aa52b6-b406-4287-b492-f254e9929f10' AND  [ComponentID] = N'792426a0-4f0d-4c71-96e8-b4e589c80f87'
UPDATE [dbo].[bvc_ComponentSettingList] SET [Setting2] = N'http://www.bvcommerce.com/forums/' WHERE [bvin] = 'dce81cb9-9954-4ecf-84b8-2bfa2e7e5498' AND  [ComponentID] = N'31d7752a-e433-4093-8228-bbdf7fe7f579'

IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'LoyaltyPoints')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LoyaltyPoints', N'Loyalty Points')
END
IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'LoyaltyPointsCredit')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LoyaltyPointsCredit', N'Loyalty Points Credit')
END
IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'LoyaltyPointsEarned')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LoyaltyPointsEarned', N'Loyalty Points Earned')
END
IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'ProductCombinationInvalid')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductCombinationInvalid', N'This combination of options is not valid. Please select a different combination of options.')
END
IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'ProductReviewAnonymousUserName')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductReviewAnonymousUserName', N'Anonymous')
END
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AddThisCode', N'
<!-- AddThis Button BEGIN -->
<div class="addthis_toolbox addthis_default_style ">
<a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
<a class="addthis_button_tweet"></a>
<a class="addthis_button_pinterest_pinit"></a>
<a class="addthis_counter addthis_pill_style"></a>
</div>
<!-- AddThis Button END -->
')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AddThisTrackUrls', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutoPopulateRedirectOnCategoryDelete', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutoPopulateRedirectOnCustomPageDelete', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutoPopulateRedirectOnProductDelete', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DatabaseV2013', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplayShippingCalculatorInShoppingCart', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableAdvancedSearch', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'FacebookOpenGraphEnabled', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleTrustedStoresEnabled', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleTrustedStoresFeedsLastTimeRun', N'632926151410156250')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsEnabled', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsEarnedPerCurrencyUnit', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsToCurrencyUnitExchangeRate', N'100')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsMinimumOrderAmountToEarnPoints', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsMinimumOrderAmountToUsePoints', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsMinimumPointsCurrencyBalanceToUse', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsExpire', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsExpireDays', N'90')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewEmail', N'empty@bvcommerce.com')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RedirectorEnabled', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RedirectToPrimaryDomain', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledProductTypeName', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledProductChoiceCombinations', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductSku', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductName', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductTypeName', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductMetaDescription', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductMetaKeywords', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductMetaTitle', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductShortDescription', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductLongDescription', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductKeywords', N'1')
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'SendProductReviewNotificationEmail')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SendProductReviewNotificationEmail', N'1')
END
IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'ShippingUnknown')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ShippingUnknown', N'To Be Determined. Contact Store for Details')
END
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'WebAppSettingsLoaded')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'WebAppSettingsLoaded', N'1')
END

IF NOT EXISTS (SELECT * FROM bvc_EmailTemplate WHERE bvin = 'fc2bf4e9-65cf-4d3e-8d64-c039f8de29ee')
BEGIN
INSERT INTO bvc_EmailTemplate(bvin, Body, BodyPlainText, DisplayName, [From], RepeatingSection, RepeatingSectionPlainText, SendInPlainText, [Subject], LastUpdated, BodyPreTransform, RepeatingSectionPreTransform)
VALUES(
	'fc2bf4e9-65cf-4d3e-8d64-c039f8de29ee',
	'',
	'The following new review for [[ProductReview.ProductName]] was posted by [[ProductReview.Name]] ([[ProductReview.Email]]).

STATUS: [[ProductReview.Approved]]

RATING: [[ProductReview.Rating]]

REVIEW:  [[ProductReview.Description]]


IP: [[ProductReview.IP]]
Host: [[ProductReview.Host]]
Browser: [[ProductReview.Browser]]


You can moderate this review here:
[[Site.StandardUrl]]BVAdmin/Catalog/Reviews_Edit.aspx?reviewID=[[ProductReview.Bvin]]&ReturnURL=products_edit_reviews.aspx%3fid%3d[[ProductReview.ProductBvin]]',
	'Admin Product Review Notification',
	'empty@bvcommerce.com',
	'',
	'',
	1,
	'New Product Review for [[ProductReview.ProductName]]',
	GETDATE(),
	'',
	''
)
END



DECLARE @AvalaraCommitTaxesSortOrder AS INT
SET @AvalaraCommitTaxesSortOrder = (SELECT MAX(SortOrder) FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'db14f186-4005-4726-9a37-d67c2dc284ec' AND ControlName = '30B9B11C-1621-4779-ABC2-FEC5D280484B')
IF @AvalaraCommitTaxesSortOrder IS NOT NULL
BEGIN
UPDATE bvc_WorkFlowStep SET SortOrder = SortOrder + 1 WHERE WorkFlowBvin = 'db14f186-4005-4726-9a37-d67c2dc284ec' AND SortOrder >= @AvalaraCommitTaxesSortOrder
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES ('80d34afc-cd0c-4ab8-a48b-9d4e87717557', 'db14f186-4005-4726-9a37-d67c2dc284ec', @AvalaraCommitTaxesSortOrder, N'd10d9ffa-dda1-48ed-bfed-5a088cf685d7', N'Avalara Cancel Taxes When Payment Removed', '8/27/2013 10:21:20 PM', N'Avalara Cancel Taxes When Payment Removed')

IF NOT EXISTS (SELECT * FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'ee046427-9da3-431f-92b8-5665ec20a59c' AND ControlName = '103ec8c5-a7b3-45f0-a948-69f4f074568e')
BEGIN
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) SELECT '5a2a9769-c2e6-4578-9cf7-8245b10775ce', 'ee046427-9da3-431f-92b8-5665ec20a59c', (SELECT CASE WHEN MAX(SortOrder) IS NULL THEN 1 ELSE MAX(SortOrder) + 1 END FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'ee046427-9da3-431f-92b8-5665ec20a59c'), N'103ec8c5-a7b3-45f0-a948-69f4f074568e', N'Avalara Resubmit Taxes', '8/27/2013 10:13:31 PM', N'Avalara Resubmit Taxes'
END

IF NOT EXISTS (SELECT * FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'c84658fb-fc72-458a-b0e6-c1708d9e84f2' AND ControlName = 'e3cff8c5-b691-4a2a-b96d-d70f508d81d2')
BEGIN
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) SELECT '2ea5fa6e-40bd-4b87-a4c2-7b04f36d9f8a', 'c84658fb-fc72-458a-b0e6-c1708d9e84f2', (SELECT CASE WHEN MAX(SortOrder) IS NULL THEN 1 ELSE MAX(SortOrder) + 1 END FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'c84658fb-fc72-458a-b0e6-c1708d9e84f2'), N'e3cff8c5-b691-4a2a-b96d-d70f508d81d2', N'Avalara Commit Taxes', '8/27/2013 10:15:34 PM', N'Avalara Commit Taxes'
END
END



DECLARE @DebitLoyaltyPointsSortOrder AS INT
SET @DebitLoyaltyPointsSortOrder = (SELECT SortOrder FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'eac003c6-a354-489f-ba2c-029f4311851a' AND ControlName = 'da3c958a-8a58-43ca-8da3-8dd5a0cf244e')
IF @DebitLoyaltyPointsSortOrder IS NOT NULL
BEGIN
UPDATE bvc_WorkFlowStep SET SortOrder = SortOrder + 1 WHERE WorkFlowBvin = 'eac003c6-a354-489f-ba2c-029f4311851a' AND SortOrder >= @DebitLoyaltyPointsSortOrder
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES ('df7e4b06-f196-4458-a4f1-facfe9327efb', 'eac003c6-a354-489f-ba2c-029f4311851a', @DebitLoyaltyPointsSortOrder, N'EA43E26D-20A8-414F-B2C1-C4F4281822B6', N'Debit Loyalty Points', '8/26/2013 8:25:33 AM', N'Debit Loyalty Points')
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) SELECT '261c2448-dd10-4f7a-aeb7-fa787c11c42d', 'ee046427-9da3-431f-92b8-5665ec20a59c', (SELECT CASE WHEN MAX(SortOrder) IS NULL THEN 1 ELSE MAX(SortOrder) + 1 END FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'ee046427-9da3-431f-92b8-5665ec20a59c'), N'BBB0800B-4ED6-4060-9FBA-1B8D7EEAA686', N'Update Loyalty Points', '8/26/2013 8:27:45 AM', N'Update Loyalty Points'
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) SELECT '8c2a7012-750b-49ab-9a38-70882d54c65b', 'db14f186-4005-4726-9a37-d67c2dc284ec', (SELECT CASE WHEN MAX(SortOrder) IS NULL THEN 1 ELSE MAX(SortOrder) + 1 END FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'db14f186-4005-4726-9a37-d67c2dc284ec'), N'BBB0800B-4ED6-4060-9FBA-1B8D7EEAA686', N'Update Loyalty Points', '8/26/2013 8:29:33 AM', N'Update Loyalty Points'
END



UPDATE op
SET 
	op.creditCardNumber = '',
	op.creditCardExpYear = 1900,
	op.creditCardExpMonth = 1,
	op.EncryptionKeyId = 9223372036854775807
FROM bvc_OrderPayment AS op
INNER JOIN bvc_Order AS o ON o.Bvin = op.orderID
where
	o.IsPlaced = 1
	AND o.StatusCode = '09D7305D-BD95-48d2-A025-16ADC827582A'
	AND o.TimeOfOrder < DATEADD(DAY, -29, GETDATE())
	AND op.paymentMethodId = '4A807645-4B9D-43f1-BC07-9F233B4E713C'
	AND op.creditCardExpYear <> 1900
	AND op.creditCardNumber <> ''

GO
