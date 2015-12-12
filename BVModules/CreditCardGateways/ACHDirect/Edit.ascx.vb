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
        Me.chkDebugMode.Checked = SettingsManager.GetBooleanSetting("DebugMode")
        If Me.LiveUrlField.Text.Trim = String.Empty Then
            Me.LiveUrlField.Text = "https://www.paymentsgateway.net/cgi-bin/postauth.pl"
        End If
        If Me.TestUrlField.Text.Trim = String.Empty Then
            Me.TestUrlField.Text = "https://www.paymentsgateway.net/cgi-bin/posttest.pl"
        End If
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Username", Me.UsernameField.Text.Trim, "bvsoftware", "Credit Card Gateway", "ACHDirect")
        If Me.PasswordField.Text <> "**********" Then
            SettingsManager.SaveSetting("Password", Me.PasswordField.Text.Trim, "bvsoftware", "Credit Card Gateway", "ACHDirect")
        End If
        SettingsManager.SaveSetting("LiveUrl", Me.LiveUrlField.Text.Trim, "bvsoftware", "Credit Card Gateway", "ACHDirect")
        SettingsManager.SaveSetting("TestUrl", Me.TestUrlField.Text.Trim, "bvsoftware", "Credit Card Gateway", "ACHDirect")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTestMode.Checked, "bvsoftware", "Credit Card Gateway", "ACHDirect")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebugMode.Checked, "bvsoftware", "Credit Card Gateway", "ACHDirect")
    End Sub

End Class
