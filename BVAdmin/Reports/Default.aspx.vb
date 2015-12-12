Imports BVSoftware.Bvc5.core

Partial Class BVAdmin_Reports_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Response.Redirect("~/BVModules/Reports/" & WebAppSettings.ReportsDefaultPage.ToString & "/View.aspx")
    End Sub
End Class
