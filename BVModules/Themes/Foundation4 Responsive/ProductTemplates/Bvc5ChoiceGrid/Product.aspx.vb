Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ProductTemplates_Bvc5ChoiceGrid_Product
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
        AddToCartImageButton.ImageUrl = Page.ResolveUrl(PersonalizationServices.GetThemedButton("AddToCart"))
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

            Me.lblSKUTitle.Text = Content.SiteTerms.GetTerm("Sku")
        End If

        If Not Page.IsPostBack Then
            If LocalProduct IsNot Nothing Then
                VariantsGridDisplay.BaseProduct = Me.LocalProduct
                If Request.QueryString("LineItemId") IsNot Nothing Then
                    Dim lineItem As Orders.LineItem = Orders.LineItem.FindByBvin(Request.QueryString("LineItemId"))
                    If lineItem.Bvin <> String.Empty Then
                        VariantsGridDisplay.LoadFromLineItem(lineItem)
                    End If
                End If
                'Me.LocalProduct = VariantsGridDisplay.GetSelectedProduct(Me.LocalProduct)
                ItemAddedToCartLabel.Text = WebAppSettings.ItemAddedToCartText
                PopulateProductInfo(True)
                'Record Last 10 Products Viewed
                PersonalizationServices.RecordProductViews(LocalProduct.Bvin)
            End If
        Else
            VariantsGridDisplay.Initialize(True)
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
            If Not ProductControlsPanel.Visible Then
                ProductControlsPanel.Visible = True
                'ProductControlsPanel.UpdateAfterCallBack = True
            End If

            Dim userId As String = SessionManager.GetCurrentUserId()
        Else
            ProductControlsPanel.Visible = False
            'ProductControlsPanel.UpdateAfterCallBack = True
        End If

    End Sub

    Protected Sub AddToCartImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddToCartImageButton.Click
        Dim lineItems As Collection(Of Orders.LineItem) = VariantsGridDisplay.GetLineItems()

        Dim totalQuantity As Integer = 0
        For Each item As Orders.LineItem In lineItems
            totalQuantity += item.Quantity
        Next

        If totalQuantity = 0 Then
            Me.MessageBox.ShowError("Please enter a quantity greater than 0 for each item that you would like to add to your cart.")
            Return
        End If

        Dim notEnoughQuantity As Boolean = False
        If Me.LocalProduct IsNot Nothing Then
            If totalQuantity < Me.LocalProduct.MinimumQty Then
                notEnoughQuantity = True
            End If
        End If

        If notEnoughQuantity Then
            Me.MessageBox.ShowError(Content.SiteTerms.ReplaceTermVariable(Content.SiteTerms.GetTerm("ProductPageMinimumQuantityError"), "quantity", LocalProduct.MinimumQty.ToString()))
        Else
            Dim cart As Orders.Order = SessionManager.CurrentShoppingCart()
            If cart.UserID <> SessionManager.GetCurrentUserId() Then
                cart.UserID = SessionManager.GetCurrentUserId()
            End If

            For Each lineItem As Orders.LineItem In lineItems
                cart.AddItem(lineItem)
            Next

            If cart.LastLineItemAdded IsNot Nothing AndAlso lineItems.Count > 0 Then
                Dim destination As String = lineItems(0).AssociatedProduct.GetCartDestinationUrl(lineItems(0))

                If destination.Trim() = String.Empty Then
                    ItemAddedToCartLabel.Text = WebAppSettings.ItemAddedToCartText
                    ItemAddedToCartLabel.Visible = True
                    'ItemAddedToCartLabel.UpdateAfterCallBack = True
                Else
                    Response.Redirect(destination)
                End If
            End If

        End If
    End Sub

End Class
