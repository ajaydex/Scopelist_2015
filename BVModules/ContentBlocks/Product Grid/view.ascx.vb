Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Product_Grid_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadProductGrid()
    End Sub

    Private Sub LoadProductGrid()
        Dim products As New Collection(Of Catalog.Product)
        Dim productList As Collection(Of Content.ComponentSettingListItem) = SettingsManager.GetSettingList("ProductGrid")
        If productList IsNot Nothing Then
            For Each csli As Content.ComponentSettingListItem In productList
                Dim bvin As String = csli.Setting1
                If Not String.IsNullOrEmpty(bvin) Then
                    Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(bvin)
                    If p IsNot Nothing AndAlso p.IsVisible Then
                        products.Add(p)
                    End If
                End If
            Next
        End If

        If products.Count > 0 Then
            Me.DataList1.DataSource = products
            Me.DataList1.DataBind()
            Me.DataList1.RepeatColumns = SettingsManager.GetIntegerSetting("GridColumns")

            Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
            Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")
        Else
            ' hide control if no products are found
            Me.Visible = False
        End If
    End Sub

    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim p As Catalog.Product = CType(e.Item.DataItem, Catalog.Product)

            Dim lnkImage As HyperLink = DirectCast(e.Item.FindControl("lnkImage"), HyperLink)
            Dim smallimage As HtmlImage = DirectCast(e.Item.FindControl("imagesmall"), HtmlImage)
            Dim lnkProduct As HyperLink = DirectCast(e.Item.FindControl("lnkProduct"), HyperLink)
            If (lnkImage IsNot Nothing) AndAlso (smallimage IsNot Nothing) Then
                smallimage.Src = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(p.ImageFileSmall, True))
                smallimage.Alt = HttpUtility.HtmlEncode(p.ImageFileSmallAlternateText)
                lnkImage.NavigateUrl = p.ProductURL

                ' Force Image Size
                ViewUtilities.ForceImageSize(smallimage, smallimage.Src, ViewUtilities.Sizes.Small, Me.Page)
            End If
            If lnkProduct IsNot Nothing Then
                lnkProduct.Text = p.ProductName
                lnkProduct.NavigateUrl = lnkImage.NavigateUrl
            End If
        End If
    End Sub

End Class