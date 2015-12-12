Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Grid_with_Subs_Category
    Inherits BaseStoreCategoryPage

    Private _AllCats As Collection(Of Catalog.Category) = Nothing

    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Public Event AddToCartClicked(ByVal productId As String)

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

    Protected Sub AddToCartClickedHandler(ByVal productId As String) Handles ProductGridDisplay.AddToCartClicked
        RaiseEvent AddToCartClicked(productId)
    End Sub


    Protected Sub PageLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If LocalCategory IsNot Nothing Then
            Pager1.ItemsPerPage = Me.SettingsManager.GetIntegerSetting("ItemsPerPage")
            Pager2.ItemsPerPage = Me.SettingsManager.GetIntegerSetting("ItemsPerPage")
            PopulateCategoryInfo()

            Dim rowCount As Integer = 0

            Dim items As Collection(Of Catalog.Product) = Nothing
            If Me.ProductSearchCriteria IsNot Nothing Then
                items = LocalCategory.FindAllProductsByCriteria(Me.ProductSearchCriteria, Me.SortOrder, WebAppSettings.DisableInventory, False, Pager1.CurrentRow, Pager1.ItemsPerPage, rowCount)
            Else
                items = LocalCategory.FindAllProducts(Me.SortOrder, WebAppSettings.DisableInventory, False, Pager1.CurrentRow, Pager1.ItemsPerPage, rowCount)
            End If

            pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")

            ProductGridDisplay.DataSource = items
            ProductGridDisplay.BindProducts()
            Pager1.RowCount = rowCount
            Pager2.RowCount = rowCount

            LoadSubCategories()
        End If
    End Sub

    Private Sub LoadSubCategories()
        _AllCats = Catalog.Category.FindAllLight()
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

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        If Pager1.Visible Then
            Select Case DirectCast(Me.SettingsManager.GetIntegerSetting("PagerMode"), Controls.PagerModes)
                Case BVSoftware.BVC5.Core.Controls.PagerModes.Top
                    Pager1.Visible = True
                    Pager2.Visible = False
                Case BVSoftware.BVC5.Core.Controls.PagerModes.Bottom
                    Pager1.Visible = False
                    Pager2.Visible = True
                Case BVSoftware.BVC5.Core.Controls.PagerModes.Both
                    Pager1.Visible = True
                    Pager2.Visible = True
            End Select
        End If
    End Sub

    Protected Sub DataList2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList2.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
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