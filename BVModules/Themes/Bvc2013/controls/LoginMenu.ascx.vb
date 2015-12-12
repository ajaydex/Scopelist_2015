Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Bvc2013_LoginMenu
    Inherits System.Web.UI.UserControl

    Dim _ShowUserName As Boolean = False

    Public Property ShowUserName() As Boolean
        Get
            Return _ShowUserName
        End Get
        Set(ByVal value As Boolean)
            _ShowUserName = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim s As New StringBuilder
        If SessionManager.IsUserAuthenticated = True Then
            s.Append("<a href=""" & Page.ResolveUrl("~/logout.aspx") & """ class=""lnkSignOut"">")
            If _ShowUserName = True Then
                Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
                s.Append("Sign Out (" & u.FirstName & " " & u.LastName & ")")
            Else
                s.Append("Sign Out")
            End If
            s.Append("</a>")
            Me.litLogin.Text = s.ToString
        Else
            Dim destination As String = Page.ResolveUrl("~/Login.aspx")
            s.Append("<a href=""" & destination & """ class=""lnkSignIn"">")
            s.Append("Sign In")
            s.Append("</a>")
            Me.litLogin.Text = s.ToString
        End If
    End Sub

End Class