Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_ContentBlocks_Last_Products_Viewed_view
    Inherits Content.BVModule

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.LPVTitle.Text = Content.SiteTerms.GetTerm("RecentlyViewedItems")
        LoadProductGrid()
    End Sub

    Private Sub LoadProductGrid()
        Dim i As Integer = 0

        Dim products As New Collection(Of Catalog.Product)
        For Each p As Catalog.Product In PersonalizationServices.GetProductsViewed()
            If i < WebAppSettings.LastProductsViewedMaxResults Then
                If p IsNot Nothing Then
                    If Not String.IsNullOrEmpty(p.ParentId) Then
                        p = Catalog.InternalProduct.FindByBvinLight(p.ParentId)
                    End If

                    If p IsNot Nothing AndAlso p.IsVisible Then
                        If Not products.Contains(p) Then
                            products.Add(p)
                            i += 1
                        End If
                    End If
                End If
            End If
        Next

        If products.Count > 0 Then
            ProductGrid.Visible = True
            PreHtml.Visible = True
            PostHtml.Visible = True

            Me.DataList1.DataSource = products
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
            Me.PreHtml.Text = SettingsManager.GetSetting("PreHtml")
            Me.PostHtml.Text = SettingsManager.GetSetting("PostHtml")
        Else
            ProductGrid.Visible = False
            PreHtml.Visible = False
            PostHtml.Visible = False
        End If
    End Sub


    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            If e.Item.DataItem IsNot Nothing Then
                Dim image As HtmlImage = DirectCast(e.Item.FindControl("imagesmall"), HtmlImage)
                Dim product As Catalog.Product = DirectCast(e.Item.DataItem, Catalog.Product)
                image.Src = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(product.ImageFileSmall, True))
                image.Alt = HttpUtility.HtmlEncode(product.ProductName)

                ' Force Image Size
                ViewUtilities.ForceImageSize(image, product.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)                
            End If
        End If
    End Sub
End Class
