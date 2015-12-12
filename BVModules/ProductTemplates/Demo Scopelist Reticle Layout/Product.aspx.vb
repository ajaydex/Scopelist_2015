Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ProductTemplates_Demo_Scopelist_Reticle_Layout_Product
    Inherits BaseStoreProductPage

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If (LocalProduct Is Nothing) OrElse (LocalProduct.Bvin = String.Empty) Then
            EventLog.LogEvent("Product Page", "Requested Product of id " & Request.QueryString("productid") & " was not found", Metrics.EventLogSeverity.Error)
            Throw New ApplicationException("Product was not found.")
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

            If Not Content.SiteTerms.GetTerm("EnableBanner") Is Nothing And Content.SiteTerms.GetTerm("EnableBanner") <> String.Empty Then
                If Boolean.Parse(Content.SiteTerms.GetTerm("EnableBanner")) Then
                    dvfreedombanner.Visible = True
                    lnkReadMore.HRef = Page.ResolveUrl("~/make-an-offer-and-save-big.aspx?id=" & LocalProduct.Bvin)
                Else
                    dvfreedombanner.Visible = False
                End If
            Else
                dvfreedombanner.Visible = False
            End If


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

            'setting url and sitename markup values for search engines
            Me.metaUrl.Attributes.Add("content", HttpContext.Current.Request.Url.Host & HttpContext.Current.Request.RawUrl)
            Me.metaSiteName.Attributes.Add("content", HttpContext.Current.Request.Url.Host)
        End If

        CheckForBackOrder()

        If Not Page.IsPostBack Then
            If LocalProduct IsNot Nothing Then
                VariantsDisplay.BaseProduct = LocalProduct

                Dim lineitemQty As Decimal = 0
                If Request.QueryString("LineItemId") IsNot Nothing Then
                    Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(Request.QueryString("LineItemId"))
                    If lineItem.Bvin <> String.Empty Then
                        VariantsDisplay.LoadFromLineItem(lineItem)
                        lineitemQty = lineItem.Quantity
                    End If
                End If
                Me.LocalProduct = VariantsDisplay.GetSelectedProduct(Me.LocalProduct)

                ItemAddedToCartLabel.Text = WebAppSettings.ItemAddedToCartText
                'Me.lblYouSaveLabel.Text = Content.SiteTerms.GetTerm("YouSave")
                Me.lblSitePriceName.Text = Content.SiteTerms.GetTerm("SitePrice")
                Me.lblListPriceName.Text = Content.SiteTerms.GetTerm("ListPrice")
                Me.lblQuantity.Text = Content.SiteTerms.GetTerm("Quantity")
                Me.lblSKUTitle.Text = Content.SiteTerms.GetTerm("Sku")

                PopulateProductInfo(VariantsDisplay.IsValidCombination)
                'Record Last 10 Products Viewed
                PersonalizationServices.RecordProductViews(LocalProduct.Bvin)

                If lineitemQty > LocalProduct.MinimumQty Then
                    QuantityField.Text = Math.Round(lineitemQty, 0).ToString()
                Else
                    QuantityField.Text = LocalProduct.GetMinimumQuantity()
                End If
            End If

        Else
            VariantsDisplay.Initialize(True)
        End If
    End Sub

    Public Overrides Sub PopulateProductInfo(ByVal IsValidCombination As Boolean)

        ' Name Fields
        Me.lblName.Text = LocalProduct.ProductName
        'extra name label for desciption area BMF - Resposio
        Me.lblname1.Text = LocalProduct.ProductName
        'Me.lblName2.Text = LocalProduct.ProductName
        Me.lblDiscontinued.Text = LocalProduct.ProductName

        Me.lblSku.Text = LocalProduct.Sku

        Me.lblDescription.Text = LocalProduct.LongDescription
        'Code to Display Reticle Image BMF - Resposio
        Me.lblReticle.Text = LocalProduct.ShortDescription

        Dim info As ProductInfo = ProductInfo.FindByProduct(LocalProduct.Bvin)
        If info IsNot Nothing Then
            Me.lSubtitle.Text = info.Subtitle
            If info.MPN <> String.Empty Then
                Me.lblSKUTitle.Text = "MPN:"
                Me.lblSku.Text = info.MPN
            End If
        End If

        If IsValidCombination Then
            If Not ProductControlsPanel.Visible Then
                ProductControlsPanel.Visible = True
                ProductControlsPanel.UpdateAfterCallBack = True
            End If

            If Not pnlPrices.Visible Then
                pnlPrices.Visible = True
                pnlPrices.UpdateAfterCallBack = True
            End If

            'add on selected modifier prices
            Dim priceAdjustment As Decimal = VariantsDisplay.GetPriceAdjustment()
            Dim userId As String = SessionManager.GetCurrentUserId()
            Dim productDisplay As Catalog.ProductDisplayData = LocalProduct.GetProductDisplayData(userId, priceAdjustment)

            ' Prices
            If productDisplay.ListPriceGreaterThanCurrentPrice Then
                Me.trListPrice.Visible = True
                Me.lblListPrice.Text = productDisplay.ListPrice.ToString("c")
                Me.pnlPrices.UpdateAfterCallBack = True
            Else
                Me.trListPrice.Visible = False
                Me.pnlPrices.UpdateAfterCallBack = True
            End If
            Me.lblSitePrice.Text = productDisplay.SitePriceDisplay

            If (productDisplay.SitePrice < productDisplay.ListPrice) AndAlso (Not productDisplay.HasPriceOverrideText) Then
                'Me.trYouSave.Visible = True
                'Me.lblYouSave.Text = productDisplay.Savings.ToString("c")
                Me.pnlPrices.UpdateAfterCallBack = True
            Else
                'Me.trYouSave.Visible = False
                Me.pnlPrices.UpdateAfterCallBack = True
            End If
        Else
            ProductControlsPanel.Visible = False
            ProductControlsPanel.UpdateAfterCallBack = True
        End If
        ' Cross Sell
        Me.CrossSellDisplay.Product = LocalProduct
        Me.CrossSellDisplay.DataBind()
    End Sub

    Public Sub AddToCartClicked(ByVal args As AddToCartClickedEventArgs) Handles AddToCartButton1.AddToCartClicked
        args.ItemAddedToCartLabel = Me.ItemAddedToCartLabel
        'args.MessageBox = Me.MessageBox
        args.Page = Me
        args.VariantsDisplay = Me.VariantsDisplay

        Dim quantity As Integer = 0
        If Integer.TryParse(Me.QuantityField.Text.Trim, quantity) Then
            If LocalProduct.MinimumQty > 0 Then
                If quantity < LocalProduct.MinimumQty Then
                    MessageBox.ShowError(Content.SiteTerms.ReplaceTermVariable(Content.SiteTerms.GetTerm("ProductPageMinimumQuantityError"), "quantity", LocalProduct.MinimumQty.ToString()))
                    args.IsValid = False
                End If
            End If
            args.Quantity = quantity
        Else
            If LocalProduct.MinimumQty > 0 Then
                args.Quantity = LocalProduct.MinimumQty
            Else
                args.Quantity = 1
            End If
        End If
    End Sub

    Public Sub AddToWishlistClicked(ByVal args As AddToWishlistClickedEventArgs) Handles AddToWishlist1.Clicked
        args.ItemAddedToCartLabel = Me.ItemAddedToCartLabel
        'args.MessageBox = Me.MessageBox
        args.Page = Me
        args.VariantsDisplay = Me.VariantsDisplay
        args.IsValid = True
        Dim quantity As Integer = 0
        If Integer.TryParse(Me.QuantityField.Text.Trim, quantity) Then
            args.Quantity = quantity
        Else
            args.Quantity = 1
        End If
    End Sub

    Public Sub CheckForBackOrder()
        If Not WebAppSettings.DisableInventory Then
            Select Case Me.LocalProduct.InventoryStatus
                Case Catalog.ProductInventoryStatus.NotAvailable
                    Me.trQuantity.Visible = False
                Case Else
                    Me.trQuantity.Visible = True
            End Select
        End If
    End Sub
End Class
