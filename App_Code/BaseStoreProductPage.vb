Imports System.Linq
Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Public MustInherit Class BaseStoreProductPage
    Inherits BaseStorePage

    Private _LocalProduct As New Catalog.Product()
    Private _LocalParentProdct As Catalog.Product = Nothing
    Private _ModuleProductQuantity As Integer = 1
    Private _errorMessage As IMessageBox = Nothing

    Public Property LocalProduct() As Catalog.Product
        Get
            Return _LocalProduct
        End Get
        Set(ByVal value As Catalog.Product)
            _LocalProduct = value
        End Set
    End Property
    Public ReadOnly Property LocalParentProduct() As Catalog.Product
        Get
            If _LocalParentProdct Is Nothing OrElse String.IsNullOrEmpty(_LocalParentProdct.Bvin) Then
                If LocalProduct IsNot Nothing Then
                    If String.IsNullOrEmpty(LocalProduct.ParentId) Then
                        _LocalParentProdct = LocalProduct
                    Else
                        _LocalParentProdct = Catalog.InternalProduct.FindByBvin(LocalProduct.ParentId)
                    End If
                End If
            End If

            Return _LocalParentProdct
        End Get
    End Property
    Public Property ModuleProductQuantity() As Integer
        Get
            Return _ModuleProductQuantity
        End Get
        Set(ByVal value As Integer)
            _ModuleProductQuantity = value
        End Set
    End Property

    Public Property MessageBox() As IMessageBox
        Get
            Return _errorMessage
        End Get
        Set(ByVal value As IMessageBox)
            _errorMessage = value
        End Set
    End Property

    Public Overrides ReadOnly Property DisplaysActiveCategoryTab() As Boolean
        Get
            Return True
        End Get
    End Property

    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init        
        If Request.QueryString("productid") IsNot Nothing Then
            If Request.QueryString("productid").Length > 36 Then
                Throw New ApplicationException("Invalid product id length.")
            End If
            _LocalProduct = Catalog.InternalProduct.FindByBvin(Request.QueryString("productid"))
            If _LocalProduct Is Nothing Then
                Utilities.UrlRewriter.RedirectToErrorPage(BVSoftware.Bvc5.Core.ErrorTypes.Product, Response)
            ElseIf _LocalProduct.Status = Catalog.ProductStatus.Disabled Then
                Utilities.UrlRewriter.RedirectToErrorPage(BVSoftware.Bvc5.Core.ErrorTypes.Product, Response)
            End If
        Else
            Utilities.UrlRewriter.RedirectToErrorPage(BVSoftware.Bvc5.Core.ErrorTypes.Product, Response)
        End If
    End Sub

    Public MustOverride Sub PopulateProductInfo(ByVal IsValidCombination As Boolean)

    Protected Overrides Sub LoadCanonicalUrl()
        Me.CanonicalUrl = Utilities.UrlRewriter.ResolveServerUrl(Me.LocalProduct.ProductURL)
    End Sub

    Protected Overrides Sub LoadFacebookOpenGraph()
        MyBase.LoadFacebookOpenGraph()

        If Me.LocalProduct IsNot Nothing Then
            ' Url
            Me.FbOpenGraph.Url = Me.CanonicalUrl

            ' Title
            Me.FbOpenGraph.Title = Me.LocalProduct.ProductName

            ' PageType
            Me.FbOpenGraph.PageType = "product"

            ' Description
            If String.IsNullOrEmpty(Me.FbOpenGraph.Description) Then
                If Not String.IsNullOrEmpty(Me.LocalProduct.MetaDescription) Then
                    Me.FbOpenGraph.Description = Me.LocalProduct.MetaDescription
                ElseIf Not String.IsNullOrEmpty(Me.LocalProduct.ShortDescription) Then
                    Me.FbOpenGraph.Description = Me.LocalProduct.ShortDescription
                Else
                    Me.FbOpenGraph.Description = Utilities.TextUtilities.StripHtml(Me.LocalProduct.LongDescription)
                End If
            End If

            ' ImageUrl
            If String.IsNullOrEmpty(Me.FbOpenGraph.ImageUrl) Then
                If Not String.IsNullOrEmpty(Me.LocalProduct.ImageFileMedium) Then
                    Me.FbOpenGraph.ImageUrl = Utilities.UrlRewriter.CreateFullyQualifiedUrl(Me.LocalProduct.ImageFileMedium)
                End If
            End If

            ' Price
            If Me.FbOpenGraph.Price < 0 Then
                Me.FbOpenGraph.Price = Me.LocalProduct.GetCurrentPrice(SessionManager.GetCurrentUserId(), 0D, Nothing)
            End If

            ' Currency
            If String.IsNullOrEmpty(Me.FbOpenGraph.Currency) Then
                Dim country As Content.Country = Content.Country.FindByBvin(WebAppSettings.SiteCountryBvin)
                Me.FbOpenGraph.Currency = New System.Globalization.RegionInfo(country.CultureCode).ISOCurrencySymbol
            End If

            ' Availability
            If String.IsNullOrEmpty(Me.FbOpenGraph.Availability) Then
                If Me.LocalProduct.IsInStock Then
                    Me.FbOpenGraph.Availability = "instock"
                Else
                    If Me.LocalProduct.IsBackordered Then
                        Me.FbOpenGraph.Availability = "pending"
                    Else
                        Me.FbOpenGraph.Availability = "oos"
                    End If
                End If
            End If


            ' look for UPC, EAN, and ISBN type properties
            If String.IsNullOrEmpty(Me.FbOpenGraph.Upc) OrElse String.IsNullOrEmpty(Me.FbOpenGraph.Ean) OrElse String.IsNullOrEmpty(Me.FbOpenGraph.Isbn) Then
                Dim properties As Collection(Of Catalog.ProductProperty) = Catalog.ProductProperty.FindByProductType(Me.LocalProduct.ProductTypeId)

                ' UPC
                If String.IsNullOrEmpty(Me.FbOpenGraph.Isbn) Then
                    Dim upcProperty As Catalog.ProductProperty = properties.FirstOrDefault(Function(x) x.PropertyName.ToLower() = "upc" OrElse x.DisplayName.ToLower() = "upc")
                    If upcProperty IsNot Nothing Then
                        Me.FbOpenGraph.Upc = Catalog.InternalProduct.GetPropertyValue(Me.LocalProduct.Bvin, upcProperty.Bvin)
                    End If
                End If

                ' EAN
                If String.IsNullOrEmpty(Me.FbOpenGraph.Ean) Then
                    Dim eanProperty As Catalog.ProductProperty = properties.FirstOrDefault(Function(x) x.PropertyName.ToLower() = "ean" OrElse x.DisplayName.ToLower() = "ean")
                    If eanProperty IsNot Nothing Then
                        Me.FbOpenGraph.Ean = Catalog.InternalProduct.GetPropertyValue(Me.LocalProduct.Bvin, eanProperty.Bvin)
                    End If
                End If

                ' ISBN
                If String.IsNullOrEmpty(Me.FbOpenGraph.Upc) Then
                    Dim isbnProperty As Catalog.ProductProperty = properties.FirstOrDefault(Function(x) x.PropertyName.ToLower() = "isbn" OrElse x.DisplayName.ToLower() = "isbn")
                    If isbnProperty IsNot Nothing Then
                        Me.FbOpenGraph.Isbn = Catalog.InternalProduct.GetPropertyValue(Me.LocalProduct.Bvin, isbnProperty.Bvin)
                    End If
                End If
            End If
        End If
    End Sub

End Class