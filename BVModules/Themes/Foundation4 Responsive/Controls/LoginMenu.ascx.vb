Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_LoginMenu
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

    Private _tabIndex As Integer = -1
    Public Property TabIndex() As Integer
        Get
            Return _tabIndex
        End Get
        Set(ByVal value As Integer)
            _tabIndex = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim s As New StringBuilder
        If SessionManager.IsUserAuthenticated = True Then

            If _ShowUserName = True Then
                Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
                s.Append("Welcome back <strong>" & u.FirstName & " " &  u.LastName & " ")
                s.Append("<a href=""" & Page.ResolveUrl("~/logout.aspx") & """ class=""lnkSignOut button secondary tiny"">")
                s.Append(" <i class=""fa fa-unlock""></i> <span>Logout</span>")
                s.Append("</a>")
            Else
                s.Append("<a href=""" & Page.ResolveUrl("~/logout.aspx") & """ class=""lnkSignOut"">")
                s.Append("<i class=""fa fa-unlock""></i> <span>Logout</span>")
                s.Append("</a>")
            End If

            Me.litLogin.Text = s.ToString
        Else
            Dim destination As String = Page.ResolveUrl("~/Login.aspx")
            s.Append("<a href=""" & destination & """ class=""lnkSignIn"">")
            s.Append("<i class=""fa fa-lock""></i> <span>Login</span>")
            s.Append("</a>")
            Me.litLogin.Text = s.ToString
        End If
    End Sub

End Class