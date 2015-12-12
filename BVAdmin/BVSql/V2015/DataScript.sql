SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO

-- SiteTerms
IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'NextProduct')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'NextProduct', N'Next')
END
IF NOT EXISTS (SELECT * FROM bvc_SiteTerm WHERE SiteTerm = 'PreviousProduct')
BEGIN
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PreviousProduct', N'Prev')
END
GO

-- WebAppSettings
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'CallbackWaitingMessage')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CallbackWaitingMessage', N'Please Wait...')
END
GO
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'CanonicalUrlEnabled')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CanonicalUrlEnabled', N'0')
END
GO
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'DatabaseV2015')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DatabaseV2015', N'1')
END
GO
IF (SELECT SettingValue FROM bvc_WebAppSetting WHERE SettingName = 'DefaultTextEditor') = 'Free Text Box'
BEGIN
UPDATE bvc_WebAppSetting SET SettingValue = 'TinyMCE' WHERE SettingName = 'DefaultTextEditor'
END
GO
IF EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'GiftWrapRate')
BEGIN
IF EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'GiftWrapCharge')
BEGIN
UPDATE bvc_WebAppSetting SET SettingValue = (SELECT SettingValue FROM bvc_WebAppSetting WHERE SettingName = 'GiftWrapRate') WHERE SettingName = 'GiftWrapCharge'
END
END
GO
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'GoogleTrustedStoresBadgeLocation')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleTrustedStoresBadgeLocation', N'BOTTOM_RIGHT')
END
GO
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'MetaTitleAppendStoreName')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MetaTitleAppendStoreName', N'1')
END
GO
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'SqlCommandTimeout')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SqlCommandTimeout', N'30')
END
GO
IF NOT EXISTS (SELECT * FROM bvc_WebAppSetting WHERE SettingName = 'ShippingDimensionCalculator')
BEGIN
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingDimensionCalculator', N'544942ab-4d85-4927-af35-a4721acf769c')
END
GO
BEGIN
UPDATE bvc_WebAppSetting SET SettingValue = '30' WHERE SettingName = 'CCSDaysOld'
END
GO

-- Workflows
IF NOT EXISTS (SELECT * FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'c84658fb-fc72-458a-b0e6-c1708d9e84f2' AND ControlName = 'BBB0800B-4ED6-4060-9FBA-1B8D7EEAA686')
BEGIN
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) SELECT '4c793fdf-9ef1-4ff1-8196-01dd605e581b', 'c84658fb-fc72-458a-b0e6-c1708d9e84f2', (SELECT CASE WHEN MAX(SortOrder) IS NULL THEN 1 ELSE MAX(SortOrder) + 1 END FROM bvc_WorkFlowStep WHERE WorkFlowBvin = 'c84658fb-fc72-458a-b0e6-c1708d9e84f2'), N'BBB0800B-4ED6-4060-9FBA-1B8D7EEAA686', N'Update Loyalty Points', '12/19/2013 11:08:29 AM', N'Update Loyalty Points'
END
GO
-- remove Google Checkout workflow steps
DELETE FROM bvc_WorkFlowStep
WHERE ControlName = 'c2c432db-ec35-4101-be16-48cbb4951663' OR ControlName = '9e1f141c-e9bf-4df5-801b-35b623dae3a8' OR ControlName = '0a91c490-df6c-4f88-9b12-cb65615ab758'

-- change country name for USPS real-time rates
UPDATE bvc_Country
SET DisplayName = 'United Arab Emirates'
WHERE DisplayName = 'U.A.E.'

EXEC [dbo].[bvc_Category_LatestProductCount_u]
GO

-- cart abandonment email template
IF NOT EXISTS (SELECT * FROM bvc_EmailTemplate WHERE bvin = '6312e781-9961-4384-82cb-84b1f2baa44f')
BEGIN
INSERT INTO [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES('6312e781-9961-4384-82cb-84b1f2baa44f', '<a href="[[Site.StandardUrl]]cart.aspx" style="border:none;"><IMG src="[[Site.Logo]]" border=0></a>    <br><br>    <div style="font-family:arial,sans-serif;">      <strong>Hey there,</strong> <br>      This is just a friendly reminder that you''ve got some pretty cool stuff in your shopping cart at [[Site.SiteName]].   </div>    <br><br>  <a href="[[Site.StandardUrl]]cart.aspx" style="font-family:arial,sans-serif;">Take me to my cart &raquo;</a>  <br>  <br>    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;font-family:Arial,sans-serif">  <tr>  <td colspan="2" style="font-weight:bold;background:#000;color:#fff;padding:5px;">Item</td>  <td style="font-weight:bold;background:#000;color:#fff;text-align:right;padding:5px;">Price</td>  <td style="font-weight:bold;background:#000;color:#fff;text-align:center;padding-left:15px;padding-top:5px;padding-bottom:5px;padding-right:15px;">Qty</td>  <td style="font-weight:bold;background:#000;color:#fff;text-align:right;padding:5px;">Total</td>  </tr>      [[RepeatingSection]]                      </table>       <br>  <a href="[[Site.StandardUrl]]cart.aspx" style="font-family:arial,sans-serif;">Take me to my cart &raquo;</a>  <br>  <br>', '', 'Shopping Cart Abandonment', 'orders@bvcommerce.com', '<tr>   <td align="left" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;width:80px;">    <a href="[[Site.StandardUrl]][[Product.ProductURL]]">     <img width="65" height="65" src="[[Site.StandardUrl]][[Product.ImageFileSmall]]" />    </a>   </td>         <td align="left" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;vertical-align:top;padding-right:15px;">    <a href="[[Site.StandardUrl]][[Product.ProductURL]]"><strong>[[Product.ProductName]]</strong></a>   </td>            <td align="right" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;">[[LineItem.AdjustedPrice]]</td>            <td align="left" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;text-align:center;">[[LineItem.Quantity]]</td>      <td align="right" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;"><strong>[[LineItem.LineTotal]]</strong></td>  </tr>', '', 0, 'Did you forget something?', '2014-03-31 16:43:14.267', '<a href="[[Site.StandardUrl]]cart.aspx" style="border:none;"><IMG src="[[Site.Logo]]" border=0></a>    <br><br>    <div style="font-family:arial,sans-serif;">      <strong>Hey there,</strong> <br>      This is just a friendly reminder that you''ve got some pretty cool stuff in your shopping cart at [[Site.SiteName]].   </div>    <br><br>  <a href="[[Site.StandardUrl]]cart.aspx" style="font-family:arial,sans-serif;">Take me to my cart &raquo;</a>  <br>  <br>    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;font-family:Arial,sans-serif">  <tr>  <td colspan="2" style="font-weight:bold;background:#000;color:#fff;padding:5px;">Item</td>  <td style="font-weight:bold;background:#000;color:#fff;text-align:right;padding:5px;">Price</td>  <td style="font-weight:bold;background:#000;color:#fff;text-align:center;padding-left:15px;padding-top:5px;padding-bottom:5px;padding-right:15px;">Qty</td>  <td style="font-weight:bold;background:#000;color:#fff;text-align:right;padding:5px;">Total</td>  </tr>      [[RepeatingSection]]                      </table>       <br>  <a href="[[Site.StandardUrl]]cart.aspx" style="font-family:arial,sans-serif;">Take me to my cart &raquo;</a>  <br>  <br>', '<tr>   <td align="left" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;width:80px;">    <a href="[[Site.StandardUrl]][[Product.ProductURL]]">     <img width="65" height="65" src="[[Site.StandardUrl]][[Product.ImageFileSmall]]" />    </a>   </td>         <td align="left" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;vertical-align:top;padding-right:15px;">    <a href="[[Site.StandardUrl]][[Product.ProductURL]]"><strong>[[Product.ProductName]]</strong></a>   </td>            <td align="right" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;">[[LineItem.AdjustedPrice]]</td>            <td align="left" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;text-align:center;">[[LineItem.Quantity]]</td>      <td align="right" valign="top" bgcolor="#E8E8E8" style="padding:5px;border-bottom:1px solid #fff;font-family:arial,sans-serif;"><strong>[[LineItem.LineTotal]]</strong></td>  </tr>')
END
GO

-- delete unsubmitted returns
DELETE ri FROM bvc_RMAItem AS ri
INNER JOIN bvc_RMA AS r ON ri.RMABvin = r.bvin
WHERE r.[Status] = 0
DELETE FROM bvc_RMA WHERE [Status] = 0

-- initialize CustomProperties field to prevent exception when loading category and user objects from database - code already updated to handle this scenario but this cleans up the data
UPDATE bvc_Category
SET CustomProperties = '<?xml version="1.0" encoding="utf-16"?>  <ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />'
WHERE CustomProperties = '' OR CustomProperties IS NULL
UPDATE bvc_User
SET CustomProperties = '<?xml version="1.0" encoding="utf-16"?>  <ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />'
WHERE CustomProperties = '' OR CustomProperties IS NULL

-- populate child product ExtraShipFee field using the parent's value since this field can now be set at the child level
UPDATE child
SET child.ExtraShipFee = parent.ExtraShipFee
FROM bvc_Product AS child
JOIN bvc_Product AS parent ON parent.bvin = child.ParentId

-- fix country information for North Korea
UPDATE bvc_Country
SET CultureCode = 'ko-KP',
	ISOCode = 'KP',
	ISOAlpha3 = 'PRK',
	ISONumeric = '408'
WHERE bvin = '57E083A5-43B6-47f5-90AF-E7153794F0C9'

-- fix Maldives culture code
UPDATE bvc_Country
SET CultureCode = 'dv-MV'
WHERE bvin = '271f61fc-9f93-4ac2-bcda-d62640e23489'

-- clean up product data from admin dummy values
UPDATE bvc_Product
SET ManufacturerId = ''
WHERE ManufacturerId = '- No Manufacturer -'

UPDATE bvc_Product
SET VendorId = ''
WHERE VendorId = '- No Vendor -'

UPDATE bvc_Product
SET PreContentColumnId = ''
WHERE PreContentColumnId = ' - None -'

UPDATE bvc_Product
SET PostContentColumnId = ''
WHERE PostContentColumnId = ' - None -'

-- clean out expired authentication tokens
exec bvc_AuthenticationToken_Expired_d

-- disable inventory and gift wrapping for gift certificates
UPDATE bvc_Product
SET 
	TrackInventory = 0,
	GiftWrapAllowed = 0
WHERE SpecialProductType = 1 OR SpecialProductType = 2