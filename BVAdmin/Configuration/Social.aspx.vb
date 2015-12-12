Imports BVSoftware.BVC5.Core

Partial Class BVAdmin_Configuration_Social
    Inherits BaseAdminPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Social Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            Me.chkFacebookOpenGraph.Checked = WebAppSettings.FacebookOpenGraphEnabled
            Me.txtAddThisCode.Text = WebAppSettings.AddThisCode
            Me.txtAddThisProfileID.Text = WebAppSettings.AddThisProfileID
            Me.chkAddThisTrackkUrls.Checked = WebAppSettings.AddThisTrackUrls
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.ucMessageBox.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = True

        Try
            WebAppSettings.FacebookOpenGraphEnabled = Me.chkFacebookOpenGraph.Checked
            WebAppSettings.AddThisCode = Regex.Replace(Me.txtAddThisCode.Text.Trim(), "<script.*?</script>", String.Empty, RegexOptions.IgnoreCase Or RegexOptions.Compiled)
            WebAppSettings.AddThisProfileID = Me.txtAddThisProfileID.Text.Trim()
            WebAppSettings.AddThisTrackUrls = Me.chkAddThisTrackkUrls.Checked
        Catch ex As Exception
            result = False
        End Try

        Return result
    End Function

End Class