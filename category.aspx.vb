Imports BVSoftware.Bvc5.Core

Partial Class category
    Inherits System.Web.UI.Page

    Private Use301 As Boolean = True

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id As String = Page.Request.QueryString("categoryid")

        Dim destination As String = WebAppSettings.SiteStandardRoot

        If Not String.IsNullOrEmpty(id) Then
            Dim c As Catalog.Category = Catalog.Category.FindByBvin(id)
            If c IsNot Nothing AndAlso Not String.IsNullOrEmpty(c.Bvin) Then
                destination = Utilities.UrlRewriter.BuildUrlForCategory(c, Me.Page, Catalog.Category.FindAllLight())
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