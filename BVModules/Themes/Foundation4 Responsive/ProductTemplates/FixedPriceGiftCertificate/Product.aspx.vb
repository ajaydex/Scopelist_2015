Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_ProductTemplates_FixedPriceGiftCertificate_Product
    Inherits BaseStoreProductPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If LocalProduct.Bvin = String.Empty Then
            EventLog.LogEvent("Product Page", "Requested Product of id " & Request.QueryString("productid") & " was not found", Metrics.EventLogSeverity.Error)
        Else
            If LocalProduct.PreContentColumnId <> String.Empty Then
                Me.PreContentColumn.ColumnID = LocalProduct.PreContentColumnId
                Me.PreContentColumn.LoadColumn()
            End If
            If LocalProduct.PostContentColumnId <> String.Empty Then
                Me.PostContentColumn.ColumnID = LocalProduct.PostContentColumnId
                Me.PostContentColumn.LoadColumn()
            End If
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Product.master")
    End Sub

    Private Sub PageLoad(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If LocalProduct IsNot Nothing Then
            ' Page Title
            If LocalProduct.MetaTitle.Trim.Length > 0 Then
                Me.PageTitle = LocalProduct.MetaTitle
            Else
                Me.PageTitle = LocalProduct.ProductName
            End If

            ' Meta Keywords
            If LocalProduct.MetaKeywords.Trim.Length > 0 Then
                CType(Page, BaseStorePage).MetaKeywords = LocalProduct.MetaKeywords
            End If

            ' Meta Description
            If LocalProduct.MetaDescription.Trim.Length > 0 Then
                CType(Page, BaseStorePage).MetaDescription = LocalProduct.MetaDescription
            End If
        End If
        If Not Page.IsPostBack Then
            If LocalProduct IsNot Nothing Then
                PopulateProductInfo(True)
            End If
        End If
    End Sub

    Public Overrides Sub PopulateProductInfo(ByVal IsValidCombination As Boolean)
        ' Name Fields
        Me.lblName.Text = Me.LocalProduct.ProductName
        Me.lblSku.Text = Me.LocalProduct.Sku
        Me.lblSitePrice.Text = Me.LocalProduct.GetProductDisplayData(SessionManager.GetCurrentUserId(), 0D).SitePriceDisplay
        Me.lblSitePriceName.Text = Content.SiteTerms.GetTerm("SitePrice")
        Me.lblSKUTitle.Text = Content.SiteTerms.GetTerm("Sku")
        Me.lblDescription.Text = Me.LocalProduct.LongDescription
    End Sub


    Public Sub AddToCartClicked(ByVal args As AddToCartClickedEventArgs) Handles AddToCartButton1.AddToCartClicked
        args.ItemAddedToCartLabel = Me.ItemAddedToCartLabel
        'args.MessageBox = Me.MessageBox
        args.Page = Me

        'Dim quantity As Integer = 0
        'If Integer.TryParse(Me.QuantityField.Text.Trim, quantity) Then
        '    args.Quantity = quantity
        'Else
        args.Quantity = 1
        'End If
    End Sub

End Class