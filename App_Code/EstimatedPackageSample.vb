Imports Microsoft.VisualBasic
Imports BVSoftware.BVC5.Core
Imports System.Collections.ObjectModel

Public Class EstimatedPackageSample
    Inherits BVSoftware.Bvc5.Core.Shipping.ShippingProvider


    Protected Overloads Overrides Function GetRates(ByVal o As BVSoftware.Bvc5.Core.Orders.Order, ByVal m As BVSoftware.Bvc5.Core.Shipping.ShippingMethod) As System.Collections.ObjectModel.Collection(Of BVSoftware.Bvc5.Core.Shipping.ShippingRate)
        Return GetRates(o.GetShippingGroups, m)
    End Function

    Protected Overloads Overrides Function GetRates(ByVal g As System.Collections.ObjectModel.Collection(Of BVSoftware.Bvc5.Core.Shipping.ShippingGroup), ByVal m As BVSoftware.Bvc5.Core.Shipping.ShippingMethod) As System.Collections.ObjectModel.Collection(Of BVSoftware.Bvc5.Core.Shipping.ShippingRate)
        Dim result As New Collection(Of BVSoftware.Bvc5.Core.Shipping.ShippingRate)

        If g.Count > 0 Then

            Dim amount As Decimal = 99.99D
            Dim suggestedPackages As New Collection(Of BVSoftware.Bvc5.Core.Shipping.Package)

            Dim myPackage As New Shipping.Package
            myPackage.Description = "Sample Estimated Package"
            myPackage.EstimatedShippingCost = amount
            myPackage.HasShipped = False
            myPackage.Height = g(0).Height
            For Each li As Orders.LineItem In g(0).Items
                myPackage.Items.Add(New Shipping.PackageItem(li.ProductId, li.Bvin, li.Quantity))
            Next
            myPackage.Length = g(0).Length
            If g(0).Items.Count > 0 Then
                myPackage.OrderId = g(0).Items(0).OrderBvin
            End If
            myPackage.ShippingProviderId = Me.ProviderId
            myPackage.ShippingProviderServiceCode = ""
            myPackage.SizeUnits = Shipping.LengthType.Inches
            myPackage.Weight = g(0).Weight
            myPackage.WeightUnits = Shipping.WeightType.Pounds
            myPackage.Width = g(0).Width

            suggestedPackages.Add(myPackage)

            result.Add(New BVSoftware.Bvc5.Core.Shipping.ShippingRate(Me.Name, Me.ProviderId, "", amount, m.Bvin, suggestedPackages, "Sample Provider Only"))

        End If

        Return result
    End Function

    Public Overrides Function GetTrackingUrl(ByVal trackingCode As String) As String
        Return String.Empty
    End Function

    Public Overrides ReadOnly Property Name() As String
        Get
            Return "EstimatedPackageSample"
        End Get
    End Property

    Public Overrides ReadOnly Property ProviderId() As String
        Get
            Return "6649F336-D1DA-4c30-B048-8AA7DADB4B4F"
        End Get
    End Property

    Public Overrides ReadOnly Property RequiresPostalCode(ByVal shippingMethodId As String) As Boolean
        Get
            Return False
        End Get
    End Property

    Public Overrides ReadOnly Property RequiresCity(ByVal shippingMethodId As String) As Boolean
        Get
            Return False
        End Get
    End Property

    Public Overrides ReadOnly Property RequiresState(ByVal shippingMethodId As String) As Boolean
        Get
            Return False
        End Get
    End Property

    Public Overrides ReadOnly Property SupportsTracking() As Boolean
        Get
            Return False
        End Get
    End Property

    Public Overrides Function GetSelectedShippingNames(ByVal method As BVSoftware.Bvc5.Core.Shipping.ShippingMethod) As System.Collections.ObjectModel.Collection(Of String)
        Dim result As New Collection(Of String)()
        result.Add(method.Name)
        Return result
    End Function
End Class