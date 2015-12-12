Imports System.Collections.ObjectModel
Imports System.Linq
Imports BVSoftware.BVC5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Category_Grid_view
    Inherits Content.BVModule

    Private allCats As Collection(Of Catalog.Category)
    Private itemCount As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Title
        Dim title As String = SettingsManager.GetSetting("Title")
        Dim headingTag As String = SettingsManager.GetSetting("HeadingTag")
        If String.IsNullOrEmpty(title) Then
            Me.litTitle.Visible = False
        Else
            Me.litTitle.Text = String.Format("<{0}>{1}</{0}>", headingTag, title)
        End If

        Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")

        LoadCategoryGrid()
    End Sub

    Private Sub LoadCategoryGrid()
        allCats = Catalog.Category.FindAllLight()

        Dim categories As New Collection(Of Catalog.Category)
        For Each bvin As String In SettingsManager.GetSettingList("Categories").Select(Function(csli) csli.Setting1).ToList()
            If Not String.IsNullOrEmpty(bvin) Then
                Dim c As Catalog.Category = Catalog.Category.FindInCollection(allCats, bvin)
                If c IsNot Nothing AndAlso Not c.Hidden Then
                    categories.Add(c)
                End If
            End If
        Next

        itemCount = categories.Count()

        Me.dlCategories.DataSource = categories
        Me.dlCategories.DataBind()
        Me.dlCategories.RepeatColumns = SettingsManager.GetIntegerSetting("Columns")
    End Sub

    Protected Sub dlCategories_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlCategories.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim c As Catalog.Category = CType(e.Item.DataItem, Catalog.Category)

            Dim lnkImage As HyperLink = DirectCast(e.Item.FindControl("lnkImage"), HyperLink)
            Dim smallimage As HtmlImage = DirectCast(e.Item.FindControl("imagesmall"), HtmlImage)
            Dim lnkProduct As HyperLink = DirectCast(e.Item.FindControl("lnkCategory"), HyperLink)
            If (lnkImage IsNot Nothing) AndAlso (smallimage IsNot Nothing) Then
                smallimage.Src = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(c.ImageUrl, True))
                smallimage.Alt = HttpUtility.HtmlEncode(c.Name)
                lnkImage.NavigateUrl = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page.Request, allCats)

                ' Force Image Size
                ViewUtilities.ForceImageSize(smallimage, smallimage.Src, ViewUtilities.Sizes.Small, Me.Page)
            End If
            If lnkProduct IsNot Nothing Then
                lnkProduct.Text = c.Name
                lnkProduct.NavigateUrl = lnkImage.NavigateUrl
                lnkProduct.ToolTip = c.MetaTitle
            End If

            ' Set appropriate classes
            Dim containerDiv As HtmlGenericControl = DirectCast(e.Item.FindControl("containerDiv"), HtmlGenericControl)
            containerDiv.Attributes("class") = Me.GetColumnClassName(SettingsManager.GetIntegerSetting("Columns"))
            If e.Item.ItemIndex = (Me.itemCount - 1) Then
                containerDiv.Attributes("class") += " end"
            End If
        End If
    End Sub

    Private Function GetColumnClassName(ByVal Columns As Integer) As String
        Return String.Format("large-{0} columns", (12 / Columns).ToString())
    End Function

End Class
