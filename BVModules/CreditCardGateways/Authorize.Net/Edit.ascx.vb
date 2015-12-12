Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_Authorize_Net_Edit
    Inherits Content.BVModule

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.UsernameField.Text = SettingsManager.GetSetting("Username")
        Me.PasswordField.Text = "**********"
        'Me.PasswordField.Text = SettingsManager.GetSetting("Password")
        Me.LiveUrlField.Text = SettingsManager.GetSetting("LiveUrl")
        Me.TestUrlField.Text = SettingsManager.GetSetting("TestUrl")
        Me.chkTestMode.Checked = SettingsManager.GetBooleanSetting("TestMode")
        If Me.LiveUrlField.Text.Trim = String.Empty Then
            Me.LiveUrlField.Text = "https://secure.authorize.net/gateway/transact.dll"
        End If
        If Me.TestUrlField.Text.Trim = String.Empty Then
            Me.TestUrlField.Text = "https://secure.authorize.net/gateway/transact.dll"
        End If
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
        Me.EmailCustomerCheckBox.Checked = SettingsManager.GetBooleanSetting("EmailCustomer")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Username", Me.UsernameField.Text.Trim, "bvsoftware", "Credit Card Gateway", "Authorize.Net")
        If Me.PasswordField.Text <> "**********" Then
            SettingsManager.SaveSetting("Password", Me.PasswordField.Text.Trim, "bvsoftware", "Credit Card Gateway", "Authorize.Net")
        End If
        SettingsManager.SaveSetting("LiveUrl", Me.LiveUrlField.Text.Trim, "bvsoftware", "Credit Card Gateway", "Authorize.Net")
        SettingsManager.SaveSetting("TestUrl", Me.TestUrlField.Text.Trim, "bvsoftware", "Credit Card Gateway", "Authorize.Net")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTestMode.Checked, "bvsoftware", "Credit Card Gateway", "Authorize.Net")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvsoftware", "Credit Card Gateway", "Authorize.Net")
        SettingsManager.SaveBooleanSetting("EmailCustomer", Me.EmailCustomerCheckBox.Checked, "bvsoftware", "Credit Card Gateway", "Authorize.Net")
    End Sub

End Class
