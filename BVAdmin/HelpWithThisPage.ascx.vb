
Partial Class BVAdmin_HelpWithThisPage
    Inherits System.Web.UI.UserControl


    Private Sub RegisterWindowScripts()

        Dim nameOfPage As String = Request.AppRelativeCurrentExecutionFilePath

        Dim sb As New StringBuilder

        sb.Append("var w;")
        sb.Append("function OpenHelpWindow() {")
        sb.Append("w = window.open('http://www.bvsoftware.com/OnlineHelp/Bvc5/default.aspx?page=")
        sb.Append(Server.UrlEncode(nameOfPage))
        sb.Append("', 'onlineHelp', 'height=700, width=200');")
        sb.Append("}")

        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "OnlineHelpScripts", sb.ToString, True)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.RegisterWindowScripts()
    End Sub

End Class
