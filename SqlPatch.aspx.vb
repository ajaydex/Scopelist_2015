Imports BVSoftware.Bvc5.Core
Imports System.Threading

Partial Class SqlPatch
    Inherits System.Web.UI.Page

    Sub Page_Load(ByVal Sender As Object, ByVal E As EventArgs) Handles MyBase.Load
        If Not Utilities.VersionHelper.SqlPatchNeeded() Then
            Response.Redirect("~/Default.aspx")
        End If
    End Sub

    Protected Sub StartButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles StartButton.Click
        If Utilities.VersionHelper.SqlPatchNeeded() Then
            Utilities.VersionHelper.RunSqlPatch()

            ' restart application
            Dim globalAsax As New ASP.global_asax()
            globalAsax.RestartApplication()
        End If

        Response.Redirect("~/Default.aspx")
    End Sub

End Class