Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Users
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.chkPrivateStore.Checked = WebAppSettings.IsPrivateStore
            Me.UserIDCookieNameField.Text = WebAppSettings.UserIDCookieName
            Me.PasswordMinimumField.Text = WebAppSettings.PasswordMinimumLength.ToString
            Me.CartIdCookieNameField.Text = WebAppSettings.CartIdCookieName
            Me.UserLockoutAttemptsField.Text = WebAppSettings.UserLockoutAttempts
            Me.UserLockoutMinutesField.Text = WebAppSettings.UserLockoutMinutes
            Me.LastProductsViewedCookieName.Text = WebAppSettings.LastProductsViewed.ToString

            Select Case WebAppSettings.PasswordDefaultEncryption
                Case Membership.UserPasswordFormat.ClearText
                    Me.DefaultPasswordEncryptionField.Items.FindByValue("0").Selected = True
                Case Membership.UserPasswordFormat.Encrypted
                    Me.DefaultPasswordEncryptionField.Items.FindByValue("2").Selected = True
                Case Membership.UserPasswordFormat.Hashed
                    Me.DefaultPasswordEncryptionField.Items.FindByValue("1").Selected = True
            End Select

            Me.chkRememberUsers.Checked = WebAppSettings.RememberUsers
            Me.chkRememberUserPasswords.Checked = WebAppSettings.RememberUserPasswords
            Me.chkRedirectToHomePageOnLogin.Checked = WebAppSettings.RedirectToHomePageOnLogin
            Me.PasswordExpirationDaysField.Text = WebAppSettings.PasswordExpirationDays.ToString()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "User Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.UserIDCookieName = Me.UserIDCookieNameField.Text.Trim
        WebAppSettings.IsPrivateStore = Me.chkPrivateStore.Checked
        WebAppSettings.PasswordMinimumLength = Integer.Parse(Me.PasswordMinimumField.Text.Trim)
        WebAppSettings.CartIdCookieName = Me.CartIdCookieNameField.Text.Trim
        WebAppSettings.UserLockoutAttempts = Me.UserLockoutAttemptsField.Text.Trim
        WebAppSettings.UserLockoutMinutes = Me.UserLockoutMinutesField.Text.Trim
        Dim e As Integer = CType(Me.DefaultPasswordEncryptionField.SelectedValue, Integer)
        Dim selectedEncryption As Membership.UserPasswordFormat = CType(e, Membership.UserPasswordFormat)
        WebAppSettings.PasswordDefaultEncryption = selectedEncryption
        WebAppSettings.RememberUsers = Me.chkRememberUsers.Checked
        WebAppSettings.RememberUserPasswords = Me.chkRememberUserPasswords.Checked
        WebAppSettings.LastProductsViewed = Me.LastProductsViewedCookieName.Text.Trim
        WebAppSettings.RedirectToHomePageOnLogin = Me.chkRedirectToHomePageOnLogin.Checked
        WebAppSettings.PasswordExpirationDays = Integer.Parse(Me.PasswordExpirationDaysField.Text)
        result = True

        Return result
    End Function
End Class
