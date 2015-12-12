Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_GiftWrap
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Gift Wrap Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            Me.chkGiftWrapAll.Checked = WebAppSettings.GiftWrapAll
            Me.txtGiftWrapCharge.Text = WebAppSettings.GiftWrapCharge
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.GiftWrapAll = Me.chkGiftWrapAll.Checked
        WebAppSettings.GiftWrapCharge = Me.txtGiftWrapCharge.Text
        result = True

        Return result
    End Function
End Class
