Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Configuration_InventoryNotices
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.SettingsEdit) = False Then
                Me.btnSave.Enabled = False
            End If
            Me.EmailReportToTextBox.Text = WebAppSettings.InventoryLowEmail
            Me.LowStockHoursTextBox.Text = WebAppSettings.InventoryLowHours.ToString()
            Me.LinePrefixTextBox.Text = WebAppSettings.InventoryLowReportLinePrefix

            Me.chkDisableInventory.Checked = WebAppSettings.DisableInventory
            If Me.lstInventoryMode.Items.FindByValue(WebAppSettings.InventoryMode) IsNot Nothing Then
                Me.lstInventoryMode.ClearSelection()
                Me.lstInventoryMode.Items.FindByValue(WebAppSettings.InventoryMode).Selected = True
            End If

            Me.TrackInventoryNewProductsCheckBox.Checked = WebAppSettings.InventoryEnabledNewProductDefault
            Me.DefaultInventoryModeDropDownList.SelectedValue = WebAppSettings.InventoryNewProductDefaultMode

        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Inventory Settings"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Me.Save() = True Then
            Me.MessageBox1.ShowOk("Settings saved successfully.")
        End If
    End Sub

    Private Function Save() As Boolean
        Dim result As Boolean = False
        WebAppSettings.InventoryLowEmail = Me.EmailReportToTextBox.Text
        WebAppSettings.InventoryLowHours = Integer.Parse(Me.LowStockHoursTextBox.Text)
        WebAppSettings.InventoryLowReportLinePrefix = Me.LinePrefixTextBox.Text
        WebAppSettings.DisableInventory = Me.chkDisableInventory.Checked
        WebAppSettings.InventoryMode = Me.lstInventoryMode.SelectedValue

        WebAppSettings.InventoryEnabledNewProductDefault = Me.TrackInventoryNewProductsCheckBox.Checked
        WebAppSettings.InventoryNewProductDefaultMode = Me.DefaultInventoryModeDropDownList.SelectedValue
        result = True

        Return result
    End Function

    Protected Sub SendLowStockReportImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles SendLowStockReportImageButton.Click
        MessageBox1.ClearMessage()
        If Me.EmailReportToTextBox.Text.Length > 0 Then

            If Catalog.ProductInventory.EmailLowStockReport(Me.EmailReportToTextBox.Text) Then
                MessageBox1.ShowOk("Report sent!")
            Else
                MessageBox1.ShowWarning("Report failed to send.")
            End If
        Else
            MessageBox1.ShowWarning("You must enter an email address to send the report!")
        End If
    End Sub
End Class
