Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_Email
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Email Addresses"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.ContactEmailField.Text = WebAppSettings.ContactEmail
            Me.EmailReportToTextBox.Text = WebAppSettings.InventoryLowEmail
            Me.txtContactUsEmailRecipient.Text = WebAppSettings.ContactUsEmailRecipient
            Me.OrderNotificationEmailField.Text = WebAppSettings.OrderNotificationEmail
            Me.ProductReviewEmailField.Text = WebAppSettings.ProductReviewEmail
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.ContactEmail = Me.ContactEmailField.Text.Trim()
        WebAppSettings.InventoryLowEmail = Me.EmailReportToTextBox.Text.Trim()
        WebAppSettings.ContactUsEmailRecipient = Me.txtContactUsEmailRecipient.Text.Trim()
        WebAppSettings.OrderNotificationEmail = Me.OrderNotificationEmailField.Text.Trim()
        WebAppSettings.ProductReviewEmail = Me.ProductReviewEmailField.Text.Trim()
        result = True
        Return result
    End Function
End Class
