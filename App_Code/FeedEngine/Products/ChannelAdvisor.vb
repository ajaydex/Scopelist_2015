Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Products

    Public Class ChannelAdvisor
        Inherits BaseProductFeed

        Private Const COMPONENTID As String = "10CFCCBF-CDE0-4f32-B158-707EAAD67236"

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Channel Advisor"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "channeladvisor.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_HOSTNAME() As String
            Get
                Return "partner.channeladvisor.com"
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddRow( _
                "Model", _
                "Manufacturer", _
                "ManufacturerModel", _
                "MPN", _
                "MerchantCategory", _
                "Brand", _
                "RegularPrice", _
                "CurrentPrice", _
                "InStock", _
                "ReferenceImageURL", _
                "OfferName", _
                "OfferDescription", _
                "ActionURL")
        End Sub

        Protected Overrides Sub AddProductRow(ByRef p As BVSoftware.BVC5.Core.Catalog.Product)
            Dim manufacturerName As String = Me.GetProductManufacturer(p)

            ' Model
            AddColumn(p.Sku)

            ' Manufacturer
            AddColumn(manufacturerName)

            ' ManufacturerModel
            AddColumn(p.Sku)

            ' MPN
            AddColumn(p.Sku)

            ' MerchantCategory
            'AddColumn(Me.GetProductCategoryBreadcrumb(p))
            AddColumn(Me.GetProductType(p))

            ' Brand
            AddColumn(manufacturerName)

            ' RegularPrice
            AddColumn(p.ListPrice.ToString("0.00"))

            ' CurrentPrice
            AddColumn(Me.GetProductPrice(p))

            ' InStock
            AddColumn(System.Convert.ToInt32(p.IsInStock).ToString())

            ' ReferenceImageURL
            AddColumn(Me.CreateProductImageUrl(p))

            ' OfferName
            AddColumn(p.ProductName)

            ' OfferDescription
            AddColumn(p.LongDescription)

            ' ActionURL
            AddColumn(Me.CreateProductUrl(p))
        End Sub

    End Class

End Namespace