Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_SuggestedItems
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load        
        Me.SuggestedItemsTitle.InnerText = Content.SiteTerms.GetTerm("SuggestedItems")

        Dim bvin As String = String.Empty
        bvin = Request.QueryString("ProductId")
        LoadProductGrid(bvin)
    End Sub

    Private Sub LoadProductGrid(ByVal bvin As String)
        Dim MyProducts As Collection(Of Catalog.Product) = PersonalizationServices.GetSuggestedItems(bvin)

        Dim SuggestedItems As New Collection(Of Catalog.Product)

        For Each p As Catalog.Product In myProducts
            If p.Bvin <> bvin Then
                SuggestedItems.Add(p)
            End If
        Next

        If SuggestedItems.Count <= 0 Then
            Me.SuggestedItemsPanel.Visible = False
        Else
            Me.SuggestedItemsPanel.Visible = True
            Me.DataList1.DataSource = SuggestedItems
            Me.DataList1.DataBind()
        End If

    End Sub


    Protected Sub DataList1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DataList1.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then            
            Dim image As HtmlImage = DirectCast(e.Item.FindControl("productImage"), HtmlImage)
            image.Src = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(DirectCast(e.Item.DataItem, Catalog.Product).ImageFileSmall, True))
            image.Alt = HttpUtility.HtmlEncode(DirectCast(e.Item.DataItem, Catalog.Product).ImageFileSmallAlternateText)

            If e.Item.DataItem IsNot Nothing Then
                Dim p As Catalog.Product = DirectCast(e.Item.DataItem, Catalog.Product)
                ' Force Image Size
                ViewUtilities.ForceImageSize(image, p.ImageFileSmall, ViewUtilities.Sizes.Small, Me.Page)                
            End If
        End If

    End Sub
End Class
