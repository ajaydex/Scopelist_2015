Imports BVSoftware.Bvc5.Core
Imports bvsoftware.Bvc5.Core.PersonalizationServices

Partial Class BVModules_Themes_Foundation4_Responsive_LoginControl
    Inherits System.Web.UI.UserControl

    Public Property HideIfLoggedIn() As Boolean
        Get
            Dim obj As Object = ViewState("HideIfLoggedIn")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("HideIfLoggedIn") = value
        End Set
    End Property

    Public Property HeaderText() As String
        Get
            Dim obj As Object = ViewState("HeaderText")
            If obj IsNot Nothing Then
                Return CStr(obj)
            Else
                Return ""
            End If
        End Get
        Set(ByVal value As String)
            ViewState("HeaderText") = value
        End Set
    End Property

    Public Event LoginCompleted(ByVal sender As Object, ByVal args As Controls.LoginCompleteEventArgs)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UsernameLabel.Text = Content.SiteTerms.GetTerm("Username") & ""
        If HideIfLoggedIn Then
            If SessionManager.IsUserAuthenticated Then
                Me.Visible = False
            Else
                Me.Visible = True
            End If
        End If

        If WebAppSettings.RememberUsers Then
            trRememberMe.Visible = True
            RememberMeCheckBox.Text = Content.SiteTerms.GetTerm("RememberUser")
        Else
            trRememberMe.Visible = False
        End If


        If Me.HeaderText.Trim = String.Empty Then
            Me.HeaderTextH2.Visible = False
        Else
            Me.HeaderTextH2.Visible = True
            HeaderTextH2.InnerText = Me.HeaderText
        End If

        If Not Page.IsPostBack Then
            Me.btnLogin.ImageUrl = PersonalizationServices.GetThemedButton("Login")

            If Request.QueryString("ReturnURL") <> Nothing Then
                Me.RedirectToField.Value = Request.QueryString("ReturnURL")
            End If

            If Not Request.QueryString("username") Is Nothing Then
                UsernameField.Text = Request.QueryString("username")
            End If

            Me.UsernameField.Focus()

            If WebAppSettings.RememberUsers = True Then
                Dim uid As String = SessionManager.GetCookieString(WebAppSettings.UserIdCookieName)
                If uid <> String.Empty Then
                    Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(uid)
                    If u IsNot Nothing Then
                        Me.UsernameField.Text = u.UserName
                        Me.PasswordField.Focus()
                    End If
                End If
            End If

        End If
    End Sub

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnLogin.Click
        If Page.IsValid Then
            Dim validateResult As BVOperationResult = Membership.UserAccount.ValidateUser(Me.UsernameField.Text.Trim, Me.PasswordField.Text.Trim)
            If validateResult.Success = True Then
                Dim u As Membership.UserAccount = Membership.UserAccount.FindByUserName(Me.UsernameField.Text.Trim)
                If u IsNot Nothing Then
                    SessionManager.SetCurrentUserId(u.Bvin, RememberMeCheckBox.Checked)
                    Dim args As New Controls.LoginCompleteEventArgs()
                    args.UserId = u.Bvin
                    RaiseEvent LoginCompleted(Me, args)
                End If
            Else
                Me.MessageBox1.ShowError("<i class='fa fa-exclamation-triangle'></i> " & validateResult.Message)
                Me.PasswordField.Focus()
            End If
        End If
    End Sub

End Class
