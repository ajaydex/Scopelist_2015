Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_CategoryTemplates_Detailed_List_Category
    Inherits BaseStoreCategoryPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Category.master")
        Me.BlockId = "7912deec-5266-4da9-a79e-282100e90621"
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        LoadContentColumns()
    End Sub

    Private Sub LoadContentColumns()
        If LocalCategory.PreContentColumnId <> String.Empty Then
            Me.PreContentColumn.ColumnID = LocalCategory.PreContentColumnId
            Me.PreContentColumn.LoadColumn()
        End If
        If LocalCategory.PostContentColumnId <> String.Empty Then
            Me.PostContentColumn.ColumnID = LocalCategory.PostContentColumnId
            Me.PostContentColumn.LoadColumn()
        End If
    End Sub

    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If LocalCategory IsNot Nothing Then
            LoadProducts()
        End If
    End Sub

    Protected Sub LoadProducts()        
        If LocalCategory IsNot Nothing Then
            Pager1.ItemsPerPage = Me.SettingsManager.GetIntegerSetting("ItemsPerPage")
            Pager2.ItemsPerPage = Me.SettingsManager.GetIntegerSetting("ItemsPerPage")
            PopulateCategoryInfo()

            Dim rowCount As Integer = 0

            Dim displayProducts As Collection(Of Catalog.Product) = Nothing
            If Me.ProductSearchCriteria IsNot Nothing Then
                displayProducts = LocalCategory.FindAllProductsByCriteria(Me.ProductSearchCriteria, Me.SortOrder, WebAppSettings.DisableInventory, False, Pager1.CurrentRow, Pager1.ItemsPerPage, rowCount)
            Else
                displayProducts = LocalCategory.FindAllProducts(Me.SortOrder, WebAppSettings.DisableInventory, False, Pager1.CurrentRow, Pager1.ItemsPerPage, rowCount)
            End If

            Me.DataList1.DataSource = displayProducts
            Me.DataList1.DataBind()

            Pager1.RowCount = rowCount
            Pager2.RowCount = rowCount
        End If
    End Sub

    Public Sub PopulateCategoryInfo()

        ' Page Title
        If LocalCategory.MetaTitle.Trim.Length > 0 Then
            Me.PageTitle = LocalCategory.MetaTitle
        Else
            Me.PageTitle = LocalCategory.Name
        End If

        ' Meta Keywords
        If LocalCategory.MetaKeywords.Trim.Length > 0 Then
            CType(Page, BaseStorePage).MetaKeywords = LocalCategory.MetaKeywords
        End If

        ' Meta Description
        If LocalCategory.MetaDescription.Trim.Length > 0 Then
            CType(Page, BaseStorePage).MetaDescription = LocalCategory.MetaDescription
            If (Pager1.CurrentPage > 1) Then
                CType(Page, BaseStorePage).MetaDescription += " Page " & Pager1.CurrentPage.ToString()
                Me.PageTitle += " Page " & Pager1.CurrentPage.ToString()
            End If
        End If

        ' Title
        If LocalCategory.ShowTitle = False Then
            Me.lblTitle.Visible = False
        Else
            Me.lblTitle.Visible = True
            Me.lblTitle.Text = LocalCategory.Name
        End If

        'Description
        If LocalCategory.Description.Trim.Length > 0 Then
            Me.DescriptionLiteral.Text = LocalCategory.Description
        Else
            Me.DescriptionLiteral.Text = String.Empty
        End If

        If LocalCategory.BannerImageUrl.Trim.Length > 0 Then
            Me.BannerImage.Visible = True
            Me.BannerImage.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(LocalCategory.BannerImageUrl, True))
            Me.BannerImage.AlternateText = LocalCategory.Name
        Else
            Me.BannerImage.Visible = False
        End If

    End Sub

    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim p As Catalog.Product = CType(e.Item.DataItem, Catalog.Product)
            If p IsNot Nothing Then

                Dim destinationLink As String = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)
                Dim imageUrl As String
                imageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(p.ImageFileSmall, True))

                '<div class="DetailProductDisplay">
                '                <div class="DetailProductDisplayName">
                '                    <asp:HyperLink ID="lnkName" runat="server">Product Name</asp:HyperLink></div>
                '                <div class="DetailProductDisplaySku">
                '                    <asp:HyperLink ID="lnkSKU" runat="server">SKU</asp:HyperLink></div>
                '                <div class="DetailProductDisplayPrice">
                '                    <asp:HyperLink ID="lnkPrice" runat="server"></asp:HyperLink></div>
                '                <div class="DetailProductDisplayDescription">
                '                    <asp:Label ID="lblDescription" runat="server" Text="Product Description"></asp:Label></div>
                '                <div class="DetailProductDisplayControls">
                '                    <asp:HyperLink ID="lnkAddToCart" runat="server" ImageUrl="~/Images/Buttons/AddToCart.gif" />
                '                </div>
                '            </div>


                ' Image
                Dim anchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordimageanchor"), HtmlAnchor)
                anchor.HRef = destinationLink
                Dim img As HtmlImage = DirectCast(e.Item.FindControl("recordimage"), HtmlImage)
                img.Src = imageUrl
                img.Alt = HttpUtility.HtmlEncode(p.ImageFileSmallAlternateText)

                ' Force Image Size
                ViewUtilities.ForceImageSize(img, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

                ' Sku
                anchor = DirectCast(e.Item.FindControl("recordskuanchor"), HtmlAnchor)
                anchor.HRef = destinationLink
                anchor.InnerText = p.Sku

                ' Name
                anchor = DirectCast(e.Item.FindControl("recordnameanchor"), HtmlAnchor)
                anchor.HRef = destinationLink
                anchor.InnerHtml = p.ProductName

                ' Short Description
                Dim litDes As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("recordshortdescriptionfield"), Literal)
                If litDes IsNot Nothing Then
                    litDes.Text = p.ShortDescription
                End If

                ' Price
                anchor = DirectCast(e.Item.FindControl("recordpriceanchor"), HtmlAnchor)
                anchor.HRef = destinationLink
                anchor.InnerText = p.GetSitePriceForDisplay(0D)

                Dim imgButton As ImageButton = DirectCast(e.Item.FindControl("AddToCartImageButton"), ImageButton)
                Dim detailsButton As ImageButton = DirectCast(e.Item.FindControl("DetailsImageButton"), ImageButton)

                If (Catalog.ProductChoice.GetChoiceCountForProduct(p.Bvin) > 0) OrElse _
                    (Catalog.ProductModifier.GetModifierCountForProduct(p.Bvin) > 0) OrElse _
                    (Catalog.ProductInput.GetInputCountForProduct(p.Bvin) > 0) OrElse _
                    (p.IsKit) Then
                    detailsButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                    detailsButton.AlternateText = "Details"
                    detailsButton.PostBackUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                    detailsButton.CommandArgument = p.Bvin
                    detailsButton.Visible = True
                    imgButton.Visible = False
                Else
                    imgButton.ImageUrl = PersonalizationServices.GetThemedButton("AddToCart")
                    imgButton.AlternateText = "Add To Cart"
                    imgButton.CommandName = "AddToCart"
                    imgButton.CommandArgument = p.Bvin
                    imgButton.Visible = True
                    detailsButton.Visible = False
                End If

                Dim paragraph As HtmlGenericControl = DirectCast(e.Item.FindControl("addedtocart"), HtmlGenericControl)
                paragraph.InnerHtml = WebAppSettings.ItemAddedToCartText
            Else
                e.Item.Visible = False
            End If
        End If
    End Sub

    Protected Sub DataList1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList1.ItemCommand
        If e.CommandName = "AddToCart" Then
            If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
                Dim key As String = e.CommandArgument
                Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(e.CommandArgument)
                Dim basket As Orders.Order = SessionManager.CurrentShoppingCart()
                basket.AddItem(product.Bvin, 1)
                Dim destination As String = product.GetCartDestinationUrl(basket.LastLineItemAdded)
                If destination <> String.Empty Then
                    Response.Redirect(destination)
                Else
                    DirectCast(e.Item.FindControl("addedtocart"), HtmlGenericControl).Visible = True
                End If
            End If
        End If
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If Pager1.Visible Then
            Select Case DirectCast(Me.SettingsManager.GetIntegerSetting("PagerMode"), Controls.PagerModes)
                Case BVSoftware.Bvc5.Core.Controls.PagerModes.Top
                    Pager1.Visible = True
                    Pager2.Visible = False
                Case BVSoftware.Bvc5.Core.Controls.PagerModes.Bottom
                    Pager1.Visible = False
                    Pager2.Visible = True
                Case BVSoftware.Bvc5.Core.Controls.PagerModes.Both
                    Pager1.Visible = True
                    Pager2.Visible = True
            End Select
        End If
    End Sub
End Class