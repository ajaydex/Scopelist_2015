Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Categories_ManualSelection
    Inherits BaseAdminPage

    Public CategoryBvin As String = String.Empty

    Private _displayButtons As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            If Request.QueryString("id") IsNot Nothing Then                
                Me.BvinField.Value = Request.QueryString("id")
                If Request.QueryString("type") IsNot Nothing Then
                    ViewState("type") = Request.QueryString("type")
                End If
                Me.lnkBack.NavigateUrl = "~/BVAdmin/Catalog/Categories_Edit.aspx?id=" & Me.BvinField.Value
                Me.lnkImportExport.NavigateUrl = "~/BVAdmin/ImportExport.aspx?id=0284309E-BF9A-4D39-900A-26E5AE3FC419&categoryId=" & Me.BvinField.Value
            Else
                ' No bvin so send back to categories page
                Response.Redirect("Categories.aspx")
            End If
        End If

        LoadCategory()
        CategoryBvin = Me.BvinField.Value
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Products for Category"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub LoadCategory()
        Dim c As Catalog.Category
        c = Catalog.Category.FindByBvin(Me.BvinField.Value)
        If Not c Is Nothing Then
            If c.Bvin <> String.Empty Then
                If c.DisplaySortOrder = Catalog.CategorySortOrder.ManualOrder OrElse c.DisplaySortOrder = Catalog.CategorySortOrder.None Then
                    _displayButtons = True
                Else
                    _displayButtons = False
                End If


                Dim allProducts As Collection(Of Catalog.Product) = c.FindAllProducts(c.DisplaySortOrder, True, True)

                Me.litProducts.Text = RenderProductList(allProducts)

                ' Exclude existing products from search results
                If Not Page.IsPostBack Then
                    Me.ProductPicker1.ExcludeCategoryBvin = c.Bvin
                End If

            End If
        End If
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAdd.Click
        Me.msg.ClearMessage()
        If Me.ProductPicker1.SelectedProducts.Count = 0 Then
            msg.ShowInformation("Please select products to add first.")
        End If
        For Each s As String In Me.ProductPicker1.SelectedProducts
            Catalog.Category.AddProduct(Me.BvinField.Value, s)
        Next
        LoadCategory()
        Me.ProductPicker1.LoadSearch()
    End Sub

    Private Function RenderProductList(ByVal products As Collection(Of Catalog.Product)) As String
        Dim result As String = String.Empty

        Dim sb As New StringBuilder()

        If (products IsNot Nothing) Then
            For Each p As Catalog.Product In products
                RenderSingleProduct(p, sb)
            Next
        End If

        result = sb.ToString()

        Return result
    End Function
    Private Sub RenderSingleProduct(ByVal p As Catalog.Product, ByVal sb As StringBuilder)

        sb.Append("<div class=""dragitem"" id=""" & p.Bvin & """>")

        sb.Append("<table border=""0"" cellspacing=""0"" cellpadding=""2"" width=""100%"">")
        sb.Append("<tr>")
        sb.Append("<td width=""25%"">" & p.Sku & "</td>")
        sb.Append("<td width=""50%"">" & p.ProductName & "</td>")
        sb.Append("<td><a href=""Categories_RemoveProducts.aspx"" title=""Remove Product"" id=""rem" & p.Bvin & """ class=""trash""><img src=""../../images/system/trashcan.png"" alt=""Remove Product"" border=""0"" /></a></td>")
        sb.Append("<td class=""handle"" align=""right""><img src=""../../images/system/draghandle.png"" alt=""sort"" border=""0"" /></td>")
        sb.Append("</tr>")
        sb.Append("</table>")
        sb.Append("</div>")

    End Sub

End Class
