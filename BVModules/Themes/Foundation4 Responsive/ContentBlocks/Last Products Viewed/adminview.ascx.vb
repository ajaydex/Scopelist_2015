Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Themes_Foundation4_Responsive_ContentBlocks_Last_Products_Viewed_adminview
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadProductGrid()
    End Sub

    Private Sub LoadProductGrid()
        Dim myProducts As Collection(Of Catalog.Product) = PersonalizationServices.GetProductsViewed

        Dim n As New Collection(Of Catalog.Product)
        Dim i As Integer = 0

        For Each p As Catalog.Product In myProducts
            If i < WebAppSettings.LastProductsViewedMaxResults Then
                n.Add(p)
                i += 1
            End If
        Next

        If myProducts IsNot Nothing Then
            Me.DataList1.DataSource = n
            Me.DataList1.DataBind()

            Dim display As Integer = SettingsManager.GetIntegerSetting("LPVDisplayTypeRad").ToString

            If display = 0 Then
                Me.DataList1.RepeatDirection = RepeatDirection.Horizontal
                Me.DataList1.RepeatColumns = SettingsManager.GetIntegerSetting("LPVGridColumnsField")
            ElseIf display = 1 Then
                Me.DataList1.RepeatDirection = RepeatDirection.Vertical
                Me.DataList1.RepeatColumns = SettingsManager.GetIntegerSetting("LPVDisplayTypeRad")
            Else
                Me.DataList1.RepeatDirection = RepeatDirection.Horizontal
                Me.DataList1.RepeatColumns = 3
            End If

        End If

        Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
        Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")
    End Sub

    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            If e.Item.DataItem IsNot Nothing Then
                Dim image As HtmlImage = DirectCast(e.Item.FindControl("imagesmall"), HtmlImage)
                Dim product As Catalog.Product = DirectCast(e.Item.DataItem, Catalog.Product)
                image.Src = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(product.ImageFileSmall, True))
                image.Alt = HttpUtility.HtmlEncode(product.ImageFileSmallAlternateText)
            End If
        End If
    End Sub
End Class
