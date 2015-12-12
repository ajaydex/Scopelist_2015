Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_CategoryTemplates_Grid_Full_Width_Category
    Inherits BaseStoreCategoryPage

    Dim pricingWorkflow As BusinessRules.Workflow = Nothing

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Default.master")
        Me.BlockId = "b8610e46-3c26-4884-9343-befd1d62a96c"
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
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

            pricingWorkflow = BusinessRules.Workflow.FindByName("Product Pricing")
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
            Me.lblTitle.Text = "<h1>" & LocalCategory.Name & "</h1>"
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

                DirectCast(e.Item.FindControl("ImageAnchor"), HtmlAnchor).HRef = destinationLink
                Dim ProductImage As HtmlImage = DirectCast(e.Item.FindControl("ProductImage"), HtmlImage)
                ProductImage.Src = imageUrl
                ProductImage.Alt = p.ProductName & " " & p.Sku

                ' Force Image Size
                ViewUtilities.ForceImageSize(ProductImage, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)

                Dim NameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("NameAnchor"), HtmlAnchor)
                NameAnchor.HRef = destinationLink
                NameAnchor.InnerHtml = p.ProductName

                Dim SkuAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("SkuAnchor"), HtmlAnchor)
                SkuAnchor.HRef = destinationLink
                SkuAnchor.InnerText = p.Sku

                Dim PriceAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("PriceAnchor"), HtmlAnchor)
                PriceAnchor.HRef = destinationLink
                PriceAnchor.InnerText = p.GetSitePriceForDisplay(0D, pricingWorkflow)
            Else
                Dim NameAnchor As HtmlAnchor = DirectCast(e.Item.FindControl("NameAnchor"), HtmlAnchor)
                NameAnchor.InnerHtml = "Product Could Not Be Located."
            End If
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

End Class