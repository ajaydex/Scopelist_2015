Imports BVSoftware.Bvc5.Core
Imports bvsoftware.Bvc5.Core.PersonalizationServices

Partial Class MyAccount_Dropshipping
    Inherits BaseStorePage

    Public Overrides ReadOnly Property RequiresSSL() As Boolean
        Get
            Return True
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_ChangePassword.aspx"))
        End If

    End Sub

End Class
