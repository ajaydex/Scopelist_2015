Imports BVSoftware.BVC5.Core

Partial Class BVModules_Controls_SingleProductDisplay
    Inherits BaseSingleProductDisplay

#Region " Properties "

    Public Overrides Property Selected() As Boolean
        Get
            Return Me.SelectedCheckBox.Checked
        End Get
        Set(ByVal value As Boolean)
            Me.SelectedCheckBox.Checked = value
        End Set
    End Property

    Public Overrides Property Quantity() As Integer
        Get
            Dim val As Integer = 1
            If Integer.TryParse(Me.QuantityTextBox.Text, val) Then
                Return val
            Else
                Return 1
            End If
        End Get
        Set(ByVal value As Integer)
            Me.QuantityTextBox.Text = CStr(value)
        End Set
    End Property

#End Region

    Public Overrides Sub LoadWithProduct(ByVal p As Catalog.Product)
        If p IsNot Nothing Then
            ViewState("ProductID") = p.Bvin
            Me.Destination = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)

            If Me.DisplayName Then
                NameHyperLink.Text = p.ProductName
                NameHyperLink.NavigateUrl = Me.Destination
            Else
                NameHyperLink.Visible = False
            End If

            productimagelink.HRef = Me.Destination

            If DisplayMode = BVSoftware.BVC5.Core.Controls.SingleProductDisplayModes.NoneUseCssClassPrefix Then
                Me.SingleProductDisplayPanel.CssClass = CssClassPrefix + "SingleProductDisplayPanel"
            ElseIf DisplayMode = BVSoftware.BVC5.Core.Controls.SingleProductDisplayModes.Skinny Then
                Me.SingleProductDisplayPanel.CssClass = "SkinnySingleProductDisplayPanel"
            ElseIf DisplayMode = BVSoftware.BVC5.Core.Controls.SingleProductDisplayModes.Wide Then
                Me.SingleProductDisplayPanel.CssClass = "WideSingleProductDisplayPanel"
            End If

            Me.BadgeImage.ImageUrl = PersonalizationServices.GetThemedButton("Misc/NewProduct")

            If WebAppSettings.NewProductBadgeAllowed AndAlso p.IsNew Then
                Me.BadgeImage.Visible = True
            Else
                Me.BadgeImage.Visible = False
            End If

            If DisplayDescription Then
                DescriptionLabel.Visible = True
                DescriptionLabel.Text = p.ShortDescription
            Else
                DescriptionLabel.Visible = False
            End If
            ProductImage.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(p.ImageFileSmall, True))
            ProductImage.AlternateText = HttpUtility.HtmlEncode(p.ImageFileSmallAlternateText)


            ' Force Image Size
            ViewUtilities.ForceImageSize(ProductImage, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

            If Me.DisplayPrice Then
                PriceLabel.Text = p.GetSitePriceForDisplay(0D)
            Else
                PriceLabel.Visible = False
            End If

            If DisplayAddToCartButton AndAlso (p.IsKit OrElse p.GlobalProduct.HasChoicesInputsOrModifiers()) Then    ' only display Details button if the Add to Cart button would have been displayed
                DetailsImageButton.NavigateUrl = Me.Destination
                DetailsImageButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                DetailsImageButton.Visible = Me.DisplayAddToCartButton
                AddToCartImageButton.Visible = False
                SelectedCheckBox.Visible = False
            Else
                AddToCartImageButton.ImageUrl = PersonalizationServices.GetThemedButton("AddToCart")
                AddToCartImageButton.EnableCallBack = Me.RemainOnPageAfterAddToCart
                AddToCartImageButton.CommandArgument = p.Bvin
                AddToCartImageButton.Visible = Me.DisplayAddToCartButton
                DetailsImageButton.Visible = False
                SelectedCheckBox.Visible = Me.DisplaySelectedCheckBox

                If AddToCartImageButton.Visible Then
                    AddToCartImageButton.ValidationGroup = p.Bvin
                    QuantityRegularExpressionValidator.ValidationGroup = p.Bvin
                    QuantityRequiredFieldValidator.ValidationGroup = p.Bvin
                End If

                If DisplayQuantity Then
                    QuantityTextBox.Visible = True
                    QuantityLabel.Visible = True
                    QuantityRequiredFieldValidator.Visible = True
                    QuantityRequiredFieldValidator.Enabled = True
                    QuantityRegularExpressionValidator.Visible = True
                    QuantityRegularExpressionValidator.Enabled = True
                Else
                    QuantityTextBox.Visible = False
                    QuantityLabel.Visible = False
                    QuantityRequiredFieldValidator.Visible = False
                    QuantityRequiredFieldValidator.Enabled = False
                    QuantityRegularExpressionValidator.Visible = False
                    QuantityRegularExpressionValidator.Enabled = False
                End If
            End If
        End If
    End Sub

    Protected Sub AddToCartImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles AddToCartImageButton.Click
        Dim productId As String = CType(ViewState("ProductID"), String)
        If productId IsNot Nothing Then
            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(productId)
            If product IsNot Nothing Then
                Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart()
                Dim LineItem As New Orders.LineItem()
                LineItem.ProductId = productId
                LineItem.Quantity = Convert.ToDecimal(Math.Max(Me.Quantity, product.MinimumQty))
                Basket.AddItem(LineItem)
                MyBase.OnAddToCartClicked(productId)  ' raises AddToCartClicked event
                AddedToCartLabel.Visible = True
                If (WebAppSettings.RedirectToCartAfterAddProduct) AndAlso (Not Me.RemainOnPageAfterAddToCart) Then
                    Response.Redirect("~/Cart.aspx")
                End If
            End If
        End If
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        If AddedToCartLabel.Visible Then
            AddedToCartLabel.Visible = False
        End If
    End Sub

End Class