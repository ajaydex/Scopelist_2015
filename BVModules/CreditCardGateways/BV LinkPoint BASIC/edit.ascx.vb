Imports BVSoftware.Bvc5.Core

Partial Class BVModules_CreditCardGateways_BV_LinkPoint_BASIC_edit
    Inherits Content.BVModule

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        SaveData()
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Me.NotifyFinishedEditing()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LoadData()
        End If
    End Sub

    Private Sub LoadData()
        Me.TestUrlField.Text = ""
        Me.LiveUrlField.Text = ""

        'Fetch Values
        Me.UsernameField.Text = SettingsManager.GetSetting("Username")
        Me.PasswordField.Text = SettingsManager.GetSetting("Password")
        Me.LiveUrlField.Text = SettingsManager.GetSetting("LiveUrl")
        Me.TestUrlField.Text = SettingsManager.GetSetting("TestUrl")
        Me.chkTest.Checked = SettingsManager.GetBooleanSetting("TestMode")
        Me.chkDebug.Checked = SettingsManager.GetBooleanSetting("DebugMode")
    End Sub

    Private Sub SaveData()
        SettingsManager.SaveSetting("Username", Me.UsernameField.Text.Trim, "bvsoftware", "Credit Card Gateway", "LinkPointBasic")
        SettingsManager.SaveSetting("Password", Me.PasswordField.Text.Trim, "bvsoftware", "Credit Card Gateway", "LinkPointBasic")
        SettingsManager.SaveSetting("LiveURL", Me.LiveUrlField.Text.Trim, "bvsoftware", "Credit Card Gateway", "LinkPointBasic")
        SettingsManager.SaveSetting("TestURL", Me.TestUrlField.Text.Trim, "bvsoftware", "Credit Card Gateway", "LinkPointBasic")
        SettingsManager.SaveBooleanSetting("TestMode", Me.chkTest.Checked, "bvsoftware", "Credit Card Gateway", "LinkPointBasic")
        SettingsManager.SaveBooleanSetting("DebugMode", Me.chkDebug.Checked, "bvsoftware", "Credit Card Gateway", "LinkPointBasic")
    End Sub

End Class
