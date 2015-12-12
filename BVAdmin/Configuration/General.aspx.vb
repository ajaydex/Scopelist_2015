Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_General
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "General Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.chkStoreClosed.Checked = WebAppSettings.StoreClosed
            Me.SiteNameField.Text = WebAppSettings.SiteName
            Me.ContactEmailField.Text = WebAppSettings.ContactEmail
            'Me.GiftWrapCharge.Text = WebAppSettings.GiftWrapCharge
            Me.chkAllowPersonalizedThemes.Checked = WebAppSettings.AllowPersonalizedThemes
            Me.SiteHomePageFileNameField.Text = WebAppSettings.DefaultHomePage            
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.SiteName = Me.SiteNameField.Text.Trim
        WebAppSettings.ContactEmail = Me.ContactEmailField.Text.Trim
        WebAppSettings.StoreClosed = Me.chkStoreClosed.Checked
        WebAppSettings.AllowPersonalizedThemes = Me.chkAllowPersonalizedThemes.Checked
        WebAppSettings.DefaultHomePage = Me.SiteHomePageFileNameField.Text.Trim
        result = True

        Return result
    End Function
End Class
