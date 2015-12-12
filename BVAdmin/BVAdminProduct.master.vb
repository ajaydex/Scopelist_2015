Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_BVAdminProduct
    Inherits System.Web.UI.MasterPage

    Public Property ShowProductDisplayPanel() As Boolean
        Get
            Return ProductDisplayPanel.Visible
        End Get
        Set(ByVal value As Boolean)
            ProductDisplayPanel.Visible = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("id") IsNot Nothing Then
            Dim prod As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(Request.QueryString("id"))
            productImage.ImageUrl = Page.ResolveUrl(Utilities.ImageHelper.GetValidImage(prod.ImageFileSmall, True))
            productLabel.Text = prod.ProductName
            productSkuLabel.Text = prod.Sku
        Else
            ProductDisplayPanel.Visible = False
        End If
    End Sub
End Class

