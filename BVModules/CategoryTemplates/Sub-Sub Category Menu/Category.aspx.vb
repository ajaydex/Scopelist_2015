Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.IO

Partial Class BVModules_CategoryTemplates_Sub_Sub_Category_Menu
    Inherits BaseStoreCategoryPage

    Private _AllCats As Collection(Of Catalog.Category) = Catalog.Category.FindAllLight()

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("Category.master")
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
            PopulateCategoryInfo()
        End If
        LoadMenu()
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

    Public Sub LoadMenu()
        Me.rptrSubCategories.DataSource = Catalog.Category.FindVisibleChildren(LocalCategory.Bvin)
        Me.rptrSubCategories.DataBind()
    End Sub

    Public Sub rptrSubCategories_ItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs) Handles rptrSubCategories.ItemDataBound
        Dim c As Catalog.Category = CType(e.Item.DataItem, Catalog.Category)
        Dim plSub As PlaceHolder = CType(e.Item.FindControl("plSub"), PlaceHolder)
        Dim lblCategoryHeading As Label = CType(e.Item.FindControl("lblCategoryHeading"), Label)
        Dim rptrSubSubCategories As Repeater = CType(e.Item.FindControl("rptrSubSubCategories"), Repeater)
        Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindVisibleChildren(c.Bvin)

        If children.Count > 0 Then
            plSub.Visible = True
            lblCategoryHeading.Text = String.Format("<h2>{0}</h2>", c.Name)
            AddHandler rptrSubSubCategories.ItemDataBound, AddressOf rptrSubSubCategories_ItemDataBound
            Dim childCategories As Collection(Of Catalog.Category) = Catalog.Category.FindVisibleChildren(c.Bvin)
            rptrSubSubCategories.DataSource = childCategories
            rptrSubSubCategories.DataBind()
        Else
            plSub.Visible = False
        End If
    End Sub

    Protected Sub rptrSubSubCategories_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim c As Catalog.Category = CType(e.Item.DataItem, Catalog.Category)
            If c IsNot Nothing Then

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
                nameAnchor.Title = c.MetaTitle
            End If
        End If
    End Sub


End Class
