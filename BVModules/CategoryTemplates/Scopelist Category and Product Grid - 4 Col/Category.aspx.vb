Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CategoryTemplates_Scopelist_Category_and_Product_Grid___4_Col_Category
    Inherits BaseStoreCategoryPage

    Private _AllCats As Collection(Of Catalog.Category) = Nothing
    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("NewCategory.master")
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

            'code to hide left menu dynamically only for fathers day
            Dim rightDiv As HtmlGenericControl = Me.Master.FindControl("bigColumn")
            rightDiv.Attributes.Add("class", "one-column")

            'code to load the fathers day banner dynamically
            'Dim bannerControl As BVModules_Controls_ContentColumnControl = Me.Master.FindControl("ContentColumnControlBanner")
            'bannerControl.ColumnName = "System Fathers Day Banner"

            Dim itemsPerPage As Integer = Me.SettingsManager.GetIntegerSetting("ItemsPerPage")
            If itemsPerPage = 0 Then
                itemsPerPage = 6
            End If
            Pager1.ItemsPerPage = itemsPerPage
            Pager2.ItemsPerPage = itemsPerPage
            PopulateCategoryInfo()

            Dim rowCount As Integer = 0

            pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")

            Dim allDisplayProducts As Collection(Of Catalog.Product) = Nothing
            Dim displayProducts As List(Of Catalog.Product) = Nothing

            If Me.ProductSearchCriteria IsNot Nothing Then
                allDisplayProducts = LocalCategory.FindAllProductsByCriteria(Me.ProductSearchCriteria, Me.SortOrder, WebAppSettings.DisableInventory, False, 0, 100, rowCount)
            Else
                allDisplayProducts = LocalCategory.FindAllProducts(Me.SortOrder, WebAppSettings.DisableInventory, False, 0, 100, rowCount)
            End If

            Select Case LocalCategory.DisplaySortOrder
                Case 1
                    displayProducts = allDisplayProducts.OrderByDescending(Function(p) p.IsInStock).ThenByDescending(Function(p) p.CreationDate).Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()
                Case Else
                    displayProducts = allDisplayProducts.Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()
            End Select

            'If Not Content.SiteTerms.GetTerm("ProductsDisplayOption") Is Nothing And Content.SiteTerms.GetTerm("ProductsDisplayOption") <> String.Empty Then
            '    Select Case Content.SiteTerms.GetTerm("ProductsDisplayOption")

            '        Case "All Regular + Demo InStock"

            '            Dim DemoInStock As List(Of Catalog.Product)
            '            DemoInStock = allDisplayProducts.Where(Function(p) p.ProductName.Contains("Demo") And p.IsInStock = True).OrderByDescending(Function(p) p.IsInStock).ThenByDescending(Function(p) p.CreationDate).Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()

            '            Dim AllRegular As List(Of Catalog.Product)
            '            AllRegular = allDisplayProducts.Where(Function(p) Not p.ProductName.Contains("Demo")).OrderByDescending(Function(p) p.IsInStock).ThenByDescending(Function(p) p.CreationDate).Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()

            '            For Each p As Catalog.Product In DemoInStock
            '                AllRegular.Add(p)
            '            Next

            '            displayProducts = AllRegular

            '        Case "InStock"
            '            displayProducts = allDisplayProducts.Where(Function(p) p.IsInStock = True).OrderByDescending(Function(p) p.IsInStock).ThenByDescending(Function(p) p.CreationDate).Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()
            '        Case Else
            '            displayProducts = allDisplayProducts.OrderByDescending(Function(p) p.IsInStock).ThenByDescending(Function(p) p.CreationDate).Skip(Pager1.CurrentRow).Take(Pager1.ItemsPerPage).ToList()
            '    End Select
            'End If


            If displayProducts.Count > 0 Then
                categorygridtemplate.Visible = True
            Else
                categorygridtemplate.Visible = False
            End If

            Select Case LocalCategory.DisplaySortOrder
                Case 1
                    Me.DataList1.DataSource = displayProducts
                Case Else
                    Me.DataList1.DataSource = displayProducts
            End Select

            Me.DataList1.DataBind()

            Pager1.RowCount = rowCount
            Pager2.RowCount = rowCount

            lblSubCategoriesHeading.Text = LocalCategory.Name & " Categories"

            LoadSubCategories()
        End If
    End Sub

    Private Sub LoadSubCategories()
        _AllCats = Catalog.Category.FindAll()
        Dim cats As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(_AllCats, LocalCategory.Bvin, False)
        If cats.Count > 0 Then
            ltlSubHeadingStart.Visible = True
            ltlSubHeadingEnd.Visible = True
            lblSubCategoriesHeading.Visible = True
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
        Else
            CType(Page, BaseStorePage).MetaKeywords = LocalCategory.Name
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
            Me.lblTitle3.Visible = False
        Else
            Me.lblTitle.Visible = True
            Me.lblTitle.Text = LocalCategory.Name
            Me.lblTitle3.Visible = True
            Me.lblTitle3.Text = "Best Selling " & LocalCategory.Name
        End If


        If LocalCategory.BannerImageUrl.Trim.Length > 0 Then
            Me.BannerImage.Visible = True
            Me.BannerImage.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(LocalCategory.BannerImageUrl, True))
            Me.BannerImage.AlternateText = LocalCategory.Name
        Else
            Me.BannerImage.Visible = False
        End If

        'Description

        If LocalCategory.Description.Trim.Length > 0 Then

            Dim s As StringBuilder = New StringBuilder()
            s.Append(LocalCategory.Description)
            s.Replace("<a", "<a class='RightBlockHeading'")
            s.Replace("<ul>", "<ul class='desc'>")

            Dim str As String = s.ToString()
            If (str.Length > 600) Then
                Dim indexOfFullStop As Integer = str.IndexOf(". ", 600)
                If indexOfFullStop <> -1 Then
                    Me.DescriptionLiteral.Text = str.Substring(0, indexOfFullStop + 2)
                    Me.DescriptionLiteralHidden.Text = str.Substring(indexOfFullStop + 2, str.Length - (indexOfFullStop + 2))
                Else
                    Me.DescriptionLiteral.Text = str
                    Me.ShowHideButton.Style("display") = "none"
                End If
            Else
                Me.DescriptionLiteral.Text = str
                Me.ShowHideButton.Style("display") = "none"
            End If
        Else
            Me.ShowHideButton.Style("display") = "none"
            Me.DescriptionLiteral.Text = String.Empty
        End If

    End Sub

    Protected Sub DataList2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList2.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim c As Catalog.Category = CType(e.Item.DataItem, Catalog.Category)
            If c IsNot Nothing Then

                'Dim litRecord As Literal = e.Item.FindControl("litRecord")
                'If litRecord IsNot Nothing Then

                Dim destinationLink As String = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, _AllCats)

                'Name
                Dim nameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordnameanchor"), HtmlAnchor)
                nameAnchor.HRef = destinationLink

                Dim imageUrl As String

                If Not c.ImageUrl Is Nothing Then
                    imageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(c.ImageUrl, True))
		    nameAnchor.InnerHtml = "<img src=""" & ResolveUrl(c.ImageUrl) & """ width=""181"" height=""106"" alt=""" & c.Name & """ />" & c.Name
                End If

                nameAnchor.Title = c.Name

                'Dim CatTitle As HtmlAnchor = DirectCast(e.Item.FindControl("CatTitle"), HtmlAnchor)
                'CatTitle.InnerHtml = c.Name
                'CatTitle.HRef = destinationLink


                'Dim imgCategoryLogo As Image = DirectCast(e.Item.FindControl("imgCategoryLogo"), Image)
                'imgCategoryLogo.ImageUrl = Page.ResolveUrl("~/" & LocalCategory.ImageUrl)

                'Else
                '    litRecord.Text = "Product could not be located"
                'End If


                Dim imgLogo As Image = DirectCast(e.Item.FindControl("imgCategoryLogo"), Image)
                If Not LocalCategory.MenuOnImageUrl Is Nothing Then
                    If File.Exists(Server.MapPath("~" & LocalCategory.MenuOnImageUrl)) Then
                        imgLogo.ImageUrl = Page.ResolveUrl("~" + LocalCategory.MenuOnImageUrl)
                        imgLogo.ToolTip = LocalCategory.Name
                        imgLogo.AlternateText = LocalCategory.Name
                    Else
			'imgLogo.Attributes.Add("style", "display:none;")
                        imgLogo.Visible = False
                    End If
                Else
		   'imgLogo.Attributes.Add("style", "display:none;")
                    imgLogo.Visible = False
                End If
            End If
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
		anchor.InnerHtml = "<img src=""" & ResolveUrl(imageUrl) & """ width=""181"" height=""106"" alt=""" & p.ProductName & """ />" & "<p style='text-align:center;padding-bottom: 0px;'>" & p.ProductName & "</p>"

                'Dim imgLogo As Image = DirectCast(e.Item.FindControl("imgLogo"), Image)
                'imgLogo.ImageUrl = Page.ResolveUrl("~/Images/icon/" + GetProductManufacturer(p) + ".jpg")
                'imgLogo.ToolTip = GetProductManufacturer(p)
                'imgLogo.AlternateText = GetProductManufacturer(p)

                'Dim lnkOffer As HyperLink = DirectCast(e.Item.FindControl("lnkOffer"), HyperLink)
                'lnkOffer.ToolTip = p.ProductName
                'lnkOffer.NavigateUrl = destinationLink
                'lnkOffer.Text = "Buy Now"

                Dim IsBannerDisplay As Boolean = True
                Dim ManufacturerName As String = GetProductManufacturer(p)
                Dim BrandsToExclude As String()
                BrandsToExclude = Content.SiteTerms.GetTerm("ExcludedBrandName").Split(",")

                For Each m In BrandsToExclude
                    If ManufacturerName.Contains(m) Then
                        IsBannerDisplay = False
                    End If
                Next

                'If Not Content.SiteTerms.GetTerm("EnableBanner") Is Nothing And Content.SiteTerms.GetTerm("EnableBanner") <> String.Empty Then
                '    If Not Content.SiteTerms.GetTerm("ExcludedBrandName") Is Nothing And Content.SiteTerms.GetTerm("ExcludedBrandName") <> String.Empty And IsBannerDisplay Then
                '        If Boolean.Parse(Content.SiteTerms.GetTerm("EnableBanner")) Then
                '            lnkOffer.Text = "Make an Offer"
                '        Else
                '            lnkOffer.Text = "Buy Now"
                '        End If
                '    Else
                '        lnkOffer.Text = "Buy Now"
                '    End If
                'Else
                '    lnkOffer.Text = "Buy Now"
                'End If

                'Dim ProductImage As HtmlImage = DirectCast(e.Item.FindControl("ProductImage"), HtmlImage)
                'ProductImage.Src = imageUrl
                'ProductImage.Alt = p.ProductName & " " & p.Sku

                ' Force Image Size
                'ViewUtilities.ForceImageSize(ProductImage, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

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

                'to display stock status to client
                Dim lblStockStatusGrid As Label = DirectCast(e.Item.FindControl("lblStockStatusGrid"), Label)

                If p.IsInStock Then
                    lblStockStatusGrid.Text = "In Stock"
                Else
                    lblStockStatusGrid.Text = "Back Order"
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

    Protected Function GetProductManufacturer(ByRef p As Catalog.Product) As String
        Dim result As String = String.Empty

        If Not String.IsNullOrEmpty(p.ManufacturerId) AndAlso p.ManufacturerId <> "- No Manufacturer -" Then
            Dim m As Contacts.Manufacturer = Contacts.Manufacturer.FindByBvin(p.ManufacturerId)
            If m IsNot Nothing AndAlso Not String.IsNullOrEmpty(m.Bvin) Then
                result = m.DisplayName
            End If
        End If

        Return result
    End Function

End Class
