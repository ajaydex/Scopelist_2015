/*
Script created by SQL Data Compare version 7.1.0.230 from Red Gate Software Ltd at 11/4/2008 5:19:48 PM

Run this script on (local).bv532before

This script will make changes to (local).bv532before to make it the same as (local).bv54full

Note that this script will carry out all DELETE commands for all tables first, then all the UPDATES and then all the INSERTS
It will disable foreign key constraints at the beginning of the script, and re-enable them at the end
*/
SET NUMERIC_ROUNDABORT OFF
GO
SET XACT_ABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
GO
SET DATEFORMAT YMD
GO
-- Pointer used for text / image updates. This might not be needed, but is declared here just in case
DECLARE @pv binary(16)

BEGIN TRANSACTION

-- Drop constraints from [dbo].[bvc_WorkFlowStep]
ALTER TABLE [dbo].[bvc_WorkFlowStep] DROP CONSTRAINT [FK_bvc_WorkFlowStep_bvc_WorkFlow]

-- Add 2 rows to [dbo].[bvc_SiteTerm]
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'BabyRegistry', N'Baby Registry')
INSERT INTO [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'WeddingRegistry', N'Wedding Registry')

-- Add 5 rows to [dbo].[bvc_WebAppSetting]
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AllowedWishLists', N'3')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableBabyRegistry', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableWeddingRegistry', N'1')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftWrapAll', N'0')
INSERT INTO [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftWrapRate', N'0.00')

-- Add 3 rows to [dbo].[bvc_EmailTemplate]
INSERT INTO [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES ('40e873e5-7712-4383-a0d7-d0de9b486f4d', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to view their Baby Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'', N'Baby Registry Template', N'admin@store.com', N'', N'', 0, N'[[List.UserEmail]] has invited you to view their Baby Registry!', '2007-10-30 10:33:33.000', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to view their Baby Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'')
INSERT INTO [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES ('6b862817-c18b-4707-b81a-4b6515fa6694', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to see their Wishlist! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'', N'Wishlist Template', N'admin@store.com', N'', N'', 0, N'[[List.UserEmail]] has invited you to view their Wishlist!', '2007-10-30 10:31:51.000', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to see their Wishlist! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'')
INSERT INTO [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES ('8aa40d09-93dc-4e9c-bb8f-44b2052ca1dc', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
/head>

<body>
[[List.UserEmail]] has invited you to view their Wedding Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'', N'Wedding Registry Template', N'admin@store.com', N'', N'', 0, N'[[List.UserEmail]] has invited you to view their Wedding Registry!', '2007-10-30 10:32:44.000', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
/head>

<body>
[[List.UserEmail]] has invited you to view their Wedding Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'')

-- Add 1 row to [dbo].[bvc_WorkFlowStep]
INSERT INTO [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES ('66533d0b-6b37-4bad-80d5-ef70866a4d68', 'eac003c6-a354-489f-ba2c-029f4311851a', 15, N'A3AC0B3C-FB69-477B-95AB-2DC54D33F693', N'Update List Items', '2007-10-29 10:37:55.000', N'Update List Items')

-- Add constraints to [dbo].[bvc_WorkFlowStep]
ALTER TABLE [dbo].[bvc_WorkFlowStep] WITH NOCHECK ADD CONSTRAINT [FK_bvc_WorkFlowStep_bvc_WorkFlow] FOREIGN KEY ([WorkFlowBvin]) REFERENCES [dbo].[bvc_WorkFlow] ([bvin])

COMMIT TRANSACTION
GO