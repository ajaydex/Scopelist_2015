
SET NOCOUNT ON
exec sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
exec sp_msforeachtable 'ALTER TABLE ? DISABLE TRIGGER ALL'

DELETE FROM [dbo].[bvc_Address]
DELETE FROM [dbo].[bvc_Affiliate]
DELETE FROM [dbo].[bvc_AffiliateQuestions]
DELETE FROM [dbo].[bvc_AffiliateReferral]
DELETE FROM [dbo].[bvc_AuthenticationToken]
DELETE FROM [dbo].[bvc_Category]
DELETE FROM [dbo].[bvc_ComponentSetting]
DELETE FROM [dbo].[bvc_ComponentSettingList]
DELETE FROM [dbo].[bvc_ContactUsQuestions]
DELETE FROM [dbo].[bvc_ContentBlock]
DELETE FROM [dbo].[bvc_ContentColumn]
DELETE FROM [dbo].[bvc_Country]
DELETE FROM [dbo].[bvc_County]
DELETE FROM [dbo].[bvc_CreditCardType]
DELETE FROM [dbo].[bvc_CustomPage]
DELETE FROM [dbo].[bvc_CustomUrl]
DELETE FROM [dbo].[bvc_DropShipNotification]
DELETE FROM [dbo].[bvc_EmailTemplate]
DELETE FROM [dbo].[bvc_EventLog]
DELETE FROM [dbo].[bvc_Fraud]
DELETE FROM [dbo].[bvc_GiftCertificate]
DELETE FROM [dbo].[bvc_KitPart]
DELETE FROM [dbo].[bvc_KitComponent]
DELETE FROM [dbo].[bvc_LineItem]
DELETE FROM [dbo].[bvc_LineItemInput]
DELETE FROM [dbo].[bvc_LineItemModifier]
DELETE FROM [dbo].[bvc_LineItemStatusCode]
DELETE FROM [dbo].[bvc_ListItems]
DELETE FROM [dbo].[bvc_Lists]
DELETE FROM [dbo].[bvc_LoyaltyPoints]
DELETE FROM [dbo].[bvc_MailingList]
DELETE FROM [dbo].[bvc_MailingListMember]
DELETE FROM [dbo].[bvc_Manufacturer]
DELETE FROM [dbo].[bvc_Offers]
DELETE FROM [dbo].[bvc_Order]
DELETE FROM [dbo].[bvc_OrderCoupon]
DELETE FROM [dbo].[bvc_OrderNote]
DELETE FROM [dbo].[bvc_OrderPackage]
DELETE FROM [dbo].[bvc_OrderPayment]
DELETE FROM [dbo].[bvc_OrderStatusCode]
DELETE FROM [dbo].[bvc_Policy]
DELETE FROM [dbo].[bvc_PolicyBlock]
DELETE FROM [dbo].[bvc_PriceGroup]
DELETE FROM [dbo].[bvc_PrintTemplate]
DELETE FROM [dbo].[bvc_Product]
DELETE FROM [dbo].[bvc_ProductChoiceCombinations]
DELETE FROM [dbo].[bvc_ProductChoiceInputOrder]
DELETE FROM [dbo].[bvc_ProductChoiceOptions]
DELETE FROM [dbo].[bvc_ProductChoices]
DELETE FROM [dbo].[bvc_ProductCrossSell]
DELETE FROM [dbo].[bvc_ProductFile]
DELETE FROM [dbo].[bvc_ProductFileXProduct]
DELETE FROM [dbo].[bvc_ProductFilter]
DELETE FROM [dbo].[bvc_ProductImage]
DELETE FROM [dbo].[bvc_ProductInputs]
DELETE FROM [dbo].[bvc_ProductInventory]
DELETE FROM [dbo].[bvc_ProductModifier]
DELETE FROM [dbo].[bvc_ProductModifierOption]
DELETE FROM [dbo].[bvc_ProductProperty]
DELETE FROM [dbo].[bvc_ProductPropertyChoice]
DELETE FROM [dbo].[bvc_ProductPropertyValue]
DELETE FROM [dbo].[bvc_ProductReview]
DELETE FROM [dbo].[bvc_ProductType]
DELETE FROM [dbo].[bvc_ProductTypeXProductProperty]
DELETE FROM [dbo].[bvc_ProductUpSell]
DELETE FROM [dbo].[bvc_ProductVolumeDiscounts]
DELETE FROM [dbo].[bvc_ProductXCategory]
DELETE FROM [dbo].[bvc_ProductXChoice]
DELETE FROM [dbo].[bvc_ProductXInput]
DELETE FROM [dbo].[bvc_ProductXModifier]
DELETE FROM [dbo].[bvc_Region]
DELETE FROM [dbo].[bvc_RMA]
DELETE FROM [dbo].[bvc_RMAItem]
DELETE FROM [dbo].[bvc_Role]
DELETE FROM [dbo].[bvc_RolePermission]
DELETE FROM [dbo].[bvc_RoleXRolePermission]
DELETE FROM [dbo].[bvc_Sale]
DELETE FROM [dbo].[bvc_SaleXCategory]
DELETE FROM [dbo].[bvc_SaleXProduct]
DELETE FROM [dbo].[bvc_SaleXProductType]
DELETE FROM [dbo].[bvc_SearchQuery]
DELETE FROM [dbo].[bvc_ShippingMethod]
DELETE FROM [dbo].[bvc_ShippingMethod_CountryRestriction]
DELETE FROM [dbo].[bvc_ShippingMethod_RegionRestriction]
DELETE FROM [dbo].[bvc_SiteTerm]
DELETE FROM [dbo].[bvc_Tax]
DELETE FROM [dbo].[bvc_TaxClass]
DELETE FROM [dbo].[tos_PostalCodes]
DELETE FROM [dbo].[bvc_UrlRedirect]
DELETE FROM [dbo].[bvc_User]
DELETE FROM [dbo].[bvc_UserQuestions]
DELETE FROM [dbo].[bvc_UserXContact]
DELETE FROM [dbo].[bvc_UserXRole]
DELETE FROM [dbo].[bvc_USGeoData]
DELETE FROM [dbo].[bvc_Vendor]
DELETE FROM [dbo].[bvc_WebAppSetting]
DELETE FROM [dbo].[bvc_WishList]
DELETE FROM [dbo].[bvc_WorkFlow]
DELETE FROM [dbo].[bvc_WorkFlowStep]

INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'181132ba-9889-4934-b711-3e8b0162fc0b', N'Order History', N'', N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', 1, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_Orders.aspx', 0, N'', N'', 1, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:27.140' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'2f31ed11-894e-4808-9a67-93397f6f01a8', N'Category 4', N'', N'0', 4, N'', N'', N'', N'', N'', 0, 1, 0, N'http://', 0, N'', N'', 1, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:24:52.367' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', N'Your Account', N'', N'0', 6, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_Orders.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:51:12.613' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'47a5eac2-1e97-478a-8687-72d1087a99d1', N'Mailing Lists', N'', N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', 5, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_MailingLists.aspx', 0, N'', N'', 1, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:27.260' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'67432af3-490b-46c2-a344-72daba4e06ac', N'Affiliate Program', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 8, N'', N'', N'', N'', N'', 2, 1, 0, N'/AffiliateSignup.aspx', 0, N'', N'', 0, 1, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 23:15:49.157' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'68bd8c26-76a1-4cda-8582-d339637023b3', N'Change Password', N'', N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', 7, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_ChangePassword.aspx', 0, N'', N'', 1, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:27.323' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'6caa1a91-d0d9-4d3c-8a01-e87806cbb9cb', N'Address Book', N'', N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', 3, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_AddressBook.aspx', 0, N'', N'', 1, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:27.203' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'6ec553b8-de6d-48fa-81a4-a4962b521330', N'Sub-Category 1', N'', N'be4ed31e-4234-42bf-a660-4505a97857a5', 1, N'', N'', N'', N'', N'', 0, 1, 0, N'http://', 0, N'', N'', 1, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:25:27.873' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'73d179b8-8a99-423f-b6ab-6ccc3d31fb9f', N'Wish List', N'', N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', 2, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_WishList.aspx', 0, N'', N'', 1, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:27.167' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'7aa9905a-d3af-416f-925f-06a40479de9f', N'Edit Address', N'', N'6caa1a91-d0d9-4d3c-8a01-e87806cbb9cb', 2, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_AddressBook_Edit.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 23:01:03.120' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'7deaf0fe-ad79-49f0-adfe-07c9c9fb9eba', N'Checkout', N'', N'd74b9e09-8e9e-44fa-bf2b-98e1163b8239', 1, N'', N'', N'', N'', N'', 2, 1, 0, N'/checkout/checkout.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:49:24.897' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'7e55e0cb-4635-4912-a099-30be0f9aa79b', N'Order Details', N'', N'181132ba-9889-4934-b711-3e8b0162fc0b', 1, N'', N'', N'', N'', N'', 2, 1, 0, N'/Myaccount_Orders_Details.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:59:54.110' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'870bbd73-eb9f-4607-95a5-84bf8b69d499', N'Shipping Policy', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 5, N'', N'', N'', N'', N'', 2, 1, 0, N'/shippingterms.aspx', 0, N'', N'', 0, 0, N'Grid', N'', N'', CAST(N'2015-02-09 23:15:31.620' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'914d3763-37aa-45bd-9b7e-a4205c82e6d2', N'Category 2', N'', N'0', 2, N'', N'', N'', N'', N'', 0, 1, 0, N'http://', 0, N'', N'', 1, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:24:38.973' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'b155518e-066e-4faf-ae94-94df17a04e2a', N'Order Status', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 3, N'', N'', N'', N'', N'', 2, 1, 0, N'/ViewOrder.aspx', 0, N'', N'', 0, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:26.950' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'baf94129-5d43-4bae-872b-34ed599e3394', N'Forgot Password', N'', N'0', 9, N'', N'', N'', N'', N'', 2, 1, 0, N'/ForgotPassword.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:50:57.550' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'be4ed31e-4234-42bf-a660-4505a97857a5', N'Category 1', N'', N'0', 1, N'', N'', N'', N'', N'', 0, 1, 0, N'http://', 0, N'', N'', 1, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:24:31.643' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'c0b9e396-e6e5-4d6b-82bd-c6e553ed5a02', N'Change Email', N'', N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', 6, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_ChangeEmail.aspx', 0, N'', N'', 1, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:27.297' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'c6441e54-2327-4f17-beba-93e7e91351e7', N'New Address', N'', N'6caa1a91-d0d9-4d3c-8a01-e87806cbb9cb', 1, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_AddressBook_New.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 23:00:34.220' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'c92e3583-23bd-4712-9701-53588fa7ed73', N'Store Themes', N'', N'405fbc5d-f5a6-4136-b7a0-6a4df17335f8', 4, N'', N'', N'', N'', N'', 2, 1, 0, N'/MyAccount_Themes.aspx', 0, N'', N'', 1, 1, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 23:07:44.757' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'd0b02d0d-bf68-4d93-af21-638f819c32fc', N'FAQ', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 2, N'', N'', N'', N'', N'', 2, 1, 0, N'/FAQ.aspx', 0, N'', N'', 0, 0, N'Grid', N'', N'', CAST(N'2015-02-09 22:58:26.920' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'd300eb71-b469-4182-9068-bce48faaacd7', N'Customer Service', N'', N'0', 5, N'', N'', N'', N'', N'', 2, 1, 0, N'/ContactUs.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-10 10:54:48.910' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'd5c0bba2-8de5-4989-ba61-e4e247b74598', N'Login', N'', N'0', 8, N'', N'', N'', N'', N'', 2, 1, 0, N'/Login.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:50:59.410' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'd6cf5ed3-e2fa-4c17-9a6b-6e7429fb08a5', N'Category 3', N'', N'0', 3, N'', N'', N'', N'', N'', 0, 1, 0, N'http://', 0, N'', N'', 1, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:24:45.360' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'd74b9e09-8e9e-44fa-bf2b-98e1163b8239', N'Cart', N'', N'0', 7, N'', N'', N'', N'', N'', 2, 1, 0, N'/Cart.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:51:10.777' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'e8aaa164-668d-4535-9e5e-fa3c56e4c36e', N'Terms and Conditions', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 6, N'', N'', N'', N'', N'', 2, 1, 0, N'/Terms.aspx', 0, N'', N'', 0, 0, N'Grid', N'', N'', CAST(N'2015-02-09 23:15:33.537' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'ea47a62e-5e4a-48dc-8979-7292f51bbc01', N'Privacy Policy', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 7, N'', N'', N'', N'', N'', 2, 1, 0, N'/Privacy.aspx', 0, N'', N'', 0, 0, N'Grid', N'', N'', CAST(N'2015-02-09 23:15:35.407' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'f242b0dc-dee5-48f6-ae5b-999d48167502', N'Sub-Category 2', N'', N'be4ed31e-4234-42bf-a660-4505a97857a5', 2, N'', N'', N'', N'', N'', 0, 1, 0, N'http://', 0, N'', N'', 1, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-09 22:25:36.867' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'f4d5f318-d961-490f-8646-30e8ec4be2a4', N'Return Policy', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 4, N'', N'', N'', N'', N'', 2, 1, 0, N'/ReturnForm.aspx', 0, N'', N'', 0, 0, N'Grid', N'', N'', CAST(N'2015-02-09 23:15:29.640' AS DateTime), N'', 1, N'', N'', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
INSERT [dbo].[bvc_Category] ([bvin], [Name], [Description], [ParentID], [SortOrder], [MetaTitle], [MetaKeywords], [MetaDescription], [ImageURL], [BannerImageURL], [SourceType], [DisplaySortOrder], [LatestProductCount], [CustomPageURL], [CustomPageNewWindow], [MenuOffImageURL], [MenuOnImageURL], [ShowInTopMenu], [Hidden], [TemplateName], [PostContentColumnId], [PreContentColumnId], [LastUpdated], [RewriteUrl], [ShowTitle], [Criteria], [CustomPageId], [PreTransformDescription], [Keywords], [CustomerChangeableSortOrder], [ShortDescription], [CustomProperties]) VALUES (N'f5bf9900-dffe-4888-a6b1-d738b68d3cd8', N'Contact Us', N'', N'd300eb71-b469-4182-9068-bce48faaacd7', 1, N'', N'', N'', N'', N'', 2, 1, 0, N'/ContactUs.aspx', 0, N'', N'', 0, 0, N'Grid', N' - None -', N' - None -', CAST(N'2015-02-10 10:54:20.803' AS DateTime), N'', 1, N'', N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'', N'', 0, N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />')
SET IDENTITY_INSERT [dbo].[bvc_Order] ON 

SET IDENTITY_INSERT [dbo].[bvc_Order] OFF
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'01e68cef-1c77-4c2a-bb7b-5295a71379ad', N'mk-MK', N'Macedonia', 0, N'MK', N'MKD', N'807', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'04a2314b-66a2-4157-b17c-0d848b73e9c6', N'en-JM', N'Jamaica', 0, N'JM', N'JAM', N'388', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'0d813c30-067a-4420-b159-84eb8c98b7cb', N'en-ZW', N'Zimbabwe', 0, N'ZW', N'ZWE', N'716', N'', CAST(N'2005-10-12 21:50:41.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'0f812320-3aaf-4f3e-96ff-01396751cca6', N'fr-LU', N'Luxembourg', 0, N'LU', N'LUX', N'442', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'1118faf0-bb14-41d4-9848-cc011f1a344a', N'ar-MA', N'Morocco', 0, N'MA', N'MAR', N'504', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'160dbdd9-9957-4bc2-8385-201c3bf32ea0', N'sk-SK', N'Slovakia', 0, N'SK', N'SVK', N'703', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'1a109d87-e02c-4ac9-b4c9-a4f74e802ebb', N'fr-MC', N'Monaco', 0, N'MC', N'MCO', N'492', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'1b5a4f35-08a6-4259-b375-c4416bec5f11', N'ar-QA', N'Qatar', 0, N'QA', N'QAT', N'634', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'1c076e3d-43d5-4b8f-bf8c-6946fb58d231', N'fr-FR', N'France', 0, N'FR', N'FRA', N'250', N'', CAST(N'2015-02-09 16:47:19.140' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'1cf4480c-5ef8-4a80-a43a-600a69ff2157', N'es-ES', N'Spain', 0, N'ES', N'ESP', N'724', N'', CAST(N'2007-01-04 10:32:36.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'1e4fadd8-5b90-4534-8220-6be963044f39', N'hy-AM', N'Armenia', 0, N'AM', N'ARM', N'051', N'', CAST(N'2005-10-12 21:49:18.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'1f54446f-f586-483a-9d7d-7eeb812f248c', N'da-DK', N'Denmark', 0, N'DK', N'DNK', N'208', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'225a471b-8c5c-4b86-9a2d-ea443919eb55', N'el-GR', N'Greece', 0, N'GR', N'GRC', N'300', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'226c5e05-3e46-4129-9594-268d156aaffa', N'zh-SG', N'Singapore', 0, N'SG', N'SGP', N'702', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'254a6f90-f4dd-4218-879e-9869c38f9236', N'ms-BN', N'Brunei Darussalam', 0, N'BN', N'BRN', N'096', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'255b01ab-4d4f-40eb-b63d-e86ed8f7bd13', N'ar-DZ', N'Algeria', 0, N'DZ', N'DZA', N'012', N'', CAST(N'2005-10-12 21:49:17.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'271f61fc-9f93-4ac2-bcda-d62640e23489', N'dv-MV', N'Maldives', 0, N'MV', N'MDV', N'462', N'', CAST(N'2015-02-09 16:47:12.543' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'292cc30a-8976-480f-8105-1e12aa128b2f', N'en-CB', N'Caribbean', 0, N'CB', N'', N'', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'2a330eef-a115-452a-a78d-d94a8d8b7da7', N'ar-LB', N'Lebanon', 0, N'LB', N'LBN', N'422', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'2c6d4fa9-941d-4d5d-807f-7bccba497680', N'sq-AL', N'Albania', 0, N'AL', N'ALB', N'008', N'', CAST(N'2005-10-12 21:49:10.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'2ebf498d-e6d6-4814-b5f9-f152afcac264', N'en-NZ', N'New Zealand', 0, N'NZ', N'NZL', N'554', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'3335935f-84fa-4dcd-9a0b-fa4d6506d2f3', N'lv-LV', N'Latvia', 0, N'LV', N'LVA', N'428', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'33ac233a-dc15-4aef-89db-7beda61b0436', N'pt-BR', N'Brazil', 0, N'BR', N'BRA', N'076', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'37ba6822-e99f-430a-a3ec-e665ac1a3c8d', N'zh-TW', N'Taiwan', 0, N'TW', N'TWN', N'158', N'', CAST(N'2006-08-04 12:05:32.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'39c7e72b-1721-451c-a2f7-476fcc20aa72', N'nb-NO', N'Norway', 0, N'NO', N'NOR', N'578', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'3c3c25d5-0067-49f2-b951-22877d41bbb4', N'sw-KE', N'Kenya', 0, N'KE', N'KEN', N'404', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'3c707cc5-8a8c-4be9-abd1-3dabdce6dd3f', N'en-PH', N'Philippines', 0, N'PH', N'PHL', N'608', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'3dc123db-aa7b-4223-a37a-793d84b35468', N'mn-MN', N'Mongolia', 0, N'MN', N'MNG', N'496', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'424dd0e3-3cf3-4d46-b13b-2ea43da8c8ac', N'es-EC', N'Ecuador', 0, N'EC', N'ECU', N'218', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'443e409d-0daf-413a-ac06-706375aa0775', N'th-TH', N'Thailand', 0, N'TH', N'THA', N'764', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'4787bcae-97ce-46ac-aedf-fc5bbc69e509', N'es-VE', N'Venezuela', 0, N'VE', N'VEN', N'862', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'4af15981-2ffe-44ff-8c18-7680851ea335', N'is-IS', N'Iceland', 0, N'IS', N'ISL', N'352', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'52b52f9e-a2c8-4e0d-92eb-678df74f921e', N'es-PA', N'Panama', 0, N'PA', N'PAN', N'591', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'57E083A5-43B6-47f5-90AF-E7153794F0C9', N'ko-KR', N'North Korea', 0, N'KP', N'PRK', N'408', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'58b3af90-cdbd-4d36-a56e-5a4a2f6d7dbe', N'es-UY', N'Uruguay', 0, N'UY', N'URY', N'858', N'', CAST(N'2006-08-04 12:05:29.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'62b52f42-fe5e-4329-8c40-8483ff1a6996', N'en-TT', N'Trinidad and Tobago', 0, N'TT', N'TTO', N'780', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'62f5a76b-622a-4611-9ad6-17465b56b816', N'tr-TR', N'Turkey', 0, N'TR', N'TUR', N'792', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'6594806a-8e9e-4424-ac4b-4ffa19adb683', N'de-AT', N'Austria', 0, N'AT', N'AUT', N'040', N'', CAST(N'2005-10-12 21:49:19.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'678de6b8-dcbb-4fcf-ac27-6c6f72dd5291', N'et-EE', N'Estonia', 0, N'EE', N'EST', N'233', N'', CAST(N'2005-10-12 21:49:28.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'67ce5007-5a16-47b0-bd85-173a8a758944', N'zh-HK', N'Hong Kong', 0, N'HK', N'HKG', N'344', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'68249d05-62f5-45c9-9735-4057bf0dee7e', N'ka-GE', N'Georgia', 0, N'GE', N'GEO', N'268', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'69135901-5cda-42b3-9bb9-eb0318c08ef5', N'es-AR', N'Argentina', 0, N'AR', N'ARG', N'032', N'', CAST(N'2005-10-12 21:49:17.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'6926f9ef-ccf2-43e4-9c3f-2b0477f4998e', N'en-BZ', N'Belize', 0, N'BZ', N'BLZ', N'084', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'6aa3072c-540f-4e07-b203-de21180a94bd', N'es-HN', N'Honduras', 0, N'HN', N'HND', N'340', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'6b6706b6-11ad-4843-bae6-bf8de441749a', N'ru-RU', N'Russia', 0, N'RU', N'RUS', N'643', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'6c866a94-5c9f-414b-b10d-64e8dd330761', N'es-NI', N'Nicaragua', 0, N'NI', N'NIC', N'558', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'6d37454c-7e9b-4a8c-981c-acc656cbb542', N'be-BY', N'Belarus', 0, N'BY', N'BLR', N'112', N'', CAST(N'2005-10-12 21:49:21.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'6f609d0b-e837-4f43-bd3b-a6f4b631942f', N'ar-JO', N'Jordan', 0, N'JO', N'JOR', N'400', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'727971df-2751-4e7f-9b22-5f4097241aa7', N'sl-SI', N'Slovenia', 0, N'SI', N'SVN', N'705', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'7ab0fab9-7605-45cc-a20a-3e59e0b6151f', N'ro-RO', N'Romania', 0, N'RO', N'ROU', N'642', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'815902dd-3392-4dc1-b148-3ddcb1a5828c', N'zh-MO', N'Macau', 0, N'MO', N'MAC', N'446', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'817edac5-daf0-4722-b02e-03e91309f5fe', N'es-CO', N'Colombia', 0, N'CO', N'COL', N'170', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'81cd3640-c7ce-483f-b40c-fee3ee6a3a39', N'uz-UZ-Latn', N'Uzbekistan', 0, N'UZ', N'UZB', N'860', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'831a08f8-f3bd-486a-8af5-d53bc2db69fb', N'az-AZ-Latn', N'Azerbaijan', 0, N'AZ', N'AZE', N'031', N'', CAST(N'2006-08-04 12:05:53.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'83bfd137-925d-4b64-9559-b6aa9baf9085', N'lt-LT', N'Lithuania', 0, N'LT', N'LTU', N'440', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'83cea890-c1de-41be-a213-635d1416d6db', N'es-CR', N'Costa Rica', 0, N'CR', N'CRI', N'188', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'85a3f763-9543-4a0a-921b-f71a36e3b811', N'ar-IQ', N'Iraq', 0, N'IQ', N'IRQ', N'368', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'864722db-70ae-4078-b80c-b60b5216b020', N'he-IL', N'Israel', 0, N'IL', N'ISR', N'376', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'8d447e0d-6327-4a05-a7e5-f50fc408e13c', N'de-DE', N'Germany', 0, N'DE', N'DEU', N'276', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'8f6413ef-2edd-4d6c-a9d8-40257bb9dca4', N'ar-BH', N'Bahrain', 0, N'BH', N'BHR', N'048', N'', CAST(N'2006-08-04 12:05:52.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'9046b9d5-9bb9-43f5-b605-e7164f99d7d9', N'zh-CN', N'China', 0, N'CN', N'CHN', N'156', N'', CAST(N'2006-08-04 12:05:50.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'90951a60-ed1a-475d-be9d-e11982593326', N'sv-SE', N'Sweden', 0, N'SE', N'SWE', N'752', N'', CAST(N'2005-10-12 21:49:36.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'94052dcf-1ac8-4b65-813b-b17b12a0491f', N'en-CA', N'Canada', 1, N'CA', N'CAN', N'124', N'', CAST(N'2007-05-17 12:12:28.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'956066df-b065-43f0-9a2e-85eed038717e', N'es-PR', N'Puerto Rico', 0, N'PR', N'PRI', N'630', N'', CAST(N'2006-08-04 12:05:35.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'99d0a3c3-4b61-4979-8fde-52584110392e', N'ar-EG', N'Egypt', 0, N'EG', N'EGY', N'818', N'', CAST(N'2006-08-04 12:05:49.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'9c7a73b1-7ef5-4fc2-beeb-ce4c70cca32f', N'en-GB', N'United Kingdom', 1, N'GB', N'GBR', N'826', N'', CAST(N'2007-03-19 09:47:06.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'a4ac08ae-548a-48bb-af12-d2167c26b673', N'en-IE', N'Ireland', 0, N'IE', N'IRL', N'372', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'a5ffd15d-731e-4d9d-b9c8-6f68cbffe625', N'ar-YE', N'Yemen', 0, N'YE', N'YEM', N'887', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'a863ac16-e89c-46cc-bfd4-d518843445b7', N'es-CL', N'Chile', 0, N'CL', N'CHL', N'152', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'aafcbe32-4e5a-4a8c-b101-699274072571', N'ar-OM', N'Oman', 0, N'OM', N'OMN', N'512', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'acf84f60-6b00-4131-a5be-fa202f1eb569', N'hu-HU', N'Hungary', 0, N'HU', N'HUN', N'348', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'acff76b1-cdd4-4c3e-872e-d655fb092a29', N'es-PE', N'Peru', 0, N'PE', N'PER', N'604', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'b430b323-926d-4f1a-ac22-eb1b1479fcf6', N'ja-JP', N'Japan', 0, N'JP', N'JPN', N'392', N'', CAST(N'2006-08-07 15:04:52.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'b698900d-71ca-43b3-977c-95d04c152141', N'id-ID', N'Indonesia', 0, N'ID', N'IDN', N'360', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'b8f7c10f-8274-4642-a828-8b41946ac95d', N'fo-FO', N'Faroe Islands', 0, N'FO', N'FRO', N'234', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'bd87cd0a-2470-4024-b8f2-bab111899375', N'ko-KR', N'South Korea', 0, N'KR', N'KOR', N'410', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'be09cdcc-73c5-4829-85a1-ef99a480add8', N'ar-KW', N'Kuwait', 0, N'KW', N'KWT', N'414', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'be57e8d8-6a09-4589-9181-d8558d27f4b5', N'hr-HR', N'Croatia', 0, N'HR', N'HRV', N'191', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', N'en-US', N'United States', 1, N'US', N'USA', N'840', N'^\d{5}$', CAST(N'2007-10-12 14:38:46.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'bfff7d8f-0beb-44d5-bd9c-745b7e939e83', N'en-ZA', N'South Africa', 0, N'ZA', N'ZAF', N'710', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'c2a2f20d-821c-4573-ab4d-349a8c858de7', N'es-SV', N'El Salvador', 0, N'SV', N'SLV', N'222', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'c636ea8b-a773-48df-b5dc-00bf3b8bef87', N'ar-SA', N'Saudi Arabia', 0, N'SA', N'SAU', N'682', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'c7cb9d92-9ca1-431e-8e27-e5953b895d92', N'bg-BG', N'Bulgaria', 0, N'BG', N'BGR', N'100', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'cb043623-5166-481b-bd1c-79f4f7a80b16', N'pt-PT', N'Portugal', 0, N'PT', N'PRT', N'620', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'cb2f2e2c-459b-4370-a077-7831fdd16733', N'es-MX', N'Mexico', 0, N'MX', N'MEX', N'484', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'cb87aef1-ae12-4363-a292-8cff1a4e4d02', N'en-AU', N'Australia', 1, N'AU', N'AUS', N'036', N'', CAST(N'2007-10-12 14:48:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'cd884fa0-4d0b-41d9-b45d-0a486fd71009', N'fi-FI', N'Finland', 0, N'FI', N'FIN', N'246', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'ceb2ea09-1d36-4b44-ac7c-c5d7660ef4f9', N'it-IT', N'Italy', 0, N'IT', N'ITA', N'380', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd11db563-7496-4eb5-88d1-81f20bbfbe8c', N'es-GT', N'Guatemala', 0, N'GT', N'GTM', N'320', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd2b92f8b-8645-433d-9f6d-63a34d895798', N'cs-CZ', N'Czech Republic', 0, N'CZ', N'CZE', N'203', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd3e3c48a-c2e9-4c91-98d0-bf2f7802d6d6', N'de-LI', N'Liechtenstein', 0, N'LI', N'LIE', N'438', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd53313a7-cc06-4b09-a56e-9715d32aaf02', N'ar-SY', N'Syrian Arab Republic', 0, N'SY', N'SYR', N'760', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd5e8ed18-b909-4fcf-b6c6-b7a7e00a28d4', N'sr-SP-Latn', N'Serbia', 0, N'RS', N'SRB', N'688', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd6764c27-b7b3-49bd-88fb-1385570ad5ef', N'fr-BE', N'Belgium', 0, N'BE', N'BEL', N'056', N'', CAST(N'2015-02-09 16:45:56.897' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd6ae4091-0de6-4fb6-b6f9-99e4f7d3a96a', N'nl-NL', N'Netherlands', 0, N'NL', N'NLD', N'528', N'', CAST(N'2007-03-06 14:40:25.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'd7c507f0-a613-418f-8011-df0d380d8835', N'vi-VN', N'Viet Nam', 0, N'VN', N'VNM', N'704', N'', CAST(N'2006-08-04 12:05:30.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'dc3b811a-83f5-4f89-a998-af5abd015109', N'ar-LY', N'Libya', 0, N'LY', N'LBY', N'434', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'deddf780-661e-41f7-b5aa-a539cd21e1dd', N'ms-MY', N'Malaysia', 0, N'MY', N'MYS', N'458', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'dfd415ae-d8e9-42b4-a143-d1bd6874efe3', N'ar-TN', N'Tunisia', 0, N'TN', N'TUN', N'788', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'e606fc92-c7a5-4bd5-abd4-f220db830ee2', N'es-PY', N'Paraguay', 0, N'PY', N'PRY', N'600', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
GO
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'e750df18-7cee-42b2-a334-ba82f26f3dd8', N'ur-PK', N'Pakistan', 0, N'PK', N'PAK', N'586', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'e911f5fb-157d-41ed-84d6-f7c23ac053cf', N'es-BO', N'Bolivia', 0, N'BO', N'BOL', N'068', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'ebb0cd59-d227-4c38-b31b-c6c93332bdde', N'fr-CH', N'Switzerland', 0, N'CH', N'CHE', N'756', N'', CAST(N'2006-08-04 12:05:33.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'ed004593-31b7-4c6b-b918-8e7efdb9c8e6', N'es-DO', N'Dominican Republic', 0, N'DO', N'DOM', N'214', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'f01b4b56-e99c-4b5d-b10e-29be58a79e9b', N'fa-IR', N'Iran', 0, N'IR', N'IRN', N'364', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'f23ea508-4df9-4aba-9b79-a3de288aa0b2', N'ar-AE', N'United Arab Emirates', 0, N'AE', N'ARE', N'784', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'f3e85660-e4a1-4dc8-afaf-4b4d0a0043f9', N'uk-UA', N'Ukraine', 0, N'UA', N'UKR', N'804', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'f6eb3a3f-ea89-43e3-90d4-b665d382542b', N'pl-PL', N'Poland', 0, N'PL', N'POL', N'616', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'f7867666-bb5e-46fe-9f49-39fdc0703382', N'kk-KZ', N'Kazakhstan', 0, N'KZ', N'KAZ', N'398', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Country] ([bvin], [CultureCode], [DisplayName], [Active], [ISOCode], [ISOAlpha3], [ISONumeric], [PostalCodeValidationRegex], [LastUpdated]) VALUES (N'fa10d66f-3a6a-4b3b-980a-cc66143a2328', N'hi-IN', N'India', 0, N'IN', N'IND', N'356', N'', CAST(N'2005-07-14 16:24:47.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'0435dfd5-3dd4-4ae7-8815-2b4c92a32de9', N'Manitoba', N'MB', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'05ee34b3-0274-4aae-a81a-d79302aca3ee', N'New Brunswick', N'NB', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'081f3890-a6d6-4c88-9dbd-58a58cd74736', N'Hawaii', N'HI', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'0d0a7cdc-8b4f-473d-98fe-dcf2a2396fc9', N'South Dakota', N'SD', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'0da7aca9-ced9-4cd0-b943-fbc78f2ff5bc', N'Idaho', N'ID', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'10473095-63a4-476e-8435-1ffdb7f2c90b', N'West Virginia', N'WV', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'16f5837c-7516-4c91-b592-09518f75f843', N'District Of Columbia', N'DC', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'18103f07-0875-4346-8f73-2ad3d2eec09d', N'Armed Forces Americas', N'AA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'1a13786b-e1e4-4e46-aa9b-4615a9c1089d', N'New Jersey', N'NJ', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'1cfc422f-24a1-43c4-b507-2a0130cc89f3', N'Oregon', N'OR', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'1e222f5b-c83f-455c-9353-67b7b2772f03', N'New Hampshire', N'NH', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'1f423c08-c341-437b-a347-2780bb987608', N'Northwest Territories', N'NT', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'20fe63de-2e42-4a9d-a3cd-afdc28bb7388', N'Alaska', N'AK', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'2353e51a-0bf6-4d96-8600-cc5429a3249a', N'Nevada', N'NV', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'255a78c3-a1a1-421b-8f7a-07190ea631e5', N'Washington', N'WA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'2882f923-be28-4b43-9725-913373f39895', N'Kentucky', N'KY', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'29b4944a-bb1c-4a2b-9f7a-d4b9d9f22590', N'Alberta', N'AB', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'2ce717a6-0885-4af4-8a23-e88645ffb34d', N'Armed Forces Middle', N'AE', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'3623afee-5b4f-4a9e-a276-ec511e75df04', N'Arizona', N'AZ', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'390e53a2-49a4-444f-a92a-765586fa6b33', N'Ontario', N'ON', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'39a9f11a-0a05-42a6-a6ac-2c8721ec5ccc', N'Iowa', N'IA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'3b0b9e9a-8ddb-4f50-8002-e8198da450a8', N'Virginia', N'VA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2006-08-31 16:28:13.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'3dbca8de-6ffe-465b-820b-babeb6fea700', N'Texas', N'TX', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'402a245b-0981-455c-b920-85c055cbfcb4', N'North Dakota', N'ND', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'43a1df26-b6d6-463e-998c-bada17c3496e', N'New Mexico', N'NM', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'44f7ea0e-1332-4dd9-a4f8-9fb8286eb04d', N'South Carolina', N'SC', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'4c31211e-d41d-4411-a2f6-f6a3cad37541', N'Michigan', N'MI', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'5b957830-dd43-4257-a866-b1a76d7dcaab', N'Maryland', N'MD', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'5d0019c3-7463-4420-81be-fcaa7716ec24', N'Prince Edward Island', N'PE', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'63dc7ec0-237e-49a2-bdd3-68f161b97d0d', N'Tennessee', N'TN', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'64df6892-ff0f-4b64-a958-a48afe3cc94e', N'Pennsylvania', N'PA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'685fd51c-3575-46b3-a4e8-104d91d1b5c6', N'Minnesota', N'MN', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'69180ec8-0a51-453a-b154-d4257f4a08fc', N'Oklahoma', N'OK', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'6b2d1cc6-55d4-44b8-b836-a1bb0f7b31dd', N'Illinois', N'IL', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'71846c9c-b57c-4202-a3a1-f473641228ea', N'Utah', N'UT', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'79e29ee3-6312-4af4-a61e-396db5bc25f9', N'Wisconsin', N'WI', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'8a268916-02af-4442-88a8-15d87e253f21', N'U.S. Virgin Islands', N'VI', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'8d62b1c1-d996-4f98-b74a-8fd5e931b937', N'Vermont', N'VT', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'8e752263-77e3-4e43-bba8-4580c1605ac7', N'North Carolina', N'NC', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'927fd1ec-b495-496b-9d15-a388ee0db03e', N'Armed Forces Africa', N'AE', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a0d0e3c8-e3e9-426f-97c4-da1ffc1f7c15', N'Saskatchewan', N'SK', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a18aa477-47a6-4ee3-8bea-6c53ca89fa89', N'Armed Forces Europe', N'AE', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a1b8be4d-7155-496a-8719-af428bbea622', N'Nova Scotia', N'NS', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a29415e7-9ee4-4d84-a5e3-594388772dba', N'Wyoming', N'WY', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a40f6951-8a13-4e04-a31a-837293a0a11a', N'Montana', N'MT', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a5654183-1341-4550-9f8c-2b02b7fd5671', N'Nunavut', N'NU', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a6e48f24-d642-4448-a6f5-5752ddb3061e', N'Connecticut', N'CT', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a7522467-50ba-450c-8c3f-eab844653c81', N'Georgia', N'GA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'a9fe39c5-0e13-43fa-a6be-4fcd6bbb3324', N'Florida', N'FL', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'adf175d7-893d-45f6-8028-5ead7fc1d719', N'Missouri', N'MO', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'b8f2e615-b45f-4747-be34-a48782938462', N'Massachusetts', N'MA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'c05f2afd-a3a5-4bf9-8e01-799218143d5a', N'Newfoundland', N'NL', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'c6b59551-89cb-4112-a499-bd1275124a30', N'Rhode Island', N'RI', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'c7e079f5-9b2a-4c1b-bac0-a3307f552d8d', N'Colorado', N'CO', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'c85d3542-87b0-4430-807d-611c15f958fa', N'Louisiana', N'LA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'ce78ecfc-56dc-485d-9cbf-66652ac404c5', N'Arkansas', N'AR', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'cf46daba-5077-42f0-ae02-6cd256bd395b', N'Maine', N'ME', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'd098c151-8c57-4306-b3a6-11ae33cc03e7', N'Delaware', N'DE', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'd0e1724a-ffca-441f-83f6-110d33bd81ca', N'Alabama', N'AL', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'd102e7b1-b43f-4608-bed8-b7ff767f5c7b', N'Ohio', N'OH', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'd5adb4f2-ddab-46db-ba72-b673c9fb85e7', N'British Columbia', N'BC', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'd5fbab6f-edef-4c99-842e-92462591b59f', N'Indiana', N'IN', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'd77a5759-4e2c-457b-a03a-accf9c89123c', N'California', N'CA', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'da3fb9d3-9520-4e35-b3a2-59bce5357c78', N'Mississippi', N'MS', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'de2b5f2a-31b1-4493-be67-f8f4e0e4c682', N'Armed Forces Pacific', N'AP', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'e51d6281-07f5-46b7-a88d-c13870adeec1', N'Kansas', N'KS', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'e79c556e-667a-4c46-b868-bb594a64bd41', N'Nebraska', N'NE', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'e9f7face-960d-49dc-ba83-4040b3cdbdc2', N'Armed Forces Canada', N'AE', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'edaa3862-e7a2-4b7b-a7eb-dd2a80302b5a', N'New York', N'NY', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0', CAST(N'2006-08-31 16:28:08.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'f3e8ee46-421f-4632-9949-fd78552fe8db', N'Quebec', N'QC', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_Region] ([bvin], [Name], [Abbreviation], [CountryID], [LastUpdated]) VALUES (N'f51fce3e-db03-4bb3-893a-9d6c526153f4', N'Yukon Territory', N'YT', N'94052dcf-1ac8-4b65-813b-b17b12a0491f', CAST(N'2005-07-14 16:40:40.000' AS DateTime))
INSERT [dbo].[bvc_User] ([bvin], [UserName], [Password], [FirstName], [LastName], [Salt], [TaxExempt], [Email], [CreationDate], [LastLoginDate], [PasswordHint], [Comment], [AddressBook], [LastUpdated], [PasswordAnswer], [PasswordFormat], [Locked], [LockedUntil], [FailedLoginCount], [BillingAddress], [ShippingAddress], [PricingGroup], [CustomQuestionAnswers], [PasswordLastSet], [PasswordLastThree], [CustomProperties], [IsSalesPerson]) VALUES (N'30', N'admin', N'r0227FSenzG6tXlG9chLnw==', N'Aaron', N'Sherrick', N'7d426863-f23e-4a0f-9ced-4a3414c977cc', 0, N'admin@bvcommerce.com', CAST(N'2005-09-05 00:00:00.000' AS DateTime), CAST(N'2015-02-10 11:58:00.183' AS DateTime), N'', N'', N'<?xml version="1.0" encoding="utf-16"?>
<AddressBook />', CAST(N'2015-02-10 11:58:00.010' AS DateTime), N'', 1, 0, CAST(N'2006-06-09 15:58:31.000' AS DateTime), 0, N'<Address><Bvin /><NickName /><FirstName>Aaron</FirstName><MiddleInitial /><LastName>Sherrick</LastName><Company>Develisys</Company><Line1>5 S Water St</Line1><Line2></Line2><Line3 /><City>Hummelstown</City><RegionName>PA</RegionName><RegionBvin>64df6892-ff0f-4b64-a958-a48afe3cc94e</RegionBvin><PostalCode>23229</PostalCode><CountryName>United States</CountryName><CountryBvin>bf7389a2-9b21-4d33-b276-23c9c18ea0c0</CountryBvin><Phone>888-665-8637</Phone><Fax>717-566-9603</Fax><WebSiteUrl>http://www.bvcommerce.com</WebSiteUrl><CountyName /><CountyBvin /><UserBvin /><Residential>false</Residential><LastUpdated>0001-01-01T00:00:00</LastUpdated></Address>', N'<Address><Bvin /><NickName /><FirstName>Aaron</FirstName><MiddleInitial /><LastName>Sherrick</LastName><Company>Develisys</Company><Line1>5 S Water St</Line1><Line2></Line2><Line3 /><City>Hummelstown</City><RegionName>PA</RegionName><RegionBvin>64df6892-ff0f-4b64-a958-a48afe3cc94e</RegionBvin><PostalCode>23229</PostalCode><CountryName>United States</CountryName><CountryBvin>bf7389a2-9b21-4d33-b276-23c9c18ea0c0</CountryBvin><Phone>888-665-8637</Phone><Fax>717-566-9603</Fax><WebSiteUrl>http://www.bvcommerce.com</WebSiteUrl><CountyName /><CountyBvin /><UserBvin /><Residential>false</Residential><LastUpdated>0001-01-01T00:00:00</LastUpdated></Address>', N'', N'', CAST(N'2015-02-09 21:39:34.457' AS DateTime), N'', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfCustomProperty xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" />', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'07d8886d-c574-4121-958c-bb368c4b9f5c', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'Web Services Access', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'18749fa3-4b31-4d3a-93cb-ce983cd9c347', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'Product Admin', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'36CC0F07-2DE4-4d25-BF60-C80BC0214F09', CAST(N'2006-08-04 13:35:36.000' AS DateTime), N'New Adminstrator', 1)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'5dbd2e56-f2fb-4aec-b091-f340d21cba39', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'Report Users', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'60ae86b0-ddc3-49a5-912d-027c2c1d693c', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'Order Admin', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'6ca5482a-1906-419e-bec5-5595fab03256', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'Wholesale Customers', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'c93d7a6f-d9a0-4e9d-b6af-751ecec76c8b', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'Content Admin', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'e1068a90-ca61-4fa9-acf7-c54bfa7e1ae1', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'Settings Admin', 0)
INSERT [dbo].[bvc_Role] ([bvin], [LastUpdated], [RoleName], [SystemRole]) VALUES (N'e2908188-cbd5-465d-adc1-8df712d3a9d7', CAST(N'2006-08-28 14:15:13.000' AS DateTime), N'People Admin', 0)
INSERT [dbo].[bvc_MailingList] ([bvin], [Name], [Private], [LastUpdated]) VALUES (N'8858e25b-d9a0-4ae7-b74b-bdecd0c77a8d', N'Store Mailing List', 0, CAST(N'2006-08-31 16:25:18.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'1                                   ', N'System Homepage 1', 1, CAST(N'2005-09-07 22:50:35.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'101', N'System Admin Dashboard 1', 1, CAST(N'2006-04-13 12:14:58.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'102', N'System Admin Dashboard 2', 1, CAST(N'2006-04-13 12:15:11.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'103', N'System Admin Dashboard 3', 1, CAST(N'2006-04-13 12:15:20.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'2                                   ', N'System Homepage 2', 1, CAST(N'2005-09-07 22:50:35.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'3                                   ', N'System Homepage 3', 1, CAST(N'2005-09-07 22:50:35.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'33c09dba-543f-46a8-b023-a45589c544cc', N'PreFooter Column 5-6', 0, CAST(N'2015-02-09 21:53:29.943' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'3fdcaa5e-b9e7-450c-8607-d4d045822b23', N'PreFooter Column 2', 0, CAST(N'2015-02-09 22:43:20.083' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'4                                   ', N'System Category Page', 1, CAST(N'2005-09-07 22:50:35.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'482ab4c3-a799-4f98-abab-2fa9607b413a', N'System Account Pages', 1, CAST(N'2006-05-16 15:47:56.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'5                                   ', N'System Product Page', 1, CAST(N'2005-09-07 22:50:35.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'657b243a-f888-4d43-bd13-97a2b1b2c3f9', N'PreFooter Column 1', 0, CAST(N'2015-02-09 21:32:38.133' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'9fd3f81c-61fd-4d11-b339-50c32074c95b', N'Footer Column 2', 0, CAST(N'2015-02-09 21:24:07.243' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'a076a30a-0ce7-468f-8a58-799a3397886a', N'PreFooter Column 4', 0, CAST(N'2015-02-09 21:52:06.043' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'b3658e33-1501-4ae4-b95e-594698e0e4c2', N'System Service Pages', 1, CAST(N'2006-05-15 17:40:25.000' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'bd3eb7b7-1901-45bd-855b-fa62aee19525', N'PreFooter Column 3', 0, CAST(N'2015-02-09 21:37:58.403' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'c15fa32c-bb55-427c-96aa-2eb1a914c1b9', N'Footer Column 1', 0, CAST(N'2015-02-09 21:23:58.867' AS DateTime))
INSERT [dbo].[bvc_ContentColumn] ([bvin], [DisplayName], [SystemColumn], [LastUpdated]) VALUES (N'e2c83778-b8ba-4e4f-a190-cf7f988faac9', N'Nav', 0, CAST(N'2015-02-09 21:23:44.427' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'1', 1, N'Html', CAST(N'2015-02-09 22:14:18.723' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'00cd335d-d64c-48a9-84f5-01e422824389', N'101', 4, N'Reviews to Moderate', CAST(N'2006-08-09 15:08:57.000' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'022256cc-c09f-40b1-971c-f515b47361bc', N'103', 3, N'RSS Feed Viewer', CAST(N'2006-08-10 12:00:27.000' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'101', 3, N'Side Menu', CAST(N'2006-08-09 15:09:47.000' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'a076a30a-0ce7-468f-8a58-799a3397886a', 1, N'Html', CAST(N'2015-02-09 21:52:12.373' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'c15fa32c-bb55-427c-96aa-2eb1a914c1b9', 1, N'Html', CAST(N'2015-02-09 21:27:44.803' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'657b243a-f888-4d43-bd13-97a2b1b2c3f9', 2, N'Category Menu Plus', CAST(N'2015-02-09 21:34:18.530' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'5', 1, N'Category Menu Plus', CAST(N'2015-02-09 23:42:53.627' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'3e17dd23-f2f0-4f0b-869f-df7761505874', N'101', 6, N'Html', CAST(N'2006-08-09 15:08:54.000' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'3e20a49f-6cd4-4130-bbaa-1c4aea8e9437', N'33c09dba-543f-46a8-b023-a45589c544cc', 2, N'Mailing List Signup', CAST(N'2015-02-09 21:53:55.180' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'657b243a-f888-4d43-bd13-97a2b1b2c3f9', 1, N'Html', CAST(N'2015-02-09 21:34:18.513' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'9fd3f81c-61fd-4d11-b339-50c32074c95b', 1, N'Html', CAST(N'2015-02-09 21:28:47.103' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'2', 1, N'Html', CAST(N'2015-02-09 22:15:50.410' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'482ab4c3-a799-4f98-abab-2fa9607b413a', 1, N'Category Menu Plus', CAST(N'2015-02-09 23:04:22.873' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'33c09dba-543f-46a8-b023-a45589c544cc', 1, N'Html', CAST(N'2015-02-09 21:53:33.803' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'b3658e33-1501-4ae4-b95e-594698e0e4c2', 1, N'Category Menu Plus', CAST(N'2015-02-09 23:10:20.717' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'4', 1, N'Category Menu Plus', CAST(N'2015-02-09 23:41:30.300' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'd274ab7d-1a90-4e3c-81e8-4b52bdc49930', N'101', 5, N'Side Menu', CAST(N'2006-08-09 15:08:55.000' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'e2c83778-b8ba-4e4f-a190-cf7f988faac9', 1, N'Category Menu Plus', CAST(N'2015-02-09 22:10:17.053' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'102', 5, N'Order Activity', CAST(N'2006-08-08 15:50:10.000' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'ef4072da-bd18-4032-884b-8188a5765bd0', N'5', 2, N'Last Products Viewed', CAST(N'2015-02-09 23:43:25.667' AS DateTime))
INSERT [dbo].[bvc_ContentBlock] ([bvin], [ColumnID], [SortOrder], [ControlName], [LastUpdated]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'bd3eb7b7-1901-45bd-855b-fa62aee19525', 1, N'Html', CAST(N'2015-02-09 21:39:28.417' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'070F3D47-1182-4e08-92C4-F317544F0FA2', N'Content - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'0984762F-9E31-4f6f-A087-138A69973AE1', N'Settings - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'0B2DCF72-145C-48e0-B5A3-7C54D44805D2', N'Catalog - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'1085A525-F084-47df-B791-65DFA148D3C5', N'Marketing - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'34CD8C5C-9906-49c0-8F8A-9D85275D6A51', N'Roles - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'403F3109-1A6D-48D6-8753-91EA59A8A318', N'Plug-ins - View', 1, CAST(N'2007-10-04 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'46B42418-E039-477e-A412-6602B02DC166', N'Roles - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'4F708BA8-00B5-4171-B2AA-FC785319891D', N'Orders - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'5519BC97-9CE4-4549-AFF1-56B6A54D449C', N'People - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'6C049663-35F2-4b6f-89DE-02FD33AF3E39', N'Login to Admin', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'7379A1FF-50AC-4504-9553-E8296029C804', N'Settings - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'7B85F2F9-E565-4ddb-AEE6-5E5B6EFF54D7', N'Reports - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'83D27138-E941-4aaf-8A45-AA4F39D242E8', N'Marketing - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'C2B41076-A952-49ff-B2E2-DE62EFC2B554', N'Reports - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'D0201557-356F-4ee6-A24C-3C0F85E2C472', N'Catalog - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'D9900036-0794-4aa5-B662-28E99A23E9B1', N'Orders - View', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'ECCB357A-FB25-4176-835E-95650160CF77', N'Login to Web Services', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'F008F7DF-CCA4-4db1-8484-9A758AD42A76', N'People - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_RolePermission] ([bvin], [Name], [SystemPermission], [LastUpdated]) VALUES (N'F5E5B463-B0CB-4f4b-9CC4-01817D99E1A6', N'Content - Edit', 1, CAST(N'2005-09-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'2ABF8529-DDA9-4d3f-B514-3C7F8573E342', N'Shipping Policy', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'5F2A8111-00A0-4df5-872B-891B3E6ADBAE', N'Affiliate Terms and Conditions', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'6FE97141-772A-4a18-909A-719F20C9054F', N'Privacy Policy', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'715cdd98-6d10-482f-b397-6c86bf7f6fee', N'Affiliate Thanks', 1, CAST(N'2006-05-10 11:43:24.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'B5DD1832-1F41-47da-9F12-6F3BACA77C8A', N'Return Page Introduction', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'B680F6C0-DEFB-4e74-A953-720972BFCB90', N'Return Policy', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'B9342ADF-7CD3-4618-881E-DE5AEDBAAD95', N'Frequently Asked Questions', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'CA9A6D20-1979-4cdc-87B4-672C4D94DD02', N'Return Page Completed', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'cac3ace1-e4e8-4d49-a9b1-ef4b113f7e6c', N'Affiliate Intro', 1, CAST(N'2006-05-09 14:59:41.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'D66B897E-F0A3-4ed4-B4B1-E35C29D029A4', N'Customer Service Page', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'DEFFEF39-C451-41bb-A0AD-D7F2CBA9135D', N'Terms and Conditions', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'E3E14D93-5920-46b0-B0CB-478021A01032', N'Return Page Body', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_Policy] ([bvin], [Title], [SystemPolicy], [LastUpdated]) VALUES (N'F1E327F0-A99A-4903-A157-093CFE077F04', N'Contact Us Page', 1, CAST(N'2005-08-01 00:00:00.000' AS DateTime))
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'12CEE854-CAF9-4268-93C7-2D68CAAF8675', N'Commitment to Data Security', N'<P>Your personally identifiable information is kept secure. Only authorized employees, agents and contractors (who have agreed to keep information secure and confidential) have access to this information. All emails and newsletters from this site allow you to opt out of further mailings.</P>', 5, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'6FE97141-772A-4a18-909A-719F20C9054F', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'1b452da3-4c3b-4f3c-90fb-bcfa9e943344', N'Affiliate Intro Text', N'You should join our affiliate program because it rocks! Also you can make money.', 1, CAST(N'2006-05-16 18:46:42.000' AS DateTime), N'cac3ace1-e4e8-4d49-a9b1-ef4b113f7e6c', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'2A9AF4B5-846D-4624-8D2C-D714A5E4507D', N'Affilate Program Terms', N'As an affiliate you agree to...<br>
&nbsp;<br>', 1, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'5F2A8111-00A0-4df5-872B-891B3E6ADBAE', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'2b6f49bd-2c9a-43be-bd0f-2b5e876958ed', N'How can I contact you?', N'<p>Click on the Contact Us link in the Customer Service menu.</p>', 1, CAST(N'2006-05-17 17:54:35.000' AS DateTime), N'B9342ADF-7CD3-4618-881E-DE5AEDBAAD95', N'Click on the Contact Us link in the Customer Service menu.')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'300F5B64-3455-4b57-81E3-375F2EA3D1F2', N'Collection of Information', N'<P>We collect personally identifiable information, like names, postal addresses, email addresses, etc., when voluntarily submitted by our visitors. The information you provide is used to fulfill your specific request. This information is only used to fulfill your specific request, unless you give us permission to use it in another manner, for example to add you to one of our mailing lists.</P>', 2, CAST(N'2005-08-26 17:48:10.000' AS DateTime), N'6FE97141-772A-4a18-909A-719F20C9054F', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'42723340-DACE-403d-89CE-257CFB9F5C40', N'ReturnFormIntro', N'<p>
To return an item please fill out this form completely.
</p>', 1, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'B5DD1832-1F41-47da-9F12-6F3BACA77C8A', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'4B26FEDD-6A88-403c-9961-1C1A36634FF8', N'Return Policy', N'All returns are subject to approval by a store manager.', 1, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'B680F6C0-DEFB-4e74-A953-720972BFCB90', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'5361ba5f-dbd1-43d0-aef2-efd3ff41909d', N'Contact Form Header', N'<p><strong>Please fill out the form below in it&#8217;s entirety</strong>
<hr /></p>', 2, CAST(N'2006-08-15 12:31:09.000' AS DateTime), N'F1E327F0-A99A-4903-A157-093CFE077F04', N'<p><strong>Please fill out the form below in it&#8217;s entirety</strong>
<hr /></p>')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'5977F6AC-1295-4016-A634-F7DEDC097A38', N'Customer Service', N'Customer Service Content Here', 1, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'D66B897E-F0A3-4ed4-B4B1-E35C29D029A4', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'6E9168A2-A55F-4ffd-840C-5E8A788A8570', N'ReturnFormPolicy', N'<ul><li>Items must be returned within 15 days of receipt.</li><li>Returned items may be subject to a restocking fee.</li><li>All items must be returned in the original containers.</li></ul>', 1, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'E3E14D93-5920-46b0-B0CB-478021A01032', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'6F654437-FF88-4964-BBA1-64413B87C9B1', N'', N'<P>We reserve the right to make changes to this policy. Any changes to this policy will be posted.</P>', 7, CAST(N'2005-12-29 17:42:11.000' AS DateTime), N'6FE97141-772A-4a18-909A-719F20C9054F', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'82E9C630-2782-4b8f-BE3E-8C7C48514097', N'Distribution of Information', N'<P>We may share information with governmental agencies or other companies assisting us in fraud prevention or investigation. We may do so when: (1) permitted or required by law; or, (2) trying to protect against or prevent actual or potential fraud or unauthorized transactions; or, (3) investigating fraud which has already taken place. The information is not provided to these companies for marketing purposes.</P>', 4, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'6FE97141-772A-4a18-909A-719F20C9054F', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'A3F1B1A5-EA40-4e83-8CF0-D07C07B241E8', N'', N'<P>Thank you for visiting our web site. This privacy policy tells you how we use personal information collected at this site. Please read this privacy policy before using the site or submitting any personal information. By using the site, you are accepting the practices described in this privacy policy. These practices may be changed, but any changes will be posted and changes will only apply to activities and information on a going forward, not retroactive basis. You are encouraged to review the privacy policy whenever you visit the site to make sure that you understand how any personal information you provide will be used. </P>
<P>Note, the privacy practices set forth in this privacy policy are for this web site only. If you link to other web sites, please review the privacy policies posted at those sites.</P>', 1, CAST(N'2005-08-26 17:48:10.000' AS DateTime), N'6FE97141-772A-4a18-909A-719F20C9054F', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'ACC59C53-80CF-4134-ABD8-12D094359D0F', N'Shipping Policy', N'<p>All shipping charges are estimated. Actual shipping charges may vary.</p>', 1, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'2ABF8529-DDA9-4d3f-B514-3C7F8573E342', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'B4B37F60-C96B-404a-9917-69DA17625D67', N'Cookie/Tracking Technology', N'<P>The Site may use cookie and tracking technology depending on the features offered. Cookie and tracking technology are useful for gathering information such as browser type and operating system, tracking the number of visitors to the Site, and understanding how visitors use the Site. Cookies can also help customize the Site for visitors. Personal information cannot be collected via cookies and other tracking technology, however, if you previously provided personally identifiable information, cookies may be tied to such information. Aggregate cookie and tracking information may be shared with third parties.</P>', 3, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'6FE97141-772A-4a18-909A-719F20C9054F', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'C767D8C3-4001-4942-A8D8-B6D4DF75708F', N'Terms And Conditions', N'<P>By visiting or shopping at this web site, you accept the following terms and conditions. Please read them carefully.</P>
<H3>Copyright</H3>
<P>All content included on this site, such as text, graphics, logos, button icons, images, audio clips, digital downloads, data compilations, and software, is the property of this site''s owner or its content suppliers and protected by United States and international copyright laws. The compilation of all content on this site is the exclusive property of this site''s owner and protected by U.S. and international copyright laws. All software used on this site is the property of this site''s owner or its software suppliers and protected by United States and international copyright laws.</P>
<H3>Disclaimer of Warranties and Limitation of Liability</H3>
<P>THIS SITE IS PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS. NO REPRESENTATIONS OR WARRANTIES OF ANY KIND ARE MADE, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THIS SITE OR THE INFORMATION, CONTENT, MATERIALS, OR PRODUCTS INCLUDED ON THIS SITE. YOU EXPRESSLY AGREE THAT YOUR USE OF THIS SITE IS AT YOUR SOLE RISK.</P>
<P>TO THE FULL EXTENT PERMISSIBLE BY APPLICABLE LAW, THIS SITE''S OWNER DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THIS SITE''S OWNER DOES NOT WARRANT THAT THIS SITE, ITS SERVERS, OR E-MAIL SENT FROM THIS SITE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS. THIS SITE''S OWNER WILL NOT BE LIABLE FOR ANY DAMAGES OF ANY KIND ARISING FROM THE USE OF THIS SITE, INCLUDING, BUT NOT LIMITED TO DIRECT, INDIRECT, INCIDENTAL, PUNITIVE, AND CONSEQUENTIAL DAMAGES. </P>
<P>CERTAIN STATE LAWS DO NOT ALLOW LIMITATIONS ON IMPLIED WARRANTIES OR THE EXCLUSION OR LIMITATION OF CERTAIN DAMAGES. IF THESE LAWS APPLY TO YOU, SOME OR ALL OF THE ABOVE DISCLAIMERS, EXCLUSIONS, OR LIMITATIONS MAY NOT APPLY TO YOU, AND YOU MIGHT HAVE ADDITIONAL RIGHTS. </P>', 1, CAST(N'2005-08-26 12:33:02.000' AS DateTime), N'DEFFEF39-C451-41bb-A0AD-D7F2CBA9135D', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'c8e41935-59b5-466d-a148-f38cc6af5b1f', N'Affiliate Thanks Text', N'Thank you for joining our affiliate program!', 1, CAST(N'2006-05-10 11:43:53.000' AS DateTime), N'715cdd98-6d10-482f-b397-6c86bf7f6fee', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'CE241BE1-A6BB-4b5c-BB15-879C265AC209', N'ReturnFormComplete', N'<p>Thank you. Your request has been received. If you have any other questions please contact our customer service center.</p>', 1, CAST(N'2005-07-19 10:42:17.000' AS DateTime), N'CA9A6D20-1979-4cdc-87B4-672C4D94DD02', N'')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'CFEF942E-969A-4aed-A6B7-8FF515F4EA6F', N'', N'<p>Business hours are M-F 9am through 5pm Eastern Standard Time.</p>', 1, CAST(N'2006-07-12 12:33:39.000' AS DateTime), N'F1E327F0-A99A-4903-A157-093CFE077F04', N'<p>Business hours are M-F 9am through 5pm Eastern Standard Time.</p>

')
INSERT [dbo].[bvc_PolicyBlock] ([bvin], [Name], [Description], [SortOrder], [LastUpdated], [PolicyID], [DescriptionPreTransform]) VALUES (N'D7281026-AB8E-447d-AF5F-9C9696A7E940', N'Privacy Contact information', N'<P>If you have any questions, concerns, or comments about our privacy policy you may contact us using the information below:</P>
<UL>
<LI>By E-Mail: xxxxxx@xxxxxx.xxx
<LI>By Phone: xxx-xxx-xxxx</LI></UL>', 6, CAST(N'2005-12-29 17:42:11.000' AS DateTime), N'6FE97141-772A-4a18-909A-719F20C9054F', N'')
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'09739bec-8974-4c38-b026-f6ca8aed615d', 2, N'Third Party Checkout Selected', 1, CAST(N'2006-07-24 09:17:45.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'0bd9414e-00a0-414e-8eb7-61121358a609', 2, N'Shipping Changed', 1, CAST(N'2006-06-13 16:52:59.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'11dc88f5-43f2-44bb-bb86-1141d6aee495', 2, N'Process New Return', 1, CAST(N'2007-02-27 11:34:00.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'242848e0-1e5a-4a85-be62-887a21fdf0f9', 2, N'Checkout Selected', 1, CAST(N'2006-10-26 10:41:32.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'268ff9dc-ae7f-4faf-9944-d1aa15e64852', 3, N'Shipping Adjustments', 1, CAST(N'2006-10-16 11:35:53.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'53d0a831-1401-4d4c-bf44-66c2493b2cec', 2, N'Checkout Started', 1, CAST(N'2006-07-19 12:16:14.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'8b95070d-ce9b-4b43-9905-0981fbedd5af', 1, N'Product Pricing', 1, CAST(N'2006-03-29 10:30:23.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'c84658fb-fc72-458a-b0e6-c1708d9e84f2', 2, N'Payment Complete', 1, CAST(N'2006-06-15 15:08:33.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'cf1bc2b5-b371-4b57-80c5-f26fbce94064', 2, N'Dropship', 1, CAST(N'2006-06-14 15:51:59.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'd139a636-04c7-41b9-adca-0533432735bc', 2, N'Shipping Complete', 1, CAST(N'2006-08-25 16:24:01.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'db14f186-4005-4726-9a37-d67c2dc284ec', 2, N'Payment Changed', 1, CAST(N'2006-05-23 10:51:11.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'ddfc85a3-97f6-4d53-9e26-0f34518ef207', 2, N'Calculate Order', 1, CAST(N'2006-04-07 17:53:55.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'eac003c6-a354-489f-ba2c-029f4311851a', 2, N'Process New Order', 1, CAST(N'2006-03-29 10:30:54.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'ee046427-9da3-431f-92b8-5665ec20a59c', 2, N'Order Edited', 1, CAST(N'2006-10-20 16:02:07.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlow] ([bvin], [ContextType], [Name], [SystemWorkFlow], [LastUpdated]) VALUES (N'f9d6b245-8809-4500-bd72-b54618b2d0a7', 2, N'Package Shipped', 1, CAST(N'2006-10-19 15:08:40.000' AS DateTime))
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'062bc1ee-8fb8-4247-8d00-889c58b7e576', N'eac003c6-a354-489f-ba2c-029f4311851a', 11, N'14D38D1A-8B26-4a8b-B143-8485B4E7A584', N'Local Fraud Check', CAST(N'2006-08-29 12:11:13.000' AS DateTime), N'Local Fraud Check')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'0b289711-c570-4851-8ff2-cb29613c0c4f', N'0bd9414e-00a0-414e-8eb7-61121358a609', 4, N'30B9B11C-1621-4779-ABC2-FEC5D280484B', N'Update Order', CAST(N'2006-11-07 10:32:23.000' AS DateTime), N'Update Order')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'10594dd2-da98-4e09-8462-bdd0c79cbc99', N'c84658fb-fc72-458a-b0e6-c1708d9e84f2', 2, N'203bf29e-52e4-468a-8899-0498f1f48886', N'Issue Gift Certificates', CAST(N'2006-07-03 12:16:25.000' AS DateTime), N'Issue Gift Certificates')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'194d3c8a-ed8b-45aa-acdc-d1a567ead206', N'ddfc85a3-97f6-4d53-9e26-0f34518ef207', 3, N'963DBBCB-A206-4e6e-88DD-1204EE0B96F2', N'Apply Product Shipping Modifiers', CAST(N'2006-08-10 12:18:20.000' AS DateTime), N'Apply Product Shipping Modifiers')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'1f3a266e-6735-4255-b81c-30efd55cdb5e', N'eac003c6-a354-489f-ba2c-029f4311851a', 15, N'B1BAE947-3F33-473f-8AFE-F27A6B9625D3', N'Email Order', CAST(N'2006-08-29 12:11:14.000' AS DateTime), N'Send Email to Customer')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'23699613-8013-4083-8677-1d2181480948', N'eac003c6-a354-489f-ba2c-029f4311851a', 1, N'F2B91F7A-2634-42e1-9915-5C4AFD5188B8', N'Assign Order Number', CAST(N'2006-03-29 20:48:21.000' AS DateTime), N'')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'261c2448-dd10-4f7a-aeb7-fa787c11c42d', N'ee046427-9da3-431f-92b8-5665ec20a59c', 2, N'BBB0800B-4ED6-4060-9FBA-1B8D7EEAA686', N'Update Loyalty Points', CAST(N'2013-08-26 08:27:45.000' AS DateTime), N'Update Loyalty Points')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'2a0422be-5aae-459e-88bb-08e21018274b', N'8b95070d-ce9b-4b43-9905-0981fbedd5af', 5, N'4EDA00D6-CBC0-4b13-8B5B-FEAACEF63B15', N'Check for Price Below Cost', CAST(N'2007-02-09 10:34:42.000' AS DateTime), N'Check for Price Below Cost')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'2ea5fa6e-40bd-4b87-a4c2-7b04f36d9f8a', N'c84658fb-fc72-458a-b0e6-c1708d9e84f2', 4, N'e3cff8c5-b691-4a2a-b96d-d70f508d81d2', N'Avalara Commit Taxes', CAST(N'2013-08-27 22:15:34.000' AS DateTime), N'Avalara Commit Taxes')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'38b56c32-52e3-414d-bd70-de44facca865', N'ddfc85a3-97f6-4d53-9e26-0f34518ef207', 5, N'2d38fbd9-d308-4a9e-94bc-bdbeec165759', N'Apply Handling', CAST(N'2006-08-28 17:20:29.000' AS DateTime), N'Apply Handling')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'4d0e483b-f6a5-4ec6-a9a7-2ef23b93e1b5', N'11dc88f5-43f2-44bb-bb86-1141d6aee495', 1, N'e5a9b457-554e-4d31-9c0d-d01d5e0799a3', N'Send RMA Email', CAST(N'2007-02-27 13:20:01.000' AS DateTime), N'Send RMA Email')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'526b7b29-6b89-4c33-af43-bfe166ad493f', N'eac003c6-a354-489f-ba2c-029f4311851a', 9, N'37e0b27e-567f-4ee3-95ec-c7e5a66bfb26', N'Receive Paypal Express Payments', CAST(N'2015-02-10 11:15:11.590' AS DateTime), N'Receive Paypal Express Payments')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'52ab4076-a977-4785-bbe2-55e6624a47e9', N'eac003c6-a354-489f-ba2c-029f4311851a', 2, N'8F2BB6B4-2FEF-406d-A62D-075CD74D2551', N'Make Placed Order', CAST(N'2006-05-23 11:33:40.000' AS DateTime), N'')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'547cfe07-6462-42bb-b916-75231cfd8bd7', N'eac003c6-a354-489f-ba2c-029f4311851a', 16, N'30B9B11C-1621-4779-ABC2-FEC5D280484B', N'Update Order', CAST(N'2006-11-15 15:14:23.000' AS DateTime), N'Update Order')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'552b2fab-15d3-4139-abe5-f83e9d4dba28', N'c84658fb-fc72-458a-b0e6-c1708d9e84f2', 3, N'995E482F-8BDC-47E2-926F-D7248553035F', N'Run All Dropship Notifications', CAST(N'2006-08-25 16:25:57.000' AS DateTime), N'Run All Dropship Notifications')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'556982e2-aa14-40b1-8ea1-13493d2152ae', N'ddfc85a3-97f6-4d53-9e26-0f34518ef207', 4, N'1a875c85-baff-46d3-930b-84653f086c6d', N'Apply Taxes', CAST(N'2006-08-10 12:18:20.000' AS DateTime), N'Apply Taxes')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'578c979b-d0c0-415b-9dd7-f35dcdd8015a', N'09739bec-8974-4c38-b026-f6ca8aed615d', 1, N'56597582-05d0-4b51-bd87-7426a9cf146f', N'Start Paypal Express Checkout', CAST(N'2006-11-13 10:17:37.000' AS DateTime), N'Start Paypal Express Checkout')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'5a2a9769-c2e6-4578-9cf7-8245b10775ce', N'ee046427-9da3-431f-92b8-5665ec20a59c', 1, N'103ec8c5-a7b3-45f0-a948-69f4f074568e', N'Avalara Resubmit Taxes', CAST(N'2013-08-27 22:13:31.000' AS DateTime), N'Avalara Resubmit Taxes')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'5a48228d-854e-4dac-9bf8-2af8daaaaa30', N'eac003c6-a354-489f-ba2c-029f4311851a', 8, N'da3c958a-8a58-43ca-8da3-8dd5a0cf244e', N'Debit Gift Certificates', CAST(N'2015-02-10 11:16:39.773' AS DateTime), N'Debit Gift Certificates')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'64881de7-5221-460e-a915-2a5a9c023025', N'242848e0-1e5a-4a85-be62-887a21fdf0f9', 2, N'a07ed476-3165-4842-a4bf-ab40c8054501', N'Apply Minimum Order Amount', CAST(N'2007-02-01 16:57:26.000' AS DateTime), N'Minimum Order')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'66533d0b-6b37-4bad-80d5-ef70866a4d68', N'eac003c6-a354-489f-ba2c-029f4311851a', 15, N'A3AC0B3C-FB69-477B-95AB-2DC54D33F693', N'Update List Items', CAST(N'2007-10-29 10:37:55.000' AS DateTime), N'Update List Items')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'6fbba3af-c4c9-4cf2-8718-ff550f5d5c9c', N'0bd9414e-00a0-414e-8eb7-61121358a609', 5, N'5ba90d63-ff6c-4ca4-8e34-7705ec3b2728', N'Run Shipping Complete Workflow If Needed', CAST(N'2006-11-07 10:32:21.000' AS DateTime), N'Run Shipping Complete Workflow If Needed')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'73c32d9a-9f2f-43e2-a717-64e2d89f7003', N'db14f186-4005-4726-9a37-d67c2dc284ec', 2, N'19e6e637-e651-488d-a54c-11bc249ef28f', N'Mark Completed When Order Is Shipped And Paid', CAST(N'2006-08-11 15:22:06.000' AS DateTime), N'Mark Completed When Order Is Shipped And Paid')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'73df7b5e-10cb-4cab-b664-97678cb1795c', N'268ff9dc-ae7f-4faf-9944-d1aa15e64852', 1, N'63c58f44-36dd-4866-bbae-af2681a5063e', N'Apply Shipping Discounts', CAST(N'2006-10-16 12:42:48.000' AS DateTime), N'Apply Shipping Discounts')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'76f6349d-c7ec-4881-8d0f-2fc3d54dd314', N'0bd9414e-00a0-414e-8eb7-61121358a609', 1, N'19e6e637-e651-488d-a54c-11bc249ef28f', N'Mark Completed When Order Is Shipped And Paid', CAST(N'2006-08-11 15:22:25.000' AS DateTime), N'Mark Completed When Order Is Shipped And Paid')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'7769babb-35f9-4489-ac23-e24407bb0771', N'c84658fb-fc72-458a-b0e6-c1708d9e84f2', 1, N'30B9B11C-1621-4779-ABC2-FEC5D280484B', N'Update Order', CAST(N'2006-06-15 15:08:37.000' AS DateTime), N'Update Order')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'7f96ccb5-8110-4296-95a5-afdf891219fe', N'ddfc85a3-97f6-4d53-9e26-0f34518ef207', 1, N'8e5cfc0a-7fe1-407d-9347-df885a1a4d5e', N'Apply Volume Pricing', CAST(N'2006-06-20 11:41:55.000' AS DateTime), N'Apply Volume Pricing')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'80d34afc-cd0c-4ab8-a48b-9d4e87717557', N'db14f186-4005-4726-9a37-d67c2dc284ec', 4, N'd10d9ffa-dda1-48ed-bfed-5a088cf685d7', N'Avalara Cancel Taxes When Payment Removed', CAST(N'2013-08-27 22:21:20.000' AS DateTime), N'Avalara Cancel Taxes When Payment Removed')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'884e362a-c505-496d-af3a-abb6f52e886d', N'8b95070d-ce9b-4b43-9905-0981fbedd5af', 4, N'e8d6719f-dbf9-4886-bc67-acb4a2719023', N'Apply Price Groups', CAST(N'2007-02-09 11:28:06.000' AS DateTime), N'Apply Price Groups')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'89593f4f-57f3-4802-93af-e2342aa20f80', N'db14f186-4005-4726-9a37-d67c2dc284ec', 1, N'6565A823-1591-4069-8005-2FEE50E4C9E9', N'Run Payment Complete Workflow if Paid', CAST(N'2006-06-15 15:17:40.000' AS DateTime), N'Run Workflow If Paid')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'8c2a7012-750b-49ab-9a38-70882d54c65b', N'db14f186-4005-4726-9a37-d67c2dc284ec', 6, N'BBB0800B-4ED6-4060-9FBA-1B8D7EEAA686', N'Update Loyalty Points', CAST(N'2013-08-26 08:29:33.000' AS DateTime), N'Update Loyalty Points')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'8e8ee9ed-7392-4eca-a781-becab3e430d2', N'eac003c6-a354-489f-ba2c-029f4311851a', 12, N'6565A823-1591-4069-8005-2FEE50E4C9E9', N'Run Payment Complete Workflow if Paid', CAST(N'2006-11-15 15:14:22.000' AS DateTime), N'Run Payment Complete Workflow if Paid')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'94f4a9d3-cabe-4388-93bf-48b8d659b9f6', N'db14f186-4005-4726-9a37-d67c2dc284ec', 5, N'30B9B11C-1621-4779-ABC2-FEC5D280484B', N'Update Order', CAST(N'2006-11-07 10:26:17.000' AS DateTime), N'')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'9aa450d1-bc94-44a3-8ec7-07b0a39acdc7', N'8b95070d-ce9b-4b43-9905-0981fbedd5af', 1, N'b238fec3-3b16-43b3-bba3-80db10a56ec1', N'Initialize Product Price', CAST(N'2007-02-26 13:11:27.000' AS DateTime), N'Initialize Product Price')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'a0f89fa2-b0ae-409f-bc5b-05bfca30565a', N'eac003c6-a354-489f-ba2c-029f4311851a', 3, N'71EC229F-F0EF-4a6e-9790-9E84DC8DCA09', N'Assign Order To User', CAST(N'2006-05-23 11:33:42.000' AS DateTime), N'')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'a652e5c1-397a-45db-a64b-dcb184ec65f5', N'eac003c6-a354-489f-ba2c-029f4311851a', 13, N'19e6e637-e651-488d-a54c-11bc249ef28f', N'Mark Completed When Order Is Shipped And Paid', CAST(N'2006-11-15 15:14:23.000' AS DateTime), N'Mark Completed When Order Is Shipped And Paid')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'ac0016a6-257b-4707-bbdb-dbe5c445336a', N'eac003c6-a354-489f-ba2c-029f4311851a', 5, N'7cf8a5b6-3999-41b0-b283-e8280d19f3bb', N'Make Order Address User''s Current Address', CAST(N'2006-08-29 12:11:20.000' AS DateTime), N'Make Order Address User''s Current Address')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'b20583b5-f4e6-4a78-ac5d-5f88847ff9c2', N'db14f186-4005-4726-9a37-d67c2dc284ec', 3, N'4aa03a0d-1d38-4f66-ad85-82edf715103b', N'Change Order Status When Payment Removed', CAST(N'2006-11-07 10:49:18.000' AS DateTime), N'Change Order To In Process')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'bcd9c278-c565-45da-96ea-eab5326b41bc', N'eac003c6-a354-489f-ba2c-029f4311851a', 10, N'253305A6-87A4-4bcc-AA98-8A082E2D8162', N'Receive Credit Cards', CAST(N'2015-02-10 11:15:05.550' AS DateTime), N'Auth or Charge Credit Cards if present')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'c67583fd-47a8-4623-bd27-b9e83472b258', N'eac003c6-a354-489f-ba2c-029f4311851a', 14, N'B1BAE947-3F33-473f-8AFE-F27A6B9625D3', N'Email Order', CAST(N'2006-11-15 15:14:16.000' AS DateTime), N'Send Email to Admin')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'cfec40f5-4d9c-468a-b2b5-1818bf1fbb4f', N'd139a636-04c7-41b9-adca-0533432735bc', 1, N'7817bfd9-1075-4bac-9189-3c76c3ec17a6', N'Email Shipping Info', CAST(N'2006-10-19 13:54:12.000' AS DateTime), N'Send Shipping Info To Customer')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'df7e4b06-f196-4458-a4f1-facfe9327efb', N'eac003c6-a354-489f-ba2c-029f4311851a', 7, N'EA43E26D-20A8-414F-B2C1-C4F4281822B6', N'Debit Loyalty Points', CAST(N'2015-02-10 11:15:56.147' AS DateTime), N'Debit Loyalty Points')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'e39b7e82-6a9b-4b8a-8d42-aca7bba78c1d', N'268ff9dc-ae7f-4faf-9944-d1aa15e64852', 2, N'f3f17478-4d43-43b1-8bcd-89a7eef243a5', N'Apply Product Shipping Modifiers', CAST(N'2007-03-14 10:02:52.000' AS DateTime), N'Apply Product Shipping Modifiers')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'e44f6938-72f1-48a0-93ef-b705aabc6dc0', N'8b95070d-ce9b-4b43-9905-0981fbedd5af', 3, N'c46dc629-aa29-4a28-bfc0-e8338f216e79', N'Apply Sales', CAST(N'2007-02-09 11:28:06.000' AS DateTime), N'Apply Sales')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'e86fd606-985f-494d-893a-b8ab8d31882f', N'eac003c6-a354-489f-ba2c-029f4311851a', 4, N'6E27D187-F367-40f8-8231-160B6E22AB86', N'Update Line Items for Save', CAST(N'2006-05-29 16:05:49.000' AS DateTime), N'')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'ea3dde83-d14a-4377-b802-dbf594a4ca67', N'ddfc85a3-97f6-4d53-9e26-0f34518ef207', 2, N'60de8f71-89ff-42fc-ac9c-3eda4b63c9f3', N'Apply Offers - Stacked Discounts', CAST(N'2006-06-20 11:41:55.000' AS DateTime), N'Apply Offers - Stacked Discounts')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'f5f2d478-6be1-411e-be31-87d043becb65', N'0bd9414e-00a0-414e-8eb7-61121358a609', 3, N'b5d9c29d-2761-439d-92a4-6ae35870ba5b', N'Change Order Status When Shipment Removed', CAST(N'2006-11-07 10:49:56.000' AS DateTime), N'Change Order Status When Shipment Removed')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'f75c911f-5cb2-43e3-8dfc-d54ddae2cbd3', N'cf1bc2b5-b371-4b57-80c5-f26fbce94064', 1, N'D6223036-D923-41A1-AFD3-9ACEC521DBC8', N'Send Drop Ship Notification', CAST(N'2006-06-15 10:03:42.000' AS DateTime), N'Send Drop Ship Notification')
INSERT [dbo].[bvc_WorkFlowStep] ([bvin], [WorkFlowBvin], [SortOrder], [ControlName], [DisplayName], [LastUpdated], [StepName]) VALUES (N'fd595437-6347-41ec-9a23-6ebed6f33ac8', N'eac003c6-a354-489f-ba2c-029f4311851a', 6, N'30B9B11C-1621-4779-ABC2-FEC5D280484B', N'Update Order', CAST(N'2006-08-29 12:11:20.000' AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[bvc_Audit] ON 

INSERT [dbo].[bvc_Audit] ([id], [TimeStampUtc], [SourceModule], [ShortName], [Description], [UserId], [UserIdText], [Severity]) VALUES (45, CAST(N'2015-02-10 16:57:57.293' AS DateTime), 3, N'Failed Login Attempt', N'User info@develisys.com failed to login to their account.', N'', N'', 0)
INSERT [dbo].[bvc_Audit] ([id], [TimeStampUtc], [SourceModule], [ShortName], [Description], [UserId], [UserIdText], [Severity]) VALUES (46, CAST(N'2015-02-10 16:57:57.377' AS DateTime), 0, N'Membership', N'Login Failed for User: develisys', N'', N'', 4)
INSERT [dbo].[bvc_Audit] ([id], [TimeStampUtc], [SourceModule], [ShortName], [Description], [UserId], [UserIdText], [Severity]) VALUES (47, CAST(N'2015-02-10 16:58:00.107' AS DateTime), 3, N'Successful Login', N'User info@develisys.com logged into the site.', N'', N'', 1)
SET IDENTITY_INSERT [dbo].[bvc_Audit] OFF
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'HtmlData', N'<!-- orbit -->
<div class="slideshow-wrapper">
<div class="preloader">&nbsp;</div>
<ul data-orbit="" data-options="container_class:orbit-container billboard;slide_number:false; stack_on_small:false; ">
<li><a href="#"><img src="http://placehold.it/1138x640" alt="" /></a></li>
<li><a href="#"><img src="http://placehold.it/1138x640" alt="" /></a></li>
<li><a href="#"><img src="http://placehold.it/1138x640" alt="" /></a></li>
</ul>
</div>
<!-- end orbit -->', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'PreTransformHtmlData', N'<!-- orbit -->
<div class="slideshow-wrapper">
<div class="preloader">&nbsp;</div>
<ul data-orbit="" data-options="container_class:orbit-container billboard;slide_number:false; stack_on_small:false; ">
<li><a href="#"><img src="http://placehold.it/1138x640" alt="" /></a></li>
<li><a href="#"><img src="http://placehold.it/1138x640" alt="" /></a></li>
<li><a href="#"><img src="http://placehold.it/1138x640" alt="" /></a></li>
</ul>
</div>
<!-- end orbit -->', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'RemoveWrappingDiv', N'1', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'007d6e08-1296-418a-b687-6dbbeb4341d8', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'022256cc-c09f-40b1-971c-f515b47361bc', N'FeedUrl', N'http://www.bvcommerce.com/remoteapi/1/news/latest.xml', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'022256cc-c09f-40b1-971c-f515b47361bc', N'MaxItems', N'5', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'022256cc-c09f-40b1-971c-f515b47361bc', N'ShowDescription', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'022256cc-c09f-40b1-971c-f515b47361bc', N'ShowTitle', N'1', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'Title', N'Quick Links', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'HtmlData', N'<h6>Service</h6>
<ul>
<li><a href="/ContactUs.aspx">Contact Us</a></li>
<li><a href="/FAQ.aspx">FAQs</a></li>
<li><a href="/ViewOrder.aspx">Order Status</a></li>
<li><a href="/AffiliateSignup.aspx">Affiliate Signup</a></li>
</ul>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'PreTransformHtmlData', N'<h6>Service</h6>
<ul>
<li><a href="/ContactUs.aspx">Contact Us</a></li>
<li><a href="/FAQ.aspx">FAQs</a></li>
<li><a href="/ViewOrder.aspx">Order Status</a></li>
<li><a href="/AffiliateSignup.aspx">Affiliate Signup</a></li>
</ul>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'RemoveWrappingDiv', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'069934df-aaf1-494c-a144-81d5bf3a25ef', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1446047e-90bb-428f-a0ad-24c416840883', N'Columns', N'25', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'HtmlData', N'<p class="smallText">&copy; 2014 BV Commerce. All Rights Reserved. | <a href="/sitemap.aspx">Sitemap</a> | <a href="/aboutus.aspx">About Us</a></p>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'PreTransformHtmlData', N'<p class="smallText">&copy; 2014 BV Commerce. All Rights Reserved. | <a href="/sitemap.aspx">Sitemap</a> | <a href="/aboutus.aspx">About Us</a></p>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'RemoveWrappingDiv', N'1', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1781505f-c2f6-4eac-8b6d-6fcb3b079623', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1983069f-e85f-41d1-8e37-be8b5e58a8e8', N'Columns', N'25', N'bvsoftware', N'Input', N'Text Input')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1f3a266e-6735-4255-b81c-30efd55cdb5e', N'CustomEmail', N'', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1f3a266e-6735-4255-b81c-30efd55cdb5e', N'EmailTemplate', N'fea0ec5c-4d34-45fa-aef2-c05aabfad854', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1f3a266e-6735-4255-b81c-30efd55cdb5e', N'StepName', N'Send Email to Customer', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'1f3a266e-6735-4255-b81c-30efd55cdb5e', N'ToEmail', N'Customer', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2013ee18-3be5-4a13-b80d-d06bd2dd2bd1', N'packaging', N'7', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'AssignUniqueCssClassNames', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'CssClass', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'CurrentCategoryID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'DefaultExpandedDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'DepthLevels', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'DisplayOnlyActiveBranch', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'DisplayOnlyChildrenOfCurrentCategory', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'DisplayTopLevelAsHeadings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'HeadingTag', N'span', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'HtmlID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'MoreLinkText', N'more', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'ShowMoreLink', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'ShowProductCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'ShowSubCategoryCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'StartDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'2592603b-b453-4192-b3e4-a907eac235f2', N'UseShowInTopMenuSettings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'274d2112-ebb3-425c-882b-2c1afacb2e30', N'packaging', N'7', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'AssignUniqueCssClassNames', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'CssClass', N'side-nav simple', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'CurrentCategoryID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'DefaultExpandedDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'DepthLevels', N'9999', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'DisplayOnlyActiveBranch', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'DisplayOnlyChildrenOfCurrentCategory', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'DisplayTopLevelAsHeadings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'HeadingTag', N'span', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'HtmlID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'MoreLinkText', N'more', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'ShowMoreLink', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'ShowProductCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'ShowSubCategoryCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'StartDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'31d523ed-759a-4858-8037-e660f51b3e6a', N'UseShowInTopMenuSettings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3213a5a2-c00e-4a0c-809d-b3a3cf8c4636', N'Columns', N'20', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'32dd7f28-423a-4f7c-bcc8-9657b5d3aeee', N'packaging', N'7', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'35bf737f-40b2-4c0f-8f3b-1225fcca6559', N'ItemsPerPage', N'12', N'bvsoftware', N'Category Template', N'Grid')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'35bf737f-40b2-4c0f-8f3b-1225fcca6559', N'PagerMode', N'2', N'bvsoftware', N'Category Template', N'Grid')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3c9e9534-bda9-420b-9c38-be15271b6a3b', N'packaging', N'7', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3e17dd23-f2f0-4f0b-869f-df7761505874', N'HtmlData', N'<div class="sidemenu">
<div class="decoratedblock">
<ul>
<li>
<a href="#" onclick="JavaScript:window.open(''GettingStartedChecklist.aspx'',''GettingStarted'',''width=500, height=400, menubar=no, scrollbars=yes, resizable=yes, status=no, toolbar=no'')">
Getting Started Checklist
</a>
</li>
</ul>
</div>
</div>', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3e20a49f-6cd4-4130-bbaa-1c4aea8e9437', N'ErrorMessage', N'Please enter a valid email address', N'bvsoftware', N'Content Block', N'Mailing List Signup')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3e20a49f-6cd4-4130-bbaa-1c4aea8e9437', N'Instructions', N'Please enter your email address', N'bvsoftware', N'Content Block', N'Mailing List Signup')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3e20a49f-6cd4-4130-bbaa-1c4aea8e9437', N'MailingListId', N'8858e25b-d9a0-4ae7-b74b-bdecd0c77a8d', N'bvsoftware', N'Content Block', N'Mailing List Signup')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3e20a49f-6cd4-4130-bbaa-1c4aea8e9437', N'SuccessMessage', N'Thank You!', N'bvsoftware', N'Content Block', N'Mailing List Signup')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'3e20a49f-6cd4-4130-bbaa-1c4aea8e9437', N'Title', N'Mailing List', N'bvsoftware', N'Content Block', N'Mailing List Signup')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'41533adf-d89d-491e-ab7f-160fca462cf4', N'Columns', N'20', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'428ad293-a9d9-400a-b2ba-e8df676e34e3', N'ShippingMethod', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'46a1b47f-a11b-40e5-a18a-61c7e2820daa', N'packaging', N'7', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'49a03fa0-c3f6-4e55-ad58-8ac2332c5197', N'Columns', N'5', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'HtmlData', N'<h6>Store</h6>', N'bvsoftware', N'Content Block', N'HTML')
GO
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'PreTransformHtmlData', N'<h6>Store</h6>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'RemoveWrappingDiv', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'4f6d77f4-cd23-4d63-9d19-b3bca8023b15', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'526b7b29-6b89-4c33-af43-bfe166ad493f', N'CustomerErrorMessage', N'An error occurred while attempting to process your PayPal payment. Please check your payment information and try again.', N'bvsoftware', N'Order Tasks', N'Receive Paypal Express Pa')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'526b7b29-6b89-4c33-af43-bfe166ad493f', N'FailStatusCode', N'88B5B4BE-CA7B-41a9-9242-D96ED3CA3135', N'bvsoftware', N'Order Tasks', N'Receive Paypal Express Pa')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'526b7b29-6b89-4c33-af43-bfe166ad493f', N'SetStatusOnFail', N'1', N'bvsoftware', N'Order Tasks', N'Receive Paypal Express Pa')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'526b7b29-6b89-4c33-af43-bfe166ad493f', N'StepName', N'Receive Paypal Express Payments', N'bvsoftware', N'Order Tasks', N'Receive Paypal Express Pa')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'526b7b29-6b89-4c33-af43-bfe166ad493f', N'ThrowErrors', N'1', N'bvsoftware', N'Order Tasks', N'Receive Paypal Express Pa')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'57262FBB-F4AB-4bea-AC54-CF38BDC8E83B', N'diagnostics', N'0', N'bvsoftware', N'Shipping Method', N'USPS')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'5a48228d-854e-4dac-9bf8-2af8daaaaa30', N'CustomerErrorMessage', N'An error occurred while attempting to process your gift certificate. Please check your payment information and try again.', N'bvsoftware', N'Order Tasks', N'Debit Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'5a48228d-854e-4dac-9bf8-2af8daaaaa30', N'FailStatusCode', N'88B5B4BE-CA7B-41a9-9242-D96ED3CA3135', N'bvsoftware', N'Order Tasks', N'Debit Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'5a48228d-854e-4dac-9bf8-2af8daaaaa30', N'SetStatusOnFail', N'1', N'bvsoftware', N'Order Tasks', N'Debit Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'5a48228d-854e-4dac-9bf8-2af8daaaaa30', N'StepName', N'Debit Gift Certificates', N'bvsoftware', N'Order Tasks', N'Debit Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'5a48228d-854e-4dac-9bf8-2af8daaaaa30', N'ThrowErrors', N'0', N'bvsoftware', N'Order Tasks', N'Debit Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'5b1bbe5b-f8ea-4f15-a66a-dbe6cc0d08a3', N'Columns', N'30', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'6E44EA47-AB0E-40cc-8692-C699349F0B7A', N'AuthorizeFails', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'6E44EA47-AB0E-40cc-8692-C699349F0B7A', N'CaptureFails', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'6E44EA47-AB0E-40cc-8692-C699349F0B7A', N'ChargeFails', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'6E44EA47-AB0E-40cc-8692-C699349F0B7A', N'RefundFails', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'6E44EA47-AB0E-40cc-8692-C699349F0B7A', N'VoidFails', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'728833c3-506e-49de-879e-d253d7d7d071', N'Columns', N'30', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'HtmlData', N'<p><img src="/images/system/creditcards/visa.png" alt="Visa" /> <img src="/images/system/creditcards/mastercard.png" alt="MasterCard" /> <img src="/images/system/creditcards/amex.png" alt="American Express" /> <img src="/images/system/creditcards/discover.png" alt="Discover" /></p>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'PreTransformHtmlData', N'<p><img src="/images/system/creditcards/visa.png" alt="Visa" /> <img src="/images/system/creditcards/mastercard.png" alt="MasterCard" /> <img src="/images/system/creditcards/amex.png" alt="American Express" /> <img src="/images/system/creditcards/discover.png" alt="Discover" /></p>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'RemoveWrappingDiv', N'1', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'75f32563-21c0-4d17-81b0-076fc98b997f', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'762a4ef0-980d-41cb-8a5a-a83338f07cf3', N'ItemsPerPage', N'10', N'bvsoftware', N'Category Template', N'Simple List')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'762a4ef0-980d-41cb-8a5a-a83338f07cf3', N'PagerMode', N'2', N'bvsoftware', N'Category Template', N'Simple List')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'7912deec-5266-4da9-a79e-282100e90621', N'ItemsPerPage', N'10', N'bvsoftware', N'Category Template', N'Detailed List')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'7912deec-5266-4da9-a79e-282100e90621', N'PagerMode', N'2', N'bvsoftware', N'Category Template', N'Detailed List')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'7ad784bf-a813-4155-96a1-33da09dcadd6', N'Columns', N'35', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'7c4b061a-27b0-476f-bc2b-c8c243802881', N'Levels', N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfShippingMethodLevel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <ShippingMethodLevel>
    <Bvin>bec435e1-9cb1-4124-8744-2834df2a5c4a</Bvin>
    <Level>0</Level>
    <Amount>1.00</Amount>
  </ShippingMethodLevel>
</ArrayOfShippingMethodLevel>', N'bvsoftware', N'Shipping Method', N'By Item Count')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'7c4b061a-27b0-476f-bc2b-c8c243802881', N'Name', N'By Item Count', N'bvsoftware', N'Shipping Method', N'By Item Count')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'HtmlData', N'<div class="row ads">
<div class="large-4 columns"><a title="Category 1" href="/Departments/Category-1.aspx"><img src="http://placehold.it/359x200" alt="Category 1" /></a></div>
<div class="large-4 columns"><a title="Category 2" href="/Departments/Category-2.aspx"><img src="http://placehold.it/359x200" alt=" Category 2" /></a></div>
<div class="large-4 columns"><a title="Category 3" href="/Departments/Category-3.aspx"><img src="http://placehold.it/359x200" alt="Category 3" /></a></div>
</div>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'PreTransformHtmlData', N'<div class="row ads">
<div class="large-4 columns"><a title="Category 1" href="/Departments/Category-1.aspx"><img src="http://placehold.it/359x200" alt="Category 1" /></a></div>
<div class="large-4 columns"><a title="Category 2" href="/Departments/Category-2.aspx"><img src="http://placehold.it/359x200" alt=" Category 2" /></a></div>
<div class="large-4 columns"><a title="Category 3" href="/Departments/Category-3.aspx"><img src="http://placehold.it/359x200" alt="Category 3" /></a></div>
</div>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'RemoveWrappingDiv', N'1', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8433bf09-a145-420b-b73e-d1b8476ed4f6', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'84967644-2311-44f3-883b-6a52473e2ac1', N'ShippingMethod', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'894B69ED-1A11-4894-B942-D5186655DB19', N'LiveUrl', N'https://secure.authorize.net/gateway/transact.dll', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'894B69ED-1A11-4894-B942-D5186655DB19', N'Password', N'ThisIsMyPassword', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'894B69ED-1A11-4894-B942-D5186655DB19', N'TestMode', N'1', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'894B69ED-1A11-4894-B942-D5186655DB19', N'TestUrl', N'https://secure.authorize.net/gateway/transact.dll', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'894B69ED-1A11-4894-B942-D5186655DB19', N'Username', N'MyUsername', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'89bc2e73-e28e-4540-846c-c641e2b25f06', N'Columns', N'20', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'AccountInstructions_HtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'AccountInstructions_PreTransformHtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'BillingInstructions_HtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'BillingInstructions_PreTransformHtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'EnableAccountCreation', N'1', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'EnableMailingListSignup', N'1', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'EnablePromotionalCodeEntry', N'0', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'GiftCertificateInstructions_HtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'GiftCertificateInstructions_PreTransformHtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'MailingList', N'8858e25b-d9a0-4ae7-b74b-bdecd0c77a8d', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'PaymentInstructions_HtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'PaymentInstructions_PreTransformHtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'PromotionalCodeInstructions_HtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'PromotionalCodeInstructions_PreTransformHtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'PromptForLogin', N'1', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'RequireAccountCreation', N'0', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'ReviewInstructions_HtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'ReviewInstructions_PreTransformHtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'ShippingInstructions_HtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'8A0D9FD7-2C4F-43B4-B604-2C73EA9C4CE0', N'ShippingInstructions_PreTransformHtmlData', N'', N'Develisys', N'Checkout', N'One Page Checkout Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'AssignUniqueCssClassNames', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'CssClass', N'side-nav fancy', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'CurrentCategoryID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'DefaultExpandedDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'DepthLevels', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'DisplayOnlyActiveBranch', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'DisplayOnlyChildrenOfCurrentCategory', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'DisplayTopLevelAsHeadings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'HeadingTag', N'span', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'HtmlID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'MoreLinkText', N'more', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'ShowMoreLink', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'ShowProductCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'ShowSubCategoryCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'StartDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'995c51c7-2c43-4a75-a799-dafbd6418426', N'UseShowInTopMenuSettings', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
GO
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'9FD35C50-CDCB-42ac-9549-14119BECBD0C', N'Instructions', N'Call us toll free at 800-xxx-xxxx to arrange payment for this order. Please have your order number ready when you call.', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'a63d69ef-0e74-4f25-b7cd-becbf0690ecb', N'Columns', N'30', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'HtmlData', N'<p><a class="webicon facebook" href="https://www.facebook.com/bvcommerce">Facebook</a> <a class="webicon twitter" href="https://twitter.com/bvcommerce">Twitter</a> <a class="webicon pinterest" href="https://www.pinterest.com/">Pinterest</a> <a class="webicon youtube" href="https://www.youtube.com/">YouTube</a></p>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'PreTransformHtmlData', N'<p><a class="webicon facebook" href="https://www.facebook.com/bvcommerce">Facebook</a> <a class="webicon twitter" href="https://twitter.com/bvcommerce">Twitter</a> <a class="webicon pinterest" href="https://www.pinterest.com/">Pinterest</a> <a class="webicon youtube" href="https://www.youtube.com/">YouTube</a></p>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'RemoveWrappingDiv', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ac00b095-7cb1-4049-a8d4-f9ecc69d4801', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'AssignUniqueCssClassNames', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'CssClass', N'side-nav fancy', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'CurrentCategoryID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'DefaultExpandedDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'DepthLevels', N'9999', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'DisplayOnlyActiveBranch', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'DisplayOnlyChildrenOfCurrentCategory', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'DisplayTopLevelAsHeadings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'HeadingTag', N'span', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'HtmlID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'MoreLinkText', N'more', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'ShowMoreLink', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'ShowProductCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'ShowSubCategoryCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'StartDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ad34c493-1760-4c06-9955-078388d75b85', N'UseShowInTopMenuSettings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'AssignUniqueCssClassNames', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'CssClass', N'side-nav simple', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'CurrentCategoryID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'DefaultExpandedDepth', N'2', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'DepthLevels', N'9999', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'DisplayOnlyActiveBranch', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'DisplayOnlyChildrenOfCurrentCategory', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'DisplayTopLevelAsHeadings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'HeadingTag', N'span', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'HtmlID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'MoreLinkText', N'more', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'ShowMoreLink', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'ShowProductCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'ShowSubCategoryCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'StartDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b2e5c99f-b590-4ccd-a01f-14fb57443a44', N'UseShowInTopMenuSettings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b37c2726-b7d4-4b93-be69-91d3a3c0ff16', N'packaging', N'7', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b58ed67f-5c5b-4f9f-a247-0ecb2aaffd02', N'packaging', N'7', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b7111a9c-5487-4c52-9be2-3b71c05021c9', N'Columns', N'10', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b8610e46-3c26-4884-9343-befd1d62a96c', N'ItemsPerPage', N'16', N'bvsoftware', N'Category Template', N'Grid')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b8610e46-3c26-4884-9343-befd1d62a96c', N'PagerMode', N'0', N'bvsoftware', N'Category Template', N'Grid')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'b9f03450-eb38-490f-a114-328d909c3002', N'Columns', N'30', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'bcd9c278-c565-45da-96ea-eab5326b41bc', N'CustomerErrorMessage', N'An error occurred while attempting to process your credit card. Please check your payment information and try again.', N'bvsoftware', N'Order Tasks', N'Receive Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'bcd9c278-c565-45da-96ea-eab5326b41bc', N'FailStatusCode', N'88B5B4BE-CA7B-41a9-9242-D96ED3CA3135', N'bvsoftware', N'Order Tasks', N'Receive Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'bcd9c278-c565-45da-96ea-eab5326b41bc', N'SetStatusOnFail', N'1', N'bvsoftware', N'Order Tasks', N'Receive Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'bcd9c278-c565-45da-96ea-eab5326b41bc', N'StepName', N'Auth or Charge Credit Cards if present', N'bvsoftware', N'Order Tasks', N'Receive Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'bcd9c278-c565-45da-96ea-eab5326b41bc', N'ThrowErrors', N'1', N'bvsoftware', N'Order Tasks', N'Receive Credit Cards')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'bddbeb64-67f6-48dd-aa78-7a93f3674726', N'ShippingMethod', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'c3389626-8b44-4a46-a593-af077be62308', N'Columns', N'12', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'c37951e3-5294-4a44-8b49-431d235309e7', N'ShippingMethod', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'c67583fd-47a8-4623-bd27-b9e83472b258', N'CustomEmail', N'admin@bvcommerce.com', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'c67583fd-47a8-4623-bd27-b9e83472b258', N'EmailTemplate', N'ff59ce07-6a05-4142-83ad-53b8e00c04b5', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'c67583fd-47a8-4623-bd27-b9e83472b258', N'StepName', N'Send Email to Admin', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'c67583fd-47a8-4623-bd27-b9e83472b258', N'ToEmail', N'Admin', N'bvsoftware', N'Order Tasks', N'Email Order')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ce60796a-ce3a-45f8-ba87-a1fb637a9a57', N'Columns', N'25', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'd274ab7d-1a90-4e3c-81e8-4b52bdc49930', N'Title', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'D2D63F6A-2480-42a1-A593-FCFA83A2C8B8', N'ItemsPerPage', N'12', N'bvsoftware', N'Category Template', N'Grid')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'D2D63F6A-2480-42a1-A593-FCFA83A2C8B8', N'PagerMode', N'2', N'bvsoftware', N'Category Template', N'Grid')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'df7e4b06-f196-4458-a4f1-facfe9327efb', N'CustomerErrorMessage', N'An error occured while attempting to debit your loyalty points. Please contact customer service.', N'Develisys', N'Order Tasks', N'Charge Loyalty Points')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'df7e4b06-f196-4458-a4f1-facfe9327efb', N'FailStatusCode', N'88B5B4BE-CA7B-41a9-9242-D96ED3CA3135', N'Develisys', N'Order Tasks', N'Charge Loyalty Points')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'df7e4b06-f196-4458-a4f1-facfe9327efb', N'SetStatusOnFail', N'1', N'Develisys', N'Order Tasks', N'Charge Loyalty Points')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'df7e4b06-f196-4458-a4f1-facfe9327efb', N'StepName', N'Debit Loyalty Points', N'Develisys', N'Order Tasks', N'Charge Loyalty Points')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'df7e4b06-f196-4458-a4f1-facfe9327efb', N'ThrowErrors', N'0', N'Develisys', N'Order Tasks', N'Charge Loyalty Points')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e208f554-e0e5-44bd-b405-249e12039a5b', N'Columns', N'30', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'E43F909F-219A-46fa-BA61-95B63A5B2658', N'UpsRatesResidential', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'AssignUniqueCssClassNames', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'CssClass', N'left', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'CurrentCategoryID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'DefaultExpandedDepth', N'2', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'DepthLevels', N'3', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'DisplayOnlyActiveBranch', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'DisplayOnlyChildrenOfCurrentCategory', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'DisplayTopLevelAsHeadings', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'HeadingTag', N'span', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'HtmlID', N'', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'MoreLinkText', N'more', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'ShowMoreLink', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'ShowProductCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'ShowSubCategoryCount', N'0', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'StartDepth', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'e7d20f94-e83a-46b3-b61c-ea1a1af3d6ae', N'UseShowInTopMenuSettings', N'1', N'bvsoftware', N'Content Block', N'Category Menu Plus')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'DisplayTypeRad', N'0', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'GridColumnsField', N'2', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'OtherStatusBvin', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'PostHtml', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'PreHtml', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'Status', N'Payment', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'ebc5be87-eaa1-4ac2-9c3f-972107167994', N'Value', N'Unpaid', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f05b9f84-6e5a-4d9f-879a-f5f435daf9e1', N'ShippingMethod', N'', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'EnableReplacementTags', N'0', N'bvsoftware', N'Content Block', N'HTML')
GO
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'EnableScheduledContent', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'EndDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'HtmlData', N'<h6>Policies</h6>
<ul>
<li><a href="/Privacy.aspx">Privacy Policy</a></li>
<li><a href="/ReturnForm.aspx">Return Policy</a></li>
<li><a href="/shippingterms.aspx">Shipping Policy</a></li>
<li><a href="/Terms.aspx">Terms &amp; Conditions</a></li>
</ul>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'PreTransformHtmlData', N'<h6>Policies</h6>
<ul>
<li><a href="/Privacy.aspx">Privacy Policy</a></li>
<li><a href="/ReturnForm.aspx">Return Policy</a></li>
<li><a href="/shippingterms.aspx">Shipping Policy</a></li>
<li><a href="/Terms.aspx">Terms &amp; Conditions</a></li>
</ul>', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'PreTransformScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'QueryStringName', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'QueryStringValue', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'RemoveWrappingDiv', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'ScheduledHtmlData', N'', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'ShowHideByQueryString', N'0', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'f785c1f0-38c9-4f6e-98ed-20fb28b70eb0', N'StartDateTime', N'635590368000000000', N'bvsoftware', N'Content Block', N'HTML')
INSERT [dbo].[bvc_ComponentSetting] ([ComponentID], [SettingName], [SettingValue], [DeveloperId], [ComponentType], [ComponentSubType]) VALUES (N'feb7a5a2-fcf2-47bb-a2fd-c40c18300b2a', N'Columns', N'20', N'', N'', N'')
INSERT [dbo].[bvc_ComponentSettingList] ([bvin], [SortOrder], [ComponentID], [DeveloperId], [ComponentType], [ComponentSubType], [ListName], [Setting1], [Setting2], [Setting3], [Setting4], [Setting5], [Setting6], [Setting7], [Setting8], [Setting9], [Setting10], [LastUpdated]) VALUES (N'056dfe42-9b7f-45e0-bd4a-392780260fac', 3, N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'', N'', N'', N'Links', N'Manage Orders', N'~/BVAdmin/Orders/Default.aspx', N'0', N'Manage Orders', N'', N'', N'', N'', N'', N'', CAST(N'2006-08-29 14:58:42.000' AS DateTime))
INSERT [dbo].[bvc_ComponentSettingList] ([bvin], [SortOrder], [ComponentID], [DeveloperId], [ComponentType], [ComponentSubType], [ListName], [Setting1], [Setting2], [Setting3], [Setting4], [Setting5], [Setting6], [Setting7], [Setting8], [Setting9], [Setting10], [LastUpdated]) VALUES (N'110c3c58-c1aa-4468-8076-7cbcbcc09fe0', 1, N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'', N'', N'', N'Links', N'Edit Categories', N'~/BVAdmin/Catalog/Categories.aspx', N'0', N'Edit Categories', N'', N'', N'', N'', N'', N'', CAST(N'2006-08-29 14:58:42.000' AS DateTime))
INSERT [dbo].[bvc_ComponentSettingList] ([bvin], [SortOrder], [ComponentID], [DeveloperId], [ComponentType], [ComponentSubType], [ListName], [Setting1], [Setting2], [Setting3], [Setting4], [Setting5], [Setting6], [Setting7], [Setting8], [Setting9], [Setting10], [LastUpdated]) VALUES (N'2c8ecc22-d954-4d9b-9475-ba58fb8a37d1', 6, N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'', N'', N'', N'Links', N'Create Discounts', N'~/BVAdmin/Marketing/Default.aspx', N'0', N'Create Discounts', N'', N'', N'', N'', N'', N'', CAST(N'2006-08-29 14:58:42.000' AS DateTime))
INSERT [dbo].[bvc_ComponentSettingList] ([bvin], [SortOrder], [ComponentID], [DeveloperId], [ComponentType], [ComponentSubType], [ListName], [Setting1], [Setting2], [Setting3], [Setting4], [Setting5], [Setting6], [Setting7], [Setting8], [Setting9], [Setting10], [LastUpdated]) VALUES (N'8292b424-f78c-4968-bb7f-280a48aac28b', 4, N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'', N'', N'', N'Links', N'View Reports', N'~/BVAdmin/Reports/Default.aspx', N'0', N'View Reports', N'', N'', N'', N'', N'', N'', CAST(N'2006-08-29 14:58:42.000' AS DateTime))
INSERT [dbo].[bvc_ComponentSettingList] ([bvin], [SortOrder], [ComponentID], [DeveloperId], [ComponentType], [ComponentSubType], [ListName], [Setting1], [Setting2], [Setting3], [Setting4], [Setting5], [Setting6], [Setting7], [Setting8], [Setting9], [Setting10], [LastUpdated]) VALUES (N'993ae16e-9735-409c-99c8-12200383f431', 2, N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'', N'', N'', N'Links', N'Edit Products', N'~/BVAdmin/Catalog/Default.aspx', N'0', N'Edit Products', N'', N'', N'', N'', N'', N'', CAST(N'2006-08-29 14:58:42.000' AS DateTime))
INSERT [dbo].[bvc_ComponentSettingList] ([bvin], [SortOrder], [ComponentID], [DeveloperId], [ComponentType], [ComponentSubType], [ListName], [Setting1], [Setting2], [Setting3], [Setting4], [Setting5], [Setting6], [Setting7], [Setting8], [Setting9], [Setting10], [LastUpdated]) VALUES (N'ad8a228c-c0f7-4998-be3a-84af9aaf6b3a', 1, N'd274ab7d-1a90-4e3c-81e8-4b52bdc49930', N'', N'', N'', N'Links', N'Add a Custom Page', N'~/BVadmin/Content/CustomPages.aspx', N'0', N'Add a Custom Page', N'', N'', N'', N'', N'', N'', CAST(N'2006-08-29 14:58:43.000' AS DateTime))
INSERT [dbo].[bvc_ComponentSettingList] ([bvin], [SortOrder], [ComponentID], [DeveloperId], [ComponentType], [ComponentSubType], [ListName], [Setting1], [Setting2], [Setting3], [Setting4], [Setting5], [Setting6], [Setting7], [Setting8], [Setting9], [Setting10], [LastUpdated]) VALUES (N'c952d921-752a-4d7a-b5d3-1806e3607c10', 5, N'0584f9bb-e47c-4a9c-8404-dbf145cec903', N'', N'', N'', N'Links', N'Create Sales', N'~/BVAdmin/Marketing/Sales.aspx', N'0', N'Create Sales', N'', N'', N'', N'', N'', N'', CAST(N'2006-08-29 14:58:42.000' AS DateTime))
INSERT [dbo].[bvc_ContactUsQuestions] ([bvin], [QuestionName], [QuestionType], [Values], [Order], [LastUpdated]) VALUES (N'3294113b-6a66-42a1-af61-28ca6c0655f7', N'Name', 0, N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfContactUsQuestionOption xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <ContactUsQuestionOption>
    <Bvin />
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>Name</Value>
  </ContactUsQuestionOption>
</ArrayOfContactUsQuestionOption>', 3, CAST(N'2015-02-10 11:10:56.957' AS DateTime))
INSERT [dbo].[bvc_ContactUsQuestions] ([bvin], [QuestionName], [QuestionType], [Values], [Order], [LastUpdated]) VALUES (N'767945e6-93e6-4d76-9d37-5d2ab46a2890', N'Message', 2, N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfContactUsQuestionOption xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <ContactUsQuestionOption>
    <Bvin />
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>Question/Comment</Value>
  </ContactUsQuestionOption>
</ArrayOfContactUsQuestionOption>', 2, CAST(N'2015-02-10 11:10:38.200' AS DateTime))
INSERT [dbo].[bvc_ContactUsQuestions] ([bvin], [QuestionName], [QuestionType], [Values], [Order], [LastUpdated]) VALUES (N'd48174a5-7142-4121-b699-d2b44c84b383', N'Subject', 1, N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfContactUsQuestionOption xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <ContactUsQuestionOption>
    <Bvin>e5c94e85-6c9b-42a8-bf8d-403746801067</Bvin>
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>A Product</Value>
  </ContactUsQuestionOption>
  <ContactUsQuestionOption>
    <Bvin>3f7d3fba-13c8-4c8c-bc9f-2ccda41eca19</Bvin>
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>My Order</Value>
  </ContactUsQuestionOption>
  <ContactUsQuestionOption>
    <Bvin>eb0defa7-a761-4c9f-b05e-1f9b6bb63a78</Bvin>
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>Suggestion</Value>
  </ContactUsQuestionOption>
  <ContactUsQuestionOption>
    <Bvin>e4e931ba-f47a-46a0-962a-0dfc782c2eb3</Bvin>
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>Something Else</Value>
  </ContactUsQuestionOption>
  <ContactUsQuestionOption>
    <Bvin />
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>I have a question or comment about</Value>
  </ContactUsQuestionOption>
</ArrayOfContactUsQuestionOption>', 1, CAST(N'2015-02-10 11:10:10.347' AS DateTime))
INSERT [dbo].[bvc_ContactUsQuestions] ([bvin], [QuestionName], [QuestionType], [Values], [Order], [LastUpdated]) VALUES (N'f2784e16-1834-4d03-aa71-fe4b3f11bdec', N'Email', 0, N'<?xml version="1.0" encoding="utf-16"?>
<ArrayOfContactUsQuestionOption xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
  <ContactUsQuestionOption>
    <Bvin />
    <LastUpdated>0001-01-01T00:00:00</LastUpdated>
    <Value>Email Address</Value>
  </ContactUsQuestionOption>
</ArrayOfContactUsQuestionOption>', 4, CAST(N'2015-02-10 11:11:17.700' AS DateTime))
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'A', N'Amex', 1)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'C', N'Diners Club', 0)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'D', N'Discover', 1)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'J', N'JCB', 0)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'M', N'MasterCard', 1)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'MAESTRO', N'Maestro / Switch', 0)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'SOLO', N'Solo', 0)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'STAR', N'Star Card', 0)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'SWITCH', N'Switch', 0)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'V', N'Visa', 1)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'VISADELTA', N'Visa Delta', 0)
INSERT [dbo].[bvc_CreditCardType] ([Code], [LongName], [Active]) VALUES (N'VISAELECTRON', N'Visa Electron', 0)
INSERT [dbo].[bvc_CustomPage] ([bvin], [Name], [Content], [MenuName], [ShowInTopMenu], [ShowInBottomMenu], [LastUpdated], [PreTransformContent], [MetaDescription], [MetaKeywords], [MetaTitle], [TemplateName], [PreContentColumnId], [PostContentColumnId]) VALUES (N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', N'About Us', N'<p>About Us page content goes here...</p>', N'About Us', 0, 1, CAST(N'2015-02-09 21:51:27.837' AS DateTime), N'<p>About Us page content goes here...</p>', N'', N'', N'', N'', N' - None -', N' - None -')
INSERT [dbo].[bvc_CustomUrl] ([bvin], [RequestedUrl], [RedirectToUrl], [SystemUrl], [SystemData], [LastUpdated]) VALUES (N'8189e56e-bdc3-4e0f-bb02-3c370f9fb01c', N'/AboutUs.aspx', N'/Custom.aspx?id=68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', 1, N'68f93a7d-44b2-44ef-9c0b-bcf22f28c7d1', CAST(N'2015-02-09 21:51:27.867' AS DateTime))
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'0e1331d9-c323-464a-937e-41f749aa9fab', N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
        .packageitems { border-collapse: collapse; }
        .itemnamehead { background-color: #999999; }
        .itemquantityhead { background-color: #999999; }
        .alt .itemname { background-color: #aaaaaa; }
        .alt .itemquantity { background-color: #aaaaaa; }
        .itemname { background-color: #ffffff; }
        .itemquantity { background-color: #ffffff; text-align: right; border-left: solid 1px #aaaaaa; }
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>	
	<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		[[Order.BillingAddress]]<br>
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Payment Method:</b> [[Order.PaymentMethod]]&nbsp;<br>
			<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>			
		</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
                                <td><b>Shipper</b></td>
				<td><b>Shipping Method</b></td>
				<td><b>Tracking Number</b></td>
				<td><b>Ship Date</b></td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<table border="0" cellspacing="0" cellpadding="3">
					        <TR>
							<TD vAlign=top align=left>SubTotal:</TD>
							<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
                                                <TR>
							<TD vAlign=top align=left>Discounts:</TD>
							<TD vAlign=top align=right>[[Order.OrderDiscounts]] </TD></TR>

						<TR>
							<TD  vAlign=top align=left>Tax: </TD>
							<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Shipping:</TD>
							<TD  vAlign=top align=right>[[Order.ShippingTotalMinusDiscounts]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Handling: </TD>
							<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
							<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
						</TR>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
		</table>			
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'', N'Shipping Update Template', N'admin@bvcommerce.com', N'<tr>
  <td align=left valign=top>[[Package.ShipperName]]</td>
  <td align=left valign=top>[[Package.ShipperService]]</td>
  <td align=left valign=top><a href="[[Package.TrackingNumberLink]]">[[Package.TrackingNumber]]</a></td>    
  <td align=left valign=top>[[Package.ShipDate]]</td>
</tr>
<tr>
  <td></td>
  <td colspan="3" align=left valign=top>[[Package.Items]]</td>
</tr>', N'', 0, N'Shipping update for order [[Order.OrderNumber]]', CAST(N'2007-01-22 15:52:18.000' AS DateTime), N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
        .packageitems { border-collapse: collapse; }
        .itemnamehead { background-color: #999999; }
        .itemquantityhead { background-color: #999999; }
        .alt .itemname { background-color: #aaaaaa; }
        .alt .itemquantity { background-color: #aaaaaa; }
        .itemname { background-color: #ffffff; }
        .itemquantity { background-color: #ffffff; text-align: right; border-left: solid 1px #aaaaaa; }
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>	
	<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		[[Order.BillingAddress]]<br>
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Payment Method:</b> [[Order.PaymentMethod]]&nbsp;<br>
			<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>			
		</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
                                <td><b>Shipper</b></td>
				<td><b>Shipping Method</b></td>
				<td><b>Tracking Number</b></td>
				<td><b>Ship Date</b></td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<table border="0" cellspacing="0" cellpadding="3">
					        <TR>
							<TD vAlign=top align=left>SubTotal:</TD>
							<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
                                                <TR>
							<TD vAlign=top align=left>Discounts:</TD>
							<TD vAlign=top align=right>[[Order.OrderDiscounts]] </TD></TR>

						<TR>
							<TD  vAlign=top align=left>Tax: </TD>
							<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Shipping:</TD>
							<TD  vAlign=top align=right>[[Order.ShippingTotalMinusDiscounts]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Handling: </TD>
							<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
							<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
						</TR>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
		</table>			
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'<tr>
  <td align=left valign=top>[[Package.ShipperName]]</td>
  <td align=left valign=top>[[Package.ShipperService]]</td>
  <td align=left valign=top><a href="[[Package.TrackingNumberLink]]">[[Package.TrackingNumber]]</a></td>    
  <td align=left valign=top>[[Package.ShipDate]]</td>
</tr>
<tr>
  <td></td>
  <td colspan="3" align=left valign=top>[[Package.Items]]</td>
</tr>')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'34f5dffd-03ab-4bc9-b305-cd15020045ca', N'', N'A gift certificate has been issued with Gift Certificate code: [[GiftCertificate.CertificateCode]] with the amount of [[GiftCertificate.CertificateAmount]].', N'Gift Certificate Template', N'admin@bvcommerce.com', N'', N'', 1, N'Gift Certificate Code', CAST(N'2006-08-18 11:36:37.000' AS DateTime), N'', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'3b986faf-4e20-4b79-b1f8-7317ca5cac9b', N'<font face="Arial">Your password has been reset.</font>
<br />&nbsp;<br />
<font face="Arial">Username: <strong>[[User.UserName]]<br />
</strong>Password: <strong>[[NewPassword]]
</strong>
<br />
<br />
You can login with your new information here: [[Site.SiteName]]&nbsp;[[Site.TimeStamp]]
</font>', N'', N'Forgot Password Template', N'testing@bvcommerce.com', N'', N'', 0, N'Password Reminder For [[User.UserName]]', CAST(N'2006-09-07 11:16:48.000' AS DateTime), N'<font face="Arial">Your password has been reset.</font>
<br />&nbsp;<br />
<font face="Arial">Username: <strong>[[User.UserName]]<br />
</strong>Password: <strong>[[NewPassword]]
</strong>
<br />
<br />
You can login with your new information here: [[Site.SiteName]]&nbsp;[[Site.TimeStamp]]
</font>', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'3f492a3d-a77f-49a7-9b61-4173d4b13ae0', N'', N'Your Return request was reject. Please reference order number [[RMA.OrderNumber]] if you contact us for more information.

Sincerely,
[[Site.SiteName]]', N'Return Rejected Template', N'admin@bvcommerce.com', N'', N'', 1, N'Return Status for Order [[RMA.OrderNumber]]', CAST(N'2006-08-18 11:33:44.000' AS DateTime), N'', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'40e873e5-7712-4383-a0d7-d0de9b486f4d', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to view their Baby Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'', N'Baby Registry Template', N'admin@store.com', N'', N'', 0, N'[[List.UserEmail]] has invited you to view their Baby Registry!', CAST(N'2007-10-30 10:33:33.000' AS DateTime), N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to view their Baby Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'49dc0811-0d44-44ab-8ac5-5675365eca98', N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>
		<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		<br>[[Order.BillingAddress]]
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>
					</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="3"><hr></td>
			</tr>
			<tr>
                                <td><b>Qty</b></td>
				<td><b>SKU</b></td>
				<td><b>Product Name</b></td>
			</tr>
			<tr>
				<td colspan="3"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="3"><hr></td>
			</tr>
		</table>
				
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'', N'Drop Shipper Notice', N'testing@bvcommerce.com', N'<tr>
				<td align=left valign=top>[[LineItem.Quantity]]</td>
				<td align=left valign=top>[[Product.Sku]]</td>
				<td align=left valign=top>[[Product.ProductName]]<br>[[LineItem.ShippingStatus]]</td>			
</tr>', N'', 0, N'Drop Ship Request: [[Order.OrderNumber]]', CAST(N'2006-08-18 11:35:19.000' AS DateTime), N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>
		<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		<br>[[Order.BillingAddress]]
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>
					</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="3"><hr></td>
			</tr>
			<tr>
                                <td><b>Qty</b></td>
				<td><b>SKU</b></td>
				<td><b>Product Name</b></td>
			</tr>
			<tr>
				<td colspan="3"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="3"><hr></td>
			</tr>
		</table>
				
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'<tr>
				<td align=left valign=top>[[LineItem.Quantity]]</td>
				<td align=left valign=top>[[Product.Sku]]</td>
				<td align=left valign=top>[[Product.ProductName]]<br>[[LineItem.ShippingStatus]]</td>			
</tr>')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'5387b754-f9d0-4225-bf4f-12d68ecee288', N'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<style type="text/css" media="screen,print">
	html,
	body {
		margin:0;
		padding:0;
		font-family:"Trebuchet MS", Georgia, Verdana, serif;
		color:#000;
		background:#fff;
	}
	body {
		min-width:720px;
		text-align:center;
	}
	h1 {
		padding:0;
		margin:0;
		font-size:16px;
	}
	p {
		margin:9px 0 0 0;
		padding:0;
		font-size:12px;
		line-height:18px;
	}
	p+p {
		font-style:italic;
		font-size:11px;
	}
	#centerwrap {
		background:#ccc;
		width:720px;
		margin:10px auto;
		padding:10px 0;
		text-align:left;
	}
	#content {
		background:#fff;
		margin:0 10px;
		padding:10px;
	}
    .bottombox {
	    text-align:center;
	    padding:10px;
	    background-color:BlanchedAlmond;
	    border:1px solid black;
	    font-size:10px;
	    width: 200px;
        margin-left: auto;
        margin-right: auto;
	}
	
	#footer {
		text-align:center;
		clear:both;
	}
	</style>
</head>
<body>
<div id="centerwrap"> 
	<div id="content">
		<h1>Tell a Friend!</h1>
		<p>Greetings!  Your friend has suggested you look at this great deal from [[Site.SiteName]].&nbsp;
            Click on the image below to view this product in our store.</p>
        <p>
            <a href=''[[Site.StandardUrl]][[Product.ProductURL]]''>
               <IMG src=''[[Site.StandardUrl]][[Product.ImageFileSmall]]'' width=''120'' height=''120'' border=''0''>
            </a>
            <br />[[Product.LongDescription]]
            <br />[[Product.SitePrice]]
        </p>
        <p>
            Don''t worry, this e-mail is the only thing you will receive from us unless you subscribe to our [[Site.SiteName]] newsletter.
            This product, along with many others just like it can be found at our store.  These prices won''t last much longer, begin your shopping today.<br />
        </p>
    <div class="bottombox">
       <a href="[[Site.StandardUrl]]">CLICK HERE TO START SHOPPING.</a>
    </div>

</div>
<div id="footer">
	<a href="[[Site.StandardUrl]]">[[Site.SiteName]]</a>
</div>
</div>
</body>
</html>', N'', N'Email Friend', N'admin@bvcommerce.com', N'', N'', 0, N'A friend has sent you a link.', CAST(N'2006-08-18 11:36:09.000' AS DateTime), N'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
        "http://www.w3.org/TR/html4/strict.dtd">
<html lang="en">
<head>
<style type="text/css" media="screen,print">
	html,
	body {
		margin:0;
		padding:0;
		font-family:"Trebuchet MS", Georgia, Verdana, serif;
		color:#000;
		background:#fff;
	}
	body {
		min-width:720px;
		text-align:center;
	}
	h1 {
		padding:0;
		margin:0;
		font-size:16px;
	}
	p {
		margin:9px 0 0 0;
		padding:0;
		font-size:12px;
		line-height:18px;
	}
	p+p {
		font-style:italic;
		font-size:11px;
	}
	#centerwrap {
		background:#ccc;
		width:720px;
		margin:10px auto;
		padding:10px 0;
		text-align:left;
	}
	#content {
		background:#fff;
		margin:0 10px;
		padding:10px;
	}
    .bottombox {
	    text-align:center;
	    padding:10px;
	    background-color:BlanchedAlmond;
	    border:1px solid black;
	    font-size:10px;
	    width: 200px;
        margin-left: auto;
        margin-right: auto;
	}
	
	#footer {
		text-align:center;
		clear:both;
	}
	</style>
</head>
<body>
<div id="centerwrap"> 
	<div id="content">
		<h1>Tell a Friend!</h1>
		<p>Greetings!  Your friend has suggested you look at this great deal from [[Site.SiteName]].&nbsp;
            Click on the image below to view this product in our store.</p>
        <p>
            <a href=''[[Site.StandardUrl]][[Product.ProductURL]]''>
               <IMG src=''[[Site.StandardUrl]][[Product.ImageFileSmall]]'' width=''120'' height=''120'' border=''0''>
            </a>
            <br />[[Product.LongDescription]]
            <br />[[Product.SitePrice]]
        </p>
        <p>
            Don''t worry, this e-mail is the only thing you will receive from us unless you subscribe to our [[Site.SiteName]] newsletter.
            This product, along with many others just like it can be found at our store.  These prices won''t last much longer, begin your shopping today.<br />
        </p>
    <div class="bottombox">
       <a href="[[Site.StandardUrl]]">CLICK HERE TO START SHOPPING.</a>
    </div>

</div>
<div id="footer">
	<a href="[[Site.StandardUrl]]">[[Site.SiteName]]</a>
</div>
</div>
</body>
</html>', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'6b27d327-ef3f-40f4-a09b-a1a9855cbde0', N'<h1>Correspondence from [[Site.SiteName]]</h1>', N'', N'Contact Us Email Template', N'admin@bvcommerce.com', N'', N'', 0, N'Store Contact Page Notification', CAST(N'2006-08-18 11:34:58.000' AS DateTime), N'<h1>Correspondence from [[Site.SiteName]]</h1>', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'6b862817-c18b-4707-b81a-4b6515fa6694', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to see their Wishlist! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'', N'Wishlist Template', N'admin@store.com', N'', N'', 0, N'[[List.UserEmail]] has invited you to view their Wishlist!', CAST(N'2007-10-30 10:31:51.000' AS DateTime), N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>

<body>
[[List.UserEmail]] has invited you to see their Wishlist! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'8aa40d09-93dc-4e9c-bb8f-44b2052ca1dc', N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
/head>

<body>
[[List.UserEmail]] has invited you to view their Wedding Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'', N'Wedding Registry Template', N'admin@store.com', N'', N'', 0, N'[[List.UserEmail]] has invited you to view their Wedding Registry!', CAST(N'2007-10-30 10:32:44.000' AS DateTime), N'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
/head>

<body>
[[List.UserEmail]] has invited you to view their Wedding Registry! <a href="[[List.URL]]?id=[[List.Bvin]]">Click Here</a> to view it.
</body>
</html>', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'9ac4f34e-f5de-4b95-ac3b-657380542873', N'', N'Your Return request was accepted. The RMA number is [[RMA.Number]]. Please display this number clearly on the outside of the package that you are returning.

Thanks,
[[Site.SiteName]]', N'Return Accepted Template', N'admin@bvcommerce.com', N'', N'', 1, N'Return Status for Order [[RMA.OrderNumber]]', CAST(N'2006-08-18 11:34:01.000' AS DateTime), N'', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'c0cb9492-f4be-4bdb-9ae9-0b14c7bd2cd0', N'', N'A new return was requested from the store.
Name: [[RMA.Name]]
Email: [[RMA.EmailAddress]]
RMA Number: [[RMA.Number]]
Order Number: [[RMA.OrderNumber]]', N'New Return Email Template', N'admin@bvcommerce.com', N'', N'', 1, N'New Return Requested', CAST(N'2007-02-09 15:06:22.000' AS DateTime), N'', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'fc2bf4e9-65cf-4d3e-8d64-c039f8de29ee', N'', N'The following new review for [[ProductReview.ProductName]] was posted by [[ProductReview.Name]] ([[ProductReview.Email]]).

STATUS: [[ProductReview.Approved]]

RATING: [[ProductReview.Rating]]

REVIEW:  [[ProductReview.Description]]


IP: [[ProductReview.IP]]
Host: [[ProductReview.Host]]
Browser: [[ProductReview.Browser]]


You can moderate this review here:
[[Site.StandardUrl]]BVAdmin/Catalog/Reviews_Edit.aspx?reviewID=[[ProductReview.Bvin]]&ReturnURL=products_edit_reviews.aspx%3fid%3d[[ProductReview.ProductBvin]]', N'Admin Product Review Notification', N'empty@bvcommerce.com', N'', N'', 1, N'New Product Review for [[ProductReview.ProductName]]', CAST(N'2015-02-09 16:36:51.687' AS DateTime), N'', N'')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'fe64609d-db68-4cc8-a4d1-4debb1071050', N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
        .trackingnumberlist {list-style:none;}
        .trackingnumberlinklist {list-style:none;}
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>	
	<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		[[Order.BillingAddress]]<br>
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Payment Method:</b> [[Order.PaymentMethod]]&nbsp;<br>
			<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>			
		</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
                                <td><b>Qty</b></td>
				<td><b>SKU</b></td>
				<td><b>Product Name</b></td>
				<td align="right"><b>Unit Price</b></td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="4"><hr></td>
			</tr>
                        <tr>
				<td colspan="4">Tracking Numbers:</td>
			</tr>
                        <tr>
				<td colspan="4">[[Order.TrackingNumberLinks]]</td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<table border="0" cellspacing="0" cellpadding="3">
					<TR>
							<TD vAlign=top align=left>SubTotal:</TD>
							<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
                                                <TR>
							<TD vAlign=top align=left>Discounts:</TD>
							<TD vAlign=top align=right>[[Order.OrderDiscounts]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Tax: </TD>
							<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Shipping:</TD>
							<TD  vAlign=top align=right>[[Order.ShippingTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Handling: </TD>
							<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
							<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
						</TR>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
		</table>			
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'', N'Order Status Update E-Mail', N'testing@bvcommerce.com', N'<tr>
				<td align=left valign=top>[[LineItem.Quantity]]</td>
				<td align=left valign=top>[[LineItem.Sku]]</td>
				<td align=left valign=top>[[Product.ProductName]]<br>[[LineItem.ShippingStatus]]</td>
				<td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
			</tr>', N'', 0, N'Status update for order [[Order.OrderNumber]]', CAST(N'2006-11-14 13:38:44.000' AS DateTime), N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
        .trackingnumberlist {list-style:none;}
        .trackingnumberlinklist {list-style:none;}
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>	
	<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		[[Order.BillingAddress]]<br>
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Payment Method:</b> [[Order.PaymentMethod]]&nbsp;<br>
			<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>			
		</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
                                <td><b>Qty</b></td>
				<td><b>SKU</b></td>
				<td><b>Product Name</b></td>
				<td align="right"><b>Unit Price</b></td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="4"><hr></td>
			</tr>
                        <tr>
				<td colspan="4">Tracking Numbers:</td>
			</tr>
                        <tr>
				<td colspan="4">[[Order.TrackingNumberLinks]]</td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<table border="0" cellspacing="0" cellpadding="3">
					<TR>
							<TD vAlign=top align=left>SubTotal:</TD>
							<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
                                                <TR>
							<TD vAlign=top align=left>Discounts:</TD>
							<TD vAlign=top align=right>[[Order.OrderDiscounts]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Tax: </TD>
							<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Shipping:</TD>
							<TD  vAlign=top align=right>[[Order.ShippingTotalMinusDiscounts]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Handling: </TD>
							<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
							<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
						</TR>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
		</table>			
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'<tr>
				<td align=left valign=top>[[LineItem.Quantity]]</td>
				<td align=left valign=top>[[LineItem.Sku]]</td>
				<td align=left valign=top>[[Product.ProductName]]<br>[[LineItem.ShippingStatus]]</td>
				<td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
			</tr>')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'fea0ec5c-4d34-45fa-aef2-c05aabfad854', N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>
	<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		[[Order.BillingAddress]]<br>
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Payment Method:</b> [[Order.PaymentMethod]]&nbsp;<br>
			<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>			
		</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
                                <td><b>Qty</b></td>
				<td><b>SKU</b></td>
				<td><b>Product Name</b></td>
				<td align="right"><b>Unit Price</b></td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<table border="0" cellspacing="0" cellpadding="3">
					<TR>
							<TD vAlign=top align=left>SubTotal:</TD>
							<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Tax: </TD>
							<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Shipping:</TD>
							<TD  vAlign=top align=right>[[Order.ShippingTotalMinusDiscounts]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Handling: </TD>
							<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
							<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
						</TR>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
		</table>	
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'', N'New Order Receipt E-mail', N'testing@bvcommerce.com', N'<tr>
  <td align=left valign=top>[[LineItem.Quantity]]</td>
  <td align=left valign=top>[[Product.Sku]]</td>
  <td align=left valign=top>[[Product.ProductName]]<br />[[LineItem.InputsAndModifiers]]<br />[[LineItem.ShippingStatus]]</td>
  <td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
</tr>', N'', 0, N'Order receipt for order [[Order.OrderNumber]]', CAST(N'2006-11-14 13:44:59.000' AS DateTime), N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
	A:link { color: #3366cc; text-decoration: none; }
	A:visited { color: #663399; text-decoration: none; }
	A:active { color: #cccccc; text-decoration: none; }
	A:Hover { text-decoration: underline; }
	BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
	.content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
	.title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
	.headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
	.message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
	</style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
	<table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
	<tr>
		<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
	</tr>
	<TR>
		<TD class=FormLabel vAlign=top align=left width="50%">
		<b>Billed To:</b><br>
		[[Order.BillingAddress]]<br>
		[[Order.UserName]]
		</TD>
		<TD class=FormLabel vAlign=top align=left width="50%">
			<b>Order Number:</b> [[Order.OrderNumber]]<BR>
			<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
			<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
			<b>Payment Method:</b> [[Order.PaymentMethod]]&nbsp;<br>
			<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
			<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>			
		</TD>		
	</TR>
	<tr>
		<td colspan="2">
			<table border="0" cellspacing="0" cellpadding="5" width="100%">
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
                                <td><b>Qty</b></td>
				<td><b>SKU</b></td>
				<td><b>Product Name</b></td>
				<td align="right"><b>Unit Price</b></td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			[[RepeatingSection]]
			<tr>
				<td colspan="4"><hr></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<table border="0" cellspacing="0" cellpadding="3">
					<TR>
							<TD vAlign=top align=left>SubTotal:</TD>
							<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Tax: </TD>
							<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Shipping:</TD>
							<TD  vAlign=top align=right>[[Order.ShippingTotalMinusDiscounts]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left>Handling: </TD>
							<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
						<TR>
							<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
							<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
						</TR>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="4"><hr></td>
			</tr>
		</table>	
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Please retain for your records.</b></td>
	</tr>						
</table>
</body>
</html>', N'<tr>
  <td align=left valign=top>[[LineItem.Quantity]]</td>
  <td align=left valign=top>[[Product.Sku]]</td>
  <td align=left valign=top>[[Product.ProductName]]<br />[[LineItem.InputsAndModifiers]]<br />[[LineItem.ShippingStatus]]</td>
  <td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
</tr>')
INSERT [dbo].[bvc_EmailTemplate] ([bvin], [Body], [BodyPlainText], [DisplayName], [From], [RepeatingSection], [RepeatingSectionPlainText], [SendInPlainText], [Subject], [LastUpdated], [BodyPreTransform], [RepeatingSectionPreTransform]) VALUES (N'ff59ce07-6a05-4142-83ad-53b8e00c04b5', N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
    A:link { color: #3366cc; text-decoration: none; }
    A:visited { color: #663399; text-decoration: none; }
    A:active { color: #cccccc; text-decoration: none; }
    A:Hover { text-decoration: underline; }
    BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
    .body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
    .content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
    .title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
    .headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
    .message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
    </style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
    <table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
    <tr>
    	<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
    </tr>
    <tr>
    	<td class=FormLabel colSpan=2>
                <hr><a href=[[Order.AdminLink]]>View Order Details</a><br>
                &nbsp;
    	</td>
    </tr>
    <TR>
    	<TD class=FormLabel vAlign=top align=left width="50%">
    	<b>Billed To:</b><br>
    	[[Order.BillingAddress]]<br>
    	[[Order.UserName]]
    	</TD>
    	<TD class=FormLabel vAlign=top align=left width="50%">
    		<b>Order Number:</b> [[Order.OrderNumber]]<BR>
    		<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
    		<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
    		<b>Payment Method:</b> [[Order.PaymentMethod]]&nbsp;<br>
    		<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
    		<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>
    	</TD>
    </TR>
    <tr>
    	<td colspan="2">
    		<table border="0" cellspacing="0" cellpadding="5" width="100%">
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    		<tr>
                                <td><b>Qty</b></td>
    			<td><b>SKU</b></td>
    			<td><b>Product Name</b></td>
    			<td align="right"><b>Unit Price</b></td>
    		</tr>
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    		[[RepeatingSection]]
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    		<tr>
    			<td colspan="4" align="right">
    				<table border="0" cellspacing="0" cellpadding="3">
    				<TR>
    						<TD vAlign=top align=left>SubTotal:</TD>
    						<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
                                        <TR>
    						<TD vAlign=top align=left>Discounts:</TD>
    						<TD vAlign=top align=right>[[Order.OrderDiscounts]] </TD></TR>

    					<TR>
    						<TD  vAlign=top align=left>Tax: </TD>
    						<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
    					<TR>
    						<TD  vAlign=top align=left>Shipping:</TD>
    						<TD  vAlign=top align=right>[[Order.ShippingTotalMinusDiscounts]] </TD></TR>
    					<TR>
    						<TD  vAlign=top align=left>Handling: </TD>
    						<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
    					<TR>
    						<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
    						<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
    					</TR>
    				</table>
    			</td>
    		</tr>
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    	</table>
    	</td>
    </tr>
    <tr>
    	<td colspan="2"><b>Please retain for your records.</b></td>
    </tr>
</table>
</body>
</html>', N'', N'Admin Order Receipt', N'testing@bvcommerce.com', N'<tr>
  <td align=left valign=top>[[LineItem.Quantity]]</td>
  <td align=left valign=top>[[Product.Sku]]</td>
  <td align=left valign=top>[[Product.ProductName]]<br />[[LineItem.ShippingStatus]]</td>
<td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
</tr>', N'', 0, N'New Order [[Order.OrderNumber]] Received [[Site.SiteName]]', CAST(N'2006-11-14 13:36:53.000' AS DateTime), N'<html>
 <head>
 <meta name=vs_targetSchema content="http://schemas.microsoft.com/intellisense/ie5">
<style type="text/css"> A { text-decoration: none; }
    A:link { color: #3366cc; text-decoration: none; }
    A:visited { color: #663399; text-decoration: none; }
    A:active { color: #cccccc; text-decoration: none; }
    A:Hover { text-decoration: underline; }
    BODY, TD, CENTER, P { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
    .body { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 10px; color: #333333; }
    .content { font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: normal; color: #000000; }
    .title { font-family: Helvetica, Arial, sans-serif; font-size: 10px; font-weight: normal; color: #000000; }
    .headline { font-family: Helvetica, Arial, sans-serif; font-size: 14px; font-weight: bold; color: #000000; }
    .message { font-family: Geneva, Verdana, Arial, Helvetica; font-size: 9px; }
    </style>
 </head>
<body bgcolor="#ffffff" LINK="#3366cc" VLINK="#3366cc" ALINK="#3366cc" LEFTMARGIN="0" TOPMARGIN="0">
    <table cellSpacing=1 cellPadding=3 width="100%" border="0" runat="server">
    <tr>
    	<td colSpan=2><IMG src="[[Site.Logo]]" border=0></td>
    </tr>
    <tr>
    	<td class=FormLabel colSpan=2>
                <hr><a href=[[Order.AdminLink]]>View Order Details</a><br>
                &nbsp;
    	</td>
    </tr>
    <TR>
    	<TD class=FormLabel vAlign=top align=left width="50%">
    	<b>Billed To:</b><br>
    	[[Order.BillingAddress]]<br>
    	[[Order.UserName]]
    	</TD>
    	<TD class=FormLabel vAlign=top align=left width="50%">
    		<b>Order Number:</b> [[Order.OrderNumber]]<BR>
    		<b>Order Time:</b> [[Order.TimeOfOrder]]<br>
    		<b>Current Status:</b> [[Order.Status]]&nbsp;<BR>
    		<b>Payment Method:</b> [[Order.PaymentStatus]]&nbsp;<br>
    		<b>Promotional Code(s):</b> [[Order.Coupons]]&nbsp;<br>
    		<b>Special Instructions:</b> [[Order.Instructions]]&nbsp;<br>
    	</TD>
    </TR>
    <tr>
    	<td colspan="2">
    		<table border="0" cellspacing="0" cellpadding="5" width="100%">
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    		<tr>
                                <td><b>Qty</b></td>
    			<td><b>SKU</b></td>
    			<td><b>Product Name</b></td>
    			<td align="right"><b>Unit Price</b></td>
    		</tr>
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    		[[RepeatingSection]]
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    		<tr>
    			<td colspan="4" align="right">
    				<table border="0" cellspacing="0" cellpadding="3">
    				<TR>
    						<TD vAlign=top align=left>SubTotal:</TD>
    						<TD vAlign=top align=right>[[Order.SubTotal]] </TD></TR>
                                        <TR>
    						<TD vAlign=top align=left>Discounts:</TD>
    						<TD vAlign=top align=right>[[Order.OrderDiscounts]] </TD></TR>

    					<TR>
    						<TD  vAlign=top align=left>Tax: </TD>
    						<TD  vAlign=top align=right>[[Order.TaxTotal]] </TD></TR>
    					<TR>
    						<TD  vAlign=top align=left>Shipping:</TD>
    						<TD  vAlign=top align=right>[[Order.ShippingTotalMinusDiscounts]] </TD></TR>
    					<TR>
    						<TD  vAlign=top align=left>Handling: </TD>
    						<TD  vAlign=top align=right>[[Order.HandlingTotal]] </TD></TR>
    					<TR>
    						<TD  vAlign=top align=left><B>Grand Total:</B> </TD>
    						<TD  vAlign=top align=right>[[Order.GrandTotal]] </TD>
    					</TR>
    				</table>
    			</td>
    		</tr>
    		<tr>
    			<td colspan="4"><hr></td>
    		</tr>
    	</table>
    	</td>
    </tr>
    <tr>
    	<td colspan="2"><b>Please retain for your records.</b></td>
    </tr>
</table>
</body>
</html>', N'<tr>
  <td align=left valign=top>[[LineItem.Quantity]]</td>
  <td align=left valign=top>[[Product.Sku]]</td>
  <td align=left valign=top>[[Product.ProductName]]<br />[[LineItem.ShippingStatus]]</td>
<td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
</tr>')
INSERT [dbo].[bvc_OrderStatusCode] ([bvin], [SystemCode], [StatusName], [SortOrder], [LastUpdated]) VALUES (N'09D7305D-BD95-48d2-A025-16ADC827582A', 1, N'Complete', 5, CAST(N'2006-08-11 14:59:38.000' AS DateTime))
INSERT [dbo].[bvc_OrderStatusCode] ([bvin], [SystemCode], [StatusName], [SortOrder], [LastUpdated]) VALUES (N'0c6d4b57-3e46-4c20-9361-6b0e5827db5a', 0, N'Ready for Shipping', 4, CAST(N'2006-08-11 14:59:38.000' AS DateTime))
INSERT [dbo].[bvc_OrderStatusCode] ([bvin], [SystemCode], [StatusName], [SortOrder], [LastUpdated]) VALUES (N'88B5B4BE-CA7B-41a9-9242-D96ED3CA3135', 1, N'On Hold', 1, CAST(N'2006-05-29 13:49:43.000' AS DateTime))
INSERT [dbo].[bvc_OrderStatusCode] ([bvin], [SystemCode], [StatusName], [SortOrder], [LastUpdated]) VALUES (N'e42f8c28-9078-47d6-89f8-032c9a6e1cce', 0, N'Pending Payment', 3, CAST(N'2006-05-29 13:54:34.000' AS DateTime))
INSERT [dbo].[bvc_OrderStatusCode] ([bvin], [SystemCode], [StatusName], [SortOrder], [LastUpdated]) VALUES (N'F37EC405-1EC6-4a91-9AC4-6836215FBBBC', 1, N'In Process', 2, CAST(N'2006-05-29 13:49:43.000' AS DateTime))
INSERT [dbo].[bvc_PrintTemplate] ([bvin], [Body], [DisplayName], [RepeatingSection], [SystemTemplate], [LastUpdated]) VALUES (N'39e51ef8-280d-4358-b507-8d4d8ca348a1', N'<table cellSpacing="0" cellPadding="5" width="600" border="0" ID="Table1">
			<tr>
				<td vAlign="bottom" align="left">
					<H1>[[Order.OrderNumber]]</H1>
					[[Order.TimeOfOrder]]<BR>
					[[Order.Instructions]]
				</td>
				<td align="right" valign="top">
					<table border="0" cellspacing="0" cellpadding="0" ID="Table2">
						<tr>
							<td>[[Site.SiteLogo]]</td>
						</tr>
						<tr>
							<td>[[Site.StoreAddress]]</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" vAlign="top" align="left">
					<table class="PrintBorder" width="200" border="1" cellspacing="0" cellpadding="3" ID="Table3">
						<tr>
							<td class="HeaderStyle2">Ship To</td>
						</tr>
						<tr>
							<td bgcolor="#FFFFFF">
								[[Order.ShippingAddress]]</td>
						</tr>
					</table>
			<tr>
				<td colspan="2" vAlign="top" align="left">
					<table class="PrintBorder" width="200" border="1" cellspacing="0" cellpadding="3" ID="Table4">
						<tr>
							<td>Product SKU</td>
							<td>Product Name</td>
							<td>Quantity</td>
						</tr>
						
						[[RepeatingSection]]
						
			</tr>
		</table>
		</td> 
</tr> 
</tr> 
</table>', N'Packing Slip', N'<tr>
  <td align=left valign=top>[[Product.Sku]]</td>
  <td align=left valign=top>[[Product.ProductName]]</td>
  <td align=center valign=top>[[LineItem.Quantity]]</td>
</tr>', 1, CAST(N'2006-06-14 15:27:37.000' AS DateTime))
INSERT [dbo].[bvc_PrintTemplate] ([bvin], [Body], [DisplayName], [RepeatingSection], [SystemTemplate], [LastUpdated]) VALUES (N'6c9c2d90-9f76-42aa-8453-b77ed44c283d', N'<table border="0" cellspacing="0" cellpadding="3" width="600" ID="Table1">
			<tr>
				<td width="34%" align="left" valign="bottom"><H1>
						[[Order.OrderNumber]]</H1>
						[[Order.TimeOfOrder]]</td>
				<td width="33%" align="center" valign="top">&nbsp;</td>
				<td width="33%" align="right" valign="top" class="BVText">
					Admin Order Record&nbsp;
				</td>
			</tr>
			<tr>
				<td align="left" valign="top">
					<table width="200" cellSpacing="0" cellPadding="3" border="1" ID="Table2">
						<tr>
							<td class="HeaderStyle1">Sold&nbsp;To</td>
						</tr>
						<tr>
							<td class="BVSmallText">[[Order.BillingAddress]][[Order.UserName]]</td>
						</tr>
					</table>
				</td>
				<td align="center" valign="top">&nbsp;</td>
				<td align="right" valign="top"><table cellSpacing="0" cellPadding="3" border="1" ID="Table3">
						<tr>
							<td width="200" class="HeaderStyle1">Payment Info</td>
						</tr>
						<tr>
							<td class="BVSmallText">[[Order.PaymentMethod]]<BR>
								[[Order.PaymentStatus]]</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="3" align="left" valign="top">
					<table width="200" border="1" cellspacing="0" cellpadding="3" ID="Table4">
								<tr>
									<td class="HeaderStyle2">Ship To</td>
								</tr>
								<tr>
									<td bgcolor="#FFFFFF">
										[[Order.ShippingAddress]]</td>
								</tr>
							</table>
					&nbsp;
					<table width="200" border="1" cellspacing="0" cellpadding="3" ID="Table6">
					<tr>
							<td>Product SKU</td>
							<td>Product Name</td>
							<td>Quantity</td>
<td>Unit Price</td>
<td>Subtotal</td>
					</tr>
[[RepeatingSection]]


				</td>
			</tr>
			<tr>
				<td class="BVSmallText" vAlign="top" align="left"><em>Customer''s Instructions:</em><BR>
					[[Order.Instructions]]<BR>
				</td>
				<td class="BVSmallText" vAlign="top" align="center"><em>Codes Used:</em><BR>
					[[Order.Coupons]]<BR>
				</td>
				<td class="BVSmallText" vAlign="top" align="right">
					<table cellSpacing="0" cellPadding="2" width="220" border="0" ID="Table5">
						<tr>
							<td class="BVSmallText" vAlign="top" align="left">SubTotal:</td>
							<td class="BVSmallText" vAlign="top" align="right">[[Order.SubTotal]]</td>
						</tr>
						<tr>
							<td class="BVSmallText" vAlign="top" align="left">Tax:</td>
							<td class="BVSmallText" vAlign="top" align="right">[[Order.TaxTotal]]</td>
						</tr>
						<tr>
							<td class="BVSmallText" vAlign="top" align="left">Shipping:</td>
							<td class="BVSmallText" vAlign="top" align="right">[[Order.ShippingTotalMinusDiscounts]]</td>
						</tr>
						<tr>
							<td class="BVSmallText" vAlign="top" align="left">Handling:</td>
							<td class="BVSmallText" vAlign="top" align="right">[[Order.HandlingTotal]]</td>
						</tr>						
						<tr>
							<td colSpan="2">
								<hr>
							</td>
						</tr>
						<tr>
							<td class="FormLabel" vAlign="top" align="left"><b>Order Total:</b>
							</td>
							<td class="FormLabel" vAlign="top" align="right"><b>[[Order.GrandTotal]]</b></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>', N'Administrator Receipt', N'<tr>
					 <td align=left valign=top>[[Product.Sku]]</td>
					 <td align=left valign=top>[[Product.ProductName]]</td>
					 <td align=center valign=top>[[LineItem.Quantity]]</td>
					<td align=center valign=top>[[LineItem.BasePrice]]</td>
<td align=center valign=top>[[LineItem.LineTotal]]</td>
</tr>', 1, CAST(N'2006-08-23 09:52:32.000' AS DateTime))
INSERT [dbo].[bvc_PrintTemplate] ([bvin], [Body], [DisplayName], [RepeatingSection], [SystemTemplate], [LastUpdated]) VALUES (N'c090c3e7-974b-4a62-afdf-716395abec3d', N'<table border="0" cellspacing="0" cellpadding="3" width="100%">
        <tr>
            <td width="33%">
                <h1>
                    Order [[Order.OrderNumber]]                    
                </h1>
            </td>
            <td align="left" valign="top">
                [[Order.Status]]
            </td>
            <td width="33%" valign="top" align="right" rowspan="2">
            &nbsp;                
            </td>
        </tr>
        <tr>
            <td valign="top">
                <span class="lightlabel">Sold To:</span><br />
                [[Order.BillingAddress]]
            </td>
            <td valign="top">                
                <span class="lightlabel">Ship To:</span><br />
                [[Order.ShippingAddress]]                
            </td>
        </tr>
        <tr>
            <td colspan="3"><hr />
<table border="0" cellspacing="0" cellpadding="3" width="100%">[[RepeatingSection]]</table><hr />
            </td>
        </tr>
        <tr>
            <td valign="top">                
                    <em>Customer''s Instructions:</em><br />
                    [[Order.Instructions]]
                &nbsp;
            </td>
            <td valign="top">
                &nbsp;
            </td>
            <td valign="top" align="right">
                <table cellspacing="0" cellpadding="2" width="200" border="0">
                    <tr>
                        <td class="FormLabel" valign="top" align="left">
                            SubTotal:</td>
                        <td class="FormLabel" valign="top" align="right">
                            [[Order.SubTotal]]
                        </td>
                    </tr>
                    <tr>
                        <td class="FormLabel" valign="top" align="left">
                            Tax:</td>
                        <td class="FormLabel" valign="top" align="right">
                            [[Order.TaxTotal]]
                        </td>
                    </tr>
                    <tr>
                        <td class="FormLabel" valign="top" align="left">
                            Shipping:</td>
                        <td class="FormLabel" valign="top" align="right">
                            [[Order.ShippingTotal]]
                        </td>
                    </tr>
                    <tr>
                        <td class="FormLabel" valign="top" align="left">
                            Handling:</td>
                        <td class="FormLabel" valign="top" align="right">
                            [[Order.HandlingTotal]]
                        </td>
                    </tr>
                    <tr>
                        <td class="FormLabel" valign="top" align="left">
                            &nbsp;
                        </td>
                        <td class="FormLabel" valign="top" align="right" style="border-top: solid 1px #666;">
                            <strong>
                                [[Order.GrandTotal]]
                            </strong>
                        </td>
                    </tr>
                </table>
                 &nbsp;<br />
                <em>Codes Used:</em><br />
                [[Order.Coupons]]
            </td>
        </tr>       
    </table>', N'Customer Invoice', N'<tr>
  <td align=left valign=top>[[Product.Sku]]</td>
  <td align=left valign=top>[[Product.ProductName]]<br />[[LineItem.ShippingStatus]]</td>
  <td align=right valign=top>[[LineItem.AdjustedPrice]]</td>
  <td align=center valign=top>[[LineItem.Quantity]]</td>
  <td align="right" valign="top">[[LineItem.LineTotal]]</td>
</tr>', 1, CAST(N'2006-06-12 16:46:32.000' AS DateTime))
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'AccountLocked', N'Account Locked. Contact Administrator')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'AddressBook', N'Address Book')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'AffiliateReport', N'Affiliate Report')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'AffiliateSignup', N'Affiliate Signup')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'AffiliateTermsAndConditions', N'Affiliate Terms And Conditions')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'AverageRating', N'Average Rating')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'BabyRegistry', N'Baby Registry')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'BreadcrumbTrailSeparator', N'&nbsp;::&nbsp;')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CartBackOrdered', N'Item(s) In Your Cart Are Back-Ordered.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CartNotEnoughQuantity', N'%ProductName% does not have enough quantity to complete order. Please modify it.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CartOutOfStock', N'%ProductName% Is Out Of Stock. Please Remove It.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CartPageMinimumQuantityError', N'Product %ProductName% has a minimum purchase quantity of %quantity%. Amount Adjusted.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Categories', N'Categories')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Category', N'Category')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ChangeEmail', N'Change Email')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ChangePassword', N'Change Password')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Checkout', N'Checkout')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ConfirmEmail', N'Confirm Email')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ConfirmNewPassword', N'Confirm New Password')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ConfirmNewUsername', N'Confirm New Email Address')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ConfirmPassword', N'Confirm Password')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ContactUs', N'Contact Us')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CouponDoesNotApply', N'Coupon code does not apply to this order.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CreateANewAccount', N'Create New Account')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CreateNewAddress', N'Create New Address')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CrossSellTitle', N'Additional Product Accessories')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CustomerReviews', N'Customer Reviews')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'CustomerService', N'Customer Service')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'DownloadFiles', N'Download Files')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'EditAddress', N'Edit Address')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'EmptyCart', N'Your Cart is Empty')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageContentTextCategory', N'An error occurred while trying to find the specified category.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageContentTextGeneric', N'An error occurred while trying to find the specified page.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageContentTextProduct', N'An error occurred while trying to find the specified product.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageHeaderTextCategory', N'Error finding category')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageHeaderTextGeneric', N'Error finding page')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ErrorPageHeaderTextProduct', N'Error finding product')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'FAQ', N'Frequently Asked Questions')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'First', N'First')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ForgotPassword', N'Forgot Password')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'GoogleCheckoutCustomerError', N'')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Help', N'Help')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Home', N'Home')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ImageExtensionError', N'Images must be .jpg .gif or .png')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ItemFound', N'item found')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ItemsFound', N'items found')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Last', N'Last')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LineItemsChanged', N'Line Items In Your Cart Were Modified Due To Low Stock.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ListPrice', N'List Price')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Login', N'Sign In')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LoginIncorrect', N'Login incorrect, please try again.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Logout', N'Sign Out')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LowStockLineItem', N'Item stock is lower than quantity requested.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LoyaltyPoints', N'Loyalty Points')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LoyaltyPointsCredit', N'Loyalty Points Credit')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'LoyaltyPointsEarned', N'Loyalty Points Earned')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'MailingList', N'Mailing List')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'MailingLists', N'Mailing Lists')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'MakeAnyChangesAbove', N'Make any changes above?')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'MyAccount', N'Your Account')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'NewEmail', N'New Email')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'NewPassword', N'New Password')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'NewUsername', N'New Email Address')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Next', N'Next')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'NextProduct', N'Next')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'NoShippingRequired', N'No Shipping Required.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'NoValidShippingMethods', N'No Valid Shipping Methods Found.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'OrderAlreadyPlaced', N'Order has already been placed, or no cart exists.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'OrderDetails', N'Order Details')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'OrderHistory', N'Order History')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'OutOfStock', N'This Item is Out of Stock')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'OutOfStockAllowPurchase', N'Item is backordered.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'OutOfStockNoPurchase', N'Item is out of stock.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Page', N'Page')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Password', N'Password')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PasswordAnswer', N'Password Answer')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PasswordHint', N'Password Hint')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PaypalCheckoutCustomerError', N'')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Previous', N'Prev')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PreviousProduct', N'Prev')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PrivacyPolicy', N'Privacy Policy')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'PrivateStoreNewUser', N'Need an account? Contact us.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Product', N'Product')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductCombinationInvalid', N'This combination of options is not valid. Please select a different combination of options.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductCombinationNotAvailable', N'Currently selected product is not available.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductNotAvailable', N'%ProductName% is not available.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductPageMinimumQuantityError', N'Product Has A Minimum Purchase Quantity of %Quantity%')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ProductReviewAnonymousUserName', N'Anonymous')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Products', N'Products')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Quantity', N'Qty')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'QuantityChanged', N'Item''s Quantity Was Modified Due To Low Stock.')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'RecentlyViewedItems', N'Recently Viewed Items')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'RelatedItems', N'You may also like...')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'RememberUser', N'Remember Me')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ReturnForm', N'Return Form')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ReturnPolicy', N'Return Policy')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Search', N'Search')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ShippingTermsAndConditions', N'Shipping Policy')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ShippingUnknown', N'To Be Determined. Contact Store for Details')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ShoppingCart', N'Shopping Cart')
GO
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'SiteMap', N'Site Map')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'SitePrice', N'Your Price')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'SiteTermsAgreementError', N'You Must Agree To The Site Terms Before You Can Proceed')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'SKU', N'SKU')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'SortOrder', N'Sort Order')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'SuggestedItems', N'Customers who purchased this item also purchased these items:')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'TermsAndConditions', N'Terms and Conditions')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'TermsAndConditionsAgreement', N'I Agree To This Sites Terms And Conditions')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Themes', N'Themes')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'UpSellTitle', N'Additional Product Information')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'Username', N'Username')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ValidatorFieldMarker', N'*')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ViewAll', N'&nbsp;View All')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ViewByPages', N'View By Pages')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'ViewCart', N'View Cart')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'WasThisReviewHelpful', N'Was this review helpful?')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'WeddingRegistry', N'Wedding Registry')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'WishList', N'Wish List')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'WriteAReview', N'Write a Review?')
INSERT [dbo].[bvc_SiteTerm] ([SiteTerm], [SiteTermValue]) VALUES (N'YouSave', N'You Save')
INSERT [dbo].[bvc_TaxClass] ([bvin], [DisplayName], [LastUpdated]) VALUES (N'0eac3246-3d94-44f4-835f-01495ae8bfe3', N'Tobacco', CAST(N'2006-05-24 15:15:13.000' AS DateTime))
INSERT [dbo].[bvc_TaxClass] ([bvin], [DisplayName], [LastUpdated]) VALUES (N'4a4f368c-1741-4a15-8857-c762de9f0692', N'EU Taxable Item', CAST(N'2006-05-24 15:14:54.000' AS DateTime))
INSERT [dbo].[bvc_TaxClass] ([bvin], [DisplayName], [LastUpdated]) VALUES (N'6eca70ea-0cea-4d8e-b2b5-26fd0cbe07c0', N'Food and Beverages', CAST(N'2006-05-24 15:15:08.000' AS DateTime))
INSERT [dbo].[bvc_TaxClass] ([bvin], [DisplayName], [LastUpdated]) VALUES (N'caca6138-a5ea-4460-a868-4721f4b78920', N'Alcohol', CAST(N'2006-06-26 12:10:39.000' AS DateTime))
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AddThisCode', N'
<!-- AddThis Button BEGIN -->
<div class="addthis_toolbox addthis_default_style ">
<a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
<a class="addthis_button_tweet"></a>
<a class="addthis_button_pinterest_pinit"></a>
<a class="addthis_counter addthis_pill_style"></a>
</div>
<!-- AddThis Button END -->
')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AddThisTrackUrls', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AdminHeaderMessage', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AffiliateCommissionAmount', N'5')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AffiliateCommissionType', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AffiliateConflictMode', N'2')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AffiliateQueryStringName', N'affid')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AffiliateReferralDays', N'30')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AllowAffiliateThemes', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AllowedWishLists', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AllowPersonalizedThemes', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AllowZeroDollarOrders', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AlwaysShowAllProductCategories', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AmazonAssociateID', N'bvsoftware-20')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleAdwordsBackgroundColor', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleAdwordsConversionId', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleAdwordsConversionLabel', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleEcommerceStoreName', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleTagManagerContainerId', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleTrackingId', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleUseDisplayFeatures', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsGoogleUseEnhancedLinkAttribution', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsMicrosoftAdCenterTrackingCode', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsUseGoogleAdwords', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsUseGoogleEcommerce', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsUseGoogleTagManager', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsUseGoogleTracker', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsUseMicrosoftAdCenter', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsUseYahoo', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AnalyticsYahooAccountId', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ApplyTaxToShippingAddress', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutomaticallyIssueRMANumbers', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutomaticallyRegenerateDynamicCategories', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutomaticallyRegenerateDynamicCategoriesIntervalInHours', N'24')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutomaticallyRegenerateDynamicCategoriesLastDateTimeRun', N'635590966310205951')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutoPopulateRedirectOnCategoryDelete', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutoPopulateRedirectOnCustomPageDelete', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AutoPopulateRedirectOnProductDelete', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraAccount', N'iyZgiZHIngI=')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraCompanyCode', N'iyZgiZHIngI=')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraDebug', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraEnabled', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraLicenseKey', N'iyZgiZHIngI=')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraLogTransactionsInOrderNotes', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraPassword', N'iyZgiZHIngI=')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraUrl', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'AvalaraUserName', N'iyZgiZHIngI=')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressRequireCompany', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressRequireFax', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressRequireFirstName', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressRequireLastName', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressRequirePhone', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressRequireWebSiteURL', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressShowCompany', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressShowFax', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressShowMiddleInitial', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressShowPhone', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BillAddressShowWebSiteUrl', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'BreadCrumbTrailMaxEntries', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CallbackWaitingMessage', N'Please Wait...')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CanonicalUrlEnabled', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CartCleanupDaysOld', N'7')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CartCleanupIntervalInHours', N'24')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CartCleanupLastTimeRun', N'635590966310255951')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CartIdCookieName', N'Bvc5CartId')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CCSDaysOld', N'7')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CCSHours', N'24')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CCSLastTimeRun', N'635590966310275951')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ChargeTaxOnGiftwrap', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ChargeTaxOnNonShippingItems', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ChargeTaxOnShipping', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CheckoutControl', N'One Page Checkout Plus')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ContactEmail', N'empty@bvcommerce.com')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ContactForm', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ContactUsEmailRecipient', N'empty@bvcommerce.com')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CookieDomain', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'CookiePath', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Cryptography3DesKey', N'EDBE6BF8A92A417cBCD3DB23120861B5DE780BA44DB44166888707607A2A16FBBADFD3E111D54396A5701CE43E0EC3FFAE5543370AF54228B65CB87D7E346048')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DatabaseSP6', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DatabaseSP7', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DatabaseV2013', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DatabaseV2015', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DefaultCategoryTemplate', N'Grid')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DefaultHomePage', N'default.aspx')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DefaultKitTemplate', N'List')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DefaultPlugin', N'FeedEngine')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DefaultProductTemplate', N'Bvc2013')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DefaultTextEditor', N'TinyMCE')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisableAdminLights', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisableInventory', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisableProductCaching', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplayCrossSellsInShoppingCart', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplayCrossSellsWhenAddingItemToCart', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplayFullCreditCardInfo', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplayFullCreditCardNumber', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplayShippingCalculatorInShoppingCart', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplaySiteTermsToCustomerUponCheckout', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'DisplayUpSellsWhenAddingItemToCart', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EmailTemplateID_ContactUs', N'6b27d327-ef3f-40f4-a09b-a1a9855cbde0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EmailTemplateID_EmailFriend', N'5387b754-f9d0-4225-bf4f-12d68ecee288')
GO
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EmailTemplateID_ForgotPassword', N'3b986faf-4e20-4b79-b1f8-7317ca5cac9b')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableAdvancedSearch', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableBabyRegistry', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableChoiceCombinationsOnCreation', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableReturns', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'EnableWeddingRegistry', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'FacebookOpenGraphEnabled', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ForceEmailAddressOnAnonymousCheckout', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ForceImageSizes', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftCertificateMaximumAmount', N'10000.00')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftCertificateMinimumAmount', N'10.00')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftCertificateValidDays', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftWrapAll', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftWrapCharge', N'0.00')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GiftWrapRate', N'0.00')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSErrorPutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSFailsPutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSNotSupportedPutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleAVSPartialMatchPutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCartMinutes', N'30')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCheckoutButtonBackground', N'Transparent')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCheckoutButtonSize', N'Large')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCurrency', N'USD')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCVNErrorPutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCVNNoMatchPutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleCVNNotAvailablePutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDebugMode', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDefaultShippingAmount', N'1.00')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDefaultShippingType', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleDefaultShippingValues', N'<?xml version="1.0" encoding="utf-16"?><dictionary></dictionary>')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMerchantId', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMerchantKey', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMinimumAccountDaysOld', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleMode', N'Sandbox')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GooglePaymentProtectionEligiblePutHold', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleTrustedStoresBadgeLocation', N'BOTTOM_RIGHT')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleTrustedStoresEnabled', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'GoogleTrustedStoresFeedsLastTimeRun', N'632926151410156250')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HandlingAmount', N'0.00')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HandlingNonShipping', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HandlingType', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HideCartImages', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HideShippingAddressForNonShippingOrders', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HideShippingControlsForNonShippingOrders', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HomepageMetaDescription', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HomepageMetaKeywords', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'HomepageMetaTitle', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ImageBrowserDefaultDirectory', N'Images/')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ImagesMediumHeight', N'220')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ImagesMediumWidth', N'220')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ImagesSmallHeight', N'110')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ImagesSmallWidth', N'110')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryEnabledNewProductDefault', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryLowEmail', N'empty@bvcommerce.com')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryLowHours', N'24')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryLowLastTimeRun', N'635590966310265951')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryLowReportLinePrefix', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryMode', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'InventoryNewProductDefaultMode', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'IsPrivateStore', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ItemAddedToCartText', N'Item has been added to cart.')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'KitDisplayCollapsed', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LastProductsViewedCookieName', N'Bvc5LastProductsViewed')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LastProductsViewedMaxResults', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LicenseData', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsEarnedPerCurrencyUnit', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsEnabled', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsExpire', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsExpireDays', N'90')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsMinimumOrderAmountToEarnPoints', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsMinimumOrderAmountToUsePoints', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsMinimumPointsCurrencyBalanceToUse', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'LoyaltyPointsToCurrencyUnitExchangeRate', N'100')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MailServer', N'localhost')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MailServerPassword', N'aDK6zNYLKBVf1KpDX6b7MA==')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MailServerPort', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MailServerUseAuthentication', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MailServerUsername', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MailServerUseSsl', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MaxVariantCombinations', N'100')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MenuItemsPerRow', N'7')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MergeCartItems', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MessageBoxErrorTestMode', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MetaDescription', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MetaKeywords', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MetaTitleAppendStoreName', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MetricsRecordSearches', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'MoveViewstateToBottomOfPage', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'NewProductBadgeAllowed', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'NewProductBadgeDays', N'30')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'OrderLimitQuantity', N'9999')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'OrderNotificationEmail', N'empty@bvcommerce.com')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'OrderNumberSeed', N'1000')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'OrderNumberStepHigh', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'OrderNumberStepLow', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'OverrideEmptyChoiceNames', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PasswordDefaultEncryption', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PasswordExpirationDays', N'90')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PasswordMinimumLength', N'8')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentCheckDescription', N'Send a check by mail.')
GO
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentCheckName', N'Check')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentCODDescription', N'Cash on Delivery')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentCODName', N'COD')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentCreditCardAuthorizeOnly', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentCreditCardGateway', N'F5EDAC09-4BFC-48f3-BFA0-C1034EE799DD')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentCreditCardRequireCVV', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentMethodsEnabled', N'4A807645-4B9D-43f1-BC07-9F233B4E713C')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentNoPaymentNeededDescription', N'No Payment Needed.')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentPurchaseOrderDescription', N'Purchase Order')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentPurchaseOrderName', N'Purchase Order')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentPurchaseOrderRequirePONumber', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentTelephoneDescription', N'Call us after placing your order to arrange payment.')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaymentTelephoneName', N'Telephone')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalAllowUnconfirmedAddresses', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalCurrency', N'USD')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalExpressAuthorizeOnly', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalExpressCheckoutPage', N'Checkout.aspx')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalMode', N'Sandbox')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalPassword', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalSignature', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PaypalUserName', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'PerformanceAutoLoadProductsList', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductLongDescriptionEditorHeight', N'150')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewAllow', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewCount', N'5')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewEmail', N'empty@bvcommerce.com')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewModerate', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewShow', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewShowKarma', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ProductReviewShowRating', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RedirectorEnabled', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RedirectToCartAfterAddProduct', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RedirectToHomePageOnLogin', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RedirectToPrimaryDomain', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RememberUserPasswords', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RememberUsers', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ReportsDefaultPage', N'Daily Sales')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ReverseOrderNotes', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RMAAcceptedEmailTemplate', N'9ac4f34e-f5de-4b95-ac3b-657380542873')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RMANewEmailTemplate', N'c0cb9492-f4be-4bdb-9ae9-0b14c7bd2cd0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RMARejectedEmailTemplate', N'3f492a3d-a77f-49a7-9b61-4173d4b13ae0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'RowsPerPage', N'10')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisableBlankSearchTerms', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisplayImages', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisplayPrice', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchDisplaySku', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledKeywords', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledLongDescription', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledMetaDescription', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledMetaKeywords', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledMetaTitle', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledProductChoiceCombinations', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledProductName', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledProductTypeName', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledShortDescription', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchEnabledSKU', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchFilterDuplicateItems', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchItemsPerPage', N'20')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchItemsPerRow', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchMaxResults', N'100')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty1', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty10', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty2', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty3', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty4', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty5', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty6', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty7', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty8', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchProperty9', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchRedirectToProductPage', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchShowCategory', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchShowManufacturer', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchShowPrice', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchShowSort', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchShowVendor', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductKeywords', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductLongDescription', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductMetaDescription', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductMetaKeywords', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductMetaTitle', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductName', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductShortDescription', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductSku', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SearchWeightProductTypeName', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SendDropShipNotificationsThroughWebService', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SendProductReviewNotificationEmail', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressRequireCompany', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressRequireFax', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressRequireFirstName', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressRequireLastName', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressRequirePhone', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressRequireWebSiteURL', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressShowCompany', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressShowFax', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressShowMiddleInitial', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressShowPhone', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShipAddressShowWebSiteURL', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_UPS_License', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_UPS_Password', N'')
GO
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_UPS_Pickup_Type', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_UPS_Server', N'https://www.ups.com/ups.app/xml/')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_UPS_Username', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_USPS_Password', N'317UW02RM959')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_USPS_Server', N'http://production.shippingapis.com/ShippingAPI.dll')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'Shipping_USPS_Username', N'643BVSOF1535')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingDimensionCalculator', N'9a1f6916-37ca-4922-99e9-2ab623c7b3c1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExAccountNumber', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExDefaultPackaging', N'7')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExDiagnostics', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExDropOffType', N'4')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExForceResidentialRates', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExMeterNumber', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExServer', N'https://gateway.fedex.com/GatewayDC')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingFedExUseListRates', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUpsAccountNumber', N'')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUpsDefaultPackaging', N'2')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUpsDefaultPayment', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUpsDefaultService', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUPSDiagnostics', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUpsForceResidential', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUpsSkipDimensions', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUSPostalFlatRateBoxCutoff', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ShippingUSPostalFlatRateEnvelopeCutoff', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteCountryBvin', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteCountryCode', N'bf7389a2-9b21-4d33-b276-23c9c18ea0c0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteCultureCode', N'en-US')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteLogo', N'BVModules/Themes/Foundation4 Responsive/images/logo.png')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteMapMaxDepth', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteName', N'My BV Commerce 2015 Store')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteRootsOnDifferentTLDs', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteSecureRoot', N'http://localhost:50424/')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteShippingAddress', N'<Address><Bvin /><NickName /><FirstName /><MiddleInitial /><LastName /><Company>BV Commerce</Company><Line1>5 S Water St</Line1><Line2 /><Line3 /><City>Hummelstown</City><RegionName>PA</RegionName><RegionBvin>64df6892-ff0f-4b64-a958-a48afe3cc94e</RegionBvin><PostalCode>17036</PostalCode><CountryName>United States</CountryName><CountryBvin>bf7389a2-9b21-4d33-b276-23c9c18ea0c0</CountryBvin><Phone>800 999-9999</Phone><Fax /><WebSiteUrl /><CountyName /><CountyBvin /><UserBvin /><Residential>false</Residential><LastUpdated>0001-01-01T00:00:00</LastUpdated></Address>')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteShippingLengthType', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteShippingWeightType', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteShippingWidthType', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SiteStandardRoot', N'http://localhost:50424/')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'StoreAdminLinksInNewWindow', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'StoreClosed', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'StoreClosedDescription', N'<h1>Title</h1>

Our store is currently closed for updates and will return soon. In the meantime you may order by phone at 800-xxx-xxxx.


')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'StoreClosedDescriptionPreTransform', N'<h1>Title</h1>

Our store is currently closed for updates and will return soon. In the meantime you may order by phone at 800-xxx-xxxx.


')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'SuggestedItemsMaxResults', N'3')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'ThemeName', N'Foundation4 Responsive')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'TypePropertiesDisplayEmptyProperties', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UnitTestSetting', N'UnitTestSetting1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UnitTestSetting2', N'UnitTestSetting2a')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UPSRestrictions', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UrlRewriteCategories', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UrlRewriteCategoriesPrefix', N'Departments')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UrlRewriteProducts', N'1')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UrlRewriteProductsPrefix', N'Products')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UserIDCookieName', N'Bvc5UserID')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UserLockoutAttempts', N'10')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UserLockoutMinutes', N'20')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'UseSSL', N'0')
INSERT [dbo].[bvc_WebAppSetting] ([SettingName], [SettingValue]) VALUES (N'WebAppSettingsLoaded', N'1')

exec sp_msforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
exec sp_msforeachtable 'ALTER TABLE ? ENABLE TRIGGER ALL'
