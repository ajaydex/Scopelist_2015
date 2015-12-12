Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Linq
Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CategoryTemplates_Scopelist_Category___4_Col_category
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

            PopulateCategoryInfo()

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
        End If

        ' Title
        If LocalCategory.ShowTitle = False Then
            Me.lblTitle.Visible = False
        Else
            Me.lblTitle.Visible = True
            Me.lblTitle.Text = LocalCategory.Name
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





