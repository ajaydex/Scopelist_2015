Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_WaitingMessage
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        WaitingTextLiteral.Text = WebAppSettings.CallbackWaitingMessage
    End Sub
End Class
