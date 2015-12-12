Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Products

    Public Class PriceGrabber
        Inherits BaseProductFeed

        Private Const COMPONENTID As String = "700D90DE-62FE-4BFB-B496-C3C53305725A"

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDWRAPCHARACTER As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Price Grabber"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "pricegrabber.txt"
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddRow( _
                "Retsku", _
                "Product Title", _
                "DetailedDescription", _
                "Categorization", _
                "Product Url", _
                "Primary Image URL", _
                "Alternate Image URL 1", _
                "Alternate Image URL 2", _
                "Alternate Image URL 3", _
                "Alternate Image URL 4", _
                "Alternate Image URL 5", _
                "Alternate Image URL 6", _
                "Alternate Image URL 7", _
                "Alternate Image URL 8", _
                "Selling Price", _
                "Regular Price", _
                "Condition", _
                "Manufacturer Name", _
                "Manufacturer Part Number", _
                "Availability", _
                "UPC/EAN", _
                "ISBN", _
                "Availability", _
                "On Sale", _
                "Video URL", _
                "Color", _
                "Size", _
                "Material", _
                "Gender", _
                "Shipping Cost", _
                "Weight", _
                "")
        End Sub

        Protected Overrides Sub AddProductRow(ByRef p As BVSoftware.BVC5.Core.Catalog.Product)
            Dim manufacturerName As String = Me.GetProductManufacturer(p)

            ' Retsku
            AddColumn(p.Sku)

            ' Product Title
            If p.ProductName.StartsWith(manufacturerName + " ", StringComparison.InvariantCultureIgnoreCase) Then
                AddColumn(p.ProductName.Substring(manufacturerName.Length + 1), 100)
            Else
                AddColumn(p.ProductName, 100)
            End If

            ' DetailedDescription
            AddColumn(p.LongDescription, 1500)

            ' Categorization
            AddColumn(GetProductCategoryBreadcrumb(p))

            ' Product Url
            AddColumn(Me.CreateProductUrl(p))

            ' Primary Image URL
            AddColumn(Me.CreateProductImageUrl(p))

            ' Alternate Image URL 1 - 8
            Dim images As Collection(Of Catalog.ProductImage) = Catalog.ProductImage.FindByProductId(p.Bvin)
            For i As Integer = 0 To 7
                If images.Count > i Then
                    AddColumn(Me.CreateFullyQualifiedUrl(images(i).FileName))
                Else
                    AddColumn(String.Empty)
                End If
            Next

            ' Selling Price
            Dim salePrice As String = Me.GetProductPrice(p)
            AddColumn(salePrice)

            ' Regular Price'
            AddColumn(p.ListPrice.ToString("0.00"))

            ' Condition (New, Like New, Generic, Refurbished, Used)
            AddColumn("New")

            ' Manufacturer Name
            AddColumn(manufacturerName)

            ' Manufacturer Part Number
            AddColumn(String.Empty)

            ' Availability (Yes, No, Pre-Order)
            AddColumn(Me.ConvertBooleanToYesOrNo(p.IsInStock))

            ' UPC/EAN
            AddColumn(String.Empty)

            ' ISBN
            AddColumn(String.Empty)

            ' Availability
            If p.IsInStock Then
                AddColumn("Yes")
            Else
                If p.IsBackordered Then
                    AddColumn("Preorder")
                Else
                    AddColumn("No")
                End If
            End If

            ' On Sale
            Dim isOnSale As Boolean = (Decimal.Parse(salePrice) < p.SitePrice)
            AddColumn(Me.ConvertBooleanToYesOrNo(isOnSale))

            ' Video URL
            AddColumn(String.Empty)

            ' Color
            AddColumn(String.Empty)

            ' Size
            AddColumn(String.Empty)

            ' Material
            AddColumn(String.Empty)

            ' Gender
            AddColumn(String.Empty)

            ' Shipping Cost
            AddColumn(String.Empty)

            ' Weight
            If p.ShippingWeight > 0 Then
                AddColumn(p.ShippingWeight.ToString("0.##"))
            Else
                AddColumn(String.Empty)
            End If
        End Sub
    End Class

End Namespace