SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
SET XACT_ABORT ON
GO
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
GO
PRINT N'Creating [dbo].[bvc_ProductXChoice]'
GO
CREATE TABLE [dbo].[bvc_ProductXChoice]
(
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChoiceId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductXChoice] on [dbo].[bvc_ProductXChoice]'
GO
ALTER TABLE [dbo].[bvc_ProductXChoice] ADD CONSTRAINT [PK_bvc_ProductXChoice] PRIMARY KEY CLUSTERED  ([ProductId], [ChoiceId])
GO
PRINT N'Creating [dbo].[bvc_PrintTemplate]'
GO
CREATE TABLE [dbo].[bvc_PrintTemplate]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Body] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RepeatingSection] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemTemplate] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_PrintTemplate] on [dbo].[bvc_PrintTemplate]'
GO
ALTER TABLE [dbo].[bvc_PrintTemplate] ADD CONSTRAINT [PK_bvc_PrintTemplate] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_MailingListMember]'
GO
CREATE TABLE [dbo].[bvc_MailingListMember]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ListID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_MailingListMember_1] on [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] ADD CONSTRAINT [PK_bvc_MailingListMember_1] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_GiftCertificate]'
GO
CREATE TABLE [dbo].[bvc_GiftCertificate]
(
[Bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LineItemId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CertificateCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DateIssued] [datetime] NOT NULL,
[OriginalAmount] [numeric] (18, 10) NOT NULL,
[CurrentAmount] [numeric] (18, 10) NOT NULL,
[AssociatedProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_GiftCertificate] on [dbo].[bvc_GiftCertificate]'
GO
ALTER TABLE [dbo].[bvc_GiftCertificate] ADD CONSTRAINT [PK_bvc_GiftCertificate] PRIMARY KEY CLUSTERED  ([Bvin])
GO
PRINT N'Creating index [IX_bvc_GiftCertificate] on [dbo].[bvc_GiftCertificate]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_GiftCertificate] ON [dbo].[bvc_GiftCertificate] ([CertificateCode])
GO
PRINT N'Creating [dbo].[bvc_SearchQuery]'
GO
CREATE TABLE [dbo].[bvc_SearchQuery]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QueryPhrase] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShopperId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_SearchQuery] on [dbo].[bvc_SearchQuery]'
GO
ALTER TABLE [dbo].[bvc_SearchQuery] ADD CONSTRAINT [PK_bvc_SearchQuery] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ComponentSetting]'
GO
CREATE TABLE [dbo].[bvc_ComponentSetting]
(
[ComponentID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeveloperId] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ComponentType] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ComponentSubType] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ComponentSetting] on [dbo].[bvc_ComponentSetting]'
GO
ALTER TABLE [dbo].[bvc_ComponentSetting] ADD CONSTRAINT [PK_bvc_ComponentSetting] PRIMARY KEY CLUSTERED  ([ComponentID], [SettingName])
GO
PRINT N'Creating index [IX_bvc_ComponentSetting] on [dbo].[bvc_ComponentSetting]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ComponentSetting] ON [dbo].[bvc_ComponentSetting] ([ComponentID])
GO
PRINT N'Creating [dbo].[bvc_ProductChoiceOptions]'
GO
CREATE TABLE [dbo].[bvc_ProductChoiceOptions]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductChoiceId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductChoiceName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL,
[Default] [bit] NOT NULL,
[Null] [bit] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductChoiceOptions] on [dbo].[bvc_ProductChoiceOptions]'
GO
ALTER TABLE [dbo].[bvc_ProductChoiceOptions] ADD CONSTRAINT [PK_bvc_ProductChoiceOptions] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductChoiceOptions_ProductChoiceId] on [dbo].[bvc_ProductChoiceOptions]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductChoiceOptions_ProductChoiceId] ON [dbo].[bvc_ProductChoiceOptions] ([ProductChoiceId])
GO
PRINT N'Creating [dbo].[bvc_ProductChoiceInputOrder]'
GO
CREATE TABLE [dbo].[bvc_ProductChoiceInputOrder]
(
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChoiceInputId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductChoiceInputOrder] on [dbo].[bvc_ProductChoiceInputOrder]'
GO
ALTER TABLE [dbo].[bvc_ProductChoiceInputOrder] ADD CONSTRAINT [PK_bvc_ProductChoiceInputOrder] PRIMARY KEY CLUSTERED  ([ProductId], [ChoiceInputId], [Order])
GO
PRINT N'Creating [dbo].[bvc_ProductChoiceCombinations]'
GO
CREATE TABLE [dbo].[bvc_ProductChoiceCombinations]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChoiceId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChoiceOptionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ParentProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Available] [bit] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductVariations] on [dbo].[bvc_ProductChoiceCombinations]'
GO
ALTER TABLE [dbo].[bvc_ProductChoiceCombinations] ADD CONSTRAINT [PK_bvc_ProductVariations] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [bvc_ProductChoiceCombinations_ChoiceId_ChoiceOptionId] on [dbo].[bvc_ProductChoiceCombinations]'
GO
CREATE NONCLUSTERED INDEX [bvc_ProductChoiceCombinations_ChoiceId_ChoiceOptionId] ON [dbo].[bvc_ProductChoiceCombinations] ([ChoiceId], [ChoiceOptionId], [bvin], [ProductId])
GO
PRINT N'Creating index [IX_bvc_ProductChoiceCombinations] on [dbo].[bvc_ProductChoiceCombinations]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductChoiceCombinations] ON [dbo].[bvc_ProductChoiceCombinations] ([ParentProductId], [ProductId])
GO
PRINT N'Creating [dbo].[bvc_WebAppSetting]'
GO
CREATE TABLE [dbo].[bvc_WebAppSetting]
(
[SettingName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SettingValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_WebAppSetting] on [dbo].[bvc_WebAppSetting]'
GO
ALTER TABLE [dbo].[bvc_WebAppSetting] ADD CONSTRAINT [PK_bvc_WebAppSetting] PRIMARY KEY CLUSTERED  ([SettingName])
GO
PRINT N'Creating [dbo].[bvc_Region]'
GO
CREATE TABLE [dbo].[bvc_Region]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Abbreviation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Region] on [dbo].[bvc_Region]'
GO
ALTER TABLE [dbo].[bvc_Region] ADD CONSTRAINT [PK_bvc_Region] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_County]'
GO
CREATE TABLE [dbo].[bvc_County]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegionID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_County] on [dbo].[bvc_County]'
GO
ALTER TABLE [dbo].[bvc_County] ADD CONSTRAINT [PK_bvc_County] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_OrderNote]'
GO
CREATE TABLE [dbo].[bvc_OrderNote]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OrderId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AuditDate] [datetime] NOT NULL,
[Note] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NoteType] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_OrderNote] on [dbo].[bvc_OrderNote]'
GO
ALTER TABLE [dbo].[bvc_OrderNote] ADD CONSTRAINT [PK_bvc_OrderNote] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_OrderNote] on [dbo].[bvc_OrderNote]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_OrderNote] ON [dbo].[bvc_OrderNote] ([OrderId])
GO
PRINT N'Creating [dbo].[bvc_RMAItem]'
GO
CREATE TABLE [dbo].[bvc_RMAItem]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RMABvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LineItemBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ItemName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ItemDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Note] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Reason] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Replace] [bit] NOT NULL,
[Quantity] [int] NOT NULL,
[QuantityReceived] [int] NOT NULL,
[QuantityReturnedToInventory] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating index [IX_bvc_RMAItem] on [dbo].[bvc_RMAItem]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_bvc_RMAItem] ON [dbo].[bvc_RMAItem] ([bvin])
GO
PRINT N'Creating primary key [PK_bvc_RMAItem] on [dbo].[bvc_RMAItem]'
GO
ALTER TABLE [dbo].[bvc_RMAItem] ADD CONSTRAINT [PK_bvc_RMAItem] PRIMARY KEY NONCLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_RMAItem_1] on [dbo].[bvc_RMAItem]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_RMAItem_1] ON [dbo].[bvc_RMAItem] ([RMABvin])
GO
PRINT N'Creating index [IX_bvc_RMAItem_LineItemBvin] on [dbo].[bvc_RMAItem]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_RMAItem_LineItemBvin] ON [dbo].[bvc_RMAItem] ([LineItemBvin]) WITH (ALLOW_PAGE_LOCKS=OFF)
GO
PRINT N'Creating [dbo].[bvc_ProductUpSell]'
GO
CREATE TABLE [dbo].[bvc_ProductUpSell]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UpSellBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL,
[DescriptionOverride] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductUpSell] on [dbo].[bvc_ProductUpSell]'
GO
ALTER TABLE [dbo].[bvc_ProductUpSell] ADD CONSTRAINT [PK_bvc_ProductUpSell] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductUpSell] on [dbo].[bvc_ProductUpSell]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_ProductUpSell] ON [dbo].[bvc_ProductUpSell] ([ProductBvin], [Order])
GO
PRINT N'Creating [dbo].[bvc_ProductPropertyValue]'
GO
CREATE TABLE [dbo].[bvc_ProductPropertyValue]
(
[ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductPropertyValue] on [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] ADD CONSTRAINT [PK_bvc_ProductPropertyValue] PRIMARY KEY CLUSTERED  ([ProductBvin], [PropertyBvin])
GO
PRINT N'Creating [dbo].[bvc_ProductModifierOption]'
GO
CREATE TABLE [dbo].[bvc_ProductModifierOption]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifierId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL,
[CostAdjustment] [numeric] (18, 10) NOT NULL,
[PriceAdjustment] [numeric] (18, 10) NOT NULL,
[ShippingAdjustment] [numeric] (18, 10) NOT NULL,
[WeightAdjustment] [numeric] (18, 10) NOT NULL,
[IsDefault] [bit] NOT NULL,
[Null] [bit] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductModifierOption] on [dbo].[bvc_ProductModifierOption]'
GO
ALTER TABLE [dbo].[bvc_ProductModifierOption] ADD CONSTRAINT [PK_bvc_ProductModifierOption] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductModifierOption_ModifierId] on [dbo].[bvc_ProductModifierOption]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductModifierOption_ModifierId] ON [dbo].[bvc_ProductModifierOption] ([ModifierId])
GO
PRINT N'Creating [dbo].[bvc_ProductFile]'
GO
CREATE TABLE [dbo].[bvc_ProductFile]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShortDescription] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductFile] on [dbo].[bvc_ProductFile]'
GO
ALTER TABLE [dbo].[bvc_ProductFile] ADD CONSTRAINT [PK_bvc_ProductFile] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductFile] on [dbo].[bvc_ProductFile]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_ProductFile] ON [dbo].[bvc_ProductFile] ([FileName], [ShortDescription])
GO
PRINT N'Creating [dbo].[bvc_ProductCrossSell]'
GO
CREATE TABLE [dbo].[bvc_ProductCrossSell]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CrossSellBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL,
[DescriptionOverride] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductCrossSell] on [dbo].[bvc_ProductCrossSell]'
GO
ALTER TABLE [dbo].[bvc_ProductCrossSell] ADD CONSTRAINT [PK_bvc_ProductCrossSell] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductCrossSell] on [dbo].[bvc_ProductCrossSell]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_ProductCrossSell] ON [dbo].[bvc_ProductCrossSell] ([ProductBvin], [Order])
GO
PRINT N'Creating [dbo].[bvc_ProductReview]'
GO
CREATE TABLE [dbo].[bvc_ProductReview]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[lastUpdated] [datetime] NOT NULL,
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Approved] [int] NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Karma] [int] NOT NULL,
[ReviewDate] [datetime] NOT NULL,
[Rating] [int] NOT NULL,
[UserID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (151) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductReview_UserName] DEFAULT (N''),
[UserEmail] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductReview_UserEmail] DEFAULT (N'')
)
GO
PRINT N'Creating index [IX_bvc_ProductReview] on [dbo].[bvc_ProductReview]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_bvc_ProductReview] ON [dbo].[bvc_ProductReview] ([id])
GO
PRINT N'Creating primary key [PK_bvc_ProductReview] on [dbo].[bvc_ProductReview]'
GO
ALTER TABLE [dbo].[bvc_ProductReview] ADD CONSTRAINT [PK_bvc_ProductReview] PRIMARY KEY NONCLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductReview_ProductBvin] on [dbo].[bvc_ProductReview]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductReview_ProductBvin] ON [dbo].[bvc_ProductReview] ([ProductBvin])
GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_CountryRestriction]'
GO
CREATE TABLE [dbo].[bvc_ShippingMethod_CountryRestriction]
(
[ShippingMethodBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ShippingMethod_CountryRestriction] on [dbo].[bvc_ShippingMethod_CountryRestriction]'
GO
ALTER TABLE [dbo].[bvc_ShippingMethod_CountryRestriction] ADD CONSTRAINT [PK_bvc_ShippingMethod_CountryRestriction] PRIMARY KEY CLUSTERED  ([ShippingMethodBvin], [CountryBvin])
GO
PRINT N'Creating [dbo].[bvc_ShippingMethod]'
GO
CREATE TABLE [dbo].[bvc_ShippingMethod]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[Adjustment] [decimal] (18, 10) NOT NULL,
[AdjustmentType] [int] NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShippingProviderId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ShippingMethod] on [dbo].[bvc_ShippingMethod]'
GO
ALTER TABLE [dbo].[bvc_ShippingMethod] ADD CONSTRAINT [PK_bvc_ShippingMethod] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_Address]'
GO
CREATE TABLE [dbo].[bvc_Address]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[Bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[NickName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MiddleInitial] [nvarchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Company] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Line1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Line2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Line3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[City] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegionBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegionName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PostalCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountyBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountyName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[WebSiteUrl] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Address] on [dbo].[bvc_Address]'
GO
ALTER TABLE [dbo].[bvc_Address] ADD CONSTRAINT [PK_bvc_Address] PRIMARY KEY NONCLUSTERED  ([Bvin])
GO
PRINT N'Creating [dbo].[bvc_ShippingMethod_RegionRestriction]'
GO
CREATE TABLE [dbo].[bvc_ShippingMethod_RegionRestriction]
(
[ShippingMethodBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegionBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ShippingMethod_RegionRestriction] on [dbo].[bvc_ShippingMethod_RegionRestriction]'
GO
ALTER TABLE [dbo].[bvc_ShippingMethod_RegionRestriction] ADD CONSTRAINT [PK_bvc_ShippingMethod_RegionRestriction] PRIMARY KEY CLUSTERED  ([ShippingMethodBvin], [RegionBvin])
GO
PRINT N'Creating [dbo].[bvc_UserXRole]'
GO
CREATE TABLE [dbo].[bvc_UserXRole]
(
[UserID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RoleID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_UserXRole] on [dbo].[bvc_UserXRole]'
GO
ALTER TABLE [dbo].[bvc_UserXRole] ADD CONSTRAINT [PK_bvc_UserXRole] PRIMARY KEY CLUSTERED  ([UserID], [RoleID])
GO
PRINT N'Creating [dbo].[bvc_UserXContact]'
GO
CREATE TABLE [dbo].[bvc_UserXContact]
(
[ContactId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_UserXAffiliate] on [dbo].[bvc_UserXContact]'
GO
ALTER TABLE [dbo].[bvc_UserXContact] ADD CONSTRAINT [PK_bvc_UserXAffiliate] PRIMARY KEY CLUSTERED  ([ContactId], [UserId])
GO
PRINT N'Creating [dbo].[bvc_Manufacturer]'
GO
CREATE TABLE [dbo].[bvc_Manufacturer]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DropShipEmailTemplateId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Manufacturer] on [dbo].[bvc_Manufacturer]'
GO
ALTER TABLE [dbo].[bvc_Manufacturer] ADD CONSTRAINT [PK_bvc_Manufacturer] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ProductFileXProduct]'
GO
CREATE TABLE [dbo].[bvc_ProductFileXProduct]
(
[ProductFileId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AvailableMinutes] [int] NOT NULL,
[MaxDownloads] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductFileXProduct] on [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] ADD CONSTRAINT [PK_bvc_ProductFileXProduct] PRIMARY KEY CLUSTERED  ([ProductFileId], [ProductId])
GO
PRINT N'Creating index [IX_bvc_ProductFileXProduct] on [dbo].[bvc_ProductFileXProduct]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductFileXProduct] ON [dbo].[bvc_ProductFileXProduct] ([ProductFileId])
GO
PRINT N'Creating [dbo].[bvc_ContentBlock]'
GO
CREATE TABLE [dbo].[bvc_ContentBlock]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ColumnID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL,
[ControlName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ContentBlock] on [dbo].[bvc_ContentBlock]'
GO
ALTER TABLE [dbo].[bvc_ContentBlock] ADD CONSTRAINT [PK_bvc_ContentBlock] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_RoleXRolePermission]'
GO
CREATE TABLE [dbo].[bvc_RoleXRolePermission]
(
[RoleID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PermissionID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_RoleXRolePermission] on [dbo].[bvc_RoleXRolePermission]'
GO
ALTER TABLE [dbo].[bvc_RoleXRolePermission] ADD CONSTRAINT [PK_bvc_RoleXRolePermission] PRIMARY KEY CLUSTERED  ([RoleID], [PermissionID])
GO
PRINT N'Creating [dbo].[bvc_Vendor]'
GO
CREATE TABLE [dbo].[bvc_Vendor]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DropShipEmailTemplateId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Vendor] on [dbo].[bvc_Vendor]'
GO
ALTER TABLE [dbo].[bvc_Vendor] ADD CONSTRAINT [PK_bvc_Vendor] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_MailingList]'
GO
CREATE TABLE [dbo].[bvc_MailingList]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Private] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_MailingList] on [dbo].[bvc_MailingList]'
GO
ALTER TABLE [dbo].[bvc_MailingList] ADD CONSTRAINT [PK_bvc_MailingList] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_DropShipNotification]'
GO
CREATE TABLE [dbo].[bvc_DropShipNotification]
(
[Bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OrderBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TimeOfRequest] [datetime] NOT NULL,
[Processed] [bit] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_DropShipNotification] on [dbo].[bvc_DropShipNotification]'
GO
ALTER TABLE [dbo].[bvc_DropShipNotification] ADD CONSTRAINT [PK_bvc_DropShipNotification] PRIMARY KEY CLUSTERED  ([Bvin])
GO
PRINT N'Creating [dbo].[bvc_Offers]'
GO
CREATE TABLE [dbo].[bvc_Offers]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StartDate] [datetime] NOT NULL,
[EndDate] [datetime] NOT NULL,
[OfferType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RequiresCouponCode] [bit] NOT NULL,
[GenerateUniquePromotionalCodes] [bit] NOT NULL,
[PromotionalCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UseType] [int] NOT NULL,
[UseTimes] [int] NOT NULL,
[CantBeCombined] [bit] NOT NULL,
[Enabled] [bit] NOT NULL,
[Order] [int] NOT NULL,
[Priority] [tinyint] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating index [IX_bvc_Offers] on [dbo].[bvc_Offers]'
GO
CREATE CLUSTERED INDEX [IX_bvc_Offers] ON [dbo].[bvc_Offers] ([Priority], [Order])
GO
PRINT N'Creating primary key [PK_bvc_Offers] on [dbo].[bvc_Offers]'
GO
ALTER TABLE [dbo].[bvc_Offers] ADD CONSTRAINT [PK_bvc_Offers] PRIMARY KEY NONCLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ProductType]'
GO
CREATE TABLE [dbo].[bvc_ProductType]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductTypeName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsPermanent] [bit] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_ProductType] on [dbo].[bvc_ProductType]'
GO
ALTER TABLE [dbo].[bvc_ProductType] ADD CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ContentColumn]'
GO
CREATE TABLE [dbo].[bvc_ContentColumn]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemColumn] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ContentColumn] on [dbo].[bvc_ContentColumn]'
GO
ALTER TABLE [dbo].[bvc_ContentColumn] ADD CONSTRAINT [PK_bvc_ContentColumn] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_KitGroup]'
GO
CREATE TABLE [dbo].[bvc_KitGroup]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrder] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_KitGroup] on [dbo].[bvc_KitGroup]'
GO
ALTER TABLE [dbo].[bvc_KitGroup] ADD CONSTRAINT [PK_bvc_KitGroup] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ProductXModifier]'
GO
CREATE TABLE [dbo].[bvc_ProductXModifier]
(
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifierId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductXModifier] on [dbo].[bvc_ProductXModifier]'
GO
ALTER TABLE [dbo].[bvc_ProductXModifier] ADD CONSTRAINT [PK_bvc_ProductXModifier] PRIMARY KEY CLUSTERED  ([ProductId], [ModifierId])
GO
PRINT N'Creating [dbo].[bvc_ProductFilter]'
GO
CREATE TABLE [dbo].[bvc_ProductFilter]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FilterName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Criteria] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Page] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductFilter] on [dbo].[bvc_ProductFilter]'
GO
ALTER TABLE [dbo].[bvc_ProductFilter] ADD CONSTRAINT [PK_bvc_ProductFilter] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_Sale]'
GO
CREATE TABLE [dbo].[bvc_Sale]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SaleType] [int] NOT NULL,
[DiscountType] [int] NOT NULL,
[AllowSaleBelowCost] [bit] NOT NULL,
[Amount] [decimal] (18, 10) NOT NULL,
[StartDate] [datetime] NOT NULL,
[EndDate] [datetime] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Sales] on [dbo].[bvc_Sale]'
GO
ALTER TABLE [dbo].[bvc_Sale] ADD CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_Sale] on [dbo].[bvc_Sale]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Sale] ON [dbo].[bvc_Sale] ([StartDate], [EndDate])
GO
PRINT N'Creating [dbo].[bvc_OrderCoupon]'
GO
CREATE TABLE [dbo].[bvc_OrderCoupon]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[CouponCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OrderBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_OrderCoupon] on [dbo].[bvc_OrderCoupon]'
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] ADD CONSTRAINT [PK_bvc_OrderCoupon] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_OrderCoupon_OrderBvin] on [dbo].[bvc_OrderCoupon]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_OrderCoupon_OrderBvin] ON [dbo].[bvc_OrderCoupon] ([OrderBvin])
GO
PRINT N'Creating [dbo].[bvc_SaleXProductType]'
GO
CREATE TABLE [dbo].[bvc_SaleXProductType]
(
[SaleId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductTypeId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating index [IX_bvc_SaleXProductType] on [dbo].[bvc_SaleXProductType]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_bvc_SaleXProductType] ON [dbo].[bvc_SaleXProductType] ([SaleId], [ProductTypeId])
GO
PRINT N'Creating primary key [PK_bvc_SaleXProductType] on [dbo].[bvc_SaleXProductType]'
GO
ALTER TABLE [dbo].[bvc_SaleXProductType] ADD CONSTRAINT [PK_bvc_SaleXProductType] PRIMARY KEY NONCLUSTERED  ([SaleId], [ProductTypeId])
GO
PRINT N'Creating [dbo].[bvc_SaleXProduct]'
GO
CREATE TABLE [dbo].[bvc_SaleXProduct]
(
[SaleId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating index [IX_bvc_SaleXProduct] on [dbo].[bvc_SaleXProduct]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_bvc_SaleXProduct] ON [dbo].[bvc_SaleXProduct] ([SaleId], [ProductId])
GO
PRINT N'Creating primary key [PK_bvc_SaleXProduct] on [dbo].[bvc_SaleXProduct]'
GO
ALTER TABLE [dbo].[bvc_SaleXProduct] ADD CONSTRAINT [PK_bvc_SaleXProduct] PRIMARY KEY NONCLUSTERED  ([SaleId], [ProductId])
GO
PRINT N'Creating [dbo].[bvc_SaleXCategory]'
GO
CREATE TABLE [dbo].[bvc_SaleXCategory]
(
[SaleId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CategoryId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating index [IX_bvc_SaleXCategory] on [dbo].[bvc_SaleXCategory]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_bvc_SaleXCategory] ON [dbo].[bvc_SaleXCategory] ([SaleId], [CategoryId])
GO
PRINT N'Creating primary key [PK_bvc_SaleXCategory] on [dbo].[bvc_SaleXCategory]'
GO
ALTER TABLE [dbo].[bvc_SaleXCategory] ADD CONSTRAINT [PK_bvc_SaleXCategory] PRIMARY KEY NONCLUSTERED  ([SaleId], [CategoryId])
GO
PRINT N'Creating [dbo].[bvc_ProductXInput]'
GO
CREATE TABLE [dbo].[bvc_ProductXInput]
(
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InputId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductXInput] on [dbo].[bvc_ProductXInput]'
GO
ALTER TABLE [dbo].[bvc_ProductXInput] ADD CONSTRAINT [PK_bvc_ProductXInput] PRIMARY KEY CLUSTERED  ([ProductId], [InputId])
GO
PRINT N'Creating [dbo].[bvc_Policy]'
GO
CREATE TABLE [dbo].[bvc_Policy]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Title] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemPolicy] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Policy] on [dbo].[bvc_Policy]'
GO
ALTER TABLE [dbo].[bvc_Policy] ADD CONSTRAINT [PK_bvc_Policy] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_AffiliateReferral]'
GO
CREATE TABLE [dbo].[bvc_AffiliateReferral]
(
[id] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[affid] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[referrerurl] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TimeOfReferral] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_AffiliateReferral] on [dbo].[bvc_AffiliateReferral]'
GO
ALTER TABLE [dbo].[bvc_AffiliateReferral] ADD CONSTRAINT [PK_bvc_AffiliateReferral] PRIMARY KEY CLUSTERED  ([id])
GO
PRINT N'Creating index [IX_bvc_AffiliateReferral] on [dbo].[bvc_AffiliateReferral]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_AffiliateReferral] ON [dbo].[bvc_AffiliateReferral] ([affid])
GO
PRINT N'Creating [dbo].[bvc_SiteTerm]'
GO
CREATE TABLE [dbo].[bvc_SiteTerm]
(
[SiteTerm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SiteTermValue] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_SiteTerm] on [dbo].[bvc_SiteTerm]'
GO
ALTER TABLE [dbo].[bvc_SiteTerm] ADD CONSTRAINT [PK_bvc_SiteTerm] PRIMARY KEY CLUSTERED  ([SiteTerm])
GO
PRINT N'Creating [dbo].[bvc_Fraud]'
GO
CREATE TABLE [dbo].[bvc_Fraud]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RuleType] [int] NOT NULL,
[RuleValue] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Fraud] on [dbo].[bvc_Fraud]'
GO
ALTER TABLE [dbo].[bvc_Fraud] ADD CONSTRAINT [PK_bvc_Fraud] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_AuthenticationToken]'
GO
CREATE TABLE [dbo].[bvc_AuthenticationToken]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ExpirationDate] [datetime] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_AuthenticationToken] on [dbo].[bvc_AuthenticationToken]'
GO
ALTER TABLE [dbo].[bvc_AuthenticationToken] ADD CONSTRAINT [PK_bvc_AuthenticationToken] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_PriceGroup]'
GO
CREATE TABLE [dbo].[bvc_PriceGroup]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PricingType] [int] NOT NULL,
[AdjustmentAmount] [numeric] (18, 10) NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_PriceGroup] on [dbo].[bvc_PriceGroup]'
GO
ALTER TABLE [dbo].[bvc_PriceGroup] ADD CONSTRAINT [PK_bvc_PriceGroup] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_TaxClass]'
GO
CREATE TABLE [dbo].[bvc_TaxClass]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_TaxClass] on [dbo].[bvc_TaxClass]'
GO
ALTER TABLE [dbo].[bvc_TaxClass] ADD CONSTRAINT [PK_bvc_TaxClass] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_CustomPage]'
GO
CREATE TABLE [dbo].[bvc_CustomPage]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Content] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShowInTopMenu] [int] NOT NULL,
[ShowInBottomMenu] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[PreTransformContent] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_PreTransformContent] DEFAULT (N''),
[MetaDescription] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_MetaDescription] DEFAULT (N''),
[MetaKeywords] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_MetaKeywords] DEFAULT (N''),
[MetaTitle] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_MetaTitle] DEFAULT (N''),
[TemplateName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_TemplateName] DEFAULT (N''),
[PreContentColumnId] [nvarchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_PreContentColumnId] DEFAULT (N''),
[PostContentColumnId] [nvarchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_CustomPage_PostContentColumnId] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_bvc_CustomPage] on [dbo].[bvc_CustomPage]'
GO
ALTER TABLE [dbo].[bvc_CustomPage] ADD CONSTRAINT [PK_bvc_CustomPage] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_Order]'
GO
CREATE TABLE [dbo].[bvc_Order]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[Bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AffiliateId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BillingAddress] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomProperties] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_CustomProperties] DEFAULT (N''),
[FraudScore] [decimal] (18, 2) NOT NULL CONSTRAINT [DF_bvc_Order_FraudScore] DEFAULT ((-1)),
[GrandTotal] [decimal] (18, 10) NOT NULL,
[HandlingTotal] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Order_HandlingTotal] DEFAULT ((0)),
[Instructions] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_Instructions] DEFAULT (N''),
[IsPlaced] [int] NOT NULL CONSTRAINT [DF_bvc_Order_IsPlaced] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL,
[OrderDiscounts] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Order_OrderDiscounts] DEFAULT ((0)),
[OrderNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_OrderNumber] DEFAULT (N''),
[PaymentStatus] [int] NOT NULL,
[ShippingAddress] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_ShippingAddress] DEFAULT (N''),
[ShippingDiscounts] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Order_ShippingDiscounts] DEFAULT ((0)),
[ShippingMethodId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_ShippingMethodId] DEFAULT (''),
[ShippingMethodDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_ShippingMethodDisplayName] DEFAULT (N''),
[ShippingProviderId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_ShippingProviderId] DEFAULT (''),
[ShippingProviderServiceCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_ShippingProviderServiceCode] DEFAULT (N''),
[ShippingStatus] [int] NOT NULL,
[ShippingTotal] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Order_ShippingTotal] DEFAULT ((0)),
[SubTotal] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Order_SubTotal] DEFAULT ((0)),
[TaxTotal] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Order_TaxTotal] DEFAULT ((0)),
[TaxTotal2] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Order_TaxTotal2] DEFAULT ((0)),
[TimeOfOrder] [datetime] NOT NULL,
[UserEmail] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_UserEmail] DEFAULT (N''),
[UserId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StatusCode] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_StatusCode] DEFAULT (''),
[StatusName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_StatusName] DEFAULT (N''),
[GiftCertificates] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastProductAdded] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ThirdPartyOrderId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_ThirdPartyOrderId] DEFAULT (''),
[SalesPersonId] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Order_SalesPersonId] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_bvc_Order] on [dbo].[bvc_Order]'
GO
ALTER TABLE [dbo].[bvc_Order] ADD CONSTRAINT [PK_bvc_Order] PRIMARY KEY NONCLUSTERED  ([Bvin])
GO
PRINT N'Creating index [IX_bvc_Order_OrderNumber] on [dbo].[bvc_Order]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Order_OrderNumber] ON [dbo].[bvc_Order] ([OrderNumber])
GO
PRINT N'Creating index [IX_bvc_Order_UserId] on [dbo].[bvc_Order]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Order_UserId] ON [dbo].[bvc_Order] ([UserId])
GO
PRINT N'Creating [dbo].[bvc_Category]'
GO
CREATE TABLE [dbo].[bvc_Category]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ParentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL,
[MetaTitle] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MetaKeywords] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MetaDescription] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ImageURL] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BannerImageURL] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceType] [int] NOT NULL,
[DisplaySortOrder] [int] NOT NULL,
[LatestProductCount] [int] NOT NULL,
[CustomPageURL] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomPageNewWindow] [int] NOT NULL,
[MenuOffImageURL] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MenuOnImageURL] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShowInTopMenu] [int] NOT NULL,
[Hidden] [int] NOT NULL,
[TemplateName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PostContentColumnId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PreContentColumnId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[RewriteUrl] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShowTitle] [int] NOT NULL CONSTRAINT [DF_bvc_Category_ShowTitle] DEFAULT ((1)),
[Criteria] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomPageId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PreTransformDescription] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Category_PreTransformDescription] DEFAULT (N''),
[Keywords] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomerChangeableSortOrder] [bit] NOT NULL CONSTRAINT [DF_bvc_Category_CustomerChangeableSortOrder] DEFAULT ((0)),
[ShortDescription] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Category_ShortDescription] DEFAULT (N''),
[CustomProperties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Category_CustomProperties] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_bvc_Category] on [dbo].[bvc_Category]'
GO
ALTER TABLE [dbo].[bvc_Category] ADD CONSTRAINT [PK_bvc_Category] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_Category] on [dbo].[bvc_Category]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Category] ON [dbo].[bvc_Category] ([ParentID])
GO
PRINT N'Creating [dbo].[bvc_ProductChoices]'
GO
CREATE TABLE [dbo].[bvc_ProductChoices]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChoiceName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductChoices_ChoiceName] DEFAULT (''),
[ChoiceDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductChoices_ChoiceDisplayName] DEFAULT (''),
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SharedChoice] [bit] NOT NULL,
[ChoiceType] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductXVariation] on [dbo].[bvc_ProductChoices]'
GO
ALTER TABLE [dbo].[bvc_ProductChoices] ADD CONSTRAINT [PK_bvc_ProductXVariation] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductChoices_ProductId] on [dbo].[bvc_ProductChoices]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductChoices_ProductId] ON [dbo].[bvc_ProductChoices] ([ProductId], [SharedChoice])
GO
PRINT N'Creating [dbo].[bvc_ComponentSettingList]'
GO
CREATE TABLE [dbo].[bvc_ComponentSettingList]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL CONSTRAINT [DF_bvc_ComponentSettingList_SortOrder] DEFAULT ((0)),
[ComponentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DeveloperId] [nvarchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ComponentType] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ComponentSubType] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ListName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting1] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting2] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting3] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting4] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting5] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting6] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting7] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting8] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting9] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Setting10] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ComponentSettingList] on [dbo].[bvc_ComponentSettingList]'
GO
ALTER TABLE [dbo].[bvc_ComponentSettingList] ADD CONSTRAINT [PK_bvc_ComponentSettingList] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ComponentSettingList] on [dbo].[bvc_ComponentSettingList]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ComponentSettingList] ON [dbo].[bvc_ComponentSettingList] ([ComponentID])
GO
PRINT N'Creating index [IX_bvc_ComponentSettingList_1] on [dbo].[bvc_ComponentSettingList]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ComponentSettingList_1] ON [dbo].[bvc_ComponentSettingList] ([ListName])
GO
PRINT N'Creating [dbo].[bvc_Tax]'
GO
CREATE TABLE [dbo].[bvc_Tax]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RegionBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PostalCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountryBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CountyBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TaxClass] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Rate] [decimal] (18, 10) NOT NULL,
[ApplyToShipping] [bit] NOT NULL CONSTRAINT [DF_bvc_Tax_ApplyToShipping] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Tax] on [dbo].[bvc_Tax]'
GO
ALTER TABLE [dbo].[bvc_Tax] ADD CONSTRAINT [PK_bvc_Tax] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_Country]'
GO
CREATE TABLE [dbo].[bvc_Country]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CultureCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Active] [int] NOT NULL,
[ISOCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ISOAlpha3] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Country_ISOAlpha3] DEFAULT (''),
[ISONumeric] [nvarchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Country_ISONumeric] DEFAULT (''),
[PostalCodeValidationRegex] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Country_PostalCodeValidationRegex] DEFAULT (''),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_Country] on [dbo].[bvc_Country]'
GO
ALTER TABLE [dbo].[bvc_Country] ADD CONSTRAINT [PK_bvc_Country] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ProductInventory]'
GO
CREATE TABLE [dbo].[bvc_ProductInventory]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuantityAvailable] [decimal] (18, 10) NOT NULL,
[QuantityOutOfStockPoint] [decimal] (18, 10) NOT NULL,
[QuantityReserved] [decimal] (18, 10) NOT NULL,
[Status] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[OutOfStockMode] [int] NOT NULL CONSTRAINT [DF_bvc_ProductInventory_OutOfStockMode] DEFAULT ((0)),
[ReorderPoint] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_ProductInventory_ReorderPoint] DEFAULT ((0)),
[QuantityAvailableForSale] AS ([QuantityAvailable]-[QuantityOutOfStockPoint]) PERSISTED,
[ReorderLevel] AS ([QuantityAvailable]-[ReorderPoint]) PERSISTED
)
GO
PRINT N'Creating primary key [PK_bvc_ProductInventory] on [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] ADD CONSTRAINT [PK_bvc_ProductInventory] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductInventory] on [dbo].[bvc_ProductInventory]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_ProductInventory] ON [dbo].[bvc_ProductInventory] ([ProductBvin])
GO
PRINT N'Creating [dbo].[bvc_WorkFlowStep]'
GO
CREATE TABLE [dbo].[bvc_WorkFlowStep]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[WorkFlowBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL,
[ControlName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[StepName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_WorkFlowStep_StepName] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_bvc_WorkFlowStep] on [dbo].[bvc_WorkFlowStep]'
GO
ALTER TABLE [dbo].[bvc_WorkFlowStep] ADD CONSTRAINT [PK_bvc_WorkFlowStep] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ProductXCategory]'
GO
CREATE TABLE [dbo].[bvc_ProductXCategory]
(
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CategoryId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL CONSTRAINT [DF_bvc_ProductXCategory_SortOrder] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_bvc_ProductXCategory] on [dbo].[bvc_ProductXCategory]'
GO
ALTER TABLE [dbo].[bvc_ProductXCategory] ADD CONSTRAINT [PK_bvc_ProductXCategory] PRIMARY KEY CLUSTERED  ([ProductId], [CategoryId])
GO
PRINT N'Creating index [IX_ProductXCategory] on [dbo].[bvc_ProductXCategory]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductXCategory] ON [dbo].[bvc_ProductXCategory] ([ProductId], [CategoryId])
GO
PRINT N'Creating [dbo].[bvc_ProductModifier]'
GO
CREATE TABLE [dbo].[bvc_ProductModifier]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductModifier_Name] DEFAULT (''),
[Displayname] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductModifier_Displayname] DEFAULT (''),
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Shared] [bit] NOT NULL,
[Type] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Required] [bit] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductModifier] on [dbo].[bvc_ProductModifier]'
GO
ALTER TABLE [dbo].[bvc_ProductModifier] ADD CONSTRAINT [PK_bvc_ProductModifier] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductModifier_ProductId] on [dbo].[bvc_ProductModifier]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductModifier_ProductId] ON [dbo].[bvc_ProductModifier] ([ProductId])
GO
PRINT N'Creating [dbo].[bvc_ProductInputs]'
GO
CREATE TABLE [dbo].[bvc_ProductInputs]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InputName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductInputs_InputName] DEFAULT (''),
[InputDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_ProductInputs_InputDisplayName] DEFAULT (''),
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SharedInput] [bit] NOT NULL,
[InputType] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DefaultValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductInputs] on [dbo].[bvc_ProductInputs]'
GO
ALTER TABLE [dbo].[bvc_ProductInputs] ADD CONSTRAINT [PK_bvc_ProductInputs] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductInputs] on [dbo].[bvc_ProductInputs]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductInputs] ON [dbo].[bvc_ProductInputs] ([ProductId])
GO
PRINT N'Creating [dbo].[bvc_Product]'
GO
CREATE TABLE [dbo].[bvc_Product]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SKU] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductTypeId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ListPrice] [numeric] (18, 10) NOT NULL,
[SitePrice] [numeric] (18, 10) NOT NULL,
[SiteCost] [numeric] (18, 10) NOT NULL,
[MetaKeywords] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MetaDescription] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MetaTitle] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TaxExempt] [int] NOT NULL,
[TaxClass] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[NonShipping] [int] NOT NULL,
[ShipSeparately] [int] NOT NULL,
[ShippingMode] [int] NOT NULL,
[ShippingWeight] [numeric] (18, 10) NOT NULL,
[ShippingLength] [numeric] (18, 10) NOT NULL,
[ShippingWidth] [numeric] (18, 10) NOT NULL,
[ShippingHeight] [numeric] (18, 10) NOT NULL,
[Status] [int] NOT NULL,
[ImageFileSmall] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ImageFileMedium] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[MinimumQty] [int] NOT NULL,
[ParentID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[VariantDisplayMode] [int] NOT NULL,
[ShortDescription] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LongDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ManufacturerID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[VendorID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[GiftWrapAllowed] [int] NOT NULL,
[ExtraShipFee] [numeric] (18, 10) NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[Keywords] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TemplateName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PreContentColumnId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PostContentColumnId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RewriteUrl] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Product_RewriteUrl] DEFAULT (N''),
[SitePriceOverrideText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Product_SitePriceOverrideText] DEFAULT (N''),
[SpecialProductType] [int] NOT NULL,
[GiftCertificateCodePattern] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PreTransformLongDescription] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Product_PreTransformLongDescription] DEFAULT (N''),
[TrackInventory] [int] NOT NULL CONSTRAINT [DF_bvc_Product_TrackInventory] DEFAULT ((0)),
[SmallImageAlternateText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Product_SmallImageAlternateText] DEFAULT (''),
[MediumImageAlternateText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Product_MediumImageAlternateText] DEFAULT (''),
[OutOfStockMode] [int] NOT NULL CONSTRAINT [DF_bvc_Product_OutOfStockMode] DEFAULT ((0)),
[CustomProperties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GiftWrapPrice] [numeric] (18, 10) NOT NULL CONSTRAINT [DF_bvc_Product_GiftWrapPrice] DEFAULT ((0.00))
)
GO
PRINT N'Creating primary key [PK_bvc_Product] on [dbo].[bvc_Product]'
GO
ALTER TABLE [dbo].[bvc_Product] ADD CONSTRAINT [PK_bvc_Product] PRIMARY KEY NONCLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_Product_Status] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_Status] ON [dbo].[bvc_Product] ([Status], [bvin])
GO
PRINT N'Creating index [IX_bvc_Product_sku] on [dbo].[bvc_Product]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_Product_sku] ON [dbo].[bvc_Product] ([SKU])
GO
PRINT N'Creating index [IX_Product_ProductName] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_ProductName] ON [dbo].[bvc_Product] ([ProductName])
GO
PRINT N'Creating index [IX_bvc_Product_ParentId] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_Product_ParentId] ON [dbo].[bvc_Product] ([ParentID])
GO
PRINT N'Creating index [IX_Product_ManufacturerId] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_ManufacturerId] ON [dbo].[bvc_Product] ([ManufacturerID])
GO
PRINT N'Creating index [IX_Product_VendorId] on [dbo].[bvc_Product]'
GO
CREATE NONCLUSTERED INDEX [IX_Product_VendorId] ON [dbo].[bvc_Product] ([VendorID])
GO
PRINT N'Creating [dbo].[bvc_User]'
GO
CREATE TABLE [dbo].[bvc_User]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Password] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FirstName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Salt] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TaxExempt] [int] NOT NULL,
[Email] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreationDate] [datetime] NOT NULL,
[LastLoginDate] [datetime] NOT NULL,
[PasswordHint] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Comment] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AddressBook] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[PasswordAnswer] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PasswordFormat] [int] NOT NULL CONSTRAINT [DF_bvc_User_PasswordFormat] DEFAULT ((1)),
[Locked] [int] NOT NULL CONSTRAINT [DF_bvc_User_Locked] DEFAULT ((0)),
[LockedUntil] [datetime] NOT NULL,
[FailedLoginCount] [int] NOT NULL CONSTRAINT [DF_bvc_User_FailedLoginCount] DEFAULT ((0)),
[BillingAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_User_BillingAddress] DEFAULT (N''),
[ShippingAddress] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_User_ShippingAddress] DEFAULT (N''),
[PricingGroup] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CustomQuestionAnswers] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PasswordLastSet] [datetime] NOT NULL CONSTRAINT [DF_bvc_User_PasswordLastSet] DEFAULT (((1)/(1))/(1900)),
[PasswordLastThree] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_User_PasswordLastThree] DEFAULT (N''),
[CustomProperties] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_User_CustomProperties] DEFAULT (N''),
[IsSalesPerson] [int] NOT NULL CONSTRAINT [DF_bvc_User_IsSalesPerson] DEFAULT (N'0')
)
GO
PRINT N'Creating primary key [PK_bvc_User] on [dbo].[bvc_User]'
GO
ALTER TABLE [dbo].[bvc_User] ADD CONSTRAINT [PK_bvc_User] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_CustomUrl]'
GO
CREATE TABLE [dbo].[bvc_CustomUrl]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RequestedUrl] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RedirectToUrl] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemUrl] [int] NOT NULL CONSTRAINT [DF_bvc_CustomUrl_SystemUrl] DEFAULT ((0)),
[SystemData] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_CustomUrl] on [dbo].[bvc_CustomUrl]'
GO
ALTER TABLE [dbo].[bvc_CustomUrl] ADD CONSTRAINT [PK_bvc_CustomUrl] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_CustomUrl] on [dbo].[bvc_CustomUrl]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_CustomUrl] ON [dbo].[bvc_CustomUrl] ([SystemData])
GO
PRINT N'Creating [dbo].[bvc_ContactUsQuestions]'
GO
CREATE TABLE [dbo].[bvc_ContactUsQuestions]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuestionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuestionType] [int] NOT NULL,
[Values] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_ContactUsQuestions_Order] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ContactUsQuestions] on [dbo].[bvc_ContactUsQuestions]'
GO
ALTER TABLE [dbo].[bvc_ContactUsQuestions] ADD CONSTRAINT [PK_bvc_ContactUsQuestions] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_LineItemModifier]'
GO
CREATE TABLE [dbo].[bvc_LineItemModifier]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LineItemBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifierBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifierName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ModifierValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayToCustomer] [bit] NOT NULL CONSTRAINT [DF_bvc_LineItemModifier_DisplayToCustomer] DEFAULT ((1)),
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_LineItemModifier_Order] DEFAULT ((-1)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_LineItemModifier] on [dbo].[bvc_LineItemModifier]'
GO
ALTER TABLE [dbo].[bvc_LineItemModifier] ADD CONSTRAINT [PK_bvc_LineItemModifier] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_Audit]'
GO
CREATE TABLE [dbo].[bvc_Audit]
(
[id] [bigint] NOT NULL IDENTITY(1, 1),
[TimeStampUtc] [datetime] NOT NULL,
[SourceModule] [int] NOT NULL,
[ShortName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Audit_UserId] DEFAULT (''),
[UserIdText] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Audit_UserIdTest] DEFAULT (''),
[Severity] [int] NOT NULL CONSTRAINT [DF_bvc_Audit_Severity] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_bvc_Audit] on [dbo].[bvc_Audit]'
GO
ALTER TABLE [dbo].[bvc_Audit] ADD CONSTRAINT [PK_bvc_Audit] PRIMARY KEY CLUSTERED  ([id])
GO
PRINT N'Creating [dbo].[bvc_OrderPackage]'
GO
CREATE TABLE [dbo].[bvc_OrderPackage]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Width] [decimal] (18, 4) NOT NULL,
[Height] [decimal] (18, 4) NOT NULL,
[Length] [decimal] (18, 4) NOT NULL,
[SizeUnits] [int] NOT NULL,
[Weight] [decimal] (18, 4) NOT NULL,
[WeightUnits] [int] NOT NULL,
[OrderId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShippingProviderId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShippingProviderServiceCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[HasShipped] [int] NOT NULL,
[TrackingNumber] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ShipDate] [datetime] NOT NULL,
[TimeInTransit] [bigint] NOT NULL,
[EstimatedShippingCost] [decimal] (18, 10) NOT NULL,
[Items] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[CustomProperties] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_OrderPackage_CustomProperties] DEFAULT (N'n''')
)
GO
PRINT N'Creating primary key [PK_bvc_OrderPackage] on [dbo].[bvc_OrderPackage]'
GO
ALTER TABLE [dbo].[bvc_OrderPackage] ADD CONSTRAINT [PK_bvc_OrderPackage] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_OrderPackage_OrderId] on [dbo].[bvc_OrderPackage]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_OrderPackage_OrderId] ON [dbo].[bvc_OrderPackage] ([OrderId])
GO
PRINT N'Creating [dbo].[bvc_Role]'
GO
CREATE TABLE [dbo].[bvc_Role]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[RoleName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemRole] [bit] NOT NULL CONSTRAINT [DF_bvc_Role_SystemRole] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_bvc_Role] on [dbo].[bvc_Role]'
GO
ALTER TABLE [dbo].[bvc_Role] ADD CONSTRAINT [PK_bvc_Role] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_WishList]'
GO
CREATE TABLE [dbo].[bvc_WishList]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_WishList_UserId] DEFAULT (''),
[ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Quantity] [int] NOT NULL CONSTRAINT [DF_bvc_WishList_Quantity] DEFAULT ((1)),
[Modifiers] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_WishList_Modifiers] DEFAULT (''),
[Inputs] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_WishList_Inputs] DEFAULT ('')
)
GO
PRINT N'Creating primary key [PK_bvc_WishList_1] on [dbo].[bvc_WishList]'
GO
ALTER TABLE [dbo].[bvc_WishList] ADD CONSTRAINT [PK_bvc_WishList_1] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_OrderPayment]'
GO
CREATE TABLE [dbo].[bvc_OrderPayment]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[lastUpdated] [datetime] NOT NULL,
[AmountAuthorized] [decimal] (18, 10) NOT NULL,
[AmountCharged] [decimal] (18, 10) NOT NULL,
[AmountRefunded] [decimal] (18, 10) NOT NULL,
[auditDate] [datetime] NOT NULL,
[checkNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[creditCardExpMonth] [int] NOT NULL,
[creditCardExpYear] [int] NOT NULL,
[creditCardHolder] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[creditCardNumber] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[creditCardType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[giftCertificateNumber] [nvarchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[note] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[orderID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[paymentMethodId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PaymentMethodName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[purchaseOrderNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[transactionReferenceNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[transactionResponseCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[id] [int] NOT NULL IDENTITY(1, 1),
[CustomProperties] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_OrderPayment_CustomProperties] DEFAULT (N''),
[ThirdPartyOrderId] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ThirdPartyTransId] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EncryptionKeyId] [bigint] NOT NULL CONSTRAINT [DF_bvc_OrderPayment_EncryptionKeyId] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_bvc_OrderPayment] on [dbo].[bvc_OrderPayment]'
GO
ALTER TABLE [dbo].[bvc_OrderPayment] ADD CONSTRAINT [PK_bvc_OrderPayment] PRIMARY KEY NONCLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_OrderPayment_OrderId] on [dbo].[bvc_OrderPayment]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_OrderPayment_OrderId] ON [dbo].[bvc_OrderPayment] ([orderID])
GO
PRINT N'Creating [dbo].[bvc_LineItemStatusCode]'
GO
CREATE TABLE [dbo].[bvc_LineItemStatusCode]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemCode] [int] NOT NULL CONSTRAINT [DF_bvc_LineItemStatusCode_SystemCode] DEFAULT ((0)),
[StatusName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL CONSTRAINT [DF_bvc_LineItemStatusCode_SortOrder] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_LineItemStatusCode] on [dbo].[bvc_LineItemStatusCode]'
GO
ALTER TABLE [dbo].[bvc_LineItemStatusCode] ADD CONSTRAINT [PK_bvc_LineItemStatusCode] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_KitComponent]'
GO
CREATE TABLE [dbo].[bvc_KitComponent]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_KitComponent_Description] DEFAULT (''),
[GroupBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ComponentType] [int] NOT NULL,
[SmallImage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_KitComponent_SmallImage] DEFAULT (''),
[LargeImage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_KitComponent_LargeImage] DEFAULT (''),
[SortOrder] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_KitPartGroup] on [dbo].[bvc_KitComponent]'
GO
ALTER TABLE [dbo].[bvc_KitComponent] ADD CONSTRAINT [PK_bvc_KitPartGroup] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_KitPartGroup] on [dbo].[bvc_KitComponent]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_KitPartGroup] ON [dbo].[bvc_KitComponent] ([GroupBvin])
GO
PRINT N'Creating [dbo].[bvc_Affiliate]'
GO
CREATE TABLE [dbo].[bvc_Affiliate]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ReferralID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Enabled] [bit] NOT NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CommissionAmount] [numeric] (18, 10) NOT NULL,
[CommissionType] [int] NOT NULL,
[ReferralDays] [int] NOT NULL,
[TaxID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DriversLicenseNumber] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[WebSiteURL] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StyleSheet] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Notes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[Address] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_Affiliate_AddressId] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_bvc_Affiliate] on [dbo].[bvc_Affiliate]'
GO
ALTER TABLE [dbo].[bvc_Affiliate] ADD CONSTRAINT [PK_bvc_Affiliate] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_Affiliate] on [dbo].[bvc_Affiliate]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_Affiliate] ON [dbo].[bvc_Affiliate] ([ReferralID])
GO
PRINT N'Creating [dbo].[bvc_WorkFlow]'
GO
CREATE TABLE [dbo].[bvc_WorkFlow]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ContextType] [int] NOT NULL CONSTRAINT [DF_bvc_WorkFlow_WorkFlowType] DEFAULT ((1)),
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemWorkFlow] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_WorkFlow] on [dbo].[bvc_WorkFlow]'
GO
ALTER TABLE [dbo].[bvc_WorkFlow] ADD CONSTRAINT [PK_bvc_WorkFlow] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_WorkFlow] on [dbo].[bvc_WorkFlow]'
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_bvc_WorkFlow] ON [dbo].[bvc_WorkFlow] ([Name])
GO
PRINT N'Creating [dbo].[bvc_RolePermission]'
GO
CREATE TABLE [dbo].[bvc_RolePermission]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemPermission] [int] NOT NULL CONSTRAINT [DF_bvc_RolePermission_SystemPermission] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_RolePermission] on [dbo].[bvc_RolePermission]'
GO
ALTER TABLE [dbo].[bvc_RolePermission] ADD CONSTRAINT [PK_bvc_RolePermission] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_RMA]'
GO
CREATE TABLE [dbo].[bvc_RMA]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[OrderBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Number] [int] NOT NULL IDENTITY(1, 1),
[EmailAddress] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PhoneNumber] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Comments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Status] [int] NOT NULL,
[DateOfReturn] [datetime] NOT NULL CONSTRAINT [DF_bvc_RMA_DateOfReturn] DEFAULT ('01/01/2000'),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_RMA] on [dbo].[bvc_RMA]'
GO
ALTER TABLE [dbo].[bvc_RMA] ADD CONSTRAINT [PK_bvc_RMA] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_RMA_OrderBvin] on [dbo].[bvc_RMA]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_RMA_OrderBvin] ON [dbo].[bvc_RMA] ([OrderBvin])
GO
PRINT N'Creating [dbo].[bvc_ProductTypeXProductProperty]'
GO
CREATE TABLE [dbo].[bvc_ProductTypeXProductProperty]
(
[ProductTypeBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductPropertyBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL CONSTRAINT [DF_ProductTypeProperties_SortOrder] DEFAULT ((1))
)
GO
PRINT N'Creating primary key [PK_bvc_ProductTypeXProductProperty] on [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] ADD CONSTRAINT [PK_bvc_ProductTypeXProductProperty] PRIMARY KEY CLUSTERED  ([ProductTypeBvin], [ProductPropertyBvin])
GO
PRINT N'Creating [dbo].[bvc_ProductProperty]'
GO
CREATE TABLE [dbo].[bvc_ProductProperty]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayOnSite] [int] NOT NULL CONSTRAINT [DF_ProductProperty_DisplayOnSite] DEFAULT ((1)),
[DisplayToDropShipper] [int] NOT NULL CONSTRAINT [DF_ProductProperty_IsRequired] DEFAULT ((0)),
[TypeCode] [int] NOT NULL CONSTRAINT [DF_ProductProperty_TypeCode] DEFAULT ((0)),
[DefaultValue] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CultureCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_ProductProperty_CultureCode] DEFAULT ('en-US'),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_ProductProperty] on [dbo].[bvc_ProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductProperty] ADD CONSTRAINT [PK_ProductProperty] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_KitPart]'
GO
CREATE TABLE [dbo].[bvc_KitPart]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[ComponentBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProductBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrder] [int] NOT NULL,
[Description] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Quantity] [int] NOT NULL,
[Price] [decimal] (18, 10) NOT NULL,
[Weight] [decimal] (18, 10) NOT NULL,
[PriceType] [int] NOT NULL CONSTRAINT [DF_bvc_KitPart_PriceType] DEFAULT ((1)),
[WeightType] [int] NOT NULL CONSTRAINT [DF_bvc_KitPart_WeightType] DEFAULT ((1)),
[IsNull] [bit] NOT NULL CONSTRAINT [DF_bvc_KitPart_IsNull] DEFAULT ((0)),
[IsSelected] [bit] NOT NULL CONSTRAINT [DF_bvc_KitPart_IsSelected] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_bvc_KitPart] on [dbo].[bvc_KitPart]'
GO
ALTER TABLE [dbo].[bvc_KitPart] ADD CONSTRAINT [PK_bvc_KitPart] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_KitPart] on [dbo].[bvc_KitPart]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_KitPart] ON [dbo].[bvc_KitPart] ([ComponentBvin])
GO
PRINT N'Creating index [IX_bvc_KitPart_Product] on [dbo].[bvc_KitPart]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_KitPart_Product] ON [dbo].[bvc_KitPart] ([ProductBvin])
GO
PRINT N'Creating [dbo].[bvc_EmailTemplate]'
GO
CREATE TABLE [dbo].[bvc_EmailTemplate]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Body] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BodyPlainText] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DisplayName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[From] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RepeatingSection] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[RepeatingSectionPlainText] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SendInPlainText] [int] NOT NULL,
[Subject] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[BodyPreTransform] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_EmailTemplate_BodyPreTransform] DEFAULT (N''),
[RepeatingSectionPreTransform] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_EmailTemplate_RepeatingSectionPreTransform] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_bvc_EmailTemplate] on [dbo].[bvc_EmailTemplate]'
GO
ALTER TABLE [dbo].[bvc_EmailTemplate] ADD CONSTRAINT [PK_bvc_EmailTemplate] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_OrderStatusCode]'
GO
CREATE TABLE [dbo].[bvc_OrderStatusCode]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SystemCode] [int] NOT NULL CONSTRAINT [DF_bvc_OrderStatusCode_SystemCode] DEFAULT ((0)),
[StatusName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL CONSTRAINT [DF_bvc_OrderStatusCode_SortOrder] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_OrderStatusCode] on [dbo].[bvc_OrderStatusCode]'
GO
ALTER TABLE [dbo].[bvc_OrderStatusCode] ADD CONSTRAINT [PK_bvc_OrderStatusCode] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_AffiliateQuestions]'
GO
CREATE TABLE [dbo].[bvc_AffiliateQuestions]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuestionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuestionType] [int] NOT NULL,
[Values] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_AffiliateQuestions_Order] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_AffiliateQuestions] on [dbo].[bvc_AffiliateQuestions]'
GO
ALTER TABLE [dbo].[bvc_AffiliateQuestions] ADD CONSTRAINT [PK_bvc_AffiliateQuestions] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_LineItem]'
GO
CREATE TABLE [dbo].[bvc_LineItem]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[ProductId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Quantity] [decimal] (18, 10) NOT NULL,
[OrderBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BasePrice] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_BasePrice] DEFAULT ((0)),
[Discounts] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_Discounts] DEFAULT ((0)),
[AdjustedPrice] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_AdjustedPrice] DEFAULT ((0)),
[ShippingPortion] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_ShippingPortion] DEFAULT ((0)),
[TaxPortion] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_TaxPortion] DEFAULT ((0)),
[LineTotal] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_LineTotal] DEFAULT ((0)),
[CustomProperties] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_LineItem_CustomProperties] DEFAULT (N''),
[QuantityReturned] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_QuantityReturned] DEFAULT ((0)),
[QuantityShipped] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_QuantityShipped] DEFAULT ((0)),
[ProductName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductShortDescription] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductSku] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StatusCode] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_LineItem_StatusCode] DEFAULT (''),
[StatusName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_LineItem_StatusName] DEFAULT (N''),
[AdditionalDiscount] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_AdditionalDiscount] DEFAULT ((0)),
[AdminPrice] [decimal] (18, 10) NOT NULL CONSTRAINT [DF_bvc_LineItem_AdminPrice] DEFAULT ((-1)),
[GiftWrapDetails] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_bvc_LineItem_GiftWrapDetails] DEFAULT (''),
[KitSelections] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_LineItem_KitSelections] DEFAULT ('')
)
GO
PRINT N'Creating primary key [PK_bvc_LineItem] on [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] ADD CONSTRAINT [PK_bvc_LineItem] PRIMARY KEY NONCLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_LineItem_1] on [dbo].[bvc_LineItem]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_LineItem_1] ON [dbo].[bvc_LineItem] ([OrderBvin])
GO
PRINT N'Creating [dbo].[bvc_ProductImage]'
GO
CREATE TABLE [dbo].[bvc_ProductImage]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FileName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Caption] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AlternateText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL CONSTRAINT [DF_bvc_ProductImage_SortOrder] DEFAULT ((-1)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductImage] on [dbo].[bvc_ProductImage]'
GO
ALTER TABLE [dbo].[bvc_ProductImage] ADD CONSTRAINT [PK_bvc_ProductImage] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductImage] on [dbo].[bvc_ProductImage]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductImage] ON [dbo].[bvc_ProductImage] ([ProductID])
GO
PRINT N'Creating [dbo].[bvc_LineItemInput]'
GO
CREATE TABLE [dbo].[bvc_LineItemInput]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LineItemBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InputBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InputName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InputValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[InputDisplayValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_LineItemInput_InputDisplayValue] DEFAULT (''),
[InputAdminDisplayValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_LineItemInput_InputAdminDisplayValue] DEFAULT (''),
[DisplayToCustomer] [bit] NOT NULL CONSTRAINT [DF_bvc_LineItemInput_DisplayToCustomer] DEFAULT ((1)),
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_LineItemInput_Order] DEFAULT ((-1)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_LineItemInput] on [dbo].[bvc_LineItemInput]'
GO
ALTER TABLE [dbo].[bvc_LineItemInput] ADD CONSTRAINT [PK_bvc_LineItemInput] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_LineItemInput] on [dbo].[bvc_LineItemInput]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_LineItemInput] ON [dbo].[bvc_LineItemInput] ([LineItemBvin])
GO
PRINT N'Creating [dbo].[bvc_EventLog]'
GO
CREATE TABLE [dbo].[bvc_EventLog]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventTime] [datetime] NOT NULL,
[Source] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Message] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Severity] [int] NOT NULL CONSTRAINT [DF_bvc_EventLog_Severity] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_EventLog] on [dbo].[bvc_EventLog]'
GO
ALTER TABLE [dbo].[bvc_EventLog] ADD CONSTRAINT [PK_EventLog] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_CreditCardType]'
GO
CREATE TABLE [dbo].[bvc_CreditCardType]
(
[Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LongName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Active] [int] NOT NULL CONSTRAINT [DF_bvc_CreditCardType_Active] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_bvc_CreditCardType] on [dbo].[bvc_CreditCardType]'
GO
ALTER TABLE [dbo].[bvc_CreditCardType] ADD CONSTRAINT [PK_bvc_CreditCardType] PRIMARY KEY CLUSTERED  ([Code])
GO
PRINT N'Creating [dbo].[bvc_UserQuestions]'
GO
CREATE TABLE [dbo].[bvc_UserQuestions]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuestionName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[QuestionType] [int] NOT NULL,
[Values] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Order] [int] NOT NULL CONSTRAINT [DF_bvc_UserQuestions_Order] DEFAULT ((0)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_UserQuestions] on [dbo].[bvc_UserQuestions]'
GO
ALTER TABLE [dbo].[bvc_UserQuestions] ADD CONSTRAINT [PK_bvc_UserQuestions] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_PolicyBlock]'
GO
CREATE TABLE [dbo].[bvc_PolicyBlock]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL,
[LastUpdated] [datetime] NOT NULL,
[PolicyID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DescriptionPreTransform] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_bvc_PolicyBlock_DescriptionPreTransform] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_bvc_PolicyBlock] on [dbo].[bvc_PolicyBlock]'
GO
ALTER TABLE [dbo].[bvc_PolicyBlock] ADD CONSTRAINT [PK_bvc_PolicyBlock] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating [dbo].[bvc_ProductPropertyChoice]'
GO
CREATE TABLE [dbo].[bvc_ProductPropertyChoice]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[PropertyBvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChoiceName] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SortOrder] [int] NOT NULL CONSTRAINT [DF_ProductPropertyChoices_SortOrder] DEFAULT ((-1)),
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_ProductPropertyChoices] on [dbo].[bvc_ProductPropertyChoice]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyChoice] ADD CONSTRAINT [PK_ProductPropertyChoices] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductPropertyChoice_PropertyBvin] on [dbo].[bvc_ProductPropertyChoice]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductPropertyChoice_PropertyBvin] ON [dbo].[bvc_ProductPropertyChoice] ([PropertyBvin])
GO
PRINT N'Creating [dbo].[bvc_ProductVolumeDiscounts]'
GO
CREATE TABLE [dbo].[bvc_ProductVolumeDiscounts]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ProductID] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Qty] [int] NOT NULL CONSTRAINT [DF_bvc_ProductVolumeDiscounts_Qty] DEFAULT ((1)),
[DiscountType] [int] NOT NULL,
[Amount] [numeric] (18, 10) NOT NULL,
[LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_bvc_ProductVolumeDiscounts] on [dbo].[bvc_ProductVolumeDiscounts]'
GO
ALTER TABLE [dbo].[bvc_ProductVolumeDiscounts] ADD CONSTRAINT [PK_bvc_ProductVolumeDiscounts] PRIMARY KEY CLUSTERED  ([bvin])
GO
PRINT N'Creating index [IX_bvc_ProductVolumeDiscounts] on [dbo].[bvc_ProductVolumeDiscounts]'
GO
CREATE NONCLUSTERED INDEX [IX_bvc_ProductVolumeDiscounts] ON [dbo].[bvc_ProductVolumeDiscounts] ([ProductID])
GO
PRINT N'Creating [dbo].[bvc_ListItems]'
GO
CREATE TABLE [dbo].[bvc_ListItems]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[listbvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[productbvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[qtydesired] [int] NULL,
[qtyreceived] [int] NULL,
[priority] [int] NULL,
[inputs] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiers] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
PRINT N'Creating [dbo].[bvc_Lists]'
GO
CREATE TABLE [dbo].[bvc_Lists]
(
[bvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[userbvin] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[listtype] [int] NULL,
[listname] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[listdate] [datetime] NULL,
[listcity] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[liststate] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[listcountry] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marriagerole] [int] NULL,
[coregrole] [int] NULL,
[bridesfirstname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[brideslastname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[groomsfirstname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[groomslastname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[babyname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[babygender] [int] NULL,
[relateddate] [bit] NULL,
[publiclist] [bit] NULL,
[defaultlist] [bit] NULL
)
GO
PRINT N'Creating [dbo].[bvc_USGeoData]'
GO
CREATE TABLE [dbo].[bvc_USGeoData]
(
[Zip] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Latitude] [decimal] (18, 10) NOT NULL,
[Longitude] [decimal] (18, 10) NOT NULL,
[City] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[State] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[County] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ZipType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
PRINT N'Creating [dbo].[tos_PostalCodes]'
GO
CREATE TABLE [dbo].[tos_PostalCodes]
(
  [bvin] [varchar](36) NOT NULL,
  [CountryBvin] [varchar](36) NOT NULL,
  [Code] [varchar](50) NOT NULL,
  [Latitude] [decimal](18, 10) NOT NULL,
  [Longitude] [decimal](18, 10) NOT NULL,
  [RegionBvin] [varchar](36) NULL,
  [City] [nvarchar](max) NULL,
  [LastUpdated] [datetime] NOT NULL
)
GO
PRINT N'Creating primary key [PK_tos_PostalCodes] on [dbo].[tos_PostalCodes]'
GO
ALTER TABLE [dbo].[tos_PostalCodes] ADD CONSTRAINT [PK_tos_PostalCodes] PRIMARY KEY NONCLUSTERED ([bvin] ASC)
GO
PRINT N'Creating index [IX_tos_PostalCodes] on [dbo].[tos_PostalCodes]'
GO
CREATE UNIQUE CLUSTERED INDEX [IX_tos_PostalCodes] ON [dbo].[tos_PostalCodes]
(
 [CountryBvin] ASC,
 [Code] ASC
) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
PRINT N'Creating primary key [PK_bvc_USGeoData] on [dbo].[bvc_USGeoData]'
GO
ALTER TABLE [dbo].[bvc_USGeoData] ADD CONSTRAINT [PK_bvc_USGeoData] PRIMARY KEY CLUSTERED  ([Zip])
GO
PRINT N'Adding constraints to [dbo].[bvc_Address]'
GO
ALTER TABLE [dbo].[bvc_Address] ADD CONSTRAINT [IX_bvc_Address] UNIQUE CLUSTERED  ([id])
GO
PRINT N'Adding constraints to [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] ADD CONSTRAINT [IX_bvc_LineItem] UNIQUE CLUSTERED  ([id])
GO
PRINT N'Adding constraints to [dbo].[bvc_Order]'
GO
ALTER TABLE [dbo].[bvc_Order] ADD CONSTRAINT [IX_bvc_Order] UNIQUE CLUSTERED  ([id])
GO
PRINT N'Adding constraints to [dbo].[bvc_OrderPayment]'
GO
ALTER TABLE [dbo].[bvc_OrderPayment] ADD CONSTRAINT [IX_bvc_OrderPayment] UNIQUE CLUSTERED  ([id])
GO
PRINT N'Adding constraints to [dbo].[bvc_Product]'
GO
ALTER TABLE [dbo].[bvc_Product] ADD CONSTRAINT [IX_bvc_Product_id] UNIQUE CLUSTERED  ([id])
GO
PRINT N'Adding constraints to [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] ADD CONSTRAINT [IX_bvc_ProductFileXProduct_1] UNIQUE NONCLUSTERED  ([ProductFileId], [ProductId])
GO
PRINT N'Adding constraints to [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] ADD CONSTRAINT [IX_ProductPropertyValues] UNIQUE NONCLUSTERED  ([ProductBvin], [PropertyBvin])
GO
PRINT N'Adding constraints to [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] ADD CONSTRAINT [IX_ProductTypeProperties] UNIQUE NONCLUSTERED  ([ProductTypeBvin], [ProductPropertyBvin])
GO
PRINT N'Adding constraints to [dbo].[bvc_User]'
GO
ALTER TABLE [dbo].[bvc_User] ADD CONSTRAINT [IX_bvc_User] UNIQUE NONCLUSTERED  ([UserName])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductXCategory]'
GO
ALTER TABLE [dbo].[bvc_ProductXCategory] WITH NOCHECK ADD
CONSTRAINT [FK_ProductXCategory_bvc_Category] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[bvc_Category] ([bvin]),
CONSTRAINT [FK_ProductXCategory_bvc_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[bvc_Product] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ContentBlock]'
GO
ALTER TABLE [dbo].[bvc_ContentBlock] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ContentBlock_bvc_ContentColumn] FOREIGN KEY ([ColumnID]) REFERENCES [dbo].[bvc_ContentColumn] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_Region]'
GO
ALTER TABLE [dbo].[bvc_Region] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_Region_bvc_Country] FOREIGN KEY ([CountryID]) REFERENCES [dbo].[bvc_Country] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ShippingMethod_CountryRestriction]'
GO
ALTER TABLE [dbo].[bvc_ShippingMethod_CountryRestriction] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ShippingMethod_CountryRestriction_bvc_Country] FOREIGN KEY ([CountryBvin]) REFERENCES [dbo].[bvc_Country] ([bvin]),
CONSTRAINT [FK_bvc_ShippingMethod_CountryRestriction_bvc_ShippingMethod] FOREIGN KEY ([ShippingMethodBvin]) REFERENCES [dbo].[bvc_ShippingMethod] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_County]'
GO
ALTER TABLE [dbo].[bvc_County] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_County_bvc_Region] FOREIGN KEY ([RegionID]) REFERENCES [dbo].[bvc_Region] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_DropShipNotification]'
GO
ALTER TABLE [dbo].[bvc_DropShipNotification] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_DropShipNotification_bvc_Order] FOREIGN KEY ([OrderBvin]) REFERENCES [dbo].[bvc_Order] ([Bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_KitPart]'
GO
ALTER TABLE [dbo].[bvc_KitPart] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_KitPart_bvc_KitPartGroup] FOREIGN KEY ([ComponentBvin]) REFERENCES [dbo].[bvc_KitComponent] ([bvin]),
CONSTRAINT [FK_bvc_KitPart_bvc_Product] FOREIGN KEY ([ProductBvin]) REFERENCES [dbo].[bvc_Product] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_KitComponent]'
GO
ALTER TABLE [dbo].[bvc_KitComponent] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_KitComponent_bvc_KitGroup] FOREIGN KEY ([GroupBvin]) REFERENCES [dbo].[bvc_KitGroup] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_KitGroup]'
GO
ALTER TABLE [dbo].[bvc_KitGroup] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_KitGroup_bvc_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[bvc_Product] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_LineItemInput]'
GO
ALTER TABLE [dbo].[bvc_LineItemInput] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_LineItemInput_bvc_LineItem] FOREIGN KEY ([LineItemBvin]) REFERENCES [dbo].[bvc_LineItem] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_LineItemModifier]'
GO
ALTER TABLE [dbo].[bvc_LineItemModifier] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_LineItemModifier_bvc_LineItem] FOREIGN KEY ([LineItemBvin]) REFERENCES [dbo].[bvc_LineItem] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_LineItem]'
GO
ALTER TABLE [dbo].[bvc_LineItem] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_LineItem_bvc_LineItem] FOREIGN KEY ([OrderBvin]) REFERENCES [dbo].[bvc_Order] ([Bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_MailingListMember]'
GO
ALTER TABLE [dbo].[bvc_MailingListMember] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_MailingListMember_bvc_MailingList] FOREIGN KEY ([ListID]) REFERENCES [dbo].[bvc_MailingList] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_OrderCoupon]'
GO
ALTER TABLE [dbo].[bvc_OrderCoupon] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_OrderCoupon_bvc_Order] FOREIGN KEY ([OrderBvin]) REFERENCES [dbo].[bvc_Order] ([Bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_OrderNote]'
GO
ALTER TABLE [dbo].[bvc_OrderNote] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_OrderNote_bvc_Order] FOREIGN KEY ([OrderId]) REFERENCES [dbo].[bvc_Order] ([Bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_OrderPayment]'
GO
ALTER TABLE [dbo].[bvc_OrderPayment] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_OrderPayment_bvc_Order] FOREIGN KEY ([orderID]) REFERENCES [dbo].[bvc_Order] ([Bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_PolicyBlock]'
GO
ALTER TABLE [dbo].[bvc_PolicyBlock] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_PolicyBlock_bvc_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[bvc_Policy] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductChoiceCombinations]'
GO
ALTER TABLE [dbo].[bvc_ProductChoiceCombinations] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ProductChoiceCombinations_bvc_Product] FOREIGN KEY ([ProductId]) REFERENCES [dbo].[bvc_Product] ([bvin]) ON DELETE CASCADE,
CONSTRAINT [FK_bvc_ProductChoiceCombinations_bvc_ProductChoices] FOREIGN KEY ([ChoiceId]) REFERENCES [dbo].[bvc_ProductChoices] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductInventory]'
GO
ALTER TABLE [dbo].[bvc_ProductInventory] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ProductInventory_bvc_Product] FOREIGN KEY ([ProductBvin]) REFERENCES [dbo].[bvc_Product] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductPropertyValue]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyValue] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ProductPropertyValue_bvc_Product] FOREIGN KEY ([ProductBvin]) REFERENCES [dbo].[bvc_Product] ([bvin]),
CONSTRAINT [FK_ProductPropertyValues_ProductProperty] FOREIGN KEY ([PropertyBvin]) REFERENCES [dbo].[bvc_ProductProperty] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductFileXProduct]'
GO
ALTER TABLE [dbo].[bvc_ProductFileXProduct] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ProductFileXProduct_bvc_ProductFile] FOREIGN KEY ([ProductFileId]) REFERENCES [dbo].[bvc_ProductFile] ([bvin]) ON DELETE CASCADE ON UPDATE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductPropertyChoice]'
GO
ALTER TABLE [dbo].[bvc_ProductPropertyChoice] WITH NOCHECK ADD
CONSTRAINT [FK_ProductPropertyChoices_ProductProperty] FOREIGN KEY ([PropertyBvin]) REFERENCES [dbo].[bvc_ProductProperty] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ProductTypeXProductProperty]'
GO
ALTER TABLE [dbo].[bvc_ProductTypeXProductProperty] WITH NOCHECK ADD
CONSTRAINT [FK_ProductTypeProperties_ProductProperty] FOREIGN KEY ([ProductPropertyBvin]) REFERENCES [dbo].[bvc_ProductProperty] ([bvin]),
CONSTRAINT [FK_ProductTypeProperties_ProductType] FOREIGN KEY ([ProductTypeBvin]) REFERENCES [dbo].[bvc_ProductType] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_ShippingMethod_RegionRestriction]'
GO
ALTER TABLE [dbo].[bvc_ShippingMethod_RegionRestriction] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_ShippingMethod_RegionRestriction_bvc_Region] FOREIGN KEY ([RegionBvin]) REFERENCES [dbo].[bvc_Region] ([bvin]),
CONSTRAINT [FK_bvc_ShippingMethod_RegionRestriction_bvc_ShippingMethod] FOREIGN KEY ([ShippingMethodBvin]) REFERENCES [dbo].[bvc_ShippingMethod] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_RMAItem]'
GO
ALTER TABLE [dbo].[bvc_RMAItem] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_RMAItem_bvc_RMA] FOREIGN KEY ([RMABvin]) REFERENCES [dbo].[bvc_RMA] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_RoleXRolePermission]'
GO
ALTER TABLE [dbo].[bvc_RoleXRolePermission] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_RoleXRolePermission_bvc_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[bvc_Role] ([bvin]),
CONSTRAINT [FK_bvc_RoleXRolePermission_bvc_RolePermission] FOREIGN KEY ([PermissionID]) REFERENCES [dbo].[bvc_RolePermission] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_UserXRole]'
GO
ALTER TABLE [dbo].[bvc_UserXRole] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_UserXRole_bvc_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[bvc_Role] ([bvin]),
CONSTRAINT [FK_bvc_UserXRole_bvc_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[bvc_User] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_SaleXCategory]'
GO
ALTER TABLE [dbo].[bvc_SaleXCategory] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_SaleXCategory_bvc_Sale] FOREIGN KEY ([SaleId]) REFERENCES [dbo].[bvc_Sale] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_SaleXProduct]'
GO
ALTER TABLE [dbo].[bvc_SaleXProduct] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_SaleXProduct_bvc_Sale] FOREIGN KEY ([SaleId]) REFERENCES [dbo].[bvc_Sale] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_SaleXProductType]'
GO
ALTER TABLE [dbo].[bvc_SaleXProductType] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_SaleXProductType_bvc_Sale] FOREIGN KEY ([SaleId]) REFERENCES [dbo].[bvc_Sale] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_UserXContact]'
GO
ALTER TABLE [dbo].[bvc_UserXContact] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_UserXAffiliate_bvc_User] FOREIGN KEY ([UserId]) REFERENCES [dbo].[bvc_User] ([bvin])
GO
PRINT N'Adding foreign keys to [dbo].[bvc_WorkFlowStep]'
GO
ALTER TABLE [dbo].[bvc_WorkFlowStep] WITH NOCHECK ADD
CONSTRAINT [FK_bvc_WorkFlowStep_bvc_WorkFlow] FOREIGN KEY ([WorkFlowBvin]) REFERENCES [dbo].[bvc_WorkFlow] ([bvin])
GO

PRINT N'Creating [dbo].[bvc_UrlRedirect]'
GO
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
GO
PRINT N'Creating primary key [PK_bvc_UrlRedirect] on [dbo].[bvc_UrlRedirect]'
GO
ALTER TABLE [dbo].[bvc_UrlRedirect] ADD CONSTRAINT [PK_bvc_UrlRedirect] PRIMARY KEY CLUSTERED  ([bvin])
GO

CREATE TABLE [dbo].[bvc_LoyaltyPoints](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[bvin] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[UserId] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrderId] [varchar](36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PointsType] [int] NOT NULL,
	[PointsAdjustment] [int] NOT NULL,
	[PointsRemaining] [int] NOT NULL,
	[Expires] [int] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[CustomProperties] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_bvc_LoyaltyPoints] PRIMARY KEY NONCLUSTERED 
(
	[bvin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [K_bvc_LoyaltyPoints] UNIQUE CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[bvc_LoyaltyPoints]  WITH NOCHECK ADD  CONSTRAINT [FK_bvc_LoyaltyPoints_bvc_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[bvc_User] ([bvin])
GO

ALTER TABLE [dbo].[bvc_LoyaltyPoints] CHECK CONSTRAINT [FK_bvc_LoyaltyPoints_bvc_User]
GO
