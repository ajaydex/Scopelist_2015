Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_CategoryTemplates_Scopelist_Reticle_Grid_with_Subs_Category
    Inherits BaseStoreCategoryPage


    Private _AllCats As Collection(Of Catalog.Category) = Nothing
    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Category.master")
        Me.BlockId = "D2D63F6A-2480-42a1-A593-FCFA83A2C8B8"
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
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
        If Not Page.IsPostBack Then

            If LocalCategory IsNot Nothing Then



                Dim itemsPerPage As Integer = Me.SettingsManager.GetIntegerSetting("ItemsPerPage")
                If itemsPerPage = 0 Then
                    itemsPerPage = 6
                End If
                Pager1.ItemsPerPage = itemsPerPage
                Pager2.ItemsPerPage = itemsPerPage
                PopulateCategoryInfo()

                Dim rowCount As Integer = 0



                pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")

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

                LoadSubCategories()
            End If
        End If
    End Sub

    Private Sub LoadSubCategories()
        _AllCats = Catalog.Category.FindAll()
        Me.DataList2.DataSource = Catalog.Category.FindChildrenInCollection(_AllCats, LocalCategory.Bvin, False)
        Me.DataList2.DataBind()
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
            Me.lblTitle2.Visible = False
        Else
            startH1.Visible = True
            endH1.Visible = True
            Me.lblTitle.Visible = True
            Me.lblTitle.Text = LocalCategory.Name
            startH2.Visible = True
            endH2.Visible = True
            Me.lblTitle2.Visible = True
            Me.lblTitle2.Text = LocalCategory.Name
        End If

        'Description
        If LocalCategory.Description.Trim.Length > 0 Then
            'commented by developer
            'Me.DescriptionLiteral.Text = LocalCategory.Description
            Dim str As String = LocalCategory.Description
            str = Replace(str, "<strong>", "")
            str = Replace(str, "</strong>", "")
            str = Replace(str, "eurooptic", "Optics Authority")
            str = Replace(str, "Eurooptic", "Optics Authority")
            str = Replace(str, "eurooptics", "Optics Authority")
            str = Replace(str, "euro optics", "Optics Authority")
            str = Replace(str, "scopelist ", "Optics Authority")

            Me.DescriptionLiteral.Text = str
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

    Protected Sub DataList1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) 'Handles DataList1.ItemCommand
        If e.CommandName = "AddToCart" Then
            'Context.Trace.Write("AddToCart", e.CommandArgument)
            'If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim key As String = e.CommandArgument
            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(e.CommandArgument)
            Dim basket As Orders.Order = SessionManager.CurrentShoppingCart()
            basket.AddItem(product.Bvin, 1)
            'Context.Trace.Write("AddToCart", product.ProductName)
            Dim destination As String = product.GetCartDestinationUrl(basket.LastLineItemAdded)
            If destination <> String.Empty Then
                Response.Redirect(destination, True)
            Else
                DirectCast(e.Item.FindControl("addedtocart"), HtmlGenericControl).Visible = True
            End If
            'Context.Trace.Write("AddToCart", destination)
            'End If
        End If

    End Sub
    'Protected Sub AddToCartClick(ByVal sender As Object, ByVal e As Web.UI.ImageClickEventArgs)

    'End Sub
    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim p As Catalog.Product = CType(e.Item.DataItem, Catalog.Product)
            If p IsNot Nothing Then
                Dim destinationLink As String = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)
                Dim imageUrl As String
                imageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(p.ImageFileSmall, True))

                DirectCast(e.Item.FindControl("ImageAnchor"), HtmlAnchor).HRef = destinationLink
                DirectCast(e.Item.FindControl("ImageAnchor"), HtmlAnchor).Title = p.MetaKeywords.Replace(",", " ")

                Dim ProductImage As HtmlImage = DirectCast(e.Item.FindControl("ProductImage"), HtmlImage)
                ProductImage.Src = imageUrl
                ProductImage.Alt = p.ProductName & " " & p.Sku

                ' Force Image Size
                ViewUtilities.ForceImageSize(ProductImage, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

                Dim NameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("NameAnchor"), HtmlAnchor)
                NameAnchor.HRef = destinationLink
                NameAnchor.InnerHtml = p.ProductName
                NameAnchor.Title = p.ProductName

                'code to add products to cart Resposio BMF
                'Dim lnk As HyperLink = e.Item.FindControl("lnkAddToCart")
                'lnk.NavigateUrl = "~/addtocart.aspx?p=" & p.Bvin
                ' Added by Resposio BMF
                'lnk.ToolTip = p.ProductName
                'If p.InventoryStatus = Catalog.ProductInventoryStatus.NotAvailable Then 'p.TrackInventory AndAlso p.Inventory.QuantityAvailableForSale <= 0
                '    lnk.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                '    lnk.ImageUrl = "~/" & PersonalizationServices.GetThemedButton("Details")
                '    lnk.ToolTip = "Details"
                '    'lnk.Visible = False
                'End If

                Dim SkuAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("SkuAnchor"), HtmlAnchor)
                SkuAnchor.HRef = destinationLink
                SkuAnchor.InnerText = p.Sku
                SkuAnchor.Title = p.MetaKeywords.Replace(",", " ")

                ' Short Description
                Dim litDes As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("recordshortdescriptionfield"), Literal)
                If litDes IsNot Nothing Then
                    litDes.Text = p.ShortDescription
                End If

                'Custom code to display Property Type Choices on Category Page
                Dim ProductTypeChoice As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("ProductTypeChoice"), Literal)
                Dim objConn As New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings.Item("Bvc5Database").ToString)
                Dim strSQL As String = "Select DisplayName, PropertyValue From bvc_Product Inner Join bvc_ProductPropertyValue On bvc_Product.Bvin = bvc_ProductPropertyValue.ProductBvin inner Join bvc_ProductProperty on bvc_ProductPropertyValue.PropertyBvin = bvc_ProductProperty.Bvin where  bvc_Product.Bvin = '" & p.Bvin & "'"
                Dim objCommand As New System.Data.SqlClient.SqlCommand(strSQL, objConn)
                Dim r As System.Data.SqlClient.SqlDataReader
                Dim intRowNumber As Integer = 0
                objConn.Open()
                r = objCommand.ExecuteReader
                Do While r.Read
                    If ProductTypeChoice.Text.Trim = "" Then
                        ProductTypeChoice.Text = r.Item("DisplayName").ToString & "&nbsp;&nbsp<b>" & r.Item("PropertyValue").ToString & "</b>"
                    Else
                        ProductTypeChoice.Text = ProductTypeChoice.Text & "<br /> " & r.Item("DisplayName").ToString & "&nbsp;&nbsp<b>" & r.Item("PropertyValue").ToString & "</b>"
                    End If

                Loop
                r.Close()
                objConn.Close()
                'End Custom code

                Dim imgButton As ImageButton = DirectCast(e.Item.FindControl("AddToCartImageButton"), ImageButton)
                Dim detailsButton As ImageButton = DirectCast(e.Item.FindControl("DetailsImageButton"), ImageButton)

                'If (Catalog.ProductChoice.GetChoiceCountForProduct(p.Bvin) > 0) OrElse _
                '    (Catalog.ProductModifier.GetModifierCountForProduct(p.Bvin) > 0) OrElse _
                '    (Catalog.ProductInput.GetInputCountForProduct(p.Bvin) > 0) OrElse _
                '    (p.IsKit) Then
                'commented by developer
                'detailsButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                detailsButton.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-view-detail.png")
                detailsButton.AlternateText = "Details"
                detailsButton.PostBackUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                detailsButton.CommandArgument = p.Bvin
                detailsButton.Visible = True
                imgButton.Visible = False
                'ElseIf p.InventoryStatus = Catalog.ProductInventoryStatus.NotAvailable Then
                '    imgButton.Visible = False
                '    detailsButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                '    detailsButton.AlternateText = "Details"
                '    detailsButton.PostBackUrl = "~/" & Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                '    detailsButton.CommandArgument = p.Bvin
                '    detailsButton.Visible = True
                'Else
                '    imgButton.ImageUrl = PersonalizationServices.GetThemedButton("AddToCart")
                '    'imgButton.AlternateText = "Add To Cart"
                '    'imgButton.CommandName = "AddToCart"
                '    'imgButton.CommandArgument = p.Bvin
                '    imgButton.Visible = True
                '    detailsButton.Visible = False


                '    'End If
                'End If


                'Dim PriceAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("PriceAnchor"), HtmlAnchor)
                'PriceAnchor.HRef = destinationLink
                'PriceAnchor.InnerText = p.GetSitePriceForDisplay(0D, pricingWorkflow)
                'PriceAnchor.Title = p.MetaKeywords.Replace(",", " ")


                Dim ltlPrice As Literal
                ltlPrice = DirectCast(e.Item.FindControl("ltlPrice"), Literal)
                ltlPrice.Text = p.GetSitePriceForDisplay(0D, pricingWorkflow)
            Else
                Dim NameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("NameAnchor"), HtmlAnchor)
                NameAnchor.InnerHtml = "Product Could Not Be Located."
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

    Protected Sub DataList2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList2.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim c As Catalog.Category = CType(e.Item.DataItem, Catalog.Category)
            If c IsNot Nothing Then

                Dim litRecord As Literal = e.Item.FindControl("litRecord")
                If litRecord IsNot Nothing Then

                    Dim destinationLink As String = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, _AllCats)
                    Dim imageUrl As String = "~/" & c.ImageUrl
                    imageUrl = Utilities.ImageHelper.SafeImage(imageUrl)
                    imageUrl = Page.ResolveUrl(imageUrl)

                    'Image
                    Dim imageAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordimageanchor"), HtmlAnchor)
                    imageAnchor.HRef = destinationLink
                    Dim image As HtmlImage = DirectCast(e.Item.FindControl("recordimageimg"), HtmlImage)
                    image.Src = imageUrl
                    image.Alt = c.Name

                    ' Force Image Size
                    ViewUtilities.ForceImageSize(image, c.ImageUrl, ViewUtilities.Sizes.Small, Me.Page)

                    'Name
                    Dim nameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordnameanchor"), HtmlAnchor)
                    nameAnchor.HRef = destinationLink
                    nameAnchor.InnerText = c.Name

                    'Dim sb As New StringBuilder
                    ''children
                    'sb.Append("<div class=""recordChildren"">")
                    'GenerateChildList(c, sb)
                    'sb.Append("</div>")
                    'litRecord.Text = sb.ToString
                Else
                    litRecord.Text = "Product could not be located"
                End If
            End If
        End If
    End Sub
End Class

