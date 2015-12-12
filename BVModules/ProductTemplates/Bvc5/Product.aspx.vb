Imports BVSoftware.Bvc5.Core

Partial Class BVModules_ProductTemplates_Bvc5_Product
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
                PopulateProductInfo(VariantsDisplay.IsValidCombination)
                'Record Last 10 Products Viewed
                PersonalizationServices.RecordProductViews(LocalProduct.Bvin)

                Me.lblYouSaveLabel.Text = Content.SiteTerms.GetTerm("YouSave")
                Me.lblSitePriceName.Text = Content.SiteTerms.GetTerm("SitePrice")
                Me.lblListPriceName.Text = Content.SiteTerms.GetTerm("ListPrice")
                Me.lblQuantity.Text = Content.SiteTerms.GetTerm("Quantity")

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

    Public Overrides Sub PopulateProductInfo(ByVal IsValidCombination As Boolean)
        ' Name Fields
        Me.lblName.Text = Me.LocalProduct.ProductName
        Me.lblSku.Text = Me.LocalProduct.Sku
        Me.lblDescription.Text = Me.LocalProduct.LongDescription

        ' Cross Sell
        Me.CrossSellDisplay.Product = Me.LocalProduct
        Me.CrossSellDisplay.DataBind()

        If IsValidCombination Then
            Me.ProductControlsPanel.DefaultButton = Me.AddToCartButton1.FindControl("btnAdd").UniqueID

            If Not ProductControlsPanel.Visible Then
                ProductControlsPanel.Visible = True
                ProductControlsPanel.UpdateAfterCallBack = True
            End If

            PricePanel.Visible = True
            PricePanel.UpdateAfterCallBack = True

            Dim userId As String = SessionManager.GetCurrentUserId()

            'add on selected modifier prices
            Dim priceAdjustment As Decimal = VariantsDisplay.GetPriceAdjustment()
            If priceAdjustment <> 0 Then
                ' force pricing workflow to run again to take choice/modifier adjustment into account
                LocalProduct.SetCurrentPrice(Decimal.MinValue)
            End If
            Dim productDisplay As Catalog.ProductDisplayData = LocalProduct.GetProductDisplayData(userId, priceAdjustment)

            ' Prices
            If productDisplay.ListPriceGreaterThanCurrentPrice Then
                Me.trListPrice.Visible = True
                Me.lblListPrice.Text = productDisplay.ListPrice.ToString("c")
                Me.PricePanel.UpdateAfterCallBack = True
            Else
                Me.trListPrice.Visible = False
                Me.PricePanel.UpdateAfterCallBack = True
            End If
            Me.lblSitePrice.Text = productDisplay.SitePriceDisplay

            If (productDisplay.SitePrice < productDisplay.ListPrice) AndAlso (Not productDisplay.HasPriceOverrideText) Then
                Me.trYouSave.Visible = True
                Me.lblYouSave.Text = productDisplay.Savings.ToString("c") & " - " & productDisplay.SavingsPercent & Threading.Thread.CurrentThread.CurrentUICulture.NumberFormat.PercentSymbol
                Me.PricePanel.UpdateAfterCallBack = True
            Else
                Me.trYouSave.Visible = False
                Me.PricePanel.UpdateAfterCallBack = True
            End If
        Else
            ProductControlsPanel.Visible = False
            ProductControlsPanel.UpdateAfterCallBack = True
        End If

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
End Class
