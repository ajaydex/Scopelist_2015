Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

'************************************************************************
'
'  <warning>
'  DO NOT PUT CUSTOM CODE IN THIS FILE, INSTEAD PUT THE CODE INTO
'  TaskLoader.Custom.vb THIS WILL ALLOW US TO MAKE CHANGES TO THIS FILE
'  IN THE FUTURE WITHOUT AFFECTING YOUR CUSTOM CODE. 
'  </warning>
'
'************************************************************************

Partial Public Class TaskLoader

    Public Shared Sub Load()
        ' Plugins        
        Try
            '' Set Seed for Order Number Generator        
            'Try
            '    BVSoftware.Bvc5.Core.Orders.OrderNumberGenerator.LoadSeed()
            'Catch ex As Exception
            '    BVSoftware.Bvc5.Core.EventLog.LogEvent(ex)
            'End Try

            'run any custom loading code (in Taskloader.Custom.vb)
            CustomLoad()

            ' Load Plugins for Workflows
            BVSoftware.Bvc5.Core.BusinessRules.AvailableTasks.ProductTasks = TaskLoader.LoadProductTasks()
            BVSoftware.Bvc5.Core.BusinessRules.AvailableTasks.OrderTasks = TaskLoader.LoadOrderTasks()
            BVSoftware.Bvc5.Core.BusinessRules.AvailableTasks.ShippingTasks = TaskLoader.LoadShippingTasks()

            ' Load Processors for Workflows
            BVSoftware.Bvc5.Core.BusinessRules.AvailableProcessors.OrderTaskProcessors = TaskLoader.LoadOrderTaskProcessors()

            ' Load Payment Methods
            BVSoftware.Bvc5.Core.Payment.AvailablePayments.Methods = TaskLoader.LoadPaymentMethods

            ' Load Credit Card Gateways
            BVSoftware.Bvc5.Core.Payment.AvailableGateways.Gateways = TaskLoader.LoadCreditCardGateways

            ' Load Shipping Providers
            BVSoftware.Bvc5.Core.Shipping.AvailableProviders.Providers = TaskLoader.LoadShippingProviders

            ' Load Dimension Calculator
            BVSoftware.BVC5.Core.Shipping.ShippingGroup.AvailableDimensionCalculators = TaskLoader.LoadPackageDimensionCalculators()

            ' Load Custom Url Rewriting Rules
            BVSoftware.Bvc5.Core.Utilities.UrlRewritingRule.AvailableRules = TaskLoader.LoadUrlRewritingRules()

            ' Load Feeds
            FeedEngine.AvailableFeeds.Feeds = TaskLoader.LoadFeeds()

            ' Load Import/Exports
            ImportExport.AvailableImportExports.Imports = TaskLoader.LoadImports()
            ImportExport.AvailableImportExports.Exports = TaskLoader.LoadExports()

            ' Load Current Sales
            BVSoftware.BVC5.Core.Marketing.SalesManager.LoadCurrentSales()

        Catch ex As Exception
            BVSoftware.Bvc5.Core.EventLog.LogEvent(ex)
        End Try
    End Sub

    Public Shared Function LoadProductTasks() As Collection(Of BusinessRules.ProductTask)
        Dim result As New Collection(Of BusinessRules.ProductTask)

        LoadCustomProductTasks(result)

        result.Add(New BusinessRules.ProductTasks.AppendManufacturerName)
        result.Add(New BusinessRules.ProductTasks.ApplyPriceGroups)
        result.Add(New BusinessRules.ProductTasks.ApplySales)
        result.Add(New BusinessRules.ProductTasks.CheckForPriceBelowCost)
        result.Add(New BusinessRules.ProductTasks.FailPipeline)
        result.Add(New BusinessRules.ProductTasks.InitializeProductPrice)
        result.Add(New BusinessRules.ProductTasks.OverridePriceWithText)

        Return result
    End Function

    Public Shared Function LoadOrderTasks() As Collection(Of BusinessRules.OrderTask)
        Dim result As New Collection(Of BusinessRules.OrderTask)

        LoadCustomOrderTasks(result)

        result.Add(New BusinessRules.OrderTasks.ApplyOffersGreatestDiscount)
        result.Add(New BusinessRules.OrderTasks.ApplyOffersStackedDiscounts)
        result.Add(New BusinessRules.OrderTasks.ApplyProductShippingModifiers)
        result.Add(New BusinessRules.OrderTasks.ApplyMinimumOrderAmount)
        result.Add(New BusinessRules.OrderTasks.ApplyHandling)
        result.Add(New BusinessRules.OrderTasks.ApplyTaxes)
        result.Add(New BusinessRules.OrderTasks.ApplyVolumePricing)
        result.Add(New BusinessRules.OrderTasks.AssignOrderNumber)
        result.Add(New BusinessRules.OrderTasks.AssignOrderToUser)
        result.Add(New BusinessRules.OrderTasks.AvalaraCommitTaxes)
        result.Add(New BusinessRules.OrderTasks.AvalaraCancelTaxesWhenPaymentRemoved)
        result.Add(New BusinessRules.OrderTasks.AvalaraResubmitTaxes)
        result.Add(New BusinessRules.OrderTasks.ChangeOrderStatusWhenPaymentRemoved)
        result.Add(New BusinessRules.OrderTasks.ChangeOrderStatusWhenShipmentRemoved)
        result.Add(New BusinessRules.OrderTasks.CompleteCreditCards)        
        result.Add(New BusinessRules.OrderTasks.DebitGiftCertificates)
        result.Add(New BusinessRules.OrderTasks.DebitLoyaltyPoints)
        result.Add(New BusinessRules.OrderTasks.EmailOrder)
        result.Add(New BusinessRules.OrderTasks.EmailShippingInfo)
        result.Add(New BusinessRules.OrderTasks.IssueGiftCertificates)
        result.Add(New BusinessRules.OrderTasks.LocalFraudCheck)
        result.Add(New BusinessRules.OrderTasks.LogMessage)
        result.Add(New BusinessRules.OrderTasks.MakePlacedOrder)
        result.Add(New BusinessRules.OrderTasks.MarkCompletedWhenShippedAndPaid)
        result.Add(New BusinessRules.OrderTasks.MakeOrderAddressUsersCurrentAddress)
        result.Add(New BusinessRules.OrderTasks.ReceiveCreditCards)
        result.Add(New BusinessRules.OrderTasks.ReceivePaypalExpressPayments)
        result.Add(New BusinessRules.OrderTasks.RequireLoginBeforeCheckout)        
        result.Add(New BusinessRules.OrderTasks.RunAllDropShipWorkflows)
        result.Add(New BusinessRules.OrderTasks.RunShippingCompleteWorkFlow)
        result.Add(New BusinessRules.OrderTasks.SendRMAEmail)
        result.Add(New BusinessRules.OrderTasks.StartPaypalExpressCheckout)
        result.Add(New BusinessRules.OrderTasks.TestCreateErrors)
        result.Add(New BusinessRules.OrderTasks.RunWorkFlowIfPaid)
        result.Add(New BusinessRules.OrderTasks.UpdateLineItemsForSave)
        result.Add(New BusinessRules.OrderTasks.UpdateLoyaltyPoints)
        result.Add(New BusinessRules.OrderTasks.UpdateOrder)

        result.Add(New BusinessRules.OrderTasks.CredExCheckCredit)
        result.Add(New BusinessRules.OrderTasks.CredExStart)


        Return result
    End Function

    Public Shared Function LoadShippingTasks() As Collection(Of BusinessRules.ShippingTask)
        Dim result As New Collection(Of BusinessRules.ShippingTask)

        LoadCustomShippingTasks(result)

        result.Add(New BusinessRules.ShippingTasks.ApplyShippingDiscounts)
        result.Add(New BusinessRules.ShippingTasks.ApplyProductShippingModifiers)

        Return result
    End Function

    Public Shared Function LoadOrderTaskProcessors() As Collection(Of ProcessorComponentPair)
        Dim result As New Collection(Of ProcessorComponentPair)

        LoadCustomOrderTaskProcessors(result)

        result.Add(New ProcessorComponentPair("Order Total", GetType(Marketing.OrderTotalOfferTaskProcessor)))
        result.Add(New ProcessorComponentPair("Product(s)", GetType(Marketing.ProductsOfferTaskProcessor)))
        result.Add(New ProcessorComponentPair("Shipping", GetType(Marketing.ShippingOfferTaskProcessor)))
        result.Add(New ProcessorComponentPair("Free Shipping", GetType(Marketing.FreeShippingOfferTaskProcessor)))
        result.Add(New ProcessorComponentPair("Buy One Get One", GetType(Marketing.BuyOneGetOneOfferTaskProcessor)))
        result.Add(New ProcessorComponentPair("Buy X Get Y", GetType(Marketing.BuyXGetYOfferTaskProcessor)))        
        result.Add(New ProcessorComponentPair("Free Shipping Excluding Categories", GetType(Marketing.Offers.FreeShippingByCategory)))
        result.Add(New ProcessorComponentPair("Buy X get Y By Category", GetType(Marketing.Offers.BuyXGetYByCategory)))
        result.Add(New ProcessorComponentPair("Free Promo Item", GetType(Marketing.Offers.FreePromoItem)))
        result.Add(New ProcessorComponentPair("Free Promo Item by Amount", GetType(Marketing.Offers.FreePromoItemByAmount)))
        result.Add(New ProcessorComponentPair("Free Shipping on Products", GetType(Marketing.Offers.FreeShippingProducts)))
        result.Add(New ProcessorComponentPair("Products By Category", GetType(Marketing.Offers.ProductsByCategory)))
        result.Add(New ProcessorComponentPair("Product(s) Fixed Price", GetType(Marketing.Offers.ProductsFixedPrice)))
        Return result
    End Function

    Public Shared Function LoadPaymentMethods() As Collection(Of Payment.PaymentMethod)
        Dim result As New Collection(Of Payment.PaymentMethod)

        LoadCustomPaymentMethods(result)

        result.Add(New Payment.Method.CreditCard)
        result.Add(New Payment.Method.PurchaseOrder)
        result.Add(New Payment.Method.Check)
        result.Add(New Payment.Method.Cash)
        result.Add(New Payment.Method.Telephone)
        result.Add(New Payment.Method.CashOnDelivery)
        result.Add(New Payment.Method.GiftCertificate)
        result.Add(New Payment.Method.PaypalExpress)
        result.Add(New Payment.Method.Offline)
        result.Add(New Payment.Method.CredEx)
        result.Add(New Payment.Method.LoyaltyPoints)

        Return result
    End Function

    Public Shared Function LoadCreditCardGateways() As Collection(Of Payment.CreditCardGateway)
        Dim result As New Collection(Of Payment.CreditCardGateway)

        LoadCustomCreditCardGateways(result)

        result.Add(New BVSoftware.BVC5.Payment.AuthorizeNet.AuthorizeNetProvider)
        result.Add(New BVSoftware.Bvc5.Payment.ACHDirect.ACHDirectProvider)
        result.Add(New Payment.Gateways.BVTestGateway)
        result.Add(New Payment.Gateways.ManualGateway)

        result.Add(New BVSoftware.Bvc5.Payment.EcLinx3DSI)
        result.Add(New BVSoftware.Bvc5.Payment.BankOfAmerica)
        result.Add(New BVSoftware.Bvc5.Payment.ConcordEFSNet)
        result.Add(New BVSoftware.Bvc5.Payment.CyberSource)
        result.Add(New BVSoftware.Bvc5.Payment.ECHOnline)
        result.Add(New BVSoftware.Bvc5.Payment.ECX)
        result.Add(New BVSoftware.Bvc5.Payment.eProcessing)
        result.Add(New BVSoftware.Bvc5.Payment.FastTransact)
        result.Add(New BVSoftware.Bvc5.Payment.FirstDataGlobalGateway)
        result.Add(New BVSoftware.Bvc5.Payment.GoRealTime)
        result.Add(New BVSoftware.Bvc5.Payment.iBill)
        result.Add(New BVSoftware.Bvc5.Payment.Innovative)
        result.Add(New BVSoftware.Bvc5.Payment.Intellipay)
        result.Add(New BVSoftware.Bvc5.Payment.iTransact)
        result.Add(New BVSoftware.Bvc5.Payment.LinkPointAPI)
        result.Add(New BVSoftware.Bvc5.Payment.MerchantAnywhere)
        result.Add(New BVSoftware.Bvc5.Payment.Moneris)
        result.Add(New BVSoftware.Bvc5.Payment.MPCS)
        result.Add(New BVSoftware.Bvc5.Payment.NetBilling)
        result.Add(New BVSoftware.Bvc5.Payment.NetworkMerchants)
        result.Add(New BVSoftware.Bvc5.Payment.NovaViaKlix)
        result.Add(New BVSoftware.Bvc5.Payment.PayFlowLink)
        result.Add(New BVSoftware.Bvc5.Payment.PayFlowPro)
        result.Add(New BVSoftware.Bvc5.Payment.PayFuse)
        result.Add(New BVSoftware.Bvc5.Payment.PaymentechOrbital)
        result.Add(New BVSoftware.Bvc5.Payment.PaypalProGateway)
        result.Add(New BVSoftware.Bvc5.Payment.PlanetPayment)
        result.Add(New BVSoftware.Bvc5.Payment.PlugnPay)
        result.Add(New BVSoftware.Bvc5.Payment.PRIGate)
        result.Add(New BVSoftware.Bvc5.Payment.Protx)
        result.Add(New BVSoftware.BVC5.Payment.PsiGateXML)
        result.Add(New BVSoftware.BVC5.Payment.QBMS)
        result.Add(New BVSoftware.Bvc5.Payment.RTWare)
        result.Add(New BVSoftware.Bvc5.Payment.SkipJack)
        result.Add(New BVSoftware.Bvc5.Payment.TrustCommerce)
        result.Add(New BVSoftware.Bvc5.Payment.USAePay)
        result.Add(New BVSoftware.Bvc5.Payment.WorldPay)

        Return result
    End Function

    Public Shared Function LoadShippingProviders() As Collection(Of Shipping.ShippingProvider)
        Dim result As New Collection(Of Shipping.ShippingProvider)

        LoadCustomShippingProviders(result)

        'result.Add(New BVSoftware.Bvc5.Core.Shipping.Provider.NullProvider)
        result.Add(New BVSoftware.Bvc5.Core.Shipping.Provider.ByItemCount)
        result.Add(New BVSoftware.BVC5.Core.Shipping.Provider.ByOrderTotal)
        result.Add(New BVSoftware.BVC5.Core.Shipping.Provider.ByOrderTotalMixed)
        result.Add(New BVSoftware.Bvc5.Core.Shipping.Provider.ByWeight)
        result.Add(New BVSoftware.Bvc5.Core.Shipping.Provider.PerItem)
        result.Add(New BVSoftware.Bvc5.Core.Shipping.Provider.PerOrder)
        result.Add(New BVSoftware.Bvc5.Shipping.FedEx.FedExProvider)
        result.Add(New BVSoftware.Bvc5.Shipping.Ups.UpsProvider)
        result.Add(New BVSoftware.Bvc5.Shipping.USPostal.USPostalProvider)
        result.Add(New BVSoftware.Bvc5.Shipping.DHL.DHLProvider)
        result.Add(New StructuredSolutions.Bvc5.Shipping.Providers.WrapperProvider())
        result.Add(New StructuredSolutions.Bvc5.Shipping.Providers.PackageRuleProvider())
        result.Add(New StructuredSolutions.Bvc5.Shipping.Providers.OrderRuleProvider())

        Return result
    End Function

    Public Shared Function LoadPackageDimensionCalculators() As Collection(Of Shipping.DimensionCalculator)
        Dim result As New Collection(Of Shipping.DimensionCalculator)

        LoadCustomPackageDimensionCalculators(result)

        'result.Add(New Shipping.DefaultDimensionCalculator())
        result.Add(New StructuredSolutions.Bvc5.Shipping.ExtendedDimensionalCalculator())
        result.Add(New StructuredSolutions.Bvc5.Shipping.ExtendedBoxingDimensionCalculator())
        'result.Add(New Shipping.BoxingDimensionCalculator())

        Return result
    End Function

    Public Shared Function LoadUrlRewritingRules() As Collection(Of Utilities.UrlRewritingRule)
        Dim result As New Collection(Of Utilities.UrlRewritingRule)()

        LoadCustomUrlRewritingRules(result)

        result.Add(New PreventUrlPrefixConflicts())

        Return result
    End Function

    Public Shared Function LoadFeeds() As Collection(Of FeedEngine.BaseFeed)
        Dim result As New Collection(Of FeedEngine.BaseFeed)()

        LoadCustomFeeds(result)

        ' Product feeds
        result.Add(New FeedEngine.Products.BingShopping())
        result.Add(New FeedEngine.Products.ChannelAdvisor())
        result.Add(New FeedEngine.Products.CommissionJunction())
        result.Add(New FeedEngine.Products.GoogleShopping())
        result.Add(New FeedEngine.Products.PriceGrabber())
        result.Add(New FeedEngine.Products.TheFind())

        ' Transaction feeds
        'result.Add(New FeedEngine.Transactions.GoogleTrustedStoresCancellation())
        'result.Add(New FeedEngine.Transactions.GoogleTrustedStoresShipment())
        result.Add(New FeedEngine.Transactions.THub())

        ' Sitemap feeds
        result.Add(New FeedEngine.Sitemaps.GoogleSitemap())

        Return result
    End Function

    Public Shared Function LoadExports() As Collection(Of ImportExport.BaseExport)
        Dim result As New Collection(Of ImportExport.BaseExport)()

        LoadCustomExports(result)

        result.Add(New ImportExport.CatalogData.CategoryExport())
        result.Add(New ImportExport.CatalogData.ProductExport())
        result.Add(New ImportExport.CatalogData.ProductCategoryExport())
        result.Add(New ImportExport.CatalogData.ProductInventoryExport())
        result.Add(New ImportExport.ContactsData.AffiliateExport())
        result.Add(New ImportExport.ContactsData.ManufacturerExport())
        result.Add(New ImportExport.ContactsData.VendorExport())
        result.Add(New ImportExport.ContentData.CustomPageExport())
        result.Add(New ImportExport.ContentData.CustomUrlExport())
        result.Add(New ImportExport.ContentData.UrlRedirectExport())
        result.Add(New ImportExport.MembershipData.UserAccountExport())
        result.Add(New ImportExport.OrdersData.OrderExport())

        Return result
    End Function

    Public Shared Function LoadImports() As Collection(Of ImportExport.BaseImport)
        Dim result As New Collection(Of ImportExport.BaseImport)()

        LoadCustomImports(result)

        result.Add(New ImportExport.CatalogData.CategoryImport())
        result.Add(New ImportExport.CatalogData.ProductImport())
        result.Add(New ImportExport.CatalogData.ProductCategoryImport())
        result.Add(New ImportExport.CatalogData.ProductInventoryImport())
        result.Add(New ImportExport.ContactsData.AffiliateImport())
        result.Add(New ImportExport.ContactsData.ManufacturerImport())
        result.Add(New ImportExport.ContactsData.VendorImport())
        result.Add(New ImportExport.ContentData.CustomPageImport())
        result.Add(New ImportExport.ContentData.CustomUrlImport())
        result.Add(New ImportExport.ContentData.UrlRedirectImport())

        Return result
    End Function

    Public Shared Function Brand() As BVSoftware.Commerce.Branding.IBVBranding
        Return New BVSoftware.Commerce.Branding.Default()
    End Function

End Class