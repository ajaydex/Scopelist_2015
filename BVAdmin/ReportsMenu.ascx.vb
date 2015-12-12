Imports BVSoftware.Bvc5.Core
Imports System.IO

Partial Class BVAdmin_ReportsMenu
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadBlockList()
        End If
    End Sub

    Private Sub LoadBlockList()

        Dim sc As StringCollection = Content.ModuleController.FindReports

        Dim sb As New StringBuilder
        sb.Append("<ul class=""side-nav"">")
        For i As Integer = 0 To sc.Count - 1
            sb.Append("<li>")
            sb.Append("<a href=""../../Reports/" & sc(i) & "/view.aspx"">")
            sb.Append(sc(i))
            sb.Append("</a>")
            sb.Append("</li>")
        Next
        sb.Append("</ul>")
        l.Text = sb.ToString

    End Sub


End Class
