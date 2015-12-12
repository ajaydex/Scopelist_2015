Imports BVSoftware.Bvc5.Core

Partial Class ProductInfo
    Inherits System.Web.UI.Page

    Private Use301 As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id As String = String.Empty
        id = Page.Request.QueryString("productid")

        Dim destination As String = "~/"

        If id <> String.Empty Then
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(id)
            If p IsNot Nothing Then
                destination = Utilities.UrlRewriter.BuildUrlForProduct(p, Me.Page.Request)
            End If
        End If

        If Use301 Then
            Response.Status = "301 Moved Permanently"
            Response.AddHeader("Location", destination)
        Else
            Response.Redirect(destination)
        End If
    End Sub

End Class
