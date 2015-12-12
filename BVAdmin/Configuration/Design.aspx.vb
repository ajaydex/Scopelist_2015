Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Design
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Design/Debug Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.MessageBoxErrorTestModeCheckBox.Checked = WebAppSettings.MessageBoxErrorTestMode            
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Page.IsValid Then
            If Me.Save() = True Then
                Me.MessageBox1.ShowOk("Settings saved successfully.")
            End If
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.MessageBoxErrorTestMode = Me.MessageBoxErrorTestModeCheckBox.Checked        
        result = True

        Return result
    End Function

End Class
