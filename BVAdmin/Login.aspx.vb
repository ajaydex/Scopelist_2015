Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Login
    Inherits System.Web.UI.Page

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnLogin.Click
        Me.MessageBox1.ClearMessage()
        Dim result As BVOperationResult = Membership.UserAccount.ValidateUser(Me.UsernameField.Text.Trim, Me.PasswordField.Text.Trim)
        If result.Success = True Then
            Dim u As Membership.UserAccount = Membership.UserAccount.FindByUserName(Me.UsernameField.Text.Trim)
            If u IsNot Nothing Then
                SessionManager.SetCurrentUserId(u.Bvin, True)
                RedirectOnComplete()
            End If
        Else
            Me.MessageBox1.ShowError(result.Message)
            Me.PasswordField.Focus()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        UserNameLabel.Text = Content.SiteTerms.GetTerm("Username") & ":"
        If Not Page.IsPostBack Then

            CheckSSL()

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
                    If Not String.IsNullOrEmpty(u.Bvin) Then
                        Me.UsernameField.Text = u.UserName
                        Me.PasswordField.Focus()
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub CheckSSL()
        If WebAppSettings.UseSsl Then
            ' Assure that both URL's are not the same so the system doesn't try to redirect to the same URL and loop.
            If WebAppSettings.SiteSecureRoot.ToLower <> WebAppSettings.SiteStandardRoot.ToLower Then
                If Not Request.IsSecureConnection Then
                    ' Redirect to HTTPS
                    Utilities.SSL.SSLRedirect(Me, Utilities.SSL.SSLRedirectTo.SSL)
                End If
            End If
        End If
    End Sub

    Private Sub RedirectOnComplete()
        Dim url As String = "~/BVAdmin/Default.aspx"
        If Me.RedirectToField.Value IsNot Nothing Then
            If Me.RedirectToField.Value <> String.Empty Then
                url = Me.RedirectToField.Value
            End If
        End If
        Response.Redirect(url)
    End Sub

End Class
