Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.IO

Partial Class BVModules_Themes_Foundation4_Responsive_CategoryTemplates_Sub_Category_Menu_Category
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
        Me.DataList1.DataSource = Catalog.Category.FindVisibleChildren(LocalCategory.Bvin)
        Me.DataList1.DataBind()
    End Sub

    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
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
                    nameAnchor.Title = c.MetaTitle

                    Dim sb As New StringBuilder
                    'children
                    sb.Append("<div class=""recordChildren"">")
                    GenerateChildList(c, sb)
                    sb.Append("</div>")
                    litRecord.Text = sb.ToString
                Else
                    litRecord.Text = "Product could not be located"
                End If
            End If
        End If
    End Sub

    Private Sub GenerateChildList(ByVal c As Catalog.Category, ByVal sb As StringBuilder)
        Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindVisibleChildren(c.Bvin)
        If children.Count > 0 Then
            sb.Append("<ul>")
            For Each child As Catalog.Category In children
                sb.Append("<li><a href=""")
                sb.Append(Utilities.UrlRewriter.BuildUrlForCategory(child, Me.Page, _AllCats))
                sb.Append(""">")
                sb.Append(child.Name)
                sb.Append("</a></li>")
            Next
            sb.Append("</ul>")
        End If
    End Sub


End Class
