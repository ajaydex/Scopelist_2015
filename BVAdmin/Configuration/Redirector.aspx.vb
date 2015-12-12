Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Redirector
    Inherits BaseAdminPage

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Redirector Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If

            Me.chkEnableRedirector.Checked = WebAppSettings.RedirectorEnabled
            Me.chkRedirectToPrimaryDomain.Checked = WebAppSettings.RedirectToPrimaryDomain
            Me.chkAutoPopulateProductRedirect.Checked = WebAppSettings.AutoPopulateRedirectOnProductDelete
            Me.chkAutoPopulateCategoryRedirect.Checked = WebAppSettings.AutoPopulateRedirectOnCategoryDelete
            Me.chkAutoPopulateCustomPageRedirect.Checked = WebAppSettings.AutoPopulateRedirectOnCustomPageDelete
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        msg.ClearMessage()

        Try
            WebAppSettings.RedirectorEnabled = Me.chkEnableRedirector.Checked
            WebAppSettings.RedirectToPrimaryDomain = Me.chkRedirectToPrimaryDomain.Checked
            WebAppSettings.AutoPopulateRedirectOnProductDelete = Me.chkAutoPopulateProductRedirect.Checked
            WebAppSettings.AutoPopulateRedirectOnCategoryDelete = Me.chkAutoPopulateCategoryRedirect.Checked
            WebAppSettings.AutoPopulateRedirectOnCustomPageDelete = Me.chkAutoPopulateCustomPageRedirect.Checked

            msg.ShowOk("Changes Saved")
        Catch ex As Exception
            msg.ShowException(ex)
            EventLog.LogEvent(ex)
        End Try
    End Sub

End Class