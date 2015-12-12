Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_CategoryTemplates_Scopelist_Reticle_Detailed_List1_Category
    Inherits BaseStoreCategoryPage

    Private wf As BusinessRules.Workflow
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
            wf = BusinessRules.Workflow.FindByName("Product Pricing")
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
        Else
            CType(Page, BaseStorePage).MetaKeywords = LocalCategory.Name
        End If

        ' Meta Description
        If LocalCategory.MetaDescription.Trim.Length > 0 Then
            CType(Page, BaseStorePage).MetaDescription = LocalCategory.MetaDescription
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
            Me.lblTitle2.Visible = True
            Me.lblTitle2.Text = LocalCategory.Name
            startH2.Visible = True
            endH2.Visible = True
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

    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
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
                anchor.Title = p.ProductName

                Dim img As HtmlImage = DirectCast(e.Item.FindControl("recordimage"), HtmlImage)
                img.Src = imageUrl
                img.Alt = HttpUtility.HtmlEncode(p.ImageFileSmallAlternateText)

                ' Force Image Size
                ViewUtilities.ForceImageSize(img, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

                ' Sku
                'anchor = DirectCast(e.Item.FindControl("recordskuanchor"), HtmlAnchor)
                'anchor.HRef = destinationLink
                'anchor.InnerText = p.Sku
                'anchor.Title = p.MetaKeywords.Replace(",", " ")

                ' Name
                anchor = DirectCast(e.Item.FindControl("recordnameanchor"), HtmlAnchor)
                anchor.HRef = destinationLink
                anchor.InnerHtml = p.ProductName
                anchor.Title = p.MetaKeywords.Replace(",", " ")

                ' Short Description
                Dim litDes As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("recordshortdescriptionfield"), Literal)
                If litDes IsNot Nothing Then
                    litDes.Text = p.ShortDescription

                    anchor = DirectCast(e.Item.FindControl("recorddescriptionanchor"), HtmlAnchor)
                    anchor.HRef = destinationLink
                    anchor.Title = p.MetaKeywords.Replace(",", " ")

                End If

                If p.ProductTypeId <> String.Empty AndAlso p.ManufacturerId <> String.Empty Then
                    Dim t As Catalog.ProductType = Catalog.ProductType.FindByBvin(p.ProductTypeId)
                    Dim m As Contacts.Manufacturer = Contacts.Manufacturer.FindByBvin(p.ManufacturerId)
                    If t IsNot Nothing And m IsNot Nothing Then

                        Dim litReview As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("reviewtitlefield"), Literal)
                        If litReview IsNot Nothing Then
                            litReview.Text = m.DisplayName & " " & t.ProductTypeName & " Review"
                        End If

                    End If
                End If

                Dim info As ProductInfo = ProductInfo.FindByProduct(p.Bvin)
                If info IsNot Nothing Then

                    If info.MPN <> String.Empty Then
                        anchor = DirectCast(e.Item.FindControl("recordmpnanchor"), HtmlAnchor)
                        anchor.HRef = destinationLink
                        anchor.InnerText = info.MPN
                        anchor.Title = p.MetaKeywords.Replace(",", " ")
                    End If

                    If info.Subtitle <> String.Empty Then
                        anchor = DirectCast(e.Item.FindControl("recordsubtitleanchor"), HtmlAnchor)
                        anchor.HRef = destinationLink
                        anchor.InnerText = info.Subtitle
                        anchor.Title = p.MetaKeywords.Replace(",", " ")
                    End If

                    Dim litDes2 As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("recordshortdescriptionfield2"), Literal)
                    If litDes2 IsNot Nothing Then
                        litDes2.Text = info.ShortDescription2
                    End If

                    Dim litDes3 As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("recordshortdescriptionfield3"), Literal)
                    If litDes3 IsNot Nothing Then
                        Dim str As String = info.ShortDescription3
                        str = str.Replace("<p>", "<li>")
                        str = str.Replace("</p>", "</li>")
                        str = str.Replace("<b>", "")
                        str = str.Replace("</b>", "")
                        str = str.Replace("<strong>", "")
                        str = str.Replace("</strong>", "")
                        str = str.Replace("<p >", "")
                        str = str.Replace("</strong>", "")
                        str = str.Replace("<p align=""left"">", "")
                        str = str.Replace("</p>", "")
                        'commented by developer
                        'litDes3.Text = info.ShortDescription3
                        litDes3.Text = str
                    End If

                End If

                ' Price
                'commented by developer on april 9
                'anchor = DirectCast(e.Item.FindControl("recordpriceanchor"), HtmlAnchor)
                'anchor.HRef = destinationLink
                'anchor.InnerText = p.GetSitePriceForDisplay(0D, wf)
                'anchor.Title = p.MetaKeywords.Replace(",", " ")

                Dim ltlPrice As Literal
                ltlPrice = DirectCast(e.Item.FindControl("ltlPrice"), Literal)
                ltlPrice.Text = p.GetSitePriceForDisplay(0D, wf)

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
                        ProductTypeChoice.Text = "<br>" & r.Item("DisplayName").ToString & "&nbsp;&nbsp" & r.Item("PropertyValue").ToString
                    Else
                        ProductTypeChoice.Text = ProductTypeChoice.Text & "<br /> " & r.Item("DisplayName").ToString & "&nbsp;&nbsp" & r.Item("PropertyValue").ToString
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
                ' detailsButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                detailsButton.AlternateText = "Details"
                detailsButton.PostBackUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                detailsButton.CommandArgument = p.Bvin
                detailsButton.Visible = True
                imgButton.Visible = False
                'Else
                '    imgButton.ImageUrl = PersonalizationServices.GetThemedButton("AddToCart")
                '    imgButton.AlternateText = "Add To Cart"
                '    imgButton.CommandName = "AddToCart"
                '    imgButton.CommandArgument = p.Bvin
                '    imgButton.Visible = True
                '    detailsButton.Visible = False
                '    If p.InventoryStatus = Catalog.ProductInventoryStatus.NotAvailable Then
                '        imgButton.Visible = False
                '        detailsButton.ImageUrl = PersonalizationServices.GetThemedButton("Details")
                '        detailsButton.AlternateText = "Details"
                '        detailsButton.PostBackUrl = "~/" & Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                '        detailsButton.CommandArgument = p.Bvin
                '        detailsButton.Visible = True
                '    End If
                'End If

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
