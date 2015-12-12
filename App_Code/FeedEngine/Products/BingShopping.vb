Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Products

    Public Class BingShopping
        Inherits BaseProductFeed

        Private Const COMPONENTID As String = "61B85FD9-4F45-408A-9046-25151815A0F0"

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDWRAPCHARACTER As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME As String
            Get
                Return "Bing Shopping"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME As String
            Get
                Return "bingshopping.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_HOSTNAME As String
            Get
                Return "feeds.adcenter.microsoft.com"
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddRow( _
                "MerchantProductID", _
                "Title", _
                "Brand", _
                "MPN", _
                "UPC", _
                "ISBN", _
                "SKU", _
                "ProductURL", _
                "Price", _
                "Availability", _
                "Description", _
                "ImageURL", _
                "Shipping", _
                "MerchantCategory", _
                "ShippingWeight", _
                "Condition", _
                "B_Category")
        End Sub

        Protected Overrides Sub AddProductRow(ByRef p As BVSoftware.BVC5.Core.Catalog.Product)
            ' MerchantProductID
            AddColumn(p.Bvin)

            ' Title
            AddColumn(p.ProductName, 255)

            ' Brand
            AddColumn(GetProductManufacturer(p), 255)

            ' MPN
            AddColumn(p.Sku, 255)

            ' UPC
            AddColumn(String.Empty, 12)

            ' ISBN
            AddColumn(String.Empty, 13)

            ' SKU
            AddColumn(p.Sku, 255)

            ' ProductURL
            AddColumn(Me.CreateProductUrl(p), 2000)

            ' Price
            AddColumn(Me.GetProductPrice(p))

            ' Availability
            If p.IsInStock Then
                AddColumn("In Stock", 15)
            Else
                If p.IsBackordered Then
                    AddColumn("Back-Order", 15)
                Else
                    AddColumn("Out of Stock", 15)
                End If
            End If

            ' Description
            AddColumn(p.LongDescription, 5000)

            ' ImageURL
            AddColumn(Me.CreateProductImageUrl(p), 1000)

            ' Shipping
            AddColumn(String.Empty)

            ' MerchantCategory
            AddColumn(Me.GetProductCategoryBreadcrumb(p), 255)

            ' ShippingWeight
            AddColumn(p.ShippingWeight.ToString("0.00"))

            ' Condition
            AddColumn("New", 15)

            ' B_Category
            AddColumn(String.Empty)
        End Sub

    End Class

End Namespace