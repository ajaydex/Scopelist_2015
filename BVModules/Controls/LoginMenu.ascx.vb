Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_LoginMenu
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
            If Me.TabIndex <> -1 Then
                s.Append("<a  target=""_parent""  href=""" & Page.ResolveUrl("~/logout.aspx") & """ TabIndex=""" & Me.TabIndex.ToString() & """>")
            Else
                s.Append("<a  target=""_parent""  href=""" & Page.ResolveUrl("~/logout.aspx") & """>")
            End If

            If _ShowUserName = True Then
                Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)

                Dim str As String = ""
                str = u.FirstName & " " & u.LastName

                If str.Length > 5 Then
                    str = str.Substring(0, 5) & ".."
                End If
                s.Append("Sign Out (" & str & ")")
            Else
                s.Append("Sign Out")
            End If
            s.Append("</a>")
            Me.litLogin.Text = s.ToString
        Else
            Dim destination As String = Page.ResolveUrl("~/Login.aspx")
            If Me.TabIndex <> -1 Then
                s.Append("<a target=""_parent"" href=""" & destination & """ TabIndex=""" & Me.TabIndex.ToString() & """>")
            Else
                s.Append("<a  target=""_parent"" href=""" & destination & """>")
            End If
            s.Append("Sign In/ Sign up")
            s.Append("</a>")
            Me.litLogin.Text = s.ToString
        End If
    End Sub
End Class
