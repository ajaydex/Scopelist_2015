Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Linq

Partial Class BVModules_CategoryTemplates_Scopelist_Grid_with_Subs_no_Manufacturer_Name_Category
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

            If displayProducts.Count > 0 Then
                categorygridtemplate.Visible = True
            Else
                categorygridtemplate.Visible = False
            End If

            lblCategoriesTitle.Text = "Categories:"

            Select Case LocalCategory.DisplaySortOrder
                Case 1
                    Me.DataList1.DataSource = displayProducts.OrderByDescending(Function(p) p.IsInStock)
                Case Else
                    Me.DataList1.DataSource = displayProducts
            End Select

            Me.DataList1.DataBind()

            Pager1.RowCount = rowCount
            Pager2.RowCount = rowCount

            LoadSubCategories()
        End If
    End Sub

    Private Sub LoadSubCategories()
        _AllCats = Catalog.Category.FindAll()
        Dim cats As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(_AllCats, LocalCategory.Bvin, False)
        If cats.Count > 0 Then
            lblCategoriesTitle.Visible = True
        Else
            lblCategoriesTitle.Visible = False
            header4.Visible = False
        End If
        Me.DataList2.DataSource = cats
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
            'Me.lblTitle2.Visible = False
            Me.lblTitle3.Visible = False
        Else
            startH1.Visible = True
            endH1.Visible = True
            Me.lblTitle.Visible = True
            Me.lblTitle.Text = LocalCategory.Name

            startH2.Visible = True
            endH2.Visible = True
            Me.lblTitle3.Visible = True
            Me.lblTitle3.Text = "Best Selling " & LocalCategory.Name
        End If

        'Description
        If LocalCategory.Description.Trim.Length > 0 Then
            Dim s As String = LocalCategory.Description
            s = Replace(s, "<strong>", "")
            s = Replace(s, "</strong>", "")
            s = Replace(s, "<h3>", "<p><strong>")
            s = Replace(s, "</h3>", "</strong></p>")
            s = Replace(s, "<ul>", "<ul class='list_In_Descritpion'>")
            s = Replace(s, "<a", "<a class='Descritpion'")

            s = Replace(s, "eurooptic", "Optics Authority")
            s = Replace(s, "Eurooptic", "Optics Authority")
            s = Replace(s, "eurooptics", "Optics Authority")
            s = Replace(s, "euro optics", "Optics Authority")
            s = Replace(s, "scopelist ", "Optics Authority")


            Me.DescriptionLiteral.Text = "<p>" & s & "</p>"

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

                Dim anchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordimageanchor"), HtmlAnchor)
                anchor.HRef = destinationLink
                anchor.Title = p.ProductName

                Dim ProductImage As HtmlImage = DirectCast(e.Item.FindControl("ProductImage"), HtmlImage)
                ProductImage.Src = imageUrl
                ProductImage.Alt = p.ProductName & " " & p.Sku

                ' Force Image Size
                ViewUtilities.ForceImageSize(ProductImage, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

                anchor = DirectCast(e.Item.FindControl("recordnameanchor"), HtmlAnchor)
                anchor.HRef = destinationLink
                anchor.InnerHtml = p.ProductName
                anchor.Title = p.MetaKeywords.Replace(",", " ")

                Dim lnk As HyperLink = e.Item.FindControl("lnkAddToCart")
                lnk.NavigateUrl = Utilities.UrlRewriter.BuildUrlForProduct(p, Me)
                'lnk.ImageUrl = "~/" & PersonalizationServices.GetThemedButton("Details")
                lnk.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/NewImages/button-view-detail.png")
                lnk.ToolTip = p.MetaKeywords.Replace(",", " ")
                lnk.Text = "View Details"


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
                        If Not String.IsNullOrEmpty(str) Then
                            litDes3.Text = str
                        End If
                    End If

                End If

                ' Short Description
                Dim litDes As Web.UI.WebControls.Literal = DirectCast(e.Item.FindControl("recordshortdescriptionfield"), Literal)
                If litDes IsNot Nothing Then
                    litDes.Text = p.ShortDescription

                    anchor = DirectCast(e.Item.FindControl("recorddescriptionanchor"), HtmlAnchor)
                    anchor.HRef = destinationLink
                    anchor.Title = p.MetaKeywords.Replace(",", " ")

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
                        'commented by developer
                        'ProductTypeChoice.Text = "<strong>" & r.Item("DisplayName").ToString & "</strong>&nbsp;&nbsp" & r.Item("PropertyValue").ToString
                        ProductTypeChoice.Text = r.Item("DisplayName").ToString & "&nbsp;&nbsp" & r.Item("PropertyValue").ToString
                    Else
                        'commented by developer
                        'ProductTypeChoice.Text = ProductTypeChoice.Text & "<br /><strong>" & r.Item("DisplayName").ToString & "</strong>&nbsp;&nbsp" & r.Item("PropertyValue").ToString
                        ProductTypeChoice.Text = ProductTypeChoice.Text & "<br />" & r.Item("DisplayName").ToString & "&nbsp;&nbsp" & r.Item("PropertyValue").ToString
                    End If
                Loop
                r.Close()
                objConn.Close()
                'End Custom code

                'anchor = DirectCast(e.Item.FindControl("recordpriceanchor"), HtmlAnchor)
                'anchor.HRef = destinationLink
                'anchor.InnerText = p.GetSitePriceForDisplay(0D, pricingWorkflow)
                'anchor.Title = p.MetaKeywords.Replace(",", " ")

                'to display stock status to client
                Dim lblStockStatusList As Label = DirectCast(e.Item.FindControl("lblStockStatusList"), Label)

                If p.IsInStock Then
                    lblStockStatusList.Text = "In Stock"
                Else
                    lblStockStatusList.Text = "Back Order"
                End If

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
                    'Dim imageUrl As String = "~/" & c.ImageUrl
                    'imageUrl = Utilities.ImageHelper.SafeImage(imageUrl)
                    'imageUrl = Page.ResolveUrl(imageUrl)

                    ''Image
                    'Dim imageAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordimageanchor"), HtmlAnchor)
                    'imageAnchor.HRef = destinationLink
                    'Dim image As HtmlImage = DirectCast(e.Item.FindControl("recordimageimg"), HtmlImage)
                    'image.Src = imageUrl
                    'image.Alt = c.Name

                    ' Force Image Size
                    'ViewUtilities.ForceImageSize(image, c.ImageUrl, ViewUtilities.Sizes.Small, Me.Page)

                    'Name
                    Dim nameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordnameanchor"), HtmlAnchor)
                    nameAnchor.HRef = destinationLink
                    'commented by developer
                    ' nameAnchor.InnerHtml = "<img src=""" & ResolveUrl(PersonalizationServices.GetPersonalizedThemeVirtualPath & "images/list.jpg") & """ />" & c.Name
                    nameAnchor.InnerHtml = c.Name
                    nameAnchor.Title = c.MetaKeywords.Replace(",", " ")

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
