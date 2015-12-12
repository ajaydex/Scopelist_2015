Imports BVSoftware.Bvc5.Core

Partial Class BVModules_KitTemplates_List_Kit
    Inherits BaseStoreProductPage

    Private ReadOnly Property ProductId() As String
        Get
            If String.IsNullOrEmpty(Request.QueryString("productid")) Then
                Return String.Empty
            Else
                Return Request.QueryString("productid")
            End If
        End Get        
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If LocalProduct.Bvin = String.Empty Then
            EventLog.LogEvent("Kit Page", "Requested Product of id " & Me.ProductId & " was not found", Metrics.EventLogSeverity.Error)
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

                Dim lineitemQty As Decimal = 0
                If Request.QueryString("LineItemId") IsNot Nothing Then
                    Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(Request.QueryString("LineItemId"))
                    If (lineItem.Bvin <> String.Empty) Then
                        ' Future release should load up selection data here
                        lineitemQty = lineItem.Quantity
                    End If
                End If

                lblDescription.Text = LocalProduct.LongDescription

                ItemAddedToCartLabel.Text = WebAppSettings.ItemAddedToCartText
                'Record Last 10 Products Viewed
                PersonalizationServices.RecordProductViews(LocalProduct.Bvin)

                Me.lblSitePriceName.Text = Content.SiteTerms.GetTerm("SitePrice")
                Me.lblQuantity.Text = Content.SiteTerms.GetTerm("Quantity")


                If lineitemQty > LocalProduct.MinimumQty Then
                    QuantityField.Text = Math.Round(lineitemQty, 0).ToString()
                Else
                    QuantityField.Text = LocalProduct.GetMinimumQuantity()
                End If


                PopulateProductInfo(False)

            End If
        End If
    End Sub

    Public Sub CheckForBackOrder()
        If Not WebAppSettings.DisableInventory Then
            Select Case Me.LocalProduct.InventoryStatus
                Case Catalog.ProductInventoryStatus.NotAvailable
                    Me.ProductControlsPanel.Visible = False
                Case Else
                    Me.ProductControlsPanel.Visible = True
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

        'If IsValidCombination Then
        '    If Not ProductControlsPanel.Visible Then
        '        ProductControlsPanel.Visible = True
        '        ProductControlsPanel.UpdateAfterCallBack = True
        '    End If

        '    If Not PricePanel.Visible Then
        '        PricePanel.Visible = True
        '        PricePanel.UpdateAfterCallBack = True
        '    End If

        '    Dim userId As String = SessionManager.GetCurrentUserId()


        '    Dim productDisplay As Catalog.ProductDisplayData = LocalProduct.GetProductDisplayData(userId, 0)

        '    ' Prices
        '    If productDisplay.ListPriceGreaterThanCurrentPrice Then
        '        Me.PricePanel.UpdateAfterCallBack = True
        '    Else
        '        Me.PricePanel.UpdateAfterCallBack = True
        '    End If
        '    Me.lblSitePrice.Text = productDisplay.SitePriceDisplay
        'Else
        '    ProductControlsPanel.Visible = False
        '    ProductControlsPanel.UpdateAfterCallBack = True
        'End If

    End Sub

    Public Sub AddToCartClicked(ByVal args As AddToCartClickedEventArgs) Handles AddToCartButton1.AddToCartClicked
        args.ItemAddedToCartLabel = Me.ItemAddedToCartLabel
        args.MessageBox = Me.MessageBox
        args.Page = Me        
        args.KitDisplay = Me.KitComponentsDisplay
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

    Public Sub KitComponentsChanged(ByVal sender As Object, ByVal args As KitComponentsChangedEventArgs) Handles KitComponentsDisplay.KitComponentsChanged
        Dim selectionData As Catalog.KitSelectionData = Services.KitService.GetKitSelectionData(args.KitSelections)
        lblSitePrice.Text = selectionData.TotalPrice.ToString("c")        
    End Sub
End Class
