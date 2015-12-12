Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Public Class TaskLoader

    Public Shared Sub CustomLoad()

    End Sub

    Public Shared Sub LoadCustomProductTasks(ByVal result As Collection(Of BusinessRules.ProductTask))

    End Sub

    Public Shared Sub LoadCustomOrderTasks(ByVal result As Collection(Of BusinessRules.OrderTask))
        result.Add(New BusinessRules.OrderTasks.UpdateListItems)
    End Sub

    Public Shared Sub LoadCustomShippingTasks(ByVal result As Collection(Of BusinessRules.ShippingTask))

    End Sub

    Public Shared Sub LoadCustomOrderTaskProcessors(ByVal result As Collection(Of ProcessorComponentPair))

    End Sub

    Public Shared Sub LoadCustomPaymentMethods(ByVal result As Collection(Of Payment.PaymentMethod))

    End Sub

    Public Shared Sub LoadCustomCreditCardGateways(ByVal result As Collection(Of Payment.CreditCardGateway))

    End Sub

    Public Shared Sub LoadCustomShippingProviders(ByVal result As Collection(Of Shipping.ShippingProvider))

    End Sub

    Public Shared Sub LoadCustomPackageDimensionCalculators(result As Collection(Of Shipping.DimensionCalculator))

    End Sub

    Public Shared Sub LoadCustomFeeds(ByVal result As Collection(Of FeedEngine.BaseFeed))

    End Sub

    Public Shared Sub LoadCustomExports(ByVal result As Collection(Of ImportExport.BaseExport))

    End Sub

    Public Shared Sub LoadCustomImports(ByVal result As Collection(Of ImportExport.BaseImport))

    End Sub

    Public Shared Sub LoadCustomUrlRewritingRules(ByVal result As Collection(Of Utilities.UrlRewritingRule))

    End Sub

End Class