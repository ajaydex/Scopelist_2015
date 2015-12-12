Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_CategoryTemplates_Scopelist_Grid_with_Logos_Category
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
            'Pager1.ItemsPerPage = itemsPerPage
            'Pager2.ItemsPerPage = itemsPerPage
            PopulateCategoryInfo()

            Dim rowCount As Integer = 0

            pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")

            'Dim displayProducts As Collection(Of Catalog.Product) = Nothing
            'If Me.ProductSearchCriteria IsNot Nothing Then
            '    displayProducts = LocalCategory.FindAllProductsByCriteria(Me.ProductSearchCriteria, Me.SortOrder, WebAppSettings.DisableInventory, False, Pager1.CurrentRow, Pager1.ItemsPerPage, rowCount)
            'Else
            '    displayProducts = LocalCategory.FindAllProducts(Me.SortOrder, WebAppSettings.DisableInventory, False, Pager1.CurrentRow, Pager1.ItemsPerPage, rowCount)
            'End If

            'If displayProducts.Count > 0 Then
            '    categorygridtemplate.Visible = True
            'Else
            '    categorygridtemplate.Visible = False
            'End If
            'If displayProducts.Count > 0 Then
            '    Dim manufacturerId As String = String.Empty
            '    For Each p As Catalog.Product In displayProducts
            '        If p.ManufacturerId <> String.Empty Then
            '            manufacturerId = p.ManufacturerId
            '            Exit For
            '        End If
            '    Next
            '    If manufacturerId <> String.Empty Then
            '        Dim m As Contacts.Manufacturer = Contacts.Manufacturer.FindByBvin(manufacturerId)
            '        If m IsNot Nothing Then
            '            'Commented By kamala
            '            'lblCategoriesTitle.Text = m.DisplayName & " Categories:"
            '            'end
            '            lblCategoriesTitle.Text = "<h2>" & m.DisplayName & " Categories:" & "</h2>"
            '        End If
            '    End If
            'End If
            'Me.DataList1.DataSource = displayProducts
            'Me.DataList1.DataBind()
            'Pager1.RowCount = rowCount
            'Pager2.RowCount = rowCount

            LoadSubCategories()
            'CategoryProductReview1.LoadReviews(LocalCategory.Bvin)
        End If
    End Sub
    Private Sub LoadSubCategories()
        _AllCats = Catalog.Category.FindAll()
        Dim cats As Collection(Of Catalog.Category) = Catalog.Category.FindChildrenInCollection(_AllCats, LocalCategory.Bvin, False)
        'If cats.Count > 0 Then
        '    lblCategoriesTitle.Visible = True
        'Else
        '    lblCategoriesTitle.Visible = False
        'End If
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

        End If

        ' Title
        If LocalCategory.ShowTitle = False Then
            Me.lblTitle.Visible = False

        Else
            startH1.Visible = True
            endH1.Visible = True

            Me.lblTitle.Visible = True
            Me.lblTitle.Text = LocalCategory.Name

        End If

        ' Description
        If LocalCategory.Description.Trim.Length > 0 Then
            Dim s As StringBuilder = New StringBuilder()
            s.Append(LocalCategory.Description)
            s.Replace("<a", "<a class='RightBlockHeading'")
            s.Replace("<ul>", "<ul class='desc'>")

            Me.DescriptionLiteral.Text = s.ToString()
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
    Protected Sub DataList2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList2.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim c As Catalog.Category = CType(e.Item.DataItem, Catalog.Category)
            If c IsNot Nothing Then

                Dim litRecord As Literal = e.Item.FindControl("litRecord")
                If litRecord IsNot Nothing Then

                    Dim destinationLink As String = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, _AllCats)

                    Dim nameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("recordnameanchor"), HtmlAnchor)
                    nameAnchor.HRef = destinationLink
                    nameAnchor.Title = c.Name

                    Dim CatTitle As HtmlAnchor = DirectCast(e.Item.FindControl("CatTitle"), HtmlAnchor)
                    CatTitle.InnerHtml = c.Name
                    CatTitle.HRef = destinationLink
                    Dim imgLogo As Image = DirectCast(e.Item.FindControl("imgLogo"), Image)
                    imgLogo.ImageUrl = c.ImageUrl
                Else
                    litRecord.Text = "Product could not be located"
                End If
            End If
        End If
    End Sub
End Class


