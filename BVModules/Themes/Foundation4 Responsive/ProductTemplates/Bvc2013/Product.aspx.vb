Imports BVSoftware.BVC5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_ProductTemplates_Bvc2013_Responsive_Product
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

                InvalidChoiceCombinationPanel.Visible = False

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
                Me.lblSKUTitle.Text = Content.SiteTerms.GetTerm("Sku")
                Me.lblProductCombinationInvalid.Text = Content.SiteTerms.GetTerm("ProductCombinationInvalid")

                If lineitemQty > LocalProduct.MinimumQty Then
                    QuantityField.Text = Math.Round(lineitemQty, 0).ToString()
                Else
                    QuantityField.Text = LocalProduct.GetMinimumQuantity()
                End If
            End If
        Else
            VariantsDisplay.Initialize(True)
        End If

        ' Cross Sell
        Me.CrossSellDisplay.Product = LocalProduct
        Me.CrossSellDisplay.DataBind()

        ' Up Sell
        Me.UpSellDisplay.Product = LocalProduct
        Me.UpSellDisplay.DataBind()

        ' Suggested Items
        Me.SuggestedItems1.Product = LocalProduct
        Me.SuggestedItems1.DataBind()

    End Sub

    Public Overrides Sub PopulateProductInfo(ByVal IsValidCombination As Boolean)


        ' Name Fields
        Me.lblName.Text = LocalProduct.ProductName
        Me.lblSku.Text = LocalProduct.Sku
        Me.lblDescription.Text = LocalProduct.LongDescription

        If IsValidCombination Then
            Me.ProductControlsPanel.DefaultButton = Me.AddToCartButton1.FindControl("btnAdd").UniqueID

            If Not ProductControlsPanel.Visible Then
                ProductControlsPanel.Visible = True
                ProductControlsPanel.UpdateAfterCallBack = True

                InvalidChoiceCombinationPanel.Visible = False
                InvalidChoiceCombinationPanel.UpdateAfterCallBack = True
            End If

            If Not pnlPrices.Visible Then
                pnlPrices.Visible = True
                pnlPrices.UpdateAfterCallBack = True
            End If

            'add on selected modifier prices
            Dim priceAdjustment As Decimal = VariantsDisplay.GetPriceAdjustment()
            If priceAdjustment <> 0 Then
                ' force pricing workflow to run again to take choice/modifier adjustment into account
                LocalProduct.SetCurrentPrice(Decimal.MinValue)
            End If
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
                Me.trYouSave.Visible = True
                Me.lblYouSave.Text = productDisplay.Savings.ToString("c")
                Me.pnlPrices.UpdateAfterCallBack = True
            Else
                Me.trYouSave.Visible = False
                Me.pnlPrices.UpdateAfterCallBack = True
            End If


            ' Schema / structured data
            If Not String.IsNullOrEmpty(LocalParentProduct.ManufacturerId) AndAlso LocalParentProduct.ManufacturerId <> "- No Manufacturer -" Then
                Dim manufacturer As Contacts.Manufacturer = BVSoftware.BVC5.Core.Contacts.Manufacturer.FindByBvin(LocalParentProduct.ManufacturerId)
                metaBrand.Attributes.Add("content", manufacturer.DisplayName)
                metaManufacturer.Attributes.Add("content", manufacturer.DisplayName)
            Else
                Me.metaBrand.Visible = False
                Me.metaManufacturer.Visible = False
            End If

            Me.metaPriceCurrency.Attributes.Add("content", New System.Globalization.RegionInfo(BVSoftware.BVC5.Core.Content.Country.FindByBvin(BVSoftware.BVC5.Core.WebAppSettings.SiteCountryBvin).CultureCode).ISOCurrencySymbol)

            If LocalProduct.IsInStock Then
                metaAvailability.Attributes.Add("content", "InStock")
            Else
                If LocalProduct.IsBackordered Then
                    metaAvailability.Attributes.Add("content", "PreOrder")
                Else
                    metaAvailability.Attributes.Add("content", "OutOfStock")
                End If
            End If
        Else
            ProductControlsPanel.Visible = False
            ProductControlsPanel.UpdateAfterCallBack = True

            InvalidChoiceCombinationPanel.Visible = True
            InvalidChoiceCombinationPanel.UpdateAfterCallBack = True
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
                    Dim qerror As String = Content.SiteTerms.GetTerm("ProductPageMinimumQuantityError")
                    Dim qtyString As String = LocalProduct.MinimumQty.ToString()
                    Dim variableName As String = "quantity"
                    qerror = Content.SiteTerms.ReplaceTermVariable(qerror, variableName, qtyString)
                    MessageBox.ShowError(qerror)
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