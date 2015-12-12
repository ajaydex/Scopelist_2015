Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Avalara
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Avalara Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            Me.EnableCheckBox.Checked = WebAppSettings.AvalaraEnabled
            Me.AccountTextBox.Text = WebAppSettings.AvalaraAccount
            Me.LicenseKeyTextBox.Text = WebAppSettings.AvalaraLicenseKey
            Me.CompanyCodeTextBox.Text = WebAppSettings.AvalaraCompanyCode
            Me.UrlTextBox.Text = WebAppSettings.AvalaraUrl
            Me.DebugCheckBox.Checked = WebAppSettings.AvalaraDebug
            Me.LogMessagesOnOrderCheckBox.Checked = WebAppSettings.AvalaraLogTransactionsInOrderNotes
            Me.UserNameField.Text = WebAppSettings.AvalaraUserName
            Me.PasswordField.Text = "**********"

        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False

        WebAppSettings.AvalaraEnabled = Me.EnableCheckBox.Checked
        WebAppSettings.AvalaraAccount = Me.AccountTextBox.Text
        WebAppSettings.AvalaraLicenseKey = Me.LicenseKeyTextBox.Text
        WebAppSettings.AvalaraCompanyCode = Me.CompanyCodeTextBox.Text
        WebAppSettings.AvalaraUrl = Me.UrlTextBox.Text
        WebAppSettings.AvalaraDebug = Me.DebugCheckBox.Checked
        WebAppSettings.AvalaraLogTransactionsInOrderNotes = Me.LogMessagesOnOrderCheckBox.Checked
        WebAppSettings.AvalaraUserName = Me.UserNameField.Text.Trim()

        If Me.PasswordField.Text <> "**********" Then
            WebAppSettings.AvalaraPassword = Me.PasswordField.Text.Trim()
        End If

        result = True

        Return result
    End Function

End Class
