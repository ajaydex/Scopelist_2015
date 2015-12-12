Imports System.Collections.ObjectModel
Imports System.Data
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Products

    Public Class TheFind
        Inherits BaseProductFeed

        Private Const COMPONENTID As String = "7EE98412-9AE1-43B0-AA0F-F302DABDC194"

        Private hotOrNotCount As Integer = 0
        Private productSales As Hashtable

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "The Find"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME As String
            Get
                Return "thefind.txt"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_HOSTNAME As String
            Get
                Return "ftp.thefind.com"
            End Get
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)
        End Sub

        Public Overrides Sub GenerateFeed()
            ' catches "Cannot find Table 0" error in FindTotalProductsOrdered method caused by SQL Server query time out
            Try
                ' get product sales data for the past 90 days - used for "Hot or Not" and "Ordinal Sales rank"
                Dim dt As DataTable = Catalog.InternalProduct.FindTotalProductsOrdered(DateTime.Today.AddDays(-90), DateTime.Today)
                productSales = New Hashtable(dt.Rows.Count)
                For i As Integer = 0 To dt.Rows.Count - 1
                    ' store sales rank (not qty sold)
                    productSales.Add(dt.Rows(i)("bvin"), i + 1)
                Next
                dt = Nothing
            Catch ex As Exception
                productSales = New Hashtable()
            End Try

            MyBase.GenerateFeed()

            ' memory cleanup - clear large in-memory objects
            productSales = Nothing
        End Sub


        Protected Overrides Sub AddHeaderRow()
            AddRow( _
                "Title", _
                "Description", _
                "Image_Link", _
                "Page_URL", _
                "Price", _
                "SKU", _
                "UPC-EAN", _
                "MPN", _
                "ISBN", _
                "Unique_ID", _
                "Sale", _
                "Sale_Price", _
                "Shipping Cost", _
                "Free Shipping", _
                "Online_Only", _
                "Stock_Quantity", _
                "User_Rating", _
                "User_Review_Link", _
                "Brand", _
                "Categories", _
                "Condition", _
                "Model_Number", _
                "Similar_To", _
                "Tags-Keywords", _
                "Weight", _
                "Hot or Not", _
                "Ordinal Sales rank")
        End Sub

        Protected Overrides Sub AddProductRow(ByRef p As BVSoftware.BVC5.Core.Catalog.Product)
            ' Title
            AddColumn(p.ProductName)

            ' Description
            AddColumn(p.LongDescription)

            ' Image_Link
            Dim image_link As String = Me.CreateProductImageUrl(p)
            If Not String.IsNullOrEmpty(image_link) Then
                AddColumn(image_link)
            Else
                AddColumn("no image")
            End If

            ' Page_URL
            AddColumn(Me.CreateProductUrl(p))

            ' Price
            AddColumn(p.SitePrice.ToString("0.00"))

            ' SKU
            AddColumn(p.Sku)

            ' UPC-EAN
            AddColumn(String.Empty)

            ' MPN
            AddColumn(String.Empty)

            ' ISBN
            AddColumn(String.Empty)

            ' Unique_ID
            AddColumn(p.Bvin)

            ' Sale and Sale_Price
            Dim salePrice As Decimal = Me.GetProductPrice(p)
            Dim isOnSale As Boolean = (salePrice < p.SitePrice)
            If isOnSale Then
                AddColumn("Yes")
                AddColumn(salePrice.ToString("0.00"))
            Else
                AddColumn(String.Empty)
                AddColumn(String.Empty)
            End If

            ' Shipping Cost
            AddColumn(String.Empty)

            ' Free Shipping
            AddColumn(String.Empty)

            ' Online_Only
            If p.ShippingMode = Shipping.ShippingMode.ShipFromSite Then
                AddColumn("No")
            Else
                AddColumn("Yes")
            End If

            ' Stock_Quantity
            AddColumn(Me.GetProductInventory(p))

            ' User_Rating and User_Review_Link
            Dim rating As Integer = Catalog.ProductReview.CalculateReviewAverage(p.Bvin)
            If rating > 0 Then
                AddColumn(rating)
                AddColumn(Me.CreateProductUrl(p) + "#ProductReviewList")
            Else
                AddColumn(String.Empty)
                AddColumn(String.Empty)
            End If

            ' Brand
            AddColumn(Me.GetProductManufacturer(p))

            ' Categories
            'AddColumn(Me.GetProductType(p))
            AddColumn(Me.GetProductCategoryBreadcrumb(p))

            ' Condition
            AddColumn("new")

            ' Model_Number
            AddColumn(String.Empty)

            ' Similar_To
            AddColumn(getProductSimilarSkus(p, 10))

            ' Tags-Keywords
            AddColumn(Me.GetProductKeywords(p, " ", Integer.MaxValue, 10))

            ' Weight
            If p.ShippingWeight > 0 Then
                AddColumn(p.ShippingWeight.ToString("0.##"))
            Else
                AddColumn(String.Empty)
            End If

            ' Hot or Not
            If hotOrNotCount < (0.05 * Me.Products.Count) AndAlso _
                (p.IsNew OrElse productSales.ContainsKey(p.Bvin)) Then
                AddColumn("1")
                hotOrNotCount += 1
            Else
                AddColumn("0")
            End If

            ' Ordinal Sales rank
            If productSales.ContainsKey(p.Bvin) Then
                AddColumn(productSales(p.Bvin).ToString())
            Else
                AddColumn(String.Empty)
            End If
        End Sub

        Protected Overridable Function getProductSimilarSkus(ByRef p As Catalog.Product, ByVal maxItems As Integer) As String
            Dim result As New StringBuilder()

            Dim similarSkus As New Collection(Of String)

            ' start with the UpSells
            Dim upSells As Collection(Of Catalog.ProductUpSell) = Catalog.ProductUpSell.FindByProductBvin(p.Bvin)
            For Each upSell As Catalog.ProductUpSell In upSells
                Dim pUpSell As Catalog.Product = Catalog.InternalProduct.FindByBvin(upSell.ProductBvin)
                If pUpSell IsNot Nothing AndAlso Not String.IsNullOrEmpty(pUpSell.Bvin) Then
                    similarSkus.Add(pUpSell.Sku)

                    If similarSkus.Count = maxItems Then
                        Exit For
                    End If
                End If
            Next

            ' if we don't have enough items, add the CrossSells
            If similarSkus.Count < maxItems Then
                Dim crossSells As Collection(Of Catalog.ProductCrossSell) = Catalog.ProductCrossSell.FindByProductBvin(p.Bvin)
                For Each crossSell As Catalog.ProductCrossSell In crossSells
                    Dim pCrossSell As Catalog.Product = Catalog.InternalProduct.FindByBvin(crossSell.ProductBvin)
                    If pCrossSell IsNot Nothing AndAlso Not String.IsNullOrEmpty(pCrossSell.Bvin) Then
                        similarSkus.Add(pCrossSell.Sku)

                        If similarSkus.Count = maxItems Then
                            Exit For
                        End If
                    End If
                Next
            End If

            For Each sku As String In similarSkus
                result.AppendFormat("{0} ", sku)
            Next
            Return result.ToString().Trim()
        End Function

    End Class

End Namespace